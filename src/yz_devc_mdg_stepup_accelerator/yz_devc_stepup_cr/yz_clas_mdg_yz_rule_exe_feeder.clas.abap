class YZ_CLAS_MDG_YZ_RULE_EXE_FEEDER definition
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

  types:
    gty_t_yz_rule_e TYPE STANDARD TABLE OF yzr_s_yz_pp_yz_rule_e .

  class-data:
    gt_yztabl_rule_typ  TYPE   SORTED TABLE OF yztabl_rule_typ WITH NON-UNIQUE DEFAULT KEY .
  class-data GT_FIELD_USAGE type FPMGB_T_FIELDUSAGE .
  class-data MV_LAST_ACTION type STRING .
  data GT_YZ_RULE_E type YZR_T_RULE_EXE .
  class-data GV_RULE_SEC_READ_REF type NAME_KOMP .
  class-data GV_ATTRIBUTE_READ_REF type NAME_KOMP .
  class-data GV_CLASS_READ_REF type NAME_KOMP .
  class-data GV_ENTITY_READ_REF type NAME_KOMP .
  class-data GV_ETEMP_ID_READ_REF type NAME_KOMP .
  class-data GV_EXE_TYPE_READ_REF type NAME_KOMP .
  class-data GV_METHOD_READ_REF type NAME_KOMP .
  class-data GV_OPERATION_READ_REF type NAME_KOMP .
  class-data GV_OPERATOR_READ_REF type NAME_KOMP .
  class-data GV_SEQ_NO_READ_REF type NAME_KOMP .
  class-data GV_TASK_READ_REF type NAME_KOMP .
  class-data GV_ACTIVE_E_READ_REF type NAME_KOMP .
  class-data GV_PREV_INDEX type SYTABIX .
  constants GC_ROW_EDIT type STRING value 'ROW_EDIT' ##NO_TEXT.
  constants GC_LIST_CELL_ACTION type STRING value 'FPM_GUIBB_LIST_CELL_ACTION' ##NO_TEXT.
  constants GC_RULE_SEC_SELECTION type STRING value 'ON_RULE_SEC_SELECTION' ##NO_TEXT.
  class-data GV_LEAD_INDEX type SYTABIX .
  class-data GV_CURR_INDEX_ORDER type YZ_DTEL_ORDER_ID .
  class-data GV_EXE_ID_GENERATED type BOOLE_D .

  class-methods CLASS_CONSTRUCTOR .

  methods IF_FPM_GUIBB_LIST~FLUSH
    redefinition .
  methods IF_FPM_GUIBB_LIST~GET_DATA
    redefinition .
  methods IF_FPM_GUIBB_LIST~GET_DEFINITION
    redefinition .
  methods IF_FPM_GUIBB_LIST~PROCESS_EVENT
    redefinition .
protected section.
private section.

  class-methods SET_EXE_ROW_READ_ONLY
    importing
      !IV_LEAD_INDEX type SYTABIX
      !IV_FPM_EVENT_ID type FPM_EVENT_ID
    exporting
      !EV_DATA_CHANGED type BOOLE_D
    changing
      !CT_DATA type DATA .
  class-methods SET_EXE_BUTTON_PROPERTY
    importing
      !IV_LEAD_INDEX type SYTABIX
      !IT_DATA type YZR_TT_YZ_PP_YZ_RULE_E
    exporting
      !EV_ACTION_USAGE_CHANGED type BOOLE_D
    changing
      !CT_ACTION_USAGE type FPMGB_T_ACTIONUSAGE .
  class-methods SET_EXE_ROW_ORDER_ID
    importing
      !IV_LEAD_INDEX type SYTABIX optional
      !IV_EVENT_ID type FPM_EVENT_ID
      !IT_DATA type YZR_TT_YZ_PP_YZ_RULE_E optional
    exporting
      !EV_DATA_CHANGED type BOOLE_D
    changing
      !CT_DATA type DATA .
  class-methods DERIVE_EXE_ROW_VALUE
    importing
      !IT_DATA type YZR_TT_YZ_PP_YZ_RULE_E
      !IV_LEAD_INDEX type SYTABIX
    exporting
      !EV_DATA_CHANGED type BOOLE_D
    changing
      !CT_DATA type DATA .
ENDCLASS.



CLASS YZ_CLAS_MDG_YZ_RULE_EXE_FEEDER IMPLEMENTATION.


  method CLASS_CONSTRUCTOR.
**fetching rule type
  SELECT * FROM yztabl_rule_typ WHERE rule_type IS NOT INITIAL INTO TABLE @gt_yztabl_rule_typ.
  endmethod.


  METHOD if_fpm_guibb_list~flush.

    DATA: lt_data TYPE STANDARD TABLE OF yzr_s_yz_pp_yz_rule_e.
    FIELD-SYMBOLS: <lt_data> TYPE ANY TABLE.

    CALL METHOD super->if_fpm_guibb_list~flush
      EXPORTING
        it_change_log   = it_change_log
        it_data         = it_data
        iv_old_lead_sel = iv_old_lead_sel
        iv_new_lead_sel = iv_new_lead_sel.

    ASSIGN it_data->* TO <lt_data>.
    CHECK sy-subrc IS INITIAL AND <lt_data> IS ASSIGNED AND <lt_data> IS NOT INITIAL.
    lt_data = CORRESPONDING #( <lt_data> ).
