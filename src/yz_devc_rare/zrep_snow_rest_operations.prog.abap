*&---------------------------------------------------------------------*
*& Report ZREP_SNOW_REST_OPERATIONS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zrep_snow_rest_operations.

types: begin of lty_resp_data,
         number type string,
         sys_id type string,
       end of lty_resp_data.

types: begin of lty_data,
         caller_id         type string,
         category          type string,
         description       type string,
         short_description type string,
         urgency           type i,
         impact            type i,
         subcategory       type string,
         assignment_group  type string,
       end of lty_data.
types: begin of lty_response,
         result type lty_resp_data,
       end of lty_response.

data lt_errtab    type table of rpbenerr.

constants lc_cont_type  type string value 'Content-Type'.
constants lc_type_json  type string value 'application/json'.


class lcl_rest_operations definition.
  public section.

    data lo_rest_api        type ref to zss_consume_rest.
    data lo_client          type ref to if_http_client.
    data lo_rare_base       type ref to yz_clas_rare_base.

*    constants lc_base_url   type string value 'https://dev84748.service-now.com/api/now/'.
*    constants lc_inc_table  type string value 'table/incident'.
*    constants lc_attachment type string value 'attachment/file'.
*    constants lc_user       type string value 'admin'.
*    constants lc_password   type string value 'iVpW9jn6BF-!'.
    data gv_base_url        type string.
    data gv_username        type string.
    data gv_password        type string.
*    data gv_inc_table       type string.


    methods create_consume_rest_object exporting eo_obj type ref to zss_consume_rest.
    methods create_incident importing iw_data      type lty_data
                            exporting ew_resp_data type lty_response.
    methods attach_file_to_incident importing iv_file_data_bin type xstring
                                              iw_resp_data     type lty_response
                                              iv_file_path     type ibipparms-path.
    methods upload_file_in_binary importing iv_file_path     type ibipparms-path
                                  exporting ev_file_data_bin type xstring.
    methods get_subcatg_assign_grp importing iv_tcode type string
                                   exporting ev_sub_catg type string ev_assign_grp type string.

endclass.

class lcl_rest_operations implementation.
  method create_consume_rest_object.
    lo_rest_api = new zss_consume_rest( ).
    lo_rare_base = new yz_clas_rare_base( ).
  endmethod.
  method create_incident.
    gv_base_url = yz_clas_rare_base=>get_snow_base_url( ).
    data(lv_inc_table) = yz_clas_rare_base=>get_snow_url_incident_resource( ).

    lo_client = lo_rest_api->create_client(
      exporting
        url      = gv_base_url
        resource = lv_inc_table ).

    yz_clas_rare_base=>get_snow_auth_details(
      importing
        ev_user_id  = gv_username
        ev_password = gv_password
    ).

    lo_rest_api->set_authorization(
      exporting
        io_client   = lo_client
        iv_username = gv_username "'admin'
        iv_password = gv_password "'iVpW9jn6BF-!'
    ).

    lo_rest_api->set_header_field(
      exporting
        io_client = lo_client
        iv_name   = lc_cont_type "'Content-Type'
        iv_value  = lc_type_json "'application/json'
    ).
    data(lv_data) = /ui2/cl_json=>serialize( data = iw_data pretty_name = 'L' ).

    lo_rest_api->set_cdata(
      exporting
        io_client = lo_client
        iv_data   = lv_data
    ).

    lo_rest_api->send_request(
      exporting
        io_client                  = lo_client
      exceptions
        http_communication_failure = 1
        http_invalid_state         = 2
        http_processing_failed     = 3
        http_invalid_timeout       = 4
        others                     = 5
    ).
    if sy-subrc <> 0.
      message id sy-msgid type sy-msgty number sy-msgno
        with sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    else.
      lo_rest_api->get_response(
        exporting
          io_client                  = lo_client
        exceptions
          http_communication_failure = 1
          http_invalid_state         = 2
          http_processing_failed     = 3
          others                     = 4
      ).
      if sy-subrc <> 0.
        message id sy-msgid type sy-msgty number sy-msgno
          with sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      else.
        lv_data = lo_rest_api->get_response_data( io_client = lo_client ).
      endif.
    endif.
    call method /ui2/cl_json=>deserialize
      exporting
        json = lv_data
      changing
        data = ew_resp_data.


  endmethod.
  method attach_file_to_incident.
    data lv_full_path type char100.
    data lv_extension type char20.
    data lv_file_name type string.
    data lv_mime_type type w3conttype.
    data lt_params type zss_consume_rest=>url_param_tt.
    data lw_params type zss_consume_rest=>url_param.


    lv_full_path = iv_file_path.

    call function 'HRCZ_SPLIT_COMPLETE_FILENAME'
      exporting
        complete_filename = lv_full_path
      importing
