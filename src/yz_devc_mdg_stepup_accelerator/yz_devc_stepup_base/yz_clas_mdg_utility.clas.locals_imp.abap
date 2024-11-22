*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

TYPES:
BEGIN OF tys_message,
    msg_text      TYPE string,
    msgid         TYPE symsgid,
    msgty         TYPE  symsgty,
    msgno	        TYPE symsgno,
    msgv1	        TYPE symsgv,
    msgv2	        TYPE symsgv,
    msgv3	        TYPE symsgv,
    msgv4	        TYPE symsgv,
    row           TYPE n LENGTH 6,
    fieldname     TYPE fieldname,
    has_long_text TYPE boole_d,
    prio          TYPE i,
    style         TYPE lvc_t_styl,
    status        TYPE iconname,
  END OF tys_message,


  BEGIN OF tys_data_2pp,
    is_usable_mapping     TYPE char1,
    is_used_mapping       TYPE char1,
    entity_kind           TYPE char18,
    entity                TYPE char13,
    is_disabled_entity    TYPE char1,
    field_kind            TYPE char10,
    from_field            TYPE char255,
    is_disabled_field     TYPE char1,
    to_field              TYPE char255,
    trans_group           TYPE  n LENGTH 5,
    is_disabled           TYPE char1,
    is_compl_trans        TYPE char1,
    is_extension          TYPE char1,
    pp_structure          TYPE char30,
    fc_structure          TYPE char30,
    fp_structure          TYPE char30,
    smt_appl              TYPE char30,
    event                 TYPE char30,
    sstructure            TYPE char30,
    tstructure            TYPE char30,
  END OF tys_data_2pp.

CLASS select_list DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING dbtab  TYPE string
                            except TYPE string,
      get_token   RETURNING VALUE(token)  TYPE string,
      get_target  RETURNING VALUE(target) TYPE REF TO data.
  PRIVATE SECTION.
    DATA components TYPE cl_abap_structdescr=>component_table.
ENDCLASS.

CLASS select_list IMPLEMENTATION.
  METHOD constructor.
    components = CAST cl_abap_structdescr(
    cl_abap_typedescr=>describe_by_name( to_upper( dbtab ) ) )->get_components( ).

    SPLIT except AT `,` INTO TABLE DATA(columns).
    LOOP AT columns ASSIGNING FIELD-SYMBOL(<column>).
      DELETE components WHERE name = to_upper( condense( <column> ) ).
    ENDLOOP.
  ENDMETHOD.
  METHOD get_token.
    token = REDUCE string( INIT s = ``
                            FOR <wa> IN components
                            NEXT s &&=  COND #( WHEN s = ``  THEN <wa>-name
                            ELSE  `, ` && <wa>-name ) ).
  ENDMETHOD.
  METHOD get_target.
    DATA(itab_type) = cl_abap_tabledescr=>get( p_line_type  = cl_abap_structdescr=>get( p_components = components )
                                               p_table_kind = cl_abap_tabledescr=>tablekind_std ).
    CREATE DATA target TYPE HANDLE itab_type.
  ENDMETHOD.
ENDCLASS.


*----------------------------------------------------------------------*
*       CLASS lcl_find_model_details DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_find_model_details DEFINITION ##class_final.

  PUBLIC SECTION.
    DATA:gt_message                    TYPE TABLE OF tys_message .
    DATA gt_data                 TYPE STANDARD TABLE OF tys_data_2pp.

    CONSTANTS:
   BEGIN OF gc_mapping_status,
   not_defined TYPE string VALUE 'not defined',
   reuse_not_mapped TYPE string VALUE 'reuse not mapped',
   flex_mapped TYPE string VALUE 'flex mapped',
   reuse_mapped TYPE string VALUE 'reuse mapped',
   flex TYPE string VALUE 'flex',
     mapped TYPE string VALUE 'mapped',
     not_mapped TYPE string VALUE 'not mapped',
   END OF gc_mapping_status .

    CLASS-METHODS:
       check_enty_details_in_mapping
           IMPORTING iv_entity                  TYPE usmd_entity
                     is_txt                     TYPE boole
                     it_rmapped_entity          TYPE usmd_t_entity
                     it_flexmapped_entity       TYPE usmd_t_entity
                     it_disabled_attr_usual     TYPE mdg_bs_mat_t_smt_field
                     it_disabled_attr_txt_usual TYPE mdg_bs_mat_t_smt_field
                     iv_struc_attr              TYPE smt_structure
                     iv_struc_txt               TYPE smt_structure
                     iv_fc_structure            TYPE char30
                     iv_fp_structure            TYPE char30
           EXPORTING ev_pp_structure            TYPE char30
                     ev_is_usable_mapping       TYPE boole
                     ev_is_used_mapping         TYPE boole
                     ev_entity_kind             TYPE char18
                     et_disabled_fields_usual   TYPE mdg_bs_mat_t_smt_field
                     ev_entity                  TYPE char13
            CHANGING ct_message                 LIKE gt_message ,


       get_mattr_details_2pp
             IMPORTING is_mapping_details         TYPE mdg_bs_mat_s_smt_fld_mappinf_d
                       iv_group                   TYPE i
                       iv_entity                  TYPE usmd_entity
                       iv_entity_h                TYPE char13
                       is_entity_struc            TYPE mdg_bs_mat_s_enty_str
                       it_attr                    TYPE mdg_bs_mat_t_smt_field
                       it_txt	                    TYPE mdg_bs_mat_t_smt_field
                       iv_pp_structure            TYPE char30
                       iv_fc_structure            TYPE char30
                       iv_fp_structure            TYPE char30
                       iv_is_usable_mapping       TYPE boole
                       iv_is_used_mapping         TYPE boole
                       iv_entity_kind             TYPE char18
                       iv_disabled_entity         TYPE boole
              CHANGING ct_disabled_fields_usual   TYPE mdg_bs_mat_t_smt_field
                       ct_attr_and_keys_rest      TYPE mdg_bs_mat_t_prop_enties
                       ct_data                    LIKE gt_data
                       ct_message                 LIKE gt_message ,

*        get_mattr_details_2sa
*             IMPORTING is_mapping_details         TYPE mdg_bs_mat_s_smt_fld_mappinf_d
*                       iv_group                   TYPE i
*                       iv_entity                  TYPE usmd_entity
*                       iv_entity_h                TYPE char13
*                       is_entity_struc            TYPE mdg_bs_mat_s_enty_str
*                       it_attr                    TYPE mdg_bs_mat_t_smt_field
*                       it_txt                      TYPE mdg_bs_mat_t_smt_field
*                       iv_pp_structure            TYPE mdg_bs_mat_report_pp_struc
*                       iv_fc_structure            TYPE mdg_bs_mat_report_fp_struc
*                       iv_fp_structure            TYPE mdg_bs_mat_report_fp_struc
*                       iv_is_usable_mapping       TYPE boole
*                       iv_is_used_mapping         TYPE boole
*                       iv_entity_kind             TYPE char18
*                       iv_disabled_entity         TYPE boole
*              CHANGING ct_disabled_fields_usual   TYPE mdg_bs_mat_t_smt_field
*                       ct_attr_and_keys_rest      TYPE mdg_bs_mat_t_prop_enties
*                       ct_data                    LIKE gt_data
*                       ct_message                 LIKE gt_message ,


       get_nmattr_detl_consenties_2pp
             IMPORTING iv_model                   TYPE usmd_model
                       it_attr_and_keys_rest      TYPE mdg_bs_mat_t_prop_enties
                       it_considered_entities     TYPE usmd_t_entity
                       it_rmapped_entity          TYPE usmd_t_entity
                       it_flexmapped_entity       TYPE usmd_t_entity
              CHANGING ct_data                    LIKE gt_data
                       ct_message                 LIKE gt_message  ##needed ,

*      get_nmattr_detl_consenties_2sa
*             IMPORTING iv_model                   TYPE usmd_model
*                       it_attr_and_keys_rest      TYPE mdg_bs_mat_t_prop_enties
*                       it_considered_entities     TYPE usmd_t_entity
*                       it_rmapped_entity          TYPE usmd_t_entity
*                       it_flexmapped_entity       TYPE usmd_t_entity
*              CHANGING ct_data                    LIKE gt_data
*                       ct_message                 LIKE gt_message  ##needed ,

       get_rest_rnmenties_details_2pp
             IMPORTING iv_model                   TYPE usmd_model
                       it_considered_entities     TYPE usmd_t_entity
                       it_rnmapped_entity         TYPE usmd_t_entity
              CHANGING ct_data                    LIKE gt_data
                       ct_message                 LIKE gt_message ,
*
*       get_rest_rnmenties_details_2sa
*             IMPORTING iv_model                   TYPE usmd_model
*                       it_considered_entities     TYPE usmd_t_entity
*                       it_rnmapped_entity         TYPE usmd_t_entity
*              CHANGING ct_data                    LIKE gt_data
*                       ct_message                 LIKE gt_message ,

       get_rest_nmflex_details_2pp
             IMPORTING iv_model                   TYPE usmd_model
                       it_flexnmapped_entity      TYPE usmd_t_entity
              CHANGING ct_data                    LIKE gt_data
                       ct_message                 LIKE gt_message ##needed,

*       get_rest_nmflex_details_2sa
*             IMPORTING iv_model                   TYPE usmd_model
*                       it_flexnmapped_entity      TYPE usmd_t_entity
*              CHANGING ct_data                    LIKE gt_data
*                       ct_message                 LIKE gt_message ##needed,

       check_multiple_field_mapping
             IMPORTING iv_model                   TYPE usmd_model
                       iv_map_to_pp               TYPE boole_d
                       it_data                    LIKE gt_data
              CHANGING ct_message                 LIKE gt_message
                       .

