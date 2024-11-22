class YZ_CLAS_MDG_YZ_SEARCH_FEEDER definition
  public
  inheriting from CL_USMD_SEARCH_GUIBB_RESULT
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
  aliases HAS_DYNAMIC_CONFIGURATION
    for IF_FPM_GUIBB_DYNAMIC_CONFIG~HAS_DYNAMIC_CONFIGURATION .
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

  methods CONSTRUCTOR .

  methods IF_FPM_GUIBB_LIST~GET_DATA
    redefinition .
  methods IF_FPM_GUIBB_LIST~GET_DEFINITION
    redefinition .
  methods IF_FPM_GUIBB_LIST~PROCESS_EVENT
    redefinition .
  methods IF_FPM_GUIBB~INITIALIZE
    redefinition .
protected section.

  methods NAVIGATE_TO_OVP
    redefinition .
private section.
ENDCLASS.



CLASS YZ_CLAS_MDG_YZ_SEARCH_FEEDER IMPLEMENTATION.


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

  ENDMETHOD.


  method IF_FPM_GUIBB_LIST~GET_DATA.
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

  endmethod.


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

    DATA ls_action_def TYPE fpmgb_s_actiondef.
* Lead Selection for GUIBB List
    CLEAR ls_action_def .
    ls_action_def-enabled = abap_true.
    ls_action_def-visible = cl_wd_uielement=>e_visible-visible.
    ls_action_def-id = 'ON_LEADSELECTION'.
    APPEND ls_action_def TO et_action_definition.
  ENDMETHOD.


  METHOD constructor.
    super->constructor( ).
*    IF sy-uname = 'HARKUMARI'.
*      DATA cloner TYPE REF TO if_bs_bol_entity_cloner.
*      cloner = cl_bs_bol_entity_cloner=>get_instance(
*                 iv_genil_component = 'ZSP_YZ'
*                 iv_class_name      = 'YZ_CLAS_MDG_YZ_BOL_ENTITY_CLON'
*               ).
*      DATA complete_pattern TYPE REF TO if_bs_bol_entity_clone_pattern.
*      complete_pattern = cloner->pattern( 'Complete' ).
*      DATA standard_pattern TYPE REF TO if_bs_bol_entity_clone_pattern.
*      standard_pattern = cloner->pattern( ).

*      standard_pattern->vindicate_entity(
*        EXPORTING
*          iv_entity_name     = 'YZ_RULE_D'
**          iv_parent_relation =
*      ).


*    ENDIF.
  ENDMETHOD.


  METHOD if_fpm_guibb~initialize.
    CALL METHOD super->if_fpm_guibb~initialize
      EXPORTING
        it_parameter      = it_parameter
        io_app_parameter  = io_app_parameter
        iv_component_name = iv_component_name
        is_config_key     = is_config_key
        iv_instance_id    = iv_instance_id.

    me->mv_link_column = 'DEF_ID'.

*    IF sy-uname = 'HARKUMARI'.
*      me->mo_entity_cloner = cl_bs_bol_entity_cloner=>get_instance(
*                                iv_genil_component = 'ZSP_YZ'
*                                iv_class_name      = 'YZ_CLAS_MDG_YZ_BOL_ENTITY_CLON'
*                              ).
*      DATA lo_stem_entity TYPE REF TO CL_CRM_BOL_ENTITY.
*      DATA ro_cloned_entity TYPE REF TO CL_CRM_BOL_ENTITY.
*      DATA standard_pattern TYPE REF TO if_bs_bol_entity_clone_pattern.
*      standard_pattern = me->mo_entity_cloner->pattern( ).
*      me->mo_entity_cloner->rise(
*        EXPORTING
*          io_stem_entity      = lo_stem_entity
**          iv_depth            = 100
**          iv_using_pattern_id = gc_standard_pattern
**          it_fixings          =
*        RECEIVING
*          ro_cloned_entity    = ro_cloned_entity
*      ).
*
*      ENDIF.




  ENDMETHOD.


  method NAVIGATE_TO_OVP.
    DATA:
      lo_communicator TYPE REF TO cl_mdg_bs_communicator_assist,
      lt_parameters   TYPE tihttpnvp.

    FIELD-SYMBOLS:
      <ls_parameter> LIKE LINE OF lt_parameters.

* get params and communicator
    lt_parameters = it_additional_url_parameters.
    lo_communicator = cl_mdg_bs_communicator_assist=>get_instance( ).

* check if there is a CRTYPE set
    IF lo_communicator IS BOUND
      AND lo_communicator->mv_cba_crequest_type IS NOT INITIAL.
*   If yes, ensure that this will become a navi parameter for OVP based CBAs
      APPEND INITIAL LINE TO lt_parameters ASSIGNING <ls_parameter>.
      <ls_parameter>-name  = lo_communicator->gc_parameter-dim_crequest_type.
      <ls_parameter>-value = lo_communicator->mv_cba_crequest_type.
    ENDIF.

* forward to parent
    super->navigate_to_ovp( EXPORTING it_additional_url_parameters = lt_parameters ).

  endmethod.
ENDCLASS.
