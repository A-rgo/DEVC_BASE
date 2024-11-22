class ZZMDG_CL_FEEDER_ZPURCHGEN definition
  public
  inheriting from CL_MDG_BS_MAT_FEEDER_LIST
  final
  create public .

public section.

  class-data GS_ROW type ZZMDG_BS_MAT_S_EINA .

  methods GET_LEAD_SEL_ROW
    exporting
      !ET_ROW type ANY TABLE .

  methods /PLMU/IF_FRW_G_ACTIONS~GET_ACTION_DEFINITION
    redefinition .
  methods /PLMU/IF_FRW_G_ACTIONS~PROCESS_ACTION_EVENT
    redefinition .
  methods /PLMU/IF_FRW_G_AFTER_GET_DATA~AFTER_GET_DATA
    redefinition .
  methods /PLMU/IF_FRW_G_BEFORE_FLUSH~BEFORE_FLUSH
    redefinition .
  methods /PLMU/IF_FRW_G_BEFORE_GET_DATA~BEFORE_GET_DATA
    redefinition .
  methods /PLMU/IF_FRW_G_FIELD_DEF~CHANGE_FIELD_DEFINITION
    redefinition .
  methods /PLMU/IF_FRW_G_GLOBAL_EVENTS~PROCESS_GLOBAL_EVENT
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZZMDG_CL_FEEDER_ZPURCHGEN IMPLEMENTATION.


  method /PLMU/IF_FRW_G_ACTIONS~GET_ACTION_DEFINITION.

    CALL METHOD super->/plmu/if_frw_g_actions~get_action_definition
      CHANGING
        ct_action_definition     = ct_action_definition
        ct_row_action_definition = ct_row_action_definition.

    DATA ls_action_definition LIKE LINE OF ct_action_definition.

    FIELD-SYMBOLS <ls_action_definition> LIKE LINE OF ct_action_definition.

* Navigate to details popup
    ls_action_definition-id   = 'PIR_DETAIL'.
    ls_action_definition-text = 'PIR_DETAIL'.
    ls_action_definition-imagesrc = '~Icon/Display'.
    ls_action_definition-enabled = abap_true.
    ls_action_definition-visible = 02.
    ls_action_definition-disable_when_no_lead_sel = abap_true.
    ls_action_definition-disable_when_no_sel = abap_true.