ENDCLASS.                    "lcl_find_model_details DEFINITION

*----------------------------------------------------------------------*
*       CLASS lcl_handle_alv_events IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*


*----------------------------------------------------------------------*
*       CLASS find_model_details IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_find_model_details IMPLEMENTATION.

  METHOD check_enty_details_in_mapping.
    DATA:
    lv_message_string             TYPE string ##needed ,
    lv_message                    TYPE tys_message ##needed.

    CLEAR:
      ev_is_used_mapping,
      ev_is_used_mapping,
      ev_entity_kind,
      et_disabled_fields_usual,
      ev_entity.

* Since iv_entity has the length 13 here....
    IF is_txt = abap_true.
      CONCATENATE iv_entity '_txt' INTO ev_entity.
      et_disabled_fields_usual = it_disabled_attr_txt_usual.
      ev_pp_structure = iv_struc_txt.
* generate a message if the reuse area structure gv_pp_structure does not exist.
      IF ev_pp_structure IS INITIAL.
        CLEAR lv_message.
        MESSAGE e012(mdg_bs_mat_tools) INTO lv_message_string WITH ev_entity.
        MOVE-CORRESPONDING sy TO lv_message.
        INSERT lv_message INTO TABLE ct_message.
      ENDIF.
*******************************************************************************
* Not relevant anymore in 6.1/7.0.....
*******************************************************************************
** generate a message if no structure for field control exists (one of gv_fp_structure, gv_fc_structure has to exist)
*      CLEAR lv_message.
*      IF iv_fp_structure IS INITIAL AND iv_fc_structure IS INITIAL.
*        CLEAR lv_message.
*        MESSAGE e013(mdg_bs_mat_tools) INTO lv_message_string WITH ev_entity.
*        MOVE-CORRESPONDING sy TO lv_message.
*        INSERT lv_message INTO TABLE et_message.
*      ENDIF.

    ELSE.
      ev_entity =  iv_entity.
      et_disabled_fields_usual = it_disabled_attr_usual.
      ev_pp_structure = iv_struc_attr.
* generate a message if the reuse area structure gv_pp_structure does not exist.
      IF ev_pp_structure IS INITIAL.
        CLEAR lv_message.
        MESSAGE e012(mdg_bs_mat_tools) INTO lv_message_string WITH ev_entity.
        MOVE-CORRESPONDING sy TO lv_message.
        INSERT lv_message INTO TABLE ct_message.
      ENDIF.
*******************************************************************************
* Not relevant anymore in 6.1/7.0.....
*******************************************************************************
** generate a message if no structure for field control exists (one of gv_fp_structure, gv_fc_structure has to exist)
*      CLEAR lv_message.
*      IF iv_fp_structure IS INITIAL AND iv_fc_structure IS INITIAL.
*        CLEAR lv_message.
*        MESSAGE e013(mdg_bs_mat_tools) INTO lv_message_string WITH ev_entity.
*        MOVE-CORRESPONDING sy TO lv_message.
*        INSERT lv_message INTO TABLE et_message.
*      ENDIF.
    ENDIF.


    READ TABLE it_rmapped_entity FROM iv_entity TRANSPORTING NO FIELDS.
    IF sy-subrc = 0.
      ev_is_usable_mapping = abap_true.
      ev_is_used_mapping = abap_true.
      ev_entity_kind = gc_mapping_status-reuse_mapped.
    ELSE.
      READ TABLE it_flexmapped_entity FROM iv_entity TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        ev_is_usable_mapping = abap_true.
        ev_is_used_mapping = abap_false.
        ev_entity_kind = gc_mapping_status-flex_mapped.
* generate a message if flex entity is mapped....
        CLEAR lv_message.
        MESSAGE e014(mdg_bs_mat_tools) INTO lv_message_string WITH ev_entity.
        MOVE-CORRESPONDING sy TO lv_message.
        INSERT lv_message INTO TABLE ct_message.
      ELSE.  " since the entity is mapped this statement will never be considered...
        ev_is_usable_mapping = abap_true.
        ev_is_used_mapping = abap_false.
        ev_entity_kind = gc_mapping_status-reuse_not_mapped.
      ENDIF.
    ENDIF.
  ENDMETHOD.  "check_enty_details_in_mapping


  METHOD get_mattr_details_2pp.
    DATA:
    lv_message_string             TYPE string ##needed ,
    lv_message                    TYPE tys_message ##needed,
    ls_data                       LIKE LINE OF ct_data,
    lv_from_field                 TYPE smt_field,
    lv_attribute                  TYPE usmd_fieldname,
    lv_to_field                   TYPE smt_field,
    lt_from_fields                TYPE mdg_bs_mat_t_smt_field,
    lt_to_fields                  TYPE mdg_bs_mat_t_smt_field,
    lv_lines_from                 TYPE i,
    lv_lines_to                   TYPE i,
    lv_loop                       TYPE i,
    lv_count                      TYPE i.

    FIELD-SYMBOLS:
            <ls_attr_and_keys_rest>       TYPE mdg_bs_mat_s_prop_enties.

* Set the rest components of the output entry depending on the from field and on
* whether or not the transformation is complex or not
* ------------------------------------------------------------------------
    MOVE-CORRESPONDING is_mapping_details TO ls_data.
    IF is_mapping_details-is_compl_trans = abap_false.
      ls_data-is_usable_mapping = iv_is_usable_mapping.
      ls_data-is_used_mapping = iv_is_used_mapping.
      ls_data-entity_kind = iv_entity_kind.
      ls_data-entity = iv_entity_h.
      ls_data-is_disabled_entity = iv_disabled_entity.
      ls_data-pp_structure = iv_pp_structure.
      ls_data-fc_structure = iv_fc_structure.
      ls_data-fp_structure = iv_fp_structure.
      ls_data-trans_group = iv_group.
      ls_data-field_kind = gc_mapping_status-mapped.
      lv_from_field = is_mapping_details-from_field.
* Generate a message if the attribute lv_from_field is not in the model
      IF iv_entity IS NOT INITIAL.
        IF is_entity_struc-is_txt = abap_false.
          READ TABLE it_attr FROM lv_from_field TRANSPORTING NO FIELDS.
        ELSE.
          READ TABLE it_txt FROM lv_from_field TRANSPORTING NO FIELDS.
        ENDIF.
        IF sy-subrc <> 0.
          CLEAR lv_message.
          lv_attribute = lv_from_field.
          MESSAGE e017(mdg_bs_mat_tools) INTO lv_message_string WITH lv_attribute iv_entity.
          MOVE-CORRESPONDING sy TO lv_message.
          INSERT lv_message INTO TABLE ct_message.
        ENDIF.
        IF iv_entity_kind <> gc_mapping_status-not_defined.
          READ TABLE ct_attr_and_keys_rest ASSIGNING <ls_attr_and_keys_rest>
                                           WITH KEY entity = iv_entity.
          IF is_entity_struc-is_txt = abap_true.
            DELETE TABLE <ls_attr_and_keys_rest>-txt FROM lv_from_field.
          ELSE.
            DELETE TABLE <ls_attr_and_keys_rest>-attr FROM lv_from_field.
          ENDIF.

          READ TABLE ct_disabled_fields_usual FROM lv_from_field TRANSPORTING NO FIELDS.
          IF sy-subrc = 0.
            ls_data-is_disabled_field = abap_true.
          ENDIF.
        ENDIF.
      ENDIF.
********************************************************************************************
***********************   Ignore TXTMI and MATNR_EXT from MATERIAL  ************************
***********************   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  ************************
********************************************************************************************
      IF ( ls_data-from_field = 'MATNR_EXT' AND ls_data-entity = 'MATERIAL' ) OR
         ( ls_data-from_field = 'TXTMI' AND ls_data-entity = 'MATERIAL' ).
      ELSE.
        INSERT ls_data INTO TABLE ct_data.
      ENDIF.

    ELSE. " If <gs_mapping_details> is a complex transformation
      MOVE-CORRESPONDING is_mapping_details TO ls_data.
      lt_from_fields = is_mapping_details-from_fields.
      lt_to_fields =  is_mapping_details-to_fields.
      DESCRIBE TABLE lt_from_fields LINES lv_lines_from.
      DESCRIBE TABLE lt_to_fields LINES lv_lines_to.
      IF lv_lines_from < lv_lines_to.
        lv_loop = lv_lines_to.
      ELSE.
        lv_loop = lv_lines_from.
      ENDIF.
      lv_count = 1.
* Define for every from-field an entry in gt_data
      WHILE  lv_count <= lv_loop.
        CLEAR lv_from_field.
        IF  lv_count <= lv_lines_from.
          READ TABLE lt_from_fields INTO lv_from_field INDEX lv_count.
* Generate a message if the attribute lv_from_field is not in the model
          IF lv_from_field IS NOT INITIAL AND iv_entity IS NOT INITIAL.
            IF is_entity_struc-is_txt = abap_false.
              READ TABLE it_attr FROM lv_from_field TRANSPORTING NO FIELDS.
            ELSE.
              READ TABLE it_txt FROM lv_from_field TRANSPORTING NO FIELDS.
            ENDIF.
            IF sy-subrc <> 0.
              CLEAR lv_message.
              lv_attribute = lv_from_field.
              MESSAGE e017(mdg_bs_mat_tools) INTO lv_message_string WITH lv_attribute iv_entity.
              MOVE-CORRESPONDING sy TO lv_message.
              INSERT lv_message INTO TABLE ct_message.
            ENDIF.
          ENDIF.
        ENDIF.
        CLEAR lv_to_field.
        IF  lv_count <= lv_lines_to.
          READ TABLE lt_to_fields INTO lv_to_field INDEX lv_count.
        ENDIF.
        ls_data-is_usable_mapping = iv_is_usable_mapping.
        ls_data-is_used_mapping = iv_is_used_mapping.
        ls_data-entity_kind = iv_entity_kind.
        ls_data-entity = iv_entity_h.
        ls_data-is_disabled_entity = iv_disabled_entity.
