FUNCTION YZ_FUNC_APP_LOG_CREATE.
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(BALHDRI) LIKE  BALHDRI STRUCTURE  BALHDRI
*"     VALUE(IV_LOG_HANDLE) TYPE  BALLOGHNDL OPTIONAL
*"     VALUE(IV_BAL_MSG) TYPE  BAL_S_MSG OPTIONAL
*"     VALUE(IV_FREE_TEXT) TYPE  C OPTIONAL
*"  EXPORTING
*"     VALUE(EV_LOG_HANDLE) TYPE  BALLOGHNDL
*"  TABLES
*"      MESSAGES STRUCTURE  BALMI
*"--------------------------------------------------------------------
  DATA: lf_obj        TYPE balobj_d,
        lf_subobj     TYPE balsubobj,
        ls_header     TYPE balhdri,
        ls_log_handle1 TYPE balloghndl,
        ls_log_handle2 TYPE balloghndl,
        lf_log_number TYPE balognr,
        lt_msg        TYPE balmi_tab,
        ls_msg        TYPE balmi,
        lt_lognum     TYPE TABLE OF balnri,
        ls_lognum     TYPE balnri.
**
* Header information for the log
  ls_header-object     = balhdri-object.
  ls_header-subobject  = balhdri-subobject.
*  ls_log_handle1        = log_handle.

  ls_header-aldate     = sy-datum.
  ls_header-altime     = sy-uzeit.
  ls_header-aluser     = sy-uname.
  ls_header-aldate_del = sy-datum + 1.
*
* Get the Log handle using the header
  CALL FUNCTION 'APPL_LOG_WRITE_HEADER'
    EXPORTING
      header              = ls_header
      log_handle          = iv_log_handle
    IMPORTING
      e_log_handle        = ev_log_handle " ls_log_handle1
    EXCEPTIONS
      object_not_found    = 1
      subobject_not_found = 2
      error               = 3
      OTHERS              = 4.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.
*
* Get the next avaliable Log number
  CALL FUNCTION 'BAL_DB_LOGNUMBER_GET'
    EXPORTING
      i_client                 = sy-mandt
      i_log_handle             = ev_log_handle
    IMPORTING
      e_lognumber              = lf_log_number
    EXCEPTIONS
      log_not_found            = 1
      lognumber_already_exists = 2
      numbering_error          = 3
      OTHERS                   = 4.

"Add custom fields to the Application Log if required
  IF iv_bal_msg IS NOT INITIAL.
  call function 'BAL_LOG_MSG_ADD'
    exporting
      i_s_msg      = iv_bal_msg
      i_log_handle = ev_log_handle.
  ENDIF.
  IF iv_free_text IS NOT INITIAL.
    CALL FUNCTION 'BAL_LOG_MSG_ADD_FREE_TEXT'
         EXPORTING
              I_LOG_HANDLE  = ev_log_handle
              i_msgty       = 'S'
              i_text        = iv_free_text
         EXCEPTIONS
              LOG_NOT_FOUND = 0
              OTHERS        = 1.
  ENDIF.

* Write the Log mesages to the memory
  CALL FUNCTION 'APPL_LOG_WRITE_MESSAGES'
    EXPORTING
      object              = balhdri-object
      subobject           = balhdri-subobject
      log_handle          = ev_log_handle
    TABLES
      messages            = messages
    EXCEPTIONS
      object_not_found    = 1
      subobject_not_found = 2
      OTHERS              = 3.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.
*
* write the log message to Database which can be later analyzed
* from transaction SLG1
  MOVE-CORRESPONDING ls_header TO ls_lognum.
  ls_lognum-lognumber = lf_log_number.
  APPEND ls_lognum TO lt_lognum.
*
  CALL FUNCTION 'APPL_LOG_WRITE_DB'
    EXPORTING
      object                = lf_obj
      subobject             = lf_subobj
      log_handle            = ev_log_handle
      update_task           = abap_true
    TABLES
      object_with_lognumber = lt_lognum
    EXCEPTIONS
      object_not_found      = 1
      subobject_not_found   = 2
      internal_error        = 3
      OTHERS                = 4.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.


ENDFUNCTION.
