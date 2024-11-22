class YS_CLAS_MDG_YS_SEARCH_FEEDER definition
  public
  inheriting from CL_USMD_SEARCH_GUIBB_RESULT
  final
  create public .

public section.

  methods IF_FPM_GUIBB_LIST~PROCESS_EVENT
    redefinition .
  methods IF_FPM_GUIBB~INITIALIZE
    redefinition .
protected section.

  methods NAVIGATE_TO_OVP
    redefinition .
private section.
ENDCLASS.



CLASS YS_CLAS_MDG_YS_SEARCH_FEEDER IMPLEMENTATION.


  method IF_FPM_GUIBB_LIST~PROCESS_EVENT.
  """BOC by Ram
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

  """EOC by Ram
  endmethod.


  method IF_FPM_GUIBB~INITIALIZE.
    """BOC by Ram
    CALL METHOD super->if_fpm_guibb~initialize
      EXPORTING
        it_parameter      = it_parameter
        io_app_parameter  = io_app_parameter
        iv_component_name = iv_component_name
        is_config_key     = is_config_key
        iv_instance_id    = iv_instance_id.

    me->mv_link_column = 'YY_SERVIC'.

    """EOC by RAM
  endmethod.


  METHOD navigate_to_ovp.
    """BOC by Ram

    DATA:lo_communicator TYPE REF TO cl_mdg_bs_communicator_assist,
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

  DATA:
    lr_value            TYPE REF TO data,
    lv_crequest_id      TYPE usmd_crequest,
    lv_workitem_id      TYPE string,
    lv_cr_type_string   TYPE string,
    lv_cr_type          TYPE usmd_crequest_type,
    lv_otc              TYPE usmd_otc,
    lv_action           TYPE usmd_action,
    ls_activity         TYPE usmd_s_usmd160c,
    ls_runtime_info     TYPE fpm_s_runtime_info,
    lv_application      TYPE usmd_ui_appl,
*    lo_communicator     TYPE REF TO cl_mdg_bs_communicator_assist,
    lo_url_parameter    TYPE REF TO if_fpm_parameter,
    lo_url_parameters   TYPE REF TO cl_fpm_parameter,
    lt_url_parameters   TYPE apb_lpd_t_params,
    lt_navi_parameters  TYPE tihttpnvp,
    ls_navi_parameters  TYPE ihttpnvp,
    lt_data             TYPE usmd_t_value,
    ls_data             LIKE LINE OF lt_data,
    lt_key_parameters   TYPE tihttpnvp,
    lv_action_value     TYPE string,
    lv_target_appl_name TYPE string,
    lv_ui_appl          TYPE usmd_ui_appl,
    lv_ui_config        TYPE usmd_ui_config,
    lv_nav_config       TYPE usmd_ui_config_target,
    lv_nav_appl         TYPE usmd_ui_appl_target,
    lv_target_ui_config TYPE usmd_ui_config.

  FIELD-SYMBOLS:
    <ls_navi_parameter> LIKE LINE OF lt_navi_parameters,
    <ls_key_parameter>  LIKE LINE OF lt_key_parameters,
    <ls_data>           LIKE LINE OF lt_data,
    <lv_crequest_id>    TYPE string,
    <lv_workitem_id>    TYPE string.

  lo_communicator = cl_mdg_bs_communicator_assist=>get_instance( ).

* 1. Get application parameters and navigation keys
  me->mo_app_parameter->get_value(
    EXPORTING iv_key = if_fpm_constants=>gc_app_params-url_parameter
    IMPORTING ev_value = lo_url_parameter
  ).
  lo_url_parameters ?= lo_url_parameter.
  lt_url_parameters = lo_url_parameters->to_lpparam( ).

  APPEND LINES OF lt_url_parameters TO lt_navi_parameters.
  APPEND LINES OF it_additional_url_parameters TO lt_navi_parameters.

* 2. Add required lt_navi_parameters to lt_data
  " (do not add parameter SAP-WD-CONFIGID because it causes a dump in BP create)
  LOOP AT lt_navi_parameters ASSIGNING <ls_navi_parameter>.
    IF <ls_navi_parameter>-name = 'USMD_OTC' OR <ls_navi_parameter>-name = 'USMD_PROCESS'
      OR <ls_navi_parameter>-name = 'WDCONFIGURATIONID'
      OR <ls_navi_parameter>-name = 'STEM_ID' OR <ls_navi_parameter>-name = 'CLONEPATTERNID'
      OR <ls_navi_parameter>-name = 'FPM_COLLAPSED_UIBB_PROC_MODE'
      OR <ls_navi_parameter>-name = 'CATEGORY'
      OR <ls_navi_parameter>-name = 'USMD_SEARCH_EDITION_MODE'.
      ls_data-fieldname = <ls_navi_parameter>-name.
      ls_data-value = <ls_navi_parameter>-value.
      APPEND ls_data TO lt_data.
    ENDIF.
  ENDLOOP.





  READ TABLE lt_navi_parameters WITH KEY name = 'WDCONFIGURATIONID' ASSIGNING <ls_navi_parameter>.
  IF sy-subrc = 0.
    IF lv_target_ui_config IS NOT INITIAL AND
       lv_target_ui_config NE <ls_navi_parameter>-value.
      <ls_navi_parameter>-value = lv_target_ui_config.
    ENDIF.
  ENDIF.

  APPEND LINES OF lt_key_parameters TO lt_navi_parameters.


* 9. Action: Set DISPLAY, if no action was provided
  IF lv_action IS INITIAL.
    "If no action is known, use action 'DISPLAY', because we want at least to display the object.
    lv_action = cl_mdg_bs_communicator_assist=>gc_action-display.
  ENDIF.

* 10. Add parameters USMD_CREQ_TYPE and CRTYPE, if change request type is provided

  DO 3 TIMES.                                               "2576849
    CASE sy-index.
      WHEN 1.
        lv_cr_type_string = usmd0_cs_fld-crequest_type.
      WHEN 2.
        lv_cr_type_string = 'CREQ_TYPE'.
      WHEN 3.
        lv_cr_type_string = 'CRTYPE'.
    ENDCASE.

    me->mo_app_parameter->get_value(
      EXPORTING iv_key   = lv_cr_type_string
      IMPORTING ev_value = lv_cr_type ).

    IF lv_cr_type IS NOT INITIAL.
      EXIT.
    ENDIF.
  ENDDO.







  IF lv_target_appl_name = 'USMD_ENTITY_VALUE2'
  OR lv_target_appl_name = 'USMD_CREQUEST_PROCESS'
  OR lv_target_appl_name = 'USMD_MASS_CHANGE' .

* Trigger navigation to old UIs. A special navigation has to be used because it needs a special
* preparation of navigation parameters. Parameter usmd_fieldname will be added.
    lv_ui_appl = lv_target_appl_name.

    CLEAR lt_navi_parameters .
    LOOP AT lt_data ASSIGNING <ls_data>.
      ls_navi_parameters-name = <ls_data>-fieldname.
      ls_navi_parameters-value = <ls_data>-value.
      APPEND ls_navi_parameters TO lt_navi_parameters.
    ENDLOOP.

* The following method will add the usmd_fieldname parameter which is importatn for
* the older applications.

    me->navigate_to_ev2(
      EXPORTING
        iv_application    = lv_ui_appl
        iv_otc            = lv_otc
        it_navi_parameter = lt_navi_parameters ).
  ELSE.
* 14. Add parameter USMD_PROCESS if it does not exist yet
* This indicates method determine_logical_action (in cl_usmd_navigation_assist) not to
* write the USMD_PROCESS into the URL parameters
    READ TABLE lt_data ASSIGNING <ls_data>
      WITH KEY fieldname = 'USMD_PROCESS'.
    IF sy-subrc <> 0.
      ls_data-fieldname = 'USMD_PROCESS'.
      ls_data-value = space.
      APPEND ls_data TO lt_data.
    ENDIF.

* 15. Navigation

    ls_data-fieldname = 'FPM_DO_NOT_EXECUTE_DEFAULT_SEA'.
* The real name of the parameter is too long for the table.
* Will be corrected later on when the type is string
    ls_data-value = abap_true.
    APPEND ls_data TO lt_data.

    cl_usmd_navigation=>navigate(
      EXPORTING iv_action       = lv_action
*              iv_application  = lv_application             "2557330
                it_data         = lt_data ).

  ENDIF.
  CLEAR me->mv_action.

  IF lo_communicator IS BOUND.
    lo_communicator->reset_environment( ).
  ENDIF.


    """EOC by Ram
  ENDMETHOD.
ENDCLASS.