*        ls_data-trans_group = gv_group.
        ls_data-field_kind = gc_mapping_status-mapped.
        ls_data-pp_structure = iv_pp_structure.
        ls_data-fc_structure = iv_fc_structure.
        ls_data-fp_structure = iv_fp_structure.
        ls_data-from_field = lv_from_field.
        ls_data-to_field = lv_to_field.
        IF iv_entity IS NOT INITIAL AND iv_entity_kind <> gc_mapping_status-not_defined.
          READ TABLE ct_disabled_fields_usual FROM lv_from_field TRANSPORTING NO FIELDS.
          IF sy-subrc = 0.
            ls_data-is_disabled_field = abap_true.
          ENDIF.
          READ TABLE ct_attr_and_keys_rest ASSIGNING <ls_attr_and_keys_rest>
                                         WITH KEY entity = iv_entity.
          IF is_entity_struc-is_txt = abap_true.
            DELETE TABLE <ls_attr_and_keys_rest>-txt FROM lv_from_field.
          ELSE.
            DELETE TABLE <ls_attr_and_keys_rest>-attr FROM lv_from_field.
          ENDIF.
        ENDIF.
********************************************************************************************
***********************   Ignore TXTMI and MATNR_EXT from MATERIAL  ************************
***********************   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  ************************
********************************************************************************************
        IF ( ls_data-from_field = 'MATNR_EXT' AND ls_data-entity = 'MATERIAL' ) OR
           ( ls_data-from_field = 'TXTMI' AND ls_data-entity = 'MATERIAL' ).
        ELSE.
          INSERT ls_data INTO TABLE ct_data.
          lv_count = lv_count + 1.
        ENDIF.
      ENDWHILE.
    ENDIF.

  ENDMETHOD.  "get_mattr_details_2pp

*  METHOD get_mattr_details_2sa.
*    DATA:
*       lv_message_string             TYPE string ##needed ,
*       lv_message                    TYPE tys_message ##needed,
*       ls_data                       LIKE LINE OF ct_data,
*       lv_from_field                 TYPE smt_field,
*       lv_attribute                  TYPE usmd_fieldname,
*       lv_to_field                   TYPE smt_field,
*       lt_from_fields                TYPE mdg_bs_mat_t_smt_field,
*       lt_to_fields                  TYPE mdg_bs_mat_t_smt_field,
*       lv_lines_from                 TYPE i,
*       lv_lines_to                   TYPE i,
*       lv_loop                       TYPE i,
*       lv_count                      TYPE i.
*
*    FIELD-SYMBOLS:
*       <ls_attr_and_keys_rest>       TYPE mdg_bs_mat_s_prop_enties.
*
** Set the rest components of the output entry depending on the to field and on
** whether or not the transformation is complex or not
** ------------------------------------------------------------------------
*    MOVE-CORRESPONDING is_mapping_details TO ls_data.
*    IF is_mapping_details-is_compl_trans = abap_false.
*      ls_data-is_usable_mapping = iv_is_usable_mapping.
*      ls_data-is_used_mapping = iv_is_used_mapping.
*      ls_data-entity_kind = iv_entity_kind.
*      ls_data-entity = iv_entity_h.
*      ls_data-is_disabled_entity = iv_disabled_entity.
*      ls_data-pp_structure = iv_pp_structure.
*      ls_data-fc_structure = iv_fc_structure.
*      ls_data-fp_structure = iv_fp_structure.
*      ls_data-trans_group = iv_group.
*      ls_data-field_kind = 'mapped'(004).
*      lv_to_field = is_mapping_details-to_field.
** Generate a message if the attribute lv_to_field is not in the model
*      IF iv_entity IS NOT INITIAL.
*        IF is_entity_struc-is_txt = abap_false.
*          READ TABLE it_attr FROM lv_to_field TRANSPORTING NO FIELDS.
*        ELSE.
*          READ TABLE it_txt FROM lv_to_field TRANSPORTING NO FIELDS.
*        ENDIF.
*        IF sy-subrc <> 0.
*          CLEAR lv_message.
*          lv_attribute = lv_to_field.
*          MESSAGE e017(mdg_bs_mat_tools) INTO lv_message_string WITH lv_attribute iv_entity.
*          MOVE-CORRESPONDING sy TO lv_message.
*          INSERT lv_message INTO TABLE ct_message.
*        ENDIF.
*
*        IF iv_entity_kind <> 'not defined'(005).
*          READ TABLE ct_attr_and_keys_rest ASSIGNING <ls_attr_and_keys_rest>
*                                           WITH KEY entity = iv_entity.
*          IF is_entity_struc-is_txt = abap_true.
*            DELETE TABLE <ls_attr_and_keys_rest>-txt FROM lv_to_field.
*          ELSE.
*            DELETE TABLE <ls_attr_and_keys_rest>-attr FROM lv_to_field.
*          ENDIF.
*
*          READ TABLE ct_disabled_fields_usual FROM lv_to_field TRANSPORTING NO FIELDS.
*          IF sy-subrc = 0.
*            ls_data-is_disabled_field = abap_true.
*          ENDIF.
*        ENDIF.
*      ENDIF.
*********************************************************************************************
************************   Ignore TXTMI and MATNR_EXT from MATERIAL  ************************
************************   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  ************************
*********************************************************************************************
*      IF ( ls_data-to_field = 'MATNR_EXT' AND ls_data-entity = 'MATERIAL' ) OR
*         ( ls_data-to_field = 'TXTMI' AND ls_data-entity = 'MATERIAL' ).
*      ELSE.
*        INSERT ls_data INTO TABLE ct_data.
*      ENDIF.
*
*    ELSE. " If <gs_mapping_details> is a complex transformation
*      MOVE-CORRESPONDING is_mapping_details TO ls_data.
*      lt_to_fields = is_mapping_details-to_fields.
*      lt_from_fields =  is_mapping_details-from_fields.
*      DESCRIBE TABLE lt_to_fields LINES lv_lines_to.
*      DESCRIBE TABLE lt_from_fields LINES lv_lines_from.
*      IF lv_lines_to < lv_lines_from.
*        lv_loop = lv_lines_from.
*      ELSE.
*        lv_loop = lv_lines_to.
*      ENDIF.
*      lv_count = 1.
** Define for every from-field an entry in gt_data
*      WHILE  lv_count <= lv_loop.
*        CLEAR lv_to_field.
*        IF  lv_count <= lv_lines_to.
*          READ TABLE lt_to_fields INTO lv_to_field INDEX lv_count.
** Generate a message if the attribute lv_from_field is not in the model
*          IF lv_to_field IS NOT INITIAL AND iv_entity IS NOT INITIAL.
*            IF is_entity_struc-is_txt = abap_false.
*              READ TABLE it_attr FROM lv_to_field TRANSPORTING NO FIELDS.
*            ELSE.
*              READ TABLE it_txt FROM lv_to_field TRANSPORTING NO FIELDS.
*            ENDIF.
*            IF sy-subrc <> 0.
*              CLEAR lv_message.
*              lv_attribute = lv_to_field.
*              MESSAGE e017(mdg_bs_mat_tools) INTO lv_message_string WITH lv_attribute iv_entity.
*              MOVE-CORRESPONDING sy TO lv_message.
*              INSERT lv_message INTO TABLE ct_message.
*            ENDIF.
*          ENDIF.
*        ENDIF.
*        CLEAR lv_from_field.
*        IF  lv_count <= lv_lines_from.
*          READ TABLE lt_from_fields INTO lv_from_field INDEX lv_count.
*        ENDIF.
*        ls_data-is_usable_mapping = iv_is_usable_mapping.
*        ls_data-is_used_mapping = iv_is_used_mapping.
*        ls_data-entity_kind = iv_entity_kind.
*        ls_data-entity = iv_entity_h.
*        ls_data-is_disabled_entity = iv_disabled_entity.
**        ls_data-trans_group = gv_group.
*        ls_data-field_kind = 'mapped'(004).
*        ls_data-pp_structure = iv_pp_structure.
*        ls_data-fc_structure = iv_fc_structure.
*        ls_data-fp_structure = iv_fp_structure.
*        ls_data-from_field = lv_from_field.
*        ls_data-to_field = lv_to_field.
*        IF iv_entity IS NOT INITIAL AND iv_entity_kind <> 'not defined'(005).
*          READ TABLE ct_disabled_fields_usual FROM lv_to_field TRANSPORTING NO FIELDS.
*          IF sy-subrc = 0.
*            ls_data-is_disabled_field = abap_true.
*          ENDIF.
*          READ TABLE ct_attr_and_keys_rest ASSIGNING <ls_attr_and_keys_rest>
*                                         WITH KEY entity = iv_entity.
*          IF is_entity_struc-is_txt = abap_true.
*            DELETE TABLE <ls_attr_and_keys_rest>-txt FROM lv_to_field.
*          ELSE.
*            DELETE TABLE <ls_attr_and_keys_rest>-attr FROM lv_to_field.
*          ENDIF.
*        ENDIF.
*********************************************************************************************
************************   Ignore TXTMI and MATNR_EXT from MATERIAL  ************************
************************   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  ************************
*********************************************************************************************
*        IF ( ls_data-to_field = 'MATNR_EXT' AND ls_data-entity = 'MATERIAL' ) OR
*           ( ls_data-to_field = 'TXTMI' AND ls_data-entity = 'MATERIAL' ).
*        ELSE.
*          INSERT ls_data INTO TABLE ct_data.
*          lv_count = lv_count + 1.
*        ENDIF.
*      ENDWHILE.
*    ENDIF.
*
*  ENDMETHOD.  "get_mattr_details_2sa

  METHOD get_nmattr_detl_consenties_2pp.
    DATA:
      lv_disabled_entity            TYPE boole,
      lv_struc_attr                 TYPE char30,
      lt_attr_usual                 TYPE mdg_bs_mat_t_smt_field ##needed,
      lt_enabled_attr_usual         TYPE mdg_bs_mat_t_smt_field ##needed,
      lt_disabled_attr_usual        TYPE mdg_bs_mat_t_smt_field,
      lv_struc_txt                  TYPE char30,
      lt_attr_txt_usual             TYPE mdg_bs_mat_t_smt_field ##needed,
      lt_enabled_attr_txt_usual     TYPE mdg_bs_mat_t_smt_field ##needed,
      lt_disabled_attr_txt_usual    TYPE mdg_bs_mat_t_smt_field,
      lv_fp_structure               TYPE char30,
      lv_fc_structure               TYPE char30,
      ls_data                       LIKE LINE OF ct_data,
      lv_from_field                 TYPE smt_field.

    FIELD-SYMBOLS:
        <ls_attr_and_keys_rest>       TYPE mdg_bs_mat_s_prop_enties.

    LOOP AT it_attr_and_keys_rest ASSIGNING <ls_attr_and_keys_rest>.
      READ TABLE it_considered_entities FROM <ls_attr_and_keys_rest>-entity
                                        TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        CALL METHOD cl_mdg_bs_mat_smt=>get_disabling_info_enty
          EXPORTING
            iv_model         = iv_model
            iv_entity        = <ls_attr_and_keys_rest>-entity
          IMPORTING
            ev_disabled      = lv_disabled_entity
            ev_struc_attr    = lv_struc_attr
            et_attr          = lt_attr_usual
            et_enabled_attr  = lt_enabled_attr_usual
            et_disabled_attr = lt_disabled_attr_usual
            ev_struc_txt     = lv_struc_txt
            et_txt           = lt_attr_txt_usual
            et_enabled_txt   = lt_enabled_attr_txt_usual
            et_disabled_txt  = lt_disabled_attr_txt_usual
            ev_fp_struc      = lv_fp_structure
            ev_fc_struc      = lv_fc_structure.
