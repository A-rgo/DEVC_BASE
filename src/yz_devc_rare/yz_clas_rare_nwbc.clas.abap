class YZ_CLAS_RARE_NWBC definition
  public
  final
  create public .

public section.

  class-data GO_CONTEXT type ref to IF_USMD_APP_CONTEXT .
  class-data GV_USMD_MODEL type USMD_MODEL .
  class-data GV_CREQUEST type USMD_CREQUEST .

  class-methods CUSTOMIZE_HELP_MENU
    importing
      value(I_VIEW_ELEMENT) type ref to CL_WDR_VIEW_ELEMENT
      value(I_VIEW_ELEMENT_ADAPTER) type ref to CL_NW7_VIEW_ELEMENT_ADAPTER
      value(I_REPRESENTATIVE) type ref to CL_WDR_VIEW_ELEMENT
      value(I_REPRESENTATIVE_ADAPTER) type ref to CL_NW7_VIEW_ELEMENT_ADAPTER
      value(I_VIEW_ELEMENT_ADAPTER_FIRST) type ref to CL_NW7_VIEW_ELEMENT_ADAPTER optional
      value(I_CURRENT_EVENT_ID) type STRING
    exporting
      value(E_CONTEXT_MENU_TAB) type IF_WDR_UR_CUSTOM_MENU=>T_MENU_ENTRY_TAB .
  class-methods HANDLE_HELP_MENU_CHOSEN
    importing
      !EVENT_PARAM_1 type STRING .
  class-methods GET_CR_HEADER_FIELDS
    changing
      !CV_FIELDS type YZ_TTYP_FIELD_DETAILS optional .
  class-methods INIT_CR
    exporting
      !EV_USMD_MODEL type USMD_MODEL
      !EV_CREQUEST type USMD_CREQUEST .
  class-methods GET_ENTITY_DATA
    changing
      !CV_FIELDS type YZ_TTYP_FIELD_DETAILS optional .
  class-methods GET_FIORI_URL_FOR_INCIDENT
    returning
      value(EV_URL) type STRING .
protected section.
private section.
ENDCLASS.



CLASS YZ_CLAS_RARE_NWBC IMPLEMENTATION.


  METHOD customize_help_menu.
* Local data declaration
    DATA lv_menu_entry      TYPE if_wdr_ur_custom_menu=>t_menu_entry.
    DATA lv_menu_id         TYPE string.
    DATA lr_component       TYPE REF TO cl_wdr_delegating_component.
* Check whether we are already on the WDR_DOCU_HELPER popup
* if yes, don't show context menu entry
    IF i_view_element_adapter IS BOUND AND
       i_view_element_adapter->m_view_element IS BOUND AND
       i_view_element_adapter->m_view_element->_component IS BOUND.
      lr_component ?= i_view_element_adapter->m_view_element->_component.
    ELSE.
      lr_component ?= wdr_task=>application->application_window->view_manager->interface_view->get_component( ).
    ENDIF.
    CHECK lr_component->component_name <> 'WDR_DOCU_HELPER'.
* CREATE_INCIDENT
    CONCATENATE i_current_event_id '_' 'CREATE_INCIDENT' INTO lv_menu_id.
    CLEAR lv_menu_entry.
    lv_menu_entry-id        = lv_menu_id .
    lv_menu_entry-parent_id = ''.
    lv_menu_entry-text = 'Create Incident'.
    lv_menu_entry-type = cl_wdr_p13n_rt=>e_type-action.
    lv_menu_entry-event_param_1 = lv_menu_entry-id.
    lv_menu_entry-enabled = abap_true.
    APPEND lv_menu_entry TO e_context_menu_tab.
  ENDMETHOD.


  METHOD get_cr_header_fields.
* Local Data Declaration - CR header
    DATA: lo_ref      TYPE REF TO cl_abap_structdescr,
          lt_ddfields TYPE TABLE OF dfies,
          ls_fields   TYPE yztabl_field_details.

