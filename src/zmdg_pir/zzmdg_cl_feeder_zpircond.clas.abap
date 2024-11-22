class ZZMDG_CL_FEEDER_ZPIRCOND definition
  public
  inheriting from CL_MDG_BS_MAT_FEEDER_LIST
  final
  create public .

public section.

  methods /PLMU/IF_FRW_G_ACTIONS~PROCESS_ACTION_EVENT
    redefinition .
  methods /PLMU/IF_FRW_G_AFTER_GET_DATA~AFTER_GET_DATA
    redefinition .
  methods /PLMU/IF_FRW_G_BEFORE_FLUSH~BEFORE_FLUSH
    redefinition .
  methods /PLMU/IF_FRW_G_BEFORE_GET_DATA~BEFORE_GET_DATA
    redefinition .
  methods /PLMU/IF_FRW_G_CONFIG_PARAM~SET_PARAMETER_VALUES
    redefinition .
  methods /PLMU/IF_FRW_G_FIELD_DEF~CHANGE_FIELD_DEFINITION
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZZMDG_CL_FEEDER_ZPIRCOND IMPLEMENTATION.


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

  DATA : ls_row     TYPE zzmdg_bs_mat_s_eine,
         ls_data    TYPE zzmdg_bs_mat_s_cond,
         lt_data    TYPE TABLE OF zzmdg_bs_mat_s_cond,
         ls_message TYPE fpmgb_s_t100_message,
         lv_usrname TYPE usr02-bname,
         lv_plant   TYPE ust12-von.

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
*      READ TABLE lt_data INTO ls_data INDEX 1.
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

  DATA : lo_context  TYPE REF TO if_usmd_app_context,
         lt_row      TYPE STANDARD TABLE OF zzmdg_bs_mat_s_cond,
         ls_row      LIKE LINE OF lt_row,
         lv_process  TYPE usmd_process,
         lv_crequest TYPE usmd_crequest.

  DATA : lt_properties TYPE /plmb/t_spi_properties,
         ls_properties LIKE LINE OF lt_properties,
         lt_property   TYPE STANDARD TABLE OF /plmb/s_spi_properties.


  FIELD-SYMBOLS : <fs_action_usage> LIKE LINE OF ct_action_usage,
                  <fs_field_usage>  LIKE LINE OF ct_field_usage.




  lo_context = cl_usmd_app_context=>get_context( ).
  IF lo_context IS BOUND.
    lo_context->get_attributes( IMPORTING ev_process = lv_process ev_crequest_id = lv_crequest ).
  ENDIF.


  IF lv_process EQ 'MAT6'.
*   Enable Mark for Deletion in Conditions tab:
    REFRESH lt_property.
    CLEAR ls_properties.
    ls_properties-node_field = 'LOEVM_KO'.
    ls_properties-option = '1'.
    APPEND ls_properties TO lt_property.

