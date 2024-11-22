class ZCL_MDG_ZX_OCR_ACCESS definition
  public
  final
  create public .

public section.

  interfaces IF_USMD_PP_ACCESS .
  interfaces IF_USMD_PP_BLOCKLIST .
  interfaces IF_USMD_PP_HANA_SEARCH .

  methods READ_VALUE_GEN_DATA
    importing
      !I_ENTITY type USMD_ENTITY
      !IT_SEL type USMD_TS_SEL
    exporting
      !ET_DATA type ANY TABLE
      !ET_MESSAGE type USMD_T_MESSAGE .
  methods READ_VALUE_IDENTITY
    importing
      !I_ENTITY type USMD_ENTITY
      !IT_SEL type USMD_TS_SEL
    exporting
      !ET_DATA type ANY TABLE
      !ET_MESSAGE type USMD_T_MESSAGE .
  methods QUERY_ZGEN_DATA
    importing
      !I_ENTITY type USMD_ENTITY
      !IT_SEL type USMD_TS_SEL
      !IF_NO_AUTH_CHECK type USMD_FLG
      !I_SEARCH_HELP type SUBSHLP optional
      !I_NUM_ENTRIES type I default 0
    exporting
      !ET_DATA type ANY TABLE
      !ET_MESSAGE type USMD_T_MESSAGE
      !EF_NOT_SUPPORTED type USMD_FLG .
  methods QUERY_ZIDENTITY
    importing
      !I_ENTITY type USMD_ENTITY
      !IT_SEL type USMD_TS_SEL
      !IF_NO_AUTH_CHECK type USMD_FLG
      !I_SEARCH_HELP type SUBSHLP optional
      !I_NUM_ENTRIES type I default 0
    exporting
      !ET_DATA type ANY TABLE
      !ET_MESSAGE type USMD_T_MESSAGE
      !EF_NOT_SUPPORTED type USMD_FLG .
protected section.
private section.

  methods ENCRYPT_IDNUMBER
    importing
      value(IV_IDNUMBER) type BU_ID_NUMBER
    exporting
      !EV_ENCRYPT_KEY type ZMDG_ZX_ENCRYPT_KEY
      !EV_ENCRYPT_DATA type ZMDG_ZX_ENCRYPT_KEY .
  methods DCRYPT_IDNUMBER
    importing
      value(IV_ENCRYPT_KEY) type ZMDG_ZX_ENCRYPT_KEY
      value(IV_ENCRYPT_DATA) type ZMDG_ZX_ENCRYPT_KEY
    exporting
      !EV_IDNUMBER type BU_ID_NUMBER .
ENDCLASS.



