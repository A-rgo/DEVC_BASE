class ZCL_MDC_MODEL_MAT definition
  public
  inheriting from CL_MDC_MODEL_MAT
  create public

  global friends IF_MDC_MODEL .

public section.

  types:
    BEGIN OF gty_source_entity_map_data,
        matnr          TYPE matnr,
        data           TYPE mdg_s_material_data,
        iT_MAT_STAGING TYPE  usmd_gov_api_t_ent_tabl,
      END OF gty_source_entity_map_data .
  types:
    BEGIN OF gty_log_message,
        source_system TYPE mdc_business_system,
        source_id     TYPE mdc_source_id,
        log_message   TYPE bal_t_msg,
      END OF gty_log_message .
  types:
    gtt_source_entity_map_data TYPE SORTED TABLE OF gty_source_entity_map_data WITH UNIQUE KEY matnr .
  types:
    gtt_log_message            TYPE STANDARD TABLE OF gty_log_message .

  class-data GT_MDC_MAT_S_MAT_DATA type MDC_TT_MAT_S_MAT_DATA .
  class-data GT_SOURCE_ENTITY_MAP_DATA type GTT_SOURCE_ENTITY_MAP_DATA .
  class-data GT_LOG_MESSAGE type GTT_LOG_MESSAGE .

  methods IF_MDC_MAT_2_SOURCE~MAP_MATERIAL2SOURCE
    redefinition .
  methods IF_MDC_MODEL~READ
    redefinition .
  PROTECTED SECTION.


    METHODS map_mdc_tab_2_entity
      IMPORTING
        !is_mat_api         TYPE mdg_s_material_data
      EXPORTING
        !et_mat_staging     TYPE usmd_gov_api_t_ent_tabl
        !et_return_messages TYPE bapirettab .

    METHODS call_api_extension_prepare
        REDEFINITION .
    METHODS check_data_quality_rules
        REDEFINITION .
    METHODS map_extensions_2api
        REDEFINITION .
    METHODS map_material_2api
        REDEFINITION .
    METHODS read_all_data
        REDEFINITION .
    METHODS save_material_active
        REDEFINITION .
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_MDC_MODEL_MAT IMPLEMENTATION.


  METHOD call_api_extension_prepare.
    TRY.
        CALL METHOD super->call_api_extension_prepare
          EXPORTING
            is_mat_data         = is_mat_data
            iv_matnr            = iv_matnr
          IMPORTING
            et_mat_segments_ext = et_mat_segments_ext
          CHANGING
            cs_mat_data         = cs_mat_data.
      CATCH cx_mdc_model ##NO_HANDLER.
    ENDTRY.
  ENDMETHOD.


  METHOD check_data_quality_rules.

    map_material_2api( ).
    TRY.
        DATA: ls_mat_api TYPE mdg_s_material_data.
        DATA: ls_source_data_map TYPE gty_source_entity_map_data.
        IF mt_mdc_mat_s_mat_data IS NOT INITIAL.
          LOOP AT mt_mdc_mat_s_mat_data INTO DATA(ls_mdc_mat_data).
            ls_mat_api-material_data = ls_mdc_mat_data-data-material_data.
            ls_source_data_map-matnr = ls_mdc_mat_data-data-matnr.
            ls_source_data_map-data  = ls_mdc_mat_data-data.
            map_mdc_tab_2_entity(
              EXPORTING
                is_mat_api         = ls_mat_api                 " Material mapped to API MATNR
              IMPORTING
                et_mat_staging     = DATA(lt_mat_staging)                 " MDG: Table Type for Table of Entities Structure
*                et_return_messages = DATA(lt_return_messages)                  " Table of BAPI return information
            ).
            ls_source_data_map-it_mat_staging = lt_mat_staging.
            INSERT ls_source_data_map INTO TABLE gt_source_entity_map_data.

            CLEAR: lt_mat_staging, ls_source_data_map, ls_mdc_mat_data.
          ENDLOOP.
          CLEAR: mt_mdc_mat_s_mat_data.
        ENDIF.
      CATCH cx_bs_soa_exception INTO DATA(lo_cx_bs_soa_exception).    " Error message occurred
        DATA(lv_msg) = lo_cx_bs_soa_exception->get_text( ) ##NEEDED.
      CATCH cx_mdg_bs_mm_sta_error INTO DATA(lo_cx_mdg_bs_mm_sta_error). " Fatal error message in Staging occurred
        DATA(lv_msg1) = lo_cx_mdg_bs_mm_sta_error->get_text( ) ##NEEDED.
    ENDTRY.
    CLEAR: mt_mdc_mat_s_mat_data, mt_mat_keys.
    TRY.
        CALL METHOD super->check_data_quality_rules.
      CATCH cx_mdc_model INTO DATA(lo_cx_mdc_model).
        DATA(lv_msg2) = lo_cx_mdc_model->get_text( ) ##NEEDED.
    ENDTRY.

    FIELD-SYMBOLS <root_records> TYPE ANY TABLE.
    READ TABLE data_objects INTO DATA(ls_data_object) WITH TABLE KEY table_name = root_table.
    DATA(root_records_prc) = ls_data_object-access->read( ).
    ASSIGN root_records_prc->* TO <root_records>.

    SORT gt_log_message BY source_system source_id.
    LOOP AT <root_records> ASSIGNING FIELD-SYMBOL(<root_record>).
      ASSIGN COMPONENT 'SOURCE_SYSTEM' OF STRUCTURE <root_record> TO FIELD-SYMBOL(<source_system>).
      ASSIGN COMPONENT 'SOURCE_ID' OF STRUCTURE <root_record> TO FIELD-SYMBOL(<source_id>).
      ASSIGN COMPONENT 'VALIDATION_STATUS' OF STRUCTURE <root_record> TO FIELD-SYMBOL(<validation_status>).
      READ TABLE gt_log_message TRANSPORTING NO FIELDS WITH KEY source_system = <source_system> source_id = <source_id> BINARY SEARCH.
      IF sy-subrc = 0.
        LOOP AT gt_log_message INTO DATA(message) FROM sy-tabix.
          IF message-source_system <> <source_system> OR message-source_id <> <source_id>.
            EXIT.
          ENDIF.
          LOOP AT message-log_message INTO DATA(ls_log_message).
            <validation_status> = determine_validation_status(
                                            message_type = ls_log_message-msgty
                                            current_validation_status = <validation_status> ).
            me->log->subordinate_log( iv_source_system = <source_system>
                                      iv_source_id     = <source_id>     )->add_message( is_message = ls_log_message ).

          ENDLOOP.
        ENDLOOP.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD if_mdc_mat_2_source~map_material2source.

    CALL METHOD super->if_mdc_mat_2_source~map_material2source
      EXPORTING
        is_mat_api            = is_mat_api
        it_sender_material_id = it_sender_material_id
      RECEIVING
        rt_object_data        = rt_object_data.

  ENDMETHOD.


  METHOD if_mdc_model~read.
    TRY.
        CALL METHOD super->if_mdc_model~read
          EXPORTING
            iv_package_number    = iv_package_number
            it_source_keys       = it_source_keys
            iv_handover          = iv_handover
            iv_from_current_step = iv_from_current_step
            iv_for_changing      = iv_for_changing.
      CATCH cx_mdc_model INTO DATA(lo_cx_mdc_model).
        DATA(lv_msg) = lo_cx_mdc_model->get_text( ) ##NEEDED.
    ENDTRY.

    CHECK process_goal EQ if_mdc_process_object=>process_goal-rule_evaluation.
    DATA: ls_mat_api TYPE mdg_s_material_data.
    DATA: ls_source_data_map TYPE gty_source_entity_map_data.
    DATA: ltr_matnr TYPE RANGE OF matnr.
    TRY.
        read_all_data(
          it_source_keys    = it_source_keys                  " Master Data Consolidation: Keys of Source Data Table
          iv_package_number = iv_package_number
        ).
        TRY.
            map_material_2api( ).
            DATA(lr_source_key) = me->root_object->read_source_keys( ).
            LOOP AT lr_source_key->* ASSIGNING FIELD-SYMBOL(<ls_source_key>).
              CHECK sy-subrc IS INITIAL AND <ls_source_key> IS ASSIGNED.
              ltr_matnr = VALUE #( BASE ltr_matnr ( sign   = 'I'
                                                    option = 'EQ'
                                                    low    = CONV #( <ls_source_key>-source_id ) ) ).
            ENDLOOP.
            IF ltr_matnr IS NOT INITIAL.
              """ Write custom field logics to append into stating tables and then
              """ we can set data to gt tables
            ENDIF.

            IF mt_mdc_mat_s_mat_data IS NOT INITIAL.
              LOOP AT mt_mdc_mat_s_mat_data INTO DATA(ls_mdc_mat_data).
                ls_mat_api-material_data = ls_mdc_mat_data-data-material_data.
                ls_source_data_map-matnr = ls_mdc_mat_data-data-matnr.
                ls_source_data_map-data  = ls_mdc_mat_data-data.
                map_mdc_tab_2_entity(
                  EXPORTING
                    is_mat_api         = ls_mat_api                 " Material mapped to API MATNR
                  IMPORTING
                    et_mat_staging     = DATA(lt_mat_staging)                 " MDG: Table Type for Table of Entities Structure
*                    et_return_messages = DATA(lt_return_messages)                  " Table of BAPI return information
                ).

                ls_source_data_map-it_mat_staging = lt_mat_staging.
                INSERT ls_source_data_map INTO TABLE gt_source_entity_map_data.
                CLEAR: lt_mat_staging, ls_source_data_map, ls_mdc_mat_data.
              ENDLOOP.
              CLEAR: mt_mdc_mat_s_mat_data.
            ENDIF.
          CATCH cx_mdc_model.
            CLEAR: mt_mdc_mat_s_mat_data.
        ENDTRY.
      CATCH cx_mdc_model INTO lo_cx_mdc_model  . " Model Exception
        lv_msg = lo_cx_mdc_model->get_text( ) ##NEEDED.
    ENDTRY.
  ENDMETHOD.


  METHOD map_extensions_2api.
    CALL METHOD super->map_extensions_2api
      EXPORTING
        is_mat_prc  = is_mat_prc
        iv_matnr    = iv_matnr
      CHANGING
        cs_mat_data = cs_mat_data.
  ENDMETHOD.


  METHOD map_material_2api.
    TRY.
        CALL METHOD super->map_material_2api.
      CATCH cx_mdc_model INTO DATA(lo_cx_mdc_model).
        DATA(lv_msg) = lo_cx_mdc_model->get_text( ) ##NEEDED.
    ENDTRY.
  ENDMETHOD.


  METHOD map_mdc_tab_2_entity.
    TYPES:
      BEGIN OF  ty_s_attr_key,
        entity   TYPE usmd_entity,
        attr_key TYPE mdg_bs_mat_t_smt_field,
      END OF ty_s_attr_key .
    TYPES:
      ty_t_attr_key TYPE SORTED TABLE OF ty_s_attr_key WITH UNIQUE KEY entity .
    DATA mt_attr_key TYPE ty_t_attr_key .
    DATA mo_gov TYPE REF TO if_usmd_gov_api .
    DATA: lt_return_messages TYPE      bapirettab,
          lt_messages        TYPE usmd_t_message,
