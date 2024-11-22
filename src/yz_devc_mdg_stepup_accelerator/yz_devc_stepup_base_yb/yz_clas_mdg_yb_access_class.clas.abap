class YZ_CLAS_MDG_YB_ACCESS_CLASS definition
  public
  final
  create public .

public section.

  interfaces IF_USMD_PP_ACCESS .
  interfaces IF_USMD_PP_HANA_SEARCH .
  interfaces IF_MDG_BP_CONSTANTS .

  constants GC_MODEL type USMD_MODEL value 'YB' ##NO_TEXT.
  constants GC_BUSINESS_OBJECT type MDG_OBJECT_TYPE_CODE_BS value 'YB_BNKA' ##NO_TEXT.

  methods QUERY_ENTITY_DATA
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

  class-data GO_INSTANCE type ref to YZ_CLAS_MDG_YB_ACCESS_CLASS .
  class-data GT_REUSE_FMAP type MDG_HDB_TT_PP_FMAP .
  class-data GT_JOIN_CONDITIONS type MDG_HDB_TT_XML_JOIN_TABLE .

  methods SET_REUSE_MAPPING .
private section.

  methods READ_DATA
    importing
      !IV_BNKS type BANKL
      !IV_BANKS type BANKS
    exporting
      !ES_BNKS type YXX_S_YB_PP_Y_BANKL .
ENDCLASS.



CLASS YZ_CLAS_MDG_YB_ACCESS_CLASS IMPLEMENTATION.


  method IF_USMD_PP_ACCESS~ADJUST_SELECTION_ATTR.
  endmethod.


  method IF_USMD_PP_ACCESS~CHECK_AUTHORITY.
  endmethod.


  method IF_USMD_PP_ACCESS~CHECK_AUTHORITY_MASS.
  endmethod.


  METHOD if_usmd_pp_access~check_data.
    "Business Rule for Swift Key Validation
*    IF sy-uname = 'ASWARUP'.
    "Data Declarations
    DATA : lr_data     TYPE REF TO data,
           lv_country  TYPE banks,
           lv_bank_key TYPE bankk,
           lv_swift    TYPE swift.
    FIELD-SYMBOLS <ft_data> TYPE ANY TABLE.

    IF io_delta IS BOUND.
      io_delta->get_entity_types(
        IMPORTING
          et_entity_mod = DATA(lt_entity_mod)                 " List of Entity Types Containing New And/Or Changed Data
      ).
      LOOP AT lt_entity_mod INTO DATA(ls_entity_mod).
        io_delta->read_data(
          EXPORTING
            i_entity      = ls_entity_mod-entity       " Entity Type
          IMPORTING
            er_t_data_mod = lr_data                    "Modified" Data Records (INSERT+UPDATE)
        ).
        ASSIGN lr_data->* TO <ft_data>.
        IF <ft_data> IS ASSIGNED.
          CASE ls_entity_mod-entity.
            WHEN 'Y_BANKL'.
              LOOP AT <ft_data> ASSIGNING FIELD-SYMBOL(<fs_data>).
                ASSIGN COMPONENT 'Y_BANKS' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_ybanks>). " Bank Country
                IF <fs_ybanks> IS ASSIGNED AND <fs_ybanks> IS NOT INITIAL.
                  lv_country = <fs_ybanks>.
                ENDIF.
                ASSIGN COMPONENT 'Y_BANKL' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_ybankl>). " Bank Key
                IF <fs_ybankl> IS ASSIGNED AND <fs_ybankl> IS NOT INITIAL.
                  lv_bank_key = <fs_ybankl>.
                ENDIF.
                ASSIGN COMPONENT 'YB_SWIFT' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_yswift>). " Swift Key
                IF <fs_yswift> IS ASSIGNED AND <fs_yswift> IS NOT INITIAL.
                  lv_swift = <fs_yswift>.
                ENDIF.
                IF lv_country IS NOT INITIAL AND lv_swift IS NOT INITIAL.
                  CALL FUNCTION 'SWIFT_CODE_CHECK'
                    EXPORTING
                      bank_country = lv_country                  " Bank Country
                      swift_code   = lv_swift                 " SWIFT Code
                    EXCEPTIONS
                      not_valid    = 1                " Check not successful
                      OTHERS       = 2.
                  IF sy-subrc <> 0.
                    et_message = VALUE #( ( msgid = sy-msgid msgty = sy-msgty msgno = sy-msgno ) ).
                  ENDIF.
                ENDIF.
              ENDLOOP.
            WHEN OTHERS.
          ENDCASE.
        ENDIF.
      ENDLOOP.
    ENDIF.
*    ENDIF.
  ENDMETHOD.


  method IF_USMD_PP_ACCESS~CHECK_EXISTENCE_MASS.
  endmethod.


  method IF_USMD_PP_ACCESS~DEQUEUE.
  endmethod.


  METHOD if_usmd_pp_access~derive_data.
    "Derivations
*    IF sy-uname = 'ASWARUP'.
    FIELD-SYMBOLS: <lt_chd_data> TYPE ANY TABLE.
    DATA: lt_attributes TYPE usmd_ts_fieldname,
          ls_attribute  LIKE LINE OF lt_attributes,
          lv_bank_key   TYPE bankk.

    IF io_changed_data IS BOUND.
      io_changed_data->get_entity_types( IMPORTING et_entity_mod = DATA(lt_entity_mod) ).
      LOOP AT lt_entity_mod INTO DATA(ls_entity_mod). "WHERE struct = 'KATTR'.
        CHECK ls_entity_mod-struct EQ 'KATTR'.
        CASE ls_entity_mod-entity.
          WHEN 'Y_BANKL'.
            io_changed_data->read_data( EXPORTING i_entity      = 'Y_BANKL'
                                        IMPORTING er_t_data_upd = DATA(lv_chd_data)
                                                  er_t_data_ins = DATA(lv_obj_ins) ).
            IF sy-subrc IS INITIAL.
              IF lv_obj_ins IS  BOUND .
                ASSIGN lv_obj_ins->* TO <lt_chd_data>.
              ELSEIF lv_chd_data IS BOUND.
                ASSIGN lv_chd_data->* TO <lt_chd_data>.
              ENDIF.
            ENDIF.
            IF  <lt_chd_data> IS ASSIGNED AND <lt_chd_data> IS NOT INITIAL.
              LOOP AT <lt_chd_data> ASSIGNING FIELD-SYMBOL(<ls_chd_data>).
                ASSIGN COMPONENT 'Y_BANKL' OF STRUCTURE <ls_chd_data> TO FIELD-SYMBOL(<lv_ybankl>).
                IF <lv_ybankl> IS ASSIGNED AND <lv_ybankl> IS NOT INITIAL.
                  lv_bank_key = <lv_ybankl>.
                ENDIF.
                ASSIGN COMPONENT 'YB_BANKL' OF STRUCTURE <ls_chd_data> TO FIELD-SYMBOL(<lv_ybbnkl>).
                IF <lv_ybbnkl> IS ASSIGNED .
                  <lv_ybbnkl> = lv_bank_key.
                ENDIF.
              ENDLOOP.
            ENDIF.
            IF <lt_chd_data> IS NOT INITIAL.
              ls_attribute = 'YB_BANKL'.
              INSERT ls_attribute INTO TABLE lt_attributes.

              TRY.
                  io_write_data->write_data(
                    EXPORTING
                      i_entity     = 'Y_BANKL'        " Entity Type
                      it_data      = <lt_chd_data>
                      it_attribute = lt_attributes
                  ).
                CATCH cx_usmd_write_error. " Error while writing to buffer
              ENDTRY.
            ENDIF.

          WHEN OTHERS.

        ENDCASE.
      ENDLOOP.
    ENDIF.
*    ENDIF.
  ENDMETHOD.


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
      WHEN 'Y_BANKL' OR 'Y_ADDRESS'.
        query_entity_data(
          EXPORTING
            i_entity         = i_entity                 " Entity Type
            it_sel           = it_sel                 " Sorted Table: Selection Condition (Range per Field)
            if_no_auth_check = if_no_auth_check                " MDGAF: General Indicator
            i_search_help    = i_search_help                 " Search help included in a collective search help
            i_num_entries    = i_num_entries
          IMPORTING
            et_data          = et_data
            et_message       = et_message                 " Messages
            ef_not_supported = ef_not_supported ).                " MDGAF: General Indicator
      WHEN OTHERS.
    ENDCASE.

  ENDMETHOD.


  METHOD if_usmd_pp_access~read_value.

    me->if_usmd_pp_access~query(
      EXPORTING
        i_entity         = i_entity
        it_sel           = it_sel
        if_no_auth_check = abap_true
      IMPORTING
        et_data          = et_data
        et_message       = et_message
    ).

  ENDMETHOD.


  METHOD if_usmd_pp_access~save.
*----------------------------------------------------------------------*
* Program description:
* This method takes care of saving the data of Bank Master into the
* standard ECC Bank Master table BNKA in case of both CREATE & CHANGE
* Process
*----------------------------------------------------------------------*
*******************************************************************************************************************************
** After Final approval of any Bank master, this Method is used to save or change the record from the staging table or  ****
** persistance table using respective Bank master BAPI                                                                  ****
*******************************************************************************************************************************
    DATA : let_entity        TYPE usmd_t_entity,
           lw_entity         TYPE usmd_entity,
           lcl_data_inserted TYPE REF TO data, "New Crequest data
           lcl_data_updated  TYPE REF TO data, "Changed Crequest data
           lcl_data_deleted  TYPE REF TO data, "deleted Crequest data
           lr_data           TYPE REF TO data,
           lt_message        TYPE usmd_t_message,
           lv_temp_id        TYPE lstar,
           lv_creq_type      TYPE string,
           ls_bnka           TYPE txi_bnka, "BANKA_STRUCT
           ls_bnka1          TYPE txi_bnka, "BANKA_STRUCT
           ls_addr           TYPE bapiaddr1,
           lt_addr           TYPE TABLE OF bapiaddr1,
           lt_bnka           TYPE TABLE OF txi_bnka, "BANKA_STRUCT
           lt_bnka1          TYPE TABLE OF txi_bnka, "BANKA_STRUCT
           ls_error          TYPE TABLE OF suc_and_err_tabs,
           ls_success        TYPE TABLE OF suc_and_err_tabs,
           lv_crtype         TYPE usmd_crequest_type.

    DATA: ls_addressx  TYPE bapi1011_addressx,
          ls_detailx   TYPE bapi1011_detailx,
          ls_address1x TYPE bapiaddr1x.

    FIELD-SYMBOLS : <lfs_bnk_save>  TYPE ANY TABLE,
                    <lfs_addr_save> TYPE ANY TABLE,
                    <lfs_bnk_ins>   TYPE any,
                    <lfs_addr_ins>  TYPE any,
                    <lfs_z_bankl>   TYPE any,
                    <lfs_z_banks>   TYPE any,
                    <lfs_banka>     TYPE any,
                    <lfs_bgrup>     TYPE any,
                    <lfs_bnklz>     TYPE any,
                    <lfs_brnch>     TYPE any,
                    <lfs_erdat>     TYPE any,
                    <lfs_ernam>     TYPE any,
                    <lfs_loevm>     TYPE any,
                    <lfs_ort01>     TYPE any,
                    <lfs_stras>     TYPE any,
                    <lfs_swift>     TYPE any,
                    <lfs_xpgro>     TYPE any,
                    <lfs_zcbid>     TYPE any,
                    <lfs_zprovz>    TYPE any,
                    <lfs_ztrnstyp>  TYPE any,
                    <lfs_zzlcc1>    TYPE any,
                    <lfs_zzlcc2>    TYPE any,
                    <lfs_regio>     TYPE any,
                    <lfs_bnk_upd>   TYPE any,
                    <lfs_addr_upd>  TYPE any.

    "get all entity types to be processed
    CALL METHOD io_delta->get_entity_types
      IMPORTING
        et_entity = let_entity.

    LOOP AT let_entity INTO lw_entity.
*      CASE lw_entity.
*        WHEN 'Y_BANKL'.
      "This method returns data from the delta read buffer depending on the given entity.
      CALL METHOD io_delta->read_data
        EXPORTING
          i_entity      = lw_entity
          i_struct      = if_usmd_model_ext=>gc_struct_key_attr
        IMPORTING
          er_t_data_ins = lcl_data_inserted
          er_t_data_upd = lcl_data_updated
          er_t_data_del = lcl_data_deleted.
      CASE lw_entity.
        WHEN 'Y_BANKL'.