*    ls_action_definition-is_implicit_edit = abap_true.
    INSERT ls_action_definition INTO TABLE ct_action_definition.

    READ TABLE ct_action_definition ASSIGNING <ls_action_definition> WITH KEY id = 'FRW_DELETE' .
    <ls_action_definition>-disable_when_no_lead_sel = abap_true.
    <ls_action_definition>-disable_when_no_sel = abap_true.
    <ls_action_definition>-visible = 02.

    .
  endmethod.


  method /PLMU/IF_FRW_G_ACTIONS~PROCESS_ACTION_EVENT.

    CALL METHOD super->/plmu/if_frw_g_actions~process_action_event
      EXPORTING
        io_event        = io_event
        iv_index        = iv_index
      IMPORTING
        ev_skip_default = ev_skip_default
        ev_result       = ev_result
        et_messages     = et_messages.

    DATA : lt_row TYPE STANDARD TABLE OF zzmdg_s_mm_pp_zpurchgen.
    DATA : lt_row1 TYPE STANDARD TABLE OF zzmdg_bs_mat_s_eina,
           ls_row1 like LINE OF lt_row1.
    DATA: lo_fpm TYPE REF TO if_fpm.
    DATA: ls_dialog TYPE fpm_s_dialog_box_properties.

    IF io_event->mv_event_id = 'PIR_DETAIL'.
      mo_context->get_selection( IMPORTING et_selection = lt_row1 ).
      READ TABLE lt_row1 INTO ls_row1 INDEX 1.
      MOVE-CORRESPONDING ls_row1 TO gs_row.

      lo_fpm = cl_fpm_factory=>get_instance( ).
      ls_dialog-width = 1000.
      ls_dialog-height = 100.
      lo_fpm->open_dialog_box( EXPORTING
                               is_dialog_box_properties = ls_dialog
                               iv_dialog_box_id = 'PIR_POPUP' ).
    ENDIF.

  endmethod.


  method /PLMU/IF_FRW_G_AFTER_GET_DATA~AFTER_GET_DATA.

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
           ls_properties LIKE LINE OF lt_properties.


    lo_context = cl_usmd_app_context=>get_context( ).
    IF lo_context IS BOUND.
      CLEAR: lv_process.
      lo_context->get_attributes(
      IMPORTING
        ev_process        = lv_process ).
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

      ls_properties-node_field = 'LIFNR'.
      ls_properties-option = '3'.
      APPEND ls_properties TO lt_property.
      CLEAR : ls_properties.

      ls_properties-node_field = 'INFNR'.
      ls_properties-option = '3'.
      APPEND ls_properties TO lt_property.
      CLEAR : ls_properties.

      ls_properties-node_field = 'MAHN1'.
      ls_properties-option = '3'.
      APPEND ls_properties TO lt_property.
      CLEAR : ls_properties.

      ls_properties-node_field = 'MAHN2'.
      ls_properties-option = '3'.
      APPEND ls_properties TO lt_property.
      CLEAR : ls_properties.

      ls_properties-node_field = 'MAHN3'.
      ls_properties-option = '3'.
      APPEND ls_properties TO lt_property.
      CLEAR : ls_properties.

      ls_properties-node_field = 'IDNLF'.
      ls_properties-option = '3'.
      APPEND ls_properties TO lt_property.
      CLEAR : ls_properties.

      ls_properties-node_field = 'WGLIF'.
      ls_properties-option = '3'.
      APPEND ls_properties TO lt_property.
      CLEAR : ls_properties.

      ls_properties-node_field = 'VERKF'.
      ls_properties-option = '3'.
      APPEND ls_properties TO lt_property.
      CLEAR : ls_properties.

      ls_properties-node_field = 'TELF1'.
      ls_properties-option = '3'.
      APPEND ls_properties TO lt_property.
      CLEAR : ls_properties.

      ls_properties-node_field = 'RUECK'.
      ls_properties-option = '3'.
      APPEND ls_properties TO lt_property.
      CLEAR : ls_properties.

      ls_properties-node_field = 'MEINS_P'.
      ls_properties-option = '3'.
      APPEND ls_properties TO lt_property.
      CLEAR : ls_properties.

      ls_properties-node_field = 'KOLIF'.
      ls_properties-option = '3'.
      APPEND ls_properties TO lt_property.
      CLEAR : ls_properties.

      ls_properties-node_field = 'URZZT'.
      ls_properties-option = '3'.
      APPEND ls_properties TO lt_property.
      CLEAR : ls_properties.

      ls_properties-node_field = 'MFRNR_P'.
      ls_properties-option = '3'.
      APPEND ls_properties TO lt_property.
      CLEAR : ls_properties.

    ENDIF.

    SORT lt_property BY node_field.
    INSERT LINES OF lt_property INTO TABLE lt_properties.

    mo_context->get_number_of_rows( IMPORTING ev_number_of_rows = DATA(lv_index) ).
    IF lv_index IS NOT INITIAL.
      WHILE lv_index IS NOT INITIAL.
        mo_context->set_field_properties( EXPORTING iv_index = lv_index it_properties = lt_properties ).
        lv_index = lv_index - 1.
      ENDWHILE.
    ENDIF.

    DATA : lt_row TYPE STANDARD TABLE OF zzmdg_bs_mat_s_eina,
           ls_row LIKE LINE OF lt_row.
    DATA : lv_blank_window   TYPE fpm_window_name ##needed,
           ls_blank_uibb_key TYPE fpm_s_uibb_instance_key ##needed,
           lv_edit_mode      TYPE fpm_edit_mode.

    DATA(lo_fpm) = cl_fpm_factory=>get_instance( ).

    lo_fpm->get_uibb_edit_mode(
      EXPORTING
        is_uibb_instance_key = ls_blank_uibb_key
        iv_window_name       = lv_blank_window
      RECEIVING
        rv_edit_mode         = lv_edit_mode
    ).

    mo_context->get_selection( IMPORTING et_selection = lt_row ).
    READ TABLE lt_row INTO ls_row INDEX 1.
    READ TABLE ct_action_usage ASSIGNING FIELD-SYMBOL(<fs_action_usage>) WITH KEY id = 'FRW_DELETE'.
    IF <fs_action_usage> IS ASSIGNED.
      ASSIGN COMPONENT 'ENABLED' OF STRUCTURE <fs_action_usage> TO FIELD-SYMBOL(<fs_enable>).
      ASSIGN COMPONENT 'VISIBLE' OF STRUCTURE <fs_action_usage> TO FIELD-SYMBOL(<fs_visible>).
      IF <fs_enable> IS ASSIGNED.
        IF ls_row-infnr IS INITIAL.
          <fs_enable> = abap_true.
        ELSE.
          <fs_enable> = abap_false.
        ENDIF.
      ENDIF.

      IF lv_edit_mode <> 'E'.
        <fs_visible> = '01'.
      ENDIF.

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

    ev_action_usage_changed = abap_true.
  endmethod.


  method /PLMU/IF_FRW_G_BEFORE_FLUSH~BEFORE_FLUSH.

   DATA: ls_row       TYPE zzmdg_bs_mat_s_eina,
          ls_row_o    TYPE zzmdg_bs_mat_s_eina,
          lr_data_new TYPE REF TO data,
          lr_data_old TYPE REF TO data.

    DATA: go_struct TYPE REF TO cl_abap_structdescr,
          gt_comp   TYPE abap_component_tab,
          gt_comp1  TYPE STANDARD TABLE OF abap_simple_componentdescr,
          gs_comp   TYPE abap_componentdescr,
          lv_name   TYPE string.

    CALL METHOD super->/plmu/if_frw_g_before_flush~before_flush
      CHANGING
        ct_change_log = ct_change_log.

    DATA: lo_fpm     TYPE REF TO if_fpm,
          lo_fpm_ref TYPE REF TO cl_fpm,
          lr_data    TYPE REF TO data.
    FIELD-SYMBOLS : <fs_data> TYPE any,
                    <fs_value> TYPE any,
                    <fs_value1> TYPE any,
                    <fs_old> TYPE any,
                    <fs_new> TYPE any.
    DATA : lt_change_log TYPE STANDARD TABLE OF fpmgb_s_changelog,
           ls_change_log LIKE LINE OF lt_change_log.

    lo_fpm = cl_fpm_factory=>get_instance( ).
    lo_fpm_ref ?= lo_fpm.
    DATA(lv_event_id) = lo_fpm_ref->mo_current_event->mv_event_id.
    IF lv_event_id = 'SET_PIR'.
      lo_fpm_ref->mo_current_event->mo_event_data->get_value( EXPORTING iv_key = 'ROW' IMPORTING ev_value = ls_row ).
