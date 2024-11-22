class YB_CLAS_MDG_YB_FORM_FEEDER definition
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

  methods PROCESS_EVENT
    redefinition .
private section.
ENDCLASS.



CLASS YB_CLAS_MDG_YB_FORM_FEEDER IMPLEMENTATION.


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

    " Hiding the Create and Delete button in UI while CR is processing
    ASSIGN ct_action_usage TO FIELD-SYMBOL(<lt_action_usage>).
    IF <lt_action_usage> IS ASSIGNED AND <lt_action_usage> IS NOT INITIAL.
      LOOP AT <lt_action_usage> ASSIGNING FIELD-SYMBOL(<ls_action_usage>).
        IF <ls_action_usage>-id = '_CREA_' OR <ls_action_usage>-id = '_DELE_'.
*          <ls_action_usage>-enabled = abap_false. "Disabled
          <ls_action_usage>-visible = '01'. " hiding
        ENDIF.
        IF <ls_action_usage>-id = 'NEWBANK'.
          <ls_action_usage>-visible = '01'. " hiding
        ENDIF.
      ENDLOOP.
    ENDIF.

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
    DATA ls_act_def LIKE LINE OF et_action_definition.

    ls_act_def-enabled = 'X'.
    ls_act_def-id = 'NEWBANK'.
    ls_act_def-text = 'Link to New Bank'.
    ls_act_def-visible = cl_wd_uielement=>e_visible-none.
    APPEND ls_act_def TO et_action_definition.

  ENDMETHOD.


  METHOD process_event.
    CALL METHOD super->process_event
      EXPORTING
        io_event            = io_event
        iv_raised_by_own_ui = iv_raised_by_own_ui
      RECEIVING
        rv_result           = rv_result.
*-------------------------------------------------------------------------------------
    CASE io_event->mv_event_id.
      WHEN 'NEWBANK'.
*        DATA:  lo_crequest_api TYPE REF TO if_usmd_crequest_api.
*        DATA:  lt_message  TYPE usmd_t_message.
*        " Get instance of CR API
*        CALL METHOD cl_usmd_crequest_api=>get_instance
**          EXPORTING
**            iv_crequest          =
**            iv_model_name        =   'BP'               " Data Model
*          IMPORTING
*            et_message           = lt_message
*            re_inst_crequest_api = lo_crequest_api.
*        IF lt_message[] IS NOT INITIAL.
**          et_message[] = lt_message[].
*          RETURN.
*        ENDIF.
*
**        CALL METHOD lo_crequest_api->create_crequest
**          EXPORTING
***           iv_edition       =
**            iv_crequest_type = 'YBBNK01'
**            iv_crequest_text = 'Anand'
**          IMPORTING
**            ev_crequest_id   = DATA(lt_id)               " Natural number
***           et_message       =                  " Messages
**          .
*
*        "save the newly created CR
*        CALL METHOD lo_crequest_api->save_crequest
*          EXPORTING
*            if_commit  = space
*          IMPORTING
*            et_message = lt_message.
*        IF lt_message[] IS NOT INITIAL.
**        et_message[] = lt_message[].
*          RETURN.
*        ENDIF.
*        --------------Anand PoC for Henkel-----------------
        DATA:
          lo_gov_api     TYPE REF TO if_usmd_gov_api,
          lv_crequest_id TYPE usmd_crequest, " Change Request ID

          lr_bp_key_str  TYPE REF TO data,
          lr_bp_key_tab  TYPE REF TO data,
          lr_bp_data_str TYPE REF TO data,
          lr_bp_data_tab TYPE REF TO data,

          ls_entity      TYPE usmd_gov_api_s_ent_tabl,
          lt_entity      TYPE usmd_gov_api_ts_ent_tabl,

          lt_message     TYPE usmd_t_message.

        FIELD-SYMBOLS:
          <ls_bp_key>  TYPE any,
          <lt_bp_key>  TYPE ANY TABLE,
          <ls_bp_data> TYPE any,
          <lt_bp_data> TYPE ANY TABLE,
          <value>      TYPE any.

        " Create Instance of the governance API
        TRY .
            lo_gov_api = cl_usmd_gov_api=>get_instance( iv_model_name = 'BP' ).
          CATCH cx_usmd_gov_api. " General Processing Error GOV_API
            EXIT.
        ENDTRY.