*          ----------------BOC: to handle create and change scenarios------------ ENTITY = 'Y_BANKL'
          IF lcl_data_inserted IS NOT INITIAL."in case of create
            DATA(lv_bank_insert) = abap_true. "Bank Data Inserted
            ASSIGN lcl_data_inserted->* TO <lfs_bnk_save>.
            CLEAR: et_message.
            LOOP AT <lfs_bnk_save> ASSIGNING <lfs_bnk_ins>.
              ASSIGN COMPONENT 'Y_BANKL' OF STRUCTURE <lfs_bnk_ins> TO <lfs_z_bankl>."Bank Key
              ls_bnka-bankl = <lfs_z_bankl>.
              ASSIGN COMPONENT 'Y_BANKS' OF STRUCTURE <lfs_bnk_ins> TO <lfs_z_banks>." Bank Country Leading Entity Type BANKS
              ls_bnka-banks   = <lfs_z_banks>.
              ASSIGN COMPONENT 'YB_BANKA' OF STRUCTURE <lfs_bnk_ins> TO <lfs_banka>." Bank name Attribute BANKA
              ls_bnka-banka   = <lfs_banka>.
              ASSIGN COMPONENT 'YB_BGRUP' OF STRUCTURE <lfs_bnk_ins> TO <lfs_bgrup>."Bank group Attribute BGRUP
              ls_bnka-bgrup    = <lfs_bgrup>.
              ASSIGN COMPONENT 'YB_BANKL' OF STRUCTURE <lfs_bnk_ins> TO <lfs_bnklz>." Bank number Attribute BANKL
              ls_bnka-bnklz  = <lfs_bnklz>.
              ASSIGN COMPONENT 'YB_BRNCH' OF STRUCTURE <lfs_bnk_ins> TO <lfs_brnch>." Bank Branch Attribute BRNCH
              ls_bnka-brnch  = <lfs_brnch>.
              ASSIGN COMPONENT 'YB_ERDAT' OF STRUCTURE <lfs_bnk_ins> TO <lfs_erdat>." Created on Attribute ERDAT_BF
              ls_bnka-erdat = sy-datum.
              ASSIGN COMPONENT 'YB_ERNAM' OF STRUCTURE <lfs_bnk_ins> TO <lfs_ernam>." Created by Attribute ERNAM_BF
              ls_bnka-ernam = sy-uname.
*              ASSIGN COMPONENT 'YB_LOEVM' OF STRUCTURE <lfs_bnk_ins> TO <lfs_loevm>." Deletion Indicator Attribute LOEVM
*              ls_bnka-loevm = <lfs_loevm>. " Not required suring create
              ASSIGN COMPONENT 'YB_ORT01' OF STRUCTURE <lfs_bnk_ins> TO <lfs_ort01>."  City Attribute ORT01_GP
              ls_bnka-ort01 = <lfs_ort01>.
              ASSIGN COMPONENT 'YB_STRAS' OF STRUCTURE <lfs_bnk_ins> TO <lfs_stras>."  Street Attribute STRAS_GP
              ls_bnka-stras = <lfs_stras>.
              ASSIGN COMPONENT 'YB_SWIFT' OF STRUCTURE <lfs_bnk_ins> TO <lfs_swift>."  SWIFT/BIC Attribute SWIFT
              ls_bnka-swift = <lfs_swift>.
              ASSIGN COMPONENT 'YB_XPGRO' OF STRUCTURE <lfs_bnk_ins> TO <lfs_xpgro>."  Post.bank curr.acct Attribute XPGRO
              ls_bnka-xpgro = <lfs_xpgro>.
              ASSIGN COMPONENT 'YB_REGIO' OF STRUCTURE <lfs_bnk_ins> TO <lfs_regio>."  Region Attribute PROVZ
              ls_bnka-provz = <lfs_regio>.
              APPEND ls_bnka TO lt_bnka.
            ENDLOOP.
          ELSEIF lcl_data_updated IS NOT INITIAL. "Update
            DATA(lv_bank_update) = abap_true. "Bank Data Updated
            ASSIGN lcl_data_updated->* TO <lfs_bnk_save>.
            LOOP AT <lfs_bnk_save> ASSIGNING <lfs_bnk_upd>.
              ASSIGN COMPONENT 'Y_BANKL' OF STRUCTURE <lfs_bnk_upd> TO <lfs_z_bankl>."Bank Key
              ls_bnka-bankl = <lfs_z_bankl>.
              ASSIGN COMPONENT 'Y_BANKS' OF STRUCTURE <lfs_bnk_upd> TO <lfs_z_banks>." Bank Country Leading Entity Type BANKS
              ls_bnka-banks   = <lfs_z_banks>.
              ASSIGN COMPONENT 'YB_BANKA' OF STRUCTURE <lfs_bnk_upd> TO <lfs_banka>." Bank name Attribute BANKA
              ls_bnka-banka   = <lfs_banka>.
              ASSIGN COMPONENT 'YB_BGRUP' OF STRUCTURE <lfs_bnk_upd> TO <lfs_bgrup>."Bank group Attribute BGRUP
              ls_bnka-bgrup    = <lfs_bgrup>.
              ASSIGN COMPONENT 'YB_BANKL' OF STRUCTURE <lfs_bnk_upd> TO <lfs_bnklz>." Bank number Attribute BANKL
              ls_bnka-bnklz  = <lfs_bnklz>.
              ASSIGN COMPONENT 'YB_BRNCH' OF STRUCTURE <lfs_bnk_upd> TO <lfs_brnch>." Bank Branch Attribute BRNCH
              ls_bnka-brnch  = <lfs_brnch>.
              ASSIGN COMPONENT 'YB_ERDAT' OF STRUCTURE <lfs_bnk_upd> TO <lfs_erdat>." Created on Attribute ERDAT_BF
              IF <lfs_erdat> IS ASSIGNED.
                ls_bnka-erdat = <lfs_erdat>.
              ENDIF.
              ASSIGN COMPONENT 'YB_ERNAM' OF STRUCTURE <lfs_bnk_upd> TO <lfs_ernam>." Created by Attribute ERNAM_BF
              IF <lfs_ernam> IS ASSIGNED.
                ls_bnka-ernam = <lfs_ernam>.
              ENDIF.
              ASSIGN COMPONENT 'YB_LOEVM' OF STRUCTURE <lfs_bnk_upd> TO <lfs_loevm>." Deletion Indicator Attribute LOEVM
              IF <lfs_loevm> IS  ASSIGNED.
                ls_bnka-loevm = <lfs_loevm>.
              ENDIF.
              ASSIGN COMPONENT 'YB_ORT01' OF STRUCTURE <lfs_bnk_upd> TO <lfs_ort01>."  City Attribute ORT01_GP
              ls_bnka-ort01 = <lfs_ort01>.
              ASSIGN COMPONENT 'YB_STRAS' OF STRUCTURE <lfs_bnk_upd> TO <lfs_stras>."  Street Attribute STRAS_GP
              ls_bnka-stras = <lfs_stras>.
              ASSIGN COMPONENT 'YB_SWIFT' OF STRUCTURE <lfs_bnk_upd> TO <lfs_swift>."  SWIFT/BIC Attribute SWIFT
              ls_bnka-swift = <lfs_swift>.
              ASSIGN COMPONENT 'YB_XPGRO' OF STRUCTURE <lfs_bnk_upd> TO <lfs_xpgro>."  Post.bank curr.acct Attribute XPGRO
              ls_bnka-xpgro = <lfs_xpgro>.
              ASSIGN COMPONENT 'YB_REGIO' OF STRUCTURE <lfs_bnk_upd> TO <lfs_regio>."  Region Attribute PROVZ
              ls_bnka-provz = <lfs_regio>.
              ASSIGN COMPONENT 'YB_ADDRNO' OF STRUCTURE <lfs_bnk_upd> TO FIELD-SYMBOL(<lfs_addrnum>)."  Address Num
              ls_bnka-adrnr = <lfs_addrnum>.
              APPEND ls_bnka TO lt_bnka.
              ASSIGN COMPONENT 'USMDX_S_UPDATE' OF STRUCTURE <lfs_bnk_upd> TO FIELD-SYMBOL(<lfs_address>).
              IF <lfs_address> IS ASSIGNED.
                ASSIGN COMPONENT 'YB_BANKA' OF STRUCTURE <lfs_address> TO FIELD-SYMBOL(<lfs_ybankax>). " Bank Name
                IF <lfs_ybankax> IS ASSIGNED AND <lfs_ybankax> EQ abap_true.
                  ls_addressx-bank_name = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_BGRUP' OF STRUCTURE <lfs_address> TO FIELD-SYMBOL(<lfs_ybgrupx>). " Bank Group
                IF <lfs_ybgrupx> IS ASSIGNED AND <lfs_ybgrupx> EQ abap_true.
                  ls_addressx-bank_group = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_BANKL' OF STRUCTURE <lfs_address> TO FIELD-SYMBOL(<lfs_ybanklx>). " Bank Number
                IF <lfs_ybanklx> IS ASSIGNED AND <lfs_ybanklx> EQ abap_true.
                  ls_addressx-bank_no = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_BRNCH' OF STRUCTURE <lfs_address> TO FIELD-SYMBOL(<lfs_ybrnchx>). " Bank Branch
                IF <lfs_ybrnchx> IS ASSIGNED AND <lfs_ybrnchx> EQ abap_true.
                  ls_addressx-bank_branch = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_ORT01' OF STRUCTURE <lfs_address> TO FIELD-SYMBOL(<lfs_yort01x>). " City
                IF <lfs_yort01x> IS ASSIGNED AND <lfs_yort01x> EQ abap_true.
                  ls_addressx-city = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_STRAS' OF STRUCTURE <lfs_address> TO FIELD-SYMBOL(<lfs_ystrasx>). " Street
                IF <lfs_ystrasx> IS ASSIGNED AND <lfs_ystrasx> EQ abap_true.
                  ls_addressx-street = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_REGIO' OF STRUCTURE <lfs_address> TO FIELD-SYMBOL(<lfs_yregiox>). " Region
                IF <lfs_yregiox> IS ASSIGNED AND <lfs_yregiox> EQ abap_true.
                  ls_addressx-region = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_SWIFT' OF STRUCTURE <lfs_address> TO FIELD-SYMBOL(<lfs_yswiftx>). " Swift
                IF <lfs_yswiftx> IS ASSIGNED AND <lfs_yswiftx> EQ abap_true.
                  ls_addressx-swift_code = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_XPGRO' OF STRUCTURE <lfs_address> TO FIELD-SYMBOL(<lfs_yxpgrox>). " Post.bank curr.acct Attribute XPGRO
                IF <lfs_yxpgrox> IS ASSIGNED AND <lfs_yxpgrox> EQ abap_true.
                  ls_addressx-pobk_curac = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_LOEVM' OF STRUCTURE <lfs_address> TO FIELD-SYMBOL(<lfs_yloevmx>). " Deletion Indicator
                IF <lfs_yloevmx> IS ASSIGNED AND <lfs_yloevmx> EQ abap_true.
                  ls_detailx-bank_delete = abap_true.
                ENDIF.
              ENDIF.
            ENDLOOP.
          ENDIF.
*          ---------------EOC: to handle create and change scenarios-------------ENTITY = 'Y_BANKL'
        WHEN 'Y_ADDRESS'.
