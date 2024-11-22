FUNCTION yz_func_yb_addr.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_BANK_CTRY) TYPE  BANKS
*"     VALUE(IV_BANK_KEY) TYPE  BANKK
*"     VALUE(IV_BANK_ADDRESS1) TYPE  BAPIADDR1
*"  EXPORTING
*"     VALUE(EV_ADDR_NUM) TYPE  AD_ADDRNUM
*"----------------------------------------------------------------------
  DATA: object_id TYPE swotobjid-objkey. "Object-ID for CAM (ZAV)
  DATA: bank_address_zav TYPE szadr_addr1_complete OCCURS 1
                                          WITH HEADER LINE,
        addr_ref         LIKE addr_ref,
        error_table      LIKE addr_error OCCURS 0 WITH HEADER LINE.
  DATA: returncode LIKE szad_field-returncode.
  DATA: return LIKE  bapiret2.
  DATA: BEGIN OF addr_handle OCCURS 0.
          INCLUDE STRUCTURE addr1_dia.
  DATA: END OF addr_handle.

  object_id = sy-mandt.
  object_id+3 = iv_bank_ctry.
  object_id+6 = iv_bank_key.

* Conversion from external to internal structure
* bank_address1-addr_no = space.
  iv_bank_address1-addr_no = space.
  CALL FUNCTION 'ADDR_CONVERT_FROM_BAPIADDR1'
    EXPORTING
      addr1_complete_bapi = iv_bank_address1
    IMPORTING
      addr1_complete      = bank_address_zav.

  bank_address_zav-addrhandle = object_id.
  MODIFY bank_address_zav INDEX 1.


**  * Complete the address
*  CALL FUNCTION 'ADDR_MAINTAIN_COMPLETE'
*    EXPORTING
*      updateflag        = 'I'
*      addr1_complete    = bank_address_zav
*      address_group     = 'CA02'
*    IMPORTING
*      returncode        = returncode
*    TABLES
*      error_table       = error_table
*    EXCEPTIONS
*      parameter_error   = 1
*      address_not_exist = 2
*      handle_exist      = 3
*      internal_error    = 4
*      OTHERS            = 5.
*  IF sy-subrc <> 0.
**    PERFORM set_return_message USING sy-msgty sy-msgid sy-msgno
**                                     sy-msgv1 sy-msgv2
**                                     sy-msgv3 sy-msgv4
**                            CHANGING return.
*  ELSEIF returncode EQ 'E'.
*    READ TABLE error_table INDEX 1.
**    PERFORM set_return_message USING error_table-msg_type
**                                     error_table-msg_id
**                                     error_table-msg_number
**                                     error_table-msg_var1
**                                     error_table-msg_var2
**                                     error_table-msg_var3
**                                     error_table-msg_var4
**                            CHANGING return.
*  ENDIF.
*  CHECK return-type CO 'WIS '.

  addr_handle-handle     = object_id.
  addr_handle-nation     = 'A'.
  addr_ref-appl_table = 'BNKA'.
  addr_ref-appl_field = 'ADRNR'.
  addr_ref-appl_key   = object_id.
  addr_ref-addr_group = 'CA02'.
  addr_ref-owner      = 'X'.
  DATA: ls_addr TYPE addr1_data.
  ls_addr-name1 = iv_bank_address1-name.
  ls_addr-langu = iv_bank_address1-langu.
  ls_addr-post_code1 = iv_bank_address1-postl_cod1.
  ls_addr-region = iv_bank_address1-region.
  ls_addr-country = iv_bank_address1-country.


  CALL FUNCTION 'ADDR_INSERT'
    EXPORTING
      address_data        = ls_addr
      address_group       = 'CA02'                 " Address group (key)
      address_handle      = addr_handle-handle              " Address handle (temporary key)
*     date_from           = '00010101'
      language            = sy-langu
      check_empty_address = 'X'
      check_address       = ' '              " Flag: Check address contents
*         IMPORTING
*     address_data        =
*     returncode          =
*         TABLES
*     error_table         =                  " Table with errors, warnings, information
    EXCEPTIONS
      address_exists      = 1
      parameter_error     = 2                " Incorrect parameter values
      internal_error      = 3                " Serious internal error (MESSAGE A...)
      OTHERS              = 4.
  IF sy-subrc <> 0.
*        MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*          WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.



*  * Get address number from CAM (Zentrale Adreßverwaltung)
  CALL FUNCTION 'ADDR_NUMBER_GET'
    EXPORTING
      address_handle           = addr_handle-handle
      address_reference        = addr_ref
      owner                    = 'X'
    IMPORTING
      address_number           = ev_addr_num
    EXCEPTIONS
      address_handle_not_exist = 1
      internal_error           = 2
      parameter_error          = 3
      OTHERS                   = 4.

  IF sy-subrc <> 0.
*    PERFORM set_return_message USING sy-msgty sy-msgid sy-msgno
*                                     sy-msgv1 sy-msgv2
*                                     sy-msgv3 sy-msgv4
*                            CHANGING return.
  ENDIF.


* Save address

  CALL FUNCTION 'ADDR_MEMORY_SAVE'
    EXPORTING
      execute_in_update_task = abap_false
    EXCEPTIONS
      address_number_missing = 1
      OTHERS                 = 6.
  IF sy-subrc <> 0.
*    PERFORM set_return_message USING sy-msgty sy-msgid sy-msgno
*                                     sy-msgv1 sy-msgv2
*                                     sy-msgv3 sy-msgv4
*                            CHANGING return.
  ELSE.
*     CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'.
  ENDIF.

  CALL FUNCTION 'ADDR_MEMORY_CLEAR'
    EXPORTING
      force              = abap_true
    EXCEPTIONS
      unsaved_data_exist = 1
      internal_error     = 2
      OTHERS             = 3.
  IF sy-subrc <> 0.
*    es_return-type = /aci/if_aci_declarations=>sc_mtype_e.
    RETURN.
  ENDIF.

ENDFUNCTION.
