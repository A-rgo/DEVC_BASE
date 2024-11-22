class ZCL_ZX_USMD_ENTITY_ATTACHMENT definition
  public
  inheriting from CL_MDG_BS_GUIBB_FORM
  final
  create public .

public section.

  constants CV_FILE_MODE_CREATE type C value 'C' ##NO_TEXT.
  constants CV_FILE_MODE_EDIT type C value 'E' ##NO_TEXT.
  constants CV_ATT_MODE type STRING value 'ATT_MODE' ##NO_TEXT.

  methods IF_BS_BOL_HOW_FEEDER~DELETE_ENTITY
    redefinition .
  methods IF_FPM_GUIBB_FORM~FLUSH
    redefinition .
  methods IF_FPM_GUIBB_FORM~GET_DATA
    redefinition .
  methods IF_FPM_GUIBB_FORM~GET_DEFINITION
    redefinition .
  methods IF_FPM_GUIBB_FORM~PROCESS_EVENT
    redefinition .
protected section.

  methods CHECK_FIELD_USAGE
    redefinition .
  methods CREATE_STRUCT_RTTI
    redefinition .
  methods GET_ENTITY_DATA
    redefinition .
private section.

  data MV_FILE_EDIT_MODE type C .
  data MV_FIRST_TIME type ABAP_BOOL value 'X' ##NO_TEXT.
  data MV_FILENAME type STRING .
  data MV_FILENAME_NEW type STRING .
  data MO_BOL_ENTITY type ref to CL_CRM_BOL_ENTITY .
  data MO_ATTACHMENT_DATA type ref to DATA .
  data MS_ATTACHMENT_FILE_DATA type BSS_CRIL_ATTACHMENT_ATTRIBUTES .
  data MO_CREATED_BY_EVENT type ref to CL_FPM_EVENT .

  methods REGISTER_CHANGE_FOR_UNDO
    importing
      !IO_ENTITY type ref to CL_CRM_BOL_ENTITY
      !IO_CREATED_BY_EVENT type ref to CL_FPM_EVENT .
  methods CLEAR_ATTACHMENT_DATA
    changing
      !CO_ATTACHMENT_DATA type ref to DATA .
  methods GET_RELATION_NAME
    importing
      !IV_HEADER type BOOLE_D default ABAP_TRUE
    returning
      value(RV_RELATION_NAME) type CRMT_RELATION_NAME .
ENDCLASS.



CLASS ZCL_ZX_USMD_ENTITY_ATTACHMENT IMPLEMENTATION.


method CHECK_FIELD_USAGE.
  FIELD-SYMBOLS <fs_field_usage> LIKE LINE OF ct_field_usage.

  CALL METHOD SUPER->CHECK_FIELD_USAGE
    CHANGING
      CT_FIELD_USAGE = ct_field_usage
      .

  IF me->mv_edit_mode = abap_true.
    LOOP AT ct_field_usage ASSIGNING <fs_field_usage>.
      <fs_field_usage>-read_only = abap_false.
      IF <fs_field_usage>-name = 'CONTENT' OR <fs_field_usage>-name = 'TITLE'.
        <fs_field_usage>-mandatory = abap_true.
      ENDIF.
    ENDLOOP.
    ms_change-field_usage = abap_true.
  ENDIF.
endmethod.


METHOD CLEAR_ATTACHMENT_DATA.

  DATA: lo_struct_rtti TYPE REF TO  cl_abap_structdescr,
        lo_substruct_rtti TYPE REF TO  cl_abap_structdescr,
"        lt_substruc_component TYPE abap_component_tab,
        lt_component   TYPE abap_component_tab.
"        lv_struc_name TYPE abap_abstypename.

  FIELD-SYMBOLS: <ls_component> TYPE LINE OF abap_component_tab,
                 <ls_substruc_component> TYPE abap_compdescr,
                 <ls_attachment_data> TYPE any,
                 <lv_field> TYPE any.



  lo_struct_rtti ?= cl_abap_structdescr=>describe_by_data_ref( co_attachment_data ).
  CALL METHOD lo_struct_rtti->get_components
    RECEIVING
      p_result = lt_component.

  CLEAR lo_struct_rtti.
  ASSIGN co_attachment_data->* TO <ls_attachment_data>.

