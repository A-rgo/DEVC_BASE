class YZ_CLAS_MDG_YZ_RULE_VAL_FEEDER definition
  public
  inheriting from CL_MDG_BS_GUIBB_LIST
  final
  create public .

public section.

  aliases CS_PORT_TYPE
    for IF_FPM_FEEDER_MODEL~CS_PORT_TYPE .
  aliases GC_EVENT_CHANGE_COLS_ROWS
    for IF_FPM_GUIBB_LIST~GC_EVENT_CHANGE_COLS_ROWS .
  aliases GC_EVENT_CLEAR_SORT_RULES_ATS
    for IF_FPM_GUIBB_LIST~GC_EVENT_CLEAR_SORT_RULES_ATS .
  aliases GC_EVENT_CLOSE_SEARCH
    for IF_FPM_GUIBB_LIST~GC_EVENT_CLOSE_SEARCH .
  aliases GC_EVENT_EXPORT_TO_CSV
    for IF_FPM_GUIBB_LIST~GC_EVENT_EXPORT_TO_CSV .
  aliases GC_EVENT_EXPORT_TO_EXCEL
    for IF_FPM_GUIBB_LIST~GC_EVENT_EXPORT_TO_EXCEL .
  aliases GC_EVENT_EXPORT_TO_OOXML
    for IF_FPM_GUIBB_LIST~GC_EVENT_EXPORT_TO_OOXML .
  aliases GC_EVENT_EXPORT_TO_PDF
    for IF_FPM_GUIBB_LIST~GC_EVENT_EXPORT_TO_PDF .
  aliases GC_EVENT_FILTER_CHANGED_SEL
    for IF_FPM_GUIBB_LIST~GC_EVENT_FILTER_CHANGED_SEL .
  aliases GC_EVENT_LIST_FILTER
    for IF_FPM_GUIBB_LIST~GC_EVENT_LIST_FILTER .
  aliases GC_EVENT_LIST_PERSONALIZATION
    for IF_FPM_GUIBB_LIST~GC_EVENT_LIST_PERSONALIZATION .
  aliases GC_EVENT_LIST_SORT
    for IF_FPM_GUIBB_LIST~GC_EVENT_LIST_SORT .
  aliases GC_EVENT_MULTI_VALUE_PASTE
    for IF_FPM_GUIBB_LIST~GC_EVENT_MULTI_VALUE_PASTE .
  aliases GC_EVENT_MV_PASTE_RESUMED
    for IF_FPM_GUIBB_LIST~GC_EVENT_MV_PASTE_RESUMED .
  aliases GC_EVENT_ON_FILTER
    for IF_FPM_GUIBB_LIST~GC_EVENT_ON_FILTER .
  aliases GC_EVENT_OPEN_SEARCH
    for IF_FPM_GUIBB_LIST~GC_EVENT_OPEN_SEARCH .
  aliases GC_EVENT_PAR_AMOUNT_COLS
    for IF_FPM_GUIBB_LIST~GC_EVENT_PAR_AMOUNT_COLS .
  aliases GC_EVENT_PAR_AMOUNT_ROWS
    for IF_FPM_GUIBB_LIST~GC_EVENT_PAR_AMOUNT_ROWS .
  aliases GC_EVENT_PAR_COLUMN_NAME
    for IF_FPM_GUIBB_LIST~GC_EVENT_PAR_COLUMN_NAME .
  aliases GC_EVENT_PAR_CONFIG_ID
    for IF_FPM_GUIBB_LIST~GC_EVENT_PAR_CONFIG_ID .
  aliases GC_EVENT_PAR_DROP_DOWN_KEY
    for IF_FPM_GUIBB_LIST~GC_EVENT_PAR_DROP_DOWN_KEY .
  aliases GC_EVENT_PAR_EXPORT_FORMAT
    for IF_FPM_GUIBB_LIST~GC_EVENT_PAR_EXPORT_FORMAT .
  aliases GC_EVENT_PAR_FEEDER_NAME
    for IF_FPM_GUIBB_LIST~GC_EVENT_PAR_FEEDER_NAME .
  aliases GC_EVENT_PAR_INPUT_VALUE
    for IF_FPM_GUIBB_LIST~GC_EVENT_PAR_INPUT_VALUE .
  aliases GC_EVENT_PAR_ROW
    for IF_FPM_GUIBB_LIST~GC_EVENT_PAR_ROW .
  aliases GC_EVENT_PAR_ROW_OLD
    for IF_FPM_GUIBB_LIST~GC_EVENT_PAR_ROW_OLD .
  aliases GC_EVENT_PAR_SORT_COL
    for IF_FPM_GUIBB_LIST~GC_EVENT_PAR_SORT_COL .
  aliases GC_EVENT_PAR_SORT_ORDER
    for IF_FPM_GUIBB_LIST~GC_EVENT_PAR_SORT_ORDER .
  aliases GC_EVENT_PAR_SOURCE
    for IF_FPM_GUIBB_LIST~GC_EVENT_PAR_SOURCE .
  aliases GC_EVENT_PAR_TOGGLE_STATE
    for IF_FPM_GUIBB_LIST~GC_EVENT_PAR_TOGGLE_STATE .
  aliases GC_EVENT_PDF_EXPORT
    for IF_FPM_GUIBB_LIST~GC_EVENT_PDF_EXPORT .
  aliases GC_EVENT_SELECTION_AGGR
    for IF_FPM_GUIBB_LIST~GC_EVENT_SELECTION_AGGR .
  aliases GC_EVENT_SELECTION_UPDATE
    for IF_FPM_GUIBB_LIST~GC_EVENT_SELECTION_UPDATE .
  aliases GC_EVENT_SOURCES
    for IF_FPM_GUIBB_LIST~GC_EVENT_SOURCES .
  aliases GC_EVENT_VIEW_CHANGE
    for IF_FPM_GUIBB_LIST~GC_EVENT_VIEW_CHANGE .
  aliases GC_FPM_EVENT_ON_LEAD_SEL
    for IF_FPM_GUIBB_LIST~GC_FPM_EVENT_ON_LEAD_SEL .
  aliases GC_FPM_EVENT_SET_INIT_LEAD_SEL
    for IF_FPM_GUIBB_LIST~GC_FPM_EVENT_SET_INIT_LEAD_SEL .
  aliases GC_GUIBB_LIST_ON_CELL_ACTION
    for IF_FPM_GUIBB_LIST~GC_GUIBB_LIST_ON_CELL_ACTION .
  aliases GC_GUIBB_LIST_ON_DROP
    for IF_FPM_GUIBB_LIST~GC_GUIBB_LIST_ON_DROP .
  aliases MS_PARAMETER_RENDER
    for IF_FPM_GUIBB~MS_PARAMETER_RENDER .
  aliases MV_IS_FIRST_ROUND
    for IF_FPM_GUIBB_LIST~MV_IS_FIRST_ROUND .
  aliases MV_TOOL_ID
    for IF_FPM_FEEDER_ENH_BO_ACCESS~MV_TOOL_ID .
  aliases AFTER_FAILED_EVENT
    for IF_FPM_GUIBB_LIST_EXT~AFTER_FAILED_EVENT .
  aliases BEFORE_DISPATCH_EVENT
    for IF_FPM_GUIBB_LIST_EXT~BEFORE_DISPATCH_EVENT .
  aliases CHIP_EXIT
    for IF_FPM_CHIP_FEEDER~CHIP_EXIT .
  aliases CHIP_INIT
    for IF_FPM_CHIP_FEEDER~CHIP_INIT .
  aliases CURRENT_ENTITY
    for IF_BS_BOL_HOW_FEEDER~CURRENT_ENTITY .
  aliases FPM_INITIALIZE
    for IF_FPM_MULTI_INSTANTIABLE~FPM_INITIALIZE .
  aliases FPM_IS_MULTI_INSTANTIABLE
    for IF_FPM_MULTI_INSTANTIABLE~FPM_IS_MULTI_INSTANTIABLE .
  aliases GET_ABSOLUTE_AMOUNT_OF_ROWS
    for IF_FPM_GUIBB_LIST_PAGING~GET_ABSOLUTE_AMOUNT_OF_ROWS .
  aliases GET_CHANGES
    for IF_FPM_GUIBB_LIST_PAGING~GET_CHANGES .
  aliases GET_DATA
    for IF_FPM_GUIBB_LIST~GET_DATA .
  aliases GET_DEFAULT_CONFIG
    for IF_FPM_GUIBB_LIST~GET_DEFAULT_CONFIG .
  aliases GET_DEFINITION
    for IF_FPM_GUIBB_LIST~GET_DEFINITION .
  aliases GET_ENHANCED_OBJECTS
    for IF_FPM_FEEDER_ENH_BO_ACCESS~GET_ENHANCED_OBJECTS .
  aliases GET_ENHANCED_OBJECT_PARTS
    for IF_FPM_FEEDER_ENH_BO_ACCESS~GET_ENHANCED_OBJECT_PARTS .
  aliases GET_INPORT_KEY
    for IF_FPM_FEEDER_MODEL~GET_INPORT_KEY .
  aliases GET_NAMESPACE
    for IF_FPM_FEEDER_MODEL~GET_NAMESPACE .
  aliases GET_OUTPORTS
    for IF_FPM_FEEDER_MODEL~GET_OUTPORTS .
  aliases GET_OUTPORT_DATA
    for IF_FPM_FEEDER_MODEL~GET_OUTPORT_DATA .
  aliases GET_PAGE
    for IF_FPM_GUIBB_LIST_PAGING~GET_PAGE .
  aliases GET_PARAMETER_LIST
    for IF_FPM_GUIBB~GET_PARAMETER_LIST .
  aliases HANDLE_PHASE_0
    for IF_FPM_GUIBB_OVS~HANDLE_PHASE_0 .
  aliases HANDLE_PHASE_1
    for IF_FPM_GUIBB_OVS~HANDLE_PHASE_1 .
  aliases HANDLE_PHASE_2
    for IF_FPM_GUIBB_OVS~HANDLE_PHASE_2 .
  aliases HANDLE_PHASE_3
    for IF_FPM_GUIBB_OVS~HANDLE_PHASE_3 .
  aliases INITIALIZE
    for IF_FPM_GUIBB~INITIALIZE .
  aliases PROCESS_CTXT_MENU
    for IF_FPM_GUIBB_CTXT_MENU~PROCESS_CTXT_MENU .
  aliases SET_CONNECTOR
    for IF_FPM_FEEDER_MODEL~SET_CONNECTOR .
  aliases S_CHANGES
    for IF_FPM_GUIBB_LIST_PAGING~S_CHANGES .
  aliases TY_APP_KEY
    for IF_FPM_GUIBB_LIST~TY_APP_KEY .
  aliases TY_S_NATIVE_DND_DATA
    for IF_FPM_GUIBB_LIST~TY_S_NATIVE_DND_DATA .
  aliases TY_S_PORT
    for IF_FPM_FEEDER_MODEL~TY_S_PORT .
  aliases TY_T_PORT
    for IF_FPM_FEEDER_MODEL~TY_T_PORT .
  aliases T_CHANGES
    for IF_FPM_GUIBB_LIST_PAGING~T_CHANGES .

  class-data MV_LAST_ACTION type STRING .

  methods GET_F4_VALUE
    importing
      !IV_TABNAME type DFIES-TABNAME
      !IV_FIELDNAME type DFIES-FIELDNAME
    exporting
      !ET_VALUE_SET type CRMT_TEXT_VALUE_PAIR_TAB .

  methods IF_FPM_GUIBB_LIST~GET_DATA
    redefinition .
  methods IF_FPM_GUIBB_LIST~GET_DEFINITION
    redefinition .
  methods IF_FPM_GUIBB_LIST~PROCESS_EVENT
    redefinition .