* Attributes
        LOOP AT <ls_attr_and_keys_rest>-attr INTO lv_from_field.
          CLEAR ls_data.
          ls_data-is_usable_mapping = abap_true.
          ls_data-pp_structure = lv_struc_attr.
          ls_data-fc_structure = lv_fc_structure.
          ls_data-fp_structure = lv_fp_structure.
          READ TABLE it_rmapped_entity FROM <ls_attr_and_keys_rest>-entity
                                       TRANSPORTING NO FIELDS.
          IF sy-subrc = 0.
            ls_data-is_usable_mapping = abap_true.
            ls_data-is_used_mapping = abap_true.
            ls_data-entity_kind = gc_mapping_status-reuse_mapped.
          ELSE.
            READ TABLE it_flexmapped_entity FROM <ls_attr_and_keys_rest>-entity
                                      TRANSPORTING NO FIELDS.
            IF sy-subrc = 0.
              ls_data-is_usable_mapping = abap_true.
              ls_data-is_used_mapping = abap_false.
              ls_data-entity_kind = gc_mapping_status-flex_mapped.
            ELSE. " since the entity is mapped this statement will never be considered...
              ls_data-is_usable_mapping = abap_true.
              ls_data-is_used_mapping = abap_false.
              ls_data-entity_kind = gc_mapping_status-reuse_not_mapped.
            ENDIF.
          ENDIF.
          ls_data-entity = <ls_attr_and_keys_rest>-entity.
          ls_data-is_disabled_entity = lv_disabled_entity.
          ls_data-field_kind = gc_mapping_status-not_mapped.
          ls_data-from_field = lv_from_field.
          READ TABLE lt_disabled_attr_usual FROM lv_from_field TRANSPORTING NO FIELDS.
          IF sy-subrc = 0.
            ls_data-is_disabled_field = abap_true.
          ENDIF.
          ls_data-sstructure = <ls_attr_and_keys_rest>-struc_attr.

*          INSERT gs_data INTO TABLE gt_data.
********************************************************************************************
***********************   Ignore TXTMI and MATNR_EXT from MATERIAL  ************************
***********************   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  ************************
********************************************************************************************
          IF ( ls_data-from_field = 'MATNR_EXT' AND ls_data-entity = 'MATERIAL' ) OR
             ( ls_data-from_field = 'TXTMI' AND ls_data-entity = 'MATERIAL' ).
          ELSE.
            INSERT ls_data INTO TABLE ct_data.
          ENDIF.
        ENDLOOP.
* Text
        LOOP AT <ls_attr_and_keys_rest>-txt INTO lv_from_field.
*          CLEAR gs_data.
          ls_data-is_usable_mapping = abap_true.
          ls_data-pp_structure = lv_struc_txt.
          ls_data-fc_structure = lv_fc_structure.
          ls_data-fp_structure = lv_fp_structure.
          READ TABLE it_rmapped_entity FROM <ls_attr_and_keys_rest>-entity
                                       TRANSPORTING NO FIELDS.
          IF sy-subrc = 0.
            ls_data-is_usable_mapping = abap_true.
            ls_data-is_used_mapping = abap_true.
            ls_data-entity_kind = gc_mapping_status-reuse_mapped.
          ELSE.
            READ TABLE it_flexmapped_entity FROM <ls_attr_and_keys_rest>-entity
                                      TRANSPORTING NO FIELDS.
            IF sy-subrc = 0.
              ls_data-is_usable_mapping = abap_true.
              ls_data-is_used_mapping = abap_false.
              ls_data-entity_kind = gc_mapping_status-flex_mapped.
            ELSE. " since the entity is mapped this statement will never be considered...
              ls_data-is_usable_mapping = abap_true.
              ls_data-is_used_mapping = abap_false.
              ls_data-entity_kind = gc_mapping_status-reuse_not_mapped.
            ENDIF.
          ENDIF.
          ls_data-entity = <ls_attr_and_keys_rest>-entity.
          ls_data-is_disabled_entity = lv_disabled_entity.
          ls_data-field_kind = gc_mapping_status-not_mapped.
          ls_data-from_field = lv_from_field.
          READ TABLE lt_disabled_attr_txt_usual FROM lv_from_field TRANSPORTING NO FIELDS.
          IF sy-subrc = 0.
            ls_data-is_disabled_field = abap_true.
          ENDIF.
          ls_data-sstructure = <ls_attr_and_keys_rest>-struc_txt.

********************************************************************************************
***********************   Ignore TXTMI and MATNR_EXT from MATERIAL  ************************
***********************   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  ************************
********************************************************************************************
          IF ( ls_data-from_field = 'MATNR_EXT' AND ls_data-entity = 'MATERIAL' ) OR
             ( ls_data-from_field = 'TXTMI' AND ls_data-entity = 'MATERIAL' ).
          ELSE.
            INSERT ls_data INTO TABLE ct_data.
          ENDIF.
        ENDLOOP.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.  "get_nmattr_details_cons_enties_2pp


