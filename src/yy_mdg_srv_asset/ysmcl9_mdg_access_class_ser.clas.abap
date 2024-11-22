class YSMCL9_MDG_ACCESS_CLASS_SER definition
  public
  final
  create public .

public section.

  interfaces IF_USMD_PP_ACCESS .
  interfaces IF_USMD_PP_HANA_SEARCH .
  interfaces IF_MDG_BP_CONSTANTS .

  constants GC_MODEL_YS type USMD_MODEL value 'YS' ##NO_TEXT.
  constants GC_BUSINESS_OBJECT type MDG_OBJECT_TYPE_CODE_BS value 'YS_BO' ##NO_TEXT.
protected section.

  class-data GT_REUSE_FMAP type MDG_HDB_TT_PP_FMAP .
  class-data GT_JOIN_CONDITIONS type MDG_HDB_TT_XML_JOIN_TABLE .

  methods SET_REUSE_MAPPING .
private section.
ENDCLASS.



CLASS YSMCL9_MDG_ACCESS_CLASS_SER IMPLEMENTATION.


  method IF_USMD_PP_ACCESS~ADJUST_SELECTION_ATTR.
  endmethod.


  method IF_USMD_PP_ACCESS~CHECK_AUTHORITY.
  endmethod.


  method IF_USMD_PP_ACCESS~CHECK_AUTHORITY_MASS.
  endmethod.


  METHOD if_usmd_pp_access~check_data.
    "Business Rule for Service category and Base UOM Validation
    "Data Declarations
    DATA : lr_data    TYPE REF TO data,
           lt_message TYPE         usmd_t_message.
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
          CASE ls_entity_mod-entity..
            WHEN 'YY_SERVIC'.
              LOOP AT <ft_data> ASSIGNING FIELD-SYMBOL(<fs_data>).
                ASSIGN COMPONENT 'ASTYP' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<lfs_astyp>).
                IF <lfs_astyp> IS ASSIGNED AND <lfs_astyp> IS INITIAL.
                  et_message = VALUE #( BASE et_message ( msgid = 'YS_SERVICE_MASTER' msgty = 'E' msgno = '000' msgv1 = TEXT-001 ) ).
                ENDIF.
                ASSIGN COMPONENT 'MEINS' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<lfs_meins>).
                IF <lfs_meins> IS ASSIGNED AND <lfs_meins> IS INITIAL.
                  et_message = VALUE #( BASE et_message ( msgid = 'YS_SERVICE_MASTER' msgty = 'E' msgno = '000' msgv1 = TEXT-002 ) ).
                ENDIF.
                ASSIGN COMPONENT 'ASKTX' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<lfs_asktx>).
                IF <lfs_asktx> IS ASSIGNED AND <lfs_asktx> IS INITIAL.
                  et_message = VALUE #( BASE et_message ( msgid = 'YS_SERVICE_MASTER' msgty = 'E' msgno = '000' msgv1 = TEXT-003 ) ).
                ENDIF.
*                ASSIGN COMPONENT 'MSTDE' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<lfs_mstde>).
*                IF <lfs_mstde> IS ASSIGNED AND <lfs_mstde> IS INITIAL.
*                  et_message = VALUE #( BASE et_message ( msgid = 'YS_SERVICE_MASTER' msgty = 'E' msgno = '000' msgv1 = TEXT-004 ) ).
*                ENDIF.
*                ASSIGN COMPONENT 'MSTAE' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<lfs_mstae>).
*                IF <lfs_mstae> IS ASSIGNED AND <lfs_mstae> IS INITIAL.
*                  et_message = VALUE #( BASE et_message ( msgid = 'YS_SERVICE_MASTER' msgty = 'E' msgno = '000' msgv1 = TEXT-005 ) ).
*                ENDIF.
              ENDLOOP.
            WHEN OTHERS.
          ENDCASE.
        ENDIF.
      ENDLOOP.
    ENDIF.

  ENDMETHOD.


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
    """ BOC by Ram
    "Initialize output
    CLEAR:
      et_data,
      et_message,
      ef_not_supported.

    "Data Declarations
    DATA lr_data         TYPE REF TO data.
    CREATE DATA lr_data  LIKE LINE OF et_data.
    ASSIGN lr_data->* TO FIELD-SYMBOL(<ls_data>).

    CASE i_entity.
      WHEN 'YY_SERVIC'. " For Service Data
        SELECT sign,option,low,high FROM @it_sel AS lt_sel INTO TABLE @DATA(lrt_sel_asmd).

        IF ( lrt_sel_asmd IS INITIAL AND it_sel IS NOT INITIAL ).
          "no supported search attribute
          RETURN.
        ENDIF.
        """ Select data from CDS view
        SELECT * FROM vasmd UP TO @i_num_entries ROWS INTO TABLE @DATA(lt_asmd_data)
          WHERE asnum IN @lrt_sel_asmd ORDER BY PRIMARY KEY.

        LOOP AT lt_asmd_data ASSIGNING FIELD-SYMBOL(<fs_asmd_result>).
          ASSIGN COMPONENT 'YY_SERVIC' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<fs_yy_servic>).
          IF <fs_yy_servic> IS ASSIGNED.
            <fs_yy_servic> = <fs_asmd_result>-asnum.
          ENDIF.
          ASSIGN COMPONENT 'LANGU' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<fs_langu>).
          IF <fs_langu> IS ASSIGNED.
            <fs_langu> = 'E'.
          ENDIF.
          ASSIGN COMPONENT 'ASTYP' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<fs_astyp>).
          IF <fs_astyp> IS ASSIGNED.
            <fs_astyp> = <fs_asmd_result>-astyp.
          ENDIF.