*       DRIVE             =
        extension         = lv_extension
*       NAME              =
        name_with_ext     = lv_file_name
*       PATH              =
      exceptions
        invalid_drive     = 1
        invalid_extension = 2
        invalid_name      = 3
        invalid_path      = 4
        others            = 5.
    if sy-subrc <> 0.
      message id sy-msgid type sy-msgty number sy-msgno
        with sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    endif.

    call function 'SDOK_MIMETYPE_GET'
      exporting
        extension = lv_extension
      importing
        mimetype  = lv_mime_type.

    lt_params = value #( base lt_params ( key = 'table_name' value = 'incident' )
                                        ( key = 'table_sys_id' value = iw_resp_data-result-sys_id )"lw_data_resp-result-sys_id )
                                        ( key = 'file_name' value = lv_file_name ) ).


    data(lv_attachment) = yz_clas_rare_base=>get_snow_url_attach_resource( ).

    lo_client = lo_rest_api->create_client(
      exporting
        url       = gv_base_url
        resource  = lv_attachment
        url_param = lt_params ).

    lo_rest_api->set_authorization(
      exporting
        io_client   = lo_client
        iv_username = gv_username "'admin'
        iv_password = gv_password "'iVpW9jn6BF-!'
    ).
    lo_rest_api->set_header_field(
      exporting
        io_client = lo_client
        iv_name   = lc_cont_type
        iv_value  = conv #( lv_mime_type )
    ).

    lo_rest_api->set_data(
      exporting
        io_client = lo_client
        iv_data   = iv_file_data_bin "lv_data "'{ "short_description":"Unable to open mail" }'                 " Character data
    ).

    lo_rest_api->send_request(
      exporting
        io_client                  = lo_client
      exceptions
        http_communication_failure = 1
        http_invalid_state         = 2
        http_processing_failed     = 3
        http_invalid_timeout       = 4
        others                     = 5
    ).
    if sy-subrc <> 0.
      message id sy-msgid type sy-msgty number sy-msgno
        with sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    else.
      lo_rest_api->get_response(
        exporting
          io_client                  = lo_client
        exceptions
          http_communication_failure = 1
          http_invalid_state         = 2
          http_processing_failed     = 3
          others                     = 4
      ).
      if sy-subrc <> 0.
        message id sy-msgid type sy-msgty number sy-msgno
          with sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      else.
        data(lv_data) = lo_rest_api->get_response_data( io_client = lo_client ).
        write lv_data.
      endif.
    endif.
  endmethod.
  method upload_file_in_binary.
    types: begin of lty_itab,
             raw(255) type x,
           end of lty_itab .
    data lt_itab type table of lty_itab.
    data lv_file_name type string.
    data lv_data_string type string.
    call method cl_gui_cfw=>flush( ).
    cl_gui_frontend_services=>gui_upload(
      exporting
        filename                = conv #( iv_file_path )            " Name of file
        filetype                = 'BIN'            " Name of file
      changing
        data_tab                = lt_itab      " Transfer table for file contents
      exceptions
        file_open_error         = 1                " File does not exist and cannot be opened
        file_read_error         = 2                " Error when reading file
        no_batch                = 3                " Cannot execute front-end function in background
        gui_refuse_filetransfer = 4                " Incorrect front end or error on front end
        invalid_type            = 5                " Incorrect parameter FILETYPE
        no_authority            = 6                " No upload authorization
        unknown_error           = 7                " Unknown error
        bad_data_format         = 8                " Cannot Interpret Data in File
        header_not_allowed      = 9                " Invalid header
        separator_not_allowed   = 10               " Invalid separator
        header_too_long         = 11               " Header information currently restricted to 1023 bytes
        unknown_dp_error        = 12               " Error when calling data provider
        access_denied           = 13               " Access to file denied.
        dp_out_of_memory        = 14               " Not enough memory in data provider
        disk_full               = 15               " Storage medium is full.
        dp_timeout              = 16               " Data provider timeout
        not_supported_by_gui    = 17               " GUI does not support this
        error_no_gui            = 18               " GUI not available
        others                  = 19
    ).
    if sy-subrc <> 0.
      message id sy-msgid type sy-msgty number sy-msgno
        with sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    endif.

    lv_file_name = iv_file_path.
    call method cl_gui_frontend_services=>file_get_size
      exporting
        file_name = lv_file_name "conv #( p_file )
      importing
        file_size = data(filesize).

    call function 'GUI_GET_FILE_INFO'
      exporting
        fname          = iv_file_path
      importing
