class ZZMDG_CL_FEEDER_ZPURCHINFO definition
  public
  inheriting from CL_MDG_BS_MAT_FEEDER_LIST
  final
  create public .

public section.

  types:
    BEGIN OF ty_mwskz,
                   mwskz TYPE mwskz,
                   kalsm TYPE kalsm_d,
                   text1 TYPE text1_007s,
           END OF ty_mwskz .

  data CALLED type STRING .

  methods BUILD_MESSAGE
    importing
      !IS_MESSAGE type USMD_S_MESSAGE
    changing
      !CT_MESSAGE type USMD_T_MESSAGE .

  methods /PLMU/IF_FRW_G_ACTIONS~GET_ACTION_DEFINITION
    redefinition .
  methods /PLMU/IF_FRW_G_ACTIONS~PROCESS_ACTION_EVENT
    redefinition .
  methods /PLMU/IF_FRW_G_AFTER_GET_DATA~AFTER_GET_DATA
    redefinition .
  methods /PLMU/IF_FRW_G_FIELD_DEF~CHANGE_FIELD_DEFINITION
    redefinition .
  methods /PLMU/IF_FRW_G_GLOBAL_EVENTS~PROCESS_GLOBAL_EVENT
    redefinition .
  methods /PLMU/IF_FRW_G_OVS~HANDLE_PHASE_0
    redefinition .
  methods /PLMU/IF_FRW_G_OVS~HANDLE_PHASE_1
    redefinition .
  methods /PLMU/IF_FRW_G_OVS~HANDLE_PHASE_2
    redefinition .
  methods /PLMU/IF_FRW_G_OVS~HANDLE_PHASE_3
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZZMDG_CL_FEEDER_ZPURCHINFO IMPLEMENTATION.


  method /PLMU/IF_FRW_G_ACTIONS~GET_ACTION_DEFINITION.
*CALL METHOD SUPER->/PLMU/IF_FRW_G_ACTIONS~GET_ACTION_DEFINITION
*  CHANGING
*    CT_ACTION_DEFINITION     =
**    ct_row_action_definition =
*    .

    CALL METHOD super->/plmu/if_frw_g_actions~get_action_definition
      CHANGING
        ct_action_definition     = ct_action_definition
        ct_row_action_definition = ct_row_action_definition.
    DATA ls_action_definition LIKE LINE OF ct_action_definition.

    ls_action_definition-id   = 'PURORG_INS'.
    ls_action_definition-text = 'PURORG_INS'.
    ls_action_definition-imagesrc = '~Icon/Add'.
*    ls_action_definition-enabled = abap_true.
*    ls_action_definition-visible = 02.
*    ls_action_definition-disable_when_no_lead_sel = abap_true.
*    ls_action_definition-disable_when_no_sel = abap_true.
*    ls_action_definition-is_implicit_edit = abap_true.
    INSERT ls_action_definition INTO TABLE ct_action_definition.

  endmethod.


  method /PLMU/IF_FRW_G_ACTIONS~PROCESS_ACTION_EVENT.