* clear content of attribute
  LOOP AT lt_component ASSIGNING <ls_component>.
    IF <ls_component>-as_include = abap_true.
      lo_substruct_rtti ?= <ls_component>-type.
      LOOP AT lo_substruct_rtti->components ASSIGNING <ls_substruc_component>.
        ASSIGN COMPONENT <ls_substruc_component>-name OF STRUCTURE <ls_attachment_data> TO <lv_field>.
        CLEAR <lv_field>.
      ENDLOOP.
    ELSE.
      ASSIGN COMPONENT <ls_component>-name OF STRUCTURE <ls_attachment_data> TO <lv_field>.
      CLEAR <lv_field>.
    ENDIF.
  ENDLOOP.


ENDMETHOD.


method CREATE_STRUCT_RTTI.
  DATA:
    lt_component TYPE cl_abap_structdescr=>component_table.

  FIELD-SYMBOLS:
    <ls_component> LIKE LINE OF lt_component.

  super->create_struct_rtti( ).

  APPEND INITIAL LINE TO lt_component ASSIGNING <ls_component>.

  <ls_component>-type = me->mo_struct_rtti.
  <ls_component>-as_include = abap_true.

  APPEND INITIAL LINE TO lt_component ASSIGNING <ls_component>.
  <ls_component>-name = 'FILENAME'.
  <ls_component>-type = cl_abap_elemdescr=>get_string( ).

  me->mo_struct_rtti = cl_abap_structdescr=>create( lt_component ).

  if mo_attachment_data is INITIAL.
    CREATE DATA mo_attachment_data TYPE HANDLE me->mo_struct_rtti.
  endif.
endmethod.


  METHOD GET_ENTITY_DATA.

    super->get_entity_data(
      EXPORTING io_access = io_access
      CHANGING cs_data = cs_data ).

    FIELD-SYMBOLS:  <lv_usmd_title> TYPE any.


    ASSIGN COMPONENT 'USMD_TITLE' OF STRUCTURE cs_data TO <lv_usmd_title>.
    IF sy-subrc = 0.
      REPLACE REGEX '\.\w+((\s+)|($))' IN <lv_usmd_title> WITH space .
    ENDIF.
  ENDMETHOD.


METHOD GET_RELATION_NAME.

  DATA: lf_entity_type TYPE crmt_ext_obj_name.

  lf_entity_type = me->mo_bol_entity->get_name( ).

  IF iv_header = abap_true.
    rv_relation_name = lf_entity_type && '2' &&
             if_usmd_generic_genil_const=>gc_attach_object && lf_entity_type && 'Rel'.
  ELSE.
    rv_relation_name = if_usmd_generic_genil_const=>gc_attach_object && lf_entity_type && '2' &&
             if_usmd_generic_genil_const=>gc_attach_object_content && lf_entity_type && 'Rel'.
  ENDIF.

ENDMETHOD.


METHOD IF_BS_BOL_HOW_FEEDER~DELETE_ENTITY.

  "redefinition is required for undo function
*----- default: failed
  rv_success = abap_false.

*----- entity defined?
  CHECK io_entity IS BOUND.
  CHECK io_entity->alive( ) = abap_true.
  CHECK io_entity->lock( ) = abap_true.

**----- activate sending if necessary
*  activate_bol_sending( io_entity ).

*----- note: for roots, deletions are committed immediately
  io_entity->delete( ).

*----- check success
  cl_crm_bol_core=>get_instance( )->modify( ).
  IF io_entity->alive( ) = abap_true.
    rv_success = abap_false.
  ELSE.
    "remove not required after undo
    "mo_collection->remove( io_entity ).
    rv_success = abap_true.
  ENDIF.

ENDMETHOD.


