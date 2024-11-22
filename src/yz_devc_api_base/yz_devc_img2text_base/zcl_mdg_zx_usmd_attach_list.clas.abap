class ZCL_MDG_ZX_USMD_ATTACH_LIST definition
  public
  inheriting from CL_MDG_BS_GUIBB_LIST
  create public .

public section.

  constants CV_EVENT_ID_LINK_ADD type FPM_EVENT_ID value 'ATT_LINK_ADD' ##NO_TEXT.
  constants CV_EVENT_ID_FILE_ADD type FPM_EVENT_ID value 'ATT_FILE_ADD' ##NO_TEXT.
  constants CV_EVENT_ID_ATT_EDIT type FPM_EVENT_ID value 'ATT_EDIT' ##NO_TEXT.
  constants CV_EVENT_ID_ATT_LINK_CREATE type FPM_EVENT_ID value 'ATT_LINK_CREATE' ##NO_TEXT.
  constants CV_EVENT_ID_ATT_FILE_CREATE type FPM_EVENT_ID value 'ATT_FILE_CREATE' ##NO_TEXT.
  constants CV_EVENT_ID_ATT_FILE_EDIT type FPM_EVENT_ID value 'ATT_FILE_EDIT' ##NO_TEXT.
  constants CV_EVENT_ID_ATT_LINK_EDIT type FPM_EVENT_ID value 'ATT_LINK_EDIT' ##NO_TEXT.
  constants CV_EVENT_ID_SHOW_ATT type FPM_EVENT_ID value 'ATT_SHOW' ##NO_TEXT.
  constants CV_EVENT_ID_ATT_DEL type FPM_EVENT_ID value 'ATT_DELETE' ##NO_TEXT.
  data MO_WORK type ref to IF_DO_WORK .
  data GT_ZATTACHMENT type ref to ZATTACHMENT .

  methods IF_FPM_GUIBB_LIST~GET_DATA
    redefinition .
  methods IF_FPM_GUIBB_LIST~GET_DEFINITION
    redefinition .
  methods IF_FPM_GUIBB_LIST~PROCESS_EVENT
    redefinition .
protected section.

  methods ADD_STANDARD_ROW_ACTIONS
    redefinition .
  methods CHECK_ACTION_USAGE
    redefinition .
  methods CHECK_ACTION_USAGE_SINGLE
    redefinition .
  methods CREATE_STRUCT_RTTI
    redefinition .
  methods GET_ACTIONS
    redefinition .
  methods GET_ENTITY_DATA
    redefinition .
  methods HANDLE_EDIT_ENTRANCE
    redefinition .
  methods IS_ROW_ACTION_ENABLED
    redefinition .
  methods PROCESS_LIST_CELL_ACTION
    redefinition .
private section.

  methods ADD_FILE_ATTACHMENT
    importing
      !IO_EVENT type ref to CL_FPM_EVENT
    exporting
      !EV_RESULT type FPM_EVENT_RESULT
      !ET_MESSAGES type FPMGB_T_MESSAGES .
  methods ADD_LINK_ATTACHMENT
    importing
      !IO_EVENT type ref to CL_FPM_EVENT
    exporting
      !EV_RESULT type FPM_EVENT_RESULT
      !ET_MESSAGES type FPMGB_T_MESSAGES .
ENDCLASS.



CLASS ZCL_MDG_ZX_USMD_ATTACH_LIST IMPLEMENTATION.


METHOD ADD_FILE_ATTACHMENT.
*! The method triggers the pop-up for a new attachment of type file.
*  Dialog Box properties are not changed. Title, width, and so on is
*  defined by the related OVP using the pop-up.
*  Furthermore it is allowed for applications to define the dialog box
*  ID as part of the event parameters (required for MDG-F!).
  DATA:
    lo_connector     TYPE REF TO cl_mdg_bs_connector_bol_rel,
    lo_parent_entity TYPE REF TO cl_crm_bol_entity,
    lv_dialog_box_id TYPE fpm_dialog_window_id,
    lv_key TYPE string,
    lo_event TYPE REF TO cl_fpm_event.

  ev_result = if_fpm_constants=>gc_event_result-failed.
  IF me->mo_connector IS NOT BOUND
    OR me->mo_fpm_toolbox IS NOT BOUND
    OR me->mo_fpm_toolbox->mo_fpm IS NOT BOUND.
    RETURN.
  ENDIF.

  "add parent to event parameter
  lo_connector ?= me->mo_connector.
  lo_parent_entity = lo_connector->get_parent( ).
  io_event->mo_event_data->set_value(
    EXPORTING
      iv_key   = cl_usmd_cr_att_file_bol_feeder=>cv_att_mode
      iv_value = lo_parent_entity ).

  "pass 'create' event to file attachment feeder for undo function
  lv_key = cv_event_id_file_add.
  io_event->mo_event_data->set_value(
        EXPORTING
          iv_key   = lv_key
          iv_value = io_event ).

  "determine dialog box ID
  io_event->mo_event_data->get_value(
    EXPORTING
      iv_key   = if_fpm_constants=>gc_dialog_box-id
    IMPORTING
      ev_value = lv_dialog_box_id ).
  IF lv_dialog_box_id IS INITIAL.
    "use the default
    lv_dialog_box_id = if_usmd_generic_bolui_const=>gc_popup_att_file.
  ENDIF.


  "trigger the dialog box for creating/editing attachments of type file
  me->mo_fpm_toolbox->mo_fpm->open_dialog_box(
    EXPORTING
      iv_dialog_box_id = lv_dialog_box_id
      io_event_data    = io_event->mo_event_data ).

  ev_result = if_fpm_constants=>gc_event_result-ok.
  et_messages = get_messages( ) .