CLASS ZCL_MDG_ZX_OCR_ACCESS IMPLEMENTATION.


  METHOD dcrypt_idnumber.
    DATA: lv_data              TYPE xstring,
          lv_key               TYPE xstring,
          lv_message_decrypted TYPE xstring.

    lv_data = iv_encrypt_data.
    lv_key  = iv_encrypt_key.
    "Decrypt message
    cl_sec_sxml_writer=>decrypt(
      EXPORTING
        ciphertext = lv_data
        key       =  lv_key
        algorithm =  cl_sec_sxml_writer=>co_aes128_algorithm
      IMPORTING
        plaintext =  lv_message_decrypted ).

    DATA(lv_id_num) = cl_bcs_convert=>xstring_to_string(
      EXPORTING
        iv_xstr   = lv_message_decrypted
        iv_cp     = '4110'                 " SAP character set identification
    ).
    ev_idnumber = lv_id_num.
  ENDMETHOD.


  METHOD encrypt_idnumber.
    DATA: lv_data   TYPE xstring,
          lv_string TYPE string,
          lv_key    TYPE xstring,
          lv_msg    TYPE xstring.


    lv_string = iv_idnumber.
    lv_data = cl_bcs_convert=>string_to_xstring(
      iv_string = lv_string    " Input data
     ).

    lv_key = cl_sec_sxml_writer=>generate_key( algorithm = cl_sec_sxml_writer=>co_aes128_algorithm  ).

    "encrypt using AES256
    cl_sec_sxml_writer=>encrypt(
      EXPORTING
        plaintext =  Lv_data
        key       =  Lv_key
        algorithm =  cl_sec_sxml_writer=>co_aes128_algorithm
      IMPORTING
        ciphertext = lv_msg ).

    ev_encrypt_key  = lv_key.
    ev_encrypt_data = lv_msg.
  ENDMETHOD.


  method IF_USMD_PP_ACCESS~ADJUST_SELECTION_ATTR.
  endmethod.


  method IF_USMD_PP_ACCESS~CHECK_AUTHORITY.
  endmethod.


  method IF_USMD_PP_ACCESS~CHECK_AUTHORITY_MASS.
  endmethod.


  method IF_USMD_PP_ACCESS~CHECK_DATA.
  endmethod.


  method IF_USMD_PP_ACCESS~CHECK_EXISTENCE_MASS.
  endmethod.


  method IF_USMD_PP_ACCESS~DEQUEUE.
  endmethod.


  method IF_USMD_PP_ACCESS~DERIVE_DATA.
  endmethod.


  method IF_USMD_PP_ACCESS~DERIVE_DATA_ON_KEY_CHANGE.
  endmethod.


  method IF_USMD_PP_ACCESS~DISCARD_READ_BUFFER.
  endmethod.


  method IF_USMD_PP_ACCESS~ENQUEUE.
  endmethod.


  method IF_USMD_PP_ACCESS~GET_CHANGE_DOCUMENT.
  endmethod.


  method IF_USMD_PP_ACCESS~GET_ENTITY_PROPERTIES.
  endmethod.


  method IF_USMD_PP_ACCESS~GET_FIELD_PROPERTIES.
  endmethod.


  method IF_USMD_PP_ACCESS~GET_KEY_HANDLING.
  endmethod.


  method IF_USMD_PP_ACCESS~GET_MAPPING_CD.
  endmethod.


  method IF_USMD_PP_ACCESS~GET_QUERY_PROPERTIES.
  endmethod.


  METHOD if_usmd_pp_access~query.
    CASE i_entity.
      WHEN 'ZGEN_DATA'.
        query_zgen_data(
          EXPORTING
            i_entity         = i_entity                         " Entity Type
            it_sel           = it_sel                           " Sorted Table: Selection Condition (Range per Field)
            if_no_auth_check = if_no_auth_check                 " 'X'=No filtering of reloaded data after authorization
            i_search_help    = i_search_help                    " Search Help Included in a Collective Search Help
            i_num_entries    = i_num_entries                   " 0 = No Restriction
          IMPORTING
            et_data          =  et_data
            et_message       =  et_message                       " Messages
            ef_not_supported =  ef_not_supported                 " 'X'=Query could not be executed
        ).
      WHEN 'ZIDENTITY'.
        query_zidentity(
          EXPORTING
            i_entity         = i_entity                          " Entity Type
            it_sel           = it_sel                            " Sorted Table: Selection Condition (Range per Field)
            if_no_auth_check = if_no_auth_check                  " 'X'=No filtering of reloaded data after authorization
            i_search_help    = i_search_help                     " Search Help Included in a Collective Search Help
            i_num_entries    = i_num_entries                    " 0 = No Restriction
          IMPORTING
            et_data          =  et_data
            et_message       =  et_message                       " Messages
            ef_not_supported =  ef_not_supported                 " 'X'=Query could not be executed
        ).
    ENDCASE.
  ENDMETHOD.


  METHOD if_usmd_pp_access~read_value.
    CASE i_entity.
      WHEN 'ZGEN_DATA'.
        read_value_gen_data(
          EXPORTING
            i_entity   = i_entity                 " Entity Type
            it_sel     = it_sel                   " Sorted Table: Selection Condition (Range per Field)
          IMPORTING
            et_data    = et_data
            et_message = et_message                 " Messages
        ).
      WHEN 'ZIDENTITY'.
        read_value_identity(
          EXPORTING
            i_entity   = i_entity                 " Entity Type
            it_sel     = it_sel                   " Sorted Table: Selection Condition (Range per Field)
          IMPORTING
            et_data    = et_data
            et_message = et_message                 " Messages
        ).
    ENDCASE.
  ENDMETHOD.


  METHOD if_usmd_pp_access~save.
    DATA:
      lt_entity            TYPE usmd_t_entity,
      lv_entity            TYPE usmd_entity,
      lrt_data_inserted    TYPE REF TO data,
      lrt_data_updated     TYPE REF TO data,
      lrt_data_deleted     TYPE REF TO data,
      lt_gen_ins_data      TYPE TABLE OF zzx_s_zx_pp_zgen_data,
      lt_gen_upd_data      TYPE TABLE OF zzx_s_zx_pp_zgen_data,
      lt_identity_ins_data TYPE TABLE OF zzx_s_zx_pp_zidentity,
      lt_identity_upd_data TYPE TABLE OF zzx_s_zx_pp_zidentity,
      lt_gen_data          TYPE STANDARD TABLE OF zmdg_zx_gen_data,
      ls_gen_data          TYPE zmdg_zx_gen_data_s,
      lt_identity_data     TYPE zmdg_zx_identity_data_tt,
      ls_identity_data     TYPE zmdg_zx_identity_data_s.

    FIELD-SYMBOLS: <lt_gen_data_insert> TYPE ANY TABLE.
    FIELD-SYMBOLS: <lt_gen_data_update> TYPE ANY TABLE.
    FIELD-SYMBOLS: <lt_identity_data_insert> TYPE ANY TABLE.
    FIELD-SYMBOLS: <lt_identity_data_update> TYPE ANY TABLE.
    CLEAR:
      et_message,
      et_tmp_key_map.

