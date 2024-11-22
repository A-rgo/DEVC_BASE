class YZ_CLAS_MDG_YZ_ACCESS definition
  public
  final
  create public

  global friends CL_MDG_BS_FND_ACCESS_SERVICES .

public section.

  interfaces IF_USMD_PP_ACCESS .
  interfaces IF_USMD_PP_BLOCKLIST .
  interfaces IF_USMD_PP_HANA_SEARCH .

  aliases CS_ACTIVITY
    for IF_USMD_PP_ACCESS~CS_ACTIVITY .
  aliases CS_KEY_HANDLING
    for IF_USMD_PP_ACCESS~CS_KEY_HANDLING .
  aliases D_FLDPROP_HIDDEN_SUPPORTED
    for IF_USMD_PP_ACCESS~D_FLDPROP_HIDDEN_SUPPORTED .
  aliases GC_CONTEXT_SAVE
    for IF_USMD_PP_ACCESS~GC_CONTEXT_SAVE .
  aliases MO_MODEL_EXT
    for IF_USMD_PP_BLOCKLIST~MO_MODEL_EXT .
  aliases ADAPT_RESULT_LIST
    for IF_USMD_PP_HANA_SEARCH~ADAPT_RESULT_LIST .
  aliases ADAPT_SEL_FIELDS
    for IF_USMD_PP_HANA_SEARCH~ADAPT_SEL_FIELDS .
  aliases ADAPT_WHERE_CLAUSE
    for IF_USMD_PP_HANA_SEARCH~ADAPT_WHERE_CLAUSE .
  aliases ADJUST_SELECTION_ATTR
    for IF_USMD_PP_ACCESS~ADJUST_SELECTION_ATTR .
  aliases CHECK_AUTHORITY
    for IF_USMD_PP_ACCESS~CHECK_AUTHORITY .
  aliases CHECK_AUTHORITY_MASS
    for IF_USMD_PP_ACCESS~CHECK_AUTHORITY_MASS .
  aliases CHECK_DATA
    for IF_USMD_PP_ACCESS~CHECK_DATA .
  aliases CHECK_EXISTENCE_MASS
    for IF_USMD_PP_ACCESS~CHECK_EXISTENCE_MASS .
  aliases DEQUEUE
    for IF_USMD_PP_ACCESS~DEQUEUE .
  aliases DERIVE_DATA
    for IF_USMD_PP_ACCESS~DERIVE_DATA .
  aliases DERIVE_DATA_ON_KEY_CHANGE
    for IF_USMD_PP_ACCESS~DERIVE_DATA_ON_KEY_CHANGE .
  aliases DISCARD_READ_BUFFER
    for IF_USMD_PP_ACCESS~DISCARD_READ_BUFFER .
  aliases ENQUEUE
    for IF_USMD_PP_ACCESS~ENQUEUE .
  aliases GET_BLOCKLIST_FOR_READ
    for IF_USMD_PP_BLOCKLIST~GET_BLOCKLIST_FOR_READ .
  aliases GET_BLOCKLIST_FOR_WRITE
    for IF_USMD_PP_BLOCKLIST~GET_BLOCKLIST_FOR_WRITE .
  aliases GET_CHANGE_DOCUMENT
    for IF_USMD_PP_ACCESS~GET_CHANGE_DOCUMENT .
  aliases GET_ENTITY_PROPERTIES
    for IF_USMD_PP_ACCESS~GET_ENTITY_PROPERTIES .
  aliases GET_FIELD_PROPERTIES
    for IF_USMD_PP_ACCESS~GET_FIELD_PROPERTIES .
  aliases GET_KEY_HANDLING
    for IF_USMD_PP_ACCESS~GET_KEY_HANDLING .
  aliases GET_MAPPING_CD
    for IF_USMD_PP_ACCESS~GET_MAPPING_CD .
  aliases GET_MAPPING_INFO
    for IF_USMD_PP_HANA_SEARCH~GET_MAPPING_INFO .
  aliases GET_QUERY_PROPERTIES
    for IF_USMD_PP_ACCESS~GET_QUERY_PROPERTIES .
  aliases GET_REUSE_VIEW_CONTENT
    for IF_USMD_PP_HANA_SEARCH~GET_REUSE_VIEW_CONTENT .
  aliases MERGE_REUSE_AUTHORIZATION
    for IF_USMD_PP_HANA_SEARCH~MERGE_REUSE_AUTHORIZATION .
  aliases QUERY
    for IF_USMD_PP_ACCESS~QUERY .
  aliases READ_VALUE
    for IF_USMD_PP_ACCESS~READ_VALUE .
  aliases SAVE
    for IF_USMD_PP_ACCESS~SAVE .
  aliases KEY_HANDLING
    for IF_USMD_PP_ACCESS~KEY_HANDLING .
  aliases S_TMP_KEY_MAP
    for IF_USMD_PP_ACCESS~S_TMP_KEY_MAP .
  aliases TS_TMP_KEY_MAP
    for IF_USMD_PP_ACCESS~TS_TMP_KEY_MAP .

  types:
    gty_t_yz_rule_d TYPE SORTED TABLE OF yzr_s_yz_pp_yz_rule_d WITH UNIQUE KEY def_id model otc rule_type .
  types:
    gty_t_yz_rule_e TYPE SORTED TABLE OF yzr_s_yz_pp_yz_rule_e WITH UNIQUE KEY def_id model otc rule_type exe_id rule_sec .
  types:
    gty_t_yz_rule_v TYPE SORTED TABLE OF yzr_s_yz_pp_yz_rule_v WITH UNIQUE KEY def_id model otc rule_type exe_id rule_sec val_id .

  class-data GT_YZ_RULE_D type GTY_T_YZ_RULE_D .
  class-data GT_YZ_RULE_E type GTY_T_YZ_RULE_E .
  class-data GT_YZ_RULE_V type GTY_T_YZ_RULE_V .
  class-data GC_MODEL type USMD_MODEL value 'YZ' ##NO_TEXT.
  data GC_BUSINESS_OBJECT type MDG_OBJECT_TYPE_CODE_BS value 'YZ_BO' ##NO_TEXT.
  data GR_HANA_SEARCH type ref to IF_USMD_PP_HANA_SEARCH .

  class-methods CLASS_CONSTRUCTOR .
  methods QUERY_ENTITY_DATA
    importing
      !I_ENTITY type USMD_ENTITY
      !IT_SEL type USMD_TS_SEL
      !IF_NO_AUTH_CHECK type USMD_FLG
      !I_SEARCH_HELP type SUBSHLP optional
      !I_NUM_ENTRIES type I default 0
    exporting
      !ET_DATA type ANY TABLE
      !ET_MESSAGE type USMD_T_MESSAGE
      !EF_NOT_SUPPORTED type USMD_FLG .
  class-methods SET_ENTITY_DATA
    importing
      !IO_CHANGED_DATA type ref to IF_USMD_DELTA_BUFFER_READ optional
      !IT_DATA type ANY TABLE optional
      !IV_ENTITY type USMD_ENTITY optional .
  class-methods SET_YZ_RULE_D
    importing
      !IT_DATA type ANY TABLE .
  class-methods SET_YZ_RULE_E
    importing
      !IT_DATA type ANY TABLE .
  class-methods SET_YZ_RULE_V
    importing
      !IT_DATA type ANY TABLE .
  class-methods GET_YZ_RULE_D
    exporting
      !ER_DATA type ref to DATA
    returning
      value(RT_YZ_RULE_D) type GTY_T_YZ_RULE_D .
  class-methods GET_YZ_RULE_E
    exporting
      !ER_DATA type ref to DATA
    returning
      value(RT_YZ_RULE_E) type GTY_T_YZ_RULE_E .
  class-methods GET_YZ_RULE_V
    exporting
      !ER_DATA type ref to DATA
    returning
      value(RT_YZ_RULE_V) type GTY_T_YZ_RULE_V .
  class-methods GET_INSTANCE
    returning
      value(RO_INSTANCE) type ref to YZ_CLAS_MDG_YZ_ACCESS .
protected section.

  class-data GT_REUSE_FMAP type MDG_HDB_TT_PP_FMAP .
  class-data GT_JOIN_CONDITIONS type MDG_HDB_TT_XML_JOIN_TABLE .
  class-data GO_INSTANCE type ref to YZ_CLAS_MDG_YZ_ACCESS .

  methods ENQUEUE_YZ_RULE_D
    importing
      !IV_SCOPE type CHAR1
      !IV_LOCK_TYPE type ENQMODE default 'E'
      !IT_VALUE type ANY TABLE
    exporting
      !CT_MESSAGE type USMD_T_MESSAGE .
  methods DERIVE_RULE_EXECUTION_DATA
    importing
      !IV_TEMP_ID type YZ_DTEL_TEMP_ID
      !IO_WRITE_DATA type ref to IF_USMD_DELTA_BUFFER_WRITE
    exporting
      !ET_MESSAGE_INFO type USMD_T_MESSAGE .
  methods SET_REUSE_MAPPING .
private section.

  class-methods DELIVER_ACCESS_CLASS_NAME
    returning
      value(RV_ACCESS_CLASS_NAME) type SEOCLSNAME .
ENDCLASS.