*CALL METHOD SUPER->/PLMU/IF_FRW_G_ACTIONS~PROCESS_ACTION_EVENT
*  EXPORTING
*    IO_EVENT        =
**    iv_index        =
**  IMPORTING
**    ev_skip_default =
**    ev_result       =
**    et_messages     =
*    .
   CALL METHOD super->/plmu/if_frw_g_actions~process_action_event
      EXPORTING
        io_event        = io_event
        iv_index        = iv_index
      IMPORTING
        ev_skip_default = ev_skip_default
        ev_result       = ev_result
        et_messages     = et_messages.

    TYPES : BEGIN OF ty_pog,
              lifnr     TYPE elifn,
              ekorg     TYPE ekorg,
              werks     TYPE werks_d,
              esokz     TYPE esokz,
              esokz_txt TYPE val_text,
            END OF ty_pog.
    DATA : lo_singleton TYPE REF TO zzmdg_cl_pircond_singleton,
           lt_pog       TYPE TABLE OF ty_pog,
           ls_pog       TYPE ty_pog.

    DATA : ls_row     TYPE zzmdg_bs_mat_s_eina,
           ls_data    TYPE zzmdg_bs_mat_s_eine,
           lt_data    TYPE TABLE OF zzmdg_bs_mat_s_eine,
           ls_message TYPE fpmgb_s_t100_message,
           lv_usrname TYPE usr02-bname,
           lv_plant   TYPE ust12-von.
    DATA: lo_fpm TYPE REF TO if_fpm.
    DATA: ls_dialog TYPE fpm_s_dialog_box_properties,
          lo_para   TYPE REF TO cl_fpm_parameter.

    DATA : lo_event_params TYPE  REF  TO  if_fpm_parameter,
           lr_event        TYPE  REF  TO  cl_fpm_event,
           lv_window_id    TYPE  fpm_dialog_window_id.

    CONSTANTS : lc_msg_cls TYPE string VALUE 'ZZMDG_PIR_MSG',
                lc_buffer  TYPE xuflag VALUE 3,
                lc_object  TYPE ust12-objct VALUE 'M_MATE_WRK',
                lc_field1  TYPE ust12-field VALUE 'WERKS',
                lc_field2  TYPE ust12-field VALUE 'ACTVT',
                lc_value2  TYPE ust12-von VALUE '02'.

    IF io_event->mv_event_id = 'ROUNDTRIP'.
      mo_context->get_selection(
        IMPORTING
          et_selection =  lt_data                " Content of the selected rows
      ).

      LOOP AT lt_data INTO ls_data.
        IF ls_data-werks IS NOT INITIAL.
          lv_plant = ls_data-werks.
          lv_usrname = sy-uname.
          CALL FUNCTION 'AUTHORITY_CHECK'
            EXPORTING
              new_buffering       = lc_buffer
              user                = lv_usrname
              object              = lc_object
              field1              = lc_field1
              value1              = lv_plant
              field2              = lc_field2
              value2              = lc_value2
            EXCEPTIONS
              user_dont_exist     = 1
              user_is_authorized  = 2
              user_not_authorized = 3
              user_is_locked      = 4
              OTHERS              = 5.
          IF sy-subrc EQ 3.
            ls_message-msgid = lc_msg_cls.
            ls_message-msgno = 055.
            ls_message-category = 'E'.
            ls_message-parameter_1 = ls_data-werks.
            APPEND ls_message TO et_messages.
            CLEAR ls_message.
          ENDIF.
        ENDIF.
      ENDLOOP.

      IF lt_data IS NOT INITIAL.
        READ TABLE lt_data INTO ls_data INDEX iv_index.
        IF sy-subrc IS INITIAL.
          IF ls_data-matnr IS NOT INITIAL
            AND ls_data-lifnr IS NOT INITIAL
            AND ls_data-ekorg IS NOT INITIAL
            AND ls_data-werks IS NOT INITIAL
            AND ls_data-esokz IS NOT INITIAL
            AND ls_data-netpr IS NOT INITIAL.

          ENDIF.
        ENDIF.
      ENDIF.

    ENDIF.

    IF io_event->mv_event_id = 'PURORG_INS'.
      ls_row = zzmdg_cl_feeder_zpurchgen=>gs_row.
      IF ls_row-lifnr IS NOT INITIAL.
        "Set existing data
        mo_context->get_rows( IMPORTING et_row = lt_data ).
        LOOP AT lt_data INTO ls_data.
          IF ls_data-lifnr IS NOT INITIAL AND ls_data-ekorg IS NOT INITIAL.
            ls_pog-lifnr = ls_data-lifnr.
            ls_pog-ekorg = ls_data-ekorg.
            ls_pog-werks = ls_data-werks.
            ls_pog-esokz = ls_data-esokz.
            APPEND ls_pog TO lt_pog.
          ENDIF.
          CLEAR : ls_pog.
        ENDLOOP.


        lv_window_id = 'POG_INS' .
        CREATE OBJECT lo_event_params TYPE cl_fpm_parameter.
        lo_event_params->set_value( EXPORTING
                                    iv_key = if_fpm_constants=>gc_dialog_box-id
                                    iv_value = lv_window_id ).
        lo_event_params->set_value( EXPORTING
                                    iv_key = 'TAB'
                                    iv_value = lt_pog ).
        lo_event_params->set_value( EXPORTING
                            iv_key = 'WIDTH'
*                            iv_value = '500' ).
                            iv_value = '1000' ).
        lo_event_params->set_value( EXPORTING
            iv_key = 'HEIGHT'
            iv_value = '100' ).

        CREATE OBJECT lr_event
          EXPORTING
            iv_event_id   = cl_fpm_event=>gc_event_open_dialog_box
            io_event_data = lo_event_params.

        lo_fpm = cl_fpm_factory=>get_instance( ).
        lo_fpm->raise_event( lr_event ).
      ENDIF.
    ENDIF.

  endmethod.


  method /PLMU/IF_FRW_G_AFTER_GET_DATA~AFTER_GET_DATA.
