class YS_CLAS_MDG_YS_FORM_FEEDER definition
  public
  inheriting from CL_MDG_BS_GUIBB_FORM
  final
  create public .

public section.

  methods IF_FPM_GUIBB_FORM~GET_DATA
    redefinition .
  methods IF_FPM_GUIBB_FORM~GET_DEFINITION
    redefinition .
protected section.

  methods GET_ENTITY_DATA
    redefinition .
private section.
ENDCLASS.



CLASS YS_CLAS_MDG_YS_FORM_FEEDER IMPLEMENTATION.


  METHOD get_entity_data.
    CALL METHOD super->get_entity_data
      EXPORTING
        io_access = io_access
      CHANGING
        cs_data   = cs_data.
  ENDMETHOD.


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

*  SOC Karthick
    "Making Mandatory field ASTYP service category and MEINS Base UoM.
    LOOP AT ct_field_usage ASSIGNING FIELD-SYMBOL(<ls_field_usage>).
      IF <ls_field_usage>-name = 'ASTYP' OR <ls_field_usage>-name = 'MEINS'
         OR <ls_field_usage>-name = 'ASKTX'." OR <ls_field_usage>-name = 'MSTDE' OR <ls_field_usage>-name = 'MSTAE'.
        <ls_field_usage>-mandatory = abap_true.
      ENDIF.
      IF <ls_field_usage>-name = 'YY_SERVIC'.
        <ls_field_usage>-mandatory = abap_false.
        <ls_field_usage>-read_only = abap_true.
      ENDIF.
    ENDLOOP.

    " Hiding the Create and Delete button in UI while CR is processing
    LOOP AT ct_action_usage ASSIGNING FIELD-SYMBOL(<ls_action_usage>).
      IF <ls_action_usage>-id = '_DELE_' OR <ls_action_usage>-id = '_CREA_' .
        <ls_action_usage>-visible = '01'. " hiding
      ENDIF.
    ENDLOOP.
*  EOC Karthick

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
  ENDMETHOD.
ENDCLASS.
