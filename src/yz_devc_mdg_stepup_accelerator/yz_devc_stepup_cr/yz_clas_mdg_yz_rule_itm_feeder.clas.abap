class YZ_CLAS_MDG_YZ_RULE_ITM_FEEDER definition
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

  class-data:
    gt_yztabl_rule_typ  TYPE   SORTED TABLE OF yztabl_rule_typ WITH NON-UNIQUE DEFAULT KEY .

  class-methods CLASS_CONSTRUCTOR .

  methods IF_FPM_GUIBB_LIST~GET_DATA
    redefinition .
  methods IF_FPM_GUIBB_LIST~GET_DEFINITION
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS YZ_CLAS_MDG_YZ_RULE_ITM_FEEDER IMPLEMENTATION.


  method CLASS_CONSTRUCTOR.
**fetching rule type
  SELECT * FROM yztabl_rule_typ INTO TABLE gt_yztabl_rule_typ.
  endmethod.


  METHOD IF_FPM_GUIBB_LIST~GET_DATA.
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

**setting decision table row ID field property as read only
    READ TABLE ct_field_usage ASSIGNING FIELD-SYMBOL(<fs_field>) WITH KEY name = 'EXE_ID'.
    IF sy-subrc = 0.
      <fs_field>-read_only = 'X'.
      ev_field_usage_changed = abap_true.
    ENDIF.

**derive decision table row ID.

    DATA : lo_bol_ref TYPE REF TO cl_crm_bol_entity.

    IF iv_eventid->mv_event_id EQ '_CREA_' OR iv_eventid->mv_event_id EQ 'AFTER_BOL_MODIFY'. "'FPM_GUIBB_LIST_CELL_ACTION'.

      LOOP AT ct_data ASSIGNING FIELD-SYMBOL(<cs_data>).

        IF <cs_data> IS ASSIGNED AND <cs_data> IS NOT INITIAL.

          ASSIGN COMPONENT 'FPM_KEY_BY_BOL_ENTITY' OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<fs_o_ref>).
          ASSIGN COMPONENT 'RULE_SEC' OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<is_rule_sec>).
          lo_bol_ref = <fs_o_ref>.
          IF lines( ct_data ) EQ 1.
            ASSIGN COMPONENT 'RTYPE_T' OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<is_rule_type>).
            IF <is_rule_sec> IS ASSIGNED AND <is_rule_sec> IS INITIAL.
              <is_rule_sec> = '1'.
              lo_bol_ref->if_bol_bo_property_access~set_property( iv_attr_name = 'RULE_SEC' iv_value = <is_rule_sec> ).
              IF sy-subrc = 0.
                DELETE et_messages WHERE msgid       = 'USMD_GENERIC_GENIL'
                                     AND msgno       = '001'
                                     AND severity    = 'E'
                                     AND parameter_1 = 'Rule Section'.
              ENDIF.
            ENDIF.
            ASSIGN COMPONENT 'SEQ_NO_T' OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<is_rule_seq>).
            IF <is_rule_seq> IS ASSIGNED AND <is_rule_seq> IS INITIAL.
              <is_rule_seq> = '1U01'.
              lo_bol_ref->if_bol_bo_property_access~set_property( iv_attr_name = 'SEQ_NO_T' iv_value = <is_rule_seq> ).
            ENDIF.
            ASSIGN COMPONENT 'TASK_T' OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<is_rule_task>).
            IF <is_rule_task> IS ASSIGNED AND <is_rule_task> IS INITIAL.
              <is_rule_task> = 'CHECK'.
              lo_bol_ref->if_bol_bo_property_access~set_property( iv_attr_name = 'TASK_T' iv_value = <is_rule_task> ).
            ENDIF.
            ASSIGN COMPONENT 'OPRATON_T' OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<is_rule_operation>).
            IF <is_rule_operation> IS ASSIGNED AND <is_rule_operation> IS INITIAL.
              <is_rule_operation> = 'IF'.
              lo_bol_ref->if_bol_bo_property_access~set_property( iv_attr_name = 'OPRATON_T' iv_value = <is_rule_operation> ).
            ENDIF.
            IF line_exists( gt_yztabl_rule_typ[ rule_type = <is_rule_type> cr_rtype = abap_true ]  ). ""Setting entity and attribute fields value for CR related rule type
              ASSIGN COMPONENT 'ENTITY_T' OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<is_rule_entity>).
              IF <is_rule_entity> IS ASSIGNED AND <is_rule_entity> IS INITIAL.
                <is_rule_entity> = 'YYUSAGE'.
                lo_bol_ref->if_bol_bo_property_access~set_property( iv_attr_name = 'ENTITY_T' iv_value = <is_rule_entity> ).
              ENDIF.
              ASSIGN COMPONENT 'ATTR_T' OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<is_rule_attr>).
              IF <is_rule_attr> IS ASSIGNED AND <is_rule_attr> IS INITIAL.
                <is_rule_attr> = 'CR_TYPE'.
                lo_bol_ref->if_bol_bo_property_access~set_property( iv_attr_name = 'ATTR_T' iv_value = <is_rule_attr> ).
              ENDIF.
              ASSIGN COMPONENT 'EXETYPE_T' OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<is_rule_exe_type>).
              IF <is_rule_exe_type> IS ASSIGNED AND <is_rule_exe_type> IS INITIAL.
                <is_rule_exe_type> = 'USAGE_V'.
                lo_bol_ref->if_bol_bo_property_access~set_property( iv_attr_name = 'EXETYPE_T' iv_value = <is_rule_exe_type> ).
              ENDIF.
            ENDIF.
          ENDIF.

          ASSIGN COMPONENT 'EXE_ID' OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<iv_exe_id>).
          ASSIGN COMPONENT 'TMP_ID' OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<iv_tmp_id>).

          IF <iv_exe_id> IS INITIAL AND <is_rule_sec> IS NOT INITIAL.
            <iv_exe_id> = <iv_tmp_id> && '_' && <is_rule_sec> && '_' && yz_clas_mdg_accelerator=>get_nr_itm_id_for_rule( iv_temp_id = <iv_tmp_id> iv_rule_sec = <is_rule_sec> ).
            CONDENSE <iv_exe_id>.
            lo_bol_ref->if_bol_bo_property_access~set_property( iv_attr_name = 'EXE_ID' iv_value = <iv_exe_id> ).
            IF sy-subrc = 0.
              DELETE et_messages WHERE msgid       = 'USMD_GENERIC_GENIL'
                                   AND msgno       = '001'
                                   AND severity    = 'E'
                                   AND parameter_1 = 'Rule Execution ID'.
              ev_data_changed = abap_true.
            ENDIF.
          ENDIF.
          ASSIGN COMPONENT 'ACTIVE_T' OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<is_rule_active_t>).
          IF <is_rule_active_t> IS ASSIGNED AND <is_rule_active_t> IS INITIAL.
            <is_rule_active_t> = 'X'.
            lo_bol_ref->if_bol_bo_property_access~set_property( iv_attr_name = 'ACTIVE_T' iv_value = <is_rule_active_t> ).
          ENDIF.

        ENDIF.
      ENDLOOP.

    ENDIF.



  ENDMETHOD.


  METHOD IF_FPM_GUIBB_LIST~GET_DEFINITION.
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
  ENDMETHOD.
ENDCLASS.