*  METHOD get_nmattr_detl_consenties_2sa.
*    DATA:
*      lv_disabled_entity            TYPE boole,
*      lv_struc_attr                 TYPE smt_structure,
*      lt_attr_usual                 TYPE mdg_bs_mat_t_smt_field ##needed,
*      lt_enabled_attr_usual         TYPE mdg_bs_mat_t_smt_field ##needed,
*      lt_disabled_attr_usual        TYPE mdg_bs_mat_t_smt_field,
*      lv_struc_txt                  TYPE smt_structure,
*      lt_attr_txt_usual             TYPE mdg_bs_mat_t_smt_field ##needed,
*      lt_enabled_attr_txt_usual     TYPE mdg_bs_mat_t_smt_field ##needed,
*      lt_disabled_attr_txt_usual    TYPE mdg_bs_mat_t_smt_field,
*      lv_fp_structure               TYPE mdg_bs_mat_report_fp_struc,
*      lv_fc_structure               TYPE mdg_bs_mat_report_fc_struc,
*      ls_data                       LIKE LINE OF ct_data,
*      lv_to_field                   TYPE smt_field.
*
*    FIELD-SYMBOLS:
*        <ls_attr_and_keys_rest>       TYPE mdg_bs_mat_s_prop_enties.
*
*    LOOP AT it_attr_and_keys_rest ASSIGNING <ls_attr_and_keys_rest>.
*      READ TABLE it_considered_entities FROM <ls_attr_and_keys_rest>-entity
*                                        TRANSPORTING NO FIELDS.
*      IF sy-subrc = 0.
*        CALL METHOD cl_mdg_bs_mat_smt=>get_disabling_info_enty
*          EXPORTING
*            iv_model         = iv_model
*            iv_entity        = <ls_attr_and_keys_rest>-entity
*          IMPORTING
*            ev_disabled      = lv_disabled_entity
*            ev_struc_attr    = lv_struc_attr
*            et_attr          = lt_attr_usual
*            et_enabled_attr  = lt_enabled_attr_usual
*            et_disabled_attr = lt_disabled_attr_usual
*            ev_struc_txt     = lv_struc_txt
*            et_txt           = lt_attr_txt_usual
*            et_enabled_txt   = lt_enabled_attr_txt_usual
*            et_disabled_txt  = lt_disabled_attr_txt_usual
*            ev_fp_struc      = lv_fp_structure
*            ev_fc_struc      = lv_fc_structure.
** Attributes
*        LOOP AT <ls_attr_and_keys_rest>-attr INTO lv_to_field.
*          CLEAR ls_data.
*          ls_data-is_usable_mapping = abap_true.
*          ls_data-pp_structure = lv_struc_attr.
*          ls_data-fc_structure = lv_fc_structure.
*          ls_data-fp_structure = lv_fp_structure.
*          READ TABLE it_rmapped_entity FROM <ls_attr_and_keys_rest>-entity
*                                       TRANSPORTING NO FIELDS.
*          IF sy-subrc = 0.
*            ls_data-is_usable_mapping = abap_true.
*            ls_data-is_used_mapping = abap_true.
*            ls_data-entity_kind = 'reuse mapped'(002).
*          ELSE.
*            READ TABLE it_flexmapped_entity FROM <ls_attr_and_keys_rest>-entity
*                                      TRANSPORTING NO FIELDS.
*            IF sy-subrc = 0.
*              ls_data-is_usable_mapping = abap_true.
*              ls_data-is_used_mapping = abap_false.
*              ls_data-entity_kind = 'flex mapped'(009).
*            ELSE. " since the entity is mapped this statement will never be considered...
*              ls_data-is_usable_mapping = abap_true.
*              ls_data-is_used_mapping = abap_false.
*              ls_data-entity_kind = 'reuse not mapped'(003).
*            ENDIF.
*          ENDIF.
*          ls_data-entity = <ls_attr_and_keys_rest>-entity.
*          ls_data-is_disabled_entity = lv_disabled_entity.
*          ls_data-field_kind = 'not mapped'(006).
*          ls_data-to_field = lv_to_field.
*          READ TABLE lt_disabled_attr_usual FROM lv_to_field TRANSPORTING NO FIELDS.
*          IF sy-subrc = 0.
*            ls_data-is_disabled_field = abap_true.
*          ENDIF.
*          ls_data-sstructure = <ls_attr_and_keys_rest>-struc_attr.
*
**          INSERT gs_data INTO TABLE gt_data.
*********************************************************************************************
************************   Ignore TXTMI and MATNR_EXT from MATERIAL  ************************
************************   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  ************************
*********************************************************************************************
*          IF ( ls_data-to_field = 'MATNR_EXT' AND ls_data-entity = 'MATERIAL' ) OR
*             ( ls_data-to_field = 'TXTMI' AND ls_data-entity = 'MATERIAL' ).
*          ELSE.
*            INSERT ls_data INTO TABLE ct_data.
*          ENDIF.
*        ENDLOOP.
** Text
*        LOOP AT <ls_attr_and_keys_rest>-txt INTO lv_to_field.
**          CLEAR gs_data.
*          ls_data-is_usable_mapping = abap_true.
*          ls_data-pp_structure = lv_struc_txt.
*          ls_data-fc_structure = lv_fc_structure.
*          ls_data-fp_structure = lv_fp_structure.
*          READ TABLE it_rmapped_entity FROM <ls_attr_and_keys_rest>-entity
*                                       TRANSPORTING NO FIELDS.
*          IF sy-subrc = 0.
*            ls_data-is_usable_mapping = abap_true.
*            ls_data-is_used_mapping = abap_true.
*            ls_data-entity_kind = 'reuse mapped'(002).
*          ELSE.
*            READ TABLE it_flexmapped_entity FROM <ls_attr_and_keys_rest>-entity
*                                      TRANSPORTING NO FIELDS.
*            IF sy-subrc = 0.
*              ls_data-is_usable_mapping = abap_true.
*              ls_data-is_used_mapping = abap_false.
*              ls_data-entity_kind = 'flex mapped'(009).
*            ELSE. " since the entity is mapped this statement will never be considered...
*              ls_data-is_usable_mapping = abap_true.
*              ls_data-is_used_mapping = abap_false.
*              ls_data-entity_kind = 'reuse not mapped'(003).
*            ENDIF.
*          ENDIF.
*          ls_data-entity = <ls_attr_and_keys_rest>-entity.
*          ls_data-is_disabled_entity = lv_disabled_entity.
*          ls_data-field_kind = 'not mapped'(006).
*          ls_data-to_field = lv_to_field.
*          READ TABLE lt_disabled_attr_txt_usual FROM lv_to_field TRANSPORTING NO FIELDS.
*          IF sy-subrc = 0.
*            ls_data-is_disabled_field = abap_true.
*          ENDIF.
*          ls_data-sstructure = <ls_attr_and_keys_rest>-struc_txt.
*
*********************************************************************************************
************************   Ignore TXTMI and MATNR_EXT from MATERIAL  ************************
************************   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  ************************
*********************************************************************************************
*          IF ( ls_data-to_field = 'MATNR_EXT' AND ls_data-entity = 'MATERIAL' ) OR
*             ( ls_data-to_field = 'TXTMI' AND ls_data-entity = 'MATERIAL' ).
*          ELSE.
*            INSERT ls_data INTO TABLE ct_data.
*          ENDIF.
*        ENDLOOP.
*      ENDIF.
*    ENDLOOP.
*
*  ENDMETHOD.  "get_nmattr_details_cons_enties_2sa

  METHOD get_rest_rnmenties_details_2pp.
    DATA:
      lv_message                    TYPE tys_message,
      lv_message_string             TYPE string ##needed,
      ls_rnmapped_entity            TYPE usmd_entity,
      lv_disabled_entity            TYPE boole,
      lv_struc_attr                 TYPE char30,
      lt_attr_usual                 TYPE mdg_bs_mat_t_smt_field,
      lt_enabled_attr_usual         TYPE mdg_bs_mat_t_smt_field ##needed,
      lt_disabled_attr_usual        TYPE mdg_bs_mat_t_smt_field,
      lv_struc_txt                  TYPE char30,
      lt_attr_txt_usual             TYPE mdg_bs_mat_t_smt_field,
      lt_enabled_attr_txt_usual     TYPE mdg_bs_mat_t_smt_field ##needed,
      lt_disabled_attr_txt_usual    TYPE mdg_bs_mat_t_smt_field,
      lv_fp_structure               TYPE char30,
      lv_fc_structure               TYPE char30,
      lv_entity                     TYPE char13,
      ls_data                       LIKE LINE OF ct_data,
      lv_field                      TYPE smt_field.

    LOOP AT it_rnmapped_entity INTO ls_rnmapped_entity.
      READ TABLE it_considered_entities FROM ls_rnmapped_entity
                                        TRANSPORTING NO FIELDS.
      IF sy-subrc <> 0.
        CLEAR ls_data.
        ls_data-is_usable_mapping = abap_false.
        ls_data-is_used_mapping = abap_false.
        ls_data-entity_kind = gc_mapping_status-reuse_not_mapped.
* generate a message if the reuse entity (except drad entities) is not mapped.
        IF ls_rnmapped_entity <> cl_mdg_bs_mat_c=>gc_entity_dradbasic AND
           ls_rnmapped_entity <> cl_mdg_bs_mat_c=>gc_entity_dradtxt AND
           ls_rnmapped_entity <> cl_mdg_bs_mat_c=>gc_entity_mkalbasic AND
           ls_rnmapped_entity <> cl_mdg_bs_mat_c=>gc_entity_matchgmng.
          CLEAR lv_message.
          MESSAGE e015(mdg_bs_mat_tools) INTO lv_message_string WITH ls_rnmapped_entity.
          MOVE-CORRESPONDING sy TO lv_message.
          INSERT lv_message INTO TABLE ct_message.
        ENDIF.
        CALL METHOD cl_mdg_bs_mat_smt=>get_disabling_info_enty
          EXPORTING
            iv_model         = iv_model
            iv_entity        = ls_rnmapped_entity
          IMPORTING
            ev_disabled      = lv_disabled_entity
            ev_struc_attr    = lv_struc_attr
            et_attr          = lt_attr_usual
            et_enabled_attr  = lt_enabled_attr_usual
            et_disabled_attr = lt_disabled_attr_usual
            ev_struc_txt     = lv_struc_txt
            et_txt           = lt_attr_txt_usual
            et_enabled_txt   = lt_enabled_attr_txt_usual
            et_disabled_txt  = lt_disabled_attr_txt_usual
            ev_fp_struc      = lv_fp_structure
            ev_fc_struc      = lv_fc_structure.
* generate a message if the reuse area structure gv_pp_structure does not exist.
        IF lv_struc_attr IS INITIAL.
          CLEAR lv_message.
          MESSAGE e012(mdg_bs_mat_tools) INTO lv_message_string WITH ls_rnmapped_entity.
          MOVE-CORRESPONDING sy TO lv_message.
          INSERT lv_message INTO TABLE ct_message.
        ENDIF.
*****************************************************************
* Not relevant anymore for 6.1  and 7.0
*****************************************************************
** generate a message if no structure for field control exists (one of lv_fp_structure, lv_fc_structure has to exist)
*        CLEAR lv_message.
*        IF lv_fp_structure IS INITIAL AND lv_fc_structure IS INITIAL.
*          CLEAR lv_message.
*          MESSAGE e013(mdg_bs_mat_tools) INTO lv_message_string WITH ls_rnmapped_entity.
*          MOVE-CORRESPONDING sy TO lv_message.
*          INSERT lv_message INTO TABLE ct_message.
*        ENDIF.
* Attributes
        LOOP AT lt_attr_usual INTO lv_field.
          ls_data-entity = ls_rnmapped_entity.
          ls_data-pp_structure = lv_struc_attr.
          ls_data-fc_structure = lv_fc_structure.
          ls_data-fp_structure = lv_fp_structure.
          ls_data-is_disabled_entity = lv_disabled_entity.
          ls_data-field_kind = gc_mapping_status-not_mapped.
          ls_data-from_field = lv_field.
          READ TABLE lt_disabled_attr_usual FROM lv_field TRANSPORTING NO FIELDS.
          IF sy-subrc = 0.
            ls_data-is_disabled_field = abap_true.
          ELSE.
            ls_data-is_disabled_field = abap_false.
          ENDIF.