CLASS YZ_CLAS_MDG_YZ_ACCESS IMPLEMENTATION.


  METHOD DERIVE_RULE_EXECUTION_DATA.

    DATA: lr_exe_data_s TYPE REF TO data,
          lt_tmp_itm TYPE SORTED TABLE OF yztabl_temp_itm WITH NON-UNIQUE DEFAULT KEY. ""sorted internal table for fetching template execution rows

    FIELD-SYMBOLS <ft_exe_data> TYPE SORTED TABLE.

    IF io_write_data IS BOUND AND iv_temp_id IS NOT INITIAL.
      io_write_data->create_data_reference(
        EXPORTING
          i_entity     = 'YZ_RULE_E'                 " Entity Type
          i_struct     = 'KATTR'               " Type of Data Structure
        RECEIVING
          er_data      = DATA(lr_exe_data) ).

      ASSIGN lr_exe_data->* TO <ft_exe_data>.
      CREATE DATA lr_exe_data_s LIKE LINE OF <ft_exe_data>.
      ASSIGN lr_exe_data_s->* TO FIELD-SYMBOL(<fs_exe_data>). "work area for YZ_RULE_E data

      IF <fs_exe_data> IS ASSIGNED.
        DATA(lrs_exe_data) = NEW yzr_s_yz_pp_yz_rule_e( ).
        ASSIGN lrs_exe_data->* TO FIELD-SYMBOL(<ls_exe_data>).

        DATA(ls_rule_def) = gt_yz_rule_d[ 1 ].
        SELECT * FROM yztabl_temp_itm INTO TABLE @lt_tmp_itm WHERE temp_id = @iv_temp_id.
        IF sy-subrc = 0.
          LOOP AT lt_tmp_itm ASSIGNING FIELD-SYMBOL(<ls_tmp_itm>).

            <ls_exe_data>-model       = ls_rule_def-model.
            <ls_exe_data>-otc         = ls_rule_def-otc.
            <ls_exe_data>-rule_type   = ls_rule_def-rule_type.
            <ls_exe_data>-def_id      = ls_rule_def-def_id.
            <ls_exe_data>-rule_sec    = <ls_tmp_itm>-rule_sec.
            <ls_exe_data>-exe_id      = <ls_exe_data>-def_id && '_' && <ls_exe_data>-rule_sec && '_' &&
                                        yz_clas_mdg_accelerator=>get_nr_exe_id_for_rule( iv_def_id = <ls_exe_data>-def_id iv_rule_sec = <ls_exe_data>-rule_sec ).
            <ls_exe_data>-seq_no      = <ls_tmp_itm>-seq_no.
            <ls_exe_data>-task        = <ls_tmp_itm>-task.
            <ls_exe_data>-operation   = <ls_tmp_itm>-operation.
            <ls_exe_data>-entity      = <ls_tmp_itm>-entity.
            <ls_exe_data>-attribute   = <ls_tmp_itm>-attribute.
            <ls_exe_data>-exe_type    = <ls_tmp_itm>-exe_type.
            <ls_exe_data>-operator    = <ls_tmp_itm>-operator.
            <ls_exe_data>-class       = <ls_tmp_itm>-class.
            <ls_exe_data>-method      = <ls_tmp_itm>-method.
            <ls_exe_data>-active_e    = <ls_tmp_itm>-active.
            <ls_exe_data>-order_id    = sy-tabix.

            MOVE-CORRESPONDING <ls_exe_data> TO <fs_exe_data>.
            INSERT <fs_exe_data> INTO TABLE <ft_exe_data>.
          ENDLOOP.
          IF <ft_exe_data> IS ASSIGNED AND <ft_exe_data> IS NOT INITIAL.
            TRY.
                io_write_data->write_data(
                EXPORTING
                  i_entity     =  'YZ_RULE_E'                " Entity Type
                  it_data      = <ft_exe_data> ).
                  set_yz_rule_e( it_data = <ft_exe_data> ).
              CATCH cx_usmd_write_error INTO DATA(lv_usmd_write_error). " Error while writing to buffer
                DATA(lv_exception_text) = lv_usmd_write_error->get_text( ).
            ENDTRY.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDIF.



  ENDMETHOD.


  METHOD enqueue_yz_rule_d.

*  DATA:
*    lv_message        TYPE string.                          "#EC NEEDED
*
*  FIELD-SYMBOLS:
*    <ls_struc>        TYPE any,
*    <lv_carrid>       TYPE s_carr_id,
*    <lv_connid>       TYPE s_conn_id.
*
*  LOOP AT it_value ASSIGNING <ls_struc>.
*    ASSIGN COMPONENT gc_carr OF STRUCTURE <ls_struc> TO <lv_carrid>.
*    IF sy-subrc IS NOT INITIAL.
*      MESSAGE x106(mdg_sf).
*    ENDIF.
*
*    ASSIGN COMPONENT gc_pfli OF STRUCTURE <ls_struc> TO <lv_connid>.
*    IF sy-subrc IS NOT INITIAL.
*      MESSAGE x106(mdg_sf).
*    ENDIF.
*
**   For SPFLI exists a regular lock object
*    CALL FUNCTION 'ENQUEUE_ESSPFLI'
*      EXPORTING
*        mode_spfli     = iv_lock_type
*        mandt          = sy-mandt
*        carrid         = <lv_carrid>
*        connid         = <lv_connid>
*        _scope         = iv_scope
*      EXCEPTIONS
*        foreign_lock   = 1
*        system_failure = 2
*        OTHERS         = 3.
*
*    IF sy-subrc <> 0.
*      IF sy-subrc = 1.
*        MESSAGE e049(sv) WITH sy-msgv1 INTO lv_message.
*        add_last_message( CHANGING ct_message = ct_message ).
*      ELSE.
*        MESSAGE i104(mdg_sf) WITH 'YZ_RULE_D' sy-subrc INTO lv_message.
*        add_last_message( CHANGING ct_message = ct_message ).
*      ENDIF.
*    ENDIF.
*  ENDLOOP.

  ENDMETHOD.


  method GET_YZ_RULE_D.
    IF gt_yz_rule_d IS INITIAL.
*#Fallback API
      CALL METHOD yz_clas_mdg_utility=>read_entity(
        EXPORTING
          iv_entity   = 'YZ_RULE_D' " Entity Type
          iv_crequest = yz_clas_mdg_utility=>get_cr_number( )
          iv_readmode = '2'
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_yz_rule_d = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.

    ELSE.
      rt_yz_rule_d = gt_yz_rule_d.
    ENDIF.

    IF rt_yz_rule_d IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_yz_rule_d.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_yz_rule_d ).
    ENDIF.

  endmethod.


  method GET_YZ_RULE_E.

    IF gt_yz_rule_e IS INITIAL.
