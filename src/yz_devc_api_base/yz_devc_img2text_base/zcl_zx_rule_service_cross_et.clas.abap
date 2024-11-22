CLASS zcl_zx_rule_service_cross_et DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_badi_interface .
    INTERFACES if_ex_usmd_rule_service2 .

    CONSTANTS gc_readmode_act_inact TYPE usmd_readmode VALUE '2' ##NO_TEXT.
  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS validate_identity_info
      IMPORTING
        !iv_identity_number TYPE char30
      EXPORTING
        !ev_request_status  TYPE char20
        !ev_status          TYPE char20
        !ev_holder_name     TYPE char70
        !ev_type            TYPE char50
        !ev_reason_message  TYPE char30 .
    METHODS upload_file_to_app_server
      EXPORTING
        !ev_file_path TYPE text1024 .
    METHODS remove_file_from_app_server
      IMPORTING
        !ev_file_path TYPE text1024 .
    METHODS fetch_idnum_from_file
      IMPORTING
        !iv_file_path TYPE text1024
      EXPORTING
        !ev_id_number TYPE char15
        !ev_file_type TYPE char1 .
    METHODS read_entity
      IMPORTING
        !iv_crequest TYPE usmd_crequest
        !iv_entity   TYPE usmd_entity
        !iv_readmode TYPE usmd_readmode_ext
      EXPORTING
        !eo_data_tab TYPE REF TO data .
ENDCLASS.