*          INSERT gs_data INTO TABLE gt_data.
********************************************************************************************
***********************   Ignore TXTMI and MATNR_EXT from MATERIAL  ************************
***********************   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  ************************
********************************************************************************************
          IF ( ls_data-from_field = 'MATNR_EXT' AND ls_data-entity = 'MATERIAL' ) OR
             ( ls_data-from_field = 'TXTMI' AND ls_data-entity = 'MATERIAL' ).
          ELSE.
            INSERT ls_data INTO TABLE ct_data.
          ENDIF.
        ENDLOOP.
* Text
        CONCATENATE ls_rnmapped_entity '_txt' INTO lv_entity.
        LOOP AT lt_attr_txt_usual INTO lv_field.
          ls_data-entity = lv_entity.
          ls_data-pp_structure = lv_struc_txt.
          ls_data-fc_structure = lv_fc_structure.
          ls_data-fp_structure = lv_fp_structure.
          ls_data-is_disabled_entity = lv_disabled_entity.
          ls_data-field_kind = gc_mapping_status-not_mapped.
          ls_data-from_field = lv_field.
          READ TABLE lt_disabled_attr_txt_usual FROM lv_field TRANSPORTING NO FIELDS.
          IF sy-subrc = 0.
            ls_data-is_disabled_field = abap_true.
          ELSE.
            ls_data-is_disabled_field = abap_false.
          ENDIF.
********************************************************************************************
***********************   Ignore TXTMI and MATNR_EXT from MATERIAL  ************************
***********************   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  ************************
********************************************************************************************
          IF ( ls_data-from_field = 'MATNR_EXT' AND ls_data-entity = 'MATERIAL' ) OR
             ( ls_data-from_field = 'TXTMI' AND ls_data-entity = 'MATERIAL' ).
          ELSE.
            INSERT ls_data INTO TABLE ct_data.
          ENDIF.
        ENDLOOP.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.  "get_rest_rnmenties_details_2pp

*  METHOD get_rest_rnmenties_details_2sa.
*    DATA:
*      lv_message                    TYPE tys_message,
*      lv_message_string             TYPE string ##needed,
*      ls_rnmapped_entity            TYPE usmd_entity,
*      lv_disabled_entity            TYPE boole,
*      lv_struc_attr                 TYPE smt_structure,
*      lt_attr_usual                 TYPE mdg_bs_mat_t_smt_field,
*      lt_enabled_attr_usual         TYPE mdg_bs_mat_t_smt_field ##needed,
*      lt_disabled_attr_usual        TYPE mdg_bs_mat_t_smt_field,
*      lv_struc_txt                  TYPE smt_structure,
*      lt_attr_txt_usual             TYPE mdg_bs_mat_t_smt_field,
*      lt_enabled_attr_txt_usual     TYPE mdg_bs_mat_t_smt_field ##needed,
*      lt_disabled_attr_txt_usual    TYPE mdg_bs_mat_t_smt_field,
*      lv_fp_structure               TYPE mdg_bs_mat_report_fp_struc,
*      lv_fc_structure               TYPE mdg_bs_mat_report_fc_struc,
*      lv_entity                     TYPE char13,
*      ls_data                       LIKE LINE OF ct_data,
*      lv_field                      TYPE smt_field.
*
*    LOOP AT it_rnmapped_entity INTO ls_rnmapped_entity.
*      READ TABLE it_considered_entities FROM ls_rnmapped_entity
*                                        TRANSPORTING NO FIELDS.
*      IF sy-subrc <> 0.
*        CLEAR ls_data.
*        ls_data-is_usable_mapping = abap_false.
*        ls_data-is_used_mapping = abap_false.
*        ls_data-entity_kind = 'reuse not mapped'(003).
** generate a message if the reuse entity (except drad entities) is not mapped.
*        IF ls_rnmapped_entity <> cl_mdg_bs_mat_c=>gc_entity_dradbasic AND
*           ls_rnmapped_entity <> cl_mdg_bs_mat_c=>gc_entity_dradtxt.
*          CLEAR lv_message.
*          MESSAGE e015(mdg_bs_mat_tools) INTO lv_message_string WITH ls_rnmapped_entity.
*          MOVE-CORRESPONDING sy TO lv_message.
*          INSERT lv_message INTO TABLE ct_message.
*        ENDIF.
*        CALL METHOD cl_mdg_bs_mat_smt=>get_disabling_info_enty
*          EXPORTING
*            iv_model         = iv_model
*            iv_entity        = ls_rnmapped_entity
*          IMPORTING
*            ev_disabled      = lv_disabled_entity
*            ev_struc_attr    = lv_struc_attr
*            et_attr          = lt_attr_usual
*            et_enabled_attr  = lt_enabled_attr_usual
*            et_disabled_attr = lt_disabled_attr_usual
*            ev_struc_txt     = lv_struc_txt
*            et_txt           = lt_attr_txt_usual
*            et_enabled_txt   = lt_enabled_attr_txt_usual
*            et_disabled_txt  = lt_disabled_attr_txt_usual
*            ev_fp_struc      = lv_fp_structure
*            ev_fc_struc      = lv_fc_structure.
** generate a message if the reuse area structure gv_pp_structure does not exist.
*        IF lv_struc_attr IS INITIAL.
*          CLEAR lv_message.
*          MESSAGE e012(mdg_bs_mat_tools) INTO lv_message_string WITH ls_rnmapped_entity.
*          MOVE-CORRESPONDING sy TO lv_message.
*          INSERT lv_message INTO TABLE ct_message.
*        ENDIF.
******************************************************************
** Not relevant anymore for 6.1  and 7.0
******************************************************************
*** generate a message if no structure for field control exists (one of lv_fp_structure, lv_fc_structure has to exist)
**        CLEAR lv_message.
**        IF lv_fp_structure IS INITIAL AND lv_fc_structure IS INITIAL.
**          CLEAR lv_message.
**          MESSAGE e013(mdg_bs_mat_tools) INTO lv_message_string WITH ls_rnmapped_entity.
**          MOVE-CORRESPONDING sy TO lv_message.
**          INSERT lv_message INTO TABLE ct_message.
**        ENDIF.
** Attributes
*        LOOP AT lt_attr_usual INTO lv_field.
*          ls_data-entity = ls_rnmapped_entity.
*          ls_data-pp_structure = lv_struc_attr.
*          ls_data-fc_structure = lv_fc_structure.
*          ls_data-fp_structure = lv_fp_structure.
*          ls_data-is_disabled_entity = lv_disabled_entity.
*          ls_data-field_kind = 'not mapped'(006).
*          ls_data-to_field = lv_field.
*          READ TABLE lt_disabled_attr_usual FROM lv_field TRANSPORTING NO FIELDS.
*          IF sy-subrc = 0.
*            ls_data-is_disabled_field = abap_true.
*          ELSE.
*            ls_data-is_disabled_field = abap_false.
*          ENDIF.
**          INSERT gs_data INTO TABLE gt_data.
*********************************************************************************************
************************   Ignore TXTMI and MATNR_EXT from MATERIAL  ************************
************************   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  ************************
*********************************************************************************************
*          IF ( ls_data-to_field = 'MATNR_EXT' AND ls_data-entity = 'MATERIAL' ) OR
*             ( ls_data-to_field = 'TXTMI' AND ls_data-entity = 'MATERIAL' ).
*          ELSE.
*            INSERT ls_data INTO TABLE ct_data.
*          ENDIF.
*        ENDLOOP.
** Text
*        CONCATENATE ls_rnmapped_entity '_txt' INTO lv_entity.
*        LOOP AT lt_attr_txt_usual INTO lv_field.
*          ls_data-entity = lv_entity.
*          ls_data-pp_structure = lv_struc_txt.
*          ls_data-fc_structure = lv_fc_structure.
*          ls_data-fp_structure = lv_fp_structure.
*          ls_data-is_disabled_entity = lv_disabled_entity.
*          ls_data-field_kind = 'not mapped'(006).
*          ls_data-to_field = lv_field.
*          READ TABLE lt_disabled_attr_txt_usual FROM lv_field TRANSPORTING NO FIELDS.
*          IF sy-subrc = 0.
*            ls_data-is_disabled_field = abap_true.
*          ELSE.
*            ls_data-is_disabled_field = abap_false.
*          ENDIF.
*********************************************************************************************
************************   Ignore TXTMI and MATNR_EXT from MATERIAL  ************************
************************   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  ************************
*********************************************************************************************
*          IF ( ls_data-to_field = 'MATNR_EXT' AND ls_data-entity = 'MATERIAL' ) OR
*             ( ls_data-to_field = 'TXTMI' AND ls_data-entity = 'MATERIAL' ).
*          ELSE.
*            INSERT ls_data INTO TABLE ct_data.
*          ENDIF.
*        ENDLOOP.
*      ENDIF.
*    ENDLOOP.
*
*  ENDMETHOD.  "get_rest_rnmenties_details_2sa

  METHOD get_rest_nmflex_details_2pp.
    DATA:
      lv_message                    TYPE tys_message,
      lv_message_string             TYPE string ##needed,
      ls_rnmapped_entity            TYPE usmd_entity,
      lv_disabled_entity            TYPE boole,
      lv_struc_attr                 TYPE smt_structure,
      lt_attr_usual                 TYPE mdg_bs_mat_t_smt_field,
      lt_enabled_attr_usual         TYPE mdg_bs_mat_t_smt_field ##needed,
      lt_disabled_attr_usual        TYPE mdg_bs_mat_t_smt_field,
      lv_struc_txt                  TYPE smt_structure,
      lt_attr_txt_usual             TYPE mdg_bs_mat_t_smt_field,
      lt_enabled_attr_txt_usual     TYPE mdg_bs_mat_t_smt_field ##needed,
      lt_disabled_attr_txt_usual    TYPE mdg_bs_mat_t_smt_field,
      lv_fp_structure               TYPE char30,
      lv_fc_structure               TYPE char30,
      lv_entity                     TYPE char13,
      ls_data                       LIKE LINE OF ct_data,
      lv_field                      TYPE smt_field.


    LOOP AT it_flexnmapped_entity INTO ls_rnmapped_entity.
      CLEAR ls_data.
      ls_data-is_usable_mapping = abap_false.
      ls_data-is_used_mapping = abap_false.
      ls_data-entity_kind = gc_mapping_status-flex.
      CALL METHOD cl_mdg_bs_mat_smt=>get_disabling_info_enty
        EXPORTING
          iv_model         = iv_model
          iv_entity        = ls_rnmapped_entity
        IMPORTING
          ev_disabled      = lv_disabled_entity
          ev_struc_attr    = lv_struc_attr
          et_attr          = lt_attr_usual
          et_enabled_attr  = lt_enabled_attr_usual
          et_disabled_attr = lt_disabled_attr_usual
          ev_struc_txt     = lv_struc_txt
          et_txt           = lt_attr_txt_usual
          et_enabled_txt   = lt_enabled_attr_txt_usual
          et_disabled_txt  = lt_disabled_attr_txt_usual
          ev_fp_struc      = lv_fp_structure
          ev_fc_struc      = lv_fc_structure.