*          ---------------EOC: to handle create and change scenarios-------------ENTITY = 'Y_ADDRESS'
          IF lcl_data_inserted IS NOT INITIAL."in case of create
            DATA(lv_addr_insert) = abap_true. "Address Data Inserted
            ASSIGN lcl_data_inserted->* TO <lfs_addr_save>.
            CLEAR: et_message.
            LOOP AT <lfs_addr_save> ASSIGNING <lfs_addr_ins>.
              ASSIGN COMPONENT 'Y_BANKL' OF STRUCTURE <lfs_addr_ins> TO <lfs_z_bankl>."Bank Key
              IF <lfs_z_bankl> IS ASSIGNED.
                ls_bnka-bankl = <lfs_z_bankl>.
              ENDIF.
              ASSIGN COMPONENT 'Y_BANKS' OF STRUCTURE <lfs_addr_ins> TO <lfs_z_banks>." Bank Country Leading Entity Type BANKS
              IF <lfs_z_banks> IS  ASSIGNED.
                ls_bnka-banks   = <lfs_z_banks>.
              ENDIF.
              ASSIGN COMPONENT 'Y_ADDRNO' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_y_addrno>)." Address Numner
              IF <lfs_y_addrno> IS ASSIGNED.
                ls_addr-addr_no   = <lfs_y_addrno>.
              ENDIF.
              ASSIGN COMPONENT 'YB_BUILD' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_build>)." Building Code
              IF <lfs_yb_build> IS ASSIGNED.
                ls_addr-build_long  = <lfs_yb_build>.
              ENDIF.
              ASSIGN COMPONENT 'YB_CITY1' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_city>)." City
              IF <lfs_yb_city> IS ASSIGNED.
                ls_addr-city  = <lfs_yb_city>.
              ENDIF.
              ASSIGN COMPONENT 'YB_CITY2' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_city2>)." Other City
              IF <lfs_yb_city2> IS ASSIGNED.
                ls_addr-home_city  = <lfs_yb_city2>.
              ENDIF.
              ASSIGN COMPONENT 'YB_CMNTS' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_cmnts>). " Notes or Comments
              IF <lfs_yb_cmnts> IS ASSIGNED.
                ls_addr-adr_notes = <lfs_yb_cmnts>.
              ENDIF.
              ASSIGN COMPONENT 'YB_CO' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_co>). " Care of
              IF <lfs_yb_co> IS ASSIGNED.
                ls_addr-c_o_name = <lfs_yb_co>.
              ENDIF.
              ASSIGN COMPONENT 'YB_COMM' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_comm>). " Communication Method
              IF <lfs_yb_comm> IS ASSIGNED.
                ls_addr-comm_type = <lfs_yb_comm>.
              ENDIF.
              ASSIGN COMPONENT 'YB_DISTR' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_Distr>). " District
              IF <lfs_yb_Distr> IS ASSIGNED.
                ls_addr-district = <lfs_yb_distr>.
              ENDIF.
              ASSIGN COMPONENT 'YB_EMAIL' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_Email>). " Email Address
              IF <lfs_yb_Email> IS ASSIGNED.
                ls_addr-e_mail = <lfs_yb_email>.
              ENDIF.
              ASSIGN COMPONENT 'YB_FLOOR' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_floor>). " Floor Number
              IF <lfs_yb_floor> IS ASSIGNED.
                ls_addr-floor = <lfs_yb_floor>.
              ENDIF.
              ASSIGN COMPONENT 'YB_FXNMBR' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_fxnmbr>). " Fax Number
              IF <lfs_yb_fxnmbr> IS ASSIGNED.
                ls_addr-fax_number = <lfs_yb_fxnmbr>.
              ENDIF.
              ASSIGN COMPONENT 'YB_FXNTNS' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_fxntns>). " Fax Number Extensions
              IF <lfs_yb_fxntns> IS ASSIGNED.
                ls_addr-fax_extens = <lfs_yb_fxntns>.
              ENDIF.
              ASSIGN COMPONENT 'YB_HSNM' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_hsnm>). " House Number
              IF <lfs_yb_hsnm> IS ASSIGNED.
                ls_addr-house_no = <lfs_yb_hsnm>.
              ENDIF.
              ASSIGN COMPONENT 'YB_HSNM2' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_hssup>). " House Number Suppliment
              IF <lfs_yb_hssup> IS ASSIGNED.
                ls_addr-house_no2 = <lfs_yb_hssup>.
              ENDIF.
              ASSIGN COMPONENT 'YB_LAND1' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_land1>). " Country Key
              IF <lfs_yb_land1> IS ASSIGNED.
                ls_addr-country = <lfs_yb_land1>.
              ENDIF.
              ASSIGN COMPONENT 'YB_LANGU' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_lang>). " Language Key
              IF <lfs_yb_lang> IS ASSIGNED.
                ls_addr-langu = <lfs_yb_lang>.
              ENDIF.
              ASSIGN COMPONENT 'YB_LZONE' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_tzone>). " Tansport Zone
              IF <lfs_yb_tzone> IS ASSIGNED.
                ls_addr-transpzone = <lfs_yb_tzone>.
              ENDIF.
              ASSIGN COMPONENT 'YB_NAME1' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_name1>). " Name1
              IF <lfs_yb_name1> IS ASSIGNED.
                ls_addr-name = <lfs_yb_name1>.
              ENDIF.
              ASSIGN COMPONENT 'YB_NAME2' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_name2>). " Name2
              IF <lfs_yb_name2> IS ASSIGNED.
                ls_addr-name_2 = <lfs_yb_name2>.
              ENDIF.
              ASSIGN COMPONENT 'YB_NAME3' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_name3>). " Name2
              IF <lfs_yb_name3> IS ASSIGNED.
                ls_addr-name_3 = <lfs_yb_name3>.
              ENDIF.
              ASSIGN COMPONENT 'YB_NAME4' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_name4>). " Name4
              IF <lfs_yb_name4> IS ASSIGNED.
                ls_addr-name_4 = <lfs_yb_name4>.
              ENDIF.
              ASSIGN COMPONENT 'YB_NOTES' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_notes>). " Notes/Comments
              IF <lfs_yb_notes> IS ASSIGNED.
                ls_addr-adr_notes = <lfs_yb_notes>.
              ENDIF.
              ASSIGN COMPONENT 'YB_SORT1' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_search1>). " Search Term1
              IF <lfs_yb_search1> IS ASSIGNED.
                ls_addr-sort1 = <lfs_yb_search1>.
              ENDIF.
              ASSIGN COMPONENT 'YB_SORT2' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_search2>). " Search Term2
              IF <lfs_yb_search2> IS ASSIGNED.
                ls_addr-sort2 = <lfs_yb_search2>.
              ENDIF.
              ASSIGN COMPONENT 'YB_STREET' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_street>). " Street Number
              IF <lfs_yb_street> IS ASSIGNED.
                ls_addr-street = <lfs_yb_street>.
              ENDIF.
              ASSIGN COMPONENT 'YB_PSTCD1' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_PSTCD1>). " Postal Code
              IF <lfs_yb_PSTCD1> IS ASSIGNED.
                ls_addr-postl_cod1 = <lfs_yb_pstcd1>.
              ENDIF.
              ASSIGN COMPONENT 'YB_REGION' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_regio>). " Region
              IF <lfs_yb_regio> IS ASSIGNED.
                ls_addr-region = <lfs_yb_regio>.
              ENDIF.

              ASSIGN COMPONENT 'YB_TIMEZONE' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_tmzone>). " Time Zone
              IF <lfs_yb_tmzone> IS ASSIGNED.
                ls_addr-time_zone = <lfs_yb_tmzone>.
              ENDIF.

              ASSIGN COMPONENT 'YB_POBX' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_POBX>). " Po Box
              IF <lfs_yb_pobx> IS ASSIGNED.
                ls_addr-po_box = <lfs_yb_pobx>.
              ENDIF.
              ASSIGN COMPONENT 'YB_PSTCD2' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_PSTCD2>). " Po Box Postal Code
              IF <lfs_yb_pstcd2> IS ASSIGNED.
                ls_addr-postl_cod2 = <lfs_yb_pstcd2>.
              ENDIF.
              ASSIGN COMPONENT 'YB_PSTCD3' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_PSTCD3>). " Company Postal Code
              IF <lfs_yb_pstcd3> IS ASSIGNED.
                ls_addr-postl_cod3 = <lfs_yb_pstcd3>.
              ENDIF.
              ASSIGN COMPONENT 'YB_POBCTY' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_pobcty>). " PO Box City
              IF <lfs_yb_pobcty> IS ASSIGNED.
                ls_addr-po_box_cit = <lfs_yb_pobcty>.
              ENDIF.
              ASSIGN COMPONENT 'YB_POBCTR' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_pobctr>). " PO Box Country/Region
              IF <lfs_yb_pobctr> IS ASSIGNED.
                ls_addr-pobox_ctry = <lfs_yb_pobctr>.
              ENDIF.
              ASSIGN COMPONENT 'YB_POBNUM' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_pobnum>). " Flag PO Box W/o No.
              IF <lfs_yb_pobnum> IS ASSIGNED.
                ls_addr-po_w_o_no = <lfs_yb_pobnum>.
              ENDIF.
              ASSIGN COMPONENT 'YB_pobxrg' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_pobxrg>). " Region for PO Box (Country/Region, State, Province, ...)
              IF <lfs_yb_pobxrg> IS ASSIGNED.
                ls_addr-po_box_reg = <lfs_yb_pobxrg>.
              ENDIF.
              ASSIGN COMPONENT 'YB_POLBY' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_polby>). " PO Box Lobby
              IF <lfs_yb_polby> IS ASSIGNED.
                ls_addr-po_box_lobby = <lfs_yb_polby>.
              ENDIF.
              ASSIGN COMPONENT 'YB_POUND' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_pound>). " PO Box Undelivable flag.
              IF <lfs_yb_pound> IS ASSIGNED.
                ls_addr-dont_use_p = <lfs_yb_pound>.
              ENDIF.
              ASSIGN COMPONENT 'YB_REGGRP' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_REGGRP>). " Regional structure grouping
              IF <lfs_yb_REGGRP> IS ASSIGNED.
                ls_addr-regiogroup = <lfs_yb_REGGRP>.
              ENDIF.

              ASSIGN COMPONENT 'YB_ROOM' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_ROOM>). " Room or Apartment Number
              IF <lfs_yb_ROOM> IS ASSIGNED.
                ls_addr-room_no = <lfs_yb_ROOM>.
              ENDIF.
              ASSIGN COMPONENT 'YB_SERNUM' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_sernum>). " Number of Delivery Service
              IF <lfs_yb_sernum> IS ASSIGNED.
                ls_addr-deli_serv_number = <lfs_yb_sernum>.
              ENDIF.
              ASSIGN COMPONENT 'YB_SRTYPE' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_srtype>). " Type of Delivery Service
              IF <lfs_yb_srtype> IS ASSIGNED.
                ls_addr-deli_serv_type = <lfs_yb_srtype>.
              ENDIF.
              ASSIGN COMPONENT 'YB_STRSP1' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_strsp1>). " Street2
              IF <lfs_yb_strsp1> IS ASSIGNED.
                ls_addr-str_suppl1 = <lfs_yb_strsp1>.
              ENDIF.
              ASSIGN COMPONENT 'YB_STRSP2' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_strsp2>). " Street3
              IF <lfs_yb_strsp2> IS ASSIGNED.
                ls_addr-str_suppl2 = <lfs_yb_strsp2>.
              ENDIF.
              ASSIGN COMPONENT 'YB_STRSP3' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_strsp3>). " Street4
              IF <lfs_yb_strsp3> IS ASSIGNED.
                ls_addr-str_suppl3 = <lfs_yb_strsp3>.
              ENDIF.
              ASSIGN COMPONENT 'YB_STRSP4' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_strsp4>). " Street5
              IF <lfs_yb_strsp4> IS ASSIGNED.
                ls_addr-location = <lfs_yb_strsp4>.
              ENDIF.
              ASSIGN COMPONENT 'YB_STUND' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_stund>). "Undeliverable
              IF <lfs_yb_stund> IS ASSIGNED.
                ls_addr-dont_use_s = <lfs_yb_stund>.
              ENDIF.
              ASSIGN COMPONENT 'YB_TLNMBR' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_tlnmbr1>). "Telephone Number1
              IF <lfs_yb_tlnmbr1> IS ASSIGNED.
                ls_addr-tel1_numbr = <lfs_yb_tlnmbr1>.
              ENDIF.
              ASSIGN COMPONENT 'YB_TLXTNS' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_tlxtns1>). "Telephone Number extension
              IF <lfs_yb_tlxtns1> IS ASSIGNED.
                ls_addr-tel1_ext = <lfs_yb_tlxtns1>.
              ENDIF.
              ASSIGN COMPONENT 'YB_TXJCD' OF STRUCTURE <lfs_addr_ins> TO FIELD-SYMBOL(<lfs_yb_txjcd>). "Tax Jurisidication
              IF <lfs_yb_txjcd> IS ASSIGNED.
                ls_addr-taxjurcode = <lfs_yb_txjcd>.
              ENDIF.
              APPEND ls_addr TO lt_addr.
            ENDLOOP.
          ELSEIF lcl_data_updated IS NOT INITIAL. "Update
            DATA(lv_addr_update) = abap_true. "Address Data Updated
            ASSIGN lcl_data_updated->* TO <lfs_bnk_save>.
            LOOP AT <lfs_bnk_save> ASSIGNING <lfs_addr_upd>.
              ASSIGN COMPONENT 'Y_BANKL' OF STRUCTURE <lfs_addr_upd> TO <lfs_z_bankl>."Bank Key
              IF <lfs_z_bankl> IS ASSIGNED.
                ls_bnka-bankl = <lfs_z_bankl>.
              ENDIF.
              ASSIGN COMPONENT 'Y_BANKS' OF STRUCTURE <lfs_addr_upd> TO <lfs_z_banks>." Bank Country Leading Entity Type BANKS
              IF <lfs_z_banks> IS  ASSIGNED.
                ls_bnka-banks   = <lfs_z_banks>.
              ENDIF.
              ASSIGN COMPONENT 'Y_ADDRNO' OF STRUCTURE <lfs_addr_upd> TO <lfs_y_addrno>." Address Numner
              IF <lfs_y_addrno> IS ASSIGNED.
                ls_addr-addr_no   = <lfs_y_addrno>.
              ENDIF.
              ASSIGN COMPONENT 'YB_BUILD' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_build>." Building Code
              IF <lfs_yb_build> IS ASSIGNED.
                ls_addr-build_long  = <lfs_yb_build>.
              ENDIF.
              ASSIGN COMPONENT 'YB_CITY1' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_city>." City
              IF <lfs_yb_city> IS ASSIGNED.
                ls_addr-city  = <lfs_yb_city>.
              ENDIF.
              ASSIGN COMPONENT 'YB_CITY2' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_city2>." Other City
              IF <lfs_yb_city2> IS ASSIGNED.
                ls_addr-home_city  = <lfs_yb_city2>.
              ENDIF.
              ASSIGN COMPONENT 'YB_CMNTS' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_cmnts>. " Notes or Comments
              IF <lfs_yb_cmnts> IS ASSIGNED.
                ls_addr-adr_notes = <lfs_yb_cmnts>.
              ENDIF.
              ASSIGN COMPONENT 'YB_CO' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_co>. " Care of
              IF <lfs_yb_co> IS ASSIGNED.
                ls_addr-c_o_name = <lfs_yb_co>.
              ENDIF.
              ASSIGN COMPONENT 'YB_COMM' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_comm>. " Communication Method
              IF <lfs_yb_comm> IS ASSIGNED.
                ls_addr-comm_type = <lfs_yb_comm>.
              ENDIF.
              ASSIGN COMPONENT 'YB_DISTR' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_Distr>. " District
              IF <lfs_yb_Distr> IS ASSIGNED.
                ls_addr-district = <lfs_yb_distr>.
              ENDIF.
              ASSIGN COMPONENT 'YB_EMAIL' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_Email>. " Email Address
              IF <lfs_yb_Email> IS ASSIGNED.
                ls_addr-e_mail = <lfs_yb_email>.
              ENDIF.
              ASSIGN COMPONENT 'YB_FLOOR' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_floor>. " Floor Number
              IF <lfs_yb_floor> IS ASSIGNED.
                ls_addr-floor = <lfs_yb_floor>.
              ENDIF.
              ASSIGN COMPONENT 'YB_FXNMBR' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_fxnmbr>. " Fax Number
              IF <lfs_yb_fxnmbr> IS ASSIGNED.
                ls_addr-fax_number = <lfs_yb_fxnmbr>.
              ENDIF.
              ASSIGN COMPONENT 'YB_FXNTNS' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_fxntns>. " Fax Number Extensions
              IF <lfs_yb_fxntns> IS ASSIGNED.
                ls_addr-fax_extens = <lfs_yb_fxntns>.
              ENDIF.
              ASSIGN COMPONENT 'YB_HSNM' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_hsnm>. " House Number
              IF <lfs_yb_hsnm> IS ASSIGNED.
                ls_addr-house_no = <lfs_yb_hsnm>.
              ENDIF.
              ASSIGN COMPONENT 'YB_HSNM2' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_hssup>. " House Number Suppliment
              IF <lfs_yb_hssup> IS ASSIGNED.
                ls_addr-house_no2 = <lfs_yb_hssup>.
              ENDIF.
              ASSIGN COMPONENT 'YB_LAND1' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_land1>. " Country Key
              IF <lfs_yb_land1> IS ASSIGNED.
                ls_addr-country = <lfs_yb_land1>.
              ENDIF.
              ASSIGN COMPONENT 'YB_LANGU' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_lang>. " Language Key
              IF <lfs_yb_lang> IS ASSIGNED.
                ls_addr-langu = <lfs_yb_lang>.
              ENDIF.
              ASSIGN COMPONENT 'YB_LZONE' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_tzone>. " Tansport Zone
              IF <lfs_yb_tzone> IS ASSIGNED.
                ls_addr-transpzone = <lfs_yb_tzone>.
              ENDIF.
              ASSIGN COMPONENT 'YB_NAME1' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_name1>. " Name1
              IF <lfs_yb_name1> IS ASSIGNED.
                ls_addr-name = <lfs_yb_name1>.
              ENDIF.
              ASSIGN COMPONENT 'YB_NAME2' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_name2>. " Name2
              IF <lfs_yb_name2> IS ASSIGNED.
                ls_addr-name_2 = <lfs_yb_name2>.
              ENDIF.
              ASSIGN COMPONENT 'YB_NAME3' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_name3>. " Name2
              IF <lfs_yb_name3> IS ASSIGNED.
                ls_addr-name_3 = <lfs_yb_name3>.
              ENDIF.
              ASSIGN COMPONENT 'YB_NAME4' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_name4>. " Name4
              IF <lfs_yb_name4> IS ASSIGNED.
                ls_addr-name_4 = <lfs_yb_name4>.
              ENDIF.
              ASSIGN COMPONENT 'YB_NOTES' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_notes>. " Notes/Comments
              IF <lfs_yb_notes> IS ASSIGNED.
                ls_addr-adr_notes = <lfs_yb_notes>.
              ENDIF.
              ASSIGN COMPONENT 'YB_SORT1' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_search1>. " Search Term1
              IF <lfs_yb_search1> IS ASSIGNED.
                ls_addr-sort1 = <lfs_yb_search1>.
              ENDIF.
              ASSIGN COMPONENT 'YB_SORT2' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_search2>. " Search Term2
              IF <lfs_yb_search2> IS ASSIGNED.
                ls_addr-sort2 = <lfs_yb_search2>.
              ENDIF.
              ASSIGN COMPONENT 'YB_STREET' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_street>. " Street Number
              IF <lfs_yb_street> IS ASSIGNED.
                ls_addr-street = <lfs_yb_street>.
              ENDIF.
              ASSIGN COMPONENT 'YB_PSTCD1' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_PSTCD1>. " Postal Code
              IF <lfs_yb_PSTCD1> IS ASSIGNED.
                ls_addr-postl_cod1 = <lfs_yb_pstcd1>.
              ENDIF.
              ASSIGN COMPONENT 'YB_REGION' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_regio>. " Region
              IF <lfs_yb_regio> IS ASSIGNED.
                ls_addr-region = <lfs_yb_regio>.
              ENDIF.

              ASSIGN COMPONENT 'YB_TIMEZONE' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_tmzone>. " Time Zone
              IF <lfs_yb_tmzone> IS ASSIGNED.
                ls_addr-time_zone = <lfs_yb_tmzone>.
              ENDIF.

              ASSIGN COMPONENT 'YB_POBX' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_POBX>. " Po Box
              IF <lfs_yb_pobx> IS ASSIGNED.
                ls_addr-po_box = <lfs_yb_pobx>.
              ENDIF.
              ASSIGN COMPONENT 'YB_PSTCD2' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_PSTCD2>. " Po Box Postal Code
              IF <lfs_yb_pstcd2> IS ASSIGNED.
                ls_addr-postl_cod2 = <lfs_yb_pstcd2>.
              ENDIF.
              ASSIGN COMPONENT 'YB_PSTCD3' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_PSTCD3>. " Company Postal Code
              IF <lfs_yb_pstcd3> IS ASSIGNED.
                ls_addr-postl_cod3 = <lfs_yb_pstcd3>.
              ENDIF.
              ASSIGN COMPONENT 'YB_POBCTY' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_pobcty>. " PO Box City
              IF <lfs_yb_pobcty> IS ASSIGNED.
                ls_addr-po_box_cit = <lfs_yb_pobcty>.
              ENDIF.
              ASSIGN COMPONENT 'YB_POBCTR' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_pobctr>. " PO Box Country/Region
              IF <lfs_yb_pobctr> IS ASSIGNED.
                ls_addr-pobox_ctry = <lfs_yb_pobctr>.
              ENDIF.
              ASSIGN COMPONENT 'YB_POBNUM' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_pobnum>. " Flag PO Box W/o No.
              IF <lfs_yb_pobnum> IS ASSIGNED.
                ls_addr-po_w_o_no = <lfs_yb_pobnum>.
              ENDIF.
              ASSIGN COMPONENT 'YB_pobxrg' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_pobxrg>. " Region for PO Box (Country/Region, State, Province, ...
              IF <lfs_yb_pobxrg> IS ASSIGNED.
                ls_addr-po_box_reg = <lfs_yb_pobxrg>.
              ENDIF.
              ASSIGN COMPONENT 'YB_POLBY' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_polby>. " PO Box Lobby
              IF <lfs_yb_polby> IS ASSIGNED.
                ls_addr-po_box_lobby = <lfs_yb_polby>.
              ENDIF.
              ASSIGN COMPONENT 'YB_POUND' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_pound>. " PO Box Undelivable flag.
              IF <lfs_yb_pound> IS ASSIGNED.
                ls_addr-dont_use_p = <lfs_yb_pound>.
              ENDIF.
              ASSIGN COMPONENT 'YB_REGGRP' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_REGGRP>. " Regional structure grouping
              IF <lfs_yb_REGGRP> IS ASSIGNED.
                ls_addr-regiogroup = <lfs_yb_REGGRP>.
              ENDIF.

              ASSIGN COMPONENT 'YB_ROOM' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_ROOM>. " Room or Apartment Number
              IF <lfs_yb_ROOM> IS ASSIGNED.
                ls_addr-room_no = <lfs_yb_ROOM>.
              ENDIF.
              ASSIGN COMPONENT 'YB_SERNUM' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_sernum>. " Number of Delivery Service
              IF <lfs_yb_sernum> IS ASSIGNED.
                ls_addr-deli_serv_number = <lfs_yb_sernum>.
              ENDIF.
              ASSIGN COMPONENT 'YB_SRTYPE' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_srtype>. " Type of Delivery Service
              IF <lfs_yb_srtype> IS ASSIGNED.
                ls_addr-deli_serv_type = <lfs_yb_srtype>.
              ENDIF.
              ASSIGN COMPONENT 'YB_STRSP1' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_strsp1>. " Street2
              IF <lfs_yb_strsp1> IS ASSIGNED.
                ls_addr-str_suppl1 = <lfs_yb_strsp1>.
              ENDIF.
              ASSIGN COMPONENT 'YB_STRSP2' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_strsp2>. " Street3
              IF <lfs_yb_strsp2> IS ASSIGNED.
                ls_addr-str_suppl2 = <lfs_yb_strsp2>.
              ENDIF.
              ASSIGN COMPONENT 'YB_STRSP3' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_strsp3>. " Street4
              IF <lfs_yb_strsp3> IS ASSIGNED.
                ls_addr-str_suppl3 = <lfs_yb_strsp3>.
              ENDIF.
              ASSIGN COMPONENT 'YB_STRSP4' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_strsp4>. " Street5
              IF <lfs_yb_strsp4> IS ASSIGNED.
                ls_addr-location = <lfs_yb_strsp4>.
              ENDIF.
              ASSIGN COMPONENT 'YB_STUND' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_stund>. "Undeliverable
              IF <lfs_yb_stund> IS ASSIGNED.
                ls_addr-dont_use_s = <lfs_yb_stund>.
              ENDIF.
              ASSIGN COMPONENT 'YB_TLNMBR' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_tlnmbr1>. "Telephone Number1
              IF <lfs_yb_tlnmbr1> IS ASSIGNED.
                ls_addr-tel1_numbr = <lfs_yb_tlnmbr1>.
              ENDIF.
              ASSIGN COMPONENT 'YB_TLXTNS' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_tlxtns1>. "Telephone Number extension
              IF <lfs_yb_tlxtns1> IS ASSIGNED.
                ls_addr-tel1_ext = <lfs_yb_tlxtns1>.
              ENDIF.
              ASSIGN COMPONENT 'YB_TXJCD' OF STRUCTURE <lfs_addr_upd> TO <lfs_yb_txjcd>. "Tax Jurisidication
              IF <lfs_yb_txjcd> IS ASSIGNED.
                ls_addr-taxjurcode = <lfs_yb_txjcd>.
              ENDIF.
              APPEND ls_addr TO lt_addr.

              ASSIGN COMPONENT 'USMDX_S_UPDATE' OF STRUCTURE <lfs_addr_upd> TO FIELD-SYMBOL(<lfs_address1>).
              IF <lfs_address1> IS ASSIGNED.
                ASSIGN COMPONENT 'YB_BUILD' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybuildx>)." Building Code
                IF <lfs_ybuildx> IS ASSIGNED AND <lfs_ybuildx> EQ abap_true.
                  ls_address1x-building = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_CITY1' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybcityx>)." City
                IF <lfs_ybcityx> IS ASSIGNED AND <lfs_ybcityx> EQ abap_true.
                  ls_address1x-city = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_CITY2' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybcity2x>)." Other City
                IF <lfs_ybcity2x> IS ASSIGNED AND <lfs_ybcity2x> EQ abap_true.
                  ls_address1x-home_city = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_CMNTS' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybcmntsx>). " Notes or Comments
                IF <lfs_ybcmntsx> IS ASSIGNED AND <lfs_ybcmntsx> EQ abap_true.
                  ls_address1x-adr_notes = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_CO' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybcox>). " Care of
                IF <lfs_ybcox> IS ASSIGNED AND <lfs_ybcox> EQ abap_true.
                  ls_address1x-c_o_name = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_COMM' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybcommx>). " Communication Method
                IF <lfs_ybcommx> IS ASSIGNED AND <lfs_ybcommx> EQ abap_true.
                  ls_address1x-comm_type = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_DISTR' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybdistrx>). " District
                IF <lfs_ybdistrx> IS ASSIGNED AND <lfs_ybdistrx> EQ abap_true.
                  ls_address1x-district = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_EMAIL' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybemailx>). " Email Address
                IF <lfs_ybemailx> IS ASSIGNED AND <lfs_ybemailx> EQ abap_true.
                  ls_address1x-e_mail = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_FLOOR' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybfloorx>). " Floor Number
                IF <lfs_ybfloorx> IS ASSIGNED AND <lfs_ybfloorx> EQ abap_true.
                  ls_address1x-floor = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_FXNMBR' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybfxnmbrx>). " Fax Number
                IF <lfs_ybfxnmbrx> IS ASSIGNED AND <lfs_ybfxnmbrx> EQ abap_true.
                  ls_address1x-fax_number = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_FXNTNS' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybfxntns>). " Fax Number Extensions
                IF <lfs_ybfxntns> IS ASSIGNED AND <lfs_ybfxntns> EQ abap_true.
                  ls_address1x-fax_extens = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_HSNM' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybhsnmx>). " House Number
                IF <lfs_ybhsnmx> IS ASSIGNED AND <lfs_ybhsnmx> EQ abap_true.
                  ls_address1x-house_no = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_HSNM2' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybhssupx>). " House Number Suppliment
                IF <lfs_ybhssupx> IS ASSIGNED AND <lfs_ybhssupx> EQ abap_true.
                  ls_address1x-house_no2 = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_LAND1' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybland1x>). " Country Key
                IF <lfs_ybland1x> IS ASSIGNED AND <lfs_ybland1x> EQ abap_true.
                  ls_address1x-country = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_LANGU' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_yblangx>). " Language Key
                IF <lfs_yblangx> IS ASSIGNED AND <lfs_yblangx> EQ abap_true.
                  ls_address1x-langu = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_LZONE' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybtzonex>). " Tansport Zone
                IF <lfs_ybtzonex> IS ASSIGNED AND <lfs_ybtzonex> EQ abap_true.
                  ls_address1x-transpzone = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_NAME1' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybname1x>). " Name1
                IF <lfs_ybname1x> IS ASSIGNED AND <lfs_ybname1x> EQ abap_true.
                  ls_address1x-name = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_NAME2' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybname2x>). " Name2
                IF <lfs_ybname2x> IS ASSIGNED AND <lfs_ybname2x> EQ abap_true.
                  ls_address1x-name_2 = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_NAME3' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybname3x>). " Name2
                IF <lfs_ybname3x> IS ASSIGNED AND <lfs_ybname3x> EQ abap_true.
                  ls_address1x-name_3 = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_NAME4' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybname4x>). " Name4
                IF <lfs_ybname4x> IS ASSIGNED AND <lfs_ybname4x> EQ abap_true.
                  ls_address1x-name_4 = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_NOTES' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybnotesx>). " Notes/Comments
                IF <lfs_ybnotesx> IS ASSIGNED AND <lfs_ybnotesx> EQ abap_true.
                  ls_address1x-adr_notes = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_SORT1' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybsearch1x>). " Search Term1
                IF <lfs_ybsearch1x> IS ASSIGNED AND <lfs_ybsearch1x> EQ abap_true.
                  ls_address1x-sort1 = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_SORT2' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybsearch2x>). " Search Term2
                IF <lfs_ybsearch2x> IS ASSIGNED AND <lfs_ybsearch2x> EQ abap_true.
                  ls_address1x-sort2 = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_STREET' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybstreetx>). " Street Number
                IF <lfs_ybstreetx> IS ASSIGNED AND <lfs_ybstreetx> EQ abap_true.
                  ls_address1x-street = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_PSTCD1' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybpstcd1x>). " Postal Code
                IF <lfs_ybpstcd1x> IS ASSIGNED AND <lfs_ybpstcd1x> EQ abap_true.
                  ls_address1x-postl_cod1 = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_REGION' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybregionx>). " Region
                IF <lfs_ybregionx> IS ASSIGNED AND <lfs_ybregionx> EQ abap_true.
                  ls_address1x-region = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_TIMEZONE' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybtmzonex>). " Time Zone
                IF <lfs_ybtmzonex> IS ASSIGNED AND <lfs_ybtmzonex> EQ abap_true.
                  ls_address1x-time_zone = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_POBX' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybpobx>). " Po Box
                IF <lfs_ybpobx> IS ASSIGNED AND <lfs_ybpobx> EQ abap_true.
                  ls_address1x-po_box = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_PSTCD2' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybpstcd2x>). " Po Box Postal Code
                IF <lfs_ybpstcd2x> IS ASSIGNED AND <lfs_ybpstcd2x> EQ abap_true.
                  ls_address1x-postl_cod2 = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_PSTCD3' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybPSTCD3x>). " Company Postal Code
                IF <lfs_ybpstcd3x> IS ASSIGNED AND <lfs_ybpstcd3x> EQ abap_true.
                  ls_address1x-postl_cod3 = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_POBCTY' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybpobctyx>). " PO Box City
                IF <lfs_ybpobctyx> IS ASSIGNED AND <lfs_ybpobctyx> EQ abap_true.
                  ls_address1x-po_box_cit = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_POBCTR' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybpobctrx>). " PO Box Country/Region
                IF <lfs_ybpobctrx> IS ASSIGNED AND <lfs_ybpobctrx> EQ abap_true.
                  ls_address1x-pobox_ctry = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_POBNUM' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybpobnumx>). " Flag PO Box W/o No.
                IF <lfs_ybpobnumx> IS ASSIGNED AND <lfs_ybpobnumx> EQ abap_true.
                  ls_address1x-po_w_o_no = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_pobxrg' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybpobxrgx>). " Region for PO Box (Country/Region, State, Province, ...
                IF <lfs_ybpobxrgx> IS ASSIGNED AND <lfs_ybpobxrgx> EQ abap_true.
                  ls_address1x-po_box_reg = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_POLBY' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybpolyx>). " PO Box Lobby
                IF <lfs_ybpolyx> IS ASSIGNED AND <lfs_ybpolyx> EQ abap_true.
                  ls_address1x-po_box_lobby = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_POUND' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybpoundx>). " PO Box Undelivable flag.
                IF <lfs_ybpoundx> IS ASSIGNED AND <lfs_ybpoundx> EQ abap_true.
                  ls_address1x-dont_use_p = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_REGGRP' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybreggrpx>). " Regional structure grouping
                IF <lfs_ybreggrpx> IS ASSIGNED AND <lfs_ybreggrpx> EQ abap_true.
                  ls_address1x-regiogroup = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_ROOM' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybroomx>). " Room or Apartment Number
                IF <lfs_ybroomx> IS ASSIGNED AND <lfs_ybroomx> EQ abap_true.
                  ls_address1x-room_no = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_SERNUM' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybsernumx>). " Number of Delivery Service
                IF <lfs_ybsernumx> IS ASSIGNED AND <lfs_ybsernumx> EQ abap_true.
                  ls_address1x-deli_serv_number = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_SRTYPE' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybsrtypex>). " Type of Delivery Service
                IF <lfs_ybsrtypex> IS ASSIGNED AND <lfs_ybsrtypex> EQ abap_true.
                  ls_address1x-deli_serv_type = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_STRSP1' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybstrsp1x>). " Street2
                IF <lfs_ybstrsp1x> IS ASSIGNED AND <lfs_ybstrsp1x> EQ abap_true.
                  ls_address1x-str_suppl1 = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_STRSP2' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybstrsp2x>). " Street3
                IF <lfs_ybstrsp2x> IS ASSIGNED AND <lfs_ybstrsp2x> EQ abap_true.
                  ls_address1x-str_suppl2 = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_STRSP3' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybstrsp3x>). " Street4
                IF <lfs_ybstrsp3x> IS ASSIGNED AND <lfs_ybstrsp3x> EQ abap_true.
                  ls_address1x-str_suppl3 = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_STRSP4' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybstrsp4x>). " Street5
                IF <lfs_ybstrsp4x> IS ASSIGNED AND <lfs_ybstrsp4x> EQ abap_true.
                  ls_address1x-location = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_STUND' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybstundx>). "Undeliverable
                IF <lfs_ybstundx> IS ASSIGNED AND <lfs_ybstundx> EQ abap_true.
                  ls_address1x-dont_use_s = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_TLNMBR' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybtlnmbr1x>). "Telephone Number1
                IF <lfs_ybtlnmbr1x> IS ASSIGNED AND <lfs_ybtlnmbr1x> EQ abap_true.
                  ls_address1x-tel1_numbr = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_TLXTNS' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybtlxtns1x>). "Telephone Number extension
                IF <lfs_ybtlxtns1x> IS ASSIGNED AND <lfs_ybtlxtns1x> EQ abap_true.
                  ls_address1x-tel1_ext = abap_true.
                ENDIF.
                ASSIGN COMPONENT 'YB_TXJCD' OF STRUCTURE <lfs_address1> TO FIELD-SYMBOL(<lfs_ybtxjcdx>). "Tax Jurisidication
                IF <lfs_ybtxjcdx> IS ASSIGNED AND <lfs_ybtxjcdx> EQ abap_true.
                  ls_address1x-taxjurcode = abap_true.
                ENDIF.
              ENDIF.
            ENDLOOP.