*CALL METHOD SUPER->/PLMU/IF_FRW_G_AFTER_GET_DATA~AFTER_GET_DATA
*  EXPORTING
*    IV_FIRST_TIME           =
*    IO_EVENT                =
**    it_selected_fields      =
**  IMPORTING
**    et_message              =
**    ev_field_usage_changed  =
**    ev_action_usage_changed =
*  CHANGING
*    CT_FIELD_USAGE          =
*    CT_ACTION_USAGE         =
*    .

    CALL METHOD super->/plmu/if_frw_g_after_get_data~after_get_data
      EXPORTING
        iv_first_time           = iv_first_time
        io_event                = io_event
        it_selected_fields      = it_selected_fields
      IMPORTING
        et_message              = et_message
        ev_field_usage_changed  = ev_field_usage_changed
        ev_action_usage_changed = ev_action_usage_changed
      CHANGING
        ct_field_usage          = ct_field_usage
        ct_action_usage         = ct_action_usage.

    DATA : lo_context    TYPE REF TO if_usmd_app_context,
           lv_process    TYPE usmd_process,
           lt_property   TYPE STANDARD TABLE OF /plmb/s_spi_properties,
           lt_properties TYPE /plmb/t_spi_properties,
           ls_properties LIKE LINE OF lt_properties,
           lv_crequest   TYPE usmd_crequest.
    DATA : lt_row TYPE STANDARD TABLE OF zzmdg_bs_mat_s_eine,
           ls_row LIKE LINE OF lt_row,
           lo_fpm TYPE REF TO if_fpm.
    DATA : lv_blank_window   TYPE fpm_window_name ##needed,
           ls_blank_uibb_key TYPE fpm_s_uibb_instance_key ##needed,
           lv_edit_mode      TYPE fpm_edit_mode.

    lo_context = cl_usmd_app_context=>get_context( ).
    IF lo_context IS BOUND.
      lo_context->get_attributes( IMPORTING ev_process = lv_process ev_crequest_id = lv_crequest ).
    ENDIF.
    IF lv_process <> 'MAT6'.
      ls_properties-node_field = 'LOEKZ'.
      ls_properties-option = '3'.
      APPEND ls_properties TO lt_property.
      CLEAR : ls_properties.
    ELSE.
      ls_properties-node_field = 'LOEKZ'.
      ls_properties-option = '1'.
      APPEND ls_properties TO lt_property.
      CLEAR : ls_properties.

      ls_properties-node_field = 'EKWRK'.
      ls_properties-option = '3'.
      APPEND ls_properties TO lt_property.
      CLEAR : ls_properties.

      ls_properties-node_field = 'LIFNR'.
      ls_properties-option = '3'.
      APPEND ls_properties TO lt_property.
      CLEAR : ls_properties.

      ls_properties-node_field = 'APLFZ'.
      ls_properties-option = '3'.
      APPEND ls_properties TO lt_property.
      CLEAR : ls_properties.

      ls_properties-node_field = 'EKORG'.
      ls_properties-option = '3'.
      APPEND ls_properties TO lt_property.
      CLEAR : ls_properties.

      ls_properties-node_field = 'EKGRP_P'.
      ls_properties-option = '3'.
      APPEND ls_properties TO lt_property.
      CLEAR : ls_properties.

      ls_properties-node_field = 'NORBM'.
      ls_properties-option = '3'.
      APPEND ls_properties TO lt_property.
      CLEAR : ls_properties.

      ls_properties-node_field = 'MINBM'.
      ls_properties-option = '3'.
      APPEND ls_properties TO lt_property.
      CLEAR : ls_properties.

      ls_properties-node_field = 'BSTMA_P'.
      ls_properties-option = '3'.
      APPEND ls_properties TO lt_property.
      CLEAR : ls_properties.

      ls_properties-node_field = 'NETPR'.
      ls_properties-option = '3'.
      APPEND ls_properties TO lt_property.
      CLEAR : ls_properties.

      ls_properties-node_field = 'BPRME'.
      ls_properties-option = '3'.
      APPEND ls_properties TO lt_property.
      CLEAR : ls_properties.

      ls_properties-node_field = 'PEINH_P'.
      ls_properties-option = '3'.
      APPEND ls_properties TO lt_property.
      CLEAR : ls_properties.

      ls_properties-node_field = 'INCO1'.
      ls_properties-option = '3'.
      APPEND ls_properties TO lt_property.
      CLEAR : ls_properties.

      ls_properties-node_field = 'ESOKZ'.
      ls_properties-option = '3'.
      APPEND ls_properties TO lt_property.
      CLEAR : ls_properties.

      ls_properties-node_field = 'WAERS'.
      ls_properties-option = '3'.
      APPEND ls_properties TO lt_property.
      CLEAR : ls_properties.

      ls_properties-node_field = 'INCOV'.
      ls_properties-option = '3'.
      APPEND ls_properties TO lt_property.
      CLEAR : ls_properties.

      ls_properties-node_field = 'INCO2_L'.
      ls_properties-option = '3'.
      APPEND ls_properties TO lt_property.
      CLEAR : ls_properties.

      ls_properties-node_field = 'INCO3_L'.
      ls_properties-option = '3'.
      APPEND ls_properties TO lt_property.
      CLEAR : ls_properties.

      ls_properties-node_field = 'MWSKZ_P'.
      ls_properties-option = '3'.
      APPEND ls_properties TO lt_property.
      CLEAR : ls_properties.

      ls_properties-node_field = 'WEBRE'.
      ls_properties-option = '3'.
      APPEND ls_properties TO lt_property.
      CLEAR : ls_properties.

      ls_properties-node_field = 'ANGNR'.
      ls_properties-option = '3'.
      APPEND ls_properties TO lt_property.
      CLEAR : ls_properties.

      ls_properties-node_field = 'MHDRZ_P'.
      ls_properties-option = '3'.
      APPEND ls_properties TO lt_property.
      CLEAR : ls_properties.
    ENDIF.

    CLEAR : lt_row.
    SORT lt_property BY node_field.
    DELETE ADJACENT DUPLICATES FROM lt_property.
    INSERT LINES OF lt_property INTO TABLE lt_properties.

    mo_context->get_number_of_rows( IMPORTING ev_number_of_rows = DATA(lv_index) ).
    IF lv_index IS NOT INITIAL.
      WHILE lv_index IS NOT INITIAL.
        mo_context->set_field_properties( EXPORTING iv_index = lv_index it_properties = lt_properties ).
        lv_index = lv_index - 1.
      ENDWHILE.
    ENDIF.

    "Net Price and currency should not be editable in Change Mode
    CLEAR : lt_property, ls_properties, lt_properties.
    mo_context->get_rows( IMPORTING et_row = lt_row ).

    ls_properties-node_field = 'NETPR'.
    ls_properties-option = '3'.
    APPEND ls_properties TO lt_property.
    CLEAR : ls_properties.

    ls_properties-node_field = 'WAERS'.
    ls_properties-option = '3'.
    APPEND ls_properties TO lt_property.
    CLEAR : ls_properties.

    ls_properties-node_field = 'ESOKZ'.
    ls_properties-option = '3'.
    APPEND ls_properties TO lt_property.
    CLEAR : ls_properties.

    ls_properties-node_field = 'PEINH_P'.
    ls_properties-option = '3'.
    APPEND ls_properties TO lt_property.
    CLEAR : ls_properties.

    ls_properties-node_field = 'BPRME'.
    ls_properties-option = '3'.
    APPEND ls_properties TO lt_property.
    CLEAR : ls_properties.

    SORT lt_property BY node_field.
    DELETE ADJACENT DUPLICATES FROM lt_property.
    INSERT LINES OF lt_property INTO TABLE lt_properties.


    CLEAR : lt_row.

    mo_context->get_selection( IMPORTING et_selection = lt_row ).
    READ TABLE lt_row INTO ls_row INDEX 1.
    READ TABLE ct_action_usage ASSIGNING FIELD-SYMBOL(<fs_action_usage>) WITH KEY id = 'FRW_DELETE'.
    IF <fs_action_usage> IS ASSIGNED.
      ASSIGN COMPONENT 'ENABLED' OF STRUCTURE <fs_action_usage> TO FIELD-SYMBOL(<fs_enable>).
      IF <fs_enable> IS ASSIGNED.
        IF ls_row-infnr IS INITIAL.
          <fs_enable> = abap_true.
        ELSE.
          <fs_enable> = abap_false.
        ENDIF.
      ENDIF.
    ENDIF.
    IF lt_row IS INITIAL.
      <fs_enable> = abap_false.
    ENDIF.

    IF lv_process = 'MAT6'.
      READ TABLE ct_action_usage ASSIGNING FIELD-SYMBOL(<fs_action_usage1>) WITH KEY id = 'FRW_DELETE'.
      IF <fs_action_usage1> IS ASSIGNED.
        ASSIGN COMPONENT 'ENABLED' OF STRUCTURE <fs_action_usage1> TO FIELD-SYMBOL(<fs_enable1>).
        IF <fs_enable1> IS ASSIGNED.
          <fs_enable1> = abap_false.
        ENDIF.
      ENDIF.
    ENDIF.

    "Enable Ins button only when General data is selected
    READ TABLE ct_action_usage ASSIGNING FIELD-SYMBOL(<fs_action_usage2>) WITH KEY id = 'PURORG_INS'.
    IF <fs_action_usage2> IS ASSIGNED.
      ASSIGN COMPONENT 'ENABLED' OF STRUCTURE <fs_action_usage2> TO FIELD-SYMBOL(<fs_enable2>).
      ASSIGN COMPONENT 'VISIBLE' OF STRUCTURE <fs_action_usage2> TO FIELD-SYMBOL(<fs_visible>).
    ENDIF.
    IF zzmdg_cl_feeder_zpurchgen=>gs_row IS INITIAL.
      IF <fs_enable2> IS ASSIGNED.
        <fs_enable2> = abap_false.
      ENDIF.
    ELSE.
      IF <fs_enable2> IS ASSIGNED AND lv_crequest IS NOT INITIAL.
        <fs_visible> = '02'.
        <fs_enable2> = abap_true.
      ENDIF.
    ENDIF.
    IF lv_crequest IS INITIAL.
      <fs_visible> = '01'.
      <fs_enable2> = abap_false.
    ENDIF.

    lo_fpm = cl_fpm_factory=>get_instance( ).

    lo_fpm->get_uibb_edit_mode(
      EXPORTING
        is_uibb_instance_key = ls_blank_uibb_key
        iv_window_name       = lv_blank_window
      RECEIVING
        rv_edit_mode         = lv_edit_mode
    ).

    IF lv_edit_mode <> 'E'.
      <fs_enable2> = abap_false.
      <fs_visible> = '01'.
    ENDIF.

    ev_action_usage_changed = abap_true.

  endmethod.


  method /PLMU/IF_FRW_G_FIELD_DEF~CHANGE_FIELD_DEFINITION.
