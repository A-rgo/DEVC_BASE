FUNCTION yz_func_yb_bank.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(LT_BANK) TYPE  YBNK_TT_TXI_BNKA
*"     VALUE(LT_ADDR) TYPE  YBNK_TT_BAPIADDR1 OPTIONAL
*"     VALUE(IV_CREATE) TYPE  BOOLEAN OPTIONAL
*"     VALUE(IV_CHANGE) TYPE  BOOLEAN OPTIONAL
*"     VALUE(IV_DELETE) TYPE  BOOLEAN OPTIONAL
*"     VALUE(IV_ADDRESSX) TYPE  BAPI1011_ADDRESSX OPTIONAL
*"     VALUE(IV_DETAILX) TYPE  BAPI1011_DETAILX OPTIONAL
*"     VALUE(IV_ADDRESS1X) TYPE  BAPIADDR1X OPTIONAL
*"     VALUE(IV_BANK_CTRY) TYPE  BANKS OPTIONAL
*"     VALUE(IV_BANK_KEY) TYPE  BANKK OPTIONAL
*"----------------------------------------------------------------------
  DATA : ls_address TYPE bapi1011_address.
*  DATA : ls_address TYPE YBAPI1011_ADDRESS.
  DATA : ls_advance_addr TYPE bapiaddr1.
  DATA : ls_detail TYPE bapi1011_detail.
  DATA : ls_detailx TYPE bapi1011_detailx.
  DATA : ls_addressx TYPE bapi1011_addressx.
  DATA : ls_address1x TYPE bapiaddr1x.
  DATA : ls_return TYPE bapiret2."TECHNICAL_TYPE
  DATA : lt_message TYPE mdg_bs_mat_t_mat_msg.
  DATA : lw_message LIKE LINE OF lt_message.
  DATA: lw_adrnum TYPE adrc-addrnumber.

  IF iv_create EQ abap_true. " Bank Create + Address Create
    LOOP AT lt_bank INTO DATA(ls_bank).
      ls_address-bank_branch = ls_bank-brnch.
      ls_address-bank_group  = ls_bank-bgrup.
      ls_address-bank_name   = ls_bank-banka.
      ls_address-bank_no     = ls_bank-bnklz.
      ls_address-city        = ls_bank-ort01.
      ls_address-pobk_curac  = ls_bank-xpgro.
      ls_address-region      = ls_bank-provz.
      ls_address-street      = ls_bank-stras.
      ls_address-swift_code  = ls_bank-swift.
*     ---------------------Advance Address----------------
      READ TABLE lt_addr ASSIGNING FIELD-SYMBOL(<ls_addr>) INDEX 1.
      IF <ls_addr> IS  ASSIGNED AND sy-subrc = 0.
        MOVE-CORRESPONDING <ls_addr> TO ls_advance_addr.
      ENDIF.
*     -----------------------------------------------------
*      CALL FUNCTION 'YZ_FUNC_YB_ADDR'
*        EXPORTING
*          iv_bank_ctry     = ls_bank-banks                 " Country/Region Key of Bank
*          iv_bank_key      = ls_bank-bankl                  " Bank Keys
*          iv_bank_address1 = ls_advance_addr                  " BAPI Reference Structure for Addresses (Org./Company)
*        IMPORTING
*          ev_addr_num      = lw_adrnum.                " Address Number
*      ls_address-addr_no = lw_adrnum.

      CALL FUNCTION 'BAPI_BANK_CREATE'
        EXPORTING
          bank_ctry     = ls_bank-banks
          bank_key      = ls_bank-bankl
          bank_address  = ls_address
          bank_address1 = ls_advance_addr