* Fetch CR header details
    SELECT SINGLE *
      FROM usmd120c
      INTO @DATA(lv_cr_header)
      WHERE usmd_crequest = @gv_crequest.
    IF sy-subrc = 0.
      " Find structure at run time
      lo_ref ?= cl_abap_structdescr=>describe_by_data( lv_cr_header ).
      CALL METHOD lo_ref->get_ddic_field_list
        RECEIVING
          p_field_list = lt_ddfields
        EXCEPTIONS
          not_found    = 1
          no_ddic_type = 2
          OTHERS       = 3.
      IF sy-subrc = 0.
        " Remove MANDT from the list of fields
        DELETE lt_ddfields INDEX 1.
        LOOP AT lt_ddfields INTO DATA(wa).
          CLEAR ls_fields.
          IF sy-tabix = 1.
            ls_fields-field = 'USMD120C'.
            ls_fields-fieldname = 'CR HEADER DETAILS'.
            APPEND ls_fields TO cv_fields.
          ENDIF.
          ASSIGN COMPONENT wa-fieldname OF STRUCTURE lv_cr_header TO FIELD-SYMBOL(<fs>).
          IF <fs> IS ASSIGNED AND <fs> NE '0' AND <fs> IS NOT INITIAL.
            ls_fields-field = wa-fieldname.
            ls_fields-fieldname = wa-scrtext_m.
            ls_fields-value = <fs>.
            " Append to exporting attribute
            APPEND ls_fields TO cv_fields.
          ENDIF.
        ENDLOOP.
      ENDIF.

    ELSE.
      cl_usmd_app_context=>init_context(
        EXPORTING
          iv_model                 =   gv_usmd_model               " Data Model
          iv_crequest_id           =   gv_crequest                " Change Request
      ).
*      CATCH cx_usmd_app_context_cons_error. " Exception: Consistency Error in Design of Appl. Context
      cl_usmd_app_context=>get_context( )->get_parameter_all(
        IMPORTING
          et_context_parameter =  DATA(lt_all)                " Table of Context Parameters (Field Name and Value)
      ).
      IF lt_all IS NOT INITIAL.
        LOOP AT lt_all INTO DATA(ls_data).
          ls_fields-fieldname = ls_data-fieldname.
          ls_fields-value      =  ls_data-value.
          APPEND ls_fields TO cv_fields.
        ENDLOOP.
      ELSE.
        ls_fields-fieldname = 'Data Model'.
        ls_fields-value      =  gv_usmd_model.
        APPEND ls_fields TO cv_fields.

        ls_fields-fieldname = 'CR Number'.
        ls_fields-value     =  gv_crequest.
        APPEND ls_fields TO cv_fields.
      ENDIF.
    ENDIF.


    get_entity_data(
      CHANGING
        cv_fields =  cv_fields                " Table Type for screen field details
    ).


  ENDMETHOD.


  METHOD get_entity_data.
* Local Declaration - USMD_MODEL_EXT
    DATA: lo_model       TYPE REF TO if_usmd_model_ext,
          lt_message     TYPE usmd_t_message,
          lt_object_list TYPE usmd_ts_entity_data,
          lt_entity_data TYPE usmd_ts_data_entity,
          ls_entity_data TYPE usmd_sx_data_entity.

* Local Declaration - PDF fields
    DATA: lo_ref        TYPE REF TO cl_abap_typedescr,
          lo_str        TYPE REF TO cl_abap_structdescr,
          lo_tab        TYPE REF TO cl_abap_tabledescr,
          lo_dat        TYPE REF TO cl_abap_datadescr,
          lt_attributes TYPE TABLE OF x031l,
          ls_header     TYPE x030l,
          ls_fields     TYPE yztabl_field_details.

    FIELD-SYMBOLS <itab> TYPE ANY TABLE.

* Get instance
    CALL METHOD cl_usmd_model_ext=>get_instance
      EXPORTING
        i_usmd_model = gv_usmd_model
      IMPORTING
        eo_instance  = lo_model.

* Get object list
    CALL METHOD lo_model->if_usmd_model_cr_ext~get_cr_objectlist
      EXPORTING
        i_crequest = gv_crequest
      IMPORTING
        et_key_all = lt_object_list.

* Read type 1 entity name and clear entity data internal table for reuse
    READ TABLE lt_object_list INTO DATA(ls_object_list) INDEX 1.
    CLEAR lt_object_list.

    CHECK lo_model IS BOUND AND gv_crequest IS NOT INITIAL AND gv_usmd_model IS NOT INITIAL.

