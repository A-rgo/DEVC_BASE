class ZCL_MDG_ZR_LIST definition
  public
  inheriting from CL_MDG_BS_GUIBB_LIST
  final
  create public .

public section.

  data GT_SEARCH_CRITERIA type FPMGB_T_SEARCH_CRITERIA .

  methods IF_FPM_GUIBB_LIST~GET_DATA
    redefinition .
  methods IF_FPM_GUIBB_LIST~GET_DEFINITION
    redefinition .
  methods IF_FPM_GUIBB_OVS~HANDLE_PHASE_2
    redefinition .
  methods IF_FPM_GUIBB_OVS~HANDLE_PHASE_3
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCL_MDG_ZR_LIST IMPLEMENTATION.


  METHOD if_fpm_guibb_list~get_data.

    CALL METHOD super->if_fpm_guibb_list~get_data
      EXPORTING
        iv_eventid                = iv_eventid
        it_selected_fields        = it_selected_fields
        iv_raised_by_own_ui       = iv_raised_by_own_ui
        iv_visible_rows           = iv_visible_rows
        iv_edit_mode              = iv_edit_mode
        io_extended_ctrl          = io_extended_ctrl
      IMPORTING
        et_messages               = et_messages
        ev_data_changed           = ev_data_changed
        ev_field_usage_changed    = ev_field_usage_changed
        ev_action_usage_changed   = ev_action_usage_changed
        ev_selected_lines_changed = ev_action_usage_changed
        ev_dnd_attr_changed       = ev_dnd_attr_changed
        eo_itab_change_log        = eo_itab_change_log
      CHANGING
        ct_data                   = ct_data
        ct_field_usage            = ct_field_usage
        ct_action_usage           = ct_action_usage
        ct_selected_lines         = ct_selected_lines
        cv_lead_index             = cv_lead_index
        cv_first_visible_row      = cv_lead_index
        cs_additional_info        = cs_additional_info
        ct_dnd_attributes         = ct_dnd_attributes.

    LOOP AT ct_data ASSIGNING FIELD-SYMBOL(<fs_data>).
      ASSIGN COMPONENT 'ZFIELD' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_datab>).
      ASSIGN COMPONENT 'ZFLD_VAL' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_fvalue>).
      IF <fs_datab> IS ASSIGNED.
        DATA: eo_field_catalog TYPE REF TO cl_abap_tabledescr.
        DATA: lt_dfies TYPE TABLE OF dfies.

        TRY.
            CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
              EXPORTING
                ddic_structure  = 'MARA'
                retfield        = 'MATERIAL'
                dynpprog        = 'ZCL_MDG_ZR_LIST===============CP'
                dynpnr          = '0010'
                dynprofield     = 'MATERIAL'
              TABLES
*               value_tab       =
                field_tab       = lt_dfies
*               RETURN_TAB      =
*               DYNPFLD_MAPPING =
              EXCEPTIONS
                parameter_error = 1
                no_values_found = 2
                OTHERS          = 3.
          CATCH cx_root.
        ENDTRY.

*        CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
*          EXPORTING
*           DDIC_STRUCTURE         = ''
*            retfield               =
*           PVALKEY                = ' '
*           DYNPPROG               = ''
*           DYNPNR                 = ' '
**           DYNPROFIELD            = ' '
**           STEPL                  = 0
**           WINDOW_TITLE           =
**           VALUE                  = ' '
**           VALUE_ORG              = 'C'
**           MULTIPLE_CHOICE        = ' '
**           DISPLAY                = ' '
**           CALLBACK_PROGRAM       = ' '
**           CALLBACK_FORM          = ' '
**           CALLBACK_METHOD        =
**           MARK_TAB               =
**         IMPORTING
**           USER_RESET             =
*          tables
*            value_tab              =
**           FIELD_TAB              =
**           RETURN_TAB             =
**           DYNPFLD_MAPPING        =
**         EXCEPTIONS
**           PARAMETER_ERROR        = 1
**           NO_VALUES_FOUND        = 2
**           OTHERS                 = 3
*                  .
*        IF sy-subrc <> 0.
** Implement suitable error handling here
*        ENDIF.


*        eo_field_catalog = CL_ABAP_STRUCTDESCR=>describe_by_name( p_name = <fs_datab> ).



      ENDIF.
    ENDLOOP.



  ENDMETHOD.


  METHOD if_fpm_guibb_list~get_definition.

    CALL METHOD super->if_fpm_guibb_list~get_definition
      IMPORTING
        eo_field_catalog         = eo_field_catalog
        et_field_description     = et_field_description
        et_action_definition     = et_action_definition
        et_special_groups        = et_special_groups
        es_message               = es_message
        ev_additional_error_info = ev_additional_error_info
        et_dnd_definition        = et_dnd_definition
        et_row_actions           = et_row_actions
        es_options               = es_options.
  ENDMETHOD.


  method IF_FPM_GUIBB_OVS~HANDLE_PHASE_2.
*CALL METHOD SUPER->IF_FPM_GUIBB_OVS~HANDLE_PHASE_2
*  EXPORTING
*    IV_FIELD_NAME   =
*    IO_OVS_CALLBACK =
**    iv_index        =
*    .
    DATA : BEGIN OF ls_struc,
           KAPPL TYPE A399-kappl,
           KNUMH TYPE A399-knumh,
           END OF ls_struc,
           lt_struc LIKE TABLE OF ls_struc,
           lt_KAPPL TYPE TABLE of A399-kappl.

    CASE IV_FIELD_NAME.
      WHEN 'KNUMH'.
        IF gt_search_criteria is NOT INITIAL.
          LOOP AT gt_search_criteria ASSIGNING FIELD-SYMBOL(<fs_search_criteria>).
             CASE <fs_search_criteria>-search_attribute.
             	WHEN 'KAPPL'.
                 APPEND INITIAL LINE TO lt_kappl ASSIGNING FIELD-SYMBOL(<fs_kappl>).
                 <fs_kappl> = <fs_search_criteria>-low.
*               WHEN .
             	WHEN OTHERS.
             ENDCASE.
          ENDLOOP.
          select kappl knumh from a399 into TABLE lt_struc for ALL ENTRIES IN lt_kappl WHERE kappl = lt_KAPPL-table_line.
         ELSE.
            select kappl knumh from a399 INTO TABLE lt_struc.
        ENDIF.
        IO_OVS_CALLBACK->set_output_table( exporting output = lt_struc ).
*      WHEN .
      WHEN OTHERS.
    ENDCASE.


  endmethod.


  method if_fpm_guibb_ovs~handle_phase_3.
*CALL METHOD SUPER->IF_FPM_GUIBB_OVS~HANDLE_PHASE_3
*  EXPORTING
*    IV_FIELD_NAME           =
*    IO_OVS_CALLBACK         =
**    iv_wd_context_attr_name =
**  importing
**    eo_fpm_event            =
*    .
    data : begin of ls_struc,
             kappl type a399-kappl,
             knumh type a399-knumh,
           end of ls_struc.
    field-symbols : <fs_struc> like ls_struc.
    case iv_field_name.
      when 'KNUMH'.
        check io_ovs_callback->selection is bound.
        assign io_ovs_callback->selection->* to <fs_struc>.
        io_ovs_callback->context_element->set_attribute(
         exporting
           value = <fs_struc>-knumh
           name = iv_wd_context_attr_name ).
*	WHEN .
      when others.
    endcase.

  endmethod.
ENDCLASS.