* process data for entity type
    io_delta->get_entity_types(
      IMPORTING
        et_entity = lt_entity ).

    LOOP AT lt_entity INTO lv_entity.
      io_delta->read_data(
        EXPORTING
          i_entity      = lv_entity                             " entity
          i_struct      = if_usmd_model_ext=>gc_struct_key_attr " keys and attributes
        IMPORTING
          er_t_data_ins = lrt_data_inserted                     " inserted data
          er_t_data_upd = lrt_data_updated                      " updated data
          er_t_data_del = lrt_data_deleted ).                   " deleted data

      CASE lv_entity.
        WHEN 'ZGEN_DATA'.
          IF lrt_data_inserted IS NOT INITIAL.
            ASSIGN lrt_data_inserted->* TO <lt_gen_data_insert>.
            IF sy-subrc IS INITIAL AND <lt_gen_data_insert> IS ASSIGNED.
              lt_gen_ins_data = CORRESPONDING #( <lt_gen_data_insert> ).
            ENDIF.
            IF lt_gen_ins_data IS NOT INITIAL.
              LOOP AT lt_gen_ins_data INTO DATA(ls_gen_ins_data).
                ls_gen_data-client    = sy-mandt.
                ls_gen_data-zgen_data = ls_gen_ins_data-zgen_data.
                ls_gen_data-zfir_name = ls_gen_ins_data-zfir_name.
                ls_gen_data-zfir_last = ls_gen_ins_data-zfir_last.
                ls_gen_data-zdob      = ls_gen_ins_data-zdob.
                APPEND ls_gen_data TO lt_gen_data.
                CLEAR ls_gen_data.
              ENDLOOP.
            ENDIF.
          ENDIF.
          IF lrt_data_updated IS NOT INITIAL.
            ASSIGN lrt_data_updated->* TO <lt_gen_data_update>.
            IF sy-subrc IS INITIAL AND <lt_gen_data_update> IS ASSIGNED.
              lt_gen_upd_data = CORRESPONDING #( <lt_gen_data_update> ).
            ENDIF.
            IF lt_gen_upd_data IS NOT INITIAL.
              LOOP AT lt_gen_upd_data INTO DATA(ls_gen_upd_data).
                CLEAR ls_gen_data.
                ls_gen_data-client    = sy-mandt.
                ls_gen_data-zgen_data = ls_gen_upd_data-zgen_data.
                ls_gen_data-zfir_name = ls_gen_upd_data-zfir_name.
                ls_gen_data-zfir_last = ls_gen_upd_data-zfir_last.
                ls_gen_data-zdob      = ls_gen_upd_data-zdob.
                APPEND ls_gen_data TO lt_gen_data.
              ENDLOOP.
            ENDIF.
          ENDIF.
          CALL FUNCTION 'MODIFY_ZGEN_DATA' IN UPDATE TASK
            EXPORTING
              it_data = lt_gen_data.                 " Table Type for ZGEN DATA
        WHEN 'ZIDENTITY'.
          IF lrt_data_inserted IS NOT INITIAL.
            ASSIGN lrt_data_inserted->* TO <lt_identity_data_insert>.
            IF sy-subrc IS INITIAL AND <lt_identity_data_insert> IS ASSIGNED.
              lt_identity_ins_data = CORRESPONDING #( <lt_identity_data_insert> ).
            ENDIF.
            IF lt_identity_ins_data IS NOT INITIAL.
              LOOP AT lt_identity_ins_data INTO DATA(ls_identity_ins_data).
                ls_identity_data-client     = sy-mandt.
                ls_identity_data-zgen_data  = ls_identity_ins_data-zgen_data.
                ls_identity_data-zid_type   = ls_identity_ins_data-zid_type.
                ls_identity_data-zidnum     = '*******'.
                encrypt_idnumber(
                  EXPORTING
                    iv_idnumber     = ls_identity_ins_data-zidnum                 " Identification Number
                  IMPORTING
                    ev_encrypt_key  = DATA(lv_key)                 " Encrypt key
                    ev_encrypt_data = DATA(lv_data)                " Encrypt Data
                ).
                ls_identity_data-encrypt_key  = lv_key.
                ls_identity_data-ENCRYPT_data = lv_data.
                ls_identity_data-zid_vfrom    = ls_identity_ins_data-zid_vfrom.
                ls_identity_data-zid_vto      = ls_identity_ins_data-zid_vto.
                APPEND ls_identity_data TO lt_identity_data.
                CLEAR ls_identity_data.
              ENDLOOP.
            ENDIF.
          ENDIF.
          IF lrt_data_updated IS NOT INITIAL.
            ASSIGN lrt_data_updated->* TO <lt_identity_data_update>.
            IF sy-subrc IS INITIAL AND <lt_identity_data_update> IS ASSIGNED.
              lt_identity_upd_data = CORRESPONDING #( <lt_identity_data_update> ).
            ENDIF.
            IF lt_identity_upd_data IS NOT INITIAL.
              LOOP AT lt_identity_upd_data INTO DATA(ls_identity_upd_data).
                CLEAR ls_gen_data.
                ls_identity_data-client     = sy-mandt.
                ls_identity_data-zgen_data  = ls_identity_upd_data-zgen_data.
                ls_identity_data-zid_type   = ls_identity_upd_data-zid_type.
                ls_identity_data-zidnum     = '*******'.
                CONDENSE ls_identity_ins_data-zidnum.
                encrypt_idnumber(
                  EXPORTING
                    iv_idnumber     = ls_identity_upd_data-zidnum                 " Identification Number
                  IMPORTING
                    ev_encrypt_key  = DATA(lv_key1)                 " Encrypt key
                    ev_encrypt_data = DATA(lv_data1)                " Encrypt Data
                ).
                ls_identity_data-encrypt_key  = lv_key1.
                ls_identity_data-ENCRYPT_data = lv_data1.
                ls_identity_data-zid_vfrom  = ls_identity_upd_data-zid_vfrom.
                ls_identity_data-zid_vto    = ls_identity_upd_data-zid_vto.
                APPEND ls_identity_data TO lt_identity_data.
              ENDLOOP.
            ENDIF.
          ENDIF.
          CALL FUNCTION 'MODIFY_ZIDENTITY' IN UPDATE TASK
            EXPORTING
              it_data = lt_identity_data.
        WHEN OTHERS.