METHOD IF_FPM_GUIBB_FORM~FLUSH.
  DATA lf_file_size TYPE i.
  DATA lv_filename  TYPE string.
  DATA lv_mime_type TYPE skwf_mime.
  DATA lo_access    TYPE REF TO if_bol_bo_property_access.
  DATA l_file_parts TYPE TABLE OF skwf_filnm.
  DATA l_file_ext   TYPE skwf_filnm.
  DATA l_i          TYPE i.


  FIELD-SYMBOLS <fs_data1> TYPE any.
  FIELD-SYMBOLS <fs_data2> TYPE any.

  ASSIGN mo_attachment_data->* TO <fs_data1> .
  ASSIGN is_data->*            TO <fs_data2> .

  FIELD-SYMBOLS <fs_title1>       TYPE usmd_txtlg.
  FIELD-SYMBOLS <fs_content1>     TYPE usmd_content.
  FIELD-SYMBOLS <fs_file_type1>   TYPE skwf_mime.
  FIELD-SYMBOLS <fs_filename1>    TYPE string.
  FIELD-SYMBOLS <fs_explanation1> TYPE string.
  FIELD-SYMBOLS <fs_file_size1>   TYPE filesize.
  FIELD-SYMBOLS <fs_language1>    TYPE spras.

  FIELD-SYMBOLS <fs_title2>       TYPE usmd_txtlg.
  FIELD-SYMBOLS <fs_content2>     TYPE usmd_content.
  FIELD-SYMBOLS <fs_file_type2>   TYPE skwf_mime.
  FIELD-SYMBOLS <fs_filename2>    TYPE string.
  FIELD-SYMBOLS <fs_explanation2> TYPE string.
  FIELD-SYMBOLS <fs_language2>    TYPE spras.

  IF it_change_log IS INITIAL.
    RETURN.
  ENDIF.

  ASSIGN COMPONENT 'USMD_TITLE' OF STRUCTURE <fs_data1> TO <fs_title1>.
  ASSIGN COMPONENT 'USMD_TITLE' OF STRUCTURE <fs_data2> TO <fs_title2>.
  <fs_title1> = <fs_title2> .

  ASSIGN COMPONENT 'USMD_EXPLANATION' OF STRUCTURE <fs_data1> TO <fs_explanation1>.
  ASSIGN COMPONENT 'USMD_EXPLANATION' OF STRUCTURE <fs_data2> TO <fs_explanation2>.
  <fs_explanation1> = <fs_explanation2> .

  ASSIGN COMPONENT 'USMD_LANGUAGE' OF STRUCTURE <fs_data1> TO <fs_language1>.
  ASSIGN COMPONENT 'USMD_LANGUAGE' OF STRUCTURE <fs_data2> TO <fs_language2>.
  <fs_language1> = <fs_language2> .

  ASSIGN COMPONENT 'USMD_CONTENT'   OF STRUCTURE <fs_data2> TO <fs_content2>.
  IF <fs_content2> IS NOT INITIAL.
    ASSIGN COMPONENT 'USMD_CONTENT'   OF STRUCTURE <fs_data1> TO <fs_content1>.
    <fs_content1> = <fs_content2> .

    ASSIGN COMPONENT 'USMD_FILE_TYPE' OF STRUCTURE <fs_data1> TO <fs_file_type1>.
    ASSIGN COMPONENT 'USMD_FILE_TYPE' OF STRUCTURE <fs_data2> TO <fs_file_type2>.
    <fs_file_type1> = <fs_file_type2>.

    ASSIGN COMPONENT 'FILENAME'       OF STRUCTURE <fs_data1> TO <fs_filename1>.
    ASSIGN COMPONENT 'FILENAME'       OF STRUCTURE <fs_data2> TO <fs_filename2>.
    <fs_filename1> = <fs_filename2>.
    mv_filename = <fs_filename1> .

    SPLIT mv_filename AT '.' INTO TABLE l_file_parts.
    DESCRIBE TABLE l_file_parts LINES l_i.
    IF l_i > 1.
      READ TABLE l_file_parts INTO l_file_ext INDEX l_i.
    ENDIF.

    IF <fs_title1> IS NOT INITIAL.
      CONCATENATE <fs_title1>(55) '.' l_file_ext INTO <fs_title1>.
    ENDIF.

    ASSIGN COMPONENT 'USMD_FILE_SIZE' OF STRUCTURE <fs_data1> TO <fs_file_size1>.
    lf_file_size = xstrlen( <fs_content2> ).
    <fs_file_size1> = lf_file_size.
  ENDIF.


  " Special handling for outlook message files as they are not correctly provided by microsoft file upload
  ASSIGN COMPONENT 'FILENAME' OF STRUCTURE <fs_data2> TO <fs_filename2>.
  IF sy-subrc = 0 AND <fs_filename2> IS ASSIGNED AND <fs_filename2> IS NOT INITIAL.
    lv_filename = <fs_filename2>.

    " Check if it is a .msg file
    CALL METHOD cl_usmd_crequest_util=>convert_mime_type_of_attach
      EXPORTING
        iv_file_name = lv_filename
      CHANGING
        cv_mime_type = lv_mime_type.

    IF lv_mime_type = cl_usmd_crequest_util=>gc_mime_type_outlook_msg.
      lo_access = get_property_access( iv_for_change = abap_true ).
      IF lo_access IS BOUND.
        lo_access->set_property(
          EXPORTING
            iv_attr_name = 'FILE_TYPE'
            iv_value     = lv_mime_type
        ).
      ENDIF.
    ENDIF.
  ENDIF.