*          ASSIGN COMPONENT 'AUSGB' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<fs_AUSGB>).
*          IF <fs_AUSGB> IS ASSIGNED.
*            <fs_AUSGB> = <fs_asmd_result>-AUSGB.
*          ENDIF.
          ASSIGN COMPONENT 'BEGRU' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<fs_begru>).
          IF <fs_begru> IS ASSIGNED.
            <fs_begru> = <fs_asmd_result>-begru.
          ENDIF.
          ASSIGN COMPONENT 'BKLAS' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<fs_bklas>).
          IF <fs_bklas> IS ASSIGNED.
            <fs_bklas> = <fs_asmd_result>-bklas.
          ENDIF.
*          ASSIGN COMPONENT 'CHGTEXT' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<fs_CHGTEXT>).
*          IF <fs_CHGTEXT> IS ASSIGNED.
*            <fs_CHGTEXT> = <fs_asmd_result>-CHGTEXT.
*          ENDIF.
          ASSIGN COMPONENT 'EAN11' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<fs_ean11>).
          IF <fs_ean11> IS ASSIGNED.
            <fs_ean11> = <fs_asmd_result>-ean11.
          ENDIF.
*          ASSIGN COMPONENT 'FORMELNR' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<fs_formelnr>).
*          IF <fs_formelnr> IS ASSIGNED.
*            <fs_formelnr> = <fs_asmd_result>-formelnr.
*          ENDIF.
*          ASSIGN COMPONENT 'IMAGE_URL' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<fs_IMAGE_URL>).
*          IF <fs_IMAGE_URL> IS ASSIGNED.
*            <fs_IMAGE_URL> = <fs_asmd_result>-IMAGE_URL.
*          ENDIF.
*          ASSIGN COMPONENT 'IWEIN' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<fs_IWEIN>).
*          IF <fs_IWEIN> IS ASSIGNED.
*            <fs_IWEIN> = <fs_asmd_result>-IWEIN.
*          ENDIF.
*          ASSIGN COMPONENT 'IWUMN' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<fs_IWUMN>).
*          IF <fs_IWUMN> IS ASSIGNED.
*            <fs_IWUMN> = <fs_asmd_result>-IWUMN.
*          ENDIF.
*          ASSIGN COMPONENT 'IWUMZ' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<fs_IWUMZ>).
*          IF <fs_IWUMZ> IS ASSIGNED.
*            <fs_IWUMZ> = <fs_asmd_result>-IWUMZ.
*          ENDIF.
*          ASSIGN COMPONENT 'LBNUM' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<fs_LBNUM>).
*          IF <fs_LBNUM> IS ASSIGNED.
*            <fs_LBNUM> = <fs_asmd_result>-LBNUM.
*          ENDIF.
          ASSIGN COMPONENT 'LGART' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<fs_lgart>).
          IF <fs_lgart> IS ASSIGNED.
            <fs_lgart> = <fs_asmd_result>-lgart.
          ENDIF.
          ASSIGN COMPONENT 'LSTHI' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<fs_lsthi>).
          IF <fs_lsthi> IS ASSIGNED.
            <fs_lsthi> = <fs_asmd_result>-lsthi.
          ENDIF.
          ASSIGN COMPONENT 'LVORM' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<fs_lvorm>).
          IF <fs_lvorm> IS ASSIGNED.
            <fs_lvorm> = <fs_asmd_result>-lvorm.
          ENDIF.
          ASSIGN COMPONENT 'MATKL' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<fs_matkl>).
          IF <fs_matkl> IS ASSIGNED.
            <fs_matkl> = <fs_asmd_result>-matkl.
          ENDIF.
          ASSIGN COMPONENT 'MEINS' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<fs_meins>).
          IF <fs_meins> IS ASSIGNED.
            <fs_meins> = <fs_asmd_result>-meins.
          ENDIF.
          ASSIGN COMPONENT 'MLANG' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<fs_mlang>).
          IF <fs_mlang> IS ASSIGNED.
            <fs_mlang> = <fs_asmd_result>-mlang.
          ENDIF.
          ASSIGN COMPONENT 'MSTAE' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<fs_mstae>).
          IF <fs_mstae> IS ASSIGNED.
            <fs_mstae> = <fs_asmd_result>-mstae.
          ENDIF.
          ASSIGN COMPONENT 'MSTDE' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<fs_mstde>).
          IF <fs_mstde> IS ASSIGNED.
            <fs_mstde> = <fs_asmd_result>-mstde.
          ENDIF.
          ASSIGN COMPONENT 'NUMTP' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<fs_numtp>).
          IF <fs_numtp> IS ASSIGNED.
            <fs_numtp> = <fs_asmd_result>-numtp.
          ENDIF.
          ASSIGN COMPONENT 'PAKNR' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<fs_paknr>).
          IF <fs_paknr> IS ASSIGNED.
            <fs_paknr> = <fs_asmd_result>-paknr.
          ENDIF.
          ASSIGN COMPONENT 'SPART' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<fs_spart>).
          IF <fs_spart> IS ASSIGNED.
            <fs_spart> = <fs_asmd_result>-spart.
          ENDIF.
          ASSIGN COMPONENT 'ASKTX' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<fs_asktx>).
          IF <fs_asktx> IS ASSIGNED.
            <fs_asktx> = <fs_asmd_result>-asktx.
          ENDIF.