protected section.

  methods OVS_HANDLE_PHASE_1
    redefinition .
  methods OVS_HANDLE_PHASE_2
    redefinition .
  methods OVS_HANDLE_PHASE_3
    redefinition .
private section.
ENDCLASS.



CLASS YZ_CLAS_MDG_YZ_RULE_VAL_FEEDER IMPLEMENTATION.


  METHOD get_f4_value.
    DATA ls_shlp TYPE shlp_descr.
    DATA lt_values TYPE TABLE OF seahlpres.

    IF iv_tabname IS NOT INITIAL AND iv_fieldname IS NOT INITIAL.
      CALL FUNCTION 'F4IF_DETERMINE_SEARCHHELP'
        EXPORTING
          tabname           = iv_tabname
          fieldname         = iv_fieldname
        IMPORTING
          shlp              = ls_shlp
        EXCEPTIONS
          field_not_found   = 1
          no_help_for_field = 2
          inconsistent_help = 3
          OTHERS            = 4.
      IF sy-subrc = 0.

        CALL FUNCTION 'DD_SHLP_GET_HELPVALUES'
          TABLES
            output_values               = lt_values
          CHANGING
            shlp                        = ls_shlp
          EXCEPTIONS
            cursor_selection_impossible = 1
            OTHERS                      = 2.
        IF sy-subrc = 0.
          IF ls_shlp-shlptype NE 'FV'.
            DELETE ls_shlp-fieldprop WHERE shlpoutput IS INITIAL.
            SORT ls_shlp-fielddescr BY offset.
            LOOP AT lt_values INTO DATA(ls_value).
              APPEND INITIAL LINE TO et_value_set ASSIGNING FIELD-SYMBOL(<lfs_valuelist>).
              IF <lfs_valuelist> IS ASSIGNED.
                READ TABLE ls_shlp-fieldprop INTO DATA(ls_fieldprop) INDEX 1.
                IF sy-subrc = 0.
                  READ TABLE ls_shlp-fielddescr INTO DATA(ls_fielddescr) WITH KEY fieldname = ls_fieldprop-fieldname.
                  IF sy-subrc = 0.
                    ls_fielddescr-offset /= 2.
                    <lfs_valuelist>-key = COND #( WHEN ls_fielddescr-offset = 1 THEN ls_value-string(ls_fielddescr-leng)
                                                  ELSE ls_value-string+ls_fielddescr-offset(ls_fielddescr-leng) ).

                  ENDIF.
                ENDIF.

                READ TABLE ls_shlp-fieldprop INTO ls_fieldprop INDEX 2.
                IF sy-subrc = 0.
                  READ TABLE ls_shlp-fielddescr INTO ls_fielddescr WITH KEY fieldname = ls_fieldprop-fieldname.
                  IF sy-subrc = 0.
                    ls_fielddescr-offset /= 2.
                    <lfs_valuelist>-text = COND #( WHEN ls_fielddescr-offset = 1 THEN ls_value-string(ls_fielddescr-leng)
                                                  ELSE ls_value-string+ls_fielddescr-offset(ls_fielddescr-leng) ).

                  ENDIF.
                ENDIF.
              ENDIF.
            ENDLOOP.
          ELSE.
            LOOP AT lt_values INTO ls_value.
              APPEND INITIAL LINE TO et_value_set ASSIGNING <lfs_valuelist>.
              IF <lfs_valuelist> IS ASSIGNED.
                READ TABLE ls_shlp-fielddescr INTO ls_fielddescr WITH KEY fieldname = '_LOW'.
                IF sy-subrc = 0.
                  ls_fielddescr-offset /= 2.
                  <lfs_valuelist>-key = COND #( WHEN ls_fielddescr-offset = 1 THEN ls_value-string(ls_fielddescr-leng)
                                                ELSE ls_value-string+ls_fielddescr-offset(ls_fielddescr-leng) ).
                ENDIF.
                READ TABLE ls_shlp-fielddescr INTO ls_fielddescr WITH KEY fieldname = '_TEXT'.
                IF sy-subrc = 0.
                  ls_fielddescr-offset /= 2.