*#Fallback API
      CALL METHOD yz_clas_mdg_utility=>read_entity(
        EXPORTING
          iv_entity   = 'YZ_RULE_E' " Entity Type
          iv_crequest = yz_clas_mdg_utility=>get_cr_number( )
          iv_readmode = '2'
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_yz_rule_e = <ft_data>.
          rt_yz_rule_e = gt_yz_rule_e.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.

    ELSE.
      rt_yz_rule_e = gt_yz_rule_e.
    ENDIF.

  endmethod.


  method GET_YZ_RULE_V.

    IF gt_yz_rule_v IS INITIAL.
*#Fallback API
      CALL METHOD yz_clas_mdg_utility=>read_entity(
        EXPORTING
          iv_entity   = 'YZ_RULE_V' " Entity Type
          iv_crequest = yz_clas_mdg_utility=>get_cr_number( )
          iv_readmode = '2'
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_yz_rule_v = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.

    ELSE.
      rt_yz_rule_v = gt_yz_rule_v.
    ENDIF.

    IF rt_yz_rule_v IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_yz_rule_v.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_yz_rule_v ).
    ENDIF.

  endmethod.


  METHOD if_usmd_pp_access~adjust_selection_attr.
  ENDMETHOD.


  METHOD if_usmd_pp_access~check_authority.
  ENDMETHOD.


  METHOD if_usmd_pp_access~check_authority_mass.
  ENDMETHOD.


  METHOD if_usmd_pp_access~check_data.

    DATA lr_data            TYPE REF TO data.
    FIELD-SYMBOLS <ft_data> TYPE ANY TABLE.

    IF io_delta IS BOUND.

      io_delta->get_entity_types(
        IMPORTING
          et_entity_mod = DATA(lt_entity_mod)                 " List of Entity Types Containing New And/Or Changed Data
      ).

      LOOP AT lt_entity_mod INTO DATA(ls_entity_mod).
        io_delta->read_data(
        EXPORTING
          i_entity               = ls_entity_mod-entity       " Entity Type
            IMPORTING
              er_t_data_mod      = lr_data                    "Modified" Data Records (INSERT+UPDATE)
          ).
        ASSIGN lr_data->* TO <ft_data>.
        IF <ft_data> IS ASSIGNED.
          CASE ls_entity_mod-entity.
            WHEN 'YZ_RULE_D'.
              APPEND LINES OF
              yz_clas_mdg_accelerator=>process_yz_view_rule_def( EXPORTING iv_event_id = 'CR_CHECK' CHANGING ct_data = <ft_data> )
              TO  et_message.
            WHEN 'YZ_RULE_E'.
              APPEND LINES OF
              yz_clas_mdg_accelerator=>process_yz_view_rule_exe( EXPORTING iv_event_id = 'CR_CHECK' CHANGING ct_data = <ft_data> )
              TO  et_message.
            WHEN 'YZ_RULE_V'.
              APPEND LINES OF
              yz_clas_mdg_accelerator=>process_yz_view_rule_val( EXPORTING iv_event_id = 'CR_CHECK' CHANGING ct_data = <ft_data> )
              TO  et_message.
            WHEN 'YZ_RULE_T'.
              APPEND LINES OF
              yz_clas_mdg_accelerator=>process_yz_view_rule_tmp( EXPORTING iv_event_id = 'CR_CHECK' CHANGING ct_data = <ft_data> )
              TO  et_message.
            WHEN 'YZ_RULE_I'.
              APPEND LINES OF
              yz_clas_mdg_accelerator=>process_yz_view_temp_itm( EXPORTING iv_event_id = 'CR_CHECK' CHANGING ct_data = <ft_data> )
              TO  et_message.
          ENDCASE.
        ENDIF.
      ENDLOOP.

    ENDIF.

  ENDMETHOD.


  METHOD if_usmd_pp_access~check_existence_mass.
  ENDMETHOD.


  METHOD if_usmd_pp_access~dequeue.
  ENDMETHOD.


  METHOD if_usmd_pp_access~derive_data.

    IF io_changed_data IS BOUND.
      set_entity_data( io_changed_data = io_changed_data ).
      io_changed_data->get_entity_types( IMPORTING et_entity_mod = DATA(lt_entity_mod) ).
      CHECK gt_yz_rule_d IS NOT INITIAL.
      DATA(ls_def_data)  = gt_yz_rule_d[ 1 ].
      LOOP AT lt_entity_mod INTO DATA(ls_entity_mod). "WHERE struct = 'KATTR'.
        CHECK ls_entity_mod-struct EQ 'KATTR'.
        CASE ls_entity_mod-entity.
          WHEN 'YZ_RULE_D'.

            IF ls_def_data-temp_id IS NOT INITIAL AND gt_yz_rule_e IS INITIAL.

              derive_rule_execution_data( EXPORTING iv_temp_id      = ls_def_data-temp_id        " Rule Template ID
                                                    io_write_data   = io_write_data              " Write Interface to Data Buffer
                                          IMPORTING et_message_info = et_message_info ).         " Messages

            ENDIF.
          WHEN 'YZ_RULE_E'.

            IF lines( gt_yz_rule_e ) EQ 1 AND ls_def_data-temp_id IS INITIAL .
              DATA(lt_del_exe_data) = gt_yz_rule_e.
              derive_rule_execution_data( EXPORTING iv_temp_id     = COND #( WHEN ls_def_data-rule_type EQ 'VAL' THEN '0000000001'
                                                                             WHEN ls_def_data-rule_type EQ 'DER' THEN '0000000002'
                                                                             WHEN ls_def_data-rule_type EQ 'FLP' THEN '0000000003'
                                                                             WHEN ls_def_data-rule_type EQ 'UNV' THEN '0000000004'
                                                                             WHEN ls_def_data-rule_type EQ 'DYN' THEN '0000000005'
                                                                             WHEN ls_def_data-rule_type EQ 'UND' THEN '0000000006'
                                                                             WHEN ls_def_data-rule_type EQ 'CDB' THEN '0000000007'
                                                                             WHEN ls_def_data-rule_type EQ 'HID' THEN '0000000008' )       " Rule Template ID
                                                    io_write_data   = io_write_data              " Write Interface to Data Buffer
                                          IMPORTING et_message_info = et_message_info ).         " Messages
              IF et_message_info IS INITIAL.
                TRY.
                    io_write_data->delete_data(
                      EXPORTING
                        i_entity = 'YZ_RULE_E'                  " Entity Type
                        it_data  = lt_del_exe_data ).               " Key to be Deleted

                  CATCH cx_usmd_write_error INTO DATA(lv_usmd_write_error). " Error while writing to buffer
                    DATA(lv_exception_text) = lv_usmd_write_error->get_text( ).
                ENDTRY.
              ENDIF.

            ENDIF.

          WHEN OTHERS.
        ENDCASE.

      ENDLOOP.
    ENDIF.

  ENDMETHOD.


  METHOD if_usmd_pp_access~derive_data_on_key_change.
  ENDMETHOD.


  METHOD if_usmd_pp_access~discard_read_buffer.
  ENDMETHOD.


  METHOD if_usmd_pp_access~enqueue.
  ENDMETHOD.


  METHOD if_usmd_pp_access~get_change_document.
  ENDMETHOD.


  METHOD if_usmd_pp_access~get_entity_properties.
  ENDMETHOD.


  METHOD if_usmd_pp_access~get_field_properties.


    IF iv_entity EQ 'YZ_RULE_D' AND gt_yz_rule_e IS NOT INITIAL.
      LOOP AT ct_fld_prop_attr ASSIGNING FIELD-SYMBOL(<ls_ctfld>).
        IF <ls_ctfld> IS ASSIGNED.
          ASSIGN COMPONENT 'USMD_FP' OF STRUCTURE <ls_ctfld> TO FIELD-SYMBOL(<ls_usmd>).
          IF sy-subrc IS INITIAL AND <ls_usmd> IS ASSIGNED.
                 yz_clas_mdg_utility=>assign_to( EXPORTING component_name  = 'TEMP_ID'
                                                                    value  = 'R'
                                                 CHANGING structure        = <ls_usmd>  ).

          ENDIF.
        ENDIF.
      ENDLOOP.
    ENDIF.

  ENDMETHOD.


  METHOD if_usmd_pp_access~get_key_handling.
  ENDMETHOD.


  METHOD if_usmd_pp_access~get_mapping_cd.
  ENDMETHOD.


  METHOD if_usmd_pp_access~get_query_properties.
  ENDMETHOD.


  METHOD if_usmd_pp_access~query.

    CASE i_entity.
      WHEN 'YZ_RULE_D'.
        query_entity_data(
      EXPORTING
        i_entity         = i_entity                 " Entity Type
        it_sel           = it_sel                 " Sorted Table: Selection Condition (Range per Field)
        if_no_auth_check = if_no_auth_check                " MDGAF: General Indicator
        i_search_help    = i_search_help                 " Search help included in a collective search help
        i_num_entries    = i_num_entries
      IMPORTING
        et_data          = et_data
        et_message       = et_message                 " Messages
        ef_not_supported = ef_not_supported ).                " MDGAF: General Indicator

      WHEN 'YZ_RULE_E'.
        query_entity_data(
      EXPORTING
        i_entity         = i_entity                 " Entity Type
        it_sel           = it_sel                 " Sorted Table: Selection Condition (Range per Field)
        if_no_auth_check = if_no_auth_check                " MDGAF: General Indicator
        i_search_help    = i_search_help                 " Search help included in a collective search help
        i_num_entries    = i_num_entries
      IMPORTING
        et_data          = et_data
        et_message       = et_message                 " Messages
        ef_not_supported = ef_not_supported ).                " MDGAF: General Indicator

      WHEN 'YZ_RULE_V'.
        query_entity_data(
      EXPORTING
        i_entity         = i_entity                 " Entity Type
        it_sel           = it_sel                 " Sorted Table: Selection Condition (Range per Field)
        if_no_auth_check = if_no_auth_check                " MDGAF: General Indicator
        i_search_help    = i_search_help                 " Search help included in a collective search help
        i_num_entries    = i_num_entries
      IMPORTING
        et_data          = et_data
        et_message       = et_message                 " Messages
        ef_not_supported = ef_not_supported ).                " MDGAF: General Indicator

      WHEN 'YZ_RULE_T'.
        query_entity_data(
      EXPORTING
        i_entity         = i_entity                 " Entity Type
        it_sel           = it_sel                 " Sorted Table: Selection Condition (Range per Field)
        if_no_auth_check = if_no_auth_check                " MDGAF: General Indicator
        i_search_help    = i_search_help                 " Search help included in a collective search help
        i_num_entries    = i_num_entries
      IMPORTING
        et_data          = et_data
        et_message       = et_message                 " Messages
        ef_not_supported = ef_not_supported ).                " MDGAF: General Indicator

      WHEN 'YZ_RULE_I'.
        query_entity_data(
      EXPORTING
        i_entity         = i_entity                 " Entity Type
        it_sel           = it_sel                 " Sorted Table: Selection Condition (Range per Field)
        if_no_auth_check = if_no_auth_check                " MDGAF: General Indicator
        i_search_help    = i_search_help                 " Search help included in a collective search help
        i_num_entries    = i_num_entries
      IMPORTING
        et_data          = et_data
        et_message       = et_message                 " Messages
        ef_not_supported = ef_not_supported ).                " MDGAF: General Indicator

      WHEN OTHERS.
    ENDCASE.
  ENDMETHOD.


  METHOD if_usmd_pp_access~read_value.

    me->if_usmd_pp_access~query(
         EXPORTING
           i_entity         = i_entity
           it_sel           = it_sel
           if_no_auth_check = abap_true
         IMPORTING
           et_data          = et_data
           et_message       = et_message
       ).

  ENDMETHOD.


  METHOD if_usmd_pp_access~save.

    DATA:
      lt_rule_def_mod_data TYPE TABLE OF yzr_s_yz_pp_yz_rule_d,
      lt_rule_exe_mod_data TYPE TABLE OF yzr_s_yz_pp_yz_rule_e,
      lt_rule_exe_del      TYPE TABLE OF yzr_s_yz_pp_yz_rule_e,
      lt_rule_def_data     TYPE yzr_tt_rule_def,
      lt_rule_exe_data     TYPE yzr_tt_rule_exe,
      lt_rule_exe_del_data TYPE yzr_tt_rule_exe,
      ls_rule_def_data     LIKE LINE OF lt_rule_def_data,
      ls_rule_exe_data     LIKE LINE OF lt_rule_exe_data,
      ls_rule_exe_del_data LIKE LINE OF lt_rule_exe_del_data,
      lt_rule_val_mod_data TYPE TABLE OF yzr_s_yz_pp_yz_rule_v,
      lt_rule_val_del      TYPE TABLE OF yzr_s_yz_pp_yz_rule_v,
      lt_rule_val_data     TYPE yzr_tt_rule_val,
      ls_rule_val_data     LIKE LINE OF lt_rule_val_data,
      lt_rule_val_del_data TYPE yzr_tt_rule_val,
      ls_rule_val_del_data LIKE LINE OF lt_rule_val_del_data,
      lt_rule_tmp_mod_data TYPE TABLE OF yzr_s_yz_pp_yz_rule_t,
      lt_rule_imp_mod_data TYPE TABLE OF yzr_s_yz_pp_yz_rule_i,
      lt_rule_tmp_data     TYPE STANDARD TABLE OF yztabl_rule_tmp,
      lt_rule_imp_data     TYPE STANDARD TABLE OF yztabl_temp_itm,
      ls_rule_tmp_data     LIKE LINE OF lt_rule_tmp_data,
      ls_rule_imp_data     LIKE LINE OF lt_rule_imp_data.

    CLEAR:
      et_message,
      et_tmp_key_map.