CLASS ZCL_ZX_RULE_SERVICE_CROSS_ET IMPLEMENTATION.


  METHOD fetch_idnum_from_file.
    CHECK iv_file_path IS NOT INITIAL.
    DATA: lo_regex_adhr   TYPE REF TO cl_abap_regex,
          lo_matcher_adhr TYPE REF TO cl_abap_matcher,
          lo_match_adhr   TYPE c LENGTH 1.

    DATA: lo_regex_pan   TYPE REF TO cl_abap_regex,
          lo_matcher_pan TYPE REF TO cl_abap_matcher,
          lo_match_pan   TYPE c LENGTH 1.

    CALL METHOD yz_clas_python_library_base=>execute_python_script
      EXPORTING
        i_filename = iv_file_path  ""'/hana/log/Python_MDG_Files/_English_sample2Test_Adhaar.png'
      IMPORTING
        t_execprot = DATA(lt_file_data).

    CREATE OBJECT lo_regex_adhr
      EXPORTING
        pattern     = '[2-9]{1}[0-9]{3} [0-9]{4} [0-9]{4}'
        ignore_case = abap_true.

    CREATE OBJECT lo_regex_pan
      EXPORTING
        pattern     = '[A-Z]{5}[0-9]{4}[A-Z]{1}'
        ignore_case = abap_false.

    LOOP AT lt_file_data INTO DATA(ls_file_data).
      CONDENSE ls_file_data.
      lo_matcher_adhr = lo_regex_adhr->create_matcher( text = ls_file_data ).
      IF lo_matcher_adhr->match( ) IS NOT INITIAL.
        ev_id_number = ls_file_data.
        ev_file_type = 'A'.
        EXIT.
      ENDIF.

      lo_matcher_pan = lo_regex_pan->create_matcher( text = ls_file_data ).
      IF lo_matcher_pan->match( ) IS NOT INITIAL.
        ev_id_number = ls_file_data.
        ev_file_type = 'P'.
        EXIT.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD if_ex_usmd_rule_service2~derive.
    DATA : lt_data                 TYPE STANDARD TABLE OF usmd_s_attachment_gui_wo_cont,
           ls_data                 TYPE usmd_s_attachment_gui_wo_cont,
           lt_sel                  TYPE usmd_ts_sel,
           ls_sel                  TYPE usmd_s_sel,
           lv_bp_id                TYPE bu_businesspartner,
           lt_key                  TYPE usmd_ts_value,
           lt_att                  TYPE usmd_ts_fieldname,
           ls_key                  TYPE usmd_s_value,
           ls_att                  TYPE usmd_fieldname,
           lv_long_directory       TYPE eps2path,
           lr_zidentity_data_struc TYPE REF TO data,
           lv_error                TYPE string,
           lv_idnum(16).
    DATA: lv_identity           TYPE char30,
          lt_zgen_data          TYPE TABLE OF zzx_s_zx_pp_zgen_data,
          lt_zidentity_cur_data TYPE TABLE OF zzx_s_zx_pp_zidentity,
          lt_zidentity_data     TYPE TABLE OF zzx_s_zx_pp_zidentity,
          ls_identity           LIKE LINE OF lt_zidentity_data,
          ls_zgen_data          LIKE LINE OF lt_zgen_data,
          ls_message            TYPE usmd_s_message.
    CONSTANTS : lc_directory     TYPE epsf-epsdirnam VALUE '/hana/log/Python_MDG_Files',
                lc_zidentity(10) TYPE c VALUE 'zidentity'.
    FIELD-SYMBOLS : <lfs_data>     TYPE any,
                    <lt_zidentity> TYPE ANY TABLE,
                    <ls_zidentity> TYPE any,
                    <lt_data>      TYPE ANY TABLE.

    DATA(lif_context) = cl_usmd_app_context=>get_context( ).
    IF lif_context IS NOT BOUND.
      RETURN.
    ENDIF.

    ls_sel-fieldname = 'USMD_CREQUEST'.
    ls_sel-sign = 'I'.
    ls_sel-option = 'EQ'.
    ls_sel-low = lif_context->mv_crequest_id.

    APPEND ls_sel TO lt_sel.

    CALL METHOD io_model->read_char_value
      EXPORTING
        i_fieldname = 'USMD_CREQUEST'
        it_sel      = lt_sel
      IMPORTING
        et_data     = lt_data
        et_message  = DATA(lt_message).

    LOOP AT lt_data INTO ls_data.
      DATA(lv_file_name) = ls_data-usmd_title.
    ENDLOOP.

    ""UPLOAD FILE TO SERVER
    upload_file_to_app_server(
      IMPORTING
        ev_file_path = DATA(lv_file_path)                 " Case-Sensitive Length 1024
    ).
    "" RUN PYTHON SCRIPT TO GET ID FROM FILE
    fetch_idnum_from_file(
      EXPORTING
        iv_file_path = lv_file_path                 " Case-Sensitive Length 1024
      IMPORTING
        ev_id_number = DATA(ls_file_data)                 " Character Field of Length 12
        ev_file_type = DATA(lv_file_t)
    ).
    IF ls_file_data IS INITIAL.
      ls_message-msgty = 'W'.
      ls_message-msgid = 'ZMDG_MESSAGE'.
      ls_message-msgno = '004'.
      APPEND ls_message TO et_message_info.
      ""REMOVE FILE FROM APP SERVER AFTER PROCESSING
      remove_file_from_app_server( ev_file_path = lv_file_path ).
      RETURN.
    ENDIF.
    CALL METHOD io_changed_data->read_data
      EXPORTING
        i_entity      = 'ZGEN_DATA'
      IMPORTING
        er_t_data_mod = DATA(lr_zgen_data).

    IF lr_zgen_data IS BOUND.
      ASSIGN lr_zgen_data->* TO <lfs_data>.
      IF sy-subrc IS NOT INITIAL AND <lfs_data> IS NOT ASSIGNED.
        RETURN.
      ENDIF.
      MOVE-CORRESPONDING <lfs_data> TO lt_zgen_data.

      LOOP AT <lfs_data> ASSIGNING FIELD-SYMBOL(<lfs_zgen_data>).
        ASSIGN COMPONENT 'ZGEN_DATA' OF STRUCTURE <lfs_zgen_data> TO FIELD-SYMBOL(<lfs_bp_id>).
        lv_bp_id = <lfs_bp_id>.
      ENDLOOP.

      read_entity(
        EXPORTING
          iv_crequest = lif_context->mv_crequest_id
          iv_entity   = 'ZIDENTITY'
          iv_readmode = gc_readmode_act_inact
        IMPORTING
          eo_data_tab = DATA(lo_data_tab)
      ).
      IF lo_data_tab IS BOUND.
        ASSIGN lo_data_tab->* TO <lt_data>.
        IF sy-subrc IS INITIAL AND <lt_data> IS ASSIGNED.
          lt_zidentity_cur_data = <lt_data>.
        ENDIF.
      ENDIF.
      IF lv_file_t EQ 'A'.
        READ TABLE lt_zidentity_cur_data WITH KEY zid_type = 'ZAD000' INTO DATA(ls_identity_adhr_data).
        IF sy-subrc IS INITIAL.
          DATA(lv_adhar_exist) = abap_true.
        ENDIF.
      ELSEIF lv_file_t EQ 'P'.
        READ TABLE lt_zidentity_cur_data WITH KEY zid_type = 'ZPK000' INTO DATA(ls_identity_pan_data).
        IF sy-subrc IS INITIAL.
          DATA(lv_pan_exist) = abap_true.
        ENDIF.
      ENDIF.
      CALL METHOD io_model->create_data_reference
        EXPORTING
          i_fieldname = 'ZIDENTITY'
          i_struct    = 'KATTR'
          i_tabtype   = if_usmd_model_ext=>gc_tabtype_standard
        IMPORTING
          er_data     = DATA(lr_zidentity).

      IF lr_zidentity IS BOUND.
        ASSIGN lr_zidentity->* TO <lt_zidentity>.
        CREATE DATA lr_zidentity_data_struc LIKE LINE OF <lt_zidentity>.
        ASSIGN lr_zidentity_data_struc->* TO <ls_zidentity>.
      ENDIF.

      IF lv_pan_exist EQ abap_true.
        ls_identity_pan_data-zidnum = ls_file_data.
        APPEND ls_identity_pan_data TO lt_zidentity_data.
      ELSEIF lv_adhar_exist EQ abap_true.
        ls_identity_adhr_data-zidnum = ls_file_data.
        APPEND ls_identity_adhr_data TO lt_zidentity_data.
      ELSE.
        ls_identity-zgen_data = lv_bp_id.
        ls_identity-zidnum = ls_file_data.
        lv_identity = ls_file_data.
        IF lv_file_t EQ 'A'.
          ls_identity-zid_type = 'ZAD000'.
        ELSEIF lv_file_t EQ 'P'.
          ls_identity-zid_type = 'ZPK000'.
        ENDIF.
        ls_identity-zid_vfrom = sy-datum.
        APPEND ls_identity TO lt_zidentity_data.
      ENDIF.
      io_write_data->write_data(
            EXPORTING
              i_entity = 'ZIDENTITY'
              it_data  = lt_zidentity_data ).

      IF lv_identity IS INITIAL.
        SELECT * FROM zmdg_zx_api_swch INTO TABLE @DATA(lt_api_switch).
        IF sy-subrc IS INITIAL.
          READ TABLE lt_api_switch INTO DATA(ls_api_switch) INDEX 1.
          IF sy-subrc IS INITIAL.
            IF lv_file_t EQ 'A' AND ls_api_switch-adhaar_valid_act EQ abap_false.
              ls_message-msgty = 'I'.
              ls_message-msgid = 'ZMDG_MESSAGE'.
              ls_message-msgno = '005'.
              APPEND ls_message TO et_message_info.
              RETURN.
            ENDIF.
            IF lv_file_t EQ 'P' AND ls_api_switch-pan_valid_act EQ abap_false.

              ls_message-msgty = 'I'.
              ls_message-msgid = 'ZMDG_MESSAGE'.
              ls_message-msgno = '006'.
              APPEND ls_message TO et_message_info.
              RETURN.
            ENDIF.
          ELSE.
            ls_message-msgty = 'I'.
            ls_message-msgid = 'ZMDG_MESSAGE'.
            ls_message-msgno = '007'.
            APPEND ls_message TO et_message_info.
            RETURN.
          ENDIF.
        ELSE.
          ls_message-msgty = 'I'.
          ls_message-msgid = 'ZMDG_MESSAGE'.
          ls_message-msgno = '007'.
          APPEND ls_message TO et_message_info.
          RETURN.
        ENDIF.
        CHECK 1 = 2.
        validate_identity_info(
          EXPORTING
            iv_identity_number = lv_identity                " 30 Characters
          IMPORTING
            ev_request_status  = DATA(lv_request_status)
            ev_status          = DATA(lv_status)
            ev_holder_name     = DATA(lv_holder_name)
            ev_type            = DATA(lv_types)
            ev_reason_message  = DATA(lv_type)                 " 30 Characters
        ).
        IF lv_request_status EQ 'TRUE' AND lv_file_t EQ 'A'.
          ls_message-msgty = 'I'.
          ls_message-msgid = 'ZMDG_MESSAGE'.
          ls_message-msgno = '000'.
          APPEND ls_message TO et_message_info.
        ELSEIF lv_request_status EQ 'TRUE' AND lv_file_t EQ 'P'.
          ls_message-msgty = 'I'.
          ls_message-msgid = 'ZMDG_MESSAGE'.
          ls_message-msgno = '002'.
          APPEND ls_message TO et_message_info.
        ENDIF.
        IF lv_holder_name IS NOT INITIAL.
          SPLIT lv_holder_name AT space INTO TABLE DATA(lt_names).
          DATA(max_row) = lines( lt_names ).
          READ TABLE lt_names INTO DATA(lv_first_name) INDEX 1.
          READ TABLE lt_names INTO DATA(lv_last_name) INDEX max_row.

          READ TABLE lt_zgen_data ASSIGNING FIELD-SYMBOL(<ls_zgen_data>) INDEX 1.
          IF sy-subrc IS INITIAL AND <ls_zgen_data> IS ASSIGNED.
            <ls_zgen_data>-zfir_name = lv_first_name.
            <ls_zgen_data>-zfir_last = lv_last_name.
          ENDIF.
          io_write_data->write_data(
            EXPORTING
              i_entity = 'ZGEN_DATA'
              it_data  = lt_zgen_data ).
        ENDIF.
      ENDIF.
    ENDIF.

    ""REMOVE FILE FROM APP SERVER AFTER PROCESSING
    remove_file_from_app_server( ev_file_path = lv_file_path ).
  ENDMETHOD.


  METHOD read_entity.
    DATA lif_model     TYPE REF TO if_usmd_model_ext.
    DATA lts_sel       TYPE        usmd_ts_sel.
    DATA lts_objlist   TYPE        usmd_t_crequest_entity.
    DATA lo_data_tab  TYPE REF TO data.

    FIELD-SYMBOLS <lt_data> TYPE ANY TABLE.

    DATA(lv_crequest) = iv_crequest.
    IF lv_crequest IS INITIAL.
      RETURN.
    ENDIF.
    CLEAR eo_data_tab.
    cl_usmd_model_ext=>get_instance(
      EXPORTING i_usmd_model = 'ZX'
      IMPORTING eo_instance  = lif_model ).
    lts_sel = VALUE #( ( fieldname = usmd0_cs_fld-crequest
                        sign      = 'I'
                        option    = 'EQ'
                        low       = iv_crequest ) ).

    lif_model->read_char_value(
      EXPORTING i_fieldname       = usmd0_cs_fld-crequest
                it_sel            = lts_sel
                if_use_edtn_slice = abap_false
      IMPORTING et_data           = lts_objlist ).

    lif_model->create_data_reference(
      EXPORTING i_fieldname = iv_entity && ''
                i_struct    = if_usmd_model=>gc_struct_key_attr
                i_tabtype   = if_usmd_model=>gc_tabtype_standard
      IMPORTING er_data     = lo_data_tab ).

    ASSIGN lo_data_tab->* TO <lt_data>.
    IF <lt_data> IS  NOT ASSIGNED.
      RETURN.
    ENDIF.
    LOOP AT lts_objlist INTO DATA(ls_objlist).
      CHECK ls_objlist-usmd_entity = 'ZGEN_DATA'.

      INSERT VALUE #( fieldname = 'ZGEN_DATA'
                      sign      = 'I'
                      option    = 'EQ'
                      low       = ls_objlist-usmd_value )
       INTO TABLE lts_sel.
    ENDLOOP.
    lif_model->read_char_value(
      EXPORTING i_fieldname       = iv_entity && ''
                it_sel            = lts_sel
                i_readmode        = iv_readmode
                if_use_edtn_slice = abap_false
      IMPORTING et_data           = <lt_data> ).

    eo_data_tab = lo_data_tab.
  ENDMETHOD.


  METHOD remove_file_from_app_server.

    DATA: lv_file_name TYPE epsf-epsfilnam,
          lv_directory TYPE epsf-epsdirnam VALUE '/hana/log/Python_MDG_Files',
          lv_filename  TYPE string.

    lv_filename = ev_file_path.

    REPLACE ALL OCCURRENCES OF '/hana/log/Python_MDG_Files/' IN lv_filename WITH space.

    CONDENSE lv_filename.

    lv_file_name = lv_filename.

    IF lv_filename IS NOT INITIAL.
      CALL FUNCTION 'EPS_DELETE_FILE'
        EXPORTING
          file_name              = lv_file_name