*       Other entities are not supported

      ENDCASE.
    ENDLOOP.

  ENDMETHOD.


  method IF_USMD_PP_BLOCKLIST~GET_BLOCKLIST_FOR_READ.
  endmethod.


  method IF_USMD_PP_BLOCKLIST~GET_BLOCKLIST_FOR_WRITE.
  endmethod.


  method IF_USMD_PP_HANA_SEARCH~ADAPT_RESULT_LIST.
  endmethod.


  method IF_USMD_PP_HANA_SEARCH~ADAPT_SEL_FIELDS.
  endmethod.


  method IF_USMD_PP_HANA_SEARCH~ADAPT_WHERE_CLAUSE.
  endmethod.


  method IF_USMD_PP_HANA_SEARCH~GET_MAPPING_INFO.
  endmethod.


  method IF_USMD_PP_HANA_SEARCH~GET_REUSE_VIEW_CONTENT.
  endmethod.


  method IF_USMD_PP_HANA_SEARCH~MERGE_REUSE_AUTHORIZATION.
  endmethod.


  METHOD query_zgen_data.
    DATA:
      lt_gendata         TYPE STANDARD TABLE OF zmdg_zx_gen_data,
      lr_data            TYPE REF TO data,
      ls_sel             TYPE usmd_s_sel,
      lrt_sel_gen_data   TYPE RANGE OF bu_businesspartner,
      lrs_sel_gen_data   LIKE LINE OF lrt_sel_gen_data,
      lrt_sel_dob        TYPE RANGE OF gbdat,
      lrs_sel_dob        LIKE LINE OF lrt_sel_dob,
      lrt_sel_ad_namelas TYPE RANGE OF ad_namelas,
      lrs_sel_ad_namelas LIKE LINE OF lrt_sel_ad_namelas,
      lrt_sel_ad_namefir TYPE RANGE OF ad_namefir,
      lrs_sel_ad_namefir LIKE LINE OF lrt_sel_ad_namefir.

    FIELD-SYMBOLS:
      <lv_gendata> TYPE any,
      <ls_gendata> LIKE LINE OF lt_gendata,
      <ls_data>    TYPE any.