*            ls_address1x-name = abap_true.
*            ls_address1x-country = abap_true.
*            ls_address1x-langu = abap_true.
*            ls_address1x-postl_cod1 = abap_true.
*            ls_address1x-region = abap_true.
          ENDIF.

*          ---------------EOC: to handle create and change scenarios-------------ENTITY = 'Y_ADDRESS'
      ENDCASE.
    ENDLOOP.



**********************************************Calling of respective BAPI function modules for create and change*********
************************************************************************************************************************
    "If All the data has been fetched from the staging tables ten save into the Persistance table

    IF ( ( lv_bank_insert = abap_true ) OR ( lv_bank_insert = abap_true AND lv_addr_insert = abap_true ) )." Create Scenario
      CALL FUNCTION 'YZ_FUNC_YB_BANK'  " Not called here in update task because in standard it is taking care and updating in update task
        EXPORTING
          lt_bank   = lt_bnka               " Bank master record
          lt_addr   = lt_addr
          iv_create = 'X'.                " Boolean Variable (X = True, - = False, Space = Unknown)

    ELSEIF ( ( lv_bank_update = abap_false AND lv_addr_insert = abap_true AND lv_addr_update = abap_false )
       AND ( ls_detailx-bank_delete = abap_false ) ). " Advance Address insert during Change CR; No Bank Update
      ls_addressx-addr_no = abap_true.
      CALL FUNCTION 'YZ_FUNC_YB_BANK'
        EXPORTING
          lt_bank      = lt_bnka               " Bank master record
          lt_addr      = lt_addr                " Table Type for address
          iv_change    = 'X'                 " Boolean Variable (X = True, - = False, Space = Unknown)
          iv_addressx  = ls_addressx
          iv_bank_ctry = ls_bnka-banks                 " Country/Region Key of Bank
          iv_bank_key  = ls_bnka-bankl.                " Bank Keys

    ELSEIF ( ( lv_bank_update = abap_true AND lv_addr_insert = abap_false AND lv_addr_update = abap_true )
     AND ( ls_detailx-bank_delete = abap_false ) ). "Bank Update + Address Update
      CALL FUNCTION 'YZ_FUNC_YB_BANK'  " Not called here in update task because in standard it is taking care and updating in update task
        EXPORTING
          lt_bank      = lt_bnka               " Bank master record
          lt_addr      = lt_addr
          iv_addressx  = ls_addressx
          iv_address1x = ls_address1x
          iv_change    = 'X'.                 " Boolean Variable (X = True, - = False, Space = Unknown)

    ELSEIF ( ( lv_bank_update = abap_true AND lv_addr_insert = abap_true AND lv_addr_update = abap_false )
       AND ( ls_detailx-bank_delete = abap_false ) ). "Bank Update + Address Insert
      CALL FUNCTION 'YZ_FUNC_YB_BANK'
        EXPORTING
          lt_bank      = lt_bnka               " Bank master record
          lt_addr      = lt_addr               " Table Type for address
          iv_change    = 'X'              " Boolean Variable (X = True, - = False, Space = Unknown)
          iv_addressx  = ls_addressx               " Transfer structure object 1011: Bank
          iv_bank_ctry = ls_bnka-banks                " Country/Region Key of Bank
          iv_bank_key  = ls_bnka-bankl.               " Bank Keys.

    ELSEIF ( ( lv_bank_update = abap_true AND lv_addr_insert = abap_false AND lv_addr_update = abap_false )
       AND ( ls_detailx-bank_delete = abap_false ) ). "Only Bank Update
      CALL FUNCTION 'YZ_FUNC_YB_BANK'
        EXPORTING
          lt_bank      = lt_bnka                " Bank master record
          iv_change    = 'X'               " Boolean Variable (X = True, - = False, Space = Unknown)
          iv_addressx  = ls_addressx               " Transfer structure object 1011: Bank
          iv_bank_ctry = ls_bnka-banks                " Country/Region Key of Bank
          iv_bank_key  = ls_bnka-bankl.                " Bank Keys

    ELSEIF ( ( lv_bank_update = abap_false AND lv_addr_insert = abap_false AND lv_addr_update = abap_true )
      AND ( ls_detailx-bank_delete = abap_false ) ). "Only Address Update
      CALL FUNCTION 'YZ_FUNC_YB_BANK'
        EXPORTING
          lt_bank      = lt_bnka                " Bank master record
          lt_addr      = lt_addr                " Table Type for address
          iv_change    = 'X'               " Boolean Variable (X = True, - = False, Space = Unknown)
          iv_addressx  = ls_addressx                " Transfer structure object 1011: Bank
          iv_address1x = ls_address1x                " BAPI change reference structure for addresses (Org./Company)
          iv_bank_ctry = ls_bnka-banks                " Country/Region Key of Bank
          iv_bank_key  = ls_bnka-bankl.               " Bank Keys

    ELSEIF ( lv_bank_update = abap_true AND ( lv_addr_insert = abap_false OR lv_addr_update = abap_false )
     AND ( ls_detailx-bank_delete = abap_true ) )."Mark For Delete Scenario
      CALL FUNCTION 'YZ_FUNC_YB_BANK'
        EXPORTING
          lt_bank    = lt_bnka                  " Bank master record
          iv_delete  = 'X'                " Boolean Variable (X = True, - = False, Space = Unknown)