ENDMETHOD.


METHOD ADD_LINK_ATTACHMENT.
*! The method triggers the pop-up for a new attachment of type file.
*  Dialog Box properties are not changed. Title, width, and so on is
*  defined by the related OVP using the pop-up.
*  Furthermore it is allowed for applications to define the dialog box
*  ID as part of the event parameters (required for MDG-F!).
  DATA:
    lo_connector     TYPE REF TO cl_mdg_bs_connector_bol_rel,
    lo_parent_entity TYPE REF TO cl_crm_bol_entity,
    lv_dialog_box_id TYPE fpm_dialog_window_id,
    lv_key TYPE string,
    lo_event TYPE REF TO cl_fpm_event.



  ev_result = if_fpm_constants=>gc_event_result-failed.
  IF me->mo_connector IS NOT BOUND
    OR me->mo_fpm_toolbox IS NOT BOUND
    OR me->mo_fpm_toolbox->mo_fpm IS NOT BOUND.
    RETURN.
  ENDIF.

  "add parent to event parameter
  lo_connector ?= me->mo_connector.
  lo_parent_entity = lo_connector->get_parent( ).
  io_event->mo_event_data->set_value(
    EXPORTING
      iv_key   = cl_usmd_cr_att_file_bol_feeder=>cv_att_mode
      iv_value = lo_parent_entity ).

  "pass 'create' event to file attachment feeder for undo function
  lv_key = cv_event_id_link_add.
  io_event->mo_event_data->set_value(
      EXPORTING
        iv_key   = lv_key
        iv_value = io_event ).

  "determine dialog box ID
  io_event->mo_event_data->get_value(
    EXPORTING
      iv_key   = if_fpm_constants=>gc_dialog_box-id
    IMPORTING
      ev_value = lv_dialog_box_id ).
  IF lv_dialog_box_id IS INITIAL.
    "use the default
    lv_dialog_box_id = if_usmd_generic_bolui_const=>gc_popup_att_link.
  ENDIF.

  "trigger the dialog box for creating/editing attachments of type link
  me->mo_fpm_toolbox->mo_fpm->open_dialog_box(
    EXPORTING
      iv_dialog_box_id         = lv_dialog_box_id
      io_event_data            = io_event->mo_event_data ).

  ev_result = if_fpm_constants=>gc_event_result-ok.
  et_messages = get_messages( ) .
ENDMETHOD.


METHOD ADD_STANDARD_ROW_ACTIONS.
  DATA:
    ls_row_action_ref LIKE LINE OF mt_row_action_ref.

  FIELD-SYMBOLS:
    <ls_row_action> LIKE LINE OF me->mt_row_action.

  super->add_standard_row_actions( ).

* Add delete button
  APPEND INITIAL LINE TO me->mt_row_action ASSIGNING <ls_row_action>.
  <ls_row_action>-id               = cv_event_id_att_del.
  <ls_row_action>-is_implicit_edit = abap_true.
  ls_row_action_ref-id             = <ls_row_action>-id.
  INSERT ls_row_action_ref INTO TABLE me->mt_row_action_ref.
* image source is configured in the component configuration / at the bottom (add action assignment)
ENDMETHOD.


METHOD CHECK_ACTION_USAGE.

  DATA: lv_change_allowed TYPE abap_bool. "Allowed when CR-UIBB is displayed and CR belongs to the same user.
* This flag is independent of current mode (change / display)
  DATA: lo_parent_entity  TYPE REF TO cl_crm_bol_entity,
        lo_connector      TYPE REF TO cl_mdg_bs_connector_bol_rel.
  DATA  lv_editable       TYPE c LENGTH 1.
  FIELD-SYMBOLS <fs_actionusage> TYPE fpmgb_s_actionusage.
  lv_editable = me->is_mode_read_only( ) .

  super->check_action_usage( CHANGING ct_action_usage = ct_action_usage ).
  CHECK: me->mv_check_mutability = abap_true,
         me->mo_connector IS BOUND.

  IF me->mv_edit_mode = abap_true. "UIBB edit flag in configurator
    lo_connector     ?= me->mo_connector.
    lo_parent_entity  = lo_connector->get_parent( ).
    IF lo_parent_entity IS BOUND. "not bound when creating PFLI without entry screen
      lv_change_allowed = lo_parent_entity->is_change_allowed( ).
    ENDIF.
  ELSE.
    lv_change_allowed = abap_false.
  ENDIF.