*
* process data for entity type
    io_delta->get_entity_types( IMPORTING et_entity = DATA(lt_entity) ).

    LOOP AT lt_entity INTO DATA(ls_entity).
      io_delta->read_data(
        EXPORTING
          i_entity      = ls_entity                             " entity
          i_struct      = if_usmd_model_ext=>gc_struct_key_attr " keys and attributes
        IMPORTING
          er_t_data_del = DATA(lrt_rule_del)                     " deleted data
          er_t_data_mod = DATA(lrt_rule_mod) ).                  " Insert+Update

      CASE ls_entity.
        WHEN 'YZ_RULE_D'.
          IF lrt_rule_mod IS NOT INITIAL.
            ASSIGN lrt_rule_mod->* TO FIELD-SYMBOL(<lt_rule_def_mod>).
            IF sy-subrc IS INITIAL AND <lt_rule_def_mod> IS ASSIGNED.
              lt_rule_def_mod_data = CORRESPONDING #( <lt_rule_def_mod> ).
            ENDIF.
            IF lt_rule_def_mod_data IS NOT INITIAL.
              LOOP AT lt_rule_def_mod_data INTO DATA(ls_rule_def_mod_data).
                ls_rule_def_data-mandt     = sy-mandt.
                ls_rule_def_data-def_id    = ls_rule_def_mod_data-def_id.
                ls_rule_def_data-model     = ls_rule_def_mod_data-model.
                ls_rule_def_data-otc       = ls_rule_def_mod_data-otc.
                ls_rule_def_data-rule_type = ls_rule_def_mod_data-rule_type.
                ls_rule_def_data-active    = ls_rule_def_mod_data-active_d.
                ls_rule_def_data-def_ref1  = ls_rule_def_mod_data-def_ref1.
                ls_rule_def_data-refruleid = ls_rule_def_mod_data-refruleid.
                ls_rule_def_data-reuse_scp = ls_rule_def_mod_data-reuse_scp.
                ls_rule_def_data-rule_def  = ls_rule_def_mod_data-rule_def.
                ls_rule_def_data-rule_exp  = ls_rule_def_mod_data-rule_exp.
                ls_rule_def_data-rule_own  = ls_rule_def_mod_data-rule_own.
                ls_rule_def_data-rule_sta  = ls_rule_def_mod_data-rule_sta.
                ls_rule_def_data-temp_id   = ls_rule_def_mod_data-temp_id.
                APPEND ls_rule_def_data TO lt_rule_def_data.
                CLEAR ls_rule_def_data.
              ENDLOOP.
            ENDIF.
          ENDIF.

        WHEN 'YZ_RULE_E'.
          IF lrt_rule_mod IS NOT INITIAL.
            ASSIGN lrt_rule_mod->* TO FIELD-SYMBOL(<lt_rule_exe_mod>).
            IF sy-subrc IS INITIAL AND <lt_rule_exe_mod> IS ASSIGNED.
              lt_rule_exe_mod_data = CORRESPONDING #( <lt_rule_exe_mod> ).
            ENDIF.
            IF lt_rule_exe_mod_data IS NOT INITIAL.
              LOOP AT lt_rule_exe_mod_data INTO DATA(ls_rule_exe_mod_data).
                ls_rule_exe_data-mandt     = sy-mandt.
                ls_rule_exe_data-def_id    = ls_rule_exe_mod_data-def_id.
                ls_rule_exe_data-model     = ls_rule_exe_mod_data-model.
                ls_rule_exe_data-otc       = ls_rule_exe_mod_data-otc.
                ls_rule_exe_data-rule_type = ls_rule_exe_mod_data-rule_type.
                ls_rule_exe_data-exe_id    = ls_rule_exe_mod_data-exe_id.
                ls_rule_exe_data-exe_type  = ls_rule_exe_mod_data-exe_type.
                ls_rule_exe_data-rule_sec  = ls_rule_exe_mod_data-rule_sec.
                ls_rule_exe_data-active    = ls_rule_exe_mod_data-active_e.
                ls_rule_exe_data-entity    = ls_rule_exe_mod_data-entity.
                ls_rule_exe_data-attribute = ls_rule_exe_mod_data-attribute.
                ls_rule_exe_data-class     = ls_rule_exe_mod_data-class.
                ls_rule_exe_data-method    = ls_rule_exe_mod_data-method.
                ls_rule_exe_data-temp_id   = ls_rule_exe_mod_data-etemp_id.
                ls_rule_exe_data-operation = ls_rule_exe_mod_data-operation.
                ls_rule_exe_data-operator  = ls_rule_exe_mod_data-operator.
                ls_rule_exe_data-seq_no    = ls_rule_exe_mod_data-seq_no.
                ls_rule_exe_data-task      = ls_rule_exe_mod_data-task.
                ls_rule_exe_data-order_id  = ls_rule_exe_mod_data-order_id.
                APPEND ls_rule_exe_data TO lt_rule_exe_data.
                CLEAR ls_rule_exe_data.
              ENDLOOP.
            ENDIF.
          ENDIF.

          IF lrt_rule_del IS NOT INITIAL.
            ASSIGN lrt_rule_del->* TO FIELD-SYMBOL(<lt_rule_exe_del>).
            IF sy-subrc IS INITIAL AND <lt_rule_exe_del> IS ASSIGNED.
              lt_rule_exe_del = CORRESPONDING #( <lt_rule_exe_del> ).
            ENDIF.
            IF lt_rule_exe_del IS NOT INITIAL.
              LOOP AT lt_rule_exe_del INTO DATA(ls_rule_exe_del).
                ls_rule_exe_del_data-mandt     = sy-mandt.
                ls_rule_exe_del_data-def_id    = ls_rule_exe_del-def_id.
                ls_rule_exe_del_data-model     = ls_rule_exe_del-model.
                ls_rule_exe_del_data-otc       = ls_rule_exe_del-otc.
                ls_rule_exe_del_data-rule_type = ls_rule_exe_del-rule_type.
                ls_rule_exe_del_data-exe_id    = ls_rule_exe_del-exe_id.
                ls_rule_exe_del_data-exe_type  = ls_rule_exe_del-exe_type.
                ls_rule_exe_del_data-rule_sec  = ls_rule_exe_del-rule_sec.
                ls_rule_exe_del_data-active    = ls_rule_exe_del-active_e.
                ls_rule_exe_del_data-entity    = ls_rule_exe_del-entity.
                ls_rule_exe_del_data-attribute = ls_rule_exe_del-attribute.
                ls_rule_exe_del_data-class     = ls_rule_exe_del-class.
                ls_rule_exe_del_data-method    = ls_rule_exe_del-method.
                ls_rule_exe_del_data-temp_id   = ls_rule_exe_del-etemp_id.
                ls_rule_exe_del_data-operation = ls_rule_exe_del-operation.
                ls_rule_exe_del_data-operator  = ls_rule_exe_del-operator.
                ls_rule_exe_del_data-seq_no    = ls_rule_exe_del-seq_no.
                ls_rule_exe_del_data-task      = ls_rule_exe_del-task.
                ls_rule_exe_del_data-order_id  = ls_rule_exe_del-order_id.
                APPEND ls_rule_exe_del_data TO lt_rule_exe_del_data.
                CLEAR: ls_rule_exe_del, ls_rule_exe_del_data.
              ENDLOOP.
            ENDIF.
          ENDIF.

        WHEN 'YZ_RULE_V'.
          IF lrt_rule_del IS NOT INITIAL.
            ASSIGN lrt_rule_del->* TO FIELD-SYMBOL(<lt_rule_val_del>).
            IF sy-subrc IS INITIAL AND <lt_rule_val_del> IS ASSIGNED.
              lt_rule_val_del = CORRESPONDING #( <lt_rule_val_del> ).
            ENDIF.
            IF lt_rule_val_del IS NOT INITIAL.
              LOOP AT lt_rule_val_del INTO DATA(ls_rule_val_del).
                ls_rule_val_del_data-mandt     = sy-mandt.
                ls_rule_val_del_data-def_id    = ls_rule_val_del-def_id.
                ls_rule_val_del_data-model     = ls_rule_val_del-model.
                ls_rule_val_del_data-otc       = ls_rule_val_del-otc.
                ls_rule_val_del_data-rule_type = ls_rule_val_del-rule_type.
                ls_rule_val_del_data-exe_id    = ls_rule_val_del-exe_id.
                ls_rule_val_del_data-rule_sec  = ls_rule_val_del-rule_sec.
                ls_rule_val_del_data-val_id    = ls_rule_val_del-val_id.
                ls_rule_val_del_data-active    = ls_rule_val_del-active_v.
                ls_rule_val_del_data-high      = ls_rule_val_del-high.
                ls_rule_val_del_data-low       = ls_rule_val_del-low.
                ls_rule_val_del_data-opt       = ls_rule_val_del-opt.
                ls_rule_val_del_data-sign      = ls_rule_val_del-sign.
                ls_rule_val_del_data-val_type  = ls_rule_val_del-val_type.
                APPEND ls_rule_val_del_data TO lt_rule_val_del_data.
                CLEAR: ls_rule_val_del_data, ls_rule_val_del.
              ENDLOOP.
            ENDIF.
          ENDIF.

          IF lrt_rule_mod IS NOT INITIAL.
            ASSIGN lrt_rule_mod->* TO FIELD-SYMBOL(<lt_rule_val_mod>).
            IF sy-subrc IS INITIAL AND <lt_rule_val_mod> IS ASSIGNED.
              lt_rule_val_mod_data = CORRESPONDING #( <lt_rule_val_mod> ).
            ENDIF.
            IF lt_rule_val_mod_data IS NOT INITIAL.
              LOOP AT lt_rule_val_mod_data INTO DATA(ls_rule_val_mod_data).
                ls_rule_val_data-mandt     = sy-mandt.
                ls_rule_val_data-def_id    = ls_rule_val_mod_data-def_id.
                ls_rule_val_data-model     = ls_rule_val_mod_data-model.
                ls_rule_val_data-otc       = ls_rule_val_mod_data-otc.
                ls_rule_val_data-rule_type = ls_rule_val_mod_data-rule_type.
                ls_rule_val_data-exe_id    = ls_rule_val_mod_data-exe_id.
                ls_rule_val_data-rule_sec  = ls_rule_val_mod_data-rule_sec.
                ls_rule_val_data-val_id    = ls_rule_val_mod_data-val_id.
                ls_rule_val_data-active    = ls_rule_val_mod_data-active_v.
                ls_rule_val_data-high      = ls_rule_val_mod_data-high.
                ls_rule_val_data-low       = ls_rule_val_mod_data-low.
                ls_rule_val_data-opt       = ls_rule_val_mod_data-opt.
                ls_rule_val_data-sign      = ls_rule_val_mod_data-sign.
                ls_rule_val_data-val_type  = ls_rule_val_mod_data-val_type.
                APPEND ls_rule_val_data TO lt_rule_val_data.
                CLEAR ls_rule_val_data.
              ENDLOOP.
            ENDIF.
          ENDIF.

        WHEN 'YZ_RULE_T'.
          IF lrt_rule_mod IS NOT INITIAL.
            ASSIGN lrt_rule_mod->* TO FIELD-SYMBOL(<lt_rule_tmp_mod>).
            IF sy-subrc IS INITIAL AND <lt_rule_tmp_mod> IS ASSIGNED.
              lt_rule_tmp_mod_data = CORRESPONDING #( <lt_rule_tmp_mod> ).
            ENDIF.
            IF lt_rule_tmp_mod_data IS NOT INITIAL.
              LOOP AT lt_rule_tmp_mod_data INTO DATA(ls_rule_tmp_mod_data).
                ls_rule_tmp_data-mandt     = sy-mandt.
                ls_rule_tmp_data-temp_id   = ls_rule_tmp_mod_data-tmp_id.
                ls_rule_tmp_data-model     = ls_rule_tmp_mod_data-model_t.
                ls_rule_tmp_data-otc       = ls_rule_tmp_mod_data-otc_t.
                ls_rule_tmp_data-rule_type = ls_rule_tmp_mod_data-rtype_t.
                ls_rule_tmp_data-active    = ls_rule_tmp_mod_data-active_t.
                ls_rule_tmp_data-temp_desc = ls_rule_tmp_mod_data-tmp_desc.
                APPEND ls_rule_tmp_data TO lt_rule_tmp_data.
                CLEAR ls_rule_tmp_data.
              ENDLOOP.
            ENDIF.
          ENDIF.
        WHEN 'YZ_RULE_I'.
          IF lrt_rule_mod IS NOT INITIAL.
            ASSIGN lrt_rule_mod->* TO FIELD-SYMBOL(<lt_rule_imp_mod>).
            IF sy-subrc IS INITIAL AND <lt_rule_tmp_mod> IS ASSIGNED.
              lt_rule_imp_mod_data = CORRESPONDING #( <lt_rule_imp_mod> ).
            ENDIF.
            IF lt_rule_imp_mod_data IS NOT INITIAL.
              LOOP AT lt_rule_imp_mod_data INTO DATA(ls_rule_imp_mod_data).
                ls_rule_imp_data-mandt     = sy-mandt.
                ls_rule_imp_data-temp_id   = ls_rule_imp_mod_data-tmp_id.
                ls_rule_imp_data-model     = ls_rule_imp_mod_data-model_t.
                ls_rule_imp_data-otc       = ls_rule_imp_mod_data-otc_t.
                ls_rule_imp_data-rule_type = ls_rule_imp_mod_data-rtype_t.
                ls_rule_imp_data-active    = ls_rule_imp_mod_data-active_i.
                ls_rule_imp_data-exe_id    = ls_rule_imp_mod_data-exe_id.
                ls_rule_imp_data-rule_sec  = ls_rule_imp_mod_data-rule_sec.
                ls_rule_imp_data-attribute = ls_rule_imp_mod_data-attr_t.
                ls_rule_imp_data-class     = ls_rule_imp_mod_data-class_t.
                ls_rule_imp_data-entity    = ls_rule_imp_mod_data-entity_t.
                ls_rule_imp_data-exe_type  = ls_rule_imp_mod_data-exetype_t.
                ls_rule_imp_data-method    = ls_rule_imp_mod_data-method_t.
                ls_rule_imp_data-operation = ls_rule_imp_mod_data-opraton_t.
                ls_rule_imp_data-operator  = ls_rule_imp_mod_data-oprator_t.
                ls_rule_imp_data-seq_no    = ls_rule_imp_mod_data-seq_no_t.
                ls_rule_imp_data-task      = ls_rule_imp_mod_data-task_t.

                APPEND ls_rule_imp_data TO lt_rule_imp_data.
                CLEAR ls_rule_imp_data.
              ENDLOOP.
            ENDIF.
          ENDIF.
      ENDCASE.
    ENDLOOP.

    IF lt_rule_def_data IS NOT INITIAL OR lt_rule_exe_data IS NOT INITIAL OR lt_rule_val_data IS NOT INITIAL OR lt_rule_exe_del_data IS NOT INITIAL OR lt_rule_val_del_data IS NOT INITIAL.
      CALL FUNCTION 'YZ_FUNC_RULE_UPDATE' IN UPDATE TASK
        EXPORTING
          it_rule_def_data     = lt_rule_def_data
          it_rule_exe_data     = lt_rule_exe_data
          it_rule_val_data     = lt_rule_val_data
          it_rule_exe_del_data = lt_rule_exe_del_data
          it_rule_val_del_data = lt_rule_val_del_data.

    ENDIF.

    IF lt_rule_tmp_data IS NOT INITIAL OR lt_rule_imp_data IS NOT INITIAL .
      CALL FUNCTION 'YZ_FUNC_TEMP_UPDATE' IN UPDATE TASK
        EXPORTING
          it_rule_tmp_data = lt_rule_tmp_data
          it_rule_imp_data = lt_rule_imp_data.

    ENDIF.




  ENDMETHOD.


  METHOD if_usmd_pp_blocklist~get_blocklist_for_read.
  ENDMETHOD.


  METHOD if_usmd_pp_blocklist~get_blocklist_for_write.
  ENDMETHOD.


  METHOD if_usmd_pp_hana_search~adapt_result_list.