*       FILE_VERSION   =
*       FILE_DBGREL    =
*       FILE_LANG      =
        file_size      = filesize
      exceptions
        fileinfo_error = 1
        others         = 2.
    if sy-subrc <> 0.
* Implement suitable error handling here
    endif.

    call function 'SCMS_BINARY_TO_XSTRING'
      exporting
        input_length = filesize
      importing
        buffer       = ev_file_data_bin
      tables
        binary_tab   = lt_itab
      exceptions
        failed       = 1
        others       = 2.

    clear lv_data_string.

    call function 'SCMS_BASE64_ENCODE_STR'
      exporting
        input  = ev_file_data_bin
      importing
        output = lv_data_string.
    clear ev_file_data_bin.
    call function 'SSFC_BASE64_DECODE'
      exporting
        b64data                  = lv_data_string
      importing
        bindata                  = ev_file_data_bin
      exceptions
        ssf_krn_error            = 1
        ssf_krn_noop             = 2
        ssf_krn_nomemory         = 3
        ssf_krn_opinv            = 4
        ssf_krn_input_data_error = 5
        ssf_krn_invalid_par      = 6
        ssf_krn_invalid_parlen   = 7
        others                   = 8.
    if sy-subrc <> 0.
* Implement suitable error handling here
    endif.

  endmethod.
  method get_subcatg_assign_grp.
    select single sub_category assignment_grp
                from yztabl_rare_catg
                into ( ev_sub_catg, ev_assign_grp )
               where tcode = iv_tcode
                 and active = abap_true.
  endmethod.
endclass.


data lt_filetable type filetable.
data lv_rc        type i.
data lw_data      type lty_data.
data lw_resp_data type lty_response.
data lv_file_data type xstring.

selection-screen begin of block inc_det with frame title text-001.
  parameters: "p_inc type string,
    p_sdescr type string,
    p_urg    type i,
    p_descr  type string,
    p_impact type i,
    p_tcode  type string.
selection-screen end of block inc_det.

selection-screen begin of block file with frame title text-002.
  parameters: p_file type ibipparms-path.
selection-screen end of block file.



at selection-screen on value-request for p_file.
  call method cl_gui_frontend_services=>file_open_dialog
    exporting
      window_title = conv #( text-003 ) "'Select a file'
    changing
      file_table   = lt_filetable
      rc           = lv_rc.
  if sy-subrc = 0.
    read table lt_filetable into data(lw_file_table) index 1.
    p_file = lw_file_table-filename.
  endif.

initialization.
  data(lo_obj) = new lcl_rest_operations( ).

start-of-selection.

  lo_obj->create_consume_rest_object( ).

*  lw_data-short_description = p_descr.
*  lw_data-urgency           = p_urg.
*  lw_data-category          = 'sap_application'.
*  lw_data-subcategory       = 'O2C_SD_TEAM'.
*  lw_data-assignment_group  = 'SAP_O2C_TEAM'.
*  lw_data-caller_id         = 'rabhayani@deloitte.com'.

  lw_data-category          = 'sap_application'.
  lo_obj->get_subcatg_assign_grp(
    exporting
      iv_tcode      = CONV #( p_tcode )
    importing
      ev_sub_catg   = lw_data-assignment_group
      ev_assign_grp = lw_data-subcategory
  ).
  call function 'HR_FBN_GET_USER_EMAIL_ADDRESS'
    exporting
      user_id       = sy-uname
      reaction      = 'I'
    importing
      email_address = lw_data-caller_id
    tables
      error_table   = lt_errtab.

  lw_data-description = p_descr.
  lw_data-impact = p_impact.
  lw_data-short_description = p_sdescr.
  lw_data-urgency = p_urg.

  lo_obj->create_incident(
    exporting
      iw_data      = lw_data
    importing
      ew_resp_data = lw_resp_data
  ).



*  if lv_data is not initial.
  if p_file is not initial.
    lo_obj->upload_file_in_binary(
      exporting
        iv_file_path     = p_file
      importing
        ev_file_data_bin = lv_file_data
    ).

    lo_obj->attach_file_to_incident(
      exporting
        iv_file_data_bin = lv_file_data
        iw_resp_data     = lw_resp_data
        iv_file_path     = p_file
    ).
  endif.
*  endif.
