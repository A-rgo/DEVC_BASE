class YZ_CLAS_MDG_YB_OB_CLASS definition
  public
  create public .

public section.

  interfaces IF_DRF_OUTBOUND .
protected section.

  class-data MT_BNKA_KEYS type YBNKA_DRF_TT_KEY_STRUCTURE .
private section.

  data MS_RUNTIME_PARAM type DRF_S_RUNTIME_PARAMETER_EXT .
ENDCLASS.



CLASS YZ_CLAS_MDG_YB_OB_CLASS IMPLEMENTATION.


  method IF_DRF_OUTBOUND~ANALYZE_CHANGES_BY_CHG_POINTER.
  endmethod.


  method IF_DRF_OUTBOUND~ANALYZE_CHANGES_BY_MDG_CP.
  endmethod.


  method IF_DRF_OUTBOUND~ANALYZE_CHANGES_BY_OTHERS.
  endmethod.


  method IF_DRF_OUTBOUND~APPLY_NODE_INST_FILTER_MULTI.
  endmethod.


  method IF_DRF_OUTBOUND~APPLY_NODE_INST_FILTER_SINGLE.
  endmethod.


  method IF_DRF_OUTBOUND~BUILD_PARALLEL_PACKAGE.
  endmethod.


  method IF_DRF_OUTBOUND~ENRICH_FILTER_CRITERIA.
  endmethod.


  method IF_DRF_OUTBOUND~FINALIZE.
  endmethod.


  METHOD if_drf_outbound~initialize.
    DATA: ls_runtime_param TYPE  drf_s_runtime_param_out_impl, lo_bnka TYPE REF TO yz_clas_mdg_yb_ob_class.

    TRY.
        CREATE OBJECT lo_bnka.
      CATCH cx_sy_create_object_error.
        EXIT.
    ENDTRY.

    IF lo_bnka IS BOUND.
      lo_bnka->ms_runtime_param = is_runtime_param.
    ENDIF.

    ls_runtime_param-table_type_name = 'YBNKA_DRF_TT_KEY_STRUCTURE'.
    es_runtime_param_out_impl = ls_runtime_param.
    eo_if_drf_outbound = lo_bnka.

  ENDMETHOD.


  METHOD if_drf_outbound~map_data2message.
    FIELD-SYMBOLS: <ls_bnka_key> TYPE ybnka_drf_s_key_structure.
    REFRESH : MT_bnka_keys.
    IF ir_relevant_object IS BOUND.
      ASSIGN ir_relevant_object->* TO <ls_bnka_key>.
      APPEND <ls_bnka_key> TO MT_bnka_keys.
    ENDIF.
  ENDMETHOD.


  method IF_DRF_OUTBOUND~READ_COMPLETE_DATA.
  endmethod.


  METHOD if_drf_outbound~send_message.
    DATA:
      it_sel          TYPE usmd_ts_sel,
      i_num_entries	  TYPE i,
      seg_bank_header TYPE edidd-segnam VALUE 'E1BANK_SAVEREPLICA',
      seg_addr_header TYPE edidd-segnum VALUE 'E1ADRMAS',
      lw_seg_address  TYPE e1bpad1vl,
      lw_seg_addr_tel TYPE e1bpadtel,
      lw_seg_addr_eml TYPE e1bpadsmtp,
      lw_seg_header   TYPE e1bank_savereplica,
      lw_addr_header1 TYPE e1adrmas,
      seg_bank_addr   TYPE edidd-segnam VALUE 'E1BP1011_ADDRESS',
      lw_seg_addr     TYPE e1bp1011_address,
      seg_bank_detail TYPE edidd-segnam VALUE 'E1BP1011_DETAIL',
      lw_seg_detail   TYPE e1bp1011_detail,
      lw_obj          TYPE drf_s_obj_rep_sta_attr,
      lt_edidd        TYPE STANDARD TABLE OF edidd,
      ls_edidd        TYPE edidd,
      lt_edidc        TYPE STANDARD TABLE OF edidc,
      ls_edidc        TYPE  edidc,
      lt_control_data TYPE STANDARD TABLE OF edidc.