ENDMETHOD.


METHOD IF_FPM_GUIBB_FORM~GET_DATA.

  DATA: lv_key TYPE string,
        lo_created_by_event TYPE REF TO cl_fpm_event.

  FIELD-SYMBOLS:
     <lv_filename> TYPE any,
     <fs_data>     TYPE fpmgb_s_fieldusage.



  "get created by event for 'undo' registration
  lv_key = cl_usmd_attachment_list=>cv_event_id_file_add.
  io_event->mo_event_data->get_value(
    EXPORTING
      iv_key   = lv_key
    IMPORTING
      ev_value = lo_created_by_event ).
  IF lo_created_by_event IS BOUND.
    mo_created_by_event = lo_created_by_event.
  ENDIF.

  ASSIGN COMPONENT 'FILENAME' OF STRUCTURE cs_data TO <lv_filename>.
  IF sy-subrc = 0.
    mv_filename = <lv_filename>.
  ENDIF.

  IF  me->mv_first_time = abap_true.
* If there was an error and the popup has to be sent again, we shouldn't overwrite the text fields.
* cs_data will not be changed by this super call because data weren't submitted to the BOL-layer.
    CALL METHOD super->if_fpm_guibb_form~get_data
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
        ct_action_usage         = ct_action_usage.
  ENDIF.

  READ TABLE ct_field_usage INDEX 1 ASSIGNING <fs_data> .
  <fs_data>-mandatory = abap_true.
  READ TABLE ct_field_usage INDEX 4 ASSIGNING <fs_data>.
  <fs_data>-mandatory = abap_true.

  ASSIGN COMPONENT 'FILENAME' OF STRUCTURE cs_data TO <lv_filename>.
  IF sy-subrc = 0.
    <lv_filename> = mv_filename.
  ENDIF.

  IF me->mv_first_time = abap_true.
    me->mv_first_time = abap_false.
    " Get fpm event parameter

    CALL METHOD io_event->mo_event_data->get_value
      EXPORTING
        iv_key   = me->cv_att_mode
      IMPORTING
        ev_value = me->mv_file_edit_mode.

    CALL METHOD io_event->mo_event_data->get_value
      EXPORTING
        iv_key   = me->cv_att_mode
      IMPORTING
        ev_value = mo_bol_entity.

    IF me->mv_file_edit_mode = cv_file_mode_edit.
      " Store the initial data of the popup in order to unddo changes  (if happened)
      " when the popup processing will be cancelled
      CLEAR me->ms_attachment_file_data.
      MOVE-CORRESPONDING cs_data TO me->ms_attachment_file_data.
    ENDIF.

    me->raise_local_event_by_id( if_fpm_constants=>gc_event-local_edit ). "to make the popup fields editable

    IF "me->mv_workflow_is_stable = abap_true AND
       me->is_mode_read_only( ) = abap_true AND
       me->mo_entity IS BOUND AND
      NOT ( io_event->mv_event_id = if_fpm_constants=>gc_event-local_edit AND iv_raised_by_own_ui = abap_true ).
      me->raise_local_event_by_id( if_fpm_constants=>gc_event-local_edit ).
    ENDIF.
  ENDIF.
ENDMETHOD.


method IF_FPM_GUIBB_FORM~GET_DEFINITION.