*                ls_fielddescr-offset /= 2.
                  <lfs_valuelist>-text = COND #( WHEN ls_fielddescr-offset = 1 THEN ls_value-string(ls_fielddescr-leng)
                                                 ELSE ls_value-string+ls_fielddescr-offset(ls_fielddescr-leng) ).

                ENDIF.
              ENDIF.
            ENDLOOP.
          ENDIF.
        ELSE.
*          CASE sy-subrc.
*            WHEN 1.
*              c_input-e_status = 'Error'(001).
*              c_input-e_message = 'Cursor selection impossible'(002).
*            WHEN OTHERS.
*              c_input-e_status = 'Error'(001).
*          ENDCASE.
        ENDIF.
      ELSE.
*        CASE sy-subrc.
*          WHEN 1.
*            c_input-e_status = 'Error'(001).
*            c_input-e_message = 'Field not found'(003).
*          WHEN 2.
*            c_input-e_status = 'Error'(001).
*            c_input-e_message = 'No search help defined'(004).
*          WHEN 3.
*            c_input-e_status = 'Error'(001).
*            c_input-e_message = 'Incosistent Help'(005).
*          WHEN OTHERS.
*            c_input-e_status = 'Error'(001).
*        ENDCASE.
      ENDIF.
*    ELSEIF c_input-i_searchhelp IS NOT INITIAL.
*      get_search_help_data( EXPORTING i_model = i_model CHANGING c_input = c_input ).
    ENDIF.

    SORT et_value_set BY key.
    DELETE ADJACENT DUPLICATES FROM et_value_set COMPARING key.
  ENDMETHOD.


  METHOD if_fpm_guibb_list~get_data.
    CALL METHOD super->if_fpm_guibb_list~get_data
      EXPORTING
        iv_eventid                = iv_eventid
        it_selected_fields        = it_selected_fields
        iv_raised_by_own_ui       = iv_raised_by_own_ui
        iv_visible_rows           = iv_visible_rows
        iv_edit_mode              = iv_edit_mode
        io_extended_ctrl          = io_extended_ctrl
      IMPORTING
        et_messages               = et_messages
        ev_data_changed           = ev_data_changed
        ev_field_usage_changed    = ev_field_usage_changed
        ev_action_usage_changed   = ev_action_usage_changed
        ev_selected_lines_changed = ev_selected_lines_changed
        ev_dnd_attr_changed       = ev_dnd_attr_changed
        eo_itab_change_log        = eo_itab_change_log
      CHANGING
        ct_data                   = ct_data
        ct_field_usage            = ct_field_usage
        ct_action_usage           = ct_action_usage
        ct_selected_lines         = ct_selected_lines
        cv_lead_index             = cv_lead_index
        cv_first_visible_row      = cv_first_visible_row
        cs_additional_info        = cs_additional_info
        ct_dnd_attributes         = ct_dnd_attributes.