*  CALL METHOD go_instance->if_usmd_pp_hana_search~adapt_result_list
*    EXPORTING
*      is_search_context          = is_search_context
*      ir_staging_struct_type_ref = ir_staging_struct_type_ref
*      it_reuse_data              = it_reuse_data
*      it_reuse_data_mdg_names    = it_reuse_data_mdg_names
*    IMPORTING
*      et_data                    = et_data.

*    """Added by Ram
    CLEAR et_data.
    et_data = it_reuse_data_mdg_names.
    LOOP AT et_data ASSIGNING FIELD-SYMBOL(<fs_data>).
      <fs_data>-f_active = 1.
    ENDLOOP.

  ENDMETHOD.


  METHOD if_usmd_pp_hana_search~adapt_sel_fields.

*  CALL METHOD go_instance->if_usmd_pp_hana_search~adapt_sel_fields
*    EXPORTING
*      iv_model          = iv_model
*      iv_main_entity    = iv_main_entity
*    CHANGING
*      ct_sel_attributes = ct_sel_attributes.

*    IF gr_hana_search IS BOUND.
*      CALL METHOD gr_hana_search->adapt_sel_fields
*        EXPORTING
*          iv_model          = iv_model
*          iv_main_entity    = iv_main_entity
*        CHANGING
*          ct_sel_attributes = ct_sel_attributes.
*    ENDIF.

  ENDMETHOD.


  METHOD if_usmd_pp_hana_search~adapt_where_clause.

   CALL METHOD go_instance->if_usmd_pp_hana_search~adapt_where_clause
    EXPORTING
      is_search_context    = is_search_context
      it_search_attributes = it_search_attributes
    CHANGING
      cv_where_clause      = cv_where_clause.

  ENDMETHOD.


  METHOD if_usmd_pp_hana_search~get_mapping_info.


*  CALL METHOD go_instance->if_usmd_pp_hana_search~get_mapping_info
*    EXPORTING
*      is_search_context = is_search_context
*    IMPORTING
*      et_messages       = et_messages
*    CHANGING
*      ct_mapping_info   = ct_mapping_info.


**    """Added by Naveen
**
*    IF gr_hana_search IS BOUND.
*      CALL METHOD gr_hana_search->get_mapping_info
*        EXPORTING
*          is_search_context = is_search_context    " Search Context
*        IMPORTING
*          et_messages       = et_messages    " Messages
*        CHANGING
*          ct_mapping_info   = ct_mapping_info.
*    ENDIF.
*
*
*    DATA:
*      ls_message TYPE usmd_s_message.
*
*    FIELD-SYMBOLS:
*      <ls_reuse_fmap>   LIKE LINE OF gt_reuse_fmap,
*      <ls_mapping_info> LIKE LINE OF ct_mapping_info.
*
*    CLEAR et_messages.
*
*    IF is_search_context-entity_main EQ 'YZ_RULE_D'.
*      me->set_reuse_mapping( ).
*    ELSE.
*      RETURN.
*    ENDIF.
*
** Add reuse field name
*    LOOP AT ct_mapping_info ASSIGNING <ls_mapping_info>
*      WHERE reuse_view_fieldname IS INITIAL.
*
*      READ TABLE gt_reuse_fmap
*        WITH KEY model           = gc_model
*                 entity          = <ls_mapping_info>-entity
*                 model_fieldname = <ls_mapping_info>-model_fieldname
*       ASSIGNING <ls_reuse_fmap>.
*      IF sy-subrc IS INITIAL.
*        MOVE-CORRESPONDING <ls_reuse_fmap>   TO <ls_mapping_info>.
*        <ls_mapping_info>-reuse_view_fieldname = <ls_reuse_fmap>-reuse_fieldname.
**        IF <ls_mapping_info>-model_fieldname = 'DEF_ID'.
**          <ls_mapping_info>-reuse_view_fieldname = 'DEF_ID'.
**          <ls_mapping_info>-reuse_rollname = 'YZ_DTEL_DEF_ID'.
**        ELSEIF <ls_mapping_info>-model_fieldname = 'MODEL'.
**          <ls_mapping_info>-reuse_view_fieldname = 'MODEL'.
**          <ls_mapping_info>-reuse_rollname = 'YZ_DTEL_USMD_MODEL'.
**        ELSEIF <ls_mapping_info>-model_fieldname = 'OTC'.
**          <ls_mapping_info>-reuse_view_fieldname = 'OTC'.
**          <ls_mapping_info>-reuse_rollname = 'YZ_DTEL_SOURCE_OTC'.
**        ELSEIF <ls_mapping_info>-model_fieldname = 'RULE_TYPE'.
**          <ls_mapping_info>-reuse_view_fieldname = 'RULE_TYPE'.
**          <ls_mapping_info>-reuse_rollname = 'YZ_DTEL_RULE_TYPE'.
**        ENDIF.
**        <ls_mapping_info>-reuse_view_fieldname = <ls_reuse_fmap>-reuse_fieldname
**        IF <ls_reuse_fmap>-deviating_fieldname IS INITIAL.
**          <ls_mapping_info>-reuse_view_fieldname = <ls_reuse_fmap>-reuse_fieldname.
**        ELSE.
**          <ls_mapping_info>-reuse_view_fieldname = <ls_reuse_fmap>-deviating_fieldname.
**        ENDIF.
*      ELSE.
*      ENDIF.
*    ENDLOOP.


  ENDMETHOD.


  METHOD if_usmd_pp_hana_search~get_reuse_view_content.