*    IF iv_new_lead_sel GT 0.
*      READ TABLE lt_data ASSIGNING FIELD-SYMBOL(<ls_data>) INDEX iv_old_lead_sel.
*      IF sy-subrc IS INITIAL AND <ls_data> IS ASSIGNED AND <ls_data> IS NOT INITIAL.
*        ASSIGN COMPONENT 'MODEL' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_model>).
*        IF  <lv_model> IS ASSIGNED AND <lv_model> IS NOT INITIAL.
*          SET PARAMETER ID 'YZ_PARAM_MODEL' FIELD <lv_model>.
*        ENDIF.
*        ASSIGN COMPONENT 'OTC' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_otc>).
*        IF <lv_otc> IS ASSIGNED AND <lv_otc> IS NOT INITIAL.
*          SET PARAMETER ID 'YZ_PARAM_OTC' FIELD <lv_otc>.
*        ENDIF.
*        ASSIGN COMPONENT 'ENTITY' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_entity>).
*        IF  <lv_entity> IS ASSIGNED AND <lv_entity> IS NOT INITIAL.
*          SET PARAMETER ID 'YZ_PARAM_ENTITY' FIELD <lv_entity>.
*        ENDIF.
*        ASSIGN COMPONENT 'ATTRIBUTE' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_attr>).
*        IF  <lv_attr> IS ASSIGNED AND <lv_attr> IS NOT INITIAL.
*          SET PARAMETER ID 'YZ_PARAM_ATTRIBUTE' FIELD <lv_attr>.
*        ENDIF.
*      ENDIF.
*    ENDIF.

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

    FIELD-SYMBOLS : <ls_data> TYPE yzr_s_yz_pp_yz_rule_e,
                    <lt_data> TYPE STANDARD TABLE.

    DATA: lt_data    TYPE yzr_tt_yz_pp_yz_rule_e,
          lo_bol_ref TYPE REF TO cl_crm_bol_entity.

    DATA: lt_values  TYPE if_fpm_list_ats_value_set=>ty_t_set.


    IF ct_data IS NOT INITIAL.
      ASSIGN ct_data TO <lt_data>.
      IF <lt_data> IS ASSIGNED AND <lt_data> IS NOT INITIAL.
        lt_data = CORRESPONDING #( <lt_data> ).
        IF iv_eventid->mv_event_id EQ 'FPM_LEAVE_INITIAL_SCREEN' AND yz_clas_mdg_yz_access=>gt_yz_rule_e IS INITIAL.
          yz_clas_mdg_yz_access=>set_entity_data( EXPORTING it_data = lt_data iv_entity = 'YZ_RULE_E' ).
        ENDIF.
*****setting execution rows default property as read only
        set_exe_row_read_only( EXPORTING iv_lead_index   = cv_lead_index iv_fpm_event_id = iv_eventid->mv_event_id
                               IMPORTING ev_data_changed = ev_data_changed
                               CHANGING  ct_data         = ct_data ).
*****setting property of buttons based on rule section value of seleccted row
        IF iv_eventid->mv_event_id EQ 'FPM_GUIBB_LIST_ON_LEAD_SELECTI'.
          set_exe_button_property( EXPORTING iv_lead_index           = cv_lead_index  it_data = lt_data
                                   IMPORTING ev_action_usage_changed = ev_action_usage_changed
                                   CHANGING  ct_action_usage         = ct_action_usage ).
        ENDIF.

        yz_clas_mdg_utility=>set_parameter_value( it_data = ct_data iv_param_name = 'YZ_PARAM_MODEL'     iv_component = 'MODEL'     iv_lead_selection = cv_lead_index ).
        yz_clas_mdg_utility=>set_parameter_value( it_data = ct_data iv_param_name = 'YZ_PARAM_OTC'       iv_component = 'OTC'       iv_lead_selection = cv_lead_index ).
        yz_clas_mdg_utility=>set_parameter_value( it_data = ct_data iv_param_name = 'YZ_PARAM_ENTITY'    iv_component = 'ENTITY'    iv_lead_selection = cv_lead_index ).
        yz_clas_mdg_utility=>set_parameter_value( it_data = ct_data iv_param_name = 'YZ_PARAM_ATTRIBUTE' iv_component = 'ATTRIBUTE' iv_lead_selection = cv_lead_index ).

*******deriving exe row field values
        IF iv_eventid->mv_event_id EQ '_CREA_' OR iv_eventid->mv_event_id EQ 'ON_RULE_SEC_SELECTION'."'AFTER_BOL_MODIFY' OR iv_eventid->mv_event_id EQ 'FPM_GUIBB_LIST_CELL_ACTION'.
          CLEAR gv_exe_id_generated.
          derive_exe_row_value( EXPORTING it_data         = lt_data   iv_lead_index   =  cv_lead_index
                                IMPORTING ev_data_changed = ev_data_changed
                                CHANGING  ct_data         = ct_data ).
        ENDIF.