* Read all entities
    CALL METHOD lo_model->read_entity_data_all
      EXPORTING
        i_fieldname    = CONV usmd_fieldname( ls_object_list-entity )
        if_active      = ' '
        i_crequest     = gv_crequest
      IMPORTING
        et_message     = lt_message
        et_data_entity = lt_entity_data.

* Convert all other entity data into cv_fields format
    LOOP AT lt_entity_data INTO ls_entity_data.
      IF ls_entity_data-usmd_entity_cont IS INITIAL.
        " Type 1/Top most entity is being processed
        ls_fields-field = ls_entity_data-usmd_entity.
        ls_fields-fieldname = 'ENTITY NAME'.
        APPEND ls_fields TO cv_fields.
      ELSE.
        " Other entities are being processed
        ls_fields-field = ls_entity_data-usmd_entity_cont.
        ls_fields-fieldname = 'ENTITY NAME'.
        APPEND ls_fields TO cv_fields.
      ENDIF.

      " Assign entity data
      ASSIGN ls_entity_data-r_t_data->* TO <itab>.

      DATA:
        l_tabledescr_ref TYPE REF TO cl_abap_tabledescr,
        l_descr_ref      TYPE REF TO cl_abap_structdescr,
        wa_table         TYPE abap_compdescr.

      l_tabledescr_ref ?= cl_abap_typedescr=>describe_by_data( <itab> ).
      l_descr_ref ?= l_tabledescr_ref->get_table_line_type( ).

      CHECK <itab> IS ASSIGNED.
      " Loop at each entity data
      LOOP AT <itab> ASSIGNING FIELD-SYMBOL(<line>).
        CHECK <line> IS ASSIGNED.
        LOOP AT l_descr_ref->components INTO DATA(wa).
          CLEAR ls_fields.
          ASSIGN COMPONENT wa-name OF STRUCTURE <line> TO FIELD-SYMBOL(<fs>).
          IF <fs> IS ASSIGNED ."AND <fs> IS NOT INITIAL."and <fs> <> '0'
            ls_fields-field = wa-name.
*                ls_fields-fieldname = wa-scrtext_m.
            ls_fields-value = <fs>.
            " Append to exporting attribute
            APPEND ls_fields TO cv_fields.
          ENDIF.
        ENDLOOP.
      ENDLOOP.
    ENDLOOP.


  ENDMETHOD.


  METHOD handle_help_menu_chosen.
* Data Declaration - SHMA
    DATA: lo_handle TYPE REF TO yz_clas_rare_shma_area,
          lo_root   TYPE REF TO yz_clas_rare_shma_root.

*    FIELD-SYMBOLS <lo_context> TYPE any.

* Data Declaration - LSAPI: to call URL
    DATA: lo_lsapi             TYPE REF TO if_lsapi,
          lv_location          TYPE string,
          lv_mode              TYPE if_lsapi=>t_navigation_mode VALUE 3,
          lv_title             TYPE string,
          lv_window_attributes TYPE string,
          lv_window_id         TYPE string,
          lv_host              TYPE string,
          lv_port              TYPE string,
          lv_work_protect      TYPE abap_bool,
          lv_history_mode      TYPE if_lsapi=>t_history_mode,
          lt_parameters        TYPE if_lsapi=>t_parameters.

    CONSTANTS: lv_url1 TYPE string VALUE 'https://',
               lv_url2 TYPE string VALUE '/sap/bc/gui/sap/its/webgui/?sap-client=',
               lv_url3 TYPE string VALUE '&~transaction=YZ_CAPTURE_WEBGUI'.

* Data Declaration - runtime method calling
    DATA lo_exc_ref TYPE REF TO cx_sy_dyn_call_error.
    CASE event_param_1.
      WHEN 'CREATE_INCIDENT'.
* Initialize App context and Get Context
        cl_usmd_app_context=>init_context( ).
        go_context = cl_usmd_app_context=>get_context( ).
        IF go_context IS BOUND.