* Initialize output
    CLEAR:
      et_data,
      et_message,
      ef_not_supported.

* Build range for select
    LOOP AT it_sel INTO ls_sel WHERE fieldname EQ i_entity.
      MOVE-CORRESPONDING ls_sel TO lrs_sel_gen_data.
      INSERT lrs_sel_gen_data INTO TABLE lrt_sel_gen_data.
    ENDLOOP.

    LOOP AT it_sel INTO ls_sel WHERE fieldname EQ  'ZDOB'.
      MOVE-CORRESPONDING ls_sel TO lrs_sel_dob.
      INSERT lrs_sel_dob INTO TABLE lrt_sel_dob.
    ENDLOOP.

    LOOP AT it_sel INTO ls_sel WHERE fieldname EQ 'ZFIR_LAST'.
      MOVE-CORRESPONDING ls_sel TO lrs_sel_ad_namelas.
      INSERT lrs_sel_ad_namelas INTO TABLE lrt_sel_ad_namelas.
    ENDLOOP.

    LOOP AT it_sel INTO ls_sel WHERE fieldname EQ 'ZFIR_NAME'.
      MOVE-CORRESPONDING ls_sel TO lrs_sel_ad_namefir.
      INSERT lrs_sel_ad_namefir INTO TABLE lrt_sel_ad_namefir.
    ENDLOOP.

    IF ( lrt_sel_gen_data      IS INITIAL AND
         lrt_sel_dob           IS INITIAL AND
         lrt_sel_ad_namefir    IS INITIAL AND
         lrt_sel_ad_namelas    IS INITIAL AND
         it_sel                IS NOT INITIAL ).
*   no supported search attribute
      RETURN.
    ENDIF.

* Create local data structure
    CREATE DATA lr_data LIKE LINE OF et_data.
    ASSIGN lr_data->* TO <ls_data>.
    ASSIGN COMPONENT 'ZGEN_DATA' OF STRUCTURE <ls_data> TO <lv_gendata>.

* Select data
    SELECT * FROM zmdg_zx_gen_data UP TO i_num_entries ROWS INTO TABLE lt_gendata
      WHERE zgen_data IN lrt_sel_gen_data
        AND zdob      IN lrt_sel_dob
        AND zfir_name IN lrt_sel_ad_namefir
        AND zfir_last IN lrt_sel_ad_namelas.

* Transfer from SCARR format into ET_DATA format
    LOOP AT lt_gendata ASSIGNING <ls_gendata>.
      IF <lv_gendata> IS ASSIGNED.
        <lv_gendata> = <ls_gendata>-zgen_data.
      ENDIF.
      MOVE-CORRESPONDING <ls_gendata> TO <ls_data>.
      INSERT <ls_data> INTO TABLE et_data.
    ENDLOOP.
  ENDMETHOD.


  METHOD query_zidentity.
    DATA:
      lt_identitydata  TYPE STANDARD TABLE OF zmdg_zx_identity,
      lr_data          TYPE REF TO data,
      ls_sel           TYPE usmd_s_sel,
      lrt_sel_gen_data TYPE RANGE OF bu_businesspartner,
      lrs_sel_gen_data LIKE LINE OF lrt_sel_gen_data,
      lrt_sel_idnum    TYPE RANGE OF bu_id_number,
      lrs_sel_idnum    LIKE LINE OF lrt_sel_idnum,
      lrt_sel_idtype   TYPE RANGE OF bu_id_type,
      lrs_sel_idtype   LIKE LINE OF lrt_sel_idtype,
      lrt_sel_vfrom    TYPE RANGE OF bu_id_valid_date_from,
      lrs_sel_vfrom    LIKE LINE OF lrt_sel_vfrom,
      lrt_sel_vto      TYPE RANGE OF bu_id_valid_date_to,
      lrs_sel_vto      LIKE LINE OF lrt_sel_vto.


    FIELD-SYMBOLS:
      <lv_gendata> TYPE any,
      <ls_gendata> LIKE LINE OF lt_identitydata,
      <ls_data>    TYPE any.