***************************************************************************************
    DATA: lt_data    TYPE STANDARD TABLE OF yzr_s_yz_pp_yz_rule_v,
          lo_bol_ref TYPE REF TO cl_crm_bol_entity.
    FIELD-SYMBOLS <lt_data> TYPE STANDARD TABLE.

**setting Value ID field property as read only
    READ TABLE ct_field_usage ASSIGNING FIELD-SYMBOL(<fs_field>) WITH KEY name = 'VAL_ID'.
    IF sy-subrc = 0.
      <fs_field>-read_only = 'X'.
      ev_field_usage_changed = abap_true.
    ENDIF.

**derive decision table Value ID.

    IF iv_eventid->mv_event_id EQ '_CREA_'.
      ASSIGN ct_data TO <lt_data>.
      IF <lt_data> IS ASSIGNED AND <lt_data> IS NOT INITIAL.
        lt_data = CORRESPONDING #( <lt_data> ).
        IF cv_lead_index GT 0.
          DATA(ls_data) = lt_data[ cv_lead_index ].
        ENDIF.
        LOOP AT ct_data ASSIGNING FIELD-SYMBOL(<cs_data>).

          IF <cs_data> IS ASSIGNED AND <cs_data> IS NOT INITIAL.

            ASSIGN COMPONENT 'FPM_KEY_BY_BOL_ENTITY' OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<fs_o_ref>).
            lo_bol_ref = <fs_o_ref>.
            ASSIGN COMPONENT 'EXE_ID' OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<is_exe_id>).
            ASSIGN COMPONENT 'VAL_ID' OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<is_val_id>).

            IF <is_val_id> IS INITIAL.
              <is_val_id> = <is_exe_id> && '_' && yz_clas_mdg_accelerator=>get_nr_val_id_for_rule( ).
              CONDENSE <is_exe_id>.
              lo_bol_ref->if_bol_bo_property_access~set_property( iv_attr_name = 'VAL_ID' iv_value = <is_val_id> ).
              IF sy-subrc = 0.
                DELETE et_messages WHERE msgid       = 'USMD_GENERIC_GENIL'
                                     AND msgno       = '001'
                                     AND severity    = 'E'
                                     AND parameter_1 = 'Value ID'.
              ENDIF.
              ASSIGN COMPONENT 'SIGN' OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<is_sign>).
              IF <is_sign> IS ASSIGNED AND <is_sign> IS INITIAL.
                <is_sign> =  COND #( WHEN lines( ct_data ) EQ 1 THEN 'I'
                                     WHEN mv_last_action EQ 'COPY_VAL' THEN ls_data-sign ).
                lo_bol_ref->if_bol_bo_property_access~set_property( iv_attr_name = 'SIGN' iv_value = <is_sign> ).
              ENDIF.
              ASSIGN COMPONENT 'OPT' OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<is_opt>).
              IF <is_opt> IS ASSIGNED AND <is_opt> IS INITIAL.
                <is_opt> = COND #( WHEN lines( ct_data ) EQ 1 THEN 'EQ'
                                   WHEN mv_last_action EQ 'COPY_VAL' THEN ls_data-opt ).
                lo_bol_ref->if_bol_bo_property_access~set_property( iv_attr_name = 'OPT' iv_value = <is_opt> ).
              ENDIF.
              ASSIGN COMPONENT 'VAL_TYPE' OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<is_val_type>).
              IF <is_val_type> IS ASSIGNED AND <is_val_type> IS INITIAL.
                <is_val_type> = COND #( WHEN lines( ct_data ) EQ 1 THEN 'VR'
                                        WHEN mv_last_action EQ 'COPY_VAL' THEN ls_data-val_type ).
                lo_bol_ref->if_bol_bo_property_access~set_property( iv_attr_name = 'VAL_TYPE' iv_value = <is_val_type> ).
              ENDIF.
              ASSIGN COMPONENT 'ACTIVE_V' OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<is_active>).
              IF <is_active> IS ASSIGNED AND <is_active> IS INITIAL.
                <is_active> = 'X'.
                lo_bol_ref->if_bol_bo_property_access~set_property( iv_attr_name = 'ACTIVE_V' iv_value = <is_active> ).
              ENDIF.
              CLEAR mv_last_action.
            ENDIF.
          ENDIF.
        ENDLOOP.
      ENDIF.
    ENDIF.

  ENDMETHOD.


  METHOD if_fpm_guibb_list~get_definition.
    CALL METHOD super->if_fpm_guibb_list~get_definition
      IMPORTING
        eo_field_catalog         = eo_field_catalog
        et_field_description     = et_field_description
        et_action_definition     = et_action_definition
        et_special_groups        = et_special_groups
        es_message               = es_message
        ev_additional_error_info = ev_additional_error_info
        et_dnd_definition        = et_dnd_definition
        et_row_actions           = et_row_actions
        es_options               = es_options.

    GET PARAMETER ID 'YZ_PARAM_MODEL'     FIELD DATA(lv_model).
    GET PARAMETER ID 'YZ_PARAM_OTC'       FIELD DATA(lv_otc).
    GET PARAMETER ID 'YZ_PARAM_ENTITY'    FIELD DATA(lv_entity).
    GET PARAMETER ID 'YZ_PARAM_ATTRIBUTE' FIELD DATA(lv_attr).


    READ TABLE et_field_description WITH KEY name = 'LOW' ASSIGNING FIELD-SYMBOL(<ls_field_desc1>).
    IF sy-subrc IS INITIAL AND <ls_field_desc1> IS ASSIGNED AND <ls_field_desc1> IS NOT INITIAL.