*   Make other fields Read-Only:
    CLEAR ls_properties.
    ls_properties-node_field = 'DATAB'.
    ls_properties-option = '3'.
    APPEND ls_properties TO lt_property.
    CLEAR : ls_properties.

    ls_properties-node_field = 'DATBI'.
    ls_properties-option = '3'.
    APPEND ls_properties TO lt_property.
    CLEAR : ls_properties.

    ls_properties-node_field = 'LIFNR'.
    ls_properties-option = '3'.
    APPEND ls_properties TO lt_property.
    CLEAR : ls_properties.

    ls_properties-node_field = 'EKORG'.
    ls_properties-option = '3'.
    APPEND ls_properties TO lt_property.
    CLEAR : ls_properties.

    ls_properties-node_field = 'ESOKZ'.
    ls_properties-option = '3'.
    APPEND ls_properties TO lt_property.
    CLEAR : ls_properties.

    ls_properties-node_field = 'KONWA'.
    ls_properties-option = '3'.
    APPEND ls_properties TO lt_property.
    CLEAR : ls_properties.

    ls_properties-node_field = 'WERKS'.
    ls_properties-option = '3'.
    APPEND ls_properties TO lt_property.
    CLEAR : ls_properties.

    ls_properties-node_field = 'KPEIN_C'.
    ls_properties-option = '3'.
    APPEND ls_properties TO lt_property.
    CLEAR : ls_properties.

    ls_properties-node_field = 'KMEIN_C'.
    ls_properties-option = '3'.
    APPEND ls_properties TO lt_property.
    CLEAR : ls_properties.

    ls_properties-node_field = 'MWSK1_C'.
    ls_properties-option = '3'.
    APPEND ls_properties TO lt_property.
    CLEAR : ls_properties.

    ls_properties-node_field = 'KZBZG'.
    ls_properties-option = '3'.
    APPEND ls_properties TO lt_property.
    CLEAR : ls_properties.

    ls_properties-node_field = 'KRECH'.
    ls_properties-option = '3'.
    APPEND ls_properties TO lt_property.
    CLEAR : ls_properties.

    ls_properties-node_field = 'KBETR_C'.
    ls_properties-option = '3'.
    APPEND ls_properties TO lt_property.
    CLEAR : ls_properties.

    ls_properties-node_field = 'KZNEP_C'.
    ls_properties-option = '3'.
    APPEND ls_properties TO lt_property.
    CLEAR : ls_properties.

    ls_properties-node_field = 'ZTERM'.
    ls_properties-option = '3'.
    APPEND ls_properties TO lt_property.
    CLEAR : ls_properties.

    ls_properties-node_field = 'VALDT'.
    ls_properties-option = '3'.
    APPEND ls_properties TO lt_property.
    CLEAR : ls_properties.

    ls_properties-node_field = 'VALTG'.
    ls_properties-option = '3'.
    APPEND ls_properties TO lt_property.
    CLEAR : ls_properties.

    REFRESH: lt_row.
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
  ENDIF.
* << Inc 8000019952
  mo_context->get_selection( IMPORTING et_selection = lt_row ).
  READ TABLE lt_row INTO ls_row INDEX 1.
  IF sy-subrc IS INITIAL.
    READ TABLE ct_action_usage ASSIGNING FIELD-SYMBOL(<fs_action_use>) WITH KEY id = 'FRW_DELETE'.
    IF <fs_action_use> IS ASSIGNED.
      ASSIGN COMPONENT 'ENABLED' OF STRUCTURE <fs_action_use> TO FIELD-SYMBOL(<fs_enable>).
      IF <fs_enable> IS ASSIGNED.
        <fs_enable> = abap_true.
      ENDIF.
    ENDIF.
  ENDIF.

  IF lv_process EQ 'MAT1' OR lv_process EQ 'MAT6'.
    LOOP AT ct_action_usage ASSIGNING <fs_action_usage>.
      <fs_action_usage>-enabled = abap_false.
    ENDLOOP.
  ENDIF.

  endmethod.


  method /PLMU/IF_FRW_G_BEFORE_FLUSH~BEFORE_FLUSH.
*CALL METHOD SUPER->/PLMU/IF_FRW_G_BEFORE_FLUSH~BEFORE_FLUSH
*  CHANGING
*    CT_CHANGE_LOG =
*    .

CALL METHOD SUPER->/PLMU/IF_FRW_G_BEFORE_FLUSH~BEFORE_FLUSH
  CHANGING
    CT_CHANGE_LOG = ct_change_log.

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


  method /PLMU/IF_FRW_G_CONFIG_PARAM~SET_PARAMETER_VALUES.
*CALL METHOD SUPER->/PLMU/IF_FRW_G_CONFIG_PARAM~SET_PARAMETER_VALUES
*  EXPORTING
*    IT_PARAMETER_VALUE =
*    .

    CALL METHOD super->/plmu/if_frw_g_config_param~set_parameter_values
      EXPORTING
        it_parameter_value = it_parameter_value.

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
ENDCLASS.