* Attributes
* generate a message if the reuse area structure gv_pp_structure does not exist.
      IF lv_struc_attr IS INITIAL.
        CLEAR lv_message.
        MESSAGE e012(mdg_bs_mat_tools) INTO lv_message_string WITH ls_rnmapped_entity.
        MOVE-CORRESPONDING sy TO lv_message.
        INSERT lv_message INTO TABLE ct_message.
      ENDIF.
      LOOP AT lt_attr_usual INTO lv_field.
        ls_data-entity = ls_rnmapped_entity.
        ls_data-pp_structure = lv_struc_attr.
        ls_data-fc_structure = lv_fc_structure.
        ls_data-fp_structure = lv_fp_structure.
        ls_data-is_disabled_entity = lv_disabled_entity.
        ls_data-field_kind = gc_mapping_status-not_mapped.
        ls_data-from_field = lv_field.
        READ TABLE lt_disabled_attr_usual FROM lv_field TRANSPORTING NO FIELDS.
        IF sy-subrc = 0.
          ls_data-is_disabled_field = abap_true.
        ELSE.
          ls_data-is_disabled_field = abap_false.
        ENDIF.
********************************************************************************************
***********************   Ignore TXTMI and MATNR_EXT from MATERIAL  ************************
***********************   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  ************************
********************************************************************************************
        IF ( ls_data-from_field = 'MATNR_EXT' AND ls_data-entity = 'MATERIAL' ) OR
           ( ls_data-from_field = 'TXTMI' AND ls_data-entity = 'MATERIAL' ).
        ELSE.
          INSERT ls_data INTO TABLE ct_data.
        ENDIF.
      ENDLOOP.

* Text
      CONCATENATE ls_rnmapped_entity '_txt' INTO lv_entity.
      LOOP AT lt_attr_txt_usual INTO lv_field.
        ls_data-entity = lv_entity.
        ls_data-pp_structure = lv_struc_txt.
        ls_data-fc_structure = lv_fc_structure.
        ls_data-fp_structure = lv_fp_structure.
        ls_data-is_disabled_entity = lv_disabled_entity.
        ls_data-field_kind = gc_mapping_status-not_mapped.
        ls_data-from_field = lv_field.
        READ TABLE lt_disabled_attr_txt_usual FROM lv_field TRANSPORTING NO FIELDS.
        IF sy-subrc = 0.
          ls_data-is_disabled_field = abap_true.
        ELSE.
          ls_data-is_disabled_field = abap_false.
        ENDIF.

********************************************************************************************
***********************   Ignore TXTMI and MATNR_EXT from MATERIAL  ************************
***********************   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  ************************
********************************************************************************************
        IF ( ls_data-from_field = 'MATNR_EXT' AND ls_data-entity = 'MATERIAL' ) OR
           ( ls_data-from_field = 'TXTMI' AND ls_data-entity = 'MATERIAL' ).
        ELSE.
          INSERT ls_data INTO TABLE ct_data.
        ENDIF.
      ENDLOOP.
    ENDLOOP.

  ENDMETHOD.  "get_rest_nmflex_details_2pp

*  METHOD get_rest_nmflex_details_2sa.
*    DATA:
*      lv_message                    TYPE tys_message,
*      lv_message_string             TYPE string ##needed,
*      ls_rnmapped_entity            TYPE usmd_entity,
*      lv_disabled_entity            TYPE boole,
*      lv_struc_attr                 TYPE smt_structure,
*      lt_attr_usual                 TYPE mdg_bs_mat_t_smt_field,
*      lt_enabled_attr_usual         TYPE mdg_bs_mat_t_smt_field ##needed,
*      lt_disabled_attr_usual        TYPE mdg_bs_mat_t_smt_field,
*      lv_struc_txt                  TYPE smt_structure,
*      lt_attr_txt_usual             TYPE mdg_bs_mat_t_smt_field,
*      lt_enabled_attr_txt_usual     TYPE mdg_bs_mat_t_smt_field ##needed,
*      lt_disabled_attr_txt_usual    TYPE mdg_bs_mat_t_smt_field,
*      lv_fp_structure               TYPE mdg_bs_mat_report_fp_struc,
*      lv_fc_structure               TYPE mdg_bs_mat_report_fc_struc,
*      lv_entity                     TYPE char13,
*      ls_data                       LIKE LINE OF ct_data,
*      lv_field                      TYPE smt_field.
*
** Consider the rest of the not mapped flex entities
*    LOOP AT it_flexnmapped_entity INTO ls_rnmapped_entity.
*      CLEAR ls_data.
*      ls_data-is_usable_mapping = abap_false.
*      ls_data-is_used_mapping = abap_false.
*      ls_data-entity_kind = 'flex'(007).
*      CALL METHOD cl_mdg_bs_mat_smt=>get_disabling_info_enty
*        EXPORTING
*          iv_model         = iv_model
*          iv_entity        = ls_rnmapped_entity
*        IMPORTING
*          ev_disabled      = lv_disabled_entity
*          ev_struc_attr    = lv_struc_attr
*          et_attr          = lt_attr_usual
*          et_enabled_attr  = lt_enabled_attr_usual
*          et_disabled_attr = lt_disabled_attr_usual
*          ev_struc_txt     = lv_struc_txt
*          et_txt           = lt_attr_txt_usual
*          et_enabled_txt   = lt_enabled_attr_txt_usual
*          et_disabled_txt  = lt_disabled_attr_txt_usual
*          ev_fp_struc      = lv_fp_structure
*          ev_fc_struc      = lv_fc_structure.
** Attributes
** generate a message if the reuse area structure gv_pp_structure does not exist.
*      IF lv_struc_attr IS INITIAL.
*        CLEAR lv_message.
*        MESSAGE e012(mdg_bs_mat_tools) INTO lv_message_string WITH ls_rnmapped_entity.
*        MOVE-CORRESPONDING sy TO lv_message.
*        INSERT lv_message INTO TABLE ct_message.
*      ENDIF.
*      LOOP AT lt_attr_usual INTO lv_field.
*        ls_data-entity = ls_rnmapped_entity.
*        ls_data-pp_structure = lv_struc_attr.
*        ls_data-fc_structure = lv_fc_structure.
*        ls_data-fp_structure = lv_fp_structure.
*        ls_data-is_disabled_entity = lv_disabled_entity.
*        ls_data-field_kind = 'not mapped'(006).
*        ls_data-to_field = lv_field.
*        READ TABLE lt_disabled_attr_usual FROM lv_field TRANSPORTING NO FIELDS.
*        IF sy-subrc = 0.
*          ls_data-is_disabled_field = abap_true.
*        ELSE.
*          ls_data-is_disabled_field = abap_false.
*        ENDIF.
*********************************************************************************************
************************   Ignore TXTMI and MATNR_EXT from MATERIAL  ************************
************************   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  ************************
*********************************************************************************************
*        IF ( ls_data-to_field = 'MATNR_EXT' AND ls_data-entity = 'MATERIAL' ) OR
*           ( ls_data-to_field = 'TXTMI' AND ls_data-entity = 'MATERIAL' ).
*        ELSE.
*          INSERT ls_data INTO TABLE ct_data.
*        ENDIF.
*      ENDLOOP.
*
** Text
*      CONCATENATE ls_rnmapped_entity '_txt' INTO lv_entity.
*      LOOP AT lt_attr_txt_usual INTO lv_field.
*        ls_data-entity = lv_entity.
*        ls_data-pp_structure = lv_struc_txt.
*        ls_data-fc_structure = lv_fc_structure.
*        ls_data-fp_structure = lv_fp_structure.
*        ls_data-is_disabled_entity = lv_disabled_entity.
*        ls_data-field_kind = 'not mapped'(006).
*        ls_data-to_field = lv_field.
*        READ TABLE lt_disabled_attr_txt_usual FROM lv_field TRANSPORTING NO FIELDS.
*        IF sy-subrc = 0.
*          ls_data-is_disabled_field = abap_true.
*        ELSE.
*          ls_data-is_disabled_field = abap_false.
*        ENDIF.
*
*********************************************************************************************
************************   Ignore TXTMI and MATNR_EXT from MATERIAL  ************************
************************   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  ************************
*********************************************************************************************
*        IF ( ls_data-to_field = 'MATNR_EXT' AND ls_data-entity = 'MATERIAL' ) OR
*           ( ls_data-to_field = 'TXTMI' AND ls_data-entity = 'MATERIAL' ).
*        ELSE.
*          INSERT ls_data INTO TABLE ct_data.
*        ENDIF.
*      ENDLOOP.
*    ENDLOOP.
*
*  ENDMETHOD.  "get_rest_nmflex_details_2sa

  METHOD check_multiple_field_mapping.
    CONSTANTS:
      lc_suffix         TYPE string VALUE '_TXT'.

    DATA:
      lt_data                       LIKE gt_data,
      lt_data_h                     LIKE gt_data,
      ls_data                       LIKE LINE OF gt_data,
      lv_entity                     TYPE usmd_entity,
      lv_entity_prev                TYPE usmd_entity,
      ls_data_prev                  LIKE LINE OF gt_data,
      lv_dummy                      TYPE string,
      lv_txt_prev                   TYPE boole_d,
      lv_txt                        TYPE boole_d,
      lv_is_key_prev                TYPE boole_d,
      lv_is_key                     TYPE boole_d,
      lt_attr_key                   TYPE mdg_bs_mat_t_smt_field,
      lt_txt_key                    TYPE mdg_bs_mat_t_smt_field,
      lt_attr_key_prev              TYPE mdg_bs_mat_t_smt_field,
      lt_txt_key_prev               TYPE mdg_bs_mat_t_smt_field,
      lv_message                    TYPE tys_message,
      lv_message_string             TYPE string ##needed .

    CLEAR:
     ls_data_prev.

    lt_data = it_data.

