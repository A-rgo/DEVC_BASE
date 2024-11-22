FUNCTION YZ_FUNC_COPY_CHANGE_REQUEST.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_CREQUEST) TYPE  USMD_CREQUEST
*"     VALUE(IV_RFCDEST) TYPE  RFCDEST OPTIONAL
*"     VALUE(IV_CRTYPE) TYPE  USMD_CREQUEST_TYPE OPTIONAL
*"  EXPORTING
*"     VALUE(EV_CREQUEST) TYPE  USMD_CREQUEST
*"     VALUE(ET_MESSAGE) TYPE  USMD_T_MESSAGE
*"----------------------------------------------------------------------
  DATA:
    lt_message      TYPE usmd_t_message,
    lo_crequest_api TYPE REF TO if_usmd_crequest_api,
    lt_attribute    TYPE usmd_ts_fieldname,
    ls_attribute    TYPE usmd_fieldname,
    lv_crequest_new TYPE usmd_crequest.

  CALL METHOD cl_usmd_crequest_api=>get_instance
    IMPORTING
      et_message           = lt_message
      re_inst_crequest_api = lo_crequest_api.

  IF et_message[] IS NOT INITIAL.
    et_message[] = lt_message[].
    RETURN.
  ENDIF.

  ls_attribute = if_usmd_crequest_api=>gcs_crequest_attribute-priority.
  INSERT ls_attribute INTO TABLE lt_attribute.
  ls_attribute = if_usmd_crequest_api=>gcs_crequest_attribute-due_date.
  INSERT ls_attribute INTO TABLE lt_attribute.
  ls_attribute = if_usmd_crequest_api=>gcs_crequest_attribute-reason.
  INSERT ls_attribute INTO TABLE lt_attribute.

  CALL METHOD lo_crequest_api->create_crequest_by_reference
    EXPORTING
      iv_reference_id       = iv_crequest
      iv_crequest_type      = iv_crtype
      it_crequest_attribute = lt_attribute
      if_attachments        = abap_true
      if_objectlist         = abap_true
      if_notes              = abap_true
    IMPORTING
      ev_crequest_id        = lv_crequest_new "New CR number
      et_message            = lt_message.

  IF lt_message[] IS NOT INITIAL.
    et_message[] = lt_message[].
    RETURN.
  ENDIF.

*  save the newly created cr
  CALL METHOD lo_crequest_api->save_crequest
    EXPORTING
      if_commit  = space
    IMPORTING
      et_message = lt_message.

  IF lt_message[] IS NOT INITIAL.
    et_message[] = lt_message[].
  ELSE.
    ev_crequest = lv_crequest_new.
  ENDIF.

ENDFUNCTION.
