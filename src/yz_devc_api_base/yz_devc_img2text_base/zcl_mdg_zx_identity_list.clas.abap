class ZCL_MDG_ZX_IDENTITY_LIST definition
  public
  inheriting from CL_MDG_BS_GUIBB_LIST
  final
  create public .

public section.

  methods IF_FPM_GUIBB_LIST~GET_DEFINITION
    redefinition .
  methods IF_FPM_GUIBB_LIST~PROCESS_EVENT
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCL_MDG_ZX_IDENTITY_LIST IMPLEMENTATION.


  method if_fpm_guibb_list~get_definition.

    call method super->if_fpm_guibb_list~get_definition
      importing
        eo_field_catalog         = eo_field_catalog
        et_field_description     = et_field_description
        et_action_definition     = et_action_definition
        et_special_groups        = et_special_groups
        es_message               = es_message
        ev_additional_error_info = ev_additional_error_info
        et_dnd_definition        = et_dnd_definition
        et_row_actions           = et_row_actions
        es_options               = es_options.

    append initial line to et_row_actions assigning field-symbol(<fs_row_action>).
    <fs_row_action>-id = 'ROW_ATTACHMENT'.
    <fs_row_action>-text = 'Attachment'.

     append initial line to et_action_definition assigning field-symbol(<fs_action_definition>).
    <fs_action_definition>-id = 'Attachment'.
    <fs_action_definition>-enabled = abap_true.

  endmethod.


  method if_fpm_guibb_list~process_event.
    data lr_fpm type ref to cl_fpm_factory.

    call method super->if_fpm_guibb_list~process_event "mainly FPM_LOCAL_EDIT, FPM_GUIBB_LIST_CELL_ACTION, FPM_TRAY_TOGGLE
      exporting
        io_event            = io_event
        iv_raised_by_own_ui = iv_raised_by_own_ui
        iv_lead_index       = iv_lead_index
        iv_event_index      = iv_event_index
        it_selected_lines   = it_selected_lines
      importing
        ev_result           = ev_result
        et_messages         = et_messages.

    case io_event->mv_event_id.
      when 'ROW_ATTACHMENT'.
        io_event->mo_event_data->set_value(
       exporting
         iv_key = if_fpm_constants=>gc_dialog_box-id
         iv_value = 'ZUSMD_ENTITY_ATT_FILE' ).
        cl_fpm_factory=>get_instance( )->open_dialog_box(
        iv_dialog_box_id = 'ZUSMD_ENTITY_ATT_FILE'
        io_event_data = io_event->mo_event_data ).
        return.
    endcase.
  endmethod.
ENDCLASS.