*CALL METHOD SUPER->/PLMU/IF_FRW_G_FIELD_DEF~CHANGE_FIELD_DEFINITION
**  IMPORTING
**    et_special_groups =
*  CHANGING
*    CO_CATALOGUE      =
*    CT_DEFINITION     =
*    .
    CALL METHOD super->/plmu/if_frw_g_field_def~change_field_definition
      IMPORTING
        et_special_groups = et_special_groups
      CHANGING
        co_catalogue      = co_catalogue
        ct_definition     = ct_definition.

    FIELD-SYMBOLS : <fs_definition> LIKE LINE OF ct_definition.
    READ TABLE ct_definition ASSIGNING <fs_definition> WITH KEY name = 'MWSKZ'.
    IF <fs_definition> IS ASSIGNED.
      <fs_definition>-ddic_shlp_name = 'SSH_T007A'.
    ENDIF.
  endmethod.


  method /PLMU/IF_FRW_G_GLOBAL_EVENTS~PROCESS_GLOBAL_EVENT.
*CALL METHOD SUPER->/PLMU/IF_FRW_G_GLOBAL_EVENTS~PROCESS_GLOBAL_EVENT
*  EXPORTING
*    IO_EVENT            =
*    IV_RAISED_BY_OWN_UI =
**  IMPORTING
**    ev_skip_default     =
**    ev_result           =
**    et_messages         =
*

    CALL METHOD super->/plmu/if_frw_g_global_events~process_global_event
      EXPORTING
        io_event            = io_event
        iv_raised_by_own_ui = iv_raised_by_own_ui
      IMPORTING
        ev_skip_default     = ev_skip_default
        ev_result           = ev_result
        et_messages         = et_messages.

    TYPES : BEGIN OF ty_pog,
              lifnr TYPE elifn,
              ekorg TYPE ekorg,
              werks TYPE werks_d,
              esokz TYPE esokz,
            END OF ty_pog.
    DATA : lt_pog TYPE TABLE OF ty_pog,
           ls_pog TYPE ty_pog.

    DATA : ls_data  TYPE zzmdg_bs_mat_s_eine,
           lt_data  TYPE TABLE OF zzmdg_bs_mat_s_eine.

    IF io_event->mv_event_id = 'SET_POG'.

      io_event->mo_event_data->get_value( EXPORTING iv_key = 'TAB' IMPORTING ev_value = lt_pog ).

      CHECK lt_pog IS NOT INITIAL.

      LOOP AT lt_pog INTO ls_pog.
        IF ls_pog-lifnr IS NOT INITIAL AND ls_pog-ekorg IS NOT INITIAL.
          ls_data-lifnr = ls_pog-lifnr.
          ls_data-ekorg = ls_pog-ekorg.
          ls_data-werks = ls_pog-werks.
          ls_data-esokz = ls_pog-esokz.
          APPEND ls_data TO lt_data.
        ENDIF.
        CLEAR : ls_data.
      ENDLOOP.
      IF lt_data IS NOT INITIAL.
        mo_application_model->insert(
          EXPORTING
            iv_node_name = 'ZPURCHINF'
            it_node_data = lt_data
          IMPORTING
            ev_failed    = DATA(ev_failed) ).
        IF ev_failed EQ abap_false.
          mo_application_model->action(
            EXPORTING
              iv_node_name    = cl_mdg_bs_mat_c=>gc_node_name_settings
              iv_action_name  = cl_mdg_bs_mat_c=>gc_action_confirm_entity_data
            IMPORTING
              ev_failed       = ev_failed
          ).
        ENDIF.
      ENDIF.
    ENDIF.

  endmethod.


  method /PLMU/IF_FRW_G_OVS~HANDLE_PHASE_0.