*          ASSIGN COMPONENT 'STLVPOS' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<fs_STLVPOS>).
*          IF <fs_STLVPOS> IS ASSIGNED.
*            <fs_STLVPOS> = <fs_asmd_result>-STLVPOS.
*          ENDIF.
*          ASSIGN COMPONENT 'TAXTARIFF' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<fs_TAXTARIFF>).
*          IF <fs_TAXTARIFF> IS ASSIGNED.
*            <fs_TAXTARIFF> = <fs_asmd_result>-TAXTARIFF.
*          ENDIF.

          INSERT <ls_data> INTO TABLE et_data.
          CLEAR <ls_data>.
        ENDLOOP.
    ENDCASE.
*    IF et_data IS INITIAL.
*      INSERT <ls_data> INTO TABLE et_data.
*    ENDIF.

    """ EOC by Ram

  ENDMETHOD.


  METHOD if_usmd_pp_access~read_value.

    """BOC by Ram

    me->if_usmd_pp_access~query(
      EXPORTING
        i_entity         = i_entity
        it_sel           = it_sel
        if_no_auth_check = abap_true
      IMPORTING
        et_data          = et_data
        et_message       = et_message
    ).

    """ EOC by Ram


  ENDMETHOD.


  METHOD if_usmd_pp_access~save.
*----------------------------------------------------------------------*
* Program description:
* This method takes care of saving the data of Service Master into the
* standard ECC Service Master table ASMD in case of both CREATE & CHANGE
* Process
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
* After Final approval of any Service master, this Method is used to
* save or change the record from the staging table or
* persistance table using respective Service master BAPI
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*              T Y P E S - D E C L A R A T I O N                       *
*----------------------------------------------------------------------*
    TYPES: BEGIN OF ty_class,
             classno TYPE bapi1003_key-classnum,
             classty TYPE bapi1003_key-classtype,
             asnum   TYPE asnum,
           END OF ty_class,

           BEGIN OF ty_asnum,
             asnum TYPE asnum,
           END OF ty_asnum.
    TYPES: BEGIN OF ty_usmd1213,
             usmd_crequest   TYPE usmd_crequest,
             usmd_entity     TYPE usmd_entity,
             usmd_seqnr      TYPE usmd_seqnr_obj,
             usmd_entity_obj TYPE usmd_entity,
             usmd_value      TYPE usmd_value,
           END OF ty_usmd1213.
*----------------------------------------------------------------------*
*               D A T A - D E C L A R A T I O N                        *
*----------------------------------------------------------------------*
    DATA : lt_entity         TYPE usmd_t_entity,
           lw_entity         TYPE usmd_entity,
           ls_asmd           TYPE bapisrv_asmd,
           lt_asmd           TYPE TABLE OF bapisrv_asmd,
           ls_asmdx          TYPE bapisrv_asmdx,
           lcl_data_inserted TYPE REF TO data, "New Crequest data
           lcl_data_updated  TYPE REF TO data, "Changed Crequest data
           lcl_data_deleted  TYPE REF TO data, "deleted Crequest data
           lr_data           TYPE REF TO data,
           lt_message        TYPE usmd_t_message,
           lv_temp_id        TYPE lstar,
           lv_creq_type      TYPE string,
           ls_addr           TYPE bapiaddr1,
           lt_addr           TYPE TABLE OF bapiaddr1,
           ls_error          TYPE TABLE OF suc_and_err_tabs,
           ls_success        TYPE TABLE OF suc_and_err_tabs,
           lv_crtype         TYPE usmd_crequest_type,
           ls_return         TYPE bapiret2,
           lt_return         TYPE TABLE OF bapiret2,
           ls_usmd1213       TYPE ty_usmd1213,
           lt_usmd1213       TYPE TABLE OF ty_usmd1213.
    DATA: ls_usmd TYPE usmd1213.

    DATA : ls_service_description TYPE bapisrv_asmdt,
           ls_final_id            TYPE bapisrv_asmd-service,
           ls_class               TYPE ty_class,
           ls_class_d             TYPE ty_class,
           lt_extensionin         TYPE TABLE OF bapiparex,
           ls_extensionin         TYPE bapiparex,
           lt_extensioninx        TYPE TABLE OF bapiparex,
           lt_service_description TYPE TABLE OF bapisrv_asmdt,
           lt_ltxt                TYPE TABLE OF bapisrv_text,
           lt_asnum               TYPE TABLE OF ty_asnum,
           ls_asnum               TYPE ty_asnum,
           lv_asnum               TYPE asnum.

    DATA: lr_t_key_map   TYPE REF TO data,
          lr_key_map     TYPE REF TO data,
          ls_tmp_key_map LIKE LINE OF et_tmp_key_map.

    FIELD-SYMBOLS : <lfs_srv_save> TYPE ANY TABLE,
                    <lfs_srv_ins>  TYPE any,
                    <lfs_srv_upd>  TYPE any,
                    <ls_asnum>     TYPE any.

    FIELD-SYMBOLS: <lt_key_map>   TYPE ANY TABLE,
                   <ls_key_map>   TYPE any,
                   <ls_tmp_key>   TYPE any,
                   <ls_final_key> TYPE any.
*----------------------------------------------------------------------*
*                     S O U R C E - C O D E                            *
*----------------------------------------------------------------------*
    "get all entity types to be processed
    CALL METHOD io_delta->get_entity_types
      IMPORTING
        et_entity = lt_entity.

    LOOP AT lt_entity INTO lw_entity.
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
        WHEN 'YY_SERVIC'.
          IF lcl_data_inserted IS NOT INITIAL."in case of create
            DATA(lv_srv_insert) = abap_true. "Service Data Inserted
            ASSIGN lcl_data_inserted->* TO <lfs_srv_save>.
            CLEAR: et_message.
            LOOP AT <lfs_srv_save> ASSIGNING <lfs_srv_ins>.
              ASSIGN COMPONENT 'YY_SERVIC' OF STRUCTURE <lfs_srv_ins> TO FIELD-SYMBOL(<ls_service>).
              IF <ls_service> IS ASSIGNED AND <ls_service> IS NOT INITIAL.
*                ls_asmd-service = <ls_service>.
*                ls_asmdx-service = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'MATKL' OF STRUCTURE <lfs_srv_ins> TO FIELD-SYMBOL(<ls_matkl>).
              IF <ls_matkl> IS ASSIGNED AND <ls_matkl> IS NOT INITIAL.
                ls_asmd-matl_group = <ls_matkl>.
                ls_asmdx-matl_group = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'MEINS' OF STRUCTURE <lfs_srv_ins> TO FIELD-SYMBOL(<ls_meins>).
              IF <ls_meins> IS ASSIGNED AND <ls_meins> IS NOT INITIAL.
                ls_asmd-base_uom = <ls_meins>.
                ls_asmdx-base_uom = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'ASTYP' OF STRUCTURE <lfs_srv_ins> TO FIELD-SYMBOL(<ls_astyp>).
              IF <ls_astyp> IS ASSIGNED AND <ls_astyp> IS NOT INITIAL.
                ls_asmd-serv_cat = <ls_astyp>.
                ls_asmdx-serv_cat = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'EAN11' OF STRUCTURE <lfs_srv_ins> TO FIELD-SYMBOL(<ls_ean11>).
              IF <ls_ean11> IS ASSIGNED AND <ls_ean11> IS NOT INITIAL.
                ls_asmd-ean_upc = <ls_ean11>.
                ls_asmdx-ean_upc = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'NUMTP' OF STRUCTURE <lfs_srv_ins> TO FIELD-SYMBOL(<ls_numtp>).
              IF <ls_numtp> IS ASSIGNED AND <ls_numtp> IS NOT INITIAL.
                ls_asmd-ean_cat = <ls_numtp>.
                ls_asmdx-ean_cat = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'SPART' OF STRUCTURE <lfs_srv_ins> TO FIELD-SYMBOL(<ls_spart>).
              IF <ls_spart> IS ASSIGNED AND <ls_spart> IS NOT INITIAL.
                ls_asmd-division = <ls_spart>.
                ls_asmdx-division = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'BEGRU' OF STRUCTURE <lfs_srv_ins> TO FIELD-SYMBOL(<ls_begru>).
              IF <ls_begru> IS ASSIGNED AND <ls_begru> IS NOT INITIAL.
                ls_asmd-auth_group = <ls_begru>.
                ls_asmdx-auth_group = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'MSTAE' OF STRUCTURE <lfs_srv_ins> TO FIELD-SYMBOL(<ls_mstae>).
              IF <ls_mstae> IS ASSIGNED AND <ls_mstae> IS NOT INITIAL.
                ls_asmd-p_status = <ls_mstae>.
                ls_asmdx-p_status = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'MSTDE' OF STRUCTURE <lfs_srv_ins> TO FIELD-SYMBOL(<ls_mstde>).
              IF <ls_mstde> IS ASSIGNED AND <ls_mstde> IS NOT INITIAL.
                ls_asmd-valid_from = <ls_mstde>.
                ls_asmdx-valid_from = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'BKLAS' OF STRUCTURE <lfs_srv_ins> TO FIELD-SYMBOL(<ls_bklas>).
              IF <ls_bklas> IS ASSIGNED AND <ls_bklas> IS NOT INITIAL.
                ls_asmd-val_class = <ls_bklas>.
                ls_asmdx-val_class = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'LSTHI' OF STRUCTURE <lfs_srv_ins> TO FIELD-SYMBOL(<ls_lsthi>).
              IF <ls_lsthi> IS ASSIGNED AND <ls_lsthi> IS NOT INITIAL.
                ls_asmd-hier_serv = <ls_lsthi>.
                ls_asmdx-hier_serv = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'MLANG' OF STRUCTURE <lfs_srv_ins> TO FIELD-SYMBOL(<ls_mlang>).
              IF <ls_mlang> IS ASSIGNED AND <ls_mlang> IS NOT INITIAL.
                ls_asmd-master_langu = <ls_mlang>.
                ls_asmdx-master_langu = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'LGART' OF STRUCTURE <lfs_srv_ins> TO FIELD-SYMBOL(<ls_lgart>).
              IF <ls_lgart> IS ASSIGNED AND <ls_lgart> IS NOT INITIAL.
                ls_asmd-wagetype = <ls_lgart>.
                ls_asmdx-wagetype = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'LBNUM' OF STRUCTURE <lfs_srv_ins> TO FIELD-SYMBOL(<ls_lbnum>).
              IF <ls_lbnum> IS ASSIGNED AND <ls_lbnum> IS NOT INITIAL.
                ls_asmd-serv_type = <ls_lbnum>.
                ls_asmdx-serv_type = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'AUSGB' OF STRUCTURE <lfs_srv_ins> TO FIELD-SYMBOL(<ls_ausgb>).
              IF <ls_ausgb> IS ASSIGNED AND <ls_ausgb> IS NOT INITIAL.
                ls_asmd-edition = <ls_ausgb>.
                ls_asmdx-edition = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'STLVPOS' OF STRUCTURE <lfs_srv_ins> TO FIELD-SYMBOL(<ls_stlvpos>).
              IF <ls_stlvpos> IS ASSIGNED AND <ls_stlvpos> IS NOT INITIAL.
                ls_asmd-ssc_item = <ls_stlvpos>.
                ls_asmdx-ssc_item = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'IWUMZ' OF STRUCTURE <lfs_srv_ins> TO FIELD-SYMBOL(<ls_iwumz>).
              IF <ls_iwumz> IS ASSIGNED AND <ls_iwumz> IS NOT INITIAL.
                ls_asmd-conv_num = <ls_iwumz>.
                ls_asmdx-conv_num = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'IWUMN' OF STRUCTURE <lfs_srv_ins> TO FIELD-SYMBOL(<ls_iwumn>).
              IF <ls_iwumn> IS ASSIGNED AND <ls_iwumn> IS NOT INITIAL.
                ls_asmd-conv_den = <ls_iwumn>.
                ls_asmdx-conv_den = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'IWEIN' OF STRUCTURE <lfs_srv_ins> TO FIELD-SYMBOL(<ls_iwein>).
              IF <ls_iwein> IS ASSIGNED AND <ls_iwein> IS NOT INITIAL.
                ls_asmd-work_uom = <ls_iwein>.
                ls_asmdx-work_uom = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'FORMELNR' OF STRUCTURE <lfs_srv_ins> TO FIELD-SYMBOL(<ls_forme>).
              IF <ls_forme> IS ASSIGNED AND <ls_forme> IS NOT INITIAL.
                ls_asmd-formula = <ls_forme>.
                ls_asmdx-formula = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'CHGTEXT' OF STRUCTURE <lfs_srv_ins> TO FIELD-SYMBOL(<ls_chgtext>).
              IF <ls_chgtext> IS ASSIGNED AND <ls_chgtext> IS NOT INITIAL.
                ls_asmd-chgtext = <ls_chgtext>.
                ls_asmdx-chgtext = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'IMAGE_URL' OF STRUCTURE <lfs_srv_ins> TO FIELD-SYMBOL(<ls_url>).
              IF <ls_url> IS ASSIGNED AND <ls_url> IS NOT INITIAL.
                ls_asmd-graphic_url = <ls_url>.
                ls_asmdx-graphic_url = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'ASKTX' OF STRUCTURE <lfs_srv_ins> TO FIELD-SYMBOL(<ls_asktx>).
              IF <ls_asktx> IS ASSIGNED AND <ls_asktx> IS NOT INITIAL.
                ls_service_description-short_text = <ls_asktx>.
                ls_service_description-language = sy-langu.
                APPEND ls_service_description TO lt_service_description.
              ENDIF.
              ls_asmd-master_langu = sy-langu.
              ls_asmdx-master_langu = abap_true.
*              APPEND ls_asmd TO lt_asmd.

*  The BAPI enables you to create service master records.                *
              CALL FUNCTION 'BAPI_SERVICE_CREATE'
                EXPORTING
                  im_service_data     = ls_asmd
                  im_service_datax    = ls_asmdx
*                 no_number_range_check = abap_true
*                 TESTRUN             =
                IMPORTING
                  service             = ls_final_id
*                 EX_SERVICE_DATA     =
*                 EX_SERVICE_DATAX    =
                TABLES
                  return              = lt_return
                  service_description = lt_service_description
*                 service_long_texts  = lt_ltxt
*                 extension_in        = lt_extensionin
*                 extension_out       = lt_extensioninx
                .
            ENDLOOP.


*            IF i_crequest IS NOT INITIAL AND ls_final_id IS NOT INITIAL.
*              ls_usmd-usmd_crequest = i_crequest.
*              ls_usmd-usmd_entity = 'YY_SERVIC'.
*              ls_usmd-usmd_seqnr = '1'.
*              ls_usmd-usmd_entity_obj = 'YY_SERVIC'.
*
**              ls_usmd-usmd_value = ls_final_id.
*
*              DATA: is_usmd1213 TYPE usmd1213,
*                    is_staging  TYPE /1md/md______0g4.
*              SELECT * FROM usmd1213 INTO TABLE @DATA(it_usmd1213) WHERE usmd_crequest = @i_crequest.
*              READ TABLE it_usmd1213 INTO is_usmd1213 WITH KEY usmd_crequest = i_crequest.
*
*              is_staging-usmdkysyy_servic =  is_usmd1213-usmd_value.
*              is_staging-/1md/ysyy_servic = ls_final_id.
*              is_staging-usmdtysyy_servic = ls_final_id.
*
**                MODIFY usmd1213 FROM ls_usmd.
*              MODIFY /1md/md______0g4 FROM is_staging.
*
*            ENDIF.



          ELSEIF lcl_data_updated IS NOT INITIAL. "Change

            DATA(lv_srv_change) = abap_true. "Service Data Updated
            ASSIGN lcl_data_updated->* TO <lfs_srv_save>.
            CLEAR: et_message.
            LOOP AT <lfs_srv_save> ASSIGNING <lfs_srv_upd>.
              ASSIGN COMPONENT 'YY_SERVIC' OF STRUCTURE <lfs_srv_upd> TO <ls_service>.
              IF <ls_service> IS ASSIGNED AND <ls_service> IS NOT INITIAL.
                ls_asmd-service = <ls_service>.
*                ls_asmdx-service = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'MATKL' OF STRUCTURE <lfs_srv_upd> TO <ls_matkl>.
              IF <ls_matkl> IS ASSIGNED AND <ls_matkl> IS NOT INITIAL.
                ls_asmd-matl_group = <ls_matkl>.
                ls_asmdx-matl_group = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'MEINS' OF STRUCTURE <lfs_srv_upd> TO <ls_meins>.
              IF <ls_meins> IS ASSIGNED AND <ls_meins> IS NOT INITIAL.
                ls_asmd-base_uom = <ls_meins>.
                ls_asmdx-base_uom = abap_true.
              ENDIF.
*              ASSIGN COMPONENT 'ASTYP' OF STRUCTURE <lfs_srv_upd> TO <ls_astyp>.
*              IF <ls_astyp> IS ASSIGNED AND <ls_astyp> IS NOT INITIAL.
*                ls_asmd-serv_cat = <ls_astyp>.
*                ls_asmdx-serv_cat = abap_true.
*              ENDIF.
              ASSIGN COMPONENT 'EAN11' OF STRUCTURE <lfs_srv_upd> TO <ls_ean11>.
              IF <ls_ean11> IS ASSIGNED AND <ls_ean11> IS NOT INITIAL.
                ls_asmd-ean_upc = <ls_ean11>.
                ls_asmdx-ean_upc = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'NUMTP' OF STRUCTURE <lfs_srv_upd> TO <ls_numtp>.
              IF <ls_numtp> IS ASSIGNED AND <ls_numtp> IS NOT INITIAL.
                ls_asmd-ean_cat = <ls_numtp>.
                ls_asmdx-ean_cat = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'SPART' OF STRUCTURE <lfs_srv_upd> TO <ls_spart>.
              IF <ls_spart> IS ASSIGNED AND <ls_spart> IS NOT INITIAL.
                ls_asmd-division = <ls_spart>.
                ls_asmdx-division = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'BEGRU' OF STRUCTURE <lfs_srv_upd> TO <ls_begru>.
              IF <ls_begru> IS ASSIGNED AND <ls_begru> IS NOT INITIAL.
                ls_asmd-auth_group = <ls_begru>.
                ls_asmdx-auth_group = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'MSTAE' OF STRUCTURE <lfs_srv_upd> TO <ls_mstae>.
              IF <ls_mstae> IS ASSIGNED AND <ls_mstae> IS NOT INITIAL.
                ls_asmd-p_status = <ls_mstae>.
                ls_asmdx-p_status = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'MSTDE' OF STRUCTURE <lfs_srv_upd> TO <ls_mstde>.
              IF <ls_mstde> IS ASSIGNED AND <ls_mstde> IS NOT INITIAL.
                ls_asmd-valid_from = <ls_mstde>.
                ls_asmdx-valid_from = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'BKLAS' OF STRUCTURE <lfs_srv_upd> TO <ls_bklas>.
              IF <ls_bklas> IS ASSIGNED AND <ls_bklas> IS NOT INITIAL.
                ls_asmd-val_class = <ls_bklas>.
                ls_asmdx-val_class = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'LSTHI' OF STRUCTURE <lfs_srv_upd> TO <ls_lsthi>.
              IF <ls_lsthi> IS ASSIGNED AND <ls_lsthi> IS NOT INITIAL.
                ls_asmd-hier_serv = <ls_lsthi>.
                ls_asmdx-hier_serv = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'MLANG' OF STRUCTURE <lfs_srv_upd> TO <ls_mlang>.
              IF <ls_mlang> IS ASSIGNED AND <ls_mlang> IS NOT INITIAL.
                ls_asmd-master_langu = <ls_mlang>.
                ls_asmdx-master_langu = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'LGART' OF STRUCTURE <lfs_srv_upd> TO <ls_lgart>.
              IF <ls_lgart> IS ASSIGNED AND <ls_lgart> IS NOT INITIAL.
                ls_asmd-wagetype = <ls_lgart>.
                ls_asmdx-wagetype = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'LBNUM' OF STRUCTURE <lfs_srv_upd> TO <ls_lbnum>.
              IF <ls_lbnum> IS ASSIGNED AND <ls_lbnum> IS NOT INITIAL.
                ls_asmd-serv_type = <ls_lbnum>.
                ls_asmdx-serv_type = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'AUSGB' OF STRUCTURE <lfs_srv_upd> TO <ls_ausgb>.
              IF <ls_ausgb> IS ASSIGNED AND <ls_ausgb> IS NOT INITIAL.
                ls_asmd-edition = <ls_ausgb>.
                ls_asmdx-edition = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'STLVPOS' OF STRUCTURE <lfs_srv_upd> TO <ls_stlvpos>.
              IF <ls_stlvpos> IS ASSIGNED AND <ls_stlvpos> IS NOT INITIAL.
                ls_asmd-ssc_item = <ls_stlvpos>.
                ls_asmdx-ssc_item = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'IWUMZ' OF STRUCTURE <lfs_srv_upd> TO <ls_iwumz>.
              IF <ls_iwumz> IS ASSIGNED AND <ls_iwumz> IS NOT INITIAL.
                ls_asmd-conv_num = <ls_iwumz>.
                ls_asmdx-conv_num = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'IWUMN' OF STRUCTURE <lfs_srv_upd> TO <ls_iwumn>.
              IF <ls_iwumn> IS ASSIGNED AND <ls_iwumn> IS NOT INITIAL.
                ls_asmd-conv_den = <ls_iwumn>.
                ls_asmdx-conv_den = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'IWEIN' OF STRUCTURE <lfs_srv_upd> TO <ls_iwein>.
              IF <ls_iwein> IS ASSIGNED AND <ls_iwein> IS NOT INITIAL.
                ls_asmd-work_uom = <ls_iwein>.
                ls_asmdx-work_uom = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'FORMELNR' OF STRUCTURE <lfs_srv_upd> TO <ls_forme>.
              IF <ls_forme> IS ASSIGNED AND <ls_forme> IS NOT INITIAL.
                ls_asmd-formula = <ls_forme>.
                ls_asmdx-formula = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'CHGTEXT' OF STRUCTURE <lfs_srv_upd> TO <ls_chgtext>.
              IF <ls_chgtext> IS ASSIGNED AND <ls_chgtext> IS NOT INITIAL.
                ls_asmd-chgtext = <ls_chgtext>.
                ls_asmdx-chgtext = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'IMAGE_URL' OF STRUCTURE <lfs_srv_upd> TO <ls_url>.
              IF <ls_url> IS ASSIGNED AND <ls_url> IS NOT INITIAL.
                ls_asmd-graphic_url = <ls_url>.
                ls_asmdx-graphic_url = abap_true.
              ENDIF.
              ASSIGN COMPONENT 'ASKTX' OF STRUCTURE <lfs_srv_upd> TO <ls_asktx>.
              IF <ls_asktx> IS ASSIGNED AND <ls_asktx> IS NOT INITIAL.
                ls_service_description-short_text = <ls_asktx>.
                ls_service_description-language = sy-langu.
                APPEND ls_service_description TO lt_service_description.
              ENDIF.
              ls_asmd-master_langu = sy-langu.
              ls_asmdx-master_langu = abap_true.
*              APPEND ls_asmd TO lt_asmd.

*  The BAPI enables you to Change service master records.

              CALL FUNCTION 'BAPI_SERVICE_CHANGE'
                EXPORTING
                  servicenumber       = ls_asmd-service
                  im_service_data     = ls_asmd
                  im_service_datax    = ls_asmdx
                TABLES
                  return              = lt_return
                  service_description = lt_service_description
*                 SERVICE_LONG_TEXTS  =
*                 EXTENSION_IN        =
*                 EXTENSION_OUT       =
                .

            ENDLOOP.
          ENDIF.
*      	WHEN .
        WHEN OTHERS.
      ENDCASE.


    ENDLOOP.

    IF ls_final_id IS NOT INITIAL.

      CALL METHOD io_model->create_data_reference
        EXPORTING
          i_fieldname = 'YY_SERVIC'
          i_struct    = 'KTMAP'
          if_table    = 'X'
        IMPORTING
          er_data     = lr_t_key_map
          et_message  = lt_message.
      IF lt_message IS NOT INITIAL.
        APPEND LINES OF lt_message TO et_message.
        CLEAR lt_message.
      ENDIF.

      ASSIGN lr_t_key_map->* TO <lt_key_map>.
      CREATE DATA lr_key_map LIKE LINE OF <lt_key_map>.

      ASSIGN lr_key_map->* TO <ls_key_map>.
      ASSIGN COMPONENT if_usmd_model_ext=>gc_comp_tmp_key OF STRUCTURE <ls_key_map> TO <ls_tmp_key>.
      ASSIGN COMPONENT if_usmd_model_ext=>gc_comp_final_key OF STRUCTURE <ls_key_map> TO <ls_final_key>.

      IF <ls_tmp_key> IS ASSIGNED AND <ls_service> IS ASSIGNED.
        <ls_tmp_key> = <ls_service>.
      ENDIF.

      IF <ls_final_key> IS ASSIGNED.
        <ls_final_key> = ls_final_id.
      ENDIF.

      INSERT <ls_key_map> INTO TABLE <lt_key_map>.

      ls_tmp_key_map-usmd_entity = 'YY_SERVIC'.
      ls_tmp_key_map-r_t_key_map = lr_t_key_map.
      INSERT ls_tmp_key_map INTO TABLE et_tmp_key_map.

    ENDIF.

  ENDMETHOD.


  METHOD if_usmd_pp_hana_search~adapt_result_list.
    """BOC by Ram
    CLEAR et_data.
    et_data = it_reuse_data_mdg_names.
    LOOP AT et_data ASSIGNING FIELD-SYMBOL(<fs_data>).
      <fs_data>-f_active = 1.
    ENDLOOP.

  ENDMETHOD.


  method IF_USMD_PP_HANA_SEARCH~ADAPT_SEL_FIELDS.
  endmethod.


  method IF_USMD_PP_HANA_SEARCH~ADAPT_WHERE_CLAUSE.
  endmethod.


  METHOD if_usmd_pp_hana_search~get_mapping_info.
   """BOC by Ram
    DATA:
      ls_message TYPE usmd_s_message.
    FIELD-SYMBOLS:
      <ls_reuse_fmap>   LIKE LINE OF gt_reuse_fmap,
      <ls_mapping_info> LIKE LINE OF ct_mapping_info.

    CLEAR et_messages.
    IF is_search_context-entity_main EQ 'YY_SERVIC'.
      me->set_reuse_mapping( ).
    ELSE.
      RETURN.
    ENDIF.

* Add reuse field name
    LOOP AT ct_mapping_info ASSIGNING <ls_mapping_info>
      WHERE reuse_view_fieldname IS INITIAL.

      READ TABLE gt_reuse_fmap
        WITH KEY model           = gc_model_ys   " create a constant for data model
                 entity          = <ls_mapping_info>-entity
                 model_fieldname = <ls_mapping_info>-model_fieldname
       ASSIGNING <ls_reuse_fmap>.
      IF sy-subrc IS INITIAL.
        MOVE-CORRESPONDING <ls_reuse_fmap>   TO <ls_mapping_info>.
        <ls_mapping_info>-reuse_view_fieldname = <ls_reuse_fmap>-reuse_fieldname.
      ELSE.
        IF <ls_mapping_info>-model_fieldname = 'YY_SERVIC'.
          <ls_mapping_info>-reuse_view_fieldname = 'ASNUM'.
          <ls_mapping_info>-reuse_rollname = 'ASNUM'.
        ENDIF.
      ENDIF.
    ENDLOOP.


  ENDMETHOD.


  METHOD if_usmd_pp_hana_search~get_reuse_view_content.
    """BOC by Ram
    TYPES: BEGIN OF ty_reuse_table,
             table TYPE usmd_tab_source,
           END OF ty_reuse_table .
    TYPES:
      tty_reuse_table TYPE SORTED TABLE OF ty_reuse_table
                  WITH UNIQUE KEY table .
    DATA: lt_reuse_table      TYPE tty_reuse_table,
          ls_reuse_table      LIKE LINE OF lt_reuse_table,
          ls_reuse_attributes LIKE LINE OF et_reuse_attributes.

    CLEAR:
      ev_main_table,
      et_join_conditions,
      et_reuse_attributes,
      et_messages.

    IF iv_main_entity EQ 'YY_SERVIC'.
      me->set_reuse_mapping( ).
    ELSE.
      RETURN.
    ENDIF.

    ev_main_table = 'ASMD'.
    LOOP AT it_model_attributes ASSIGNING FIELD-SYMBOL(<ls_model_attributes>).
      READ TABLE gt_reuse_fmap
       ASSIGNING FIELD-SYMBOL(<ls_reuse_fmap>)
        WITH KEY model           = gc_model_ys
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
        IF <ls_model_attributes>-fieldname = 'YY_SERVIC'.
          CLEAR ls_reuse_attributes.
          ls_reuse_attributes-reuse_table = 'ASMD'.
          ls_reuse_attributes-reuse_fieldname = 'ASNUM'.
          ls_reuse_attributes-rollname = 'ASNUM'.
          ls_reuse_attributes-model_fieldname = 'YY_SERVIC'.
          INSERT ls_reuse_attributes INTO TABLE et_reuse_attributes.
        ENDIF.
      ENDIF.
    ENDLOOP.

    LOOP AT et_reuse_attributes ASSIGNING FIELD-SYMBOL(<ls_reuse_attributes>).
      SELECT SINGLE keyflag FROM dd03l INTO @DATA(lv_keyflag)
        WHERE tabname   = @<ls_reuse_attributes>-reuse_table
          AND fieldname = @<ls_reuse_attributes>-reuse_fieldname "#EC CI_NOORDER
.
      IF sy-subrc IS INITIAL.
        <ls_reuse_attributes>-is_key = lv_keyflag.
      ENDIF.
    ENDLOOP.
    """EOD by Ram


  ENDMETHOD.


  method IF_USMD_PP_HANA_SEARCH~MERGE_REUSE_AUTHORIZATION.
  endmethod.


  method SET_REUSE_MAPPING.
    gt_reuse_fmap      = cl_mdg_hdb_reuse_mapping=>get_field_mapping( gc_model_YS ).
    gt_join_conditions = cl_mdg_hdb_reuse_mapping=>get_join_conditions( gc_business_object ).

  endmethod.
ENDCLASS.