*        "Create a Data Reference of the Key structure/ table of entity BP_HEADER
        lo_gov_api->create_data_reference(
          EXPORTING
            iv_entity_name = 'BP_HEADER'                 " Entity Type
            iv_struct      = lo_gov_api->gc_struct_key    " Type of Data Structure
          IMPORTING
            er_structure   = lr_bp_key_str                 " Structure
            er_table       = lr_bp_key_tab                 " Sorted Table (Unique key)
        ).

        "Create a Data Reference of the Key structure/ table of entity BP_HEADER

        lo_gov_api->create_data_reference(
          EXPORTING
            iv_entity_name = 'BP_HEADER'                 " Entity Type
            iv_struct      = lo_gov_api->gc_struct_key_attr    " Type of Data Structure
          IMPORTING
            er_structure   = lr_bp_data_str                  " Structure
            er_table       = lr_bp_data_tab                 " Sorted Table (Unique key)
        ).

        "assign the created data reference for bp key and bp data to field symbol

        ASSIGN lr_bp_key_str->* TO <ls_bp_key>.
        ASSIGN lr_bp_key_tab->* TO <lt_bp_key>.

        ASSIGN lr_bp_data_str->* TO <ls_bp_data>.
        ASSIGN lr_bp_data_tab->* TO <lt_bp_data>.

        ASSIGN COMPONENT 'BP_HEADER' OF STRUCTURE <ls_bp_key> TO <value>.
        IF sy-subrc = 0.
          <value> = '123456'.
          INSERT <ls_bp_key> INTO TABLE <lt_bp_key>.
        ELSE.
          EXIT.
        ENDIF.
*        ASSIGN COMPONENT 'Y_BANKS' OF STRUCTURE <ls_bp_key> TO <value>.
*        IF sy-subrc = 0.
*          <value> = 'IN'.
*          INSERT <ls_bp_key> INTO TABLE <lt_bp_key>.
*        ELSE.
*          EXIT.
*        ENDIF.

        "Create new CR
        TRY .
            lv_crequest_id = lo_gov_api->create_crequest(
              EXPORTING
                iv_crequest_type = 'BP1P1'                 " Type of Change Request
                iv_description   = 'Test Anand Henkel poC'                " Description (long text)
*               iv_edition       =                  " Edition
*            RECEIVING
*               rv_crequest_id   =                  " Change Request
            ).
*          CATCH cx_usmd_gov_api_core_error. " CX_USMD_CORE_DYNAMIC_CHECK
          CATCH cx_usmd_gov_api.            " General Processing Error GOV_API

        ENDTRY.

*        "Enque the entity
        TRY .
            lo_gov_api->enqueue_entity(
              EXPORTING
                iv_crequest_id = lv_crequest_id                " Change Request
                iv_entity_name = 'BP_HEADER'                 " Entity Type of Storage and Use Type 1
                it_data        = <lt_bp_key>                " Must Contain Entity Key
*               iv_lock_mode   = 'E'              " Block Mode
*               iv_scope       = '1'              " Block Behavior
*            IMPORTING
*               et_locked      =                  " Blocked Entities
            ).
*          CATCH               cx_usmd_gov_api_core_error.  " CX_USMD_CORE_DYNAMIC_CHECK
          CATCH  cx_usmd_gov_api_entity_lock cx_usmd_gov_api. " RESUMABLE Error While Blocking an Entity
            EXIT.
        ENDTRY.

        "Provide some entity attributes