*CALL METHOD SUPER->/PLMU/IF_FRW_G_OVS~HANDLE_PHASE_0
*  EXPORTING
*    IV_FIELD_NAME   =
*    IO_OVS_CALLBACK =
*    .

    CALL METHOD super->/plmu/if_frw_g_ovs~handle_phase_0
      EXPORTING
        iv_field_name   = iv_field_name
        io_ovs_callback = io_ovs_callback.

  endmethod.


  method /PLMU/IF_FRW_G_OVS~HANDLE_PHASE_1.
*CALL METHOD SUPER->/PLMU/IF_FRW_G_OVS~HANDLE_PHASE_1
*  EXPORTING
*    IV_FIELD_NAME   =
*    IO_OVS_CALLBACK =
*    .
    CHECK : iv_field_name = 'MWSKZ'.
    TYPES : BEGIN OF ty_query,
              mwskz TYPE mwskz,
              text1 TYPE text1_007s,
            END OF ty_query.

    DATA : ls_mwskz TYPE ty_query.

    io_ovs_callback->set_input_structure(
      EXPORTING
        input                      = ls_mwskz
*        group_header               =                  " Obsolete
*        label_texts                =                  " Table of Name Value Pairs
*        window_title               =
        display_values_immediately = abap_true       " Display values immediately
    ).

  endmethod.


  method /PLMU/IF_FRW_G_OVS~HANDLE_PHASE_2.