* The visibility of the EDIT button (event FPM_LOCAL_EDIT) has to be set manually
* because FPM_LOCAL_EDIT is not contained in CT_ACTION_USAGE.
  IF lv_change_allowed = abap_true.
    me->modify_cnr_button(
      iv_event_id = if_fpm_constants=>gc_event-local_edit
      iv_ovp_uibb_toolbar = abap_true
      iv_visibility = if_fpm_constants=>gc_visibility-visible
      iv_enabled = lv_change_allowed ).

    LOOP AT ct_action_usage ASSIGNING <fs_actionusage> WHERE id CP 'ATT_*' .
      <fs_actionusage>-visible = if_fpm_constants=>gc_visibility-visible.
    ENDLOOP.
  ELSE.
    me->modify_cnr_button(
      iv_event_id = if_fpm_constants=>gc_event-local_edit
      iv_ovp_uibb_toolbar = abap_true
      iv_visibility = if_fpm_constants=>gc_visibility-not_visible
      iv_enabled = lv_change_allowed ).
* If there is no EDIT button then also the attachment related buttons have to be invisible
    LOOP AT ct_action_usage ASSIGNING <fs_actionusage> WHERE id CP 'ATT_*' .
      <fs_actionusage>-visible = if_fpm_constants=>gc_visibility-not_visible.
    ENDLOOP.
  ENDIF.
ENDMETHOD.


METHOD CHECK_ACTION_USAGE_SINGLE.
  DATA lo_att_obj TYPE REF TO CL_CRM_BOL_ENTITY.

  CASE cs_action_usage-id.
    WHEN cv_event_id_att_del.
      IF me->is_mode_read_only( ) = abap_true OR
         me->mo_collection IS NOT BOUND.
        cs_action_usage-enabled = abap_false.
        "me->mo_collection->size( ) = 0.
      ELSEIF me->is_mode_read_only( ) = abap_false AND
             me->mo_collection->size( ) = 0.
        cs_action_usage-enabled = abap_false.
      ELSE.
        TRY.
          cs_action_usage-enabled = abap_false.
          LOOP at me->mt_entity_sel INTO lo_att_obj.
            If lo_att_obj is BOUND AND lo_att_obj->alive( ) = abap_true.
              lo_att_obj->execute( iv_method_name = cl_mdg_bs_genil=>gc_method_name-is_entity_deleted ).
            ENDIF.
          ENDLOOP.
         CATCH cx_crm_bol_meth_exec_failed.
          "One Selected obj is not deleted so we enable Delete-Button
          cs_action_usage-enabled = abap_true.
        ENDTRY.
      ENDIF.
    WHEN 'ATT_FILE_ADD' OR 'ATT_LINK_ADD' .
      IF me->is_mode_read_only( ) = abap_true.
        cs_action_usage-enabled = abap_false.
      ELSE.
        cs_action_usage-enabled = me->is_create_enabled( ).
* This logic is the same for FPM_BOL_TABLE_INSERT in the super class. This
* works for the translatable texts but not here since we don't use this event of the list uibb.
      ENDIF.
    WHEN OTHERS.
      IF me->is_mode_read_only( ) = abap_true.
        cs_action_usage-enabled = abap_false.
      ELSE.
        cs_action_usage-enabled = abap_true.
      ENDIF.
  ENDCASE.
  ms_change-action_usage = abap_true.

ENDMETHOD.


METHOD CREATE_STRUCT_RTTI.

  DATA:
      lt_component TYPE cl_abap_structdescr=>component_table.

  FIELD-SYMBOLS:
    <ls_component> LIKE LINE OF lt_component.

  super->create_struct_rtti( ).

  APPEND INITIAL LINE TO lt_component ASSIGNING <ls_component>.
  "<ls_component>-name = cv_comp_bol_data.
  <ls_component>-type = me->mo_struct_rtti.
  <ls_component>-as_include = abap_true.

  APPEND INITIAL LINE TO lt_component ASSIGNING <ls_component>.
  <ls_component>-name = 'CREATEDBY__TEXT'.
  <ls_component>-type = cl_abap_elemdescr=>get_string( ).

  APPEND INITIAL LINE TO lt_component ASSIGNING <ls_component>.
  <ls_component>-name = 'FILE_ICON'.
  <ls_component>-type = cl_abap_elemdescr=>get_string( ).

  APPEND INITIAL LINE TO lt_component ASSIGNING <ls_component>.
  <ls_component>-name = 'FILE_SIZE_DESCR'.
  <ls_component>-type = cl_abap_elemdescr=>get_string( ).

  me->mo_struct_rtti = cl_abap_structdescr=>create( lt_component ).