*---------------------------------------------------------------------------------
    IF mt_bnka_keys IS NOT INITIAL.
      LOOP AT mt_bnka_keys INTO DATA(ls_bnka_keys) .
        it_sel = VALUE #( ( fieldname = 'Y_BANKS' sign = 'I' option = 'EQ' low = ls_bnka_keys-y_banks )
                          ( fieldname = 'Y_BANKL' sign = 'I' option = 'EQ' low = ls_bnka_keys-y_bankl ) ).
      ENDLOOP.
      SELECT sign,option,low,high FROM @it_sel AS lt_sel WHERE fieldname =: 'Y_BANKS' INTO TABLE @DATA(lrt_sel_banks),
                                                                            'Y_BANKL' INTO TABLE @DATA(lrt_sel_bankl).
      IF ( lrt_sel_banks IS INITIAL AND lrt_sel_bankl IS INITIAL AND it_sel IS NOT INITIAL ).
        "no supported search attribute
        RETURN.
      ENDIF.

      SELECT * FROM i_bank_2 UP TO @i_num_entries ROWS INTO TABLE @DATA(lt_bnka_header)
        WHERE bankcountry    IN @lrt_sel_banks
        AND bankinternalid    IN @lrt_sel_bankl
        ORDER BY PRIMARY KEY.

      SELECT * FROM yb_address UP TO @i_num_entries ROWS INTO TABLE @DATA(lt_address_header)
        WHERE bankcountry IN @lrt_sel_banks
        AND bankkey IN @lrt_sel_bankl
        ORDER BY PRIMARY KEY.
*----------------------------------------Filling Idoc Segments of Address---------------------
      IF lt_address_header IS NOT INITIAL.
        LOOP AT lt_address_header INTO DATA(ls_address_header).
          lw_addr_header1-obj_type = 'BNKA'.
          CONCATENATE ls_address_header-bankkey ls_address_header-bankcountry INTO lw_addr_header1-obj_id.

          lw_seg_address-addr_vers  = ls_address_header-nation. " Address Version
          lw_seg_address-building   = ls_address_header-building. "Building
          lw_seg_address-c_o_name   = ls_address_header-nameco.  "c/o
          lw_seg_address-chckstatus = ls_address_header-chckstatus. "Check Status
          lw_seg_address-city       = ls_address_header-city1. "City
          lw_seg_address-city_no    = ls_address_header-citycode. " City Number
          lw_seg_address-conv_name  = ls_address_header-nametext. "Conv. Name
*          lw_seg_address-countryiso = ls_address_header-country. " CountryISO
          lw_seg_address-country    = ls_address_header-country. "Country
          lw_seg_address-district   = ls_address_header-city2. "District
          lw_seg_address-extens_1   = ls_address_header-extension1. "Extension1
          lw_seg_address-extens_2   = ls_address_header-extension2. "Extension2
          lw_seg_address-floor      = ls_address_header-floor. "Floor
          lw_seg_address-from_date  = ls_address_header-validfrom. " Valid From
          lw_seg_address-house_no   = ls_address_header-housenum1. "House Number
          lw_seg_address-house_no2  = ls_address_header-housenum2. "House Number 2
          lw_seg_address-langu      = ls_address_header-langu. "Language