*         iv_addressx =                  " Transfer structure object 1011: Bank
          iv_detailx = ls_detailx.                 " Transfer structure object 1011: Bank detail
    ENDIF.
    CLEAR :         lcl_data_inserted,
                    lcl_data_deleted,
                    lcl_data_updated.
  ENDMETHOD.


  METHOD if_usmd_pp_hana_search~adapt_result_list.
*    DATA: lt_reuse_data         LIKE it_reuse_data,
*          lt_staging_components TYPE abap_component_tab,
*          lr_export_r_data      TYPE REF TO data,
*          lr_export_r_data1     TYPE REF TO data,
*          ldo_dref              TYPE REF TO data,
*          ld_ruleset            TYPE abap_bool.
*    CONSTANTS: lc_active(1) TYPE c VALUE '1',
*               lc_score     TYPE string VALUE '_SCORE'.
*
*    IF it_reuse_data_mdg_names IS NOT INITIAL.
*      lt_reuse_data = it_reuse_data_mdg_names. "ruleset
*      ld_ruleset = abap_true.
*    ELSE.
*      lt_reuse_data = it_reuse_data. "no ruleset
*      ld_ruleset = abap_false.
*    ENDIF.
*    CLEAR: et_data.
*
**    IF is_search_context-entity_main EQ 'Y_BANKL' and ir_staging_struct_type_ref is NOT INITIAL.
**      "Set Reuse mapping
**
**    ENDIF.
*    lt_staging_components = ir_staging_struct_type_ref->get_components( ).
*
*    LOOP AT lt_reuse_data ASSIGNING FIELD-SYMBOL(<ls_reuse_data>).
*      IF <ls_reuse_data> IS ASSIGNED.
*        INSERT <ls_reuse_data> INTO TABLE et_data ASSIGNING FIELD-SYMBOL(<ls_export_data>).
**        IF <ls_export_data> IS ASSIGNED.
**          CLEAR <ls_export_data>-r_data.
**          ASSIGN <ls_reuse_data>-r_data->* TO FIELD-SYMBOL(<ls_reuse_r_data>).
**          CREATE DATA lr_export_r_data TYPE HANDLE ir_staging_struct_type_ref.
**          ASSIGN lr_export_r_data->* TO FIELD-SYMBOL(<ls_export_r_data>).
**
**          LOOP AT lt_staging_components ASSIGNING FIELD-SYMBOL(<ls_staging_component>).
**            CASE <ls_staging_component>-name.
**              WHEN lc_active.
**                ASSIGN COMPONENT <ls_staging_component>-name OF STRUCTURE <ls_export_data> TO FIELD-SYMBOL(<ld_export>).
**                IF <ld_export> IS ASSIGNED.
**                  <ld_export> = lc_active.
**                ENDIF.
**              WHEN lc_score.
**                ASSIGN COMPONENT <ls_staging_component>-name OF STRUCTURE <ls_export_data> TO <ld_export>.
**                check sy-subrc is INITIAL.
**                ASSIGN COMPONENT <ls_staging_component>-name OF STRUCTURE <ls_reuse_r_data> TO FIELD-SYMBOL(<ld_reuse>).
**                check sy-subrc is INITIAL.
**                <ld_export> = <ld_reuse>.
**              when OTHERS.
**                IF ld_ruleset is INITIAL.
**
**                ENDIF.
**            ENDCASE.
**          ENDLOOP.
**          <ls_export_data>-r_data = lr_export_r_data.
**        ENDIF.
*      ENDIF.
*    ENDLOOP.
    CLEAR et_data.
    et_data = it_reuse_data_mdg_names.
    LOOP AT et_data ASSIGNING FIELD-SYMBOL(<fs_data>).
      <fs_data>-f_active = 1.
    ENDLOOP.

  ENDMETHOD.


  METHOD if_usmd_pp_hana_search~adapt_sel_fields.

  ENDMETHOD.


  method IF_USMD_PP_HANA_SEARCH~ADAPT_WHERE_CLAUSE.
  endmethod.


  METHOD if_usmd_pp_hana_search~get_mapping_info.
    DATA:
      ls_message TYPE usmd_s_message.

    FIELD-SYMBOLS:
      <ls_reuse_fmap>   LIKE LINE OF gt_reuse_fmap,
      <ls_mapping_info> LIKE LINE OF ct_mapping_info.

    CLEAR et_messages.

    IF is_search_context-entity_main EQ 'Y_BANKL'.
      me->set_reuse_mapping( ).
    ELSE.
      RETURN.
    ENDIF.

