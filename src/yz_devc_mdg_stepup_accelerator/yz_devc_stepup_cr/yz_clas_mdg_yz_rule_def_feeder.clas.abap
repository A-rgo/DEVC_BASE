class YZ_CLAS_MDG_YZ_RULE_DEF_FEEDER definition
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

  class-methods GET_YZ_RULE_D .

  methods IF_FPM_GUIBB_FORM~FLUSH
    redefinition .
  methods IF_FPM_GUIBB_FORM~GET_DATA
    redefinition .
  methods IF_FPM_GUIBB_FORM~PROCESS_EVENT
    redefinition .
  methods IF_FPM_GUIBB_FORM~GET_DEFINITION
    redefinition .
protected section.

  methods GET_INITIAL_DATA
    redefinition .
  PRIVATE SECTION.

    ALIASES ms_parameter_render
      FOR if_fpm_guibb~ms_parameter_render .
    ALIASES get_outports
      FOR if_fpm_feeder_model~get_outports .
    ALIASES get_outport_data
      FOR if_fpm_feeder_model~get_outport_data .
    ALIASES get_parameter_list
      FOR if_fpm_guibb~get_parameter_list .
    ALIASES initialize
      FOR if_fpm_guibb~initialize .
    ALIASES process_ctxt_menu
      FOR if_fpm_guibb_ctxt_menu~process_ctxt_menu .
    ALIASES set_connector
      FOR if_fpm_feeder_model~set_connector .
    ALIASES ty_s_port
      FOR if_fpm_feeder_model~ty_s_port .
    ALIASES ty_t_port
      FOR if_fpm_feeder_model~ty_t_port .
ENDCLASS.



CLASS YZ_CLAS_MDG_YZ_RULE_DEF_FEEDER IMPLEMENTATION.


  METHOD if_fpm_guibb_form~get_data.

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


    FIELD-SYMBOLS : <fs_data> TYPE yzr_s_yz_pp_yz_rule_d.
    DATA lt_data TYPE yzr_tt_yz_pp_yz_rule_d.

****Setting Reference rule ID field property as read only incase Reuse scope is not set
    IF cs_data IS NOT INITIAL.
      yz_clas_mdg_utility=>set_parameter_value( is_data = cs_data iv_param_name = 'YZ_PARAM_MODEL' iv_component = 'MODEL' ).
      yz_clas_mdg_utility=>set_parameter_value( is_data = cs_data iv_param_name = 'YZ_PARAM_OTC' iv_component = 'OTC' ).
      ASSIGN: cs_data TO <fs_data> CASTING.
      CHECK <fs_data> IS ASSIGNED AND <fs_data> IS NOT INITIAL.
      IF io_event->mv_event_id EQ 'FPM_LEAVE_INITIAL_SCREEN' AND yz_clas_mdg_yz_access=>gt_yz_rule_d IS INITIAL.
        APPEND <fs_data> TO lt_data.
        yz_clas_mdg_yz_access=>set_entity_data( EXPORTING it_data = lt_data iv_entity = 'YZ_RULE_D' ).
      ENDIF.
      IF <fs_data>-reuse_scp EQ abap_false.
*       READ TABLE ct_field_usage ASSIGNING FIELD-SYMBOL(<fs_def_field>) WITH KEY name = 'REFRULEID'.
        ASSIGN ct_field_usage[ name = 'REFRULEID' ] TO FIELD-SYMBOL(<fs_def_field>).
        IF sy-subrc = 0 AND <fs_def_field> IS NOT INITIAL.
          <fs_def_field>-read_only = 'X'.
          ev_field_usage_changed = abap_true.
        ENDIF.
      ENDIF.

***Deriving rule definition ID
*--------------------------------------------------------------------*
*    Derive Root Entity Based on Template using Genil Set Method
*--------------------------------------------------------------------*
      IF <fs_data>-model  IS INITIAL AND <fs_data>-otc IS INITIAL AND <fs_data>-rule_type IS INITIAL
      AND <fs_data>-def_id IS INITIAL AND iv_edit_mode EQ 'E' AND <fs_data>-temp_id IS NOT INITIAL.
        SELECT SINGLE model,otc,rule_type,temp_id FROM yztabl_rule_tmp WHERE temp_id = @<fs_data>-temp_id INTO @DATA(ls_root_key).
        IF sy-subrc = 0 AND me->mo_entity IS BOUND.
          <fs_data> = CORRESPONDING #( ls_root_key ).
          me->mo_entity->set_properties( cs_data ).
          ev_data_changed = abap_true.
        ENDIF.
      ENDIF.
*--------------------------------------------------------------------*
      IF <fs_data>-def_id IS INITIAL AND iv_edit_mode EQ 'E' AND io_event->mv_event_id EQ 'AFTER_BOL_MODIFY'.
        IF <fs_data>-model IS NOT INITIAL AND <fs_data>-otc IS NOT INITIAL AND <fs_data>-rule_type IS NOT INITIAL AND <fs_data>-def_id IS INITIAL.
          <fs_data>-def_id = <fs_data>-model && '_' && <fs_data>-otc && '_' && <fs_data>-rule_type && '_' && yz_clas_mdg_accelerator=>get_nr_def_id_for_rule( <fs_data>-rule_type ).
          CONDENSE <fs_data>-def_id.
          me->mo_entity->set_properties( cs_data ).
          ev_data_changed = abap_true.
          DATA lo_fpm TYPE REF TO if_fpm.
          lo_fpm = cl_fpm_factory=>get_instance( ).
          lo_fpm->raise_event_by_id( 'FPM_REFRESH' ).
        ENDIF.
      ENDIF.
    ENDIF.

  ENDMETHOD.


  METHOD get_initial_data.
    CALL METHOD super->get_initial_data
      EXPORTING
        iv_event_id     = iv_event_id
      RECEIVING
        rs_initial_data = rs_initial_data.

  ENDMETHOD.


  METHOD get_yz_rule_d.
  ENDMETHOD.


  METHOD if_fpm_guibb_form~flush.

    CALL METHOD super->if_fpm_guibb_form~flush
      EXPORTING
        it_change_log = it_change_log
        is_data       = is_data.

    LOOP AT it_change_log INTO DATA(ls_change_log).
      IF ls_change_log-name = 'MODEL'.
        SET PARAMETER ID 'YZ_PARAM_MODEL' FIELD ls_change_log-new_value->*.
      ENDIF.
      IF ls_change_log-name = 'OTC'.
        SET PARAMETER ID 'YZ_PARAM_OTC' FIELD ls_change_log-new_value->*.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD if_fpm_guibb_form~process_event.
    CALL METHOD super->if_fpm_guibb_form~process_event
      EXPORTING
        io_event            = io_event
        iv_raised_by_own_ui = iv_raised_by_own_ui
      IMPORTING
        ev_result           = ev_result
        et_messages         = et_messages.
  ENDMETHOD.


  METHOD if_fpm_guibb_form~get_definition.

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

    et_action_definition = VALUE #( BASE et_action_definition
                                ( id = 'AFTER_TEMP_SELECTION'  text = 'After Templ. Selection' enabled = abap_true visible = cl_wd_uielement=>e_visible-visible  ) ).
endmethod.
ENDCLASS.
