*&---------------------------------------------------------------------*
*& Report ZFILE_ENCRYPTION
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zfile_encryption.

PARAMETERS:
  p_path TYPE string OBLIGATORY.

*----------------------------------------------------------------------*
*       CLASS lcl_encryption DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_encryption DEFINITION.

  PUBLIC SECTION.

    CLASS-METHODS:
      select_file,
      upload_file
        RAISING cx_bcs,
      encrypt_file,
      send_email.

    CONSTANTS:
      c_filepath TYPE string VALUE '/hana/log/Python_MDG_Files/encrypt.txt'.

  PRIVATE SECTION.

    CLASS-DATA:
      v_data TYPE xstring,
      v_key  TYPE xstring.

ENDCLASS.                    "lcl_encryption DEFINITION

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_path.

START-OF-SELECTION.
  TRY.
      "Upload file
      lcl_encryption=>upload_file( ).

      "Encrypted file
      lcl_encryption=>encrypt_file( ).
    CATCH cx_bcs.
  ENDTRY.

*----------------------------------------------------------------------*
*       CLASS lcl_test IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_encryption IMPLEMENTATION.

  METHOD select_file.

    DATA:
      lt_file TYPE filetable,
      ls_file TYPE file_table,
      lv_rc   TYPE i.

    CALL METHOD cl_gui_frontend_services=>file_open_dialog
      CHANGING
        file_table              = lt_file
        rc                      = lv_rc
      EXCEPTIONS
        file_open_dialog_failed = 1
        cntl_error              = 2
        error_no_gui            = 3
        not_supported_by_gui    = 4
        OTHERS                  = 5.

    IF sy-subrc EQ 0.

      READ TABLE lt_file INTO ls_file INDEX 1.

      IF sy-subrc EQ 0.
        p_path = ls_file.
      ENDIF.

    ENDIF.

  ENDMETHOD.                    "upload_file

  METHOD upload_file.

    DATA:
      lt_data TYPE string_t,
      lv_data TYPE string,
      lv_str  TYPE string.

    CLEAR v_data.

    lv_data = p_path.

    "Convert to xstring
    v_data = cl_bcs_convert=>string_to_xstring(
      iv_string = lv_data    " Input data
     ).

  ENDMETHOD.                    "upload_file

  METHOD encrypt_file.

    DATA:
      lt_str TYPE string_t,
      lv_str TYPE string,
      lv_msg TYPE xstring.

    v_key = cl_sec_sxml_writer=>generate_key( algorithm = cl_sec_sxml_writer=>co_aes128_algorithm  ).

    "encrypt using AES256
    cl_sec_sxml_writer=>encrypt(
      EXPORTING
        plaintext =  v_data
        key       =  v_key
        algorithm =  cl_sec_sxml_writer=>co_aes128_algorithm
      IMPORTING
        ciphertext = lv_msg ).

    lv_str = lv_msg.

    "Send email
    send_email( ).

    MESSAGE 'File saved in AL11' TYPE 'I'.

  ENDMETHOD.                    "encrypt_file

  METHOD send_email.

    CONSTANTS:
      lc_subject TYPE so_obj_des VALUE 'Encryption key',
      lc_raw     TYPE char03     VALUE 'RAW'.

    DATA:
      lr_send_request  TYPE REF TO cl_bcs,
      lr_bcs_exception TYPE REF TO cx_bcs,
      lr_recipient     TYPE REF TO if_recipient_bcs,
      lr_sender        TYPE REF TO cl_sapuser_bcs,
      lr_document      TYPE REF TO cl_document_bcs.

    DATA:
      lv_mlrec       TYPE so_obj_nam,
      lv_sent_to_all TYPE os_boolean,
      lv_email       TYPE adr6-smtp_addr,
      lv_subject     TYPE so_obj_des,
      lv_str         TYPE string,
      lv_text        TYPE bcsy_text.

    TRY.

        "Create send request
        lr_send_request = cl_bcs=>create_persistent( ).

        "Email FROM...
        lr_sender = cl_sapuser_bcs=>create( 'SAP_WFRT' ).

        "Add sender to send request
        CALL METHOD lr_send_request->set_sender
          EXPORTING
            i_sender = lr_sender.

        "Email TO...
        lv_email = 'nikhsinha@deloitte.com'.

        lr_recipient = cl_cam_address_bcs=>create_internet_address( lv_email ).

        "Add recipient to send request
        CALL METHOD lr_send_request->add_recipient
          EXPORTING
            i_recipient = lr_recipient
            i_express   = 'X'.

        "Email BODY
        lv_str = |Encryption key :{ v_key }|.

        APPEND lv_str TO lv_text.

        lr_document = cl_document_bcs=>create_document(
            i_type    = lc_raw
            i_text    = lv_text
            i_length  = '12'
            i_subject = lc_subject ).

        "Add document to send request
        CALL METHOD lr_send_request->set_document( lr_document ).

        "Send email
        CALL METHOD lr_send_request->send(
          EXPORTING
            i_with_error_screen = 'X'
          RECEIVING
            result              = lv_sent_to_all ).

        IF lv_sent_to_all = 'X'.
          WRITE 'Email sent!'.
        ENDIF.

        "Commit to send email
        COMMIT WORK.

        "Exception handling
      CATCH cx_bcs INTO lr_bcs_exception.

        WRITE:
          'Error!',
          'Error type:',
          lr_bcs_exception->error_type.

    ENDTRY.

  ENDMETHOD.                    "send_email

ENDCLASS.                    "lcl_test IMPLEMENTATION