*         IV_LONG_FILE_NAME      =
          dir_name               = lv_directory
*         IV_LONG_DIR_NAME       =
*       IMPORTING
*         FILE_PATH              =
*         EV_LONG_FILE_PATH      =
        EXCEPTIONS
          invalid_eps_subdir     = 1
          sapgparam_failed       = 2
          build_directory_failed = 3
          no_authorization       = 4
          build_path_failed      = 5
          delete_failed          = 6
          OTHERS                 = 7.
      IF sy-subrc <> 0.
* Implement suitable error handling here
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD upload_file_to_app_server.
    DATA: lv_file_name      TYPE eps2filnam,
          lv_directory      TYPE epsf-epsdirnam VALUE '/hana/log/Python_MDG_Files/',
          lv_filename       TYPE string,
          lv_long_directory TYPE eps2path,
          lo_exc            TYPE REF TO cx_root,
          lv_arch_path      TYPE string,
          lv_filelength     TYPE i,
          lv_error          TYPE string,
          lt_data           TYPE REF TO data,
          lv_filecontent    TYPE c,
          lt_filecontent    TYPE string,
          lv_count          TYPE i VALUE 0,
          ls_solix          TYPE solix-line,
          lt_solix_tab      TYPE TABLE OF solix-line..
    FIELD-SYMBOLS : <ls_file> TYPE c.

    DATA(lo_context) = cl_usmd_app_context=>get_context( ).
    CHECK lo_context IS BOUND.
    CALL METHOD lo_context->get_attributes
      IMPORTING
        ev_crequest_type = DATA(lv_request_type)
        ev_crequest_id   = DATA(lv_request_id).

    TRY.
        DATA(lo_gov_api) = cl_usmd_conv_som_gov_api=>get_instance(
                             iv_model_name = 'ZX'
                             iv_classname  = 'CL_USMD_GOV_API'
                            ).
        CHECK lo_gov_api IS BOUND.
        DATA(lt_attachment) = lo_gov_api->get_attachment_list( if_with_content = 'X' ).

        LOOP AT lt_attachment INTO DATA(ls_attachment).
          CALL FUNCTION 'SCMS_XSTRING_TO_BINARY'
            EXPORTING
              buffer        = ls_attachment-usmd_content