*      <ls_field_desc1>-ddic_shlp_name = 'MDG_BS_MAT_MEINS'.
      <ls_field_desc1>-ovs_name       = 'YZ_CLAS_MDG_YZ_RULE_VAL_FEEDER'.
    ENDIF.

  et_action_definition = VALUE #( BASE et_action_definition ( id = 'COPY_VAL' text = 'Value Copy' enabled = abap_true disable_when_no_lead_sel = abap_true ) ).
*    CHECK lv_entity IS NOT INITIAL AND lv_attr IS NOT INITIAL.
*
*    SELECT  usmd_model,
*            usmd_objstat,
*            usmd_entity,
*            usmd_attribute,
*            rollname,
*            usmd_search_hlp
*    FROM usmd0022
*    INTO TABLE @DATA(lt_attr_data)
*    WHERE usmd_model      = @lv_model   AND
*          usmd_objstat    = 'A'         AND
*          usmd_entity     = @lv_entity  AND
*          usmd_attribute  = @lv_attr.
*    IF sy-subrc IS INITIAL.
*      READ TABLE lt_attr_data INTO DATA(ls_attr_data) INDEX 1.
*      CHECK sy-subrc IS INITIAL AND ls_attr_data IS NOT INITIAL.
*      READ TABLE et_field_description WITH KEY name = 'LOW' ASSIGNING FIELD-SYMBOL(<ls_field_desc>).
*      IF sy-subrc IS INITIAL AND <ls_field_desc> IS ASSIGNED AND <ls_field_desc> IS NOT INITIAL.
*        IF ls_attr_data-usmd_search_hlp IS NOT INITIAL.
*          DATA(lv_srch_help) =  ls_attr_data-usmd_search_hlp.
*        ENDIF.
*        IF lv_srch_help IS INITIAL AND ls_attr_data-rollname IS NOT INITIAL.
*
*        ENDIF.
*        <ls_field_desc>-ddic_shlp_name = lv_srch_help.
*      ENDIF.
*    ENDIF.
  ENDMETHOD.


  METHOD ovs_handle_phase_1.
    CALL METHOD super->ovs_handle_phase_1
      EXPORTING
        iv_field_name                 = iv_field_name
      IMPORTING
        er_input                      = er_input
        ev_group_header               = ev_group_header
        et_label_texts                = et_label_texts
        ev_window_title               = ev_window_title
        ev_display_values_immediately = ev_display_values_immediately.
  ENDMETHOD.


  METHOD ovs_handle_phase_2.
    CALL METHOD super->ovs_handle_phase_2
      EXPORTING
        iv_field_name      = iv_field_name
        ir_query_parameter = ir_query_parameter
        io_access          = io_access
      IMPORTING
        er_output          = er_output
        ev_table_header    = ev_table_header
        et_column_texts    = et_column_texts.

    DATA ls_shlp TYPE shlp_descr.
    DATA lt_values TYPE TABLE OF seahlpres.
    DATA lt_return TYPE STANDARD TABLE OF ddshretval.
    DATA: lo_data TYPE REF TO data.

    CHECK iv_field_name EQ 'LOW'.
    GET PARAMETER ID 'YZ_PARAM_MODEL'     FIELD DATA(lv_model).
    GET PARAMETER ID 'YZ_PARAM_OTC'       FIELD DATA(lv_otc).
    GET PARAMETER ID 'YZ_PARAM_ENTITY'    FIELD DATA(lv_entity).
    GET PARAMETER ID 'YZ_PARAM_ATTRIBUTE' FIELD DATA(lv_attr).

    CHECK lv_entity IS NOT INITIAL AND lv_attr IS NOT INITIAL.
    SELECT * FROM yztabl_ref_data
      INTO TABLE @DATA(lt_ref_data)
      WHERE entity = @lv_entity AND
            attribute = @lv_attr.
    IF sy-subrc IS INITIAL.
      get_f4_value(
        EXPORTING
          iv_tabname   = lt_ref_data[ 1 ]-tabname                 " Table Name
          iv_fieldname = lt_ref_data[ 1 ]-fieldname                 " Field Name
        IMPORTING
          et_value_set = DATA(lt_value_set)                 " General Flag
      ).

      CHECK er_output IS BOUND.
      ASSIGN er_output->* TO FIELD-SYMBOL(<lt_data>).
      CHECK sy-subrc IS INITIAL AND <lt_data> IS ASSIGNED AND lt_value_set IS NOT INITIAL.
      <lt_data> = CORRESPONDING #( lt_value_set ).
    ENDIF.

    CHECK lt_value_set IS INITIAL.