*          lw_seg_address-langu_iso  = ls_address_header-langu. "Langauage ISO
          lw_seg_address-location   = ls_address_header-location. "Location
          lw_seg_address-name       = ls_address_header-name1. "Name1
          lw_seg_address-name_2     = ls_address_header-name2. "Name2
          lw_seg_address-name_3     = ls_address_header-name3. "Name3
          lw_seg_address-name_4     = ls_address_header-name4. "Name4
          lw_seg_address-postl_cod1 = ls_address_header-postcode1. "Postcode1
          lw_seg_address-postl_cod2 = ls_address_header-postcode2. "Psotcode2
          lw_seg_address-postl_cod3 = ls_address_header-postcode3. "Postcode3
          lw_seg_address-po_box_cit = ls_address_header-poboxcty. "PO City
          lw_seg_address-po_box_reg = ls_address_header-poboxreg. "PO Region
          lw_seg_address-po_box     = ls_address_header-pobox. "PO box
          lw_seg_address-po_w_o_no  = ls_address_header-poboxnum. "PO Box Num
          lw_seg_address-regiogroup = ls_address_header-regiogroup. "Region Grp
          lw_seg_address-region     = ls_address_header-region. "Region
          lw_seg_address-room_no    = ls_address_header-roomnumber. "Room number
          lw_seg_address-sort1      = ls_address_header-sort1. "sort1
          lw_seg_address-sort2      = ls_address_header-sort2. "sort2
          lw_seg_address-street     = ls_address_header-street. "Street
          lw_seg_address-street_no  = ls_address_header-streetcode. "Street code
          lw_seg_address-str_suppl1 = ls_address_header-strsuppl1. "Street1
          lw_seg_address-str_suppl2 = ls_address_header-strsuppl2. "Street2
          lw_seg_address-str_suppl3 = ls_address_header-strsuppl3. "Street3
          lw_seg_address-taxjurcode = ls_address_header-taxjurcode. "Tax jur Code
          lw_seg_address-time_zone  = ls_address_header-timezone1. "Time Zone
*          lw_seg_address-title      = ls_address_header-title. "Title
          lw_seg_address-to_date    = ls_address_header-validto. "Validto
          lw_seg_address-transpzone = ls_address_header-transpzone. "Transportation Zone

          lw_seg_addr_tel-caller_no = ls_address_header-telnrcall. "Caller num
          lw_seg_addr_tel-consnumber = ls_address_header-consnumber. "Consumner Num
          lw_seg_addr_tel-country    = ls_address_header-country. "Country Code
*          lw_seg_addr_tel-countryiso = ls_address_header-country. "Country ISO
          lw_seg_addr_tel-extension   = ls_address_header-telextens. "Telephone extension
          lw_seg_addr_tel-r_3_user    = ls_address_header-r3user. "R3User
          lw_seg_addr_tel-tel_no      = ls_address_header-telnumber. "Tel Number
          lw_seg_addr_tel-telephone   = ls_address_header-telnumber. "Extension+Tel number
          lw_seg_addr_tel-valid_from  = ls_address_header-validfrom.
          lw_seg_addr_tel-valid_to    = ls_address_header-validto.

          lw_seg_addr_eml-consnumber  = ls_address_header-consnumber.
          lw_seg_addr_eml-e_mail      = ls_address_header-smtpaddr. "Email
          lw_seg_addr_eml-email_srch  = ls_address_header-smtpsrch. "Email Search
          lw_seg_addr_eml-tnef        = ls_address_header-tnef."TNEF
          lw_seg_addr_eml-flg_nouse   = ls_address_header-flgnouse. "Nouse
          lw_seg_addr_eml-home_flag   = ls_address_header-homeflag. "Home Flag
          lw_seg_addr_eml-r_3_user    = ls_address_header-r3user.
          lw_seg_addr_eml-encode      = ls_address_header-encode. "Encode
          lw_seg_addr_eml-valid_to    = ls_address_header-validto.
          lw_seg_addr_eml-valid_from  = ls_address_header-validfrom.


          lt_edidd = VALUE #( ( sdata = lw_addr_header1 hlevel = 01 segnam = 'E1ADRMAS' segnum =  000001   )
                              ( sdata = lw_seg_address  hlevel = 02 segnam = 'E1BPAD1VL' segnum =  000002  )
                              ( sdata = lw_seg_addr_tel hlevel = 03 segnam = 'E1BPADTEL' segnum =  000003  )
                              ( sdata = lw_seg_addr_eml hlevel = 04 segnam = 'E1BPADSMTP' segnum =  000004 )
                             ).
        ENDLOOP.
        ls_edidc-mestyp = 'ADRMAS'.
        ls_edidc-rcvprn = 'DIMCT100'.
        ls_edidc-rcvpor = 'A000000031'.
        ls_edidc-rcvprt = 'LS'.
        ls_edidc-idoctp = 'ADRMAS03'.
        APPEND ls_edidc TO lt_edidc.
* check whether idoc data has some records
        IF lt_edidd IS NOT INITIAL.
* create employee outbound idoc
          CALL FUNCTION 'MASTER_IDOC_DISTRIBUTE'
            EXPORTING
              master_idoc_control            = ls_edidc