*             APPEND_TO_TABLE       = ' '
            IMPORTING
              output_length = lv_filelength
            TABLES
              binary_tab    = lt_solix_tab.

          CONCATENATE lv_directory lv_request_id '_' ls_attachment-usmd_title INTO lv_filename. "For Deletion of File
          TRY.
              OPEN DATASET lv_filename FOR OUTPUT IN BINARY MODE.
              IF sy-subrc = 0.
                LOOP AT lt_solix_tab INTO ls_solix.

                  TRANSFER ls_solix TO lv_filename.
                ENDLOOP.
              ENDIF.
            CATCH cx_sy_conversion_codepage INTO lo_exc.
          ENDTRY.
          CLOSE DATASET lv_filename.
          ev_file_path = lv_filename.
          CLEAR: ls_attachment, lv_filename, lt_solix_tab.
        ENDLOOP.
      CATCH cx_usmd_gov_api_core_error ##NO_HANDLER. " CX_USMD_CORE_DYNAMIC_CHECK
      CATCH cx_usmd_gov_api ##NO_HANDLER. " General Processing Error GOV_API
    ENDTRY.

  ENDMETHOD.


  METHOD validate_identity_info.

    DATA(lv_dentity) = condense( iv_identity_number ).
    DATA(lv_identity_len) =  strlen( lv_dentity ).

    CASE lv_identity_len.
      WHEN 10.
        zcl_validate_pan=>validate_pan(
          EXPORTING
            iv_pan_number      = lv_dentity
          IMPORTING
            ev_request_status  = ev_request_status
            ev_pan_status      = ev_status
            ev_pan_holder_name = ev_holder_name
            ev_pan_type        = ev_type
            ev_reason_message  = ev_reason_message
        ).
      WHEN 12.
        zcl_validate_pan=>validate_aadhaar(
          EXPORTING
            iv_aadhar_number      = lv_dentity
          IMPORTING
            ev_request_status     = ev_request_status
            ev_aadhar_status      = ev_status
            ev_aadhar_holder_name = ev_holder_name
            ev_aadhar_type        = ev_type
            ev_reason_message     = ev_reason_message
        ).
      WHEN OTHERS.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.