* Add reuse field name
    LOOP AT ct_mapping_info ASSIGNING <ls_mapping_info>
      WHERE reuse_view_fieldname IS INITIAL.

      READ TABLE gt_reuse_fmap
        WITH KEY model           = gc_model
                 entity          = <ls_mapping_info>-entity
                 model_fieldname = <ls_mapping_info>-model_fieldname
       ASSIGNING <ls_reuse_fmap>.
      IF sy-subrc IS INITIAL.
        MOVE-CORRESPONDING <ls_reuse_fmap>   TO <ls_mapping_info>.
        <ls_mapping_info>-reuse_view_fieldname = <ls_reuse_fmap>-reuse_fieldname.
*        IF <ls_reuse_fmap>-deviating_fieldname IS INITIAL.
*          <ls_mapping_info>-reuse_view_fieldname = <ls_reuse_fmap>-reuse_fieldname.
*        ELSE.
*          <ls_mapping_info>-reuse_view_fieldname = <ls_reuse_fmap>-deviating_fieldname.
*        ENDIF.
      ELSE.
        IF <ls_mapping_info>-model_fieldname = 'Y_BANKL'.
          <ls_mapping_info>-reuse_view_fieldname = 'BANKL'.
          <ls_mapping_info>-reuse_rollname = 'BANKK'.
        ELSEIF <ls_mapping_info>-model_fieldname = 'Y_BANKS'.
          <ls_mapping_info>-reuse_view_fieldname = 'BANKS'.
          <ls_mapping_info>-reuse_rollname = 'BANKS'.
        ENDIF.
      ENDIF.
    ENDLOOP.
*    DATA: lt_mapping_info_temp TYPE  mdg_hdb_tt_reuse_mapping.
**    DATA: lt_mapping_info_temp1 TYPE  mdg_hdb_tt_reuse_mapping.
*    DATA: lt_mapping_info      TYPE  mdg_hdb_tt_reuse_mapping,
*          lw_mapping_info      LIKE LINE OF lt_mapping_info,
*          lw_mapping_info_temp LIKE LINE OF lt_mapping_info.
*
*    lt_mapping_info[] = ct_mapping_info[].
*    LOOP AT lt_mapping_info INTO lw_mapping_info.
*      CASE lw_mapping_info-model_fieldname.
*        WHEN 'Y_BANKL'.
*          lw_mapping_info_temp-entity = lw_mapping_info-entity.
*          lw_mapping_info_temp-model_fieldname = lw_mapping_info-model_fieldname.
*          lw_mapping_info_temp-reuse_view_fieldname = 'BANKL'.
*          lw_mapping_info_temp-reuse_rollname = 'BANKK'.
**          lt_mapping_info_temp = value #( ( entity = lw_mapping_info-entity model_fieldname = lw_mapping_info-model_fieldname reuse_view_fieldname = 'BANKL' reuse_rollname = 'BANKK' ) ).
*        WHEN 'Y_BANKS'.
*          lw_mapping_info_temp-entity = lw_mapping_info-entity.
*          lw_mapping_info_temp-model_fieldname = lw_mapping_info-model_fieldname.
*          lw_mapping_info_temp-reuse_view_fieldname = 'BANKS'.
*          lw_mapping_info_temp-reuse_rollname = 'BANKS'.
**          lt_mapping_info_temp = value #( ( entity = lw_mapping_info-entity model_fieldname = lw_mapping_info-model_fieldname reuse_view_fieldname = 'BANKS' reuse_rollname = 'BANKS' ) ).
*          WHEN 'YB_ORT01'.
*           lw_mapping_info_temp-entity = lw_mapping_info-entity.
*          lw_mapping_info_temp-model_fieldname = lw_mapping_info-model_fieldname.
*          lw_mapping_info_temp-reuse_view_fieldname = 'ORT01'.
*          lw_mapping_info_temp-reuse_rollname = 'ORT01_GP'.
*        WHEN OTHERS.
*      ENDCASE.
*      APPEND lw_mapping_info_temp to lt_mapping_info_temp.
*      clear: lw_mapping_info_temp.
*    ENDLOOP.
*    CLEAR: ct_mapping_info.
*    ct_mapping_info[] = lt_mapping_info_temp[].
  ENDMETHOD.


  METHOD if_usmd_pp_hana_search~get_reuse_view_content.