*        MOVE-CORRESPONDING <ls_bp_key> to <ls_bp_data>.
*
*        ASSIGN COMPONENT 'BU_GROUP' OF STRUCTURE <ls_bp_data> to <value>.
*        <value> = '0003'.
*        INSERT <ls_bp_data> INTO TABLE <lt_bp_data>.
*
*        "Write the entity data to the CR
*        TRY .
*          lo_gov_api->write_entity(
*            EXPORTING
*              iv_crequest_id = lv_crequest_id                 " Change Request
*              iv_entity_name = 'BP_HEADER'                 " Entity Type
*              it_data        = <lt_bp_data>                 " Entity Keys and Attributes
**              it_attribute   =                  " List of Field Names with Changed Data
*          ).
**          CATCH               cx_usmd_gov_api_core_error.   " CX_USMD_CORE_DYNAMIC_CHECK
*          CATCH  cx_usmd_gov_api_entity_write. " RESUMABLE Error While Writing an Entity
*            EXIT.
**          CATCH               cx_usmd_gov_api.              " General Processing Error GOV_API
*        ENDTRY.

        "Optionally: Read the entity again to make sure every thing is correct
*        TRY .
*          lo_gov_api->read_entity(
*            EXPORTING
*              iv_crequest_id   =  lv_crequest_id                " Change Request
*              iv_entity_name   =  'BP_HEADER'                 " Entity Type
*              it_key           =  <lt_bp_key>                " Entity Key of Storage and Use Type 1
**              iv_edition       =                  " Edition
**              if_edition_logic = ' '              " obsolete: Use Edition Logic (Indicator)
**              if_active_data   = ' '              " Read Active Data Only (Indicator)
*            IMPORTING
*              et_data          = <lt_bp_data>                 " Entity Keys and Attributes
*          ).
*          CATCH  cx_usmd_gov_api_core_error cx_usmd_gov_api. " CX_USMD_CORE_DYNAMIC_CHEC
*              EXIT.
*        ENDTRY.

        "Check the complete Change request before it is saved
*        TRY .
*          lo_gov_api->check_crequest_data( iv_crequest_id = lv_crequest_id ).
*          "Collect the entities to be checked
*          ls_entity-entity = 'BP_HEADER'.
*          ls_entity-tabl   = lr_bp_key_tab.
*          INSERT ls_entity INTO TABLE lt_entity.
*          "Check the entity
*          lo_gov_api->check_complete_data(
*            EXPORTING
*              iv_crequest_id     =  lv_crequest_id                " Change Request
*              it_key             =  lt_entity                " Keys of Type-1 ETs to Be Checked
*          ).
*          CATCH cx_usmd_gov_api_core_error. " CX_USMD_CORE_DYNAMIC_CHECK

*        ENDTRY.

        "Save the new CR
        TRY .
            lo_gov_api->save(
*              i_mode = if_usmd_ui_services=>gc_save_mode_draft
            ).
          CATCH cx_usmd_gov_api_core_error. " CX_USMD_CORE_DYNAMIC_CHECK
            EXIT.
        ENDTRY.

*        "Deque the entity
        TRY .
            lo_gov_api->dequeue_entity(
              EXPORTING
                iv_crequest_id = lv_crequest_id                 " Change Request
                iv_entity_name = 'BP_HEADER'                 " Entity
                it_data        = <lt_bp_key>                 " Must Contain Entity Key
            ).
          CATCH cx_usmd_gov_api. " General Processing Error GOV_API

        ENDTRY.
*        COMMIT WORK AND WAIT.

*        Start the workflow
*        TRY .
*            lo_gov_api->start_workflow( iv_crequest_id = lv_crequest_id ).
*          CATCH cx_usmd_gov_api_core_error. " CX_USMD_CORE_DYNAMIC_CHECK
*        ENDTRY.

*        ----------------------------------------------------
    ENDCASE.
  ENDMETHOD.
ENDCLASS.
