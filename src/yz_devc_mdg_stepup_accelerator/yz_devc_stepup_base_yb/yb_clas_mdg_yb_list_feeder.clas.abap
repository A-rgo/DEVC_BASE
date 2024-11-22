class YB_CLAS_MDG_YB_LIST_FEEDER definition
  public
  inheriting from CL_BS_BP_GUIBB_LIST
  final
  create public .

public section.

  methods IF_FPM_GUIBB_LIST~GET_DATA
    redefinition .
  methods IF_FPM_GUIBB~INITIALIZE
    redefinition .
  methods IF_FPM_GUIBB_LIST~GET_DEFINITION
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS YB_CLAS_MDG_YB_LIST_FEEDER IMPLEMENTATION.


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
        ev_selected_lines_changed = ev_selected_lines_changed
        ev_dnd_attr_changed       = ev_dnd_attr_changed
        eo_itab_change_log        = eo_itab_change_log
      CHANGING
        ct_data                   = ct_data
        ct_field_usage            = ct_field_usage
        ct_action_usage           = ct_action_usage
        ct_selected_lines         = ct_selected_lines
        cv_lead_index             = cv_lead_index
        cv_first_visible_row      = cv_first_visible_row
        cs_additional_info        = cs_additional_info
        ct_dnd_attributes         = ct_dnd_attributes.

    " Hiding the Create and Delete button in UI while CR is processing
    ASSIGN ct_action_usage TO FIELD-SYMBOL(<lt_action_usage>).
    IF <lt_action_usage> IS ASSIGNED AND <lt_action_usage> IS NOT INITIAL.
      LOOP AT <lt_action_usage> ASSIGNING FIELD-SYMBOL(<ls_action_usage>).
        IF <ls_action_usage>-id = 'CREATE_ROOT' OR <ls_action_usage>-id = '_DELE_' OR <ls_action_usage>-id = 'BOL_COPY'.
*          <ls_action_usage>-enabled = abap_false. "Disabled
          <ls_action_usage>-visible = '01'. " hiding
        ENDIF.
      ENDLOOP.
    ENDIF.

*    ASSIGN ct_data TO FIELD-SYMBOL(<lt_data>).
*    IF <lt_data> is ASSIGNED and <lt_data> is NOT INITIAL.
*      READ TABLE ct_action_usage ASSIGNING FIELD-SYMBOL(<lt_action>) WITH  KEY id = '_CREA_'.
*      IF sy-subrc = 0.
*        LOOP AT <lt_data> ASSIGNING FIELD-SYMBOL(<ls_data>).
*          ASSIGN COMPONENT 'Y_ADDRNO' OF STRUCTURE <ls_data> to FIELD-SYMBOL(<lfs_yaddrno>).
*          IF <lfs_yaddrno> is ASSIGNED and <lfs_yaddrno> is INITIAL.
*            <lfs_yaddrno> = 'INTERNAL'.
*          ENDIF.
*        ENDLOOP.
*      ENDIF.
*    ENDIF.

    DATA l_table    TYPE REF TO data.
    DATA lv_lines TYPE c.
    DATA : lv_temp TYPE c LENGTH 10.
    DATA : lo_bol_ref TYPE REF TO cl_crm_bol_entity.

    FIELD-SYMBOLS: <fs_t_data> TYPE STANDARD TABLE,
                   <fs_o_ref>  TYPE any,
                   <fs_s_data> TYPE any.

    CREATE DATA l_table LIKE   ct_data.
    ASSIGN l_table->* TO <fs_t_data>.
    IF <fs_t_data> IS ASSIGNED.
      <fs_t_data> = ct_data.
      DESCRIBE TABLE <fs_t_data> LINES lv_lines.
      READ TABLE <fs_t_data> INDEX lv_lines ASSIGNING <fs_s_data>.

      ASSIGN COMPONENT 'FPM_KEY_BY_BOL_ENTITY' OF STRUCTURE <fs_s_data> TO <fs_o_ref>.
      IF <fs_o_ref> IS ASSIGNED AND <fs_o_ref> IS NOT INITIAL.
        lo_bol_ref = <fs_o_ref>.

        CONCATENATE '$INTERNAL' lv_lines INTO lv_temp.
        CALL METHOD lo_bol_ref->if_bol_bo_property_access~set_property
          EXPORTING
            iv_attr_name = 'Y_ADDRNO'
            iv_value     = lv_temp.
      ENDIF.