*CALL METHOD SUPER->/PLMU/IF_FRW_G_OVS~HANDLE_PHASE_2
*  EXPORTING
*    IV_FIELD_NAME   =
*    IO_OVS_CALLBACK =
*    .

    TYPES : BEGIN OF ty_query,
              mwskz TYPE mwskz,
              text1 TYPE text1_007s,
            END OF ty_query.

    DATA : lt_mwskz       TYPE TABLE OF ty_mwskz,
           lt_mwskz_query TYPE TABLE OF ty_mwskz,
           ls_mwskz       LIKE LINE OF lt_mwskz,
           lr_data        TYPE REF TO data,
           lv_kalsm       TYPE kalsm_d,
           ls_t001        TYPE t001,
           ls_query       TYPE ty_query,
           lv_ekorg       TYPE ekorg,
           lv_message     TYPE string,
           ls_message     TYPE usmd_s_message,
           et_message     TYPE usmd_t_message.

    FIELD-SYMBOLS : <fs_data>  TYPE any,
                    <fs_value> TYPE any.

    CONSTANTS : lc_msg_cls TYPE string VALUE 'W_CB_AIL'.

*    CHECK : iv_field_name = 'MWSKZ'.
    IF iv_field_name = 'MWSKZ'.
      io_ovs_callback->get_row_data(
        IMPORTING
          er_data = lr_data
*        es_data =
      ).

      io_ovs_callback->get_query_parameters( IMPORTING es_data = ls_query ).

      IF lr_data IS BOUND.
        ASSIGN lr_data->* TO <fs_data>.
        CHECK <fs_data> IS ASSIGNED.
      ENDIF.
      IF <fs_data> IS NOT INITIAL.
        ASSIGN COMPONENT 'EKORG' OF STRUCTURE <fs_data> TO <fs_value>.
        IF <fs_value> IS ASSIGNED AND <fs_value> IS NOT INITIAL.