ENDMETHOD.


METHOD GET_ACTIONS.

  FIELD-SYMBOLS:
    <ls_actiondef> LIKE LINE OF mt_actiondef.


*----- inherit
  super->get_actions( ).

*----- Add link
  APPEND INITIAL LINE TO mt_actiondef ASSIGNING <ls_actiondef>.
  <ls_actiondef>-id = cv_event_id_link_add.
  <ls_actiondef>-text = text-001.
  <ls_actiondef>-enabled = abap_true.
  <ls_actiondef>-exposable = abap_true. "Makes it usable in the OVP (panel) otherwise it is only available in the GUIBB in the panel
  <ls_actiondef>-visible = cl_wd_uielement=>e_visible-visible.

*----- Add file
  APPEND INITIAL LINE TO mt_actiondef ASSIGNING <ls_actiondef>.
  <ls_actiondef>-id = cv_event_id_file_add.
  <ls_actiondef>-text = text-002.
  <ls_actiondef>-enabled = abap_true.
  <ls_actiondef>-exposable = abap_true.
  <ls_actiondef>-visible = cl_wd_uielement=>e_visible-visible.


*------ Delete Attachments
  APPEND INITIAL LINE TO mt_actiondef ASSIGNING <ls_actiondef>.
  <ls_actiondef>-id = cv_event_id_att_del.
  <ls_actiondef>-imagesrc = '~Icon/Delete'.
  <ls_actiondef>-enabled = abap_true.
  <ls_actiondef>-exposable = abap_true.
  <ls_actiondef>-visible = cl_wd_uielement=>e_visible-visible.

ENDMETHOD.


METHOD GET_ENTITY_DATA.
  FIELD-SYMBOLS:
      <lv_data_dest>      TYPE any,
      <lv_usr_create>     TYPE any,
      <lv_data_file_type> TYPE any,
      <lv_data_file_icon> TYPE any,
    <lv_data_file_size> TYPE any,
    <lv_usmd_title>     TYPE any.

  DATA lv_file_size TYPE int4.

  super->get_entity_data(
    EXPORTING io_access = io_access
    CHANGING cs_data = cs_data ).

  CHECK io_access IS BOUND.

  " Fill Field CREATEDBY__TEXT
  ASSIGN COMPONENT 'CREATEDBY__TEXT' OF STRUCTURE cs_data TO <lv_data_dest>.
  ASSIGN COMPONENT 'USMD_ACREATED_BY'      OF STRUCTURE cs_data TO <lv_usr_create>.
  <lv_data_dest> = <lv_usr_create>.
  IF <lv_usr_create> IS NOT INITIAL.
    CALL METHOD cl_usmd_cr_ui_service=>get_user_full_name
      EXPORTING
        iv_username  = <lv_usr_create>
      RECEIVING
        rv_name_text = <lv_data_dest>.

    IF <lv_data_dest> IS INITIAL.
      <lv_data_dest> = <lv_usr_create>.
    ENDIF.
  ENDIF.

  ASSIGN COMPONENT 'USMD_FILE_TYPE' OF STRUCTURE cs_data TO <lv_data_file_type>.
  ASSIGN COMPONENT 'FILE_ICON' OF STRUCTURE cs_data TO <lv_data_file_icon>.
  IF <lv_data_file_type> IS ASSIGNED AND <lv_data_file_icon> IS ASSIGNED.
    IF <lv_data_file_type> IS INITIAL AND <lv_data_file_icon> IS INITIAL.
      <lv_data_file_type> = 'text/html'.
      " Get icon for file type
      CALL METHOD cl_usmd_cr_ui_service=>get_file_icon
        EXPORTING
          iv_mime_type  = <lv_data_file_type>
        RECEIVING
          rv_icon_alias = <lv_data_file_icon>.
    ELSEIF <lv_data_file_type> IS NOT INITIAL AND <lv_data_file_icon> IS INITIAL.
      " Get icon for file type
      CALL METHOD cl_usmd_cr_ui_service=>get_file_icon
        EXPORTING
          iv_mime_type  = <lv_data_file_type>
        RECEIVING
          rv_icon_alias = <lv_data_file_icon>.
    ENDIF.
  ENDIF.

  ASSIGN COMPONENT 'USMD_FILE_SIZE' OF STRUCTURE cs_data TO <lv_data_file_size>.
  ASSIGN COMPONENT 'FILE_SIZE_DESCR' OF STRUCTURE cs_data TO <lv_data_dest>.
  IF <lv_data_file_size> IS ASSIGNED AND <lv_data_dest> IS ASSIGNED.
    IF <lv_data_file_size> IS NOT INITIAL.
      lv_file_size = <lv_data_file_size>.
      CALL METHOD cl_usmd_cr_ui_service=>get_file_size_description
        EXPORTING
          iv_file_size_bytes       = lv_file_size
        RECEIVING
          rv_file_size_description = <lv_data_dest>.

    ELSE.
      CLEAR <lv_data_dest>.
    ENDIF.
  ENDIF.

  ASSIGN COMPONENT 'USMD_ACREATED_AT' OF STRUCTURE cs_data TO <lv_data_dest>.
  IF sy-subrc = 0.
    <lv_data_dest> = me->convert_utc_timestamp( <lv_data_dest> ).
  ENDIF.

  ASSIGN COMPONENT 'USMD_TITLE' OF STRUCTURE cs_data TO <lv_usmd_title>.