*    DATA: lt_reuse_attributes  TYPE mdg_hdb_tt_reuse_attributes,
*          lw_resuse_attributes LIKE LINE OF lt_reuse_attributes,
*          lv_main_table TYPE USMD_TAB_SOURCE.
*
*    lt_reuse_attributes = VALUE #( ( reuse_table = 'BNKA' reuse_fieldname = 'BANKS' is_key = 'X' rollname = 'BANKS'
*                                    model_fieldname = 'Y_BANKS' deviating_fieldname = 'BNKA_BANKS' )
*                                    ( reuse_table = 'BNKA' reuse_fieldname = 'BANKL' is_key = 'X' rollname = 'BANKK'
*                                    model_fieldname = 'Y_BANKL' deviating_fieldname = 'BNKA_BANKL' )
*                                    ( reuse_table = 'BNKA' reuse_fieldname = 'ORT01'  rollname = 'ORT01_GP'
*                                    model_fieldname = 'YB_ORT01' deviating_fieldname = 'BNKA_YB_ORT01' ) ).
*
*    et_reuse_attributes[] = lt_reuse_attributes[].
*
*    lv_main_table = 'BNKA'.
*
*    ev_main_table = lv_main_table.
    TYPES:
      BEGIN OF ty_reuse_table,
        table TYPE usmd_tab_source,
      END OF ty_reuse_table .

    TYPES:
      tty_reuse_table TYPE SORTED TABLE OF ty_reuse_table
                  WITH UNIQUE KEY table .

    DATA:
      lv_keyflag          TYPE c,
      ls_message          TYPE usmd_s_message,
      lt_reuse_table      TYPE tty_reuse_table,
      ls_reuse_table      LIKE LINE OF lt_reuse_table,
      ls_reuse_attributes LIKE LINE OF et_reuse_attributes.

    FIELD-SYMBOLS:
      <ls_model_attributes> LIKE LINE OF it_model_attributes,
      <ls_reuse_fmap>       LIKE LINE OF gt_reuse_fmap,
      <ls_reuse_attributes> LIKE LINE OF et_reuse_attributes.

    CLEAR:
      ev_main_table,
      et_join_conditions,
      et_reuse_attributes,
      et_messages.

    IF iv_main_entity EQ 'Y_BANKL'.
      me->set_reuse_mapping( ).
    ELSE.
      RETURN.
    ENDIF.

    ev_main_table = 'BNKA'.

    LOOP AT it_model_attributes ASSIGNING <ls_model_attributes>.
      READ TABLE gt_reuse_fmap
       ASSIGNING <ls_reuse_fmap>
        WITH KEY model           = gc_model
                 entity          = <ls_model_attributes>-usmd_entity
                 model_fieldname = <ls_model_attributes>-fieldname.
      IF sy-subrc IS INITIAL.
        ls_reuse_table-table = <ls_reuse_fmap>-reuse_table.
        INSERT ls_reuse_table INTO TABLE lt_reuse_table.

        CLEAR ls_reuse_attributes.
        MOVE-CORRESPONDING <ls_reuse_fmap> TO ls_reuse_attributes.
        ls_reuse_attributes-rollname = <ls_reuse_fmap>-reuse_rollname.

        INSERT ls_reuse_attributes INTO TABLE et_reuse_attributes.
      ELSE.
        IF <ls_model_attributes>-fieldname = 'Y_BANKL'.
*          ls_reuse_table-table = 'BNKA'.
*          INSERT ls_reuse_table INTO TABLE lt_reuse_table.
          CLEAR ls_reuse_attributes.
          ls_reuse_attributes-reuse_table = 'BNKA'.
          ls_reuse_attributes-reuse_fieldname = 'BANKL'.
          ls_reuse_attributes-rollname = 'BANKK'.
          ls_reuse_attributes-model_fieldname = 'Y_BANKL'.
          ls_reuse_attributes-deviating_fieldname = 'BNKA_BANKL'.
          INSERT ls_reuse_attributes INTO TABLE et_reuse_attributes.
        ELSEIF <ls_model_attributes>-fieldname = 'Y_BANKS'.
*          ls_reuse_table-table = 'BNKA'.
*          INSERT ls_reuse_table INTO TABLE lt_reuse_table.
          CLEAR ls_reuse_attributes.
          ls_reuse_attributes-reuse_table = 'BNKA'.
          ls_reuse_attributes-reuse_fieldname = 'BANKS'.
          ls_reuse_attributes-rollname = 'BANKS'.
          ls_reuse_attributes-model_fieldname = 'Y_BANKS'.
          ls_reuse_attributes-deviating_fieldname = 'BNKA_BANKS'.
          INSERT ls_reuse_attributes INTO TABLE et_reuse_attributes.
        ENDIF.
      ENDIF.
    ENDLOOP.

* set key flags
    LOOP AT et_reuse_attributes ASSIGNING <ls_reuse_attributes>.
      SELECT SINGLE keyflag FROM dd03l INTO lv_keyflag
        WHERE tabname   = <ls_reuse_attributes>-reuse_table
          AND fieldname = <ls_reuse_attributes>-reuse_fieldname "#EC CI_NOORDER
.
      IF sy-subrc IS INITIAL.
        <ls_reuse_attributes>-is_key = lv_keyflag.
      ENDIF.
    ENDLOOP.

** GET join conditions
*    IF lt_reuse_table IS NOT INITIAL.
*      et_join_conditions = me->get_join_conditions( it_reuse_table = lt_reuse_table ).
*    ENDIF.

  ENDMETHOD.


  method IF_USMD_PP_HANA_SEARCH~MERGE_REUSE_AUTHORIZATION.
  endmethod.


  METHOD query_entity_data.
*Initialize output
    CLEAR:
      et_data,
      et_message,
      ef_not_supported.

    "Data Declarations
    DATA lr_data         TYPE REF TO data.
    CREATE DATA lr_data  LIKE LINE OF et_data.
    ASSIGN lr_data->* TO FIELD-SYMBOL(<ls_data>).

    CASE i_entity.
      WHEN 'Y_BANKL'. " For Bank Data
        SELECT sign,option,low,high FROM @it_sel AS lt_sel WHERE fieldname =: 'Y_BANKS' INTO TABLE @DATA(lrt_sel_banks),
                                                                              'Y_BANKL' INTO TABLE @DATA(lrt_sel_bankl).
        IF ( lrt_sel_banks IS INITIAL AND lrt_sel_bankl IS INITIAL AND it_sel IS NOT INITIAL ).
          "no supported search attribute
          RETURN.
        ENDIF.

* Select data from Cds view
        SELECT * FROM i_bank_2 UP TO @i_num_entries ROWS INTO TABLE @DATA(lt_bnka_data)
          WHERE bankcountry    IN @lrt_sel_banks
          AND bankinternalid    IN @lrt_sel_bankl
          ORDER BY PRIMARY KEY.
        LOOP AT lt_bnka_data ASSIGNING FIELD-SYMBOL(<fs_bnka_result>).
          ASSIGN COMPONENT 'Y_BANKS' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_banks>).
          IF <lv_banks> IS ASSIGNED.
            <lv_banks> = <fs_bnka_result>-bankcountry.
          ENDIF.
          ASSIGN COMPONENT 'Y_BANKL' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_bankl>).
          IF <lv_bankl> IS ASSIGNED.
            <lv_bankl> = <fs_bnka_result>-bankinternalid.
          ENDIF.
          ASSIGN COMPONENT 'YB_ERDAT' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_erdat>).
          IF <lv_erdat> IS ASSIGNED.
            <lv_erdat> = <fs_bnka_result>-creationdate.
          ENDIF.
          ASSIGN COMPONENT 'YB_ERNAM' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_ernam>).
          IF <lv_ernam> IS ASSIGNED.
            <lv_ernam> = <fs_bnka_result>-createdbyuser.
          ENDIF.
          ASSIGN COMPONENT 'YB_BANKA' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_banka>).
          IF <lv_banka> IS ASSIGNED.
            <lv_banka> = <fs_bnka_result>-bankname.
          ENDIF.
          ASSIGN COMPONENT 'YB_REGIO' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_regio>).
          IF <lv_regio> IS ASSIGNED.
            <lv_regio> = <fs_bnka_result>-region.
          ENDIF.
          ASSIGN COMPONENT 'YB_STRAS' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_stras>).
          IF <lv_stras> IS ASSIGNED.
            <lv_stras> = <fs_bnka_result>-streetname.
          ENDIF.
          ASSIGN COMPONENT 'YB_ORT01' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_ort01>).
          IF <lv_ort01> IS ASSIGNED.
            <lv_ort01> = <fs_bnka_result>-cityname.
          ENDIF.
          ASSIGN COMPONENT 'YB_SWIFT' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_swift>).
          IF <lv_swift> IS ASSIGNED.
            <lv_swift> = <fs_bnka_result>-swiftcode.
          ENDIF.
          ASSIGN COMPONENT 'YB_BGRUP' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_bgrup>).
          IF <lv_bgrup> IS ASSIGNED.
            <lv_bgrup> = <fs_bnka_result>-banknetworkgrouping.
          ENDIF.
          ASSIGN COMPONENT 'YB_XPGRO' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_xpgro>).
          IF <lv_xpgro> IS ASSIGNED.
            <lv_xpgro> = <fs_bnka_result>-ispostbankaccount.
          ENDIF.
          ASSIGN COMPONENT 'YB_LOEVM' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_loevm>).
          IF <lv_loevm> IS ASSIGNED.
            <lv_loevm> = <fs_bnka_result>-ismarkedfordeletion.
          ENDIF.
          ASSIGN COMPONENT 'YB_BANKL' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_banklz>).
          IF <lv_banklz> IS ASSIGNED.
            <lv_banklz> = <fs_bnka_result>-bank.
          ENDIF.
          ASSIGN COMPONENT 'YB_BRNCH' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_brnch>).
          IF <lv_brnch> IS ASSIGNED.
            <lv_brnch> = <fs_bnka_result>-bankbranch.
          ENDIF.
          ASSIGN COMPONENT 'YB_ADDRNO' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_addrno>).
          IF <lv_addrno> IS ASSIGNED.
            <lv_addrno> = <fs_bnka_result>-addressid.
          ENDIF.
          INSERT <ls_data> INTO TABLE et_data.
          CLEAR <ls_data>.
        ENDLOOP.

      WHEN 'Y_ADDRESS'. "For Advance Address
        SELECT sign,option,low,high FROM @it_sel AS lt_sel WHERE fieldname =: 'Y_BANKS'  INTO TABLE @lrt_sel_banks,
                                                                              'Y_BANKL'  INTO TABLE @lrt_sel_bankl.

        IF ( lrt_sel_banks IS INITIAL AND lrt_sel_bankl IS INITIAL AND it_sel IS NOT INITIAL ).
*          no supported search attribute
          RETURN.
        ENDIF.

