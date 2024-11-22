class YZ_CLAS_MDG_YZ_RULE_TMP_FEEDER definition
  public
  inheriting from CL_MDG_BS_GUIBB_FORM
  final
  create public .

public section.

  aliases CS_PORT_TYPE
    for IF_FPM_FEEDER_MODEL~CS_PORT_TYPE .
  aliases MV_TOOL_ID
    for IF_FPM_FEEDER_ENH_BO_ACCESS~MV_TOOL_ID .
  aliases AFTER_FAILED_EVENT
    for IF_FPM_GUIBB_FORM_EXT~AFTER_FAILED_EVENT .
  aliases BEFORE_DISPATCH_EVENT
    for IF_FPM_GUIBB_FORM_EXT~BEFORE_DISPATCH_EVENT .
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
  aliases GET_DATA
    for IF_FPM_GUIBB_FORM~GET_DATA .
  aliases GET_DEFINITION
    for IF_FPM_GUIBB_FORM~GET_DEFINITION .
  aliases GET_ENHANCED_OBJECTS
    for IF_FPM_FEEDER_ENH_BO_ACCESS~GET_ENHANCED_OBJECTS .
  aliases GET_ENHANCED_OBJECT_PARTS
    for IF_FPM_FEEDER_ENH_BO_ACCESS~GET_ENHANCED_OBJECT_PARTS .
  aliases GET_INPORT_KEY
    for IF_FPM_FEEDER_MODEL~GET_INPORT_KEY .
  aliases GET_NAMESPACE
    for IF_FPM_FEEDER_MODEL~GET_NAMESPACE .
  aliases HANDLE_PHASE_0
    for IF_FPM_GUIBB_OVS~HANDLE_PHASE_0 .
  aliases HANDLE_PHASE_1
    for IF_FPM_GUIBB_OVS~HANDLE_PHASE_1 .
  aliases HANDLE_PHASE_2
    for IF_FPM_GUIBB_OVS~HANDLE_PHASE_2 .
  aliases HANDLE_PHASE_3
    for IF_FPM_GUIBB_OVS~HANDLE_PHASE_3 .

  methods IF_FPM_GUIBB_FORM~FLUSH
    redefinition .
  methods IF_FPM_GUIBB_FORM~GET_DATA
    redefinition .
  methods IF_FPM_GUIBB_FORM~GET_DEFINITION
    redefinition .
  methods IF_FPM_GUIBB_FORM~PROCESS_EVENT
    redefinition .
protected section.

  methods GET_INITIAL_DATA
    redefinition .
private section.

  aliases MS_PARAMETER_RENDER
    for IF_FPM_GUIBB~MS_PARAMETER_RENDER .
  aliases GET_OUTPORTS
    for IF_FPM_FEEDER_MODEL~GET_OUTPORTS .
  aliases GET_OUTPORT_DATA
    for IF_FPM_FEEDER_MODEL~GET_OUTPORT_DATA .
  aliases GET_PARAMETER_LIST
    for IF_FPM_GUIBB~GET_PARAMETER_LIST .
  aliases INITIALIZE
    for IF_FPM_GUIBB~INITIALIZE .
  aliases PROCESS_CTXT_MENU
    for IF_FPM_GUIBB_CTXT_MENU~PROCESS_CTXT_MENU .
  aliases SET_CONNECTOR
    for IF_FPM_FEEDER_MODEL~SET_CONNECTOR .
  aliases TY_S_PORT
    for IF_FPM_FEEDER_MODEL~TY_S_PORT .
  aliases TY_T_PORT
    for IF_FPM_FEEDER_MODEL~TY_T_PORT .
ENDCLASS.



CLASS YZ_CLAS_MDG_YZ_RULE_TMP_FEEDER IMPLEMENTATION.


  METHOD GET_INITIAL_DATA.
    CALL METHOD super->get_initial_data
      EXPORTING
        iv_event_id     = iv_event_id
      RECEIVING
        rs_initial_data = rs_initial_data.

  ENDMETHOD.


  METHOD IF_FPM_GUIBB_FORM~FLUSH.

    CALL METHOD super->if_fpm_guibb_form~flush
      EXPORTING
        it_change_log = it_change_log
        is_data       = is_data.

    LOOP AT it_change_log INTO DATA(ls_change_log).
      IF ls_change_log-name = 'MODEL_T'.
        SET PARAMETER ID 'YZ_PARAM_MODEL' FIELD ls_change_log-new_value->*.
      ENDIF.
      IF ls_change_log-name = 'OTC_T'.
        SET PARAMETER ID 'YZ_PARAM_OTC' FIELD ls_change_log-new_value->*.
      ENDIF.
  ENDLOOP.