* Remove the extension from the file name. There might be more than one dot in the name.
  REPLACE REGEX '\.\w+((\s+)|($))' IN <lv_usmd_title> WITH space .

ENDMETHOD.


METHOD HANDLE_EDIT_ENTRANCE.

*  super->handle_edit_entrance( io_event = io_event
*    iv_raised_by_own_ui = iv_raised_by_own_ui ).
*
*  RETURN.
* redefine method CL_GUIBB_BOL_COLLECTION->HANDLE_EDIT_ENTRANCE in order to
* avoid automatic creation of an initial line in the attachment list when list is empty
* internal message: 0120031469 0001832103 2013

  DATA: lo_connector TYPE REF TO cl_mdg_bs_connector_bol_rel,
        lo_entity LIKE me->mo_entity,
        lv_locked TYPE boolean.



  CASE io_event->mv_event_id.
    WHEN if_fpm_constants=>gc_event-local_edit.
      IF iv_raised_by_own_ui = abap_true AND
         mv_fpm_edit_mode = if_fpm_constants=>gc_edit_mode-read_only.
        IF mo_collection IS BOUND.
          TRY.
              lo_connector ?= mo_connector.
            CATCH cx_sy_move_cast_error .
              ASSERT lo_connector IS BOUND.
          ENDTRY.
          lo_entity = lo_connector->get_parent( ).
          IF lo_entity IS BOUND AND lo_entity->is_locked( ) = abap_false.
            lv_locked = abap_false.
            IF lo_connector->if_fpm_connector_def~mv_wire_label CS
                if_usmd_generic_genil_const=>gc_attach_object.
              "               lock type 1 entity to which attachment header refers to
              CALL METHOD
                lo_entity->lock
                RECEIVING
                  rv_success = lv_locked.
            ENDIF.
          ELSE.
            lv_locked = abap_true.
          ENDIF.

          IF mo_collection->size( ) = 0 AND lv_locked = abap_true.
            CALL METHOD set_fpm_edit_mode
              EXPORTING
                iv_fpm_edit_mode = if_fpm_constants=>gc_edit_mode-edit.
          ENDIF.
        ENDIF.
      ENDIF.
  ENDCASE.

ENDMETHOD.


method if_fpm_guibb_list~get_data.

  types : begin of lty_data,
            lo_bol_ref       type ref to cl_crm_bol_entity,
            usmd_acreated_by type xubname,
            usmd_file_type   type skwf_mime,
            usmd_file_size   type filesize,
            usmd_title       type usmd_txtlg,
            usmd_content     type usmd_content,
          end of lty_data.

  data : lt_data type standard table of lty_data,
         ls_data type lty_data.

  call method super->if_fpm_guibb_list~get_data
    exporting
      iv_eventid                = iv_eventid
      it_selected_fields        = it_selected_fields
      iv_raised_by_own_ui       = iv_raised_by_own_ui
      iv_visible_rows           = iv_visible_rows
      iv_edit_mode              = iv_edit_mode
      io_extended_ctrl          = io_extended_ctrl
    importing
      et_messages               = et_messages
      ev_data_changed           = ev_data_changed
      ev_field_usage_changed    = ev_field_usage_changed
      ev_action_usage_changed   = ev_action_usage_changed
      ev_selected_lines_changed = ev_selected_lines_changed
      ev_dnd_attr_changed       = ev_dnd_attr_changed
      eo_itab_change_log        = eo_itab_change_log
    changing
      ct_data                   = ct_data
      ct_field_usage            = ct_field_usage
      ct_action_usage           = ct_action_usage
      ct_selected_lines         = ct_selected_lines
      cv_lead_index             = cv_lead_index
      cv_first_visible_row      = cv_first_visible_row
      cs_additional_info        = cs_additional_info
      ct_dnd_attributes         = ct_dnd_attributes.


*  case iv_eventid->mv_event_id.
*
*  endcase.

endmethod.


