class YZ_CL_MDG_BS_GUIBB_FORM definition
  public
  inheriting from CL_MDG_BS_GUIBB_FORM
  final
  create public .

public section.

  methods IF_FPM_GUIBB_FORM~GET_DATA
    redefinition .
  methods IF_FPM_GUIBB_FORM~PROCESS_EVENT
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS YZ_CL_MDG_BS_GUIBB_FORM IMPLEMENTATION.


  method if_fpm_guibb_form~get_data.

    data : lv_field_usage type fpmgb_s_fieldusage,
          lv_hry type abap_boolean,
          lv_top type abap_boolean.

    super->if_fpm_guibb_form~get_data(
      exporting
        io_event                = io_event
        it_selected_fields      = it_selected_fields
        iv_raised_by_own_ui     = iv_raised_by_own_ui
        iv_edit_mode            = iv_edit_mode
      importing
        et_messages             = et_messages
        ev_data_changed         = ev_data_changed
        ev_field_usage_changed  = ev_field_usage_changed
        ev_action_usage_changed = ev_action_usage_changed
      changing
        cs_data                 = cs_data
        ct_field_usage          = ct_field_usage
        ct_action_usage         = ct_action_usage
    ).

***Disable hierarchy nodes for non-hierarchial data or top nodes.
*      assign component 'ZIS_HRY' of structure cs_data to field-symbol(<lfs_hry>).
*      if sy-subrc eq 0 .
*        lv_hry = <lfs_hry>.
*      endif.
*      assign component 'ZIS_TOP' of structure cs_data to field-symbol(<lfs_top>).
*      if sy-subrc eq 0 .
*        lv_top = <lfs_top>.
*      endif.
*    loop at ct_field_usage into lv_field_usage.
*      case lv_field_usage-name.
*        when 'ZHAS_TOP' or 'ZHAS_SUB'.
*          if lv_hry is initial or lv_top is not initial.
*            lv_field_usage-enabled = abap_false.
*            modify ct_field_usage from lv_field_usage transporting enabled where name = lv_field_usage-name.
*            ev_field_usage_changed = abap_true.
*          elseif lv_hry is not initial and lv_top is not initial.
*            lv_field_usage-mandatory = abap_true.
*            modify ct_field_usage from lv_field_usage transporting mandatory where name = lv_field_usage-name.
*            ev_field_usage_changed = abap_true.
*          endif.
*
*        when 'ZIS_TOP'.
*          if lv_hry is initial.
*            lv_field_usage-read_only = abap_true.
*            modify ct_field_usage from lv_field_usage transporting read_only where name = lv_field_usage-name.
*            ev_field_usage_changed = abap_true.
*          endif.
*        when others.
*      endcase.

*  endloop.
endmethod.


  method IF_FPM_GUIBB_FORM~PROCESS_EVENT.
CALL METHOD SUPER->IF_FPM_GUIBB_FORM~PROCESS_EVENT
  EXPORTING
    IO_EVENT            = io_event
    iv_raised_by_own_ui = iv_raised_by_own_ui
  importing
    ev_result           = ev_result
    et_messages         = et_messages
    .
  endmethod.
ENDCLASS.
