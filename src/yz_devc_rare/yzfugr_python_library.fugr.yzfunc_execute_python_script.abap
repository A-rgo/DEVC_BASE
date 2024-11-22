FUNCTION yzfunc_execute_python_script.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(I_INCLNAME) TYPE  SOBJ_NAME DEFAULT
*"       'YZINC_EXE_PY_SCRPT'
*"     REFERENCE(I_SCRIPTNAME) TYPE  STRING DEFAULT 'TEXT2IMAGE.PY'
*"     REFERENCE(I_FILENAME) TYPE  TEXT1024
*"  TABLES
*"      T_EXECPROT STRUCTURE  BTCXPGLOG
*"----------------------------------------------------------------------

  "-Variables-----------------------------------------------------------
  DATA lv_filename(255)        TYPE c.
  DATA lv_tadir                TYPE tadir.
  DATA lt_incl                 TYPE TABLE OF string.
  DATA lv_lineincl             TYPE string.
  DATA lv_strincl              TYPE string.
  DATA lv_status               TYPE extcmdexex-status.
  DATA lv_exitcode             TYPE extcmdexex-exitcode.

  "-Main----------------------------------------------------------------

  "-Gets directory path-----------------------------------------------
  CALL FUNCTION 'FILE_GET_NAME'
    EXPORTING
      client           = sy-mandt
      logical_filename = 'ZPYTHON'
      operating_system = sy-opsys
      parameter_1      = i_scriptname
      eleminate_blanks = 'X'
    IMPORTING
      file_name        = lv_filename
    EXCEPTIONS
      file_not_found   = 1
      OTHERS           = 2.

  IF sy-subrc <> 0.
    RAISE no_file_name.
  ENDIF.

  "-Gets script content-----------------------------------------------
  SELECT SINGLE * FROM tadir INTO lv_tadir
    WHERE obj_name = i_inclname.
  IF sy-subrc = 0.
    READ REPORT i_inclname INTO lt_incl.
    IF sy-subrc = 0.
      LOOP AT lt_incl INTO lv_lineincl.
        lv_strincl = lv_strincl && lv_lineincl &&
          cl_abap_char_utilities=>cr_lf.
        REPLACE '%FILE_PATH%' IN lv_strincl WITH i_filename.
      ENDLOOP.
    ENDIF.
  ELSE.
    RAISE no_include_available.
  ENDIF.

  "-Writes script-----------------------------------------------------
  OPEN DATASET lv_filename FOR OUTPUT IN TEXT MODE
    ENCODING NON-UNICODE WITH WINDOWS LINEFEED.
  IF sy-subrc = 0.
    TRANSFER lv_strincl TO lv_filename.
    CLOSE DATASET lv_filename.
  ELSE.
    RAISE can_not_write_script.
  ENDIF.

  "-Executes script---------------------------------------------------
  CALL FUNCTION 'SXPG_STEP_COMMAND_START'
    EXPORTING
      commandname                = 'ZPYTHON'
      additional_parameters      = lv_filename
      operatingsystem            = sy-opsys
      stdincntl                  = 'R'
      stdoutcntl                 = 'M'
      stderrcntl                 = 'M'
      tracecntl                  = '0'
      termcntl                   = 'C'
    TABLES
      log                        = t_execprot
    EXCEPTIONS
      command_not_found          = 1
      parameter_expected         = 2
      parameters_too_long        = 3
      security_risk              = 4
      wrong_check_call_interface = 5
      no_permission              = 6
      unknown_error              = 7
      communication_error        = 8
      system_error               = 9
      cannot_get_rfc_dests       = 10
      job_update_failed          = 11
      job_does_not_exist         = 12
      program_start_error        = 13
      OTHERS                     = 14.

  IF sy-subrc <> 0.
    RAISE error_in_script_execution.
  ENDIF.

  "-Deletes script----------------------------------------------------
  DELETE DATASET lv_filename.
  IF sy-subrc <> 0.
    RAISE can_not_delete_script.
  ENDIF.
ENDFUNCTION.