*        SELECT SINGLE land1 FROM lfa1 INTO lv_ctry WHERE lifnr = <fs_value>.
*          TRY.
          CALL FUNCTION 'WCB_COMP_CODE_OF_PURCH_ORG'
            EXPORTING
              i_ekorg         = <fs_value>
            IMPORTING
              e_t001          = ls_t001
            EXCEPTIONS
              ekorg_not_found = 1
              bukrs_not_found = 2
              OTHERS          = 3.
          IF sy-subrc <> 0.
* Implement suitable error handling here
           MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4 INTO lv_message.
           MOVE-CORRESPONDING sy TO ls_message.
           ls_message-msgty = 'E'.
           INSERT ls_message INTO TABLE et_message.
*            CATCH CX_WDR_RT_EXCEPTION.
          ENDIF.
*          ENDTRY.

          IF ls_t001-land1 IS NOT INITIAL.
            SELECT SINGLE kalsm FROM t005 INTO lv_kalsm WHERE land1 = ls_t001-land1.
            IF lv_kalsm IS NOT INITIAL.
              SELECT mwskz kalsm text1 FROM t007s INTO TABLE lt_mwskz WHERE kalsm = lv_kalsm AND spras = sy-langu.   "#EC CI_NOORDER
            ENDIF.
          ENDIF.
        ELSEIF <fs_value> IS ASSIGNED AND <fs_value> IS INITIAL.
          CLEAR lt_mwskz.
          io_ovs_callback->set_output_table(
            EXPORTING
              output       = lt_mwskz
*              table_header =
*              column_texts =                  " Table of Name Value Pairs
          ).
        ENDIF.
      ELSE.
        CLEAR lt_mwskz.
        io_ovs_callback->set_output_table(
    EXPORTING
      output       = lt_mwskz
*              table_header =
*              column_texts =                  " Table of Name Value Pairs
  ).
      ENDIF.

      IF lt_mwskz IS NOT INITIAL AND ls_query IS INITIAL.
        io_ovs_callback->set_output_table(
          EXPORTING
            output       = lt_mwskz
*              table_header =
*              column_texts =                  " Table of Name Value Pairs
        ).
      ENDIF.

      IF ls_query IS NOT INITIAL.
        LOOP AT lt_mwskz INTO ls_mwskz WHERE mwskz = ls_query-mwskz OR text1 CS ls_query-text1.
          READ TABLE lt_mwskz_query WITH KEY mwskz = ls_mwskz-mwskz kalsm = ls_mwskz-kalsm TRANSPORTING NO FIELDS.
          IF sy-subrc IS NOT INITIAL.
            APPEND ls_mwskz TO lt_mwskz_query.
          ENDIF.
        ENDLOOP.
        IF lt_mwskz_query IS NOT INITIAL.
          io_ovs_callback->set_output_table(
            EXPORTING
             output       = lt_mwskz_query
*              table_header =
*              column_texts =                  " Table of Name Value Pairs
  ).
        ENDIF.
      ENDIF.
    ENDIF.

  endmethod.


  method /PLMU/IF_FRW_G_OVS~HANDLE_PHASE_3.