*****setting execution rows order id
        IF iv_eventid->mv_event_id EQ '_CREA_' OR iv_eventid->mv_event_id EQ 'ON_RULE_SEC_SELECTION'  OR iv_eventid->mv_event_id EQ '_DELE_' .
          IF cv_lead_index GE 0 AND lines( ct_data ) GT 1.
            lt_data = CORRESPONDING #( <lt_data> ).
            set_exe_row_order_id( EXPORTING iv_lead_index   = cv_lead_index it_data = lt_data iv_event_id = iv_eventid->mv_event_id
                                  IMPORTING ev_data_changed = ev_data_changed
                                  CHANGING  ct_data         = ct_data ).
          ENDIF.
        ENDIF.

        IF gt_field_usage IS INITIAL.
          gt_field_usage = ct_field_usage.
        ENDIF.
        DATA: lt_fixed_value TYPE wdr_context_attr_value_list.

        READ TABLE lt_data INTO DATA(ls_data) INDEX cv_lead_index.
        IF sy-subrc IS INITIAL AND ls_data IS NOT INITIAL.
          READ TABLE ct_field_usage WITH KEY name = 'SEQ_NO' ASSIGNING FIELD-SYMBOL(<ls_field_usage>).
          IF sy-subrc IS INITIAL AND <ls_field_usage> IS ASSIGNED AND <ls_field_usage> IS NOT INITIAL.
            READ TABLE gt_field_usage INTO DATA(ls_field_usage) WITH KEY name = 'SEQ_NO'.
            <ls_field_usage>-fixed_values = ls_field_usage-fixed_values.
            CASE ls_data-rule_sec.
              WHEN '1'.
                lt_values = VALUE #( FOR ls_val IN <ls_field_usage>-fixed_values WHERE ( value CP '*U*' ) ( key = ls_val-value text = ls_val-text ) ).
              WHEN '2'.
                lt_values = VALUE #( FOR ls_val IN <ls_field_usage>-fixed_values WHERE ( value CP '*S*' ) ( key = ls_val-value text = ls_val-text ) ).
              WHEN '3'.
                lt_values = VALUE #( FOR ls_val IN <ls_field_usage>-fixed_values WHERE ( value CP '*C*' ) ( key = ls_val-value text = ls_val-text  ) ).
            ENDCASE.
            TRY.
                io_extended_ctrl->get_value_set_handler( )->set_row_specific_value_set(
                  EXPORTING
                    iv_column_id = 'SEQ_NO'
                    it_row_set   = lt_values
                    iv_row_index = cv_lead_index
                ).
                ev_data_changed = abap_true.
              CATCH cx_salv_column_unknown. " column name is not defined.
            ENDTRY.
          ENDIF.
        ENDIF.

        " Deriving Entity name on the basis of attribute.

        CLEAR lo_bol_ref.
        LOOP AT ct_data ASSIGNING FIELD-SYMBOL(<ls_data_exe>).
          CHECK <ls_data_exe> IS ASSIGNED.
          ASSIGN COMPONENT 'MODEL' OF STRUCTURE <ls_data_exe> TO FIELD-SYMBOL(<lv_model>).
          CHECK <lv_model> IS ASSIGNED.
          ASSIGN COMPONENT 'ATTRIBUTE' OF STRUCTURE <ls_data_exe> TO FIELD-SYMBOL(<lv_attribute>).
          CHECK <lv_attribute> IS ASSIGNED.
          ASSIGN COMPONENT 'ENTITY' OF STRUCTURE <ls_data_exe> TO FIELD-SYMBOL(<lv_entity>).
          CHECK <lv_entity> IS ASSIGNED.
          ASSIGN COMPONENT 'FPM_KEY_BY_BOL_ENTITY' OF STRUCTURE <ls_data_exe> TO FIELD-SYMBOL(<fs_o_ref>).
          CHECK <fs_o_ref> IS ASSIGNED.
          lo_bol_ref = <fs_o_ref>.
          SELECT entity FROM yztabl_ref_data UP TO 1 ROWS INTO @DATA(ls_entity)
                                             WHERE model = @<lv_model> AND attribute = @<lv_attribute> ORDER BY PRIMARY KEY.
          ENDSELECT.
          IF sy-subrc EQ 0.
            IF ls_entity IS NOT INITIAL AND <lv_entity> IS INITIAL.
              lo_bol_ref->if_bol_bo_property_access~set_property( EXPORTING iv_attr_name = 'ENTITY' iv_value = ls_entity ).
              ev_data_changed = abap_true.
            ENDIF.
          ENDIF.
        ENDLOOP.
      ENDIF.