*          ls_mdg_entity      TYPE usmd_gov_api_s_ent_tabl,
          lt_entity_struc    TYPE mdg_bs_mat_t_enty_str,
          lrs_entity_save    TYPE REF TO data,
          lrs_entity_copy    TYPE REF TO data,
          lrt_entity         TYPE REF TO data,
          lrt_entity_lama    TYPE REF TO data,
          lrt_entity_save    TYPE REF TO data,
          ls_mat_staging     TYPE usmd_gov_api_s_ent_tabl,
          lo_drad_cntl       TYPE REF TO if_mdg_bs_drad_cntl,
*          lt_key_struc       TYPE mdg_bs_mat_t_smt_field,
          ls_attr_key        TYPE ty_s_attr_key,
          lt_usmd_message    TYPE usmd_t_message.
    CONSTANTS: lc_matnr_ext   TYPE string VALUE 'MATNR_EXT'.

    FIELD-SYMBOLS: <ls_entity_struc>    TYPE mdg_bs_mat_s_enty_str,
                   <lt_model_data>      TYPE SORTED TABLE,
                   <fs_model_data_lama> TYPE SORTED TABLE,
                   <lt_model_data_save> TYPE SORTED TABLE,
                   <ls_model_data>      TYPE any,
                   <fs_model_data_copy> TYPE any,
                   <ls_model_data_save> TYPE any,
                   <lv_key_name>        TYPE smt_field,
                   <lv_key_value>       TYPE any.
    CLEAR : et_return_messages, et_mat_staging.
    cl_mdg_bs_mat_smt=>get_enties_struc( IMPORTING et_entity_struc = lt_entity_struc ).

    IF mt_attr_key IS INITIAL.
      LOOP AT lt_entity_struc ASSIGNING <ls_entity_struc>.
        ls_attr_key-entity  = <ls_entity_struc>-entity.
        cl_mdg_bs_mat_smt=>find_prop_entity( EXPORTING iv_respect_switch = abap_true   iv_entity  = <ls_entity_struc>-entity
                                             IMPORTING et_attr_key       = ls_attr_key-attr_key ).
        INSERT ls_attr_key INTO TABLE mt_attr_key.
      ENDLOOP.
    ENDIF.

    IF mo_gov IS INITIAL.
      mo_gov = cl_usmd_gov_api=>get_instance( iv_model_name = 'MM' ).
    ENDIF.

    LOOP AT lt_entity_struc ASSIGNING <ls_entity_struc>.
      CHECK sy-subrc IS INITIAL.
      CLEAR: lt_return_messages, lt_messages, lt_usmd_message.
      TRY.
          IF <ls_entity_struc>-entity = 'MATERIAL' AND <ls_entity_struc>-is_txt = abap_true.

            CALL METHOD mo_gov->create_data_reference
              EXPORTING
                iv_entity_name = <ls_entity_struc>-entity
                iv_struct      = if_usmd_model=>gc_struct_key_txt_langu
              IMPORTING
                er_table       = lrt_entity.
            ASSIGN lrt_entity->* TO <lt_model_data>.

            CALL METHOD mo_gov->create_data_reference
              EXPORTING
                iv_entity_name = <ls_entity_struc>-entity
                iv_struct      = if_usmd_model=>gc_struct_key_txt_langu
              IMPORTING
                er_table       = lrt_entity_save.
            ASSIGN lrt_entity_save->* TO <lt_model_data_save>.
          ELSE.
            CALL METHOD mo_gov->create_data_reference
              EXPORTING
                iv_entity_name = <ls_entity_struc>-entity
                iv_struct      = if_usmd_model=>gc_struct_key_attr
              IMPORTING
                er_table       = lrt_entity.
            ASSIGN lrt_entity->* TO <lt_model_data>.

            CALL METHOD mo_gov->create_data_reference
              EXPORTING
                iv_entity_name = <ls_entity_struc>-entity
                iv_struct      = if_usmd_model=>gc_struct_key_attr
              IMPORTING
                er_table       = lrt_entity_save.
            ASSIGN lrt_entity_save->* TO <lt_model_data_save>.
          ENDIF.
        CATCH cx_usmd_gov_api.
          lt_usmd_message = mo_gov->get_messages( ).
          IF lt_usmd_message[] IS NOT INITIAL.
            CALL METHOD cl_mdg_mm_2_staging=>map_usmd_mess_to_bapiret
              EXPORTING
                it_usmd_message = lt_usmd_message
              IMPORTING
                et_bapirettab   = lt_return_messages.
            APPEND LINES OF lt_return_messages TO et_return_messages.
          ENDIF.
      ENDTRY.

      CASE  <ls_entity_struc>-entity.
        WHEN 'MATCHGMNG'.