*      ls_row-matnr = ls_data-material.
*      ls_row-meins = ls_data-meins_p.
      mo_context->get_selection_index( IMPORTING et_index = DATA(lt_index) ).
      READ TABLE lt_index INTO DATA(lv_index) INDEX 1.
      mo_context->get_row( EXPORTING iv_index = lv_index IMPORTING es_row = ls_row_o ).
      mo_context->set_row( EXPORTING iv_index = lv_index is_row = ls_row ).
      CREATE DATA lr_data LIKE ls_row.
      ASSIGN lr_data->* TO <fs_data>.
      <fs_data> = ls_row.
*      ls_change_log-line_index = lv_index.
*      ls_change_log-table_row = lr_data.
*      APPEND ls_change_log TO ct_change_log.

      go_struct ?= cl_abap_typedescr=>describe_by_name( 'ZZMDG_BS_MAT_S_EINA' ).
      gt_comp = go_struct->get_components( ).
      gt_comp1 = go_struct->get_included_view( ).

      ASSIGN ls_row_o TO FIELD-SYMBOL(<fs_row_o>).
      ASSIGN ls_row   TO FIELD-SYMBOL(<fs_row>).
      LOOP AT gt_comp INTO gs_comp.
        lv_name = gs_comp-name.
        ASSIGN COMPONENT lv_name OF STRUCTURE <fs_row_o> TO <fs_value>.
        ASSIGN COMPONENT lv_name OF STRUCTURE <fs_row> TO <fs_value1>.

        IF <fs_value> IS ASSIGNED AND <fs_value1> IS ASSIGNED.
          CREATE DATA lr_data_old LIKE <fs_value>.
          CREATE DATA lr_data_new LIKE <fs_value1>.
          ASSIGN lr_data_old->* TO <fs_old>.
          ASSIGN lr_data_new->* TO <fs_new>.
          <fs_old> = <fs_value>.
          <fs_new> = <fs_value1>.
          IF <fs_value> <> <fs_value1>.
            ls_change_log-name = lv_name.
            ls_change_log-new_value = lr_data_new.
            ls_change_log-old_value = lr_data_old.
            ls_change_log-line_index = lv_index.
            ls_change_log-table_row = lr_data.
            APPEND ls_change_log TO lt_change_log.
          ENDIF.
        ENDIF.
      ENDLOOP.

      LOOP AT gt_comp1 INTO DATA(gs_comp1).
        lv_name = gs_comp1-name.
        ASSIGN COMPONENT lv_name OF STRUCTURE <fs_row_o> TO <fs_value>.
        ASSIGN COMPONENT lv_name OF STRUCTURE <fs_row> TO <fs_value1>.

        IF <fs_value> IS ASSIGNED AND <fs_value1> IS ASSIGNED.
          CREATE DATA lr_data_old LIKE <fs_value>.
          CREATE DATA lr_data_new LIKE <fs_value1>.
          ASSIGN lr_data_old->* TO <fs_old>.
          ASSIGN lr_data_new->* TO <fs_new>.
          <fs_old> = <fs_value>.
          <fs_new> = <fs_value1>.
          IF <fs_value> <> <fs_value1>.
            ls_change_log-name = lv_name.
            ls_change_log-new_value = lr_data_new.
            ls_change_log-old_value = lr_data_old.
            ls_change_log-line_index = lv_index.
            ls_change_log-table_row = lr_data.
            APPEND ls_change_log TO lt_change_log.
          ENDIF.
        ENDIF.
      ENDLOOP.

      INSERT LINES OF lt_change_log INTO TABLE ct_change_log.
    ENDIF.


  endmethod.


  method /PLMU/IF_FRW_G_BEFORE_GET_DATA~BEFORE_GET_DATA.