method IF_FPM_GUIBB_LIST~GET_DEFINITION.

  CALL METHOD SUPER->IF_FPM_GUIBB_LIST~GET_DEFINITION
    IMPORTING
      EO_FIELD_CATALOG         = EO_FIELD_CATALOG
      ET_FIELD_DESCRIPTION     = ET_FIELD_DESCRIPTION
      ET_ACTION_DEFINITION     = ET_ACTION_DEFINITION
      ET_SPECIAL_GROUPS        = ET_SPECIAL_GROUPS
      ES_MESSAGE               = ES_MESSAGE
      EV_ADDITIONAL_ERROR_INFO = EV_ADDITIONAL_ERROR_INFO
      ET_DND_DEFINITION        = ET_DND_DEFINITION
      ET_ROW_ACTIONS           = ET_ROW_ACTIONS
      ES_OPTIONS               = ES_OPTIONS.

  FIELD-SYMBOLS <fs_LISTFIELD_DESCR> type FPMGB_S_LISTFIELD_DESCR.

  read TABLE ET_FIELD_DESCRIPTION ASSIGNING <fs_LISTFIELD_DESCR>
     with key name = 'USMD_LINK'.

  if sy-subrc = 0.
    <fs_LISTFIELD_DESCR>-read_only = abap_true.
    clear <fs_LISTFIELD_DESCR>-read_only_ref.
  endif.

  read TABLE ET_FIELD_DESCRIPTION ASSIGNING <fs_LISTFIELD_DESCR>
     with key name = 'USMD_LANGUAGE'.

  if sy-subrc = 0.
    <fs_LISTFIELD_DESCR>-is_nullable = abap_true.
  endif.
.


endmethod.


method if_fpm_guibb_list~process_event.

  data: lv_row_index  type sytabix,
        lo_entity     like me->mo_entity,
        lv_att_type   type c,
        lv_success    type abap_bool,
        lv_lead_index like iv_lead_index.

  data: ls_attachment     type usmd_s_attachment_wo_cont,
        ls_message        like line of et_messages,
        ls_selected_lines like line of it_selected_lines,
        lv_delete_denied  type abap_bool.

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

  if iv_raised_by_own_ui = abap_false.
    return.
  endif.


  case io_event->mv_event_id.
    when cv_event_id_link_add.
      me->add_link_attachment(
        exporting
      io_event    = io_event
        importing
      ev_result   = ev_result
      et_messages = et_messages ).
      return.

    when cv_event_id_file_add.
      io_event->mo_event_data->set_value(
      exporting
        iv_key = if_fpm_constants=>gc_dialog_box-id
        iv_value = 'ZUSMD_ENTITY_ATT_FILE' ).
      cl_fpm_factory=>get_instance( )->open_dialog_box(
      iv_dialog_box_id = 'ZUSMD_ENTITY_ATT_FILE'
      io_event_data = io_event->mo_event_data ).
      return.

    when if_fpm_guibb_list~gc_event_list_filter.
      data dref_file_data type ref to data.
      create data dref_file_data type handle mo_struct_rtti.
      field-symbols <fs_file_data> type any .
      assign dref_file_data->* to <fs_file_data>.
      io_event->mo_event_data->get_value(
      exporting iv_key = 'ATT_DATA'
      importing ev_value = dref_file_data ).


    when cv_event_id_att_edit.
      " Editing of already existing attachment
*----- get row index
      call method io_event->mo_event_data->get_value
        exporting
          iv_key   = if_fpm_guibb_list=>gc_event_par_row
        importing
          ev_value = lv_row_index.

*----- bound for row action
      if lv_row_index > 0.

*----- put selection temporarily on row to set lead selection outport
        if mo_collection->find( iv_index = lv_row_index ) is bound.
          ev_result = if_fpm_constants=>gc_event_result-ok.
        else.
          ev_result = if_fpm_constants=>gc_event_result-failed.
        endif.
        if ev_result = if_fpm_constants=>gc_event_result-ok.
          call method me->set_selection
            exporting
              iv_lead_index = lv_row_index
*             it_selection  =
            .
        endif.
        " Determine if it is a link or a file
        " Get the corresponding bol entity for the selected link
        call method mo_collection->find
          exporting
            iv_index  = lv_row_index
