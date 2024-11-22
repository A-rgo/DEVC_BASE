class YB_CLAS_MDG_YB_SEARCH_FEEDER definition
  public
  inheriting from CL_USMD_SEARCH_GUIBB_RESULT
  create public .

public section.

  methods IF_FPM_GUIBB_LIST~GET_DATA
    redefinition .
  methods IF_FPM_GUIBB_LIST~GET_DEFINITION
    redefinition .
  methods IF_FPM_GUIBB~INITIALIZE
    redefinition .
  methods IF_FPM_GUIBB_LIST~PROCESS_EVENT
    redefinition .
protected section.

  methods NAVIGATE_TO_OVP
    redefinition .
private section.
ENDCLASS.



CLASS YB_CLAS_MDG_YB_SEARCH_FEEDER IMPLEMENTATION.


  METHOD if_fpm_guibb_list~get_data.

    DATA: lw_selected_line TYPE rstabix.
    DATA lo_model TYPE REF TO IF_USMD_CONV_SOM_GOV_API.


    IF lo_model IS NOT BOUND.
      "get an instance of the convenience API
      lo_model = cl_usmd_search_assist=>get_mdg_api( ).
    ENDIF.

    IF lo_model IS BOUND.
      IF iv_eventid->mv_event_id EQ 'MARK_DELETE'.
        CLEAR lw_selected_line.
        READ TABLE ct_selected_lines INTO lw_selected_line INDEX 1.
        IF sy-subrc EQ 0.
          me->mv_navigation_request_row = lw_selected_line-tabix.
        ENDIF.
        me->mo_app_parameter->set_value(
          EXPORTING
            iv_key   = 'USMD_PROCESS'
            iv_value = 'YB03'
*            ir_value = 'ZBDL'
        ).
             me->mo_app_parameter->set_value(
          EXPORTING
            iv_key   = 'CRTYPE'
            iv_value = 'YBBNK03'
*            ir_value = 'ZBDL'
        ).

      ENDIF.
    ENDIF.

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


    FIELD-SYMBOLS: <lfs_action> TYPE fpmgb_s_actionusage.
    UNASSIGN <lfs_action>.
    LOOP AT ct_action_usage ASSIGNING <lfs_action>.
      IF <lfs_action> IS ASSIGNED.
        CASE <lfs_action>-id.
          WHEN 'MARK_DELETE'.
            <lfs_action>-visible = cl_wd_uielement=>e_visible-visible.
            <lfs_action>-enabled = abap_true.
            ev_data_changed = abap_true.
        ENDCASE.
      ENDIF.
    ENDLOOP.
    UNASSIGN <lfs_action>.


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

    DATA ls_action_def TYPE fpmgb_s_actiondef.
    DATA ls_act_def LIKE LINE OF et_action_definition.
    ls_act_def-id = 'MARK_DELETE'.

    ls_act_def-text = 'Mark For Deletion'.
    ls_act_def-enabled = 'X'.
    ls_act_def-exposable = 'X'.
    ls_act_def-action_type = 'X'.
    ls_act_def-visible = cl_wd_uielement=>e_visible-visible.
    ls_act_def-event_param_strukname = 'BSS_EVENT_PARAMS'.
    APPEND ls_act_def TO et_action_definition.
    CLEAR ls_act_def.

* Lead Selection for GUIBB List
    CLEAR ls_action_def .
    ls_action_def-enabled = abap_true.
    ls_action_def-visible = cl_wd_uielement=>e_visible-visible.
    ls_action_def-id = 'ON_LEADSELECTION'.
    APPEND ls_action_def TO et_action_definition.

    ls_act_def-id = 'MARK_DELETE'.

    ls_act_def-text = 'Mark For Deletion'.
    ls_act_def-enabled = 'X'.
    ls_act_def-exposable = 'X'.
    ls_act_def-action_type = 'X'.
    ls_act_def-visible = cl_wd_uielement=>e_visible-visible.
    ls_act_def-event_param_strukname = 'BSS_EVENT_PARAMS'.
    APPEND ls_act_def TO et_action_definition.
    CLEAR ls_act_def.

  ENDMETHOD.


  METHOD if_fpm_guibb_list~process_event.
*CALL METHOD SUPER->IF_FPM_GUIBB_LIST~PROCESS_EVENT
*  EXPORTING
*    IO_EVENT            = IO_EVENT
**    iv_raised_by_own_ui =
*    IV_LEAD_INDEX       =
*    IV_EVENT_INDEX      =
*    IT_SELECTED_LINES   =
**    io_ui_info          =
**  IMPORTING
**    ev_result           =
**    et_messages         =
*    .
    CASE io_event->mv_event_id.
      WHEN 'REPLICATE'.
        cl_usmd_navigation=>navigate(
          EXPORTING
            iv_application = 'DRF_MANUAL_REPLICATION' ).
*      WHEN .
      WHEN OTHERS.
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
    ENDCASE.
  ENDMETHOD.


  METHOD if_fpm_guibb~initialize.
*CALL METHOD SUPER->IF_FPM_GUIBB~INITIALIZE
*  EXPORTING
*    IT_PARAMETER      =
**    io_app_parameter  =
**    iv_component_name =
**    is_config_key     =
**    iv_instance_id    =
*    .
    CALL METHOD super->if_fpm_guibb~initialize
      EXPORTING
        it_parameter      = it_parameter
        io_app_parameter  = io_app_parameter
        iv_component_name = iv_component_name
        is_config_key     = is_config_key
        iv_instance_id    = iv_instance_id.

    me->mv_link_column = 'Y_BANKL'.
  ENDMETHOD.


  METHOD navigate_to_ovp.
*CALL METHOD SUPER->NAVIGATE_TO_OVP
**  EXPORTING
**    it_additional_url_parameters =
*    .
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
  ENDMETHOD.
ENDCLASS.