*        IF sy-subrc IS INITIAL AND ls_data IS NOT INITIAL.
*          READ TABLE ct_field_usage WITH KEY name = 'EXE_TYPE' ASSIGNING <ls_field_usage>.
*          IF sy-subrc IS INITIAL AND <ls_field_usage> IS ASSIGNED AND <ls_field_usage> IS NOT INITIAL.
*            READ TABLE gt_field_usage INTO DATA(ls_field_usage) WITH KEY name = 'EXE_TYPE'.
*            <ls_field_usage>-fixed_values = ls_field_usage-fixed_values.
*            CASE ls_data-rule_sec.
*              WHEN '1'.
*                DELETE <ls_field_usage>-fixed_values WHERE value NP '*U*'.
*                <ls_field_usage>-fixed_values_changed = abap_true.
*                ev_field_usage_changed = abap_true.
*              WHEN '2'.
*                DELETE <ls_field_usage>-fixed_values WHERE value NP '*S*'.
*                <ls_field_usage>-fixed_values_changed = abap_true.
*                ev_field_usage_changed = abap_true.
*              WHEN '3'.
*                DELETE <ls_field_usage>-fixed_values WHERE value NP '*C*'.
*                <ls_field_usage>-fixed_values_changed = abap_true.
*                ev_field_usage_changed = abap_true.
*            ENDCASE.
*            TRY.
*                io_extended_ctrl->get_value_set_handler( )->set_row_specific_value_set(
*                  EXPORTING
*                    iv_column_id = 'EXE_TYPE'
*                    it_row_set   =
*                    iv_row_index = cv_lead_index
*                ).
*              CATCH cx_salv_column_unknown. " column name is not defined.
*            ENDTRY.
*          ENDIF.
*        ENDIF.

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

    et_action_definition = VALUE #( BASE et_action_definition
                                    ( id = if_fpm_guibb_list=>gc_guibb_list_on_cell_action  text = 'On Cell Action' enabled = abap_true visible = cl_wd_uielement=>e_visible-visible  )
                                    ( id = if_fpm_guibb_list=>gc_fpm_event_on_lead_sel      text = 'On Lead Select' enabled = abap_true visible = cl_wd_uielement=>e_visible-visible  )
                                    ( id = 'ON_LEADSELECTION'         text = 'On Lead Selection'           enabled = abap_true visible = cl_wd_uielement=>e_visible-visible  )
                                    ( id = 'ON_RULE_SEC_SELECTION'    text = 'On Rule Sec Selection' )
                                    ( id = 'ON_EXE_ID_GENERATION'     text = 'On exe id generation' )
                                    ( id = 'APPEND_USAGE'             text = 'Append Usage' ) "            enabled = abap_true disable_when_no_lead_sel = abap_true )
                                    ( id = 'APPEND_SCOPE'             text = 'Append Scope' ) "            enabled = abap_true disable_when_no_lead_sel = abap_true )
                                    ( id = 'APPEND_CONDITION'         text = 'Append Condition' )"         enabled = abap_true disable_when_no_lead_sel = abap_true )
                                    ( id = 'APPEND_CON_USAGE'         text = 'Append Consolidation Usage' ) "enabled = abap_true disable_when_no_lead_sel = abap_true )
                                    ( id = 'APPEND_EVA_USAGE'         text = 'Append Evaluation Usage' ) " enabled = abap_true disable_when_no_lead_sel = abap_true )
                                    ( id = 'APPEND_MAS_USAGE'         text = 'Append Mass Usage' ) "       enabled = abap_true disable_when_no_lead_sel = abap_true )
                                   ).


***storing read reference of fields in global variable
    IF et_field_description IS NOT INITIAL.
      gv_rule_sec_read_ref  = et_field_description[ name = 'RULE_SEC' ]-read_only_ref.
      gv_active_e_read_ref  = et_field_description[ name = 'ACTIVE_E' ]-read_only_ref.
      gv_attribute_read_ref = et_field_description[ name = 'ATTRIBUTE' ]-read_only_ref.
      gv_class_read_ref     = et_field_description[ name = 'CLASS' ]-read_only_ref.
      gv_entity_read_ref    = et_field_description[ name = 'ENTITY' ]-read_only_ref.
      gv_etemp_id_read_ref  = et_field_description[ name = 'ETEMP_ID' ]-read_only_ref.
      gv_exe_type_read_ref  = et_field_description[ name = 'EXE_TYPE' ]-read_only_ref.
      gv_method_read_ref    = et_field_description[ name = 'METHOD' ]-read_only_ref.
      gv_operation_read_ref = et_field_description[ name = 'OPERATION' ]-read_only_ref.
      gv_operator_read_ref  = et_field_description[ name = 'OPERATOR' ]-read_only_ref.
      gv_seq_no_read_ref    = et_field_description[ name = 'SEQ_NO' ]-read_only_ref.
      gv_task_read_ref      = et_field_description[ name = 'TASK' ]-read_only_ref.
    ENDIF.
