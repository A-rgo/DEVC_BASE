class YCL_MDG_MM_BOMHDR_FEEDER_FORM definition
  public
  inheriting from CL_MDG_BS_MAT_FEEDER_FORM
  final
  create public .

public section.

  methods /PLMU/IF_FRW_G_AFTER_GET_DATA~AFTER_GET_DATA
    redefinition .
  methods /PLMU/IF_FRW_G_FIELD_DEF~CHANGE_FIELD_DEFINITION
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS YCL_MDG_MM_BOMHDR_FEEDER_FORM IMPLEMENTATION.


  METHOD /plmu/if_frw_g_after_get_data~after_get_data.

    """Code added by Ram to disable the Details button from the UI
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


  ENDMETHOD.


  METHOD /plmu/if_frw_g_field_def~change_field_definition.
    CALL METHOD super->/plmu/if_frw_g_field_def~change_field_definition
      IMPORTING
        et_special_groups = et_special_groups
      CHANGING
        co_catalogue      = co_catalogue
        ct_definition     = ct_definition.
  ENDMETHOD.
ENDCLASS.