*         i_xupdate     = abap_false
        IMPORTING
          return        = ls_return.
      CLEAR: ls_address.
    ENDLOOP.
  ELSEIF iv_change = abap_true. " For Change Scenario
    IF ( lt_bank IS NOT INITIAL ).
      LOOP AT lt_bank INTO ls_bank.
        ls_address-bank_branch = ls_bank-brnch.
        ls_address-bank_group  = ls_bank-bgrup.
        ls_address-bank_name   = ls_bank-banka.
        ls_address-bank_no     = ls_bank-bnklz.
        ls_address-city        = ls_bank-ort01.
        ls_address-pobk_curac  = ls_bank-xpgro.
        ls_address-region      = ls_bank-provz.
        ls_address-street      = ls_bank-stras.
        ls_address-swift_code  = ls_bank-swift.
        ls_address-addr_no     = ls_bank-adrnr.

        ls_detail-bank_delete  = ls_bank-loevm.

        ls_addressx = iv_addressx.
        ls_detailx = iv_detailx.
        ls_address1x = iv_address1x.
        READ TABLE lt_addr ASSIGNING <ls_addr> INDEX 1.
        IF <ls_addr> IS  ASSIGNED AND sy-subrc = 0.
          MOVE-CORRESPONDING <ls_addr> TO ls_advance_addr.
        ENDIF.
        IF ls_advance_addr-addr_no CS '$'. " For Change scenario; if Address Insert then Adrno should be blank
          ls_advance_addr-addr_no = space.
        ENDIF.
        CALL FUNCTION 'BAPI_BANK_CHANGE'
          EXPORTING
            bankcountry    = ls_bank-banks                 " Bank Country Key
            bankkey        = ls_bank-bankl                " Bank Key
            bank_address   = ls_address                 " Bank Address Data
            bank_addressx  = ls_addressx                " X Bar for Address Data
            bank_detail    = ls_detail                 " Bank Detail Data
            bank_detailx   = ls_detailx                " X Detail Data Bar
            bank_address1  = ls_advance_addr
            bank_address1x = ls_address1x
          IMPORTING
            return         = ls_return.                 " Confirmations
        CLEAR: ls_detail.
      ENDLOOP.
    ELSEIF ( lt_bank IS INITIAL  AND lt_addr IS NOT INITIAL AND iv_address1x IS INITIAL ). " Address Insert Only
      READ TABLE lt_addr ASSIGNING <ls_addr> INDEX 1.
      IF <ls_addr> IS  ASSIGNED AND sy-subrc = 0.
        MOVE-CORRESPONDING <ls_addr> TO ls_advance_addr.
      ENDIF.
      ls_addressx = iv_addressx.
      IF ls_advance_addr-addr_no CS '$'. " For Change scenario; if Address Insert then Adrno should be blank
        ls_advance_addr-addr_no = space.
      ENDIF.
      CALL FUNCTION 'BAPI_BANK_CHANGE'
        EXPORTING
          bankcountry   = iv_bank_ctry               " Bank Country Key
          bankkey       = iv_bank_key               " Bank Key
          bank_address  = ls_address               " Bank Address Data
          bank_addressx = ls_addressx                " X Bar for Address Data
          bank_address1 = ls_advance_addr               " Address Data (BAS)
*         bank_address1x = ls_address1x                " X Bar for Address Data (BAS)
        IMPORTING
          return        = ls_return.                " Confirmations
    ELSEIF ( lt_bank IS INITIAL  AND lt_addr IS NOT INITIAL AND iv_address1x IS NOT INITIAL ). " Only Address Update
      READ TABLE lt_addr ASSIGNING <ls_addr> INDEX 1.
      IF <ls_addr> IS  ASSIGNED AND sy-subrc = 0.
        MOVE-CORRESPONDING <ls_addr> TO ls_advance_addr.
      ENDIF.
      ls_addressx = iv_addressx.
      ls_address1x = iv_address1x.
      IF ls_advance_addr-addr_no CS '$'. " For Change scenario; if Address Insert then Adrno should be blank
        ls_advance_addr-addr_no = space.
      ENDIF.
      CALL FUNCTION 'BAPI_BANK_CHANGE'
        EXPORTING
          bankcountry    = iv_bank_ctry               " Bank Country Key
          bankkey        = iv_bank_key               " Bank Key
          bank_address   = ls_address               " Bank Address Data
          bank_addressx  = ls_addressx                " X Bar for Address Data
          bank_address1  = ls_advance_addr               " Address Data (BAS)
          bank_address1x = ls_address1x                " X Bar for Address Data (BAS)
        IMPORTING
          return         = ls_return.                " Confirmations

    ENDIF.

  ELSEIF iv_delete = abap_true. " Mark For Delete Scenario
    IF ( lt_bank IS NOT INITIAL ).
      LOOP AT lt_bank INTO ls_bank.
        ls_address-bank_branch = ls_bank-brnch.
        ls_address-bank_group  = ls_bank-bgrup.
        ls_address-bank_name   = ls_bank-banka.
        ls_address-bank_no     = ls_bank-bnklz.
        ls_address-city        = ls_bank-ort01.
        ls_address-pobk_curac  = ls_bank-xpgro.
        ls_address-region      = ls_bank-provz.
        ls_address-street      = ls_bank-stras.
        ls_address-swift_code  = ls_bank-swift.
        ls_address-addr_no     = ls_bank-adrnr.
        ls_detail-bank_delete = ls_bank-loevm.
        ls_addressx = iv_addressx.
        ls_detailx = iv_detailx.
        CALL FUNCTION 'BAPI_BANK_CHANGE'
          EXPORTING
            bankcountry   = ls_bank-banks                 " Bank Country Key
            bankkey       = ls_bank-bankl                " Bank Key
            bank_address  = ls_address                 " Bank Address Data
            bank_addressx = ls_addressx                " X Bar for Address Data
            bank_detail   = ls_detail                 " Bank Detail Data
            bank_detailx  = ls_detailx                " X Detail Data Bar
          IMPORTING
            return        = ls_return.                 " Confirmations
        CLEAR: ls_detail.
      ENDLOOP.
    ENDIF.
  ENDIF.

ENDFUNCTION.