* Find multiple field-mapping
    CASE iv_map_to_pp.
      WHEN abap_true.
* Preparation. Remove irrelevant entries from lt_data
        LOOP AT lt_data INTO ls_data.
          IF   ls_data-entity IS INITIAL
            OR ls_data-to_field IS INITIAL
            OR ls_data-to_field = 'TDID'
            OR ls_data-to_field = 'NOTE'.
            DELETE lt_data.
          ENDIF.
        ENDLOOP.
        SORT lt_data BY to_field tstructure entity from_field.
        lt_data_h = lt_data.
        LOOP AT lt_data INTO ls_data_prev.
          DELETE lt_data_h INDEX 1.
          LOOP AT lt_data_h INTO ls_data.
            IF ls_data-to_field <> ls_data_prev-to_field OR ls_data-tstructure <> ls_data_prev-tstructure.
              EXIT.
            ELSEIF ls_data_prev-from_field IS NOT INITIAL AND ls_data-from_field IS NOT INITIAL.
* Output a warning message if not both from_fields are keys...
*--------------------------------------------------------------
* Get usual entity name: Rid of the suffix...
              SPLIT ls_data_prev-entity AT lc_suffix INTO lv_entity_prev lv_dummy.
              IF ls_data_prev-entity <> lv_entity_prev.
                lv_txt_prev = abap_true.
              ELSE.
                lv_txt_prev = abap_false.
              ENDIF.

              CALL METHOD cl_mdg_bs_mat_smt=>find_prop_entity
                EXPORTING
                  iv_respect_switch = 'X'
                  iv_entity         = lv_entity_prev
                IMPORTING
                  et_attr_key       = lt_attr_key_prev
                  et_txt_key        = lt_txt_key_prev.
* Get rid of the suffix
              SPLIT ls_data-entity AT lc_suffix INTO lv_entity lv_dummy.
              IF ls_data-entity <>  lv_entity.
                lv_txt = abap_true.
              ELSE.
                lv_txt = abap_false.
              ENDIF.
              CALL METHOD cl_mdg_bs_mat_smt=>find_prop_entity
                EXPORTING
                  iv_respect_switch = 'X'
                  iv_entity         = lv_entity
                IMPORTING
                  et_attr_key       = lt_attr_key
                  et_txt_key        = lt_txt_key.
* Is the from_field of  ls_data_prev a key-field?
              CLEAR  lv_is_key_prev.
              IF lv_txt_prev = abap_false.
                READ TABLE  lt_attr_key_prev FROM ls_data_prev-from_field TRANSPORTING NO FIELDS.
              ELSE.
                READ TABLE  lt_txt_key_prev FROM ls_data_prev-from_field TRANSPORTING NO FIELDS.
              ENDIF.
              IF sy-subrc = 0.
                lv_is_key_prev = abap_true.
              ENDIF.
* Is the from_field of  ls_data a key-field?
              CLEAR  lv_is_key.
              IF lv_txt = abap_false.
                READ TABLE  lt_attr_key FROM ls_data-from_field TRANSPORTING NO FIELDS.
              ELSE.
                READ TABLE  lt_txt_key FROM ls_data-from_field TRANSPORTING NO FIELDS.
              ENDIF.
              IF sy-subrc = 0.
                lv_is_key = abap_true.
              ENDIF.
              IF NOT ( lv_is_key = abap_true AND lv_is_key_prev = abap_true ).
                CLEAR lv_message.
                MESSAGE w018(mdg_bs_mat_tools) INTO lv_message_string
                   WITH ls_data_prev-from_field  ls_data-from_field  ls_data_prev-to_field.
                MOVE-CORRESPONDING sy TO lv_message.
                INSERT lv_message INTO TABLE ct_message.
              ENDIF.
            ELSE.
              CLEAR lv_message.
              MESSAGE w018(mdg_bs_mat_tools) INTO lv_message_string
                 WITH ls_data_prev-from_field  ls_data-from_field  ls_data_prev-to_field.
              MOVE-CORRESPONDING sy TO lv_message.
              INSERT lv_message INTO TABLE ct_message.
            ENDIF.
          ENDLOOP.
        ENDLOOP.
      WHEN abap_false.


* Preparation. Remove irrelevant entries from lt_data
        LOOP AT lt_data INTO ls_data.
          IF   ls_data-entity IS INITIAL
            OR ls_data-from_field IS INITIAL
            OR ls_data-from_field = 'NOTE'.
            DELETE lt_data.
          ENDIF.
        ENDLOOP.

        SORT lt_data BY from_field tstructure entity to_field.
        lt_data_h = lt_data.
        LOOP AT lt_data INTO ls_data_prev.
          DELETE lt_data_h INDEX 1.
          LOOP AT lt_data_h INTO ls_data.
            IF ls_data-from_field <> ls_data_prev-from_field OR ls_data-sstructure <> ls_data_prev-sstructure.
              EXIT.
            ELSEIF ls_data_prev-to_field IS NOT INITIAL AND ls_data-to_field IS NOT INITIAL.
* Output a warning message if not both from_fields are keys...
*--------------------------------------------------------------
* Get usual entity name: Rid of the suffix...
              SPLIT ls_data_prev-entity AT lc_suffix INTO lv_entity_prev lv_dummy.
              IF ls_data_prev-entity <> lv_entity_prev.
                lv_txt_prev = abap_true.
              ELSE.
                lv_txt_prev = abap_false.
              ENDIF.

              CALL METHOD cl_mdg_bs_mat_smt=>find_prop_entity
                EXPORTING
                  iv_respect_switch = 'X'
                  iv_entity         = lv_entity_prev
                IMPORTING
                  et_attr_key       = lt_attr_key_prev
                  et_txt_key        = lt_txt_key_prev.
* Get rid of the suffix
              SPLIT ls_data-entity AT lc_suffix INTO lv_entity lv_dummy.
              IF ls_data-entity <>  lv_entity.
                lv_txt = abap_true.
              ELSE.
                lv_txt = abap_false.
              ENDIF.
              CALL METHOD cl_mdg_bs_mat_smt=>find_prop_entity
                EXPORTING
                  iv_respect_switch = 'X'
                  iv_entity         = lv_entity
                IMPORTING
                  et_attr_key       = lt_attr_key
                  et_txt_key        = lt_txt_key.
* Is the from_field of  ls_data_prev a key-field?
              CLEAR  lv_is_key_prev.
              IF lv_txt_prev = abap_false.
                READ TABLE  lt_attr_key_prev FROM ls_data_prev-to_field TRANSPORTING NO FIELDS.
              ELSE.
                READ TABLE  lt_txt_key_prev FROM ls_data_prev-to_field TRANSPORTING NO FIELDS.
              ENDIF.
              IF sy-subrc = 0.
                lv_is_key_prev = abap_true.
              ENDIF.
* Is the from_field of  ls_data a key-field?
              CLEAR  lv_is_key.
              IF lv_txt = abap_false.
                READ TABLE  lt_attr_key FROM ls_data-to_field TRANSPORTING NO FIELDS.
              ELSE.
                READ TABLE  lt_txt_key FROM ls_data-to_field TRANSPORTING NO FIELDS.
              ENDIF.
              IF sy-subrc = 0.
                lv_is_key = abap_true.
              ENDIF.
              IF NOT ( lv_is_key = abap_true AND lv_is_key_prev = abap_true ).
                CLEAR lv_message.
                MESSAGE w018(mdg_bs_mat_tools) INTO lv_message_string
                   WITH ls_data_prev-to_field  ls_data-to_field  ls_data_prev-from_field.
                MOVE-CORRESPONDING sy TO lv_message.
                INSERT lv_message INTO TABLE ct_message.
              ENDIF.
            ELSE.
              CLEAR lv_message.
              MESSAGE w018(mdg_bs_mat_tools) INTO lv_message_string
                 WITH ls_data_prev-to_field  ls_data-to_field  ls_data_prev-from_field.
              MOVE-CORRESPONDING sy TO lv_message.
              INSERT lv_message INTO TABLE ct_message.
            ENDIF.
          ENDLOOP.
        ENDLOOP.
    ENDCASE.


  ENDMETHOD.  "check_multiple_field_mapping

ENDCLASS.                    "find_model_details IMPLEMENTATION