ENDMETHOD.


  METHOD IF_FPM_GUIBB_FORM~GET_DATA.

    CALL METHOD super->if_fpm_guibb_form~get_data
      EXPORTING
        io_event                = io_event
        iv_raised_by_own_ui     = iv_raised_by_own_ui
        it_selected_fields      = it_selected_fields
        iv_edit_mode            = iv_edit_mode
        io_extended_ctrl        = io_extended_ctrl
      IMPORTING
        et_messages             = et_messages
        ev_data_changed         = ev_data_changed
        ev_field_usage_changed  = ev_field_usage_changed
        ev_action_usage_changed = ev_action_usage_changed
      CHANGING
        cs_data                 = cs_data
        ct_field_usage          = ct_field_usage
        ct_action_usage         = ct_action_usage.
*******************************************************************************************
    FIELD-SYMBOLS : <fs_data> TYPE yzr_s_yz_pp_yz_rule_t.

****Setting rule definition ID field property as mandatory
    READ TABLE ct_field_usage ASSIGNING FIELD-SYMBOL(<fs_def_field>) WITH KEY name = 'TMP_ID'.
    IF sy-subrc = 0.
      <fs_def_field>-mandatory = 'X'.
      ev_field_usage_changed = abap_true.
    ENDIF.

***Deriving rule definition ID
    IF cs_data IS NOT INITIAL.
      ASSIGN: cs_data TO <fs_data> CASTING.
      CHECK <fs_data> IS ASSIGNED.
      IF <fs_data>-tmp_id IS INITIAL AND iv_edit_mode EQ 'E' AND io_event->mv_event_id EQ 'AFTER_BOL_MODIFY'.
        IF <fs_data>-model_t IS NOT INITIAL AND <fs_data>-otc_t IS NOT INITIAL AND <fs_data>-rtype_t IS NOT INITIAL.
          <fs_data>-tmp_id = yz_clas_mdg_accelerator=>get_nr_tmp_id_for_rule( ).
          CONDENSE <fs_data>-tmp_id.
          me->mo_entity->set_properties( cs_data ).
          ev_data_changed = abap_true.
        ENDIF.
      ENDIF.
    ENDIF.

  ENDMETHOD.


  METHOD IF_FPM_GUIBB_FORM~GET_DEFINITION.
    CALL METHOD super->if_fpm_guibb_form~get_definition
      IMPORTING
        eo_field_catalog         = eo_field_catalog
        et_field_description     = et_field_description
        et_action_definition     = et_action_definition
        et_special_groups        = et_special_groups
        et_dnd_definition        = et_dnd_definition
        es_options               = es_options
        es_message               = es_message
        ev_additional_error_info = ev_additional_error_info.

*    READ TABLE et_field_description WITH KEY name = 'MODEL' ASSIGNING FIELD-SYMBOL(<lv_srch_help>).
*    IF sy-subrc IS INITIAL AND <lv_srch_help> IS ASSIGNED.
*      <lv_srch_help>-ddic_shlp_name = 'YZ_SHLP_RULE_DML'.
*    ENDIF.
*
*    READ TABLE et_field_description WITH KEY name = 'OTC' ASSIGNING <lv_srch_help>.
*    IF sy-subrc IS INITIAL AND <lv_srch_help> IS ASSIGNED.
*      <lv_srch_help>-ddic_shlp_name = 'YZ_SHLP_RULE_DML'.
*    ENDIF.
  ENDMETHOD.


  METHOD IF_FPM_GUIBB_FORM~PROCESS_EVENT.
    CALL METHOD super->if_fpm_guibb_form~process_event
      EXPORTING
        io_event            = io_event
        iv_raised_by_own_ui = iv_raised_by_own_ui
      IMPORTING
        ev_result           = ev_result
        et_messages         = et_messages.
  ENDMETHOD.
ENDCLASS.