FIELD-SYMBOLS:  <ls_FIELD_DESCRIPTION>  TYPE FPMGB_s_FORMFIELD_DESCR.

  call method super->if_fpm_guibb_form~get_definition
    IMPORTING
      es_message               = ES_MESSAGE
      eo_field_catalog         = EO_FIELD_CATALOG
      et_field_description     = ET_FIELD_DESCRIPTION
      et_action_definition     = ET_ACTION_DEFINITION
      et_special_groups        = ET_SPECIAL_GROUPS
      ev_additional_error_info = EV_ADDITIONAL_ERROR_INFO
      et_dnd_definition        =  ET_DND_DEFINITION .

  READ TABLE ET_FIELD_DESCRIPTION with table key name = 'USMD_CONTENT' assigning <ls_FIELD_DESCRIPTION>.
  IF sy-subrc = 0.
    <ls_field_description>-file_name_ref = 'FILENAME'.
    <ls_field_description>-mime_type_ref = 'USMD_FILE_TYPE'.
  ENDIF.

endmethod.


method if_fpm_guibb_form~process_event.

  data:
    lv_dialog_action_id  type string,
    ls_message           like line of et_messages,
    ls_attachment_data   type bss_cril_attachment_attributes,
    lo_new_attach_entity type ref to cl_crm_bol_entity,
    lr_attx_entity       type ref to cl_crm_bol_entity,
    lr_fpm               type ref to if_fpm,
    lr_event_data        type ref to cl_fpm_parameter,
    dref_file_data       type ref to data..

  case io_event->mv_event_id.

    when if_fpm_constants=>gc_event-close_dialog.

      io_event->mo_event_data->get_value(
        exporting iv_key = if_fpm_constants=>gc_dialog_box-dialog_buton_key
        importing ev_value = lv_dialog_action_id ).

      case lv_dialog_action_id.

        when if_fpm_constants=>gc_dialog_action_id-ok.

          field-symbols <fs_data> type any .
          assign mo_attachment_data->* to <fs_data>  .

          field-symbols <fs_title>        type usmd_txtlg.
          field-symbols <fs_content>      type usmd_content.
          field-symbols <fs_file_type>    type skwf_mime.
          field-symbols <fs_filename>     type string.
          field-symbols <fs_explanation>  type string.
          field-symbols <fs_file_size>    type filesize.
          field-symbols <fs_language>     type spras.

          assign component 'USMD_TITLE'       of structure <fs_data> to <fs_title>.
          assign component if_usmd_generic_genil_const=>gc_attachment_content  of structure <fs_data> to <fs_content>.
          assign component 'USMD_FILE_TYPE'   of structure <fs_data> to <fs_file_type>.
          assign component 'FILENAME'         of structure <fs_data> to <fs_filename>.
          assign component 'USMD_FILE_SIZE'   of structure <fs_data> to <fs_file_size>.
          assign component 'USMD_EXPLANATION' of structure <fs_data> to <fs_explanation>.
          assign component 'USMD_LANGUAGE'    of structure <fs_data> to <fs_language>.

          create object lr_event_data.
          create data dref_file_data type handle mo_struct_rtti.
          field-symbols <fs_file_data> type any .
          assign dref_file_data->* to <fs_file_data>.
          assign <fs_data> to <fs_file_data>.
          assign component 'USMD_ACREATED_BY' of structure <fs_file_data> to field-symbol(<fs_created_by>).
          <fs_created_by> = sy-uname.
          if <fs_content> is initial.
            if 1 = 2.
              message e116(usmd2).
            endif.
            clear ls_message.
            ls_message-msgid    = 'USMD2'.
            ls_message-msgno    = '116'.
            ls_message-severity = 'E'.
            ls_message-ref_name = 'CONTENT'.
            append ls_message to et_messages.
            ev_result = if_fpm_constants=>gc_event_result-failed.
          endif.

          if <fs_title> is initial.
            if 1 = 2. message e106(usmd2) with text-001.endif.
            clear ls_message.
            ls_message-msgid       = 'USMD2'.
            ls_message-msgno       = '106'.
            ls_message-severity    = 'E'.
            ls_message-ref_name    = 'TITLE'.
            ls_message-parameter_1 = text-001.
            append ls_message to et_messages.
            ev_result = if_fpm_constants=>gc_event_result-failed.
          endif.

          if ev_result = if_fpm_constants=>gc_event_result-failed.

            if <fs_filename> is not initial.
              if 1 = 2.
                message s002(usmdcrui) with <fs_filename> .
              endif.
              clear ls_message.
              ls_message-msgid       = 'USMDCRUI'.
              ls_message-msgno       = '002'.
              ls_message-severity    = 'S'.
              ls_message-ref_name    = 'CONTENT'.
              ls_message-parameter_1 = <fs_filename>.
              append ls_message to et_messages.
            endif.
            return.
          else.