*           iv_entity =
*           iv_object_instance =
          receiving
            rv_result = lo_entity.

        if lo_entity is bound.
          " Get relevant data for showing the attachment
          call method me->mo_entity->if_bol_bo_property_access~get_properties
            importing
              es_attributes = ls_attachment.

          " Determine if it is a link or a file
          if ls_attachment-usmd_link is not initial.
            lv_att_type = 'L'.
          else.
            lv_att_type = 'F'.
          endif.

          "When file
          if lv_att_type = 'F'.
            me->raise_local_event_by_id( cv_event_id_att_file_edit ).
            "when link
          elseif lv_att_type = 'L'.
            me->raise_local_event_by_id( cv_event_id_att_link_edit ).
          endif.
          return.
        endif.
      endif.
    when cv_event_id_show_att.
      " Nothing to do here
    when cv_event_id_att_del.
      " Set the current selected lines to the bol collection
      if it_selected_lines is not initial.

        loop at it_selected_lines into ls_selected_lines.
          lv_row_index = ls_selected_lines-tabix.
          " Get the corresponding bol entity
          call method mo_collection->find
            exporting
              iv_index  = lv_row_index
            receiving
              rv_result = lo_entity.

          if lo_entity is bound.
            " Get relevant data for showing the attachment
            call method lo_entity->if_bol_bo_property_access~get_properties
              importing
                es_attributes = ls_attachment.

          endif.
        endloop.
        " All attachments that are selected are to be deleted
        lv_lead_index = iv_lead_index.
        clear lv_lead_index.
        call method me->set_selection
          exporting
            iv_lead_index = lv_lead_index
            it_selection  = it_selected_lines.
        call method me->delete.
        ev_result = if_fpm_constants=>gc_event_result-ok.
        "undo is deactivated for a delete operation
        mo_work = cl_do=>work( ).
        me->mo_work->break( ).
        clear ls_message.
        ls_message-msgid    = 'USMD2'.
        ls_message-msgno    = '374'.
        ls_message-severity = 'I'.
        append ls_message to et_messages.
      else.
        " Error message: No lines selected
        if 1 = 2.
          message e117(usmd2).
        else.
          clear ls_message.
          ls_message-msgid    = 'USMD2'.
          ls_message-msgno    = '157'.
          ls_message-severity = 'E'.
          append ls_message to et_messages.
          ev_result = if_fpm_constants=>gc_event_result-failed.
        endif.
      endif.
  endcase.
*  call method super->if_fpm_guibb_list~process_event "mainly FPM_LOCAL_EDIT, FPM_GUIBB_LIST_CELL_ACTION, FPM_TRAY_TOGGLE
*    exporting
*      io_event            = io_event
*      iv_raised_by_own_ui = iv_raised_by_own_ui
*      iv_lead_index       = iv_lead_index
*      iv_event_index      = iv_event_index
*      it_selected_lines   = it_selected_lines
*    importing
*      ev_result           = ev_result
*      et_messages         = et_messages.



endmethod.


METHOD IS_ROW_ACTION_ENABLED.
  DATA: lv_enabled TYPE abap_bool.

  IF me->is_mode_read_only( ) = abap_true.
    lv_enabled = abap_false.
  ELSE.
    lv_enabled = abap_true.
  ENDIF.

  CASE iv_event_id.
    WHEN cv_event_id_att_edit.
      rv_enabled = lv_enabled.

    WHEN cv_event_id_att_del.
      IF lv_enabled = abap_true.
        rv_enabled = super->is_row_action_enabled(
          iv_event_id = cv_event_id_row_delete
          io_entity   = io_entity ).
      ELSE.
        rv_enabled = lv_enabled.
      ENDIF.

    WHEN if_usmd_generic_bolui_const=>gc_action_discard_delete.
      IF lv_enabled = abap_true.
        rv_enabled = super->is_row_action_enabled(
          iv_event_id = iv_event_id
          io_entity   = io_entity ).
      ELSE.
        rv_enabled = lv_enabled.
      ENDIF.

    WHEN OTHERS.
      rv_enabled = super->is_row_action_enabled(
        iv_event_id = iv_event_id
        io_entity   = io_entity ).
  ENDCASE.
ENDMETHOD.


METHOD PROCESS_LIST_CELL_ACTION.
  DATA: lo_entity     TYPE REF TO cl_crm_bol_entity,
        lo_rel_entity TYPE REF TO cl_crm_bol_entity,
        ls_attachment TYPE usmd_s_attachment,
        lv_att_type   TYPE c,
        lv_title      TYPE string,
        lv_mime_type  TYPE string.

*   Data declaration for showing the selected attachment
  DATA: lo_fpm                  TYPE REF TO if_fpm,
        ls_url_launcher         TYPE fpm_s_launch_url,
        ls_navigator_parameters TYPE apb_lpd_s_portal_parameters,
        lo_navigator            TYPE REF TO if_fpm_navigate_to,
        lv_error_occured        TYPE abap_bool,
        lr_bol_property_access  TYPE REF TO if_bol_bo_property_access,
        lr_related_entities     TYPE REF TO if_bol_entity_col,
        lr_attachment_x         TYPE REF TO data,
        lr_title                TYPE REF TO data,
        lr_link                 TYPE REF TO data,
        lr_mime_type            TYPE REF TO data.

  FIELD-SYMBOLS <fs_title>      TYPE usmd_txtlg.
  FIELD-SYMBOLS <fs_link>       TYPE string.
  FIELD-SYMBOLS <fs_mime_type>  TYPE skwf_mime.
  FIELD-SYMBOLS <fs_xstring>    TYPE xstring.

  CASE io_event->mv_event_id.
    WHEN 'FPM_GUIBB_LIST_CELL_ACTION'.
      " Determine the data from the current line (IV_ROW_INDEX)
      IF iv_fieldname = 'USMD_TITLE'.
