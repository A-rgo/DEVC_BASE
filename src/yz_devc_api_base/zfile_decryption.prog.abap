*&---------------------------------------------------------------------*
*& Report ZFILE_DECRYPTION
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZFILE_DECRYPTION.

PARAMETERS:
  p_key TYPE string OBLIGATORY LOWER CASE,
  p_data TYPE string OBLIGATORY LOWER CASE.

*----------------------------------------------------------------------*
*       CLASS lcl_encryption DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_decryption DEFINITION.

  PUBLIC SECTION.

    CLASS-METHODS:
      read_file,
      decrypt_file,
      download_file.

    CONSTANTS:
      c_filepath TYPE string VALUE '\\PGRDEV\sapmnt\trans\encrypted_file.txt'.

  PRIVATE SECTION.

    CLASS-DATA:
      v_data      TYPE xstring,
      v_data_text TYPE string,
      v_key       TYPE xstring.

ENDCLASS.                    "lcl_encryption DEFINITION

START-OF-SELECTION.

  "Upload file
  lcl_decryption=>read_file( ).

  "Decryptfile
  lcl_decryption=>decrypt_file( ).

  "Download file
*  lcl_decryption=>download_file( ).

*----------------------------------------------------------------------*
*       CLASS lcl_test IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_decryption IMPLEMENTATION.

  METHOD read_file.

    DATA:
      lv_str  TYPE string,
      lv_data TYPE string.

    v_key = p_key.

    v_data = p_data.

  ENDMETHOD.                    "upload_file

  METHOD decrypt_file.

    DATA:
      lt_binary TYPE STANDARD TABLE OF x255.

    DATA:
      lv_message_decrypted TYPE xstring,
      lv_str               TYPE string,
      lv_length            TYPE i.

    "Decrypt message
    cl_sec_sxml_writer=>decrypt(
      EXPORTING
        ciphertext = v_data
        key       =  v_key
        algorithm =  cl_sec_sxml_writer=>co_aes128_algorithm
      IMPORTING
        plaintext =  lv_message_decrypted ).

  WRITE: lv_message_decrypted.
  ENDMETHOD.                    "upload_file

  METHOD download_file.

    DATA:
      lv_filename TYPE string,
      lv_path     TYPE string,
      lv_fullpath TYPE string,
      lt_string   TYPE string_t.

    "File save dialog
    CALL METHOD cl_gui_frontend_services=>file_save_dialog
      CHANGING
        filename                  = lv_filename
        path                      = lv_path
        fullpath                  = lv_fullpath
      EXCEPTIONS
        cntl_error                = 1
        error_no_gui              = 2
        not_supported_by_gui      = 3
        invalid_default_file_name = 4
        OTHERS                    = 5.

    APPEND v_data_text TO lt_string.

    CALL METHOD cl_gui_frontend_services=>gui_download
      EXPORTING
        filename                = lv_fullpath
        filetype                = 'ASC'
      CHANGING
        data_tab                = lt_string
      EXCEPTIONS
        file_write_error        = 1
        no_batch                = 2
        gui_refuse_filetransfer = 3
        invalid_type            = 4
        no_authority            = 5
        unknown_error           = 6
        header_not_allowed      = 7
        separator_not_allowed   = 8
        filesize_not_allowed    = 9
        header_too_long         = 10
        dp_error_create         = 11
        dp_error_send           = 12
        dp_error_write          = 13
        unknown_dp_error        = 14
        access_denied           = 15
        dp_out_of_memory        = 16
        disk_full               = 17
        dp_timeout              = 18
        file_not_found          = 19
        dataprovider_exception  = 20
        control_flush_error     = 21
        not_supported_by_gui    = 22
        error_no_gui            = 23
        OTHERS                  = 24.

  ENDMETHOD.                    "download_file

ENDCLASS.                    "lcl_test IMPLEMENTATION