***Define one-click actions
    APPEND INITIAL LINE TO et_row_actions ASSIGNING FIELD-SYMBOL(<fs_row_action>).
    <fs_row_action>-id =  'ROW_EDIT'.
    APPEND INITIAL LINE TO et_row_actions ASSIGNING <fs_row_action>.
    <fs_row_action>-id =  'ROW_DELETE'.

*    et_field_description[ name = 'SEQ_NO' ]-fixed_values_is_row_specific   = abap_true.
*    et_field_description[ name = 'EXE_TYPE' ]-fixed_values_is_row_specific = abap_true.

  ENDMETHOD.


  METHOD if_fpm_guibb_list~process_event.

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


    IF io_event->mv_event_id EQ 'APPEND_CONDITION' OR io_event->mv_event_id EQ 'APPEND_SCOPE' OR io_event->mv_event_id EQ 'APPEND_CON_USAGE' OR io_event->mv_event_id EQ 'APPEND_EVA_USAGE'
                             OR io_event->mv_event_id EQ 'APPEND_MAS_USAGE' OR io_event->mv_event_id EQ 'BOL_COPY'.
      me->raise_local_event_by_id( iv_event_id = '_CREA_' ).
      mv_last_action = io_event->mv_event_id.
    ENDIF.

  ENDMETHOD.


  METHOD derive_exe_row_value.

    DATA lo_bol_ref TYPE REF TO cl_crm_bol_entity.

    LOOP AT ct_data ASSIGNING FIELD-SYMBOL(<cs_data>).
      IF <cs_data> IS ASSIGNED AND <cs_data> IS NOT INITIAL.
        ASSIGN COMPONENT 'EXE_ID' OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<iv_exe_id>).
        IF <iv_exe_id> IS ASSIGNED AND <iv_exe_id> IS INITIAL.
          ASSIGN COMPONENT 'RULE_SEC' OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<iv_rule_sec>).
          ASSIGN COMPONENT 'SEQ_NO' OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<iv_rule_seq>).
          ASSIGN COMPONENT 'TASK' OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<iv_rule_task>).
          ASSIGN COMPONENT 'OPERATION' OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<iv_rule_operation>).
          ASSIGN COMPONENT 'EXE_TYPE' OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<is_rule_exe_type>).
          ASSIGN COMPONENT 'ENTITY' OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<is_rule_entity>).
          ASSIGN COMPONENT 'ATTRIBUTE' OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<is_rule_attr>).
          ASSIGN COMPONENT 'RULE_TYPE' OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<is_rule_type>).
          ASSIGN COMPONENT 'ORDER_ID' OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<is_order_id>).
          ASSIGN COMPONENT 'FPM_KEY_BY_BOL_ENTITY' OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<fs_o_ref>).
          lo_bol_ref = <fs_o_ref>.
          IF lines( ct_data ) EQ 1.
            IF <iv_rule_sec> IS ASSIGNED AND <iv_rule_sec> IS INITIAL.
              <iv_rule_sec> = '1'.
              lo_bol_ref->if_bol_bo_property_access~set_property( iv_attr_name = 'RULE_SEC' iv_value = <iv_rule_sec> ).
            ENDIF.
            IF <is_order_id> IS ASSIGNED AND <is_order_id> IS INITIAL.
              <is_order_id> = 1.
              lo_bol_ref->if_bol_bo_property_access~set_property( iv_attr_name = 'ORDER_ID' iv_value = <is_order_id> ).
            ENDIF.
          ENDIF.

          IF mv_last_action EQ 'APPEND_CONDITION' OR mv_last_action EQ 'APPEND_SCOPE' OR mv_last_action EQ 'APPEND_CON_USAGE' OR mv_last_action EQ 'APPEND_EVA_USAGE' OR mv_last_action EQ 'APPEND_MAS_USAGE' OR mv_last_action EQ 'BOL_COPY' .
            DATA(ls_data) = it_data[ iv_lead_index ].
            <iv_rule_sec>       = ls_data-rule_sec.  lo_bol_ref->if_bol_bo_property_access~set_property( iv_attr_name = 'RULE_SEC' iv_value = <iv_rule_sec> ).
            <iv_rule_seq>       = ls_data-seq_no.    lo_bol_ref->if_bol_bo_property_access~set_property( iv_attr_name = 'SEQ_NO'   iv_value = <iv_rule_seq> ).
            <iv_rule_task>      = ls_data-task.      lo_bol_ref->if_bol_bo_property_access~set_property( iv_attr_name = 'TASK'     iv_value = <iv_rule_task> ).
            <is_rule_exe_type>  = ls_data-exe_type.  lo_bol_ref->if_bol_bo_property_access~set_property( iv_attr_name = 'EXE_TYPE' iv_value = <is_rule_exe_type> ).
            <iv_rule_operation> = ls_data-operation. lo_bol_ref->if_bol_bo_property_access~set_property( iv_attr_name = 'OPERATION' iv_value = <iv_rule_operation> ).
            <is_rule_entity>    = COND #( WHEN mv_last_action EQ 'APPEND_CON_USAGE' OR mv_last_action EQ 'APPEND_CON_USAGE' OR mv_last_action EQ 'APPEND_EVA_USAGE' THEN 'YYUSAGE'
                                          WHEN mv_last_action EQ 'BOL_COPY'       THEN ls_data-entity ).
            lo_bol_ref->if_bol_bo_property_access~set_property( iv_attr_name = 'ENTITY' iv_value = <is_rule_entity> ).
            <is_rule_attr>      = COND #( WHEN mv_last_action EQ 'APPEND_CON_USAGE' OR mv_last_action EQ 'APPEND_MAS_USAGE' OR mv_last_action EQ 'APPEND_EVA_USAGE'  THEN 'RULE_STAG'
                                        WHEN mv_last_action EQ 'BOL_COPY' THEN ls_data-attribute ).
            lo_bol_ref->if_bol_bo_property_access~set_property( iv_attr_name = 'ATTRIBUTE' iv_value = <is_rule_attr> ).

            CLEAR mv_last_action.
          ENDIF.

          IF <iv_exe_id> IS INITIAL AND <iv_rule_sec> IS NOT INITIAL. """deriving exe_id field value
            ASSIGN COMPONENT 'DEF_ID' OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<iv_def_id>).
            <iv_exe_id> = <iv_def_id> && '_' && <iv_rule_sec> && '_' && yz_clas_mdg_accelerator=>get_nr_exe_id_for_rule( iv_def_id = <iv_def_id> iv_rule_sec = <iv_rule_sec> it_tab = ct_data ).
            CONDENSE <iv_exe_id>.
            lo_bol_ref->if_bol_bo_property_access~set_property( iv_attr_name = 'EXE_ID' iv_value = <iv_exe_id> ).
            IF sy-subrc = 0.
              gv_exe_id_generated = abap_true.
              ASSIGN COMPONENT 'ACTIVE_E' OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<is_rule_active_e>). """setting active indicator as 'X' for newly added row
              IF <is_rule_active_e> IS ASSIGNED AND <is_rule_active_e> IS INITIAL.
                <is_rule_active_e> = 'X'.
                lo_bol_ref->if_bol_bo_property_access~set_property( iv_attr_name = 'ACTIVE_E' iv_value = <is_rule_active_e> ).
                ev_data_changed = abap_true.
              ENDIF.
            ENDIF.
          ENDIF.

        ENDIF.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  method SET_EXE_BUTTON_PROPERTY.

   IF iv_lead_index GT 0 AND it_data IS NOT INITIAL .
    DATA(ls_data) = it_data[ iv_lead_index ].
    gv_curr_index_order = ls_data-order_id. """current index order id - to be used to rearrange order id
    CASE ls_data-rule_sec.
      WHEN '1'.
       READ TABLE ct_action_usage ASSIGNING FIELD-SYMBOL(<ls_action_usage>) WITH KEY ID = 'APPEND_CON_USAGE'.
*       ASSIGN ct_action_usage[ ID = 'APPEND_CON_USAGE' ] TO <ls_action_usage>.
        IF sy-subrc = 0 AND <ls_action_usage> IS ASSIGNED.
         <ls_action_usage>-enabled = abap_true.
        ENDIF.
       READ TABLE ct_action_usage ASSIGNING <ls_action_usage> WITH KEY ID = 'APPEND_EVA_USAGE'.
        IF sy-subrc = 0 AND <ls_action_usage> IS ASSIGNED.
         <ls_action_usage>-enabled = abap_true.
        ENDIF.
       READ TABLE ct_action_usage ASSIGNING <ls_action_usage> WITH KEY ID = 'APPEND_MAS_USAGE'.
        IF sy-subrc = 0 AND <ls_action_usage> IS ASSIGNED.
         <ls_action_usage>-enabled = abap_true.
        ENDIF.
      WHEN '2'.
       READ TABLE ct_action_usage ASSIGNING <ls_action_usage> WITH KEY ID = 'APPEND_SCOPE'.
        IF sy-subrc = 0 AND <ls_action_usage> IS ASSIGNED.
         <ls_action_usage>-enabled = abap_true.
        ENDIF.
      WHEN '3'.
       READ TABLE ct_action_usage ASSIGNING <ls_action_usage> WITH KEY ID = 'APPEND_CONDITION'.
        IF sy-subrc = 0 AND <ls_action_usage> IS ASSIGNED.
         <ls_action_usage>-enabled = abap_true.
        ENDIF.
    ENDCASE.
    ev_action_usage_changed	= abap_true.
    ENDIF.
  endmethod.


  METHOD set_exe_row_order_id.

    DATA lo_bol_ref TYPE REF TO cl_crm_bol_entity.
    DATA lt_data TYPE yzr_tt_yz_pp_yz_rule_e.

    DATA(lv_curr_index_order) = gv_curr_index_order..
    lt_data = it_data.
    SORT lt_data BY order_id.
  IF NOT line_exists( lt_data[ exe_id = abap_false ] ).
    LOOP AT lt_data INTO DATA(ls_data).
      IF ls_data-order_id GE lv_curr_index_order.
        ls_data-order_id = COND #( WHEN iv_event_id EQ '_CREA_' AND gv_exe_id_generated EQ abap_true AND ls_data-order_id GT lv_curr_index_order THEN ls_data-order_id + 1
                                   WHEN iv_event_id EQ 'ON_RULE_SEC_SELECTION' AND gv_exe_id_generated EQ abap_true AND ls_data-order_id GT lv_curr_index_order THEN ls_data-order_id + 1
                                   WHEN iv_event_id EQ '_DELE_' AND ls_data-order_id GE lv_curr_index_order THEN ls_data-order_id - 1
                                   ELSE ls_data-order_id ).
      ELSEIF ls_data-order_id IS INITIAL.
        ls_data-order_id = lv_curr_index_order + 1.
        gv_curr_index_order = gv_curr_index_order + 1.
      ENDIF.
      MODIFY lt_data FROM ls_data.
      CLEAR ls_data.
    ENDLOOP.
    LOOP AT ct_data ASSIGNING FIELD-SYMBOL(<cs_data>).
      ASSIGN COMPONENT 'EXE_ID' OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<fs_exe_id>).
      ASSIGN COMPONENT 'ORDER_ID' OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<fs_order_id>).
      ASSIGN COMPONENT 'FPM_KEY_BY_BOL_ENTITY' OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<fs_o_ref>).
      lo_bol_ref = <fs_o_ref>.
      IF <fs_exe_id> IS ASSIGNED AND <fs_exe_id> IS NOT INITIAL.
        <fs_order_id> = lt_data[ exe_id = <fs_exe_id> ]-order_id.
        lo_bol_ref->if_bol_bo_property_access~set_property( iv_attr_name = 'ORDER_ID' iv_value = <fs_order_id> ).
      ENDIF.
    ENDLOOP.

    ev_data_changed = abap_true.
    CLEAR gv_exe_id_generated.
  ENDIF.

  ENDMETHOD.


  METHOD set_exe_row_read_only.

    gv_prev_index = iv_lead_index.
    LOOP AT ct_data ASSIGNING FIELD-SYMBOL(<cs_data>).
      IF <cs_data> IS ASSIGNED AND <cs_data> IS NOT INITIAL.
        ASSIGN COMPONENT gv_active_e_read_ref OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<is_active_e>).
        ASSIGN COMPONENT gv_attribute_read_ref OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<is_attribute>).
        ASSIGN COMPONENT gv_class_read_ref OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<is_class>).
        ASSIGN COMPONENT gv_entity_read_ref OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<is_entity>).
        ASSIGN COMPONENT gv_etemp_id_read_ref OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<is_etemp_id>).
        ASSIGN COMPONENT gv_exe_type_read_ref OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<is_exe_type>).
        ASSIGN COMPONENT gv_method_read_ref OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<is_method>).
        ASSIGN COMPONENT gv_operation_read_ref OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<is_operation>).
        ASSIGN COMPONENT gv_operator_read_ref OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<is_operator>).
        ASSIGN COMPONENT gv_seq_no_read_ref OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<is_seq_no>).
        ASSIGN COMPONENT gv_task_read_ref OF STRUCTURE <cs_data> TO FIELD-SYMBOL(<is_task>).

        IF <is_seq_no> IS ASSIGNED AND <is_exe_type> IS ASSIGNED AND <is_operation> IS ASSIGNED AND <is_operator> IS ASSIGNED AND <is_etemp_id> IS ASSIGNED AND <is_active_e> IS ASSIGNED AND
           <is_entity> IS ASSIGNED AND <is_attribute> IS ASSIGNED AND <is_class> IS ASSIGNED AND <is_method> IS ASSIGNED .
          <is_active_e>  = COND #( WHEN iv_lead_index EQ sy-tabix AND iv_fpm_event_id EQ gc_row_edit THEN abap_false
                                   WHEN iv_lead_index EQ gv_prev_index AND iv_lead_index EQ sy-tabix AND iv_fpm_event_id EQ gc_list_cell_action THEN abap_false
                                   WHEN iv_lead_index EQ gv_prev_index AND iv_lead_index EQ sy-tabix AND iv_fpm_event_id EQ gc_rule_sec_selection THEN abap_false
                                   ELSE abap_true ).
          <is_attribute> = COND #( WHEN iv_lead_index EQ sy-tabix AND iv_fpm_event_id EQ gc_row_edit THEN abap_false
                                   WHEN iv_lead_index EQ gv_prev_index AND iv_lead_index EQ sy-tabix AND iv_fpm_event_id EQ gc_list_cell_action THEN abap_false
                                   WHEN iv_lead_index EQ gv_prev_index AND iv_lead_index EQ sy-tabix AND iv_fpm_event_id EQ gc_rule_sec_selection THEN abap_false
                                   ELSE abap_true ).
          <is_class>     = COND #( WHEN iv_lead_index EQ sy-tabix AND iv_fpm_event_id EQ gc_row_edit THEN abap_false
                                   WHEN iv_lead_index EQ gv_prev_index AND iv_lead_index EQ sy-tabix AND iv_fpm_event_id EQ gc_list_cell_action THEN abap_false
                                   WHEN iv_lead_index EQ gv_prev_index AND iv_lead_index EQ sy-tabix AND iv_fpm_event_id EQ gc_rule_sec_selection THEN abap_false
                                   ELSE abap_true ).
          <is_entity>    = COND #( WHEN iv_lead_index EQ sy-tabix AND iv_fpm_event_id EQ gc_row_edit THEN abap_false
                                   WHEN iv_lead_index EQ gv_prev_index AND iv_lead_index EQ sy-tabix AND iv_fpm_event_id EQ gc_list_cell_action THEN abap_false
                                   WHEN iv_lead_index EQ gv_prev_index AND iv_lead_index EQ sy-tabix AND iv_fpm_event_id EQ gc_rule_sec_selection THEN abap_false
                                   ELSE abap_true ).
          <is_etemp_id>  = COND #( WHEN iv_lead_index EQ sy-tabix AND iv_fpm_event_id EQ gc_row_edit THEN abap_false
                                   WHEN iv_lead_index EQ gv_prev_index AND iv_lead_index EQ sy-tabix AND iv_fpm_event_id EQ gc_list_cell_action THEN abap_false
                                   WHEN iv_lead_index EQ gv_prev_index AND iv_lead_index EQ sy-tabix AND iv_fpm_event_id EQ gc_rule_sec_selection THEN abap_false
                                   ELSE abap_true ).
          <is_exe_type>  = COND #( WHEN iv_lead_index EQ sy-tabix AND iv_fpm_event_id EQ gc_row_edit THEN abap_false
                                   WHEN iv_lead_index EQ gv_prev_index AND iv_lead_index EQ sy-tabix AND iv_fpm_event_id EQ gc_list_cell_action THEN abap_false
                                   WHEN iv_lead_index EQ gv_prev_index AND iv_lead_index EQ sy-tabix AND iv_fpm_event_id EQ gc_rule_sec_selection THEN abap_false
                                   ELSE abap_true ).
          <is_method>    = COND #( WHEN iv_lead_index EQ sy-tabix AND iv_fpm_event_id EQ gc_row_edit THEN abap_false
                                   WHEN iv_lead_index EQ gv_prev_index AND iv_lead_index EQ sy-tabix AND iv_fpm_event_id EQ gc_list_cell_action THEN abap_false
                                   WHEN iv_lead_index EQ gv_prev_index AND iv_lead_index EQ sy-tabix AND iv_fpm_event_id EQ gc_rule_sec_selection THEN abap_false
                                   ELSE abap_true ).
          <is_operation> = COND #( WHEN iv_lead_index EQ sy-tabix AND iv_fpm_event_id EQ gc_row_edit THEN abap_false
                                   WHEN iv_lead_index EQ gv_prev_index AND iv_lead_index EQ sy-tabix AND iv_fpm_event_id EQ gc_list_cell_action THEN abap_false
                                   WHEN iv_lead_index EQ gv_prev_index AND iv_lead_index EQ sy-tabix AND iv_fpm_event_id EQ gc_rule_sec_selection THEN abap_false
                                   ELSE abap_true ).
          <is_operator>  = COND #( WHEN iv_lead_index EQ sy-tabix AND iv_fpm_event_id EQ gc_row_edit THEN abap_false
                                   WHEN iv_lead_index EQ gv_prev_index AND iv_lead_index EQ sy-tabix AND iv_fpm_event_id EQ gc_list_cell_action THEN abap_false
                                   WHEN iv_lead_index EQ gv_prev_index AND iv_lead_index EQ sy-tabix AND iv_fpm_event_id EQ gc_rule_sec_selection THEN abap_false
                                   ELSE abap_true ).
          <is_seq_no>    = COND #( WHEN iv_lead_index EQ sy-tabix AND iv_fpm_event_id EQ gc_row_edit THEN abap_false
                                   WHEN iv_lead_index EQ gv_prev_index AND iv_lead_index EQ sy-tabix AND iv_fpm_event_id EQ gc_list_cell_action THEN abap_false
                                   WHEN iv_lead_index EQ gv_prev_index AND iv_lead_index EQ sy-tabix AND iv_fpm_event_id EQ gc_rule_sec_selection THEN abap_false
                                   ELSE abap_true ).
          <is_task>      = COND #( WHEN iv_lead_index EQ sy-tabix AND iv_fpm_event_id EQ gc_row_edit THEN abap_false
                                   WHEN iv_lead_index EQ gv_prev_index AND iv_lead_index EQ sy-tabix AND iv_fpm_event_id EQ gc_list_cell_action THEN abap_false
                                   WHEN iv_lead_index EQ gv_prev_index AND iv_lead_index EQ sy-tabix AND iv_fpm_event_id EQ gc_rule_sec_selection THEN abap_false
                                   ELSE abap_true ).
        ENDIF.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