*          me->map_matchgmng_2sta( exporting iv_cr_id = mv_cr_id is_matchgmng_api = is_mat_api-mara_aeoi_data importing et_matchgmng_data = <lt_model_data> ).
        WHEN 'CLASSASGN'.
*          me->map_class_2sta( exporting is_class_api = is_mat_api-clf_data-classasgn importing et_class_data = <lt_model_data> ).
        WHEN 'VALUATION'.
*          me->map_val_2sta( exporting is_val_api = is_mat_api-clf_data-valuation importing et_val_data = <lt_model_data> ).
        WHEN OTHERS.
          TRY.
              "           IntIncID: 1580069177
              DATA: ls_material_data TYPE mdg_bs_mat_s_mat_data,
                    lt_ckmlcr_tab    TYPE mdg_bs_mat_t_mla_ckmlcr.
              MOVE-CORRESPONDING is_mat_api-material_data TO ls_material_data EXPANDING NESTED TABLES.  "decided by CDA
              LOOP AT ls_material_data-ckmlcr_tab INTO DATA(ls_ckmlcr) GROUP BY ( matnr = ls_ckmlcr-matnr
                                                      bwkey = ls_ckmlcr-bwkey
                                                      bwtar = ls_ckmlcr-bwtar
                                                      curtp = ls_ckmlcr-curtp ) INTO DATA(lt_group).
                LOOP AT GROUP lt_group ASSIGNING FIELD-SYMBOL(<ls_ckmlcr>).
                  ls_ckmlcr = <ls_ckmlcr>.
                ENDLOOP.
                INSERT ls_ckmlcr INTO TABLE lt_ckmlcr_tab.
              ENDLOOP.
              ls_material_data-ckmlcr_tab = lt_ckmlcr_tab.
              cl_mdg_bs_mat_services=>map_model_2_sta( EXPORTING iv_entity = <ls_entity_struc>-entity iv_target_struc = <ls_entity_struc>-structure is_api_data = ls_material_data
                                                       IMPORTING et_message = lt_messages CHANGING ct_model_data = <lt_model_data> ).
              IF <ls_entity_struc>-entity = 'MATERIAL' AND <ls_entity_struc>-is_txt = abap_false AND cl_mdg_bs_mat_lama=>is_mgv_lama_switched_on( ) = abap_true.
                TRY.
                    CALL METHOD mo_gov->create_data_reference
                      EXPORTING
                        iv_entity_name = <ls_entity_struc>-entity
                        iv_struct      = if_usmd_model=>gc_struct_key_attr
                      IMPORTING
                        er_table       = lrt_entity_lama.
                    ASSIGN lrt_entity_lama->* TO <fs_model_data_lama>.
                    LOOP AT <lt_model_data> ASSIGNING FIELD-SYMBOL(<fs_model_data>).
                      CREATE DATA lrs_entity_copy TYPE (<ls_entity_struc>-structure).
                      ASSIGN lrs_entity_copy->* TO <fs_model_data_copy>.
                      <fs_model_data_copy> = <fs_model_data>.
                      ASSIGN COMPONENT lc_matnr_ext OF STRUCTURE <fs_model_data_copy> TO FIELD-SYMBOL(<fs_matnr_ext>).
                      IF sy-subrc IS INITIAL.
                        <fs_matnr_ext> = is_mat_api-matnr_ext.
                      ENDIF.
                      INSERT <fs_model_data_copy> INTO TABLE <fs_model_data_lama>.
                    ENDLOOP.
                    <lt_model_data> = <fs_model_data_lama>.
                  CATCH cx_usmd_gov_api.
                    lt_usmd_message = mo_gov->get_messages( ).
                    IF lt_usmd_message[] IS NOT INITIAL.
                      CALL METHOD cl_mdg_mm_2_staging=>map_usmd_mess_to_bapiret
                        EXPORTING
                          it_usmd_message = lt_usmd_message
                        IMPORTING
                          et_bapirettab   = lt_return_messages.
                      APPEND LINES OF lt_return_messages TO et_return_messages.
                    ENDIF.
                ENDTRY.
              ENDIF.
            CATCH cx_mdg_bs_mat_smt.
              CASE <ls_entity_struc>-entity.
                WHEN 'DRADBASIC' OR 'DRADTXT'.
                  CREATE OBJECT lo_drad_cntl TYPE cl_mdg_bs_mat_drad_access.
                  TRY.
                      lo_drad_cntl->map_2sta( EXPORTING iv_entity = <ls_entity_struc>-entity is_drad_data_db = is_mat_api-drad_data IMPORTING et_data = <lt_model_data> ) ##ENH_OK.
                    CATCH cx_mdg_bs_drad INTO DATA(lo_cx_mdg_bs_drad).
                      DATA(lv_msg) = lo_cx_mdg_bs_drad->get_text( ) ##NEEDED.
                  ENDTRY.
                WHEN 'MKALBASIC'.
                  cl_mdg_bs_mat_services=>map_mkal_data_2sta( EXPORTING it_mkal = is_mat_api-mkal_data-mkal_tab IMPORTING et_mkal_data = <lt_model_data> ) ##ENH_OK.
                WHEN OTHERS.
                  "     can not happen everything mapped
              ENDCASE.
          ENDTRY.
      ENDCASE.