*  CALL METHOD go_instance->if_usmd_pp_hana_search~get_reuse_view_content
*    EXPORTING
*      iv_model            = iv_model
*      iv_main_entity      = iv_main_entity
*      it_entities         = it_entities
*      it_model_attributes = it_model_attributes
*    IMPORTING
*      ev_main_table       = ev_main_table
*      et_join_conditions  = et_join_conditions
*      et_reuse_attributes = et_reuse_attributes
*      et_messages         = et_messages.

*    """Added by Ram
*    IF gr_hana_search IS BOUND.
*      CALL METHOD gr_hana_search->get_reuse_view_content
*        EXPORTING
*          iv_model            = iv_model
*          iv_main_entity      = iv_main_entity
*          it_entities         = it_entities
*          it_model_attributes = it_model_attributes
*        IMPORTING
*          ev_main_table       = ev_main_table
*          et_join_conditions  = et_join_conditions
*          et_reuse_attributes = et_reuse_attributes
*          et_messages         = et_messages.
*    ENDIF.

*    TYPES:
*      BEGIN OF ty_reuse_table,
*        table TYPE usmd_tab_source,
*      END OF ty_reuse_table .
*
*    TYPES:
*      tty_reuse_table TYPE SORTED TABLE OF ty_reuse_table
*                  WITH UNIQUE KEY table .
*
*    DATA:
*      lv_keyflag          TYPE c,
*      ls_message          TYPE usmd_s_message,
*      lt_reuse_table      TYPE tty_reuse_table,
*      ls_reuse_table      LIKE LINE OF lt_reuse_table,
*      ls_reuse_attributes LIKE LINE OF et_reuse_attributes.
*
*    FIELD-SYMBOLS:
*      <ls_model_attributes> LIKE LINE OF it_model_attributes,
*      <ls_reuse_fmap>       LIKE LINE OF gt_reuse_fmap,
*      <ls_reuse_attributes> LIKE LINE OF et_reuse_attributes.
*
*    CLEAR:
*      ev_main_table,
*      et_join_conditions,
*      et_reuse_attributes,
*      et_messages.
*
*    IF iv_main_entity EQ 'YZ_RULE_D'.
*      me->set_reuse_mapping( ).
*    ELSE.
*      RETURN.
*    ENDIF.
*
*    ev_main_table = 'YZTABL_R_DEF'.
*
*    LOOP AT it_model_attributes ASSIGNING <ls_model_attributes>.
*      READ TABLE gt_reuse_fmap
*       ASSIGNING <ls_reuse_fmap>
*        WITH KEY model           = gc_model
*                 entity          = <ls_model_attributes>-usmd_entity
*                 model_fieldname = <ls_model_attributes>-fieldname.
*      IF sy-subrc IS INITIAL.
*        ls_reuse_table-table = <ls_reuse_fmap>-reuse_table.
*        INSERT ls_reuse_table INTO TABLE lt_reuse_table.
*
*        CLEAR ls_reuse_attributes.
*        MOVE-CORRESPONDING <ls_reuse_fmap> TO ls_reuse_attributes.
*        ls_reuse_attributes-rollname = <ls_reuse_fmap>-reuse_rollname.
*
*        INSERT ls_reuse_attributes INTO TABLE et_reuse_attributes.
*      ELSE.
*
*      ENDIF.
*    ENDLOOP.
*
** set key flags
*    LOOP AT et_reuse_attributes ASSIGNING <ls_reuse_attributes>.
*      SELECT SINGLE keyflag FROM dd03l INTO lv_keyflag
*        WHERE tabname   = <ls_reuse_attributes>-reuse_table
*          AND fieldname = <ls_reuse_attributes>-reuse_fieldname "#EC CI_NOORDER
*.
*      IF sy-subrc IS INITIAL.
*        <ls_reuse_attributes>-is_key = lv_keyflag.
*      ENDIF.
*    ENDLOOP.
*
*** GET join conditions
**    IF lt_reuse_table IS NOT INITIAL.
**      et_join_conditions = me->get_join_conditions( it_reuse_table = lt_reuse_table ).
**    ENDIF.

  ENDMETHOD.


  METHOD if_usmd_pp_hana_search~merge_reuse_authorization.
  ENDMETHOD.


  METHOD query_entity_data.
* Initialize output
    CLEAR:
      et_data,
      et_message,
      ef_not_supported.

    DATA lr_tmp_data    TYPE REF TO yzr_s_yz_pp_yz_rule_t.
    CREATE DATA lr_tmp_data TYPE yzr_s_yz_pp_yz_rule_t.
    ASSIGN lr_tmp_data->* TO FIELD-SYMBOL(<fs_tmp_data>).

    DATA lr_itm_data    TYPE REF TO yzr_s_yz_pp_yz_rule_i.
    CREATE DATA lr_itm_data TYPE yzr_s_yz_pp_yz_rule_i.
    ASSIGN lr_itm_data->* TO FIELD-SYMBOL(<fs_itm_data>).

    DATA lr_data         TYPE REF TO data.
    CREATE DATA lr_data  LIKE LINE OF et_data.
    ASSIGN lr_data->* TO FIELD-SYMBOL(<ls_data>).


    CASE i_entity.
      WHEN 'YZ_RULE_D'.
        SELECT sign,option,low,high FROM @it_sel AS lt_sel WHERE fieldname =: 'DEF_ID'    INTO TABLE @DATA(lrt_sel_def_id),
                                                                              'MODEL'     INTO TABLE @DATA(lrt_sel_model),
                                                                              'RULE_TYPE' INTO TABLE @DATA(lrt_sel_rule_type),
                                                                              'OTC'       INTO TABLE @DATA(lrt_sel_otc).

        IF ( lrt_sel_def_id IS INITIAL AND lrt_sel_model IS INITIAL AND lrt_sel_otc IS INITIAL AND lrt_sel_rule_type IS INITIAL AND
             it_sel IS NOT INITIAL ).
*   no supported search attribute
*          RETURN. "++Naveen
          """ SOC Adding by Naveen
          SELECT sign,option,low,high FROM @it_sel AS lt_sel1 WHERE fieldname =: 'VAL_ID' INTO TABLE @DATA(lrt_sel_val_id_1),
                                                                                 'EXE_ID'    INTO TABLE @DATA(lrt_sel_exe_id_1),
                                                                                 'RULE_SEC'  INTO TABLE @DATA(lrt_sel_rule_sec_1).