*CALL METHOD SUPER->/PLMU/IF_FRW_G_BEFORE_GET_DATA~BEFORE_GET_DATA
*  EXPORTING
*    IO_EVENT           =
*    IV_FIRST_TIME      =
**    iv_lock            =
**    it_selected_fields =
**  IMPORTING
**    ev_skip_retrieve   =
*    .
    CALL METHOD super->/plmu/if_frw_g_before_get_data~before_get_data
      EXPORTING
        io_event           = io_event
        iv_first_time      = iv_first_time
        iv_lock            = iv_lock
        it_selected_fields = it_selected_fields
      IMPORTING
        ev_skip_retrieve   = ev_skip_retrieve.

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
*    .

   CALL METHOD super->/plmu/if_frw_g_global_events~process_global_event
      EXPORTING
        io_event            = io_event
        iv_raised_by_own_ui = iv_raised_by_own_ui
      IMPORTING
        ev_skip_default     = ev_skip_default
        ev_result           = ev_result
        et_messages         = et_messages.

    DATA : lt_row TYPE STANDARD TABLE OF zzmdg_s_mm_pp_zpurchgen,
           ls_row LIKE LINE OF lt_row.
    DATA: lo_fpm TYPE REF TO if_fpm.
    DATA: ls_dialog TYPE fpm_s_dialog_box_properties.

    mo_context->get_selection( IMPORTING et_selection = lt_row ).
    READ TABLE lt_row INTO ls_row INDEX 1.
    MOVE-CORRESPONDING ls_row TO gs_row.

    IF io_event->mv_event_id = 'PIR_DETAIL'.
      mo_context->get_selection( IMPORTING et_selection = lt_row ).
      READ TABLE lt_row INTO ls_row INDEX 1.
      MOVE-CORRESPONDING ls_row TO gs_row.
      gs_row-matnr = ls_row-material.
      gs_row-meins = ls_row-meins_p.

      lo_fpm = cl_fpm_factory=>get_instance( ).
      ls_dialog-width = 70.
      ls_dialog-height = 100.
      lo_fpm->open_dialog_box( EXPORTING
                               is_dialog_box_properties = ls_dialog
                               iv_dialog_box_id = 'PIR_POPUP' ).
    ENDIF.

  endmethod.


  method GET_LEAD_SEL_ROW.

    DATA :lt_row TYPE TABLE OF zzmdg_bs_mat_s_eina.
    mo_context->get_selection( IMPORTING et_selection = lt_row ).
    et_row = lt_row.

  endmethod.
ENDCLASS.