*    SELECT  usmd_model,
*            usmd_objstat,
*            usmd_entity,
*            usmd_attribute,
*            rollname,
*            usmd_search_hlp
*    FROM usmd0022
*    INTO TABLE @DATA(lt_attr_data)
*    WHERE usmd_model      = @lv_model   AND
*          usmd_objstat    = 'A'         AND
*          usmd_entity     = @lv_entity  AND
*          usmd_attribute  = @lv_attr.
*    IF sy-subrc IS INITIAL.
*      IF lt_attr_data[ 1 ]-usmd_search_hlp IS NOT INITIAL.
*        ls_shlp-shlpname = lt_attr_data[ 1 ]-usmd_search_hlp.
*        CALL FUNCTION 'DD_SHLP_GET_HELPVALUES'
*          TABLES
*            output_values               = lt_values
*          CHANGING
*            shlp                        = ls_shlp
*          EXCEPTIONS
*            cursor_selection_impossible = 1
*            OTHERS                      = 2.
*        IF sy-subrc = 0.
*        ENDIF.
*      ENDIF.
*    ENDIF.
  ENDMETHOD.


  METHOD ovs_handle_phase_3.
    CALL METHOD super->ovs_handle_phase_3
      EXPORTING
        iv_field_name  = iv_field_name
        ir_selection   = ir_selection
      IMPORTING
        et_field_value = et_field_value
        eo_fpm_event   = eo_fpm_event.
  ENDMETHOD.


  method IF_FPM_GUIBB_LIST~PROCESS_EVENT.

    CALL METHOD super->if_fpm_guibb_list~process_event
      EXPORTING
        io_event            = io_event
        iv_raised_by_own_ui = iv_raised_by_own_ui
        iv_lead_index       = iv_lead_index
        iv_event_index      = iv_event_index
        it_selected_lines   = it_selected_lines
        io_ui_info          = io_ui_info
      IMPORTING
        ev_result           = ev_result
        et_messages         = et_messages.

    IF io_event->mv_event_id EQ 'COPY_VAL'.
      mv_last_action = io_event->mv_event_id.
      me->raise_local_event_by_id( iv_event_id = '_CREA_' ).

    ENDIF.
  endmethod.
ENDCLASS.