* Initialize output
    CLEAR:
      et_data,
      et_message,
      ef_not_supported.

* Build range for select
    LOOP AT it_sel INTO ls_sel WHERE fieldname EQ 'ZGEN_DATA'.
      MOVE-CORRESPONDING ls_sel TO lrs_sel_gen_data.
      INSERT lrs_sel_gen_data INTO TABLE lrt_sel_gen_data.
    ENDLOOP.

    LOOP AT it_sel INTO ls_sel WHERE fieldname EQ  'ZID_TYPE'.
      MOVE-CORRESPONDING ls_sel TO lrs_sel_idtype.
      INSERT lrs_sel_idtype INTO TABLE lrt_sel_idtype.
    ENDLOOP.

    LOOP AT it_sel INTO ls_sel WHERE fieldname EQ 'ZIDNUM'.
      MOVE-CORRESPONDING ls_sel TO lrs_sel_idnum.
      INSERT lrs_sel_idnum INTO TABLE lrt_sel_idnum.
    ENDLOOP.

    LOOP AT it_sel INTO ls_sel WHERE fieldname EQ 'ZID_VFROM'.
      MOVE-CORRESPONDING ls_sel TO lrs_sel_vfrom.
      INSERT lrs_sel_vfrom INTO TABLE lrt_sel_vfrom.
    ENDLOOP.

    LOOP AT it_sel INTO ls_sel WHERE fieldname EQ 'ZID_VTO'.
      MOVE-CORRESPONDING ls_sel TO lrs_sel_vto.
      INSERT lrs_sel_vto INTO TABLE lrt_sel_vto.
    ENDLOOP.

    IF ( lrt_sel_gen_data IS INITIAL AND
         lrt_sel_idtype   IS INITIAL AND
         lrt_sel_idnum    IS INITIAL AND
         lrt_sel_vfrom    IS INITIAL AND
         lrt_sel_vto      IS INITIAL AND
         it_sel           IS NOT INITIAL ).
*   no supported search attribute
      RETURN.
    ENDIF.

* Create local data structure
    CREATE DATA lr_data LIKE LINE OF et_data.
    ASSIGN lr_data->* TO <ls_data>.
    ASSIGN COMPONENT 'ZGEN_DATA' OF STRUCTURE <ls_data> TO <lv_gendata>.

* Select data
    SELECT * FROM zmdg_zx_identity UP TO i_num_entries ROWS INTO TABLE lt_identitydata
      WHERE zgen_data IN lrt_sel_gen_data
        AND zidnum    IN lrt_sel_idnum
        AND zid_type  IN lrt_sel_idtype
        AND zid_vfrom IN lrt_sel_vfrom
        AND zid_vto   IN lrt_sel_vto.

* Transfer from SCARR format into ET_DATA format
    LOOP AT lt_identitydata ASSIGNING <ls_gendata>.
      IF <lv_gendata> IS ASSIGNED.
        <lv_gendata> = <ls_gendata>-zgen_data.
      ENDIF.
      MOVE-CORRESPONDING <ls_gendata> TO <ls_data>.
      INSERT <ls_data> INTO TABLE et_data.
    ENDLOOP.
  ENDMETHOD.


  METHOD read_value_gen_data.
    DATA:
      lt_gen_data      TYPE STANDARD TABLE OF zmdg_zx_gen_data,
      lr_data          TYPE REF TO data,
      ls_sel           TYPE usmd_s_sel,
      lrt_sel_gen_data TYPE RANGE OF bu_businesspartner,
      lrs_sel_gen_data LIKE LINE OF lrt_sel_gen_data.

    FIELD-SYMBOLS:
      <lv_gen_data> TYPE any,
      <ls_gen_data> LIKE LINE OF lt_gen_data,
      <ls_data>     TYPE any.