*------------------Hiding the New Button if row is already created for Address List UIBB ----
* if sy-uname = 'NACA'.



      IF <fs_t_data> IS ASSIGNED AND <fs_t_data> IS NOT INITIAL.
        ASSIGN ct_action_usage TO FIELD-SYMBOL(<lf_action_usage>).
        LOOP AT <lf_action_usage> ASSIGNING FIELD-SYMBOL(<lg_action_usage>).
          IF <lg_action_usage>-id = '_CREA_'.
            <lg_action_usage>-visible = '01'.
          ENDIF.
        ENDLOOP.
      ELSE.
        IF <fs_t_data> IS ASSIGNED AND <fs_t_data> IS INITIAL.
          ASSIGN ct_action_usage TO FIELD-SYMBOL(<lm_action_usage>).
          LOOP AT <lm_action_usage> ASSIGNING FIELD-SYMBOL(<ln_action_usage>).
            IF <ln_action_usage>-id = '_CREA_'.
              <ln_action_usage>-visible = '02'.
            ENDIF.
          ENDLOOP.
        ENDIF.
      ENDIF.



*   ----------------Restricting COPY Functionality -----------"By Anand
*      IF sy-uname = 'ASWARUP'.
*        DATA cloner TYPE REF TO if_bs_bol_entity_cloner.
*        cloner = cl_bs_bol_entity_cloner=>get_instance( 'ZSP_YB' ).
*
*        DATA : standard_pattern TYPE REF TO if_bs_bol_entity_clone_pattern.
*        standard_pattern = cloner->pattern( ).
*
**        DATA complete_pattern TYPE REF TO if_bs_bol_entity_clone_pattern.
**        complete_pattern = cloner->pattern( 'Complete' ).
*
*      standard_pattern->refuse_entity( 'Y_ADDRESS' ).
**       standard_pattern->elide_attributes(
**         EXPORTING
**           iv_entity_name         = 'Y_ADDRESS'
**           iv_names_of_attributes =  'Y_ADDRNO'
***           iv_names_separator     = ','
**       ).
*
*      ENDIF.
*   -----------------------------------------------------------

    ENDIF.

  ENDMETHOD.


  METHOD if_fpm_guibb~initialize.
    CALL METHOD super->if_fpm_guibb~initialize
      EXPORTING
        it_parameter      = it_parameter
        io_app_parameter  = io_app_parameter
        iv_component_name = iv_component_name
        is_config_key     = is_config_key
        iv_instance_id    = iv_instance_id.

*   ----------------Restricting COPY Functionality -----------"By Anand
    IF sy-uname = 'ASWARUP'.
      DATA cloner TYPE REF TO if_bs_bol_entity_cloner.
      cloner = cl_bs_bol_entity_cloner=>get_instance( 'ZSP_YB' ).

      DATA : standard_pattern TYPE REF TO if_bs_bol_entity_clone_pattern.
      standard_pattern = cloner->pattern( ).

      standard_pattern->refuse_entity( 'Y_ADDRESS' ).
**       standard_pattern->elide_attributes(
**         EXPORTING
**           iv_entity_name         = 'Y_ADDRESS'
**           iv_names_of_attributes =  'Y_ADDRNO'
***           iv_names_separator     = ','
**       ).

*
    ENDIF.
*   -----------------------------------------------------------
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
        es_options               = es_options .
  ENDMETHOD.
ENDCLASS.