*             OBJ_TYPE                       = ''
*             CHNUM                          = ''
            TABLES
              communication_idoc_control     = lt_edidc
              master_idoc_data               = lt_edidd
            EXCEPTIONS
              error_in_idoc_control          = 1
              error_writing_idoc_status      = 2
              error_in_idoc_data             = 3
              sending_logical_system_unknown = 4
              OTHERS                         = 5
              ##COMPATIBLE.
          IF sy-subrc <> 0.
* Implement suitable error handling here
          ELSE.
            COMMIT WORK.
          ENDIF.
        ENDIF.
        CLEAR: lt_edidc, lt_edidd, lt_control_data, ls_edidc.
      ENDIF.
*----------------------------------------End: Filling Idoc Segments of Address---------------------
*----------------------------------------Start: Filling Idoc Segments of Bank -----------------------
      IF lt_bnka_header IS NOT INITIAL.
        LOOP AT lt_bnka_header INTO DATA(ls_bnka_header). " Filling Header Segment
          lw_seg_header-bank_key = ls_bnka_header-bankinternalid.
          lw_seg_header-bank_ctry = ls_bnka_header-bankcountry.

          lw_seg_addr-bank_branch = ls_bnka_header-bankbranch. "Filling Address Segment
          lw_seg_addr-bank_group  = ls_bnka_header-banknetworkgrouping.
          lw_seg_addr-bank_name   = ls_bnka_header-bankname.
          lw_seg_addr-bank_no     = ls_bnka_header-bank.
          lw_seg_addr-city        = ls_bnka_header-cityname.
          lw_seg_addr-pobk_curac  = ls_bnka_header-ispostbankaccount.
          lw_seg_addr-region      = ls_bnka_header-region.
          lw_seg_addr-street      = ls_bnka_header-streetname.
          lw_seg_addr-swift_code  = ls_bnka_header-swiftcode.
          lw_seg_addr-addr_no     = ls_bnka_header-addressid. "Address num

          lw_seg_detail-bank_delete = ls_bnka_header-ismarkedfordeletion. "Filling the Details Segment

          lt_edidd = VALUE #( ( sdata = lw_seg_header hlevel = 01 segnam = 'E1BANK_SAVEREPLICA' segnum =  000001 )
                              ( sdata = lw_seg_addr hlevel = 02 segnam = 'E1BP1011_ADDRESS' segnum =  000002 )
                              ( sdata = lw_seg_detail hlevel = 02 segnam = 'E1BP1011_DETAIL' segnum =  000003 ) ).
          CLEAR: lw_seg_detail, lw_seg_addr, lw_seg_header, ls_edidd.

        ENDLOOP.
      ENDIF.
    ENDIF.
*
*-------------------------------------------------------------------

* populate control data
    ls_edidc-mestyp = 'BANK_SAVEREPLICA'.
    ls_edidc-rcvprn = 'DIMCT100'.
    ls_edidc-rcvpor = 'A000000031'.
    ls_edidc-rcvprt = 'LS'.
    ls_edidc-idoctp = 'BANK_SAVEREPLICA01'.
    APPEND ls_edidc TO lt_edidc.

* check whether idoc data has some records
    IF lt_edidd IS NOT INITIAL.
* create employee outbound idoc
      CALL FUNCTION 'MASTER_IDOC_DISTRIBUTE'
        EXPORTING
          master_idoc_control            = ls_edidc
*         OBJ_TYPE                       = ''
*         CHNUM                          = ''
        TABLES
          communication_idoc_control     = lt_edidc
          master_idoc_data               = lt_edidd
        EXCEPTIONS
          error_in_idoc_control          = 1
          error_writing_idoc_status      = 2
          error_in_idoc_data             = 3
          sending_logical_system_unknown = 4
          OTHERS                         = 5
          ##COMPATIBLE.
      IF sy-subrc <> 0.
* Implement suitable error handling here
      ELSE.
        COMMIT WORK.
      ENDIF.
    ENDIF.
    CLEAR: lt_edidc, lt_edidd, lt_control_data, ls_edidc.
  ENDMETHOD.
ENDCLASS.