* Check input
    ASSERT i_entity EQ 'ZGEN_DATA'.

* Initialize output
    CLEAR:
      et_data,
      et_message.

* Build range for select
    LOOP AT it_sel INTO ls_sel WHERE fieldname EQ i_entity.
      MOVE-CORRESPONDING ls_sel TO lrs_sel_gen_data.
      APPEND lrs_sel_gen_data TO lrt_sel_gen_data.
    ENDLOOP.

* Create local data structure
    CREATE DATA lr_data LIKE LINE OF et_data.
    ASSIGN lr_data->* TO <ls_data>.
    ASSIGN COMPONENT 'ZGEN_DATA' OF STRUCTURE <ls_data> TO <lv_gen_data>.

* get data
    SELECT * FROM zmdg_zx_gen_data INTO TABLE lt_gen_data
      WHERE zgen_data IN lrt_sel_gen_data.

* Convert data from DB format into MDG format
    LOOP AT lt_gen_data ASSIGNING <ls_gen_data>.
      MOVE-CORRESPONDING <ls_gen_data> TO <ls_data>.
      IF <lv_gen_data> IS ASSIGNED.
        <lv_gen_data> = <ls_gen_data>-zgen_data.
      ENDIF.
      INSERT <ls_data> INTO TABLE et_data.
    ENDLOOP.

  ENDMETHOD.


  METHOD read_value_identity.
    DATA:
      lt_identity      TYPE STANDARD TABLE OF zmdg_zx_identity,
      lt_identity_stg  TYPE  TABLE OF zzx_s_zx_pp_zidentity,
      ls_identity      LIKE LINE OF lt_identity_stg,
      lr_data          TYPE REF TO data,
      ls_sel           TYPE usmd_s_sel,
      lrt_sel_gen_data TYPE RANGE OF bu_businesspartner,
      lrs_sel_gen_data LIKE LINE OF lrt_sel_gen_data.
    DATA:lv_data              TYPE ZMDG_ZX_ENCRYPT_KEY,
         lv_key               TYPE zmdg_zx_encrypt_key,
         lv_message_decrypted TYPE xstring.
    FIELD-SYMBOLS:
      <lv_gen_data> TYPE any,
      <ls_identity> LIKE LINE OF lt_identity,
      <ls_data>     TYPE any.


* Check input
    ASSERT i_entity EQ 'ZIDENTITY'.

* Initialize output
    CLEAR:
      et_data,
      et_message.

* Build range for select
    LOOP AT it_sel INTO ls_sel WHERE fieldname EQ 'ZGEN_DATA'.
      MOVE-CORRESPONDING ls_sel TO lrs_sel_gen_data.
      APPEND lrs_sel_gen_data TO lrt_sel_gen_data.
    ENDLOOP.

* get data
    SELECT * FROM zmdg_zx_identity INTO TABLE lt_identity
      WHERE zgen_data IN lrt_sel_gen_data.

* Convert data from DB format into MDG format
    LOOP AT lt_identity ASSIGNING <ls_identity>.
      CLEAR:lv_data,
            lv_key.
      ls_identity-zgen_data = <ls_identity>-zgen_data.
      ls_identity-zid_vfrom = <ls_identity>-zid_vfrom.
      ls_identity-zid_vto   = <ls_identity>-zid_vto.
      ls_identity-zid_type  = <ls_identity>-zid_type.
      "Decrypt message
      lv_data = <ls_identity>-encrypt_data.
      lv_key  = <ls_identity>-encrypt_key.
      dcrypt_idnumber(
        EXPORTING
          iv_encrypt_key  = lv_key                 " Encrypt key
          iv_encrypt_data = lv_data                 " Encrypt key
        IMPORTING
          ev_idnumber     = DATA(lv_id_num)                 " Identification Number
      ).
      ls_identity-zidnum = lv_id_num.
      APPEND ls_identity TO lt_identity_stg.
    ENDLOOP.
    CHECK lt_identity_stg IS NOT INITIAL.
    MOVE-CORRESPONDING lt_identity_stg TO et_data.
  ENDMETHOD.
ENDCLASS.