*         Get the corresponding bol entity for the selected link

        CALL METHOD mo_collection->find
          EXPORTING
            iv_index           = iv_row_index
*           iv_entity          =
*           iv_object_instance =
          RECEIVING
            rv_result          = lo_entity.

        IF lo_entity IS BOUND.
          TRY.
              lr_related_entities    = lo_entity->get_related_entities( ). "related entities are children
              lr_bol_property_access = lr_related_entities->get_first( ).
              lo_rel_entity         ?= lr_bol_property_access.
            CATCH cx_crm_genil_model_error.    " Error when Accessing Object Model

          ENDTRY.

          IF lo_rel_entity IS BOUND.

            lr_link = lo_rel_entity->if_bol_bo_property_access~get_property(
            iv_attr_name = 'USMD_LINK' ).
            ASSIGN lr_link->* TO <fs_link> .

            " Determine if it is a link or a file
            IF <fs_link> IS NOT INITIAL.
              lv_att_type = 'L'.
            ELSE.
              lv_att_type = 'F'.
            ENDIF.

            lr_title = lo_rel_entity->if_bol_bo_property_access~get_property(
            iv_attr_name = 'USMD_TITLE' ).
            ASSIGN lr_title->* TO  <fs_title> .

            lv_title  = <fs_title>.
          ENDIF.

          " When Link
          IF lv_att_type = 'L'.
            lo_fpm = cl_fpm_factory=>get_instance( ).
            lo_navigator = lo_fpm->get_navigate_to( ).
            ls_url_launcher-url                     = <fs_link>.
            ls_url_launcher-header_text             = <fs_title>.
            ls_navigator_parameters-navigation_mode = 'EXTERNAL'. "opens new window for navigation target
            ls_navigator_parameters-history_mode    = '0'. "can occur multiple times in history

            lo_navigator->launch_url(
               EXPORTING
                 is_url_fields = ls_url_launcher
                 is_additional_parameters = ls_navigator_parameters
               IMPORTING
                 ev_error = lv_error_occured ).
            IF lv_error_occured = abap_true.
              rv_result = if_fpm_constants=>gc_event_result-failed.
            ELSE.
              rv_result = if_fpm_constants=>gc_event_result-ok.
            ENDIF.
            " When File
          ELSEIF lv_att_type = 'F'. "When File
            lr_attachment_x = lo_rel_entity->if_bol_bo_property_access~get_property(
              iv_attr_name = 'USMD_CONTENT' ).
            ASSIGN lr_attachment_x->* TO <fs_xstring>.
            IF <fs_xstring> IS INITIAL.
              rv_result = if_fpm_constants=>gc_event_result-failed.
              RETURN.
            ENDIF.

            lr_mime_type = lo_rel_entity->if_bol_bo_property_access~get_property(
            iv_attr_name = 'USMD_FILE_TYPE' ).
            ASSIGN lr_mime_type->* TO <fs_mime_type> .
            lv_mime_type = <fs_mime_type> .
            IF lv_mime_type = cl_usmd_crequest_util=>gc_mime_type_outlook_msg.
              CONCATENATE lv_title '.msg' INTO lv_title.
            ENDIF.

            cl_wd_runtime_services=>attach_file_to_response(
                    i_filename      = lv_title
                    i_content       = <fs_xstring>
                    i_mime_type     = lv_mime_type
                    i_in_new_window = abap_true
                    i_inplace       = abap_false ).

          ENDIF.
        ELSE.
          rv_result = if_fpm_constants=>gc_event_result-failed.
        ENDIF.

      ELSEIF iv_fieldname = 'CREATEDBY__TEXT'.
        DATA: lo_event TYPE REF TO cl_fpm_event.

        " Get the corresponding bol entity for the selected link
        CALL METHOD mo_collection->find
          EXPORTING
            iv_index           = iv_row_index
*           iv_entity          =
*           iv_object_instance =
          RECEIVING
            rv_result          = lo_entity.

        IF lo_entity IS BOUND.
          " Get relevant data for showing user profile
          CALL METHOD lo_entity->if_bol_bo_property_access~get_properties
            IMPORTING
              es_attributes = ls_attachment.

          " Only if user is set
          IF ls_attachment-usmd_acreated_by IS NOT INITIAL.
            lo_event = me->raise_local_event_by_id( cl_usmd_cr_user_popup=>cv_event_id_show_user_profile ).
          ELSE.
            rv_result = if_fpm_constants=>gc_event_result-failed.
            RETURN.
          ENDIF.

          " If we have the reference to the event, attach the user data
          IF lo_event IS BOUND.
            CALL METHOD lo_event->mo_event_data->set_value
              EXPORTING
                iv_key   = cl_usmd_cr_user_popup=>cv_user
                iv_value = ls_attachment-usmd_acreated_by.
          ENDIF.
        ENDIF.
      ENDIF.
  ENDCASE.
ENDMETHOD.
ENDCLASS.