* Write the app context to Shared Memory
          TRY.
              " Instantiate handle for write
              lo_handle = yz_clas_rare_shma_area=>attach_for_write( ).

              " Create object for SHMA Root
              CREATE OBJECT lo_root AREA HANDLE lo_handle.

              " Set attribute from app context
               lo_root->gv_data_model = go_context->mv_usmd_model.
               lo_root->gv_crequest   = go_context->mv_crequest_id.

              " Set handler for the root
              TRY.
              lo_handle->set_root( lo_root ).
                CATCH cx_shm_initial_reference.
                CATCH cx_shm_wrong_handle.
              ENDTRY.

              " Call detach commit for Shared memory
              TRY.
                  lo_handle->detach_commit( ).
                CATCH cx_shm_wrong_handle.
                CATCH cx_shm_already_detached.
                CATCH cx_shm_secondary_commit.
                CATCH cx_shm_event_execution_failed.
                CATCH cx_shm_completion_error.
                CATCH cx_sy_no_handler.
              ENDTRY.

            CATCH cx_shm_external_type.
              "Do nothing
            CATCH cx_shm_attach_error.
              "Do nothing
          ENDTRY.

          TRY.
* Get host and port
              CLEAR : lv_host , lv_port.
              cl_http_server=>if_http_server~get_location(
              IMPORTING
              host = lv_host
              port = lv_port ).
* Build URL
              CONCATENATE lv_url1 lv_host ':' lv_port lv_url2 sy-mandt lv_url3
                INTO lv_location.
              CONDENSE lv_location.
* Create LSAPI instance and finalize URL
              lo_lsapi = cl_lsapi_manager=>get_instance( ).
              lv_location = cl_lsapi_manager=>append_obn_parameters( iv_location = lv_location it_obn_params = lt_parameters ).
              IF lv_location CS if_lsapi=>gc_s_protocol-obn AND lt_parameters IS NOT INITIAL.
                CLEAR lt_parameters.
              ENDIF.
              call method cl_gui_frontend_services=>get_screenshot
                importing
                  mime_type_str        = DATA(lv_mime)
                  image                =  DATA(lv_image)
                exceptions
                  access_denied        = 1
                  cntl_error           = 2
                  error_no_gui         = 3
                  not_supported_by_gui = 4
                  others               = 5
                .
              if sy-subrc <> 0.
*               message id sy-msgid type sy-msgty number sy-msgno
*                 with sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
              endif..
* Call URL
              DATA(lv_fiori_url) = GET_FIORI_URL_FOR_INCIDENT( ).
              IF lv_fiori_url IS NOT INITIAL.
                lv_location = lv_fiori_url.
                lv_window_attributes = 'top=200,left=200,height=1000,width=1000'.
              ENDIF.
              lo_lsapi->navigate(
                                  location            = lv_location
                                  mode                = lv_mode
                                  history_mode        = lv_history_mode
                                  title               = lv_title
                                  window_id           = lv_window_id
                                  window_attributes   = lv_window_attributes
                                  work_protect        = lv_work_protect
                                  parameters          = lt_parameters
                                   ).

            CATCH cx_sy_dyn_call_error INTO lo_exc_ref.
              "Do nothing
          ENDTRY.
        ENDIF.
      WHEN 'CREATE_SERVICE_REQ'.
      WHEN OTHERS.
        "Do nothing
    ENDCASE.
  ENDMETHOD.


  METHOD init_cr.
* Local Data Declaration
    DATA: lo_handle      TYPE REF TO yz_clas_rare_shma_area.

* Read stored context from Shared Memory
    TRY.
        " Instantiate handle for read
        lo_handle = yz_clas_rare_shma_area=>attach_for_read( ).

        " Get CR data from SHMA Root attribute
        ev_usmd_model = gv_usmd_model = lo_handle->root->gv_data_model.
        ev_crequest = gv_crequest   = lo_handle->root->gv_crequest.

        " Detach from Shared memory
        TRY.
            lo_handle->detach( ).
          CATCH cx_shm_wrong_handle.
          CATCH cx_shm_already_detached.
        ENDTRY.

      CATCH cx_shm_attach_error.
        " Do nothing
    ENDTRY.
  ENDMETHOD.


  method GET_FIORI_URL_FOR_INCIDENT.

    SELECT SINGLE * FROM YZTABL_RARE_SWCH INTO @DATA(ls_rare_swch)
      WHERE obj_name = 'GET_INCIDENT_WEBGUI'
      AND task_name = 'INCIDENT_WEBGUI'
      AND vakey1 = 'FIORI'
      AND ACTIVE = 'X'.
    IF sy-subrc = 0.
      ev_url = ls_rare_swch-vadata1 && ls_rare_swch-vadata2 && ls_rare_swch-vadata3.
    ENDIF.

  endmethod.
ENDCLASS.