*       Select data from Cds view
        SELECT * FROM yb_address UP TO @i_num_entries ROWS INTO TABLE @DATA(lt_bnka_address)
        WHERE bankkey IN @lrt_sel_bankl
        AND bankcountry IN @lrt_sel_banks
          ORDER BY PRIMARY KEY.
        READ TABLE lt_bnka_address INTO DATA(ls_bnka_address) INDEX 1.
        IF sy-subrc = 0 AND ls_bnka_address-addrnumber IS NOT INITIAL.
          ASSIGN COMPONENT 'Y_BANKL' OF STRUCTURE <ls_data> TO <lv_bankl>.
          IF <lv_bankl> IS ASSIGNED.
            <lv_bankl> = ls_bnka_address-bankkey.
          ENDIF.
          ASSIGN COMPONENT 'Y_BANKS' OF STRUCTURE <ls_data> TO <lv_banks>.
          IF <lv_banks> IS ASSIGNED.
            <lv_banks> = ls_bnka_address-bankcountry.
          ENDIF.
          ASSIGN COMPONENT 'Y_ADDRNO' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_addrn>).
          IF <lv_addrn> IS ASSIGNED.
            <lv_addrn> = ls_bnka_address-addrnumber.
          ENDIF.
          ASSIGN COMPONENT 'YB_BUILD' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_build>).
          IF <lv_build> IS ASSIGNED.
            <lv_build> = ls_bnka_address-building.
          ENDIF.
          ASSIGN COMPONENT 'YB_CITY1' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_city1>)."City
          IF <lv_city1> IS ASSIGNED.
            <lv_city1> = ls_bnka_address-city1.
          ENDIF.
          ASSIGN COMPONENT 'YB_CITY2' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_city2>)."Other City
          IF <lv_city2> IS ASSIGNED.
            <lv_city2> = ls_bnka_address-homecity.
          ENDIF.
          ASSIGN COMPONENT 'YB_CO' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_CO>). " Care of
          IF <lv_co> IS ASSIGNED.
            <lv_co> = ls_bnka_address-nameco.
          ENDIF.
          ASSIGN COMPONENT 'YB_COMM' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_COMM>). " Communication Method
          IF <lv_comm> IS ASSIGNED.
            <lv_comm> = ls_bnka_address-defltcomm.
          ENDIF.
          ASSIGN COMPONENT 'YB_DISTR' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_distr>). " District
          IF <lv_distr> IS ASSIGNED.
            <lv_distr> = ls_bnka_address-city2.
          ENDIF.
          ASSIGN COMPONENT 'YB_EMAIL' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_email>). " Email Address
          IF <lv_email> IS ASSIGNED.
            <lv_email> = ls_bnka_address-smtpaddr.
          ENDIF.
          ASSIGN COMPONENT 'YB_FLOOR' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_floor>). " Floor Number
          IF <lv_floor> IS ASSIGNED.
            <lv_floor> = ls_bnka_address-floor.
          ENDIF.
          ASSIGN COMPONENT 'YB_FXNMBR' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_fxnmbr>). " Fax Number
          IF <lv_fxnmbr> IS ASSIGNED.
            <lv_fxnmbr> = ls_bnka_address-faxnumber.
          ENDIF.
          ASSIGN COMPONENT 'YB_FXNTNS' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_fxntns>). " Fax Number Extensions
          IF <lv_fxntns> IS ASSIGNED.
            <lv_fxntns> = ls_bnka_address-faxextens.
          ENDIF.
          ASSIGN COMPONENT 'YB_HSNM' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_hsnm>). " House Number
          IF <lv_hsnm> IS ASSIGNED.
            <lv_hsnm> = ls_bnka_address-housenum1.
          ENDIF.
          ASSIGN COMPONENT 'YB_HSNM2' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_hssup>). " House Number Supplement
          IF <lv_hssup> IS ASSIGNED.
            <lv_hssup> = ls_bnka_address-housenum2.
          ENDIF.
          ASSIGN COMPONENT 'YB_LAND1' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_land1>). " Country
          IF <lv_land1> IS ASSIGNED.
            <lv_land1> = ls_bnka_address-country.
          ENDIF.
          ASSIGN COMPONENT 'YB_LANGU' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_lang>). " Language Key
          IF <lv_lang> IS ASSIGNED.
            <lv_lang> = ls_bnka_address-langu.
          ENDIF.
          ASSIGN COMPONENT 'YB_LZONE' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_tzone>). " Transportation Zone
          IF <lv_tzone> IS ASSIGNED.
            <lv_tzone> = ls_bnka_address-transpzone.
          ENDIF.
          ASSIGN COMPONENT 'YB_NAME1' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_name1>). " Name1
          IF <lv_name1> IS ASSIGNED.
            <lv_name1> = ls_bnka_address-name1.
          ENDIF.
          ASSIGN COMPONENT 'YB_NAME2' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_name2>). " Name2
          IF <lv_name2> IS ASSIGNED.
            <lv_name2> = ls_bnka_address-name2.
          ENDIF.
          ASSIGN COMPONENT 'YB_NAME3' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_name3>). " Name3
          IF <lv_name3> IS ASSIGNED.
            <lv_name3> = ls_bnka_address-name3.
          ENDIF.
          ASSIGN COMPONENT 'YB_NAME4' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_name4>). " Name4
          IF <lv_name4> IS ASSIGNED.
            <lv_name4> = ls_bnka_address-name4.
          ENDIF.
          ASSIGN COMPONENT 'YB_POBCTR' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_POBCTR>). " Po Box Country/Region
          IF <lv_pobctr> IS ASSIGNED.
            <lv_pobctr> = ls_bnka_address-poboxcty.
          ENDIF.
          ASSIGN COMPONENT 'YB_POBCTY' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_POBCTY>). " Po Box City
          IF <lv_pobcty> IS ASSIGNED.
            <lv_pobcty> = ls_bnka_address-poboxloc.
          ENDIF.
          ASSIGN COMPONENT 'YB_POBNUM' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_pobnum>). " Po Box Number
          IF <lv_pobnum> IS ASSIGNED.
            <lv_pobnum> = ls_bnka_address-poboxnum.
          ENDIF.
          ASSIGN COMPONENT 'YB_POBX' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_pobx>). " Po Box
          IF <lv_pobx> IS ASSIGNED.
            <lv_pobx> = ls_bnka_address-pobox.
          ENDIF.
          ASSIGN COMPONENT 'YB_POBXRG' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_pobxrg>). " Po Box Region
          IF <lv_pobxrg> IS ASSIGNED.
            <lv_pobxrg> = ls_bnka_address-poboxreg.
          ENDIF.
          ASSIGN COMPONENT 'YB_POLBY' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_polby>). " Po Box Lobby
          IF <lv_polby> IS ASSIGNED.
            <lv_polby> = ls_bnka_address-poboxlobby.
          ENDIF.
          ASSIGN COMPONENT 'YB_POUND' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_pound>). " Po Undeliverable flag
          IF <lv_pound> IS ASSIGNED.
            <lv_pound> = ls_bnka_address-dontusep.
          ENDIF.
          ASSIGN COMPONENT 'YB_PSTCD1' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_pstcd1>). " Postal Code
          IF <lv_pstcd1> IS ASSIGNED.
            <lv_pstcd1> = ls_bnka_address-postcode1.
          ENDIF.
          ASSIGN COMPONENT 'YB_PSTCD2' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_pstcd2>). " PO Box Postal Code
          IF <lv_pstcd2> IS ASSIGNED.
            <lv_pstcd2> = ls_bnka_address-postcode2.
          ENDIF.
          ASSIGN COMPONENT 'YB_PSTCD3' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_pstcd3>). " Company Postal Code
          IF <lv_pstcd3> IS ASSIGNED.
            <lv_pstcd3> = ls_bnka_address-postcode3.
          ENDIF.
          ASSIGN COMPONENT 'YB_REGGRP' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_reggrp>). " structure Group
          IF <lv_reggrp> IS ASSIGNED.
            <lv_reggrp> = ls_bnka_address-regiogroup.
          ENDIF.
          ASSIGN COMPONENT 'YB_REGION' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_region>). " Region
          IF <lv_region> IS ASSIGNED.
            <lv_region> = ls_bnka_address-region.
          ENDIF.
          ASSIGN COMPONENT 'YB_ROOM' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_room>). " Room Number
          IF <lv_room> IS ASSIGNED.
            <lv_room> = ls_bnka_address-roomnumber.
          ENDIF.
          ASSIGN COMPONENT 'YB_SERNUM' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_sernum>). " Number of Del Service
          IF <lv_sernum> IS ASSIGNED.
            <lv_sernum> = ls_bnka_address-deliservnumber.
          ENDIF.
          ASSIGN COMPONENT 'YB_SORT1' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_sort1>). " Search Term1
          IF <lv_sort1> IS ASSIGNED.
            <lv_sort1> = ls_bnka_address-sort1.
          ENDIF.
          ASSIGN COMPONENT 'YB_SORT2' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_sort2>). " Search Term2
          IF <lv_sort2> IS ASSIGNED.
            <lv_sort2> = ls_bnka_address-sort2.
          ENDIF.
          ASSIGN COMPONENT 'YB_SQNUM' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_sqnum>). " Sequence Number
          IF <lv_sqnum> IS ASSIGNED.
            <lv_sqnum> = ls_bnka_address-consnumber.
          ENDIF.
          ASSIGN COMPONENT 'YB_SRTYPE' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_srtype>). " Type of Service Delivery
          IF <lv_srtype> IS ASSIGNED.
            <lv_srtype> = ls_bnka_address-deliservtype.
          ENDIF.
          ASSIGN COMPONENT 'YB_STREET' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_street>). " Street
          IF <lv_street> IS ASSIGNED.
            <lv_street> = ls_bnka_address-street.
          ENDIF.
          ASSIGN COMPONENT 'YB_STRSP1' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_strsp1>). " Street2
          IF <lv_strsp1> IS ASSIGNED.
            <lv_strsp1> = ls_bnka_address-strsuppl1.
          ENDIF.
          ASSIGN COMPONENT 'YB_STRSP2' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_strsp2>). " Street3
          IF <lv_strsp2> IS ASSIGNED.
            <lv_strsp2> = ls_bnka_address-strsuppl2.
          ENDIF.
          ASSIGN COMPONENT 'YB_STRSP3' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_strsp3>). " Street4
          IF <lv_strsp3> IS ASSIGNED.
            <lv_strsp3> = ls_bnka_address-strsuppl3.
          ENDIF.
          ASSIGN COMPONENT 'YB_STRSP4' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_strsp4>). " Street5
          IF <lv_strsp4> IS ASSIGNED.
            <lv_strsp4> = ls_bnka_address-location.
          ENDIF.
          ASSIGN COMPONENT 'YB_STUND' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_stund>). " Street Undeliverable
          IF <lv_stund> IS ASSIGNED.
            <lv_stund> = ls_bnka_address-dontuses.
          ENDIF.
          ASSIGN COMPONENT 'YB_TLNMBR' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_tlnmbr>). " Telephone Number
          IF <lv_tlnmbr> IS ASSIGNED.
            <lv_tlnmbr> = ls_bnka_address-telnumber.
          ENDIF.

          ASSIGN COMPONENT 'YB_TLXTNS' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_tlxtns>). " Telephone Number Extensions
          IF <lv_tlxtns> IS ASSIGNED.
            <lv_tlxtns> = ls_bnka_address-telextens.
          ENDIF.
          ASSIGN COMPONENT 'YB_TXJCD' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_txjcd>). " Tax Jurisdiction
          IF <lv_txjcd> IS ASSIGNED.
            <lv_txjcd> = ls_bnka_address-taxjurcode.
          ENDIF.
          ASSIGN COMPONENT 'YB_TZONE' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_tmzone>). " Time Zone
          IF <lv_tmzone> IS ASSIGNED.
            <lv_tmzone> = ls_bnka_address-timezone1.
          ENDIF.
          INSERT <ls_data> INTO TABLE et_data.
          CLEAR <ls_data>.
        ENDIF.
      WHEN OTHERS.
    ENDCASE.
  ENDMETHOD.


  METHOD read_data.
  ENDMETHOD.


  METHOD set_reuse_mapping.
    CLEAR: gt_reuse_fmap, gt_join_conditions.
    gt_reuse_fmap      = cl_mdg_hdb_reuse_mapping=>get_field_mapping( gc_model ).
    gt_join_conditions = cl_mdg_hdb_reuse_mapping=>get_join_conditions( gc_business_object ).
  ENDMETHOD.
ENDCLASS.
