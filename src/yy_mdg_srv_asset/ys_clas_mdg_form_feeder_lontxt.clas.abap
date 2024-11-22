class YS_CLAS_MDG_FORM_FEEDER_LONTXT definition
  public
  inheriting from CL_MDG_BS_GUIBB_FORM
  final
  create public .

public section.

  methods IF_FPM_GUIBB_FORM~GET_DATA
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS YS_CLAS_MDG_FORM_FEEDER_LONTXT IMPLEMENTATION.


  method IF_FPM_GUIBB_FORM~GET_DATA.
CALL METHOD super->if_fpm_guibb_form~get_data(
    EXPORTING
      io_event                = io_event
      it_selected_fields      = it_selected_fields
      iv_raised_by_own_ui     = iv_raised_by_own_ui
      iv_edit_mode            = iv_edit_mode
    IMPORTING
      et_messages             = et_messages
      ev_data_changed         = ev_data_changed
      ev_field_usage_changed  = ev_field_usage_changed
      ev_action_usage_changed = ev_action_usage_changed
    CHANGING
      cs_data                 = cs_data
      ct_field_usage          = ct_field_usage
      ct_action_usage         = ct_action_usage
  ).

    " Hiding the Create and Delete button in UI while CR is processing
    LOOP AT ct_action_usage ASSIGNING FIELD-SYMBOL(<ls_action_usage>).
      IF <ls_action_usage>-id = '_DELE_' OR <ls_action_usage>-id = '_CREA_' .
        <ls_action_usage>-visible = '01'. " hiding
      ENDIF.
    ENDLOOP.

  endmethod.
ENDCLASS.