*      ls_mdg_entity-entity = <ls_entity_struc>-entity.
*      ls_mdg_entity-tabl = lrt_entity.
      "IntIncID: 1580066810
      IF <lt_model_data> IS NOT INITIAL
        AND <ls_entity_struc>-entity <> 'MATERIAL' AND <ls_entity_struc>-entity <> 'DRADBASIC'
        AND <ls_entity_struc>-entity <> 'MARCBASIC' AND <ls_entity_struc>-entity <> 'MARDSTOR' AND <ls_entity_struc>-entity <> 'MBEWVALUA'
        AND <ls_entity_struc>-entity <> 'MLGTSTOR' AND <ls_entity_struc>-entity <> 'MARAPURCH' AND  <ls_entity_struc>-entity <> 'MARCSTORE'
        AND find( val = <ls_entity_struc>-entity sub = 'Y' ) NE 0 AND find( val = <ls_entity_struc>-entity sub = 'Z' ) NE 0. "custom entity types shall not be filtered
        "check if entity has non empty fields except key-fields
        CREATE DATA lrs_entity_save TYPE (<ls_entity_struc>-structure).
        ASSIGN lrs_entity_save->* TO <ls_model_data_save>.
        READ TABLE mt_attr_key WITH KEY entity = <ls_entity_struc>-entity ASSIGNING FIELD-SYMBOL(<fs_attr_key>).
        IF sy-subrc IS INITIAL.
          LOOP AT <lt_model_data> ASSIGNING <ls_model_data>.
            MOVE-CORRESPONDING <ls_model_data> TO <ls_model_data_save> EXPANDING NESTED TABLES.
            LOOP AT <fs_attr_key>-attr_key ASSIGNING <lv_key_name>.
              ASSIGN COMPONENT <lv_key_name> OF STRUCTURE <ls_model_data_save> TO <lv_key_value>.
              IF sy-subrc = 0.
                CLEAR <lv_key_value>.
              ENDIF.
            ENDLOOP.
            IF <ls_model_data_save> IS NOT INITIAL.
              INSERT <ls_model_data> INTO TABLE <lt_model_data_save>.
            ENDIF.
          ENDLOOP.
        ENDIF.
      ELSE.
        <lt_model_data_save> = <lt_model_data>.
      ENDIF.
      IF <lt_model_data_save> IS NOT INITIAL OR
      ( ( <ls_entity_struc>-entity = if_mdg_bs_mat_gen_c=>gc_entity_classasgn OR <ls_entity_struc>-entity = if_mdg_bs_mat_gen_c=>gc_entity_valuation )
        AND is_mat_api-clf_data-current_state = abap_true ).
        ls_mat_staging-entity = <ls_entity_struc>-entity.
        """"Extra code
        IF <ls_entity_struc>-is_txt EQ abap_true AND <ls_entity_struc>-entity EQ 'MATERIAL'.
          ls_mat_staging-entity = 'MATTXT'.
        ENDIF.
        """ For material text
        ls_mat_staging-tabl = lrt_entity_save.
        APPEND ls_mat_staging TO et_mat_staging.
      ENDIF.
      IF lt_messages IS NOT INITIAL.
        CALL METHOD cl_mdg_mm_2_staging=>map_usmd_mess_to_bapiret(
          EXPORTING
            it_usmd_message = lt_messages
          IMPORTING
            et_bapirettab   = lt_return_messages ).
        APPEND LINES OF lt_return_messages TO et_return_messages.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD read_all_data.
    TRY.
*        check me->mr_mara_prc is not bound.
        super->read_all_data( it_source_keys = it_source_keys iv_package_number = iv_package_number ).
      CATCH cx_mdc_model INTO DATA(lo_cx_mdc_model).
        DATA(lv_msg) = lo_cx_mdc_model->get_text( ) ##NEEDED.
    ENDTRY.
  ENDMETHOD.


  METHOD save_material_active.
    TRY.
        CALL METHOD super->save_material_active
          EXPORTING
            iv_process_improved_duplicates = abap_false.
      CATCH cx_mdc_model INTO DATA(lo_cx_mdc_model) .
        DATA(lv_msg) = lo_cx_mdc_model->get_text( ) ##NEEDED.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