*CALL METHOD SUPER->/PLMU/IF_FRW_G_OVS~HANDLE_PHASE_3
*  EXPORTING
*    IV_FIELD_NAME   =
*    IO_OVS_CALLBACK =
**  IMPORTING
**    eo_fpm_event    =
*    .

    DATA :lv_mwskz TYPE mwskz.

    IF iv_field_name EQ 'MWSKZ'.
      io_ovs_callback->get_selection( IMPORTING es_data = lv_mwskz ).
      CHECK lv_mwskz IS NOT INITIAL.
      io_ovs_callback->set_attribute_value( EXPORTING iv_value = lv_mwskz ).
    ENDIF.

  endmethod.


  method BUILD_MESSAGE.

     "Method to build messages
   DATA:ls_message LIKE LINE OF ct_message.

    IF is_message IS NOT INITIAL.
      CLEAR ls_message.
      ls_message-msgid = is_message-msgid.
      ls_message-msgno = is_message-msgno.
      ls_message-msgv1 = is_message-msgv1.
      ls_message-msgv2 = is_message-msgv2.
      ls_message-msgv3 = is_message-msgv3.
      ls_message-msgv4 = is_message-msgv4.
      ls_message-msgty = is_message-msgty.

      INSERT ls_message INTO TABLE ct_message.
    ENDIF.

  endmethod.
ENDCLASS.