*            * Select data from rule definition table
          SELECT * FROM yztabl_rule_val UP TO @i_num_entries ROWS INTO TABLE @DATA(lt_rule_val_data1)
            WHERE val_id   IN @lrt_sel_val_id_1 AND exe_id IN @lrt_sel_exe_id_1 AND rule_sec IN @lrt_sel_rule_sec_1
          ORDER BY PRIMARY KEY.

* Transfer from SCARR format into ET_DATA format
          LOOP AT lt_rule_val_data1 ASSIGNING FIELD-SYMBOL(<fs_val_result1>).

            MOVE-CORRESPONDING <fs_val_result1> TO <ls_data>.
            ASSIGN COMPONENT 'ACTIVE_V' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_active_v>).
            IF <lv_active_v> IS ASSIGNED.
              <lv_active_v> = <fs_val_result1>-active.
            ENDIF.
            INSERT <ls_data> INTO TABLE et_data.
            CLEAR <ls_data>.
          ENDLOOP.
*        ENDIF.   ++Naveen
        ELSE.
          """ EOC Adding by Naveen
* Select data from rule definition table
          SELECT * FROM yztabl_rule_def UP TO @i_num_entries ROWS INTO TABLE @DATA(lt_rule_def_data)
            WHERE def_id    IN @lrt_sel_def_id
              AND model     IN @lrt_sel_model
              AND otc       IN @lrt_sel_otc
              AND rule_type IN @lrt_sel_rule_type
              ORDER BY PRIMARY KEY.

* Transfer from SCARR format into ET_DATA format
          LOOP AT lt_rule_def_data ASSIGNING FIELD-SYMBOL(<fs_def_result>).

            MOVE-CORRESPONDING <fs_def_result> TO <ls_data>.
            ASSIGN COMPONENT 'ACTIVE_D' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_active_d>).
            IF <lv_active_d> IS ASSIGNED.
              <lv_active_d> = <fs_def_result>-active.
            ENDIF.
            INSERT <ls_data> INTO TABLE et_data.
            CLEAR <ls_data>.
          ENDLOOP.
        ENDIF.
      WHEN 'YZ_RULE_E'.
        SELECT sign,option,low,high FROM @it_sel AS lt_sel WHERE fieldname =: 'DEF_ID'    INTO TABLE @lrt_sel_def_id,
                                                                              'MODEL'     INTO TABLE @lrt_sel_model,
                                                                              'RULE_TYPE' INTO TABLE @lrt_sel_rule_type,
                                                                              'OTC'       INTO TABLE @lrt_sel_otc,
                                                                              'EXE_ID'    INTO TABLE @DATA(lrt_sel_exe_id),
                                                                              'RULE_SEC'  INTO TABLE @DATA(lrt_sel_rule_sec).

        IF ( lrt_sel_def_id IS INITIAL AND lrt_sel_model IS INITIAL AND lrt_sel_otc IS INITIAL
         AND lrt_sel_rule_type IS INITIAL AND lrt_sel_exe_id IS INITIAL AND lrt_sel_rule_sec IS INITIAL
             AND it_sel IS NOT INITIAL ).
*   no supported search attribute
          RETURN.
        ENDIF.

* Select data from rule exe table
        SELECT * FROM yztabl_rule_exe UP TO @i_num_entries ROWS INTO TABLE @DATA(lt_rule_exe_data)
          WHERE def_id    IN @lrt_sel_def_id
            AND model     IN @lrt_sel_model
            AND otc       IN @lrt_sel_otc
            AND rule_type IN @lrt_sel_rule_type
            AND exe_id    IN @lrt_sel_exe_id
            AND rule_sec  IN @lrt_sel_rule_sec
            ORDER BY PRIMARY KEY.
        SORT lt_rule_exe_data BY order_id.
* Transfer from SCARR format into ET_DATA format
        LOOP AT lt_rule_exe_data ASSIGNING FIELD-SYMBOL(<fs_exe_result>).

          MOVE-CORRESPONDING <fs_exe_result> TO <ls_data>.
          ASSIGN COMPONENT 'ACTIVE_E' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_active_e>).
          IF <lv_active_e> IS ASSIGNED.
            <lv_active_e> = <fs_exe_result>-active.
          ENDIF.
          INSERT <ls_data> INTO TABLE et_data.
          CLEAR <ls_data>.
        ENDLOOP.

      WHEN 'YZ_RULE_V'.
        SELECT sign,option,low,high FROM @it_sel AS lt_sel WHERE fieldname =: 'DEF_ID'    INTO TABLE @lrt_sel_def_id,
                                                                              'MODEL'     INTO TABLE @lrt_sel_model,
                                                                              'RULE_TYPE' INTO TABLE @lrt_sel_rule_type,
                                                                              'OTC'       INTO TABLE @lrt_sel_otc,
                                                                              'EXE_ID'    INTO TABLE @lrt_sel_exe_id,
                                                                              'RULE_SEC'  INTO TABLE @lrt_sel_rule_sec,
                                                                              'VAL_ID'    INTO TABLE @DATA(lrt_sel_val_id).

        IF ( lrt_sel_def_id IS INITIAL AND lrt_sel_model IS INITIAL AND lrt_sel_otc IS INITIAL AND lrt_sel_rule_type IS INITIAL
         AND lrt_sel_exe_id IS INITIAL AND lrt_sel_rule_sec IS INITIAL AND lrt_sel_val_id IS INITIAL
             AND it_sel IS NOT INITIAL ).
*   no supported search attribute
          RETURN.
        ENDIF.

* Select data from rule definition table
        SELECT * FROM yztabl_rule_val UP TO @i_num_entries ROWS INTO TABLE @DATA(lt_rule_val_data)
          WHERE def_id    IN @lrt_sel_def_id
            AND model     IN @lrt_sel_model
            AND otc       IN @lrt_sel_otc
            AND rule_type IN @lrt_sel_rule_type
            AND exe_id    IN @lrt_sel_exe_id
            AND rule_sec  IN @lrt_sel_rule_sec
            AND val_id    IN @lrt_sel_val_id
            ORDER BY PRIMARY KEY.

* Transfer from SCARR format into ET_DATA format
        LOOP AT lt_rule_val_data ASSIGNING FIELD-SYMBOL(<fs_val_result>).

          MOVE-CORRESPONDING <fs_val_result> TO <ls_data>.
          ASSIGN COMPONENT 'ACTIVE_V' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_active_v1>).
          IF <lv_active_v1> IS ASSIGNED.
            <lv_active_v1> = <fs_val_result>-active.
          ENDIF.
          INSERT <ls_data> INTO TABLE et_data.
          CLEAR <ls_data>.
        ENDLOOP.

      WHEN 'YZ_RULE_T'.
        SELECT sign,option,low,high FROM @it_sel AS lt_sel WHERE fieldname =: 'TEMP_ID'   INTO TABLE @DATA(lrt_sel_temp_id),
                                                                              'MODEL'     INTO TABLE @lrt_sel_model,
                                                                              'RULE_TYPE' INTO TABLE @lrt_sel_rule_type,
                                                                              'OTC'       INTO TABLE @lrt_sel_otc,
                                                                              'TEMP_DESC' INTO TABLE @DATA(lrt_sel_temp_desc).

        IF ( lrt_sel_temp_id IS INITIAL AND lrt_sel_model IS INITIAL AND lrt_sel_otc IS INITIAL AND lrt_sel_rule_type IS INITIAL
         AND lrt_sel_temp_desc IS INITIAL AND it_sel IS NOT INITIAL ).
*   no supported search attribute
          RETURN.
        ENDIF.

* Select data from rule definition table
        SELECT * FROM yztabl_rule_tmp UP TO @i_num_entries ROWS INTO TABLE @DATA(lt_rule_tmp_data)
          WHERE temp_id   IN @lrt_sel_temp_id
            AND model     IN @lrt_sel_model
            AND otc       IN @lrt_sel_otc
            AND rule_type IN @lrt_sel_rule_type
            AND temp_desc IN @lrt_sel_temp_desc
            ORDER BY PRIMARY KEY.

* Transfer from SCARR format into ET_DATA format
        LOOP AT lt_rule_tmp_data ASSIGNING FIELD-SYMBOL(<fs_tmp_result>).

          <fs_tmp_data> = CORRESPONDING #( <fs_tmp_result> MAPPING model_t = model otc_t = otc rtype_t = rule_type tmp_id = temp_id tmp_desc = temp_desc active_t = active ).
          MOVE-CORRESPONDING <fs_tmp_data> TO <ls_data>.
          INSERT <ls_data> INTO TABLE et_data.
          CLEAR: <ls_data>, <fs_tmp_data>.
        ENDLOOP.
      WHEN 'YZ_RULE_I'.
        SELECT sign,option,low,high FROM @it_sel AS lt_sel WHERE fieldname =: 'TEMP_ID'   INTO TABLE @lrt_sel_temp_id,
                                                                              'MODEL'     INTO TABLE @lrt_sel_model,
                                                                              'RULE_TYPE' INTO TABLE @lrt_sel_rule_type,
                                                                              'OTC'       INTO TABLE @lrt_sel_otc,
                                                                              'EXE_ID'    INTO TABLE @lrt_sel_exe_id,
                                                                              'RULE_SEC'  INTO TABLE @lrt_sel_rule_sec.
        .

        IF ( lrt_sel_temp_id IS INITIAL AND lrt_sel_model IS INITIAL AND lrt_sel_otc IS INITIAL AND lrt_sel_rule_type IS INITIAL
         AND lrt_sel_exe_id IS INITIAL AND lrt_sel_rule_sec IS INITIAL AND it_sel IS NOT INITIAL ).
*   no supported search attribute
          RETURN.
        ENDIF.

* Select data from rule definition table
        SELECT * FROM yztabl_temp_itm UP TO @i_num_entries ROWS INTO TABLE @DATA(lt_rule_itm_data)
          WHERE temp_id   IN @lrt_sel_temp_id
            AND model     IN @lrt_sel_model
            AND otc       IN @lrt_sel_otc
            AND rule_type IN @lrt_sel_rule_type
            AND exe_id    IN @lrt_sel_exe_id
            AND rule_sec  IN @lrt_sel_rule_sec
            ORDER BY PRIMARY KEY.

* Transfer from SCARR format into ET_DATA format
        LOOP AT lt_rule_itm_data ASSIGNING FIELD-SYMBOL(<fs_itm_result>).
          <fs_itm_data> = CORRESPONDING #( <fs_itm_result> MAPPING  model_t   = model
                                                                    otc_t     = otc
                                                                    rtype_t   = rule_type
                                                                    tmp_id    = temp_id
                                                                    active_i  = active
                                                                    entity_t  = entity
                                                                    attr_t    = attribute
                                                                    class_t   = class
                                                                    method_t  = method
                                                                    opraton_t = operation
                                                                    oprator_t = operator
                                                                    exetype_t = exe_type
                                                                    seq_no_t  = seq_no
                                                                    task_t    = task ).

          MOVE-CORRESPONDING <fs_itm_data> TO <ls_data>.
          INSERT <ls_data> INTO TABLE et_data.
          CLEAR: <ls_data>, <fs_itm_data>.
        ENDLOOP.
    ENDCASE.



  ENDMETHOD.


  METHOD set_entity_data.

    IF io_changed_data IS BOUND.
      io_changed_data->get_entity_types( IMPORTING et_entity_mod = DATA(lt_entity_mod) ).                " List of Entity Types Containing New And/Or Changed Data

      IF lt_entity_mod IS NOT INITIAL.

        LOOP AT lt_entity_mod INTO DATA(ls_entity_mod)." WHERE struct = 'KATTR'.
          CHECK ls_entity_mod-struct EQ 'KATTR'.
          io_changed_data->read_data( EXPORTING i_entity      = ls_entity_mod-entity  " Entity Type
                                                i_struct      = ls_entity_mod-struct  " Type of Data Structure
                                      IMPORTING er_t_data_mod = DATA(lr_t_data_mod)  )." "Modified" Data Records (INSERT+UPDATE ).


          ASSIGN lr_t_data_mod->* TO FIELD-SYMBOL(<lt_data_mod>).

          IF <lt_data_mod> IS ASSIGNED AND <lt_data_mod> IS NOT INITIAL.

            DATA(lv_method_name) = 'SET_' && ls_entity_mod-entity.

            TRY.
                CALL METHOD (lv_method_name) EXPORTING it_data = <lt_data_mod>.
              CATCH cx_root INTO DATA(lr_error).
                DATA(lv_error) = lr_error->get_text( ).

            ENDTRY.
          ENDIF.
        ENDLOOP.
      ENDIF.
    ELSEIF iv_entity IS NOT INITIAL AND it_data IS NOT INITIAL.
      lv_method_name = 'SET_' && iv_entity.
      TRY.
          CALL METHOD (lv_method_name) EXPORTING it_data = it_data.
        CATCH cx_root INTO lr_error.
          lv_error = lr_error->get_text( ).
      ENDTRY.
    ENDIF.
  ENDMETHOD.


  METHOD set_yz_rule_d.

    FIELD-SYMBOLS: <ls_yz_rule_d> TYPE yzr_s_yz_pp_yz_rule_d.
    DATA lt_yz_rule_d TYPE gty_t_yz_rule_d.

    MOVE-CORRESPONDING it_data TO lt_yz_rule_d.
    LOOP AT lt_yz_rule_d ASSIGNING <ls_yz_rule_d>.
      READ TABLE gt_yz_rule_d FROM <ls_yz_rule_d> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_yz_rule_d FROM <ls_yz_rule_d>.
      ELSE.
        INSERT <ls_yz_rule_d> INTO TABLE gt_yz_rule_d.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  method SET_YZ_RULE_E.

    FIELD-SYMBOLS: <ls_yz_rule_e> TYPE yzr_s_yz_pp_yz_rule_e.
    DATA lt_yz_rule_e TYPE gty_t_yz_rule_e.

    MOVE-CORRESPONDING it_data TO lt_yz_rule_e.
    LOOP AT lt_yz_rule_e ASSIGNING <ls_yz_rule_e>.
      READ TABLE gt_yz_rule_e FROM <ls_yz_rule_e> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_yz_rule_e FROM <ls_yz_rule_e>.
      ELSE.
        INSERT <ls_yz_rule_e> INTO TABLE gt_yz_rule_e.
      ENDIF.
    ENDLOOP.

  endmethod.


  method SET_YZ_RULE_V.

    FIELD-SYMBOLS: <ls_yz_rule_v> TYPE yzr_s_yz_pp_yz_rule_v.
    DATA lt_yz_rule_v TYPE gty_t_yz_rule_v.

    MOVE-CORRESPONDING it_data TO lt_yz_rule_v.
    LOOP AT lt_yz_rule_v ASSIGNING <ls_yz_rule_v>.
      READ TABLE gt_yz_rule_v FROM <ls_yz_rule_v> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_yz_rule_v FROM <ls_yz_rule_v>.
      ELSE.
        INSERT <ls_yz_rule_v> INTO TABLE gt_yz_rule_v.
      ENDIF.
    ENDLOOP.

  endmethod.


  method CLASS_CONSTRUCTOR.

*   go_access_class_provider = lcl_access_class_provider=>create( ).
*  go_instance = get_instance( ).
*  if_usmd_pp_access~d_fldprop_hidden_supported = abap_true.

  endmethod.


  method DELIVER_ACCESS_CLASS_NAME.
  " use default access class
*  IF rv_access_class_name IS INITIAL.
*    rv_access_class_name = 'CL_MDG_BS_FND_ACCESS'.
*  ENDIF.

  endmethod.


  method GET_INSTANCE.

*  DATA:
*    lv_classname             TYPE seoclsname.
*
*  IF go_instance IS INITIAL.
*
*    TRY.
*        lv_classname = deliver_access_class_name( ).
*      CATCH cx_mdg_bs_bp_access.
*        ASSERT lv_classname IS NOT INITIAL.
*    ENDTRY.
*    CREATE OBJECT go_instance TYPE (lv_classname).
*    go_instance->if_usmd_pp_access~d_fldprop_hidden_supported = abap_true.
*  ENDIF.
*
*  ro_instance = go_instance.

  endmethod.


  method SET_REUSE_MAPPING.
    """Added by Ram
*    CLEAR: gt_reuse_fmap, gt_join_conditions.
*    gt_reuse_fmap      = cl_mdg_hdb_reuse_mapping=>get_field_mapping( gc_model ).
*    gt_join_conditions = cl_mdg_hdb_reuse_mapping=>get_join_conditions( gc_business_object ).

  endmethod.
ENDCLASS.