*           no errors
            ev_result = if_fpm_constants=>gc_event_result-ok.
            me->mv_first_time = abap_true.
          endif.
          data: lr_event         type ref to cl_fpm_event,
                ld_key           TYPE string.
          create object lr_event
            exporting
              iv_event_id = if_fpm_constants=>gc_event-open_dialog.
          lr_event->mo_event_data->set_value(
          iv_key   = if_fpm_constants=>gc_dialog_box-id
          iv_value = 'ZUSMD_ENTITY_ATT_FILE' ).

          ld_key = if_mdg_bs_ecc_bp_constants=>gc_sp_field-file_path.
          lr_event->mo_event_data->set_value(
            iv_key   = ld_key
            iv_value = <fs_filename> ).

          ld_key = if_mdg_bs_ecc_bp_constants=>gc_sp_field-file_content.
          lr_event->mo_event_data->set_value(
            iv_key   = ld_key
            iv_value = <fs_content> ).
          move-corresponding me->ms_instance_key to lr_event->ms_source_uibb.
          lr_event->ms_source_uibb-config_id      = 'ZMDG_ZX_ATTACH_FILE'.
          lr_event->ms_source_uibb-interface_view = if_fpm_constants=>gc_windows-form.
          lr_event->mv_is_implicit_edit           = abap_true.
          cl_fpm_factory=>get_instance( )->raise_event( io_event = lr_event ).
*          lr_fpm = cl_fpm_factory=>get_instance( ).
*
*          lr_event_data->if_fpm_parameter~set_value(
*          exporting
*            iv_key = 'ATT_DATA'
*            iv_value = <fs_file_data> ).
*          lr_event_data->ms_source_uibb = 'FPM_LIST_UIBB_ATS'.
*          lr_event_data->ms_source_uibb-config_id = 'ZMDG_ZX_ATTACH_LIST'.
*          lr_event_data->ms_source_uibb-interface_view = if_fpm_constants=>gc_windows-list.
*          lr_event_data->mv_is_implicit_edit = abap_true.
*          cl_fpm_factory=>get_instance( )->raise_event( io_event = iv_eventid ).
*
*          lr_fpm->raise_event_by_id(
*          exporting
*            iv_event_id = if_fpm_guibb_list=>gc_event_list_filter
*            io_event_data = lr_event_data ).
        when if_fpm_constants=>gc_dialog_action_id-cancel or
        if_fpm_constants=>gc_dialog_action_id-close.
          call method clear_attachment_data
            changing
              co_attachment_data = mo_attachment_data.
          me->mv_first_time = abap_true.
      endcase.
    when if_fpm_constants=>gc_event-refresh.
      if mv_filename is not initial.
        if 1 = 2.
          message s002(usmdcrui) with mv_filename_new.
        endif.
        clear ls_message.
        ls_message-msgid       = 'USMDCRUI'.
        ls_message-msgno       = '002'.
        ls_message-severity    = 'S'.
        ls_message-ref_name    = 'CONTENT'.
        ls_message-parameter_1 = mv_filename.
        append ls_message to et_messages.
      endif.
    when others.
      return.
  endcase.
endmethod.


METHOD REGISTER_CHANGE_FOR_UNDO.

  DATA ls_delayed_change LIKE LINE OF me->mt_delayed_changes.



  CHECK me->mo_how_to IS BOUND.
  me->mo_how_to->create(
    EXPORTING
      io_entity                      = io_entity
      io_created_by_event            = io_created_by_event ).
  CHECK me->mt_delayed_changes IS NOT INITIAL.
  LOOP AT me->mt_delayed_changes INTO ls_delayed_change.
    io_entity->set_property_as_string(
      iv_attr_name = ls_delayed_change-name
      iv_value = ls_delayed_change-value
    ).
  ENDLOOP.
  CLEAR me->mt_delayed_changes.

ENDMETHOD.
ENDCLASS.
