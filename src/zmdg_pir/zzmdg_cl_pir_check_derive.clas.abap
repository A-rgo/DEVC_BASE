class ZZMDG_CL_PIR_CHECK_DERIVE definition
  public
  final
  create public .

public section.

  interfaces IF_BADI_INTERFACE .
  interfaces IF_EX_USMD_RULE_SERVICE .
protected section.
private section.

  methods BUILD_MESSAGE
    importing
      !IS_MESSAGE type USMD_S_MESSAGE
    changing
      !CT_MESSAGE type USMD_T_MESSAGE .
ENDCLASS.



CLASS ZZMDG_CL_PIR_CHECK_DERIVE IMPLEMENTATION.


  method BUILD_MESSAGE.
   "Method to build messages
    DATA:ls_message LIKE LINE OF ct_message.

    IF is_message IS NOT INITIAL.
      CLEAR ls_message.
      ls_message-msgid = is_message-msgid.
      ls_message-msgno = is_message-msgno.
      ls_message-msgv1 = is_message-msgv1.
      ls_message-msgv2 = is_message-msgv2.
      ls_message-msgv3 = is_message-msgv3.
      ls_message-msgv4 = is_message-msgv4.
      ls_message-msgty = is_message-msgty.

      INSERT ls_message INTO TABLE ct_message.
    ENDIF.

  endmethod.


  method IF_EX_USMD_RULE_SERVICE~CHECK_CREQUEST.
  endmethod.


  method IF_EX_USMD_RULE_SERVICE~CHECK_CREQUEST_FINAL.
  endmethod.


  method IF_EX_USMD_RULE_SERVICE~CHECK_CREQUEST_HIERARCHY.
  endmethod.


  method IF_EX_USMD_RULE_SERVICE~CHECK_CREQUEST_START.
  endmethod.


  method IF_EX_USMD_RULE_SERVICE~CHECK_EDITION.
  endmethod.


  method IF_EX_USMD_RULE_SERVICE~CHECK_EDITION_FINAL.
  endmethod.


  method IF_EX_USMD_RULE_SERVICE~CHECK_EDITION_HIERARCHY.
  endmethod.


  method IF_EX_USMD_RULE_SERVICE~CHECK_EDITION_START.
  endmethod.


  method IF_EX_USMD_RULE_SERVICE~CHECK_ENTITY.

    TYPES: BEGIN OF ty_werks,
             matnr TYPE matnr,
             werks TYPE werks_d,
           END OF ty_werks.
    TYPES : BEGIN OF ty_lifnr,
              lifnr TYPE elifn,
              matnr TYPE matnr,
            END OF ty_lifnr.
    TYPES : BEGIN OF ty_lfm1,
              lifnr TYPE elifn,
              ekorg TYPE ekorg,
              sperm TYPE sperm_m,
              loevm TYPE loevm_m,
              matnr TYPE matnr,
            END OF ty_lfm1.
    TYPES : BEGIN OF ty_t024w,
              matnr TYPE matnr,
              werks TYPE werks_d,
              ekorg TYPE ekorg,
            END OF ty_t024w.
    TYPES : BEGIN OF ty_ekgrp,
              matnr TYPE matnr,
              ekgrp TYPE bkgrp,
              werks TYPE werks_d,
            END OF ty_ekgrp.
    TYPES : BEGIN OF ty_meins,
              matnr TYPE matnr,
              meins TYPE meins,
            END OF ty_meins.
    TYPES : BEGIN OF ty_incov,
              matnr   TYPE matnr,
              inco1   TYPE inco1,
              inco2   TYPE inco2,
              incov   TYPE incov,
              inco2_l TYPE inco2_l,
              inco3_l TYPE inco3_l,
            END OF ty_incov.
    TYPES : BEGIN OF ty_mwskz,
              ekorg TYPE ekorg,
              mwskz TYPE mwskz,
              matnr TYPE matnr,
            END OF ty_mwskz.
    TYPES : BEGIN OF ty_mmsta,
              matnr TYPE matnr,
              werks TYPE werks_d,
              mmsta TYPE mmsta,
              mmstd TYPE mmstd,
            END OF ty_mmsta.
    TYPES : BEGIN OF ty_del,
              lifnr TYPE elifn,
              loevm TYPE loevm_x,
              sperm TYPE sperm_x,
            END OF ty_del.
    TYPES : BEGIN OF ty_land1,
              bukrs TYPE bukrs,
              land1 TYPE land1,
            END OF ty_land1.
    TYPES : BEGIN OF ty_bukrs,
              ekorg TYPE ekorg,
              bukrs TYPE bukrs,
            END OF ty_bukrs.
    TYPES : BEGIN OF ty_kalsm,
              land1 TYPE land1,
              kalsm TYPE kalsm_d,
            END OF ty_kalsm.
    TYPES : BEGIN OF ty_mwskz_check,
              ekorg TYPE ekorg,
              mwskz TYPE mwskz,
              kalsm TYPE kalsm_d,
              matnr TYPE matnr,
            END OF ty_mwskz_check,

            BEGIN OF lty_konp,
              datbi_c  TYPE  kodatbi,
              ekorg    TYPE  ekorg,
              lifnr    TYPE  lifnr,
              material TYPE  matnr,
              datab    TYPE  kodatab,
              esokz    TYPE  esokz,
              werks_c  TYPE werks_d,
            END OF lty_konp,

            BEGIN OF lty_a017,
              lifnr TYPE  elifn,
              matnr	TYPE matnr,
              ekorg	TYPE ekorg,
              werks	TYPE werks_d,
              esokz	TYPE esokz,
              knumh	TYPE knumh,
              datab TYPE datab,
              datbi	TYPE kodatbi,
            END OF lty_a017,

            BEGIN OF lty_a018,
              lifnr TYPE  elifn,
              matnr	TYPE matnr,
              ekorg	TYPE ekorg,
              esokz	TYPE esokz,
              knumh	TYPE knumh,
              datab TYPE datab,
              datbi TYPE  kodatbi,
            END OF lty_a018.

    TYPES: BEGIN OF ty_tbd,
             matnr TYPE matnr,
             atinn TYPE atinn,
           END OF ty_tbd.

    TYPES: BEGIN OF ty_atbez,
             atinn TYPE	atinn,
             spras TYPE spras,
             atbez TYPE atbez,
           END OF ty_atbez.

    DATA : lr_data            TYPE REF TO data,
           lr_data1           TYPE REF TO data,
           lr_data2           TYPE REF TO data,

           lt_werks           TYPE STANDARD TABLE OF ty_werks,
           lt_sel             TYPE usmd_ts_sel,
           lt_incov           TYPE STANDARD TABLE OF ty_incov,
           lt_incov_tmp1      TYPE STANDARD TABLE OF ty_incov,
           lt_incov_tmp2      TYPE STANDARD TABLE OF ty_incov,
           lt_tincvmap        TYPE TABLE OF tincvmap,
           lt_lfm1            TYPE STANDARD TABLE OF ty_lfm1,
           lt_lfm1_tmp        TYPE STANDARD TABLE OF ty_lfm1,
           lt_lfm1_x          TYPE STANDARD TABLE OF ty_lfm1,
           lt_lifnr           TYPE STANDARD TABLE OF ty_lifnr,
           lt_lifnr_tmp       TYPE STANDARD TABLE OF ty_lifnr,
           lt_ekgrp           TYPE STANDARD TABLE OF ty_ekgrp,
           lt_meins           TYPE STANDARD TABLE OF ty_meins,
           lt_t024w           TYPE TABLE OF t024w,
           lt_t024            TYPE STANDARD TABLE OF ty_t024w,
           lt_konp            TYPE STANDARD TABLE OF lty_konp,
           lt_a017            TYPE STANDARD TABLE OF lty_a017,
           lt_cond_tab        TYPE STANDARD TABLE OF lty_a017,
           lt_a018            TYPE STANDARD TABLE OF lty_a018,
           lt_konp_tmp        TYPE STANDARD TABLE OF lty_konp,
           lt_konp_t1         TYPE STANDARD TABLE OF lty_konp,
           lt_mwskz_check     TYPE TABLE OF ty_mwskz_check,
           lt_mwskz_check_tmp TYPE TABLE OF ty_mwskz_check,
           lt_t007a           TYPE TABLE OF t007a,
           lt_tinc            TYPE TABLE OF tinc,
           lt_mmsta           TYPE STANDARD TABLE OF ty_mmsta,
           lt_mwskz           TYPE STANDARD TABLE OF ty_mwskz,
           lt_mwskz_tmp       TYPE STANDARD TABLE OF ty_mwskz,
           lt_land1           TYPE TABLE OF ty_land1,
           lt_kalsm           TYPE TABLE OF ty_kalsm,

           ls_werks           LIKE LINE OF lt_werks,
           ls_incov           TYPE ty_incov,
           ls_tincvmap        LIKE LINE OF lt_tincvmap,
           ls_sel             LIKE LINE OF lt_sel,
           ls_message         TYPE usmd_s_message,
           ls_lfm1            TYPE ty_lfm1,
           ls_a018            TYPE lty_a018,
           ls_cond_tab        TYPE lty_a017,
           ls_lifnr           TYPE ty_lifnr,
           ls_ekgrp           TYPE ty_ekgrp,
           ls_t024            LIKE LINE OF lt_t024,
           ls_konp            TYPE lty_konp,
           ls_konp_t          TYPE lty_konp,
           ls_t007a           LIKE LINE OF lt_t007a,
           ls_meins           TYPE ty_meins,
           ls_tinc            LIKE LINE OF lt_tinc,
           ls_mwskz           TYPE ty_mwskz,
           ls_mmsta           TYPE ty_mmsta,
           lt_t141            TYPE TABLE OF t141,
           ls_t141            LIKE LINE OF lt_t141,
           lt_del             TYPE STANDARD TABLE OF ty_del,
           ls_del             TYPE ty_del,
           ls_land1           LIKE LINE OF lt_land1,
           lt_bukrs           TYPE TABLE OF ty_bukrs,
           ls_bukrs           TYPE ty_bukrs,
           ls_kalsm           TYPE ty_kalsm,
           ls_mwskz_check     LIKE LINE OF lt_mwskz_check,

           lv_message         TYPE string,
           lf_flag            TYPE boolean,
           lv_flag            TYPE boolean,
           lv_datef1          TYPE dats,
           lv_datet1          TYPE dats,
           lv_datef2          TYPE dats,
           lv_datet2          TYPE dats,
           lv_exflag          TYPE boolean,
           lv_count           TYPE i,
           lv_datab           TYPE datab,
           lv_datbi           TYPE datbi,
           lv_char_name       TYPE string,
           lv_class_flag      TYPE flag,
           lv_oem_flag        TYPE flag,
           lv_mfr             TYPE string,
           lt_tbd             TYPE STANDARD TABLE OF ty_tbd,
           ls_tbd             TYPE ty_tbd,
           lt_atbez           TYPE STANDARD TABLE OF ty_atbez,
           ls_atbez           TYPE ty_atbez,
           ls_t001            TYPE t001.

    DATA: lv_manufacturer_name TYPE string,
          lv_length_manu_name  TYPE i.

    DATA: lv_material          TYPE matnr.
    DATA: ls_tcurm             TYPE tcurm.

    FIELD-SYMBOLS : <ft_data>   TYPE ANY TABLE,
                    <ft_data1>  TYPE ANY TABLE,
                    <ft_data2>  TYPE ANY TABLE,
                    <ft_data3>  TYPE ANY TABLE,
                    <fs_data>   TYPE any,
                    <fs_data1>  TYPE any,
                    <fs_data3>  TYPE any,
                    <fs_value>  TYPE any,
                    <fs_datab>  TYPE any,
                    <fs_datbi>  TYPE any,
                    <fs_value1> TYPE any,
                    <fs_value2> TYPE any,
                    <fs_value3> TYPE any,
                    <fs_norbm>  TYPE any,
                    <fs_meins>  TYPE any,
                    <fs_infnr>  TYPE any,
                    <fs_minbm>  TYPE any,
                    <fs_lifnr>  TYPE any,
                    <fs_netpr>  TYPE any,
                    <fs_ekorg>  TYPE any,
                    <fs_ekgrp>  TYPE any.

    CONSTANTS : lc_msg_cls TYPE string VALUE 'ZZMDG_PIR_MSG'.

    CLEAR : et_message.
    ASSIGN it_data TO <ft_data>.
    CHECK <ft_data> IS ASSIGNED.

      IF id_entitytype = 'ZPURCHINF'.
        LOOP AT <ft_data> ASSIGNING <fs_data>.
          ASSIGN COMPONENT 'EKWRK' OF STRUCTURE <fs_data> TO <fs_value>.
          ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <fs_data> TO <fs_value1>.
          IF sy-subrc IS INITIAL.
            CLEAR lv_material.
            lv_material = <fs_value1>.
          ENDIF.
          IF <fs_value1> IS ASSIGNED AND <fs_value1> IS NOT INITIAL.
            ls_sel-fieldname = 'MATERIAL'.
            ls_sel-sign = 'I'.
            ls_sel-option = 'EQ'.
            ls_sel-low = <fs_value1>.
            READ TABLE lt_sel FROM ls_sel TRANSPORTING NO FIELDS.
            IF sy-subrc <> 0.
              INSERT ls_sel INTO TABLE lt_sel.
            ENDIF.
            CLEAR : ls_sel.
          ENDIF.

          IF <fs_value> IS ASSIGNED AND <fs_value> IS NOT INITIAL
            AND <fs_value1> IS ASSIGNED AND <fs_value1> IS NOT INITIAL.
            ls_werks-matnr = <fs_value1>.
            ls_werks-werks = <fs_value>.
            APPEND ls_werks TO lt_werks.
            CLEAR : ls_werks.
          ENDIF.

          ASSIGN COMPONENT 'MINBM' OF STRUCTURE <fs_data> TO <fs_minbm>.
          ASSIGN COMPONENT 'NORBM' OF STRUCTURE <fs_data> TO <fs_norbm>.
          ASSIGN COMPONENT 'INFNR' OF STRUCTURE <fs_data> TO <fs_infnr>.
          ASSIGN COMPONENT 'NETPR' OF STRUCTURE <fs_data> TO <fs_netpr>.
          IF <fs_minbm> IS ASSIGNED AND <fs_minbm> IS NOT INITIAL AND <fs_norbm> IS ASSIGNED AND <fs_norbm> IS NOT INITIAL.
            IF <fs_minbm> GT <fs_norbm>.
              MESSAGE ID lc_msg_cls TYPE 'E' NUMBER 002 WITH lv_material INTO lv_message.
              MOVE-CORRESPONDING sy TO ls_message.
              ls_message-msgty = 'E'.
              build_message(
                EXPORTING
                  is_message = ls_message                 " Messages
                CHANGING
                  ct_message = et_message                 " Messages
              ).
            ENDIF.
          ENDIF.
          IF <fs_norbm> IS INITIAL.
            CLEAR : ls_message.
            MESSAGE ID lc_msg_cls TYPE 'E' NUMBER 003 WITH lv_material INTO lv_message.
            MOVE-CORRESPONDING sy TO ls_message.
            ls_message-msgty = 'E'.
            build_message(
              EXPORTING
                is_message = ls_message                 " Messages
              CHANGING
                ct_message = et_message                 " Messages
            ).
          ENDIF.
          IF <fs_netpr> IS INITIAL.
            CLEAR : ls_message.
            MESSAGE ID lc_msg_cls TYPE 'E' NUMBER 004 WITH lv_material INTO lv_message.
            MOVE-CORRESPONDING sy TO ls_message.
            ls_message-msgty = 'E'.
            build_message(
              EXPORTING
                is_message = ls_message                 " Messages
              CHANGING
                ct_message = et_message                 " Messages
            ).
          ENDIF.

          ASSIGN COMPONENT 'LIFNR' OF STRUCTURE <fs_data> TO <fs_lifnr>.
          ASSIGN COMPONENT 'EKORG' OF STRUCTURE <fs_data> TO <fs_ekorg>.
          IF <fs_ekorg> IS ASSIGNED AND <fs_ekorg> IS NOT INITIAL.
          CALL FUNCTION 'WCB_COMP_CODE_OF_PURCH_ORG'
            EXPORTING
              i_ekorg         = <fs_ekorg>
            IMPORTING
              e_t001          = ls_t001
            EXCEPTIONS
              ekorg_not_found = 1
              bukrs_not_found = 2
              OTHERS          = 3.
          IF sy-subrc <> 0.
* Implement suitable error handling here
            MESSAGE ID lc_msg_cls TYPE 'E' NUMBER 005 WITH lv_material INTO lv_message.
            MOVE-CORRESPONDING sy TO ls_message.
              build_message(
                EXPORTING
                  is_message = ls_message                 " Messages
                CHANGING
                  ct_message = et_message                 " Messages
              ).
          ENDIF.
          ENDIF.
          IF <fs_lifnr> IS ASSIGNED AND <fs_lifnr> IS NOT INITIAL AND <fs_ekorg> IS ASSIGNED AND <fs_ekorg> IS NOT INITIAL.
            ls_lfm1-matnr = lv_material.
            ls_lfm1-lifnr = <fs_lifnr>.
            ls_lfm1-ekorg = <fs_ekorg>.
            APPEND ls_lfm1 TO lt_lfm1.
            CLEAR : ls_lfm1.
          ENDIF.

          IF <fs_lifnr> IS ASSIGNED AND <fs_lifnr> IS NOT INITIAL
            AND <fs_value1> IS ASSIGNED AND <fs_value1> IS NOT INITIAL.
            ls_lifnr-matnr = <fs_value1>.
            ls_lifnr-lifnr = <fs_lifnr>.
            APPEND ls_lifnr TO lt_lifnr.
            CLEAR : ls_lifnr.
          ENDIF.

          ASSIGN COMPONENT 'EKGRP_P' OF STRUCTURE <fs_data> TO <fs_ekgrp>.
          IF <fs_ekgrp> IS ASSIGNED AND <fs_ekgrp> IS INITIAL.
            CLEAR : ls_message.
            MESSAGE ID lc_msg_cls TYPE 'E' NUMBER 006 WITH lv_material INTO lv_message.
            MOVE-CORRESPONDING sy TO ls_message.
            ls_message-msgty = 'E'.
            build_message(
              EXPORTING
                is_message = ls_message                 " Messages
              CHANGING
                ct_message = et_message                 " Messages
            ).
          ELSEIF <fs_ekgrp> IS ASSIGNED AND <fs_ekgrp> IS NOT INITIAL AND <fs_value> IS ASSIGNED AND <fs_value> IS NOT INITIAL.
            ls_ekgrp-matnr = <fs_value1>.
            ls_ekgrp-ekgrp = <fs_ekgrp>.
            ls_ekgrp-werks = <fs_value>.
            APPEND ls_ekgrp TO lt_ekgrp.
            CLEAR : ls_ekgrp.
          ENDIF.

          ASSIGN COMPONENT 'BPRME' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_bprme>).
          IF <fs_bprme> IS ASSIGNED AND <fs_bprme> IS NOT INITIAL.
            ls_meins-matnr = <fs_value1>.
            ls_meins-meins = <fs_bprme>.
            APPEND ls_meins TO lt_meins.
            CLEAR : ls_meins.
          ENDIF.

          ASSIGN COMPONENT 'APLFZ' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_aplfz>).
          IF <fs_aplfz> IS ASSIGNED AND <fs_aplfz> IS INITIAL.
            CLEAR : ls_message.
            MESSAGE ID lc_msg_cls TYPE 'E' NUMBER 007 WITH lv_material INTO lv_message.
            MOVE-CORRESPONDING sy TO ls_message.
            ls_message-msgty = 'E'.
            build_message(
              EXPORTING
                is_message = ls_message                 " Messages
              CHANGING
                ct_message = et_message                 " Messages
            ).
          ENDIF.

          IF <fs_value1> IS ASSIGNED AND <fs_value1> IS NOT INITIAL
            AND <fs_value> IS ASSIGNED AND <fs_value> IS NOT INITIAL
            AND <fs_ekorg> IS ASSIGNED AND <fs_ekorg> IS NOT INITIAL.
            ls_t024-matnr = <fs_value1>.
            ls_t024-werks = <fs_value>.
            ls_t024-ekorg = <fs_ekorg>.
            APPEND ls_t024 TO lt_t024.
            CLEAR : ls_t024.
          ENDIF.

          ASSIGN COMPONENT 'BPRME' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_bprme1>).
          IF <fs_bprme1> IS ASSIGNED AND <fs_bprme1> IS INITIAL.
            CLEAR : ls_message.
            MESSAGE ID lc_msg_cls TYPE 'E' NUMBER 008 WITH lv_material INTO lv_message.
            MOVE-CORRESPONDING sy TO ls_message.
            ls_message-msgty = 'E'.
            build_message(
              EXPORTING
                is_message = ls_message                 " Messages
              CHANGING
                ct_message = et_message                 " Messages
            ).
          ENDIF.

          ASSIGN COMPONENT 'INCO1' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fv_inco1>).
          ASSIGN COMPONENT 'INCOV' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fv_incov>).
          ASSIGN COMPONENT 'INCO2_L' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_inco2l>).
          ASSIGN COMPONENT 'INCO3_L' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_inco3l>).
          IF <fv_inco1> IS ASSIGNED AND <fv_incov> IS ASSIGNED AND <fs_inco2l> IS ASSIGNED AND <fs_inco3l> IS ASSIGNED.
            ls_incov-matnr = lv_material.
            ls_incov-inco1 = <fv_inco1>.
            ls_incov-incov = <fv_incov>.
            ls_incov-inco2_l = <fs_inco2l>.
            ls_incov-inco3_l = <fs_inco3l>.
            APPEND ls_incov TO lt_incov.
            CLEAR : ls_incov.
          ENDIF.

          ASSIGN COMPONENT 'MWSKZ_P' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fv_mwskz>).
          IF <fv_mwskz> IS ASSIGNED AND <fv_mwskz> IS NOT INITIAL
            AND <fs_ekorg> IS ASSIGNED AND <fs_ekorg> IS NOT INITIAL.
            ls_mwskz-matnr = lv_material.
            ls_mwskz-ekorg = <fs_ekorg>.
            ls_mwskz-mwskz = <fv_mwskz>.
            APPEND ls_mwskz TO lt_mwskz.
          ENDIF.

          ASSIGN COMPONENT 'ESOKZ' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_esokz>).
          IF <fs_esokz> IS ASSIGNED AND <fs_esokz> = '1'.
            IF <fs_lifnr> IS ASSIGNED AND <fs_ekorg> IS ASSIGNED.
              CLEAR ls_tcurm.
              SELECT SINGLE * FROM tcurm INTO ls_tcurm.
              IF sy-subrc IS NOT INITIAL OR ls_tcurm-charg IS INITIAL.
                CLEAR : ls_message.
                MESSAGE ID lc_msg_cls TYPE 'E' NUMBER 009 WITH lv_material <fs_lifnr> <fs_ekorg> INTO lv_message.
                MOVE-CORRESPONDING sy TO ls_message.
                ls_message-msgty = 'E'.
                build_message(
                  EXPORTING
                    is_message = ls_message                 " Messages
                  CHANGING
                    ct_message = et_message                 " Messages
                ).
              ENDIF.
            ENDIF.
          ENDIF.
        ENDLOOP.

        IF lt_sel IS NOT INITIAL.
          "Plant based Validation
          io_model->create_data_reference( EXPORTING i_fieldname = 'MARCBASIC' i_struct = 'KATTR' IMPORTING er_data = lr_data ).
          ASSIGN lr_data->* TO <ft_data1>.
          CHECK <ft_data1> IS ASSIGNED.
          io_model->read_char_value( EXPORTING i_fieldname = 'MARCBASIC' it_sel = lt_sel IMPORTING et_data = <ft_data1> ).
          UNASSIGN : <fs_value>, <fs_value1>, <fs_data>.
          IF <ft_data1> IS ASSIGNED AND <ft_data1> IS NOT INITIAL.
            LOOP AT lt_werks INTO ls_werks.
              lv_flag = abap_false.
              LOOP AT <ft_data1> ASSIGNING <fs_data>.
                ASSIGN COMPONENT 'WERKS' OF STRUCTURE <fs_data> TO <fs_value>.
                ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <fs_data> TO <fs_value1>.
                IF sy-subrc IS INITIAL.
                  CLEAR lv_material.
                  lv_material = <fs_value1>.
                ENDIF.
                IF <fs_value> IS ASSIGNED
                  AND <fs_value> IS NOT INITIAL
                  AND <fs_value1> IS ASSIGNED
                  AND <fs_value1> IS NOT INITIAL.
                  IF <fs_value1> = ls_werks-matnr AND <fs_value> = ls_werks-werks.
                    lv_flag = abap_true.
                    "Plant spec material status validation
                    ASSIGN COMPONENT 'MMSTA' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_mmsta>).
                    ASSIGN COMPONENT 'MMSTD' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_mmstd>).
                    IF <fs_mmsta> IS ASSIGNED AND <fs_mmsta> IS NOT INITIAL.
                      IF <fs_mmstd> IS ASSIGNED AND ( <fs_mmstd> IS INITIAL OR <fs_mmstd> LE sy-datlo ).
                        ls_mmsta-matnr = ls_werks-matnr.
                        ls_mmsta-werks = ls_werks-werks.
                        ls_mmsta-mmsta = <fs_mmsta>.
                        ls_mmsta-mmstd = <fs_mmstd>.
                        INSERT ls_mmsta INTO TABLE lt_mmsta.
                        CLEAR : ls_mmsta.
                      ENDIF.
                    ENDIF.
                  ENDIF.
                ENDIF.
              ENDLOOP.
              IF lv_flag <> abap_true.
                CLEAR : ls_message.
                MESSAGE ID lc_msg_cls TYPE 'E' NUMBER 010 WITH ls_werks-werks lv_material INTO lv_message.
                MOVE-CORRESPONDING sy TO ls_message.
                ls_message-msgty = 'E'.
                build_message(
                  EXPORTING
                    is_message = ls_message                 " Messages
                  CHANGING
                    ct_message = et_message                 " Messages
                ).
              ENDIF.
            ENDLOOP.
          ELSEIF <ft_data1> IS ASSIGNED AND <ft_data1> IS INITIAL.
            IF lt_werks IS NOT INITIAL.
              LOOP AT lt_werks INTO ls_werks.
                CLEAR : ls_message.
                MESSAGE ID lc_msg_cls TYPE 'E' NUMBER 010 WITH ls_werks-werks ls_werks-matnr INTO lv_message.
                MOVE-CORRESPONDING sy TO ls_message.
                ls_message-msgty = 'E'.
                build_message(
                  EXPORTING
                    is_message = ls_message                 " Messages
                  CHANGING
                    ct_message = et_message                 " Messages
                ).
              ENDLOOP.
            ENDIF.
          ENDIF.

          io_model->create_data_reference( EXPORTING i_fieldname = 'MATERIAL' i_struct = 'KATTR' IMPORTING er_data = lr_data2 ).
          ASSIGN lr_data2->* TO <ft_data3>.
          CHECK <ft_data3> IS ASSIGNED.
          io_model->read_char_value( EXPORTING i_fieldname = 'MATERIAL' it_sel = lt_sel IMPORTING et_data = <ft_data3> ).
          LOOP AT <ft_data3> ASSIGNING <fs_data3>.
            ASSIGN COMPONENT 'MSTAE' OF STRUCTURE <fs_data> TO <fs_value1>.
            ASSIGN COMPONENT 'MSTDE' OF STRUCTURE <fs_data> TO <fs_value2>.
            IF <fs_value1> IS ASSIGNED AND <fs_value1> IS NOT INITIAL AND
              <fs_value2> IS ASSIGNED AND ( <fs_value2> IS INITIAL OR <fs_value2> LE sy-datlo ).
              ls_mmsta-matnr = <fs_value>.
              ls_mmsta-mmsta = <fs_value1>.
              ls_mmsta-mmstd = <fs_value2>.
              INSERT ls_mmsta INTO TABLE lt_mmsta.
              CLEAR : ls_mmsta.
            ENDIF.
          ENDLOOP.

          "Plant Spec Material status validation
          IF lt_mmsta IS NOT INITIAL.
            SELECT * FROM t141 INTO TABLE lt_t141 FOR ALL ENTRIES IN lt_mmsta WHERE mmsta = lt_mmsta-mmsta.
            LOOP AT lt_t141 INTO ls_t141.
              CLEAR : lv_flag.
              CASE ls_t141-deink.
                WHEN 'B'.                 "error
                  LOOP AT lt_mmsta INTO ls_mmsta WHERE mmsta = ls_t141-mmsta.
                    LOOP AT <ft_data> ASSIGNING <fs_data>.
                      ASSIGN COMPONENT 'INFNR_O' OF STRUCTURE <fs_data> TO <fs_value>.
                      ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <fs_data> TO <fs_value1>.
                      IF sy-subrc IS INITIAL.
                        CLEAR lv_material.
                        lv_material = <fs_value1>.
                      ENDIF.
                      ASSIGN COMPONENT 'EKWRK' OF STRUCTURE <fs_data> TO <fs_value2>.
                      IF <fs_value1> IS ASSIGNED AND <fs_value1> = ls_mmsta-matnr.
                        IF <fs_value> IS ASSIGNED AND <fs_value> IS INITIAL AND ls_mmsta-werks IS INITIAL.
                          lv_flag = abap_true.
                          EXIT.
                        ENDIF.
                        IF ls_mmsta-werks IS NOT INITIAL AND <fs_value> IS ASSIGNED AND <fs_value> IS INITIAL
                          AND <fs_value2> IS ASSIGNED AND <fs_value2> = ls_mmsta-werks.
                          lv_flag = abap_true.
                          EXIT.
                        ENDIF.
                      ENDIF.
                    ENDLOOP.
                  ENDLOOP.

                  CHECK lv_flag IS NOT INITIAL.

                  CLEAR : ls_message.
                  MESSAGE ID lc_msg_cls TYPE 'E' NUMBER 011 WITH lv_material INTO lv_message.
                  MOVE-CORRESPONDING sy TO ls_message.
                  ls_message-msgty = 'E'.
                  build_message(
                    EXPORTING
                      is_message = ls_message                 " Messages
                    CHANGING
                      ct_message = et_message                 " Messages
                  ).
                WHEN 'A'.                 "warning
                  CLEAR : ls_message.
                  MESSAGE ID lc_msg_cls TYPE 'W' NUMBER 011 INTO lv_message.
                  MOVE-CORRESPONDING sy TO ls_message.
                  ls_message-msgty = 'W'.
                  build_message(
                    EXPORTING
                      is_message = ls_message                 " Messages
                    CHANGING
                      ct_message = et_message                 " Messages
                  ).
                WHEN OTHERS.
              ENDCASE.
            ENDLOOP.
          ENDIF.
          CLEAR : lv_flag.
          "Plant Purchasing based validation
          IF lt_ekgrp IS NOT INITIAL.
            CLEAR : lr_data.
            UNASSIGN : <ft_data1>.
            io_model->create_data_reference( EXPORTING i_fieldname = 'MARCPURCH' i_struct = 'KATTR' IMPORTING er_data = lr_data ).
            ASSIGN lr_data->* TO <ft_data1>.
            CHECK <ft_data1> IS ASSIGNED.
            io_model->read_char_value( EXPORTING i_fieldname = 'MARCPURCH' it_sel = lt_sel IMPORTING et_data = <ft_data1> ).
            UNASSIGN : <fs_value>, <fs_value1>, <fs_data>.
            IF <ft_data1> IS NOT INITIAL.
              LOOP AT lt_ekgrp INTO ls_ekgrp.
                lv_flag = abap_false.
                LOOP AT <ft_data1> ASSIGNING <fs_data>.
                  ASSIGN COMPONENT 'EKGRP' OF STRUCTURE <fs_data> TO <fs_value1>.
                  ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <fs_data> TO <fs_value>.
                  IF sy-subrc IS INITIAL.
                    CLEAR lv_material.
                    lv_material = <fs_value>.
                  ENDIF.
                  ASSIGN COMPONENT 'WERKS' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_ekwrk>).
                  IF <fs_ekwrk> IS ASSIGNED AND <fs_ekwrk> IS NOT INITIAL
                  AND <fs_value> IS ASSIGNED AND <fs_value> IS NOT INITIAL.
*                  READ TABLE lt_ekgrp WITH KEY matnr = <fs_value> werks = <fs_ekwrk> TRANSPORTING NO FIELDS.
                    IF ls_ekgrp-matnr = <fs_value> AND ls_ekgrp-werks = <fs_ekwrk>.
                      lv_flag = abap_true.
                      EXIT.
                    ENDIF.
                  ELSEIF <fs_value> IS ASSIGNED AND <fs_value> = ls_ekgrp-matnr
                    AND <fs_ekwrk> IS ASSIGNED AND <fs_ekwrk> = ls_ekgrp-werks
                    AND <fs_value1> IS ASSIGNED AND <fs_value1> IS INITIAL.
                  ENDIF.
                ENDLOOP.
                IF lv_flag <> abap_true.
                  CLEAR : ls_message.
                  MESSAGE ID lc_msg_cls TYPE 'E' NUMBER 012 WITH lv_material INTO lv_message.
                  MOVE-CORRESPONDING sy TO ls_message.
                  ls_message-msgty = 'E'.
                  build_message(
                    EXPORTING
                      is_message = ls_message                 " Messages
                    CHANGING
                      ct_message = et_message                 " Messages
                  ).
                ENDIF.
              ENDLOOP.
            ELSE.
              CLEAR : ls_message.
              MESSAGE ID lc_msg_cls TYPE 'E' NUMBER 012 INTO lv_message.
              MOVE-CORRESPONDING sy TO ls_message.
              ls_message-msgty = 'E'.
              build_message(
                EXPORTING
                  is_message = ls_message                 " Messages
                CHANGING
                  ct_message = et_message                 " Messages
              ).
            ENDIF.

          ENDIF.

          "Automatic Purchase Order allowed checkbox
          IF lt_werks IS NOT INITIAL.
            UNASSIGN : <ft_data1>.
            io_model->create_data_reference( EXPORTING i_fieldname = 'MARCPURCH' i_struct = 'KATTR' IMPORTING er_data = lr_data ).
            ASSIGN lr_data->* TO <ft_data1>.
            CHECK <ft_data1> IS ASSIGNED.
            io_model->read_char_value( EXPORTING i_fieldname = 'MARCPURCH' it_sel = lt_sel IMPORTING et_data = <ft_data1> ).

            io_model->create_data_reference( EXPORTING i_fieldname = 'MATERIAL' i_struct = 'KATTR' IMPORTING er_data = lr_data2 ).
            ASSIGN lr_data2->* TO <ft_data3>.
            CHECK <ft_data3> IS ASSIGNED.
            io_model->read_char_value( EXPORTING i_fieldname = 'MATERIAL' it_sel = lt_sel IMPORTING et_data = <ft_data3> ).

            UNASSIGN : <fs_value>, <fs_value1>, <fs_data>.

            IF <ft_data1> IS NOT INITIAL AND <ft_data3> IS NOT INITIAL.
              LOOP AT <ft_data3> ASSIGNING <fs_data3>.
                ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <fs_data3> TO FIELD-SYMBOL(<fv_matnr>).
                ASSIGN COMPONENT 'MTART' OF STRUCTURE <fs_data3> TO FIELD-SYMBOL(<fv_mtart>).
                IF <fv_matnr> IS ASSIGNED AND <fv_matnr> IS NOT INITIAL
                  AND <fv_mtart> IS ASSIGNED AND <fv_mtart> IS NOT INITIAL.
                  IF <ft_data1> IS NOT INITIAL.
                    LOOP AT <ft_data1> ASSIGNING <fs_data>.
                      ASSIGN COMPONENT 'WERKS' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_werks>).
                      ASSIGN COMPONENT 'KAUTB' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fv_kautb>).
                      ASSIGN COMPONENT 'KORDB' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fv_kordb1>).
                      IF ( <fv_kautb> IS ASSIGNED AND <fv_kautb> IS INITIAL )
                        AND ( <fv_kordb1> IS ASSIGNED AND <fv_kordb1> IS INITIAL ).
                        READ TABLE lt_werks WITH KEY werks = <fs_werks> matnr = <fv_matnr> INTO ls_werks.
                        IF sy-subrc IS INITIAL.
                          CLEAR : ls_message.
                          MESSAGE ID lc_msg_cls TYPE 'E' NUMBER 013 WITH ls_werks-matnr ls_werks-werks INTO lv_message.
                          MOVE-CORRESPONDING sy TO ls_message.
                          ls_message-msgty = 'E'.
                          build_message(
                            EXPORTING
                              is_message = ls_message                 " Messages
                            CHANGING
                              ct_message = et_message                 " Messages
                          ).
                        ENDIF.
                      ENDIF.
                    ENDLOOP.
                  ELSE.
                    CLEAR : ls_message.
                    MESSAGE ID lc_msg_cls TYPE 'E' NUMBER 013 INTO lv_message.
                    MOVE-CORRESPONDING sy TO ls_message.
                    ls_message-msgty = 'E'.
                    build_message(
                      EXPORTING
                        is_message = ls_message                 " Messages
                      CHANGING
                        ct_message = et_message                 " Messages
                    ).
                  ENDIF.
                ENDIF.
              ENDLOOP.

            ENDIF.
          ENDIF.
          "Inco terms validations
*         >> Sort & Delete before for all entries:
          lt_incov_tmp1 = lt_incov_tmp2 = lt_incov.
          SORT lt_incov_tmp1 BY incov inco1.
          DELETE ADJACENT DUPLICATES FROM lt_incov_tmp1 COMPARING incov inco1.

          IF lt_incov_tmp1 IS NOT INITIAL.
            SELECT *
              FROM tincvmap
              INTO TABLE lt_tincvmap
              FOR ALL ENTRIES IN lt_incov_tmp1
              WHERE incov = lt_incov_tmp1-incov
                AND inco1 = lt_incov_tmp1-inco1.
          ENDIF.

          SORT lt_incov_tmp2 BY inco1.
          DELETE ADJACENT DUPLICATES FROM lt_incov_tmp2 COMPARING inco1.

          IF lt_incov_tmp2 IS NOT INITIAL.
            SELECT *
              FROM tinc
              INTO TABLE lt_tinc
              FOR ALL ENTRIES IN lt_incov_tmp2
              WHERE inco1 = lt_incov_tmp2-inco1.
          ENDIF.

          IF lt_tincvmap IS NOT INITIAL OR lt_tinc IS NOT INITIAL.
            LOOP AT lt_incov INTO ls_incov.
              IF ls_incov-inco1 IS NOT INITIAL AND ls_incov-incov IS NOT INITIAL.
                READ TABLE lt_tincvmap INTO ls_tincvmap WITH KEY incov = ls_incov-incov inco1 = ls_incov-inco1.
                IF sy-subrc IS INITIAL.
                  IF ls_tincvmap-ortob = abap_true AND ls_incov-inco2_l IS INITIAL.
                    CLEAR : ls_message.
                    MESSAGE ID lc_msg_cls TYPE 'E' NUMBER 014 WITH ls_incov-matnr INTO lv_message.
                    MOVE-CORRESPONDING sy TO ls_message.
                    ls_message-msgty = 'E'.
                    build_message(
                      EXPORTING
                        is_message = ls_message                 " Messages
                      CHANGING
                        ct_message = et_message                 " Messages
                    ).
                  ENDIF.

                  IF ls_tincvmap-bstob = 'R' AND ls_incov-inco3_l IS INITIAL.
                    CLEAR : ls_message.
                    MESSAGE ID lc_msg_cls TYPE 'E' NUMBER 015 WITH ls_incov-matnr INTO lv_message.
                    MOVE-CORRESPONDING sy TO ls_message.
                    ls_message-msgty = 'E'.
                    build_message(
                      EXPORTING
                        is_message = ls_message                 " Messages
                      CHANGING
                        ct_message = et_message                 " Messages
                    ).
                  ENDIF.

                  IF ls_tincvmap-bstob = abap_false AND ls_incov-inco3_l IS NOT INITIAL.
                    CLEAR : ls_message.
                    MESSAGE ID lc_msg_cls TYPE 'E' NUMBER 016 WITH ls_incov-inco1 ls_incov-incov ls_incov-matnr INTO lv_message.
                    MOVE-CORRESPONDING sy TO ls_message.
                    ls_message-msgty = 'E'.
                    build_message(
                      EXPORTING
                        is_message = ls_message                 " Messages
                      CHANGING
                        ct_message = et_message                 " Messages
                    ).
                  ENDIF.
                ELSE.
                  CLEAR : ls_message.
                  MESSAGE ID lc_msg_cls TYPE 'E' NUMBER 017 WITH ls_incov-matnr ls_incov-inco1 ls_incov-incov INTO lv_message.
                  MOVE-CORRESPONDING sy TO ls_message.
                  ls_message-msgty = 'E'.
                  build_message(
                    EXPORTING
                      is_message = ls_message                 " Messages
                    CHANGING
                      ct_message = et_message                 " Messages
                  ).
                ENDIF.
              ELSEIF ls_incov-inco1 IS NOT INITIAL AND ls_incov-incov IS INITIAL.
                READ TABLE lt_tinc INTO ls_tinc WITH KEY inco1 = ls_incov-inco1.
                IF sy-subrc IS INITIAL.
                  IF ls_incov-inco2_l IS INITIAL AND ls_tinc-ortob = abap_true.
                    CLEAR : ls_message.
                    MESSAGE ID lc_msg_cls TYPE 'E' NUMBER 014 WITH ls_incov-matnr INTO lv_message.
                    MOVE-CORRESPONDING sy TO ls_message.
                    ls_message-msgty = 'E'.
                    build_message(
                      EXPORTING
                        is_message = ls_message                 " Messages
                      CHANGING
                        ct_message = et_message                 " Messages
                    ).
                  ENDIF.
                ENDIF.
              ENDIF.

              IF ls_incov-inco1 IS NOT INITIAL AND ls_incov-inco2_l IS NOT INITIAL AND ls_incov-inco3_l IS NOT INITIAL AND ls_incov-incov IS INITIAL.
                CLEAR : ls_message.
                MESSAGE ID lc_msg_cls TYPE 'E' NUMBER 018 WITH ls_incov-matnr INTO lv_message.
                MOVE-CORRESPONDING sy TO ls_message.
                ls_message-msgty = 'E'.
                build_message(
                  EXPORTING
                    is_message = ls_message                 " Messages
                  CHANGING
                    ct_message = et_message                 " Messages
                ).
              ENDIF.
            ENDLOOP.
          ENDIF.

          lt_mwskz_tmp = lt_mwskz.
          SORT lt_mwskz_tmp BY ekorg.
          DELETE ADJACENT DUPLICATES FROM lt_mwskz_tmp COMPARING ekorg.
          IF lt_mwskz_tmp IS NOT INITIAL.
            SELECT ekorg bukrs FROM t024e INTO TABLE lt_bukrs FOR ALL ENTRIES IN lt_mwskz_tmp WHERE ekorg = lt_mwskz_tmp-ekorg.
            IF lt_bukrs IS NOT INITIAL.
              SORT lt_bukrs BY ekorg.
              DELETE ADJACENT DUPLICATES FROM lt_bukrs.
              SELECT bukrs land1 FROM t001 INTO TABLE lt_land1 FOR ALL ENTRIES IN lt_bukrs WHERE bukrs = lt_bukrs-bukrs.
            ENDIF.
            IF lt_land1 IS NOT INITIAL.
              SELECT land1 kalsm FROM t005 INTO TABLE lt_kalsm FOR ALL ENTRIES IN lt_land1 WHERE land1 = lt_land1-land1.
            ENDIF.
            IF lt_kalsm IS NOT INITIAL.
              LOOP AT lt_mwskz INTO ls_mwskz.
                READ TABLE lt_bukrs INTO ls_bukrs WITH KEY ekorg = ls_mwskz-ekorg.
                IF sy-subrc IS INITIAL.
                  READ TABLE lt_land1 INTO ls_land1 WITH KEY bukrs = ls_bukrs-bukrs.
                  IF sy-subrc IS INITIAL.
                    READ TABLE lt_kalsm INTO ls_kalsm WITH KEY land1 = ls_land1-land1.
                    IF sy-subrc IS INITIAL.
                      ls_mwskz_check-matnr = ls_mwskz-matnr.
                      ls_mwskz_check-ekorg = ls_mwskz-ekorg.
                      ls_mwskz_check-kalsm = ls_kalsm-kalsm.
                      ls_mwskz_check-mwskz = ls_mwskz-mwskz.
                      APPEND ls_mwskz_check TO lt_mwskz_check.
                      CLEAR : ls_mwskz_check.
                    ENDIF.
                  ENDIF.
                ENDIF.
              ENDLOOP.
            ENDIF.

            REFRESH lt_mwskz_check_tmp.
            lt_mwskz_check_tmp = lt_mwskz_check.
            SORT lt_mwskz_check_tmp BY mwskz kalsm.
            DELETE ADJACENT DUPLICATES FROM lt_mwskz_check_tmp COMPARING mwskz kalsm.

            IF lt_mwskz_check_tmp IS NOT INITIAL.

              SELECT * FROM t007a INTO TABLE lt_t007a FOR ALL ENTRIES IN lt_mwskz_check_tmp WHERE mwskz = lt_mwskz_check_tmp-mwskz AND kalsm = lt_mwskz_check_tmp-kalsm.
              LOOP AT lt_mwskz_check INTO ls_mwskz_check.
                READ TABLE lt_t007a INTO ls_t007a WITH KEY mwskz = ls_mwskz_check-mwskz kalsm = ls_mwskz_check-kalsm.
                IF sy-subrc IS INITIAL.
                  IF ls_t007a-mwart <> 'V'.
                    CLEAR : ls_message.
                    MESSAGE ID lc_msg_cls TYPE 'E' NUMBER 019 WITH ls_mwskz_check-mwskz ls_mwskz_check-matnr INTO lv_message.
                    MOVE-CORRESPONDING sy TO ls_message.
                    ls_message-msgty = 'E'.
                    build_message(
                      EXPORTING
                        is_message = ls_message                 " Messages
                      CHANGING
                        ct_message = et_message                 " Messages
                    ).
                  ENDIF.
                ELSE.
                  CLEAR : ls_message.
                  MESSAGE ID lc_msg_cls TYPE 'E' NUMBER 020 WITH ls_mwskz_check-mwskz ls_mwskz_check-kalsm ls_mwskz_check-matnr INTO lv_message.
                  MOVE-CORRESPONDING sy TO ls_message.
                  ls_message-msgty = 'E'.
                  build_message(
                    EXPORTING
                      is_message = ls_message                 " Messages
                    CHANGING
                      ct_message = et_message                 " Messages
                  ).
                ENDIF.
              ENDLOOP.
            ENDIF.

          ENDIF.

        ENDIF.

        CHECK lt_sel IS NOT INITIAL.

        lt_lfm1_tmp = lt_lfm1.
        SORT lt_lfm1_tmp BY lifnr ekorg.
        DELETE ADJACENT DUPLICATES FROM lt_lfm1_tmp COMPARING lifnr ekorg.

        IF lt_lfm1_tmp IS NOT INITIAL.
          SELECT lifnr ekorg sperm loevm FROM lfm1
            INTO TABLE lt_lfm1_x
            FOR ALL ENTRIES IN lt_lfm1_tmp
            WHERE lifnr = lt_lfm1_tmp-lifnr AND ekorg = lt_lfm1_tmp-ekorg.
          IF lt_lfm1_x <> lt_lfm1_tmp.
            LOOP AT lt_lfm1 INTO ls_lfm1.
              READ TABLE lt_lfm1_x WITH KEY lifnr = ls_lfm1-lifnr ekorg = ls_lfm1-ekorg INTO DATA(ls_lfm1_x).
              IF sy-subrc <> 0.
                CLEAR : ls_message.
                MESSAGE ID lc_msg_cls TYPE 'E' NUMBER 021 WITH ls_lfm1-lifnr ls_lfm1-ekorg ls_lfm1-matnr INTO lv_message.
                MOVE-CORRESPONDING sy TO ls_message.
                ls_message-msgty = 'E'.
                build_message(
                  EXPORTING
                    is_message = ls_message                 " Messages
                  CHANGING
                    ct_message = et_message                 " Messages
                ).
              ELSE.
                IF ls_lfm1_x-sperm IS NOT INITIAL.
                  CLEAR : ls_message.
                  MESSAGE ID lc_msg_cls TYPE 'E' NUMBER 022 WITH ls_lfm1-lifnr ls_lfm1-ekorg ls_lfm1-matnr INTO lv_message.
                  MOVE-CORRESPONDING sy TO ls_message.
                  ls_message-msgty = 'E'.
                  build_message(
                    EXPORTING
                      is_message = ls_message                 " Messages
                    CHANGING
                      ct_message = et_message                 " Messages
                  ).
                ENDIF.

                IF ls_lfm1_x-loevm IS NOT INITIAL.
                  CLEAR : ls_message.
                  MESSAGE ID lc_msg_cls TYPE 'W' NUMBER 023 WITH ls_lfm1-lifnr ls_lfm1-ekorg ls_lfm1-matnr INTO lv_message.
                  MOVE-CORRESPONDING sy TO ls_message.
                  ls_message-msgty = 'W'.
                  build_message(
                    EXPORTING
                      is_message = ls_message                 " Messages
                    CHANGING
                      ct_message = et_message                 " Messages
                  ).
                ENDIF.
              ENDIF.
            ENDLOOP.
          ENDIF.
        ENDIF.
        "PIR should be created for POR data
        IF lt_lifnr IS NOT INITIAL.
          io_model->create_data_reference( EXPORTING i_fieldname = 'ZPURCHGEN' i_struct = 'KATTR' IMPORTING er_data = lr_data ).
          ASSIGN lr_data->* TO <ft_data1>.
          CHECK <ft_data1> IS ASSIGNED.
          io_model->read_char_value( EXPORTING i_fieldname = 'ZPURCHGEN' it_sel = lt_sel IMPORTING et_data = <ft_data1> ).
          UNASSIGN : <fs_value>, <fs_value1>, <fs_data>.
          IF <ft_data1> IS ASSIGNED AND <ft_data1> IS NOT INITIAL.
            LOOP AT lt_lifnr INTO ls_lifnr.
              CLEAR : lv_flag.
              LOOP AT <ft_data1> ASSIGNING <fs_data>.
                ASSIGN COMPONENT 'LIFNR' OF STRUCTURE <fs_data> TO <fs_value>.
                ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <fs_data> TO <fs_value1>.
                IF <fs_value> IS ASSIGNED AND <fs_value> IS NOT INITIAL
                  AND <fs_value1> IS ASSIGNED AND <fs_value1> IS NOT INITIAL.
                  IF ls_lifnr-matnr = <fs_value1> AND ls_lifnr-lifnr = <fs_value>.
                    lv_flag = abap_true.
                    EXIT.
                  ENDIF.
                ENDIF.
              ENDLOOP.
              IF lv_flag <> abap_true.
                CLEAR : ls_message.
                MESSAGE ID lc_msg_cls TYPE 'E' NUMBER 024 WITH ls_lifnr-lifnr ls_lifnr-matnr INTO lv_message.
                MOVE-CORRESPONDING sy TO ls_message.
                ls_message-msgty = 'E'.
                build_message(
                  EXPORTING
                    is_message = ls_message                 " Messages
                  CHANGING
                    ct_message = et_message                 " Messages
                ).
              ENDIF.
            ENDLOOP.
          ELSEIF <ft_data1> IS ASSIGNED AND <ft_data1> IS INITIAL.
            LOOP AT lt_lifnr INTO ls_lifnr.
              CLEAR : ls_message.
              MESSAGE ID lc_msg_cls TYPE 'E' NUMBER 024 WITH ls_lifnr-lifnr ls_lifnr-matnr INTO lv_message.
              MOVE-CORRESPONDING sy TO ls_message.
              ls_message-msgty = 'E'.
              build_message(
                EXPORTING
                  is_message = ls_message                 " Messages
                CHANGING
                  ct_message = et_message                 " Messages
              ).
            ENDLOOP.
          ENDIF.
        ENDIF.

        "Alternate UOM validations
        IF lt_meins IS NOT INITIAL.
          UNASSIGN : <ft_data1>, <fs_value>, <fs_value1>, <fs_value2>, <fs_data1>.
          io_model->create_data_reference( EXPORTING i_fieldname = 'UNITOFMSR' i_struct = 'KATTR' IMPORTING er_data = lr_data ).
          ASSIGN lr_data->* TO <ft_data1>.
          CHECK <ft_data1> IS ASSIGNED.
          io_model->read_char_value( EXPORTING i_fieldname = 'UNITOFMSR' it_sel = lt_sel IMPORTING et_data = <ft_data1> ).
          IF <ft_data1> IS ASSIGNED AND <ft_data1> IS NOT INITIAL.
            LOOP AT lt_meins INTO ls_meins.
              LOOP AT <ft_data1> ASSIGNING <fs_data1>.
                ASSIGN COMPONENT 'QTEUNIT' OF STRUCTURE <fs_data1> TO <fs_value>.
                ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <fs_data1> TO <fs_value1>.
                IF <fs_value> IS ASSIGNED AND <fs_value> IS NOT INITIAL
                  AND <fs_value1> IS ASSIGNED AND <fs_value1> IS NOT INITIAL.
                  IF ls_meins-matnr = <fs_value1> AND ls_meins-meins = <fs_value>.
                    lf_flag = abap_true.
                    EXIT.
                  ENDIF.
                ENDIF.
              ENDLOOP.
              IF lf_flag <> abap_true.
                CLEAR : ls_message.
                MESSAGE ID lc_msg_cls TYPE 'E' NUMBER 025 WITH ls_meins-meins ls_meins-matnr INTO lv_message.
                MOVE-CORRESPONDING sy TO ls_message.
                ls_message-msgty = 'E'.
                build_message(
                  EXPORTING
                    is_message = ls_message                 " Messages
                  CHANGING
                    ct_message = et_message                 " Messages
                ).
              ENDIF.
            ENDLOOP.
          ENDIF.
        ENDIF.

        IF lt_t024 IS NOT INITIAL.
          SELECT * FROM t024w
            INTO TABLE lt_t024w
            FOR ALL ENTRIES IN lt_t024
            WHERE werks = lt_t024-werks
            AND ekorg = lt_t024-ekorg.
          LOOP AT lt_t024 INTO ls_t024.
            READ TABLE lt_t024w WITH KEY werks = ls_t024-werks ekorg = ls_t024-ekorg TRANSPORTING NO FIELDS.
            IF sy-subrc IS NOT INITIAL.
              CLEAR : ls_message.
              MESSAGE ID lc_msg_cls TYPE 'E' NUMBER 042 WITH ls_t024-matnr ls_t024-ekorg ls_t024-werks INTO lv_message.
              MOVE-CORRESPONDING sy TO ls_message.
              ls_message-msgty = 'E'.
              build_message(
                EXPORTING
                  is_message = ls_message                 " Messages
                CHANGING
                  ct_message = et_message                 " Messages
              ).
            ENDIF.
          ENDLOOP.
        ENDIF.

      ENDIF.

      IF id_entitytype = 'PIR_COND'.
        LOOP AT <ft_data> ASSIGNING <fs_data>.
          ASSIGN COMPONENT 'DATAB' OF STRUCTURE <fs_data> TO <fs_datab>.
          ASSIGN COMPONENT 'DATBI_C' OF STRUCTURE <fs_data> TO <fs_datbi>.
          UNASSIGN <fs_value>.
          ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <fs_data> TO <fs_value>.
          IF sy-subrc IS INITIAL.
            CLEAR lv_material.
            lv_material = <fs_value>.
          ENDIF.
          IF <fs_datab> IS ASSIGNED AND <fs_datab> IS NOT INITIAL AND <fs_datbi> IS ASSIGNED AND <fs_datbi> IS NOT INITIAL.
            IF <fs_datab> > <fs_datbi>.
              CLEAR : ls_message.
              MESSAGE ID lc_msg_cls TYPE 'E' NUMBER 066 WITH <fs_datab> <fs_datbi> lv_material INTO lv_message.
              MOVE-CORRESPONDING sy TO ls_message.
              ls_message-msgty = 'E'.
              build_message(
                EXPORTING
                  is_message = ls_message                 " Messages
                CHANGING
                  ct_message = et_message                 " Messages
              ).
            ENDIF.
            EXIT.
          ENDIF.

          ASSIGN COMPONENT 'VALDT' OF STRUCTURE <fs_data> TO <fs_value>.
          ASSIGN COMPONENT 'VALTG' OF STRUCTURE <fs_data> TO <fs_value1>.
          IF  <fs_value> IS ASSIGNED AND <fs_value1> IS ASSIGNED.
            IF <fs_value> IS NOT INITIAL AND <fs_value1> IS NOT INITIAL.
              CLEAR : ls_message.
              MESSAGE ID lc_msg_cls TYPE 'E' NUMBER 065 WITH lv_material INTO lv_message.
              MOVE-CORRESPONDING sy TO ls_message.
              ls_message-msgty = 'E'.
              build_message(
                EXPORTING
                  is_message = ls_message                 " Messages
                CHANGING
                  ct_message = et_message                 " Messages
              ).
            ENDIF.
          ENDIF.
        ENDLOOP.

        IF <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          MOVE-CORRESPONDING <ft_data> TO lt_konp.
          SORT lt_konp BY datab DESCENDING.

          SELECT lifnr matnr ekorg werks esokz knumh datab datbi
            INTO TABLE lt_a017
            FROM a017
            FOR ALL ENTRIES IN lt_konp
            WHERE lifnr = lt_konp-lifnr
            AND matnr = lt_konp-material
            AND ekorg = lt_konp-ekorg
            AND werks = lt_konp-werks_c.
          IF sy-subrc IS INITIAL.
            SORT lt_a017 BY knumh.
          ENDIF.

          APPEND LINES OF lt_a017 TO lt_cond_tab.
          SELECT lifnr matnr ekorg esokz knumh datab datbi
           INTO TABLE lt_a018
           FROM a018
           FOR ALL ENTRIES IN lt_konp
           WHERE lifnr = lt_konp-lifnr
           AND matnr = lt_konp-material
           AND ekorg = lt_konp-ekorg.
          IF sy-subrc IS INITIAL.
            SORT lt_a018 BY knumh.
          ENDIF.

          LOOP AT lt_a018 INTO ls_a018.
            ls_cond_tab-matnr = ls_a018-matnr.
            ls_cond_tab-ekorg = ls_a018-ekorg.
            ls_cond_tab-esokz = ls_a018-esokz.
            ls_cond_tab-knumh = ls_a018-knumh.
            ls_cond_tab-lifnr = ls_a018-lifnr.
            ls_cond_tab-datab = ls_a018-datab.
            ls_cond_tab-datbi = ls_a018-datbi.
            APPEND ls_cond_tab TO lt_cond_tab.
            CLEAR ls_cond_tab.
          ENDLOOP.

          LOOP AT lt_konp INTO ls_konp.
            READ TABLE lt_cond_tab TRANSPORTING NO FIELDS WITH KEY matnr = ls_konp-material lifnr = ls_konp-lifnr
                                                                   ekorg = ls_konp-ekorg werks = ls_konp-werks_c
                                                                   datab = ls_konp-datab datbi = ls_konp-datbi_c.
            IF sy-subrc IS NOT INITIAL.
              APPEND ls_konp TO lt_konp_tmp.
              CLEAR ls_konp.
            ENDIF.
          ENDLOOP.

          LOOP AT lt_cond_tab INTO ls_cond_tab.
            LOOP AT lt_konp_tmp INTO ls_konp WHERE   material = ls_cond_tab-matnr
                                                 AND lifnr   = ls_cond_tab-lifnr
                                                 AND ekorg   = ls_cond_tab-ekorg
                                                 AND werks_c = ls_cond_tab-werks
                                                 AND esokz   = ls_cond_tab-esokz.
              IF ls_konp-datab < ls_cond_tab-datab AND ls_konp-datbi_c > ls_cond_tab-datbi.
                CLEAR : ls_message.
                MESSAGE ID lc_msg_cls TYPE 'E' NUMBER 067 WITH ls_konp-datab ls_konp-datbi_c ls_cond_tab-matnr INTO lv_message.
                MOVE-CORRESPONDING sy TO ls_message.
                ls_message-msgty = 'E'.
                build_message(
                  EXPORTING
                    is_message = ls_message                 " Messages
                  CHANGING
                    ct_message = et_message                 " Messages
                ).
                lv_exflag = abap_true.
                EXIT.
              ENDIF.
            ENDLOOP.
            IF lv_exflag EQ abap_true.
              EXIT.
            ENDIF.
          ENDLOOP.

          lt_konp_t1 = lt_konp_tmp.
          LOOP AT lt_konp_tmp INTO ls_konp.
            LOOP AT lt_konp_t1 INTO ls_konp_t WHERE material = ls_konp-material
                                              AND lifnr = ls_konp-lifnr
                                              AND ekorg = ls_konp-ekorg
                                              AND werks_c = ls_konp-werks_c
                                              AND esokz   = ls_konp-esokz.
              IF ls_konp_t-datab < ls_konp-datab AND ls_konp_t-datbi_c > ls_konp-datbi_c.
                CLEAR : ls_message.
                MESSAGE ID lc_msg_cls TYPE 'E' NUMBER 067 WITH ls_konp_t-datab ls_konp_t-datbi_c ls_konp-material INTO lv_message.
                MOVE-CORRESPONDING sy TO ls_message.
                ls_message-msgty = 'E'.
                build_message(
                  EXPORTING
                    is_message = ls_message                 " Messages
                  CHANGING
                    ct_message = et_message                 " Messages
                ).
                lv_exflag = abap_true.
                EXIT.
              ENDIF.
            ENDLOOP.
            IF lv_exflag EQ abap_true.
              EXIT.
            ENDIF.
          ENDLOOP.
        ENDIF.
      ENDIF.

      IF id_entitytype = 'ZPURCHGEN'.
        LOOP AT <ft_data> ASSIGNING <fs_data>.
          ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <fs_data> TO <fs_value>.
          CHECK <fs_value> IS NOT INITIAL.
          ls_sel-fieldname = 'MATERIAL'.
          ls_sel-sign = 'I'.
          ls_sel-option = 'EQ'.
          ls_sel-low = <fs_value>.
          CLEAR lv_material.
          lv_material = <fs_value>.

          READ TABLE lt_sel FROM ls_sel TRANSPORTING NO FIELDS.
          IF sy-subrc <> 0.
            INSERT ls_sel INTO TABLE lt_sel.

          ENDIF.
          CLEAR : ls_sel.
          ASSIGN COMPONENT 'MAHN1' OF STRUCTURE <fs_data> TO <fs_value1>.
          ASSIGN COMPONENT 'MAHN2' OF STRUCTURE <fs_data> TO <fs_value2>.
          ASSIGN COMPONENT 'MAHN3' OF STRUCTURE <fs_data> TO <fs_value3>.
          IF <fs_value1> IS ASSIGNED AND <fs_value1> IS NOT INITIAL
          AND <fs_value2> IS ASSIGNED AND <fs_value2> IS NOT INITIAL
          AND <fs_value3> IS ASSIGNED AND <fs_value3> IS NOT INITIAL.
            IF ( <fs_value2> LE <fs_value1> ) OR ( <fs_value3> LE <fs_value2> ) OR ( <fs_value3> LE <fs_value1> ).
              CLEAR : ls_message.
              MESSAGE ID lc_msg_cls TYPE 'E' NUMBER 019 WITH lv_material INTO lv_message.
              MOVE-CORRESPONDING sy TO ls_message.
              ls_message-msgty = 'E'.
              build_message(
                EXPORTING
                  is_message = ls_message                 " Messages
                CHANGING
                  ct_message = et_message                 " Messages
              ).
            ENDIF.
          ENDIF.
          ASSIGN COMPONENT 'MEINS_P' OF STRUCTURE <fs_data> TO <fs_meins>.
          IF <fs_meins> IS ASSIGNED AND <fs_meins> IS INITIAL.
            CLEAR : ls_message.
            MESSAGE ID lc_msg_cls TYPE 'E' NUMBER 020 WITH lv_material INTO lv_message.
            MOVE-CORRESPONDING sy TO ls_message.
            ls_message-msgty = 'E'.
            build_message(
              EXPORTING
                is_message = ls_message                 " Messages
              CHANGING
                ct_message = et_message                 " Messages
            ).
          ELSEIF <fs_meins> IS ASSIGNED AND <fs_meins> IS NOT INITIAL.
            ls_meins-matnr = <fs_value>.
            ls_meins-meins = <fs_meins>.
            APPEND ls_meins TO lt_meins.
            CLEAR : ls_meins.
          ENDIF.

          ASSIGN COMPONENT 'LIFNR' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_ven>).
          IF <fs_value> IS ASSIGNED AND <fs_value> IS NOT INITIAL
            AND <fs_ven> IS ASSIGNED AND <fs_ven> IS NOT INITIAL.
            ls_lifnr-matnr = <fs_value>.
            ls_lifnr-lifnr = <fs_ven>.
            APPEND ls_lifnr TO lt_lifnr.
            CLEAR : ls_lifnr.
          ENDIF.
*         Check if Vendor & Prior supplier are the same:
          ASSIGN COMPONENT 'KOLIF' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_kolif>).
          IF sy-subrc IS INITIAL.
            IF <fs_ven> = <fs_kolif>.
*             Throw error:
              CLEAR : ls_message.
              MESSAGE ID lc_msg_cls TYPE 'E' NUMBER 080 WITH lv_material <fs_ven> INTO lv_message.
              MOVE-CORRESPONDING sy TO ls_message.
              ls_message-msgty = 'E'.
              build_message(
                EXPORTING
                  is_message = ls_message                 " Messages
                CHANGING
                  ct_message = et_message                 " Messages
              ).
            ENDIF.
          ENDIF.
        ENDLOOP.


        IF lt_sel IS NOT INITIAL.
          UNASSIGN : <ft_data1>.
          io_model->create_data_reference( EXPORTING i_fieldname = 'MARCPURCH' i_struct = 'KATTR' IMPORTING er_data = lr_data1 ).
          ASSIGN lr_data1->* TO <ft_data1>.
          CHECK <ft_data1> IS ASSIGNED.
          io_model->read_char_value( EXPORTING i_fieldname = 'MARCPURCH' it_sel = lt_sel IMPORTING et_data = <ft_data1> ).

          IF <ft_data1> IS INITIAL.
            io_model->create_data_reference( EXPORTING i_fieldname = 'MARAPURCH' i_struct = 'KATTR' IMPORTING er_data = lr_data ).
            ASSIGN lr_data->* TO <ft_data1>.
            CHECK <ft_data1> IS ASSIGNED.
            io_model->read_char_value( EXPORTING i_fieldname = 'MARAPURCH' it_sel = lt_sel IMPORTING et_data = <ft_data1> ).
*        LOOP AT <ft_data1> ASSIGNING <fs_data1>.
            UNASSIGN :  <fs_value1>.
            IF <ft_data1> IS ASSIGNED AND <ft_data1> IS INITIAL.

              CLEAR : ls_message.
              MESSAGE ID lc_msg_cls TYPE 'E' NUMBER 018 INTO lv_message.
              MOVE-CORRESPONDING sy TO ls_message.
              ls_message-msgty = 'E'.
              build_message(
                EXPORTING
                  is_message = ls_message                 " Messages
                CHANGING
                  ct_message = et_message                 " Messages
              ).
            ENDIF.
            LOOP AT <ft_data1> ASSIGNING <fs_data1>.
              UNASSIGN <fs_value1>.
              ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <fs_data1> TO <fs_value1>.
              IF sy-subrc IS INITIAL.
                CLEAR lv_material.
                lv_material = <fs_value1>.
              ENDIF.
              UNASSIGN <fs_value1>.
              ASSIGN COMPONENT 'EKWSL' OF STRUCTURE <fs_data1> TO <fs_value1>.
              IF <fs_value1> IS ASSIGNED AND <fs_value1> IS INITIAL.

                CLEAR : ls_message.
                MESSAGE ID lc_msg_cls TYPE 'E' NUMBER 018 WITH lv_material INTO lv_message.
                MOVE-CORRESPONDING sy TO ls_message.
                ls_message-msgty = 'E'.
                build_message(
                  EXPORTING
                    is_message = ls_message                 " Messages
                  CHANGING
                    ct_message = et_message                 " Messages
                ).
              ENDIF.
            ENDLOOP.
          ELSE.
            LOOP AT <ft_data1> ASSIGNING <fs_data1>.
              ASSIGN COMPONENT 'EKGRP' OF STRUCTURE <fs_data1> TO <fs_value2>.
              IF <fs_value2> IS ASSIGNED AND <fs_value2> IS INITIAL.
                io_model->create_data_reference( EXPORTING i_fieldname = 'MARAPURCH' i_struct = 'KATTR' IMPORTING er_data = lr_data ).
                ASSIGN lr_data->* TO <ft_data2>.
                CHECK <ft_data2> IS ASSIGNED.
                io_model->read_char_value( EXPORTING i_fieldname = 'MARAPURCH' it_sel = lt_sel IMPORTING et_data = <ft_data2> ).
                IF <ft_data2> IS INITIAL.
                  CLEAR : ls_message.
                  MESSAGE ID lc_msg_cls TYPE 'E' NUMBER 025 INTO lv_message.
                  MOVE-CORRESPONDING sy TO ls_message.
                  ls_message-msgty = 'E'.
                  build_message(
                    EXPORTING
                      is_message = ls_message                 " Messages
                    CHANGING
                      ct_message = et_message                 " Messages
                  ).
                ELSE.
                  UNASSIGN : <fs_value1>.
                  LOOP AT <ft_data2> ASSIGNING FIELD-SYMBOL(<fs_data2>).
                    UNASSIGN <fs_value1>.
                    ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <fs_data1> TO <fs_value1>.
                    IF sy-subrc IS INITIAL.
                      CLEAR lv_material.
                      lv_material = <fs_value1>.
                    ENDIF.
                    UNASSIGN <fs_value1>.
                    ASSIGN COMPONENT 'EKWSL' OF STRUCTURE <fs_data2> TO <fs_value1>.
                    IF <fs_value1> IS ASSIGNED AND <fs_value1> IS INITIAL.

                      CLEAR : ls_message.
                      MESSAGE ID lc_msg_cls TYPE 'E' NUMBER 018 WITH lv_material INTO lv_message.
                      MOVE-CORRESPONDING sy TO ls_message.
                      ls_message-msgty = 'E'.
                      build_message(
                        EXPORTING
                          is_message = ls_message                 " Messages
                        CHANGING
                          ct_message = et_message                 " Messages
                      ).
                    ENDIF.
                  ENDLOOP.
                ENDIF.
              ENDIF.
            ENDLOOP.
          ENDIF.

*        ENDLOOP.
          IF lt_meins IS NOT INITIAL.
            UNASSIGN : <ft_data1>, <fs_value>, <fs_value1>, <fs_value2>, <fs_data1>.
            io_model->create_data_reference( EXPORTING i_fieldname = 'UNITOFMSR' i_struct = 'KATTR' IMPORTING er_data = lr_data ).
            ASSIGN lr_data->* TO <ft_data1>.
            CHECK <ft_data1> IS ASSIGNED.
            io_model->read_char_value( EXPORTING i_fieldname = 'UNITOFMSR' it_sel = lt_sel IMPORTING et_data = <ft_data1> ).
            IF <ft_data1> IS ASSIGNED AND <ft_data1> IS NOT INITIAL.
              LOOP AT lt_meins INTO ls_meins.
                LOOP AT <ft_data1> ASSIGNING <fs_data1>.
                  ASSIGN COMPONENT 'QTEUNIT' OF STRUCTURE <fs_data1> TO <fs_value>.
                  ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <fs_data1> TO <fs_value1>.
                  IF <fs_value> IS ASSIGNED AND <fs_value> IS NOT INITIAL
                    AND <fs_value1> IS ASSIGNED AND <fs_value1> IS NOT INITIAL.
                    IF ls_meins-matnr = <fs_value1> AND ls_meins-meins = <fs_value>.
                      lf_flag = abap_true.
                      EXIT.
                    ENDIF.
                  ENDIF.
                ENDLOOP.
                IF lf_flag <> abap_true.
                  CLEAR : ls_message.
                  MESSAGE ID lc_msg_cls TYPE 'E' NUMBER 030 WITH ls_meins-meins ls_meins-matnr INTO lv_message.
                  MOVE-CORRESPONDING sy TO ls_message.
                  ls_message-msgty = 'E'.
                  build_message(
                    EXPORTING
                      is_message = ls_message                 " Messages
                    CHANGING
                      ct_message = et_message                 " Messages
                  ).
                ENDIF.
              ENDLOOP.
            ENDIF.
          ENDIF.


          io_model->create_data_reference( EXPORTING i_fieldname = 'MATERIAL' i_struct = 'KATTR' IMPORTING er_data = lr_data2 ).
          ASSIGN lr_data2->* TO <ft_data3>.
          CHECK <ft_data3> IS ASSIGNED.
          UNASSIGN : <fs_value1>, <fs_value>, <fs_value2>.
          io_model->read_char_value( EXPORTING i_fieldname = 'MATERIAL' it_sel = lt_sel IMPORTING et_data = <ft_data3> ).
          LOOP AT <ft_data3> ASSIGNING <fs_data3>.
            ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <fs_data3> TO <fs_value>.
            ASSIGN COMPONENT 'MSTAE' OF STRUCTURE <fs_data3> TO <fs_value1>.
            ASSIGN COMPONENT 'MSTDE' OF STRUCTURE <fs_data3> TO <fs_value2>.
            IF <fs_value1> IS ASSIGNED AND <fs_value1> IS NOT INITIAL AND
              <fs_value2> IS ASSIGNED AND ( <fs_value2> IS INITIAL OR <fs_value2> LE sy-datlo ).
              ls_mmsta-matnr = <fs_value>.
              ls_mmsta-mmsta = <fs_value1>.
              ls_mmsta-mmstd = <fs_value2>.
              INSERT ls_mmsta INTO TABLE lt_mmsta.
              CLEAR : ls_mmsta.
            ENDIF.
          ENDLOOP.

          "Plant Spec Material status validation
          IF lt_mmsta IS NOT INITIAL.
            UNASSIGN : <fs_value1>, <fs_value>, <fs_value2>.
            SELECT * FROM t141 INTO TABLE lt_t141 FOR ALL ENTRIES IN lt_mmsta WHERE mmsta = lt_mmsta-mmsta.
            LOOP AT lt_t141 INTO ls_t141.
              CLEAR : lv_flag.
              CASE ls_t141-deink.
                WHEN 'B'.                 "error
                  LOOP AT lt_mmsta INTO ls_mmsta WHERE mmsta = ls_t141-mmsta.
                    LOOP AT <ft_data> ASSIGNING <fs_data>.
                      ASSIGN COMPONENT 'INFNR' OF STRUCTURE <fs_data> TO <fs_value>.
                      ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <fs_data> TO <fs_value1>.
                      IF sy-subrc IS INITIAL.
                        CLEAR lv_material.
                        lv_material = <fs_value1>.
                      ENDIF.
                      IF <fs_value1> IS ASSIGNED AND <fs_value1> = ls_mmsta-matnr.
                        IF <fs_value> IS ASSIGNED AND <fs_value> IS INITIAL AND ls_mmsta-werks IS INITIAL.
                          lv_flag = abap_true.
                          EXIT.
                        ENDIF.
                      ENDIF.
                    ENDLOOP.
                  ENDLOOP.

                  CHECK lv_flag IS NOT INITIAL.

                  CLEAR : ls_message.
                  MESSAGE ID lc_msg_cls TYPE 'E' NUMBER 054 WITH lv_material INTO lv_message.
                  MOVE-CORRESPONDING sy TO ls_message.
                  ls_message-msgty = 'E'.
                  build_message(
                    EXPORTING
                      is_message = ls_message                 " Messages
                    CHANGING
                      ct_message = et_message                 " Messages
                  ).
                WHEN 'A'.                 "warning
                  CLEAR : ls_message.
                  MESSAGE ID lc_msg_cls TYPE 'W' NUMBER 054 INTO lv_message.
                  MOVE-CORRESPONDING sy TO ls_message.
                  ls_message-msgty = 'W'.
                  build_message(
                    EXPORTING
                      is_message = ls_message                 " Messages
                    CHANGING
                      ct_message = et_message                 " Messages
                  ).
                WHEN OTHERS.
              ENDCASE.
            ENDLOOP.
          ENDIF.
          CLEAR : lv_flag.

          REFRESH lt_lifnr_tmp.
          lt_lifnr_tmp = lt_lifnr.
          SORT lt_lifnr_tmp BY lifnr.
          DELETE ADJACENT DUPLICATES FROM lt_lifnr_tmp COMPARING lifnr.

          IF lt_lifnr_tmp IS NOT INITIAL.
            SELECT lifnr loevm sperm FROM lfa1 INTO TABLE lt_del FOR ALL ENTRIES IN lt_lifnr_tmp WHERE lifnr = lt_lifnr_tmp-lifnr.
            IF sy-subrc IS INITIAL.
              LOOP AT lt_lifnr INTO ls_lifnr.
                CLEAR ls_del.
                READ TABLE lt_del INTO ls_del WITH KEY lifnr = ls_lifnr-lifnr.

                IF ls_del-sperm IS NOT INITIAL.
                  CLEAR : ls_message.
                  MESSAGE ID lc_msg_cls TYPE 'E' NUMBER 058 WITH ls_del-lifnr ls_lifnr-matnr INTO lv_message.
                  MOVE-CORRESPONDING sy TO ls_message.
                  ls_message-msgty = 'E'.
                  build_message(
                    EXPORTING
                      is_message = ls_message                 " Messages
                    CHANGING
                      ct_message = et_message                 " Messages
                  ).
                ENDIF.

                IF ls_del-loevm IS NOT INITIAL.
                  CLEAR : ls_message.
                  MESSAGE ID lc_msg_cls TYPE 'W' NUMBER 059 WITH ls_del-lifnr ls_lifnr-matnr INTO lv_message.
                  MOVE-CORRESPONDING sy TO ls_message.
                  ls_message-msgty = 'W'.

                 CALL METHOD me->build_message
                   EXPORTING
                     is_message = ls_message
                   changing
                     ct_message = et_message.


                ENDIF.

              ENDLOOP.

            ENDIF.
          ENDIF.
        ENDIF.
      ENDIF.


  endmethod.


  method IF_EX_USMD_RULE_SERVICE~CHECK_ENTITY_HIERARCHY.
  endmethod.


  method IF_EX_USMD_RULE_SERVICE~DERIVE_ENTITY.

    TYPES : BEGIN OF ty_ekwsl,
              matnr TYPE matnr,
              ekwsl TYPE ekwsl,
            END OF ty_ekwsl.
    TYPES : BEGIN OF ty_meins,
              matnr TYPE matnr,
              meins TYPE meins,
              field type string,
            END OF ty_meins.
    TYPES : BEGIN OF ty_ekgrp,
              werks TYPE werks_d,
              ekgrp TYPE ekgrp,
            END OF ty_ekgrp.
    TYPES : BEGIN OF ty_lifnr,
              lifnr TYPE elifn,
              ekorg TYPE ekorg,
            END OF ty_lifnr.
    TYPES : BEGIN OF ty_aplfz,
              lifnr   TYPE elifn,
              aplfz   TYPE plifz,
              waers   TYPE waers,
              ekgrp   TYPE ekgrp,
              ekorg   TYPE ekorg,
              inco1   TYPE inco1,
              webre   TYPE webre,
              incov   TYPE incov,
              inco2_l TYPE inco2_l,
              inco3_l TYPE inco3_l,
            END OF ty_aplfz.
    TYPES : BEGIN OF ty_pursal,
              lifnr   TYPE elifn,
              ekorg   TYPE ekorg,
              verkf   TYPE everk,
              telf1   TYPE telfe,
              inco1   TYPE inco1,
              webre   TYPE webre,
              incov   TYPE incov,
              inco2_l TYPE inco2_l,
              inco3_l TYPE inco3_l,
            END OF ty_pursal.
    TYPES: BEGIN OF ty_cond,
             matnr TYPE matnr,
             ekorg TYPE ekorg,
             lifnr TYPE lifnr,
             datab TYPE datab,
             datbi TYPE datbi,
             werks TYPE werks_d,
             konwa TYPE konwa,
             kpein TYPE kpein,
             kmein TYPE kmein,
             kbetr TYPE kbetr_kond,
           END OF ty_cond.
    DATA : lr_data      TYPE REF TO data,
           lr_data1     TYPE REF TO data,
           lr_data2     TYPE REF TO data,
           lr_data3     TYPE REF TO data,
           lr_cond_data TYPE REF TO data,
           lt_sel       TYPE usmd_ts_sel,
           ls_sel       LIKE LINE OF lt_sel,
           lt_aplfz     TYPE STANDARD TABLE OF ty_aplfz,
           ls_aplfz     TYPE ty_aplfz,
           lt_lifnr     TYPE STANDARD TABLE OF ty_lifnr,
           ls_lifnr     TYPE ty_lifnr,
           lt_ekgrp     TYPE STANDARD TABLE OF ty_ekgrp,
           ls_ekgrp     LIKE LINE OF lt_ekgrp,
           lt_ekwsl     TYPE STANDARD TABLE OF ty_ekwsl,
           ls_ekwsl     TYPE ty_ekwsl,
           lt_meins     TYPE STANDARD TABLE OF ty_meins,
           ls_meins     TYPE ty_meins,
           lt_v405      TYPE TABLE OF t405,
           ls_v405      LIKE LINE OF lt_v405,
           lt_pursal    TYPE STANDARD TABLE OF ty_pursal,
           ls_pursal    LIKE LINE OF lt_pursal,
           lf_flag      TYPE boolean,
           lt_cond      TYPE TABLE OF ty_cond,
           ls_cond      LIKE LINE OF lt_cond.
    CONSTANTS : lc_esokz TYPE esokz VALUE '0',
                lc_peinh TYPE epein VALUE '1'.
    FIELD-SYMBOLS : <ft_data>       TYPE ANY TABLE,
                    <ft_pcond_data> TYPE ANY TABLE,
                    <fs_pcond_data> TYPE any,
                    <fs_data>       TYPE any,
                    <fs_data_c>     TYPE any,
                    <fs_matnr_c>    TYPE any,
                    <fs_vend>       TYPE any,
                    <fs_werks>      TYPE any,
                    <fs_ekorg>      TYPE any,
                    <fs_netpr>      TYPE any,
                    <fs_esokz>      TYPE any,
                    <fs_vend_c>     TYPE any,
                    <fs_werks_c>    TYPE any,
                    <fs_ekorg_c>    TYPE any,
                    <fs_netpr_c>    TYPE any,
                    <fs_datbi_c>    TYPE any,
                    <fs_esokz_c>    TYPE any,
                    <ft_data1>      TYPE ANY TABLE,
                    <ft_data2>      TYPE ANY TABLE,
                    <ft_data3>      TYPE ANY TABLE,
                    <ft_data4>      TYPE ANY TABLE,
                    <fs_data1>      TYPE any,
                    <fs_data2>      TYPE any,
                    <fs_data3>      TYPE any,
                    <fs_data4>      TYPE any,
                    <fs_value>      TYPE any,
                    <fs_value1>     TYPE any,
                    <fs_value2>     TYPE any,
                    <fs_value3>     TYPE any,
                    <fs_matnr>      TYPE any,
                    <fs_matnr1>     TYPE any,
                    <fs_meins>      TYPE any,
                    <fs_meins_po>   TYPE any,
                    <fs_inf>        TYPE any..


      CLEAR : et_message.
      ASSIGN ct_data TO <ft_data>.
      CHECK <ft_data> IS ASSIGNED.
      io_model->get_changed_fields( IMPORTING et_entity_fieldname = DATA(lt_changed_entity) ).
      LOOP AT <ft_data> ASSIGNING <fs_data>.
        IF id_entitytype = 'ZPURCHGEN'.
          ASSIGN COMPONENT 'INFNR' OF STRUCTURE <fs_data> TO <fs_inf>.
        ELSEIF id_entitytype = 'ZPURCHINF'.
          ASSIGN COMPONENT 'INFNR_O' OF STRUCTURE <fs_data> TO <fs_inf>.
        ENDIF.

        IF <fs_inf> IS ASSIGNED AND <fs_inf> IS INITIAL.
          lf_flag = abap_true.
        ENDIF.
      ENDLOOP.
      IF lt_changed_entity IS INITIAL AND lf_flag = abap_false AND id_entitytype <> 'ZPIRCOND'.
        RETURN.
      ENDIF.
      IF id_entitytype = 'ZPURCHGEN'.
        LOOP AT <ft_data> ASSIGNING <fs_data>.
          ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <fs_data> TO <fs_value>.
          CHECK <fs_value> IS NOT INITIAL.
          ls_sel-fieldname = 'MATERIAL'.
          ls_sel-sign = 'I'.
          ls_sel-option = 'EQ'.
          ls_sel-low = <fs_value>.
          READ TABLE lt_sel FROM ls_sel TRANSPORTING NO FIELDS.
          IF sy-subrc <> 0.
            INSERT ls_sel INTO TABLE lt_sel.
          ENDIF.
          CLEAR : ls_sel.
        ENDLOOP.
        "Derive order UOM
        io_model->create_data_reference( EXPORTING i_fieldname = 'MATERIAL' i_struct = 'KATTR' IMPORTING er_data = lr_data2 ).
        ASSIGN lr_data2->* TO <ft_data3>.
        CHECK <ft_data3> IS ASSIGNED.
        CHECK lt_sel IS NOT INITIAL.
        io_model->read_char_value( EXPORTING i_fieldname = 'MATERIAL' it_sel = lt_sel IMPORTING et_data = <ft_data3> ).
        IF <ft_data3> IS NOT INITIAL.
          LOOP AT <ft_data3> ASSIGNING <fs_data3>.
            ASSIGN COMPONENT 'MEINS' OF STRUCTURE <fs_data3> TO FIELD-SYMBOL(<fs_meins1>).
            ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <fs_data3> TO FIELD-SYMBOL(<fs_mat2>).
            IF <fs_meins1> IS ASSIGNED AND <fs_meins1> IS NOT INITIAL
              AND <fs_mat2> IS ASSIGNED AND <fs_mat2> IS NOT INITIAL.
              ls_meins-matnr = <fs_mat2>.
              ls_meins-meins = <fs_meins1>.
              ls_meins-field = 'MEINS'.
              APPEND ls_meins TO lt_meins.
              CLEAR : ls_meins.
            ENDIF.
          ENDLOOP.
          "Derive order UOM from Purchasing order unit.
          io_model->create_data_reference( EXPORTING i_fieldname = 'MARAPURCH' i_struct = 'KATTR' IMPORTING er_data = lr_data3 ).
          ASSIGN lr_data3->* TO <ft_data4>.
          CHECK <ft_data4> IS ASSIGNED.
          io_model->read_char_value( EXPORTING i_fieldname = 'MARAPURCH' it_sel = lt_sel IMPORTING et_data = <ft_data4> ).
          IF <ft_data4> IS NOT INITIAL.
            LOOP AT <ft_data4> ASSIGNING <fs_data4>.
            ASSIGN COMPONENT 'BSTME' OF STRUCTURE <fs_data4> TO FIELD-SYMBOL(<fs_bstme>).
            ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <fs_data4> TO FIELD-SYMBOL(<fs_mat4>).
            IF <fs_bstme> IS ASSIGNED AND <fs_bstme> IS NOT INITIAL
              AND <fs_mat4> IS ASSIGNED AND <fs_mat4> IS NOT INITIAL.
              ls_meins-matnr = <fs_mat4>.
              ls_meins-meins = <fs_bstme>.
              ls_meins-field = 'BSTME'.
              APPEND ls_meins TO lt_meins.
              CLEAR : ls_meins.
            ENDIF.
            ENDLOOP.
          ENDIF.
          IF lt_meins IS NOT INITIAL.
            LOOP AT <ft_data> ASSIGNING <fs_data>.
              ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_mat3>).
              ASSIGN COMPONENT 'MEINS_P' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_mp>).
              IF <fs_mp> IS ASSIGNED AND <fs_mp> IS INITIAL.
                READ TABLE lt_meins INTO ls_meins WITH KEY matnr = <fs_mat3> field = 'BSTME'.
                IF SY-SUBRC = 0.
                    <fs_mp> = ls_meins-meins.
                ELSE.
                  READ TABLE lt_meins INTO ls_meins WITH KEY matnr = <fs_mat3> field = 'MEINS'.
                    IF ls_meins-meins IS NOT INITIAL.
                      <fs_mp> = ls_meins-meins.
                    ENDIF.
                 ENDIF.
                CLEAR : ls_meins.
              ENDIF.
            ENDLOOP.
          ENDIF.
        ENDIF.

        " Derive Conversion factors
        io_model->create_data_reference( EXPORTING i_fieldname = 'UNITOFMSR' i_struct = 'KATTR' IMPORTING er_data = lr_data ).
        ASSIGN lr_data->* TO <ft_data1>.
        CHECK <ft_data1> IS ASSIGNED.
        CHECK lt_sel IS NOT INITIAL.
        io_model->read_char_value( EXPORTING i_fieldname = 'UNITOFMSR' it_sel = lt_sel IMPORTING et_data = <ft_data1> ).
        IF <ft_data1> IS NOT INITIAL.
          LOOP AT <ft_data1> ASSIGNING <fs_data1>.
            ASSIGN COMPONENT 'UMREN' OF STRUCTURE <fs_data1> TO <fs_value>.
            ASSIGN COMPONENT 'UMREZ' OF STRUCTURE <fs_data1> TO <fs_value1>.
            ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <fs_data1> TO <fs_matnr>.
            ASSIGN COMPONENT 'QTEUNIT' OF STRUCTURE <fs_data1> TO <fs_meins>.
            LOOP AT <ft_data> ASSIGNING <fs_data>.
              ASSIGN COMPONENT 'UMREN_P' OF STRUCTURE <fs_data> TO <fs_value2>.
              ASSIGN COMPONENT 'UMREZ_P' OF STRUCTURE <fs_data> TO <fs_value3>.
              ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <fs_data> TO <fs_matnr1>.
              ASSIGN COMPONENT 'MEINS_P' OF STRUCTURE <fs_data> TO <fs_meins_po>.
              IF <fs_matnr> IS ASSIGNED AND <fs_matnr1> IS ASSIGNED
                AND <fs_meins> IS ASSIGNED AND <fs_meins_po> IS ASSIGNED
                AND <fs_value> IS  ASSIGNED AND <fs_value1> IS ASSIGNED
                AND <fs_value2> IS  ASSIGNED AND <fs_value3> IS ASSIGNED
                AND <fs_matnr1> = <fs_matnr> AND <fs_meins> = <fs_meins_po>
                AND <fs_value2> IS INITIAL AND <fs_value3> IS INITIAL.
                <fs_value2> = <fs_value>.
                <fs_value3> = <fs_value1>.
              ENDIF.
            ENDLOOP.
          ENDLOOP.
        ENDIF.
        "Derive Reminder Dates.
        io_model->create_data_reference( EXPORTING i_fieldname = 'MARAPURCH' i_struct = 'KATTR' IMPORTING er_data = lr_data1 ).
        ASSIGN lr_data1->* TO <ft_data2>.
        CHECK <ft_data2> IS ASSIGNED.
        CHECK lt_sel IS NOT INITIAL.
        io_model->read_char_value( EXPORTING i_fieldname = 'MARAPURCH' it_sel = lt_sel IMPORTING et_data = <ft_data2> ).
        IF <ft_data2> IS NOT INITIAL.
          LOOP AT <ft_data2> ASSIGNING <fs_data2>.
            ASSIGN COMPONENT 'EKWSL' OF STRUCTURE <fs_data2> TO FIELD-SYMBOL(<fs_ekwsl>).
            ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <fs_data2> TO FIELD-SYMBOL(<fs_mat>).
            IF <fs_mat> IS ASSIGNED AND <fs_mat> IS NOT INITIAL
              AND <fs_ekwsl> IS ASSIGNED AND <fs_ekwsl> IS NOT INITIAL.
              ls_ekwsl-matnr = <fs_mat>.
              ls_ekwsl-ekwsl = <fs_ekwsl>.
              APPEND ls_ekwsl TO lt_ekwsl.
              CLEAR : ls_ekwsl.
            ENDIF.
          ENDLOOP.
          IF lt_ekwsl IS NOT INITIAL.
            SELECT * FROM t405 INTO TABLE lt_v405 FOR ALL ENTRIES IN lt_ekwsl WHERE ekwsl = lt_ekwsl-ekwsl.
          ENDIF.
          IF lt_v405 IS NOT INITIAL.
            LOOP AT <ft_data> ASSIGNING <fs_data>.
              ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_mat1>).
              ASSIGN COMPONENT 'MAHN1' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_mahn1>).
              ASSIGN COMPONENT 'MAHN2' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_mahn2>).
              ASSIGN COMPONENT 'MAHN3' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_mahn3>).
              IF <fs_mahn1> IS ASSIGNED AND <fs_mahn2> IS ASSIGNED AND <fs_mahn3> IS ASSIGNED
                AND <fs_mahn1> IS INITIAL AND <fs_mahn2> IS INITIAL AND <fs_mahn3> IS INITIAL.
                READ TABLE lt_ekwsl INTO ls_ekwsl WITH KEY matnr = <fs_mat1>.
                IF ls_ekwsl IS NOT INITIAL.
                  READ TABLE lt_v405 INTO ls_v405 WITH KEY ekwsl = ls_ekwsl-ekwsl.
                  IF ls_v405 IS NOT INITIAL.
                    <fs_mahn1> = ls_v405-mahn1.
                    <fs_mahn2> = ls_v405-mahn2.
                    <fs_mahn3> = ls_v405-mahn3.
                  ENDIF.
                ENDIF.
              ENDIF.
              CLEAR : ls_ekwsl, ls_v405.
            ENDLOOP.
          ENDIF.

          "Derive Vendor Purchasing and sales data
          io_model->create_data_reference( EXPORTING i_fieldname = 'ZPURCHINF' i_struct = 'KATTR' IMPORTING er_data = lr_data2 ).
          ASSIGN lr_data2->* TO <ft_data3>.
          CHECK <ft_data3> IS ASSIGNED.
          CHECK lt_sel IS NOT INITIAL.
          io_model->read_char_value( EXPORTING i_fieldname = 'ZPURCHINF' it_sel = lt_sel IMPORTING et_data = <ft_data3> ).
          LOOP AT <ft_data3> ASSIGNING <fs_data3>.
            ASSIGN COMPONENT 'LIFNR' OF STRUCTURE <fs_data3> TO FIELD-SYMBOL(<fv_lifnr>).
            ASSIGN COMPONENT 'EKORG' OF STRUCTURE <fs_data3> TO FIELD-SYMBOL(<fv_ekorg>).
            IF <fv_lifnr> IS ASSIGNED AND <fv_lifnr> IS NOT INITIAL
              AND <fv_ekorg> IS ASSIGNED AND <fv_ekorg> IS NOT INITIAL.
              ls_lifnr-lifnr = <fv_lifnr>.
              ls_lifnr-ekorg = <fv_ekorg>.
              APPEND ls_lifnr TO lt_lifnr.
              CLEAR : ls_lifnr.
            ENDIF.
          ENDLOOP.
          IF lt_lifnr IS NOT INITIAL.
            SELECT lifnr ekorg verkf telf1 inco1 webre incov inco2_l inco3_l
              FROM lfm1
              INTO TABLE lt_pursal
              FOR ALL ENTRIES IN lt_lifnr
              WHERE lifnr = lt_lifnr-lifnr AND ekorg = lt_lifnr-ekorg.
          ENDIF.

          IF lt_pursal IS NOT INITIAL.
            SORT lt_pursal BY lifnr ekorg.
            DELETE lt_pursal WHERE verkf IS INITIAL AND telf1 IS INITIAL.
            LOOP AT <ft_data> ASSIGNING <fs_data>.
              ASSIGN COMPONENT 'LIFNR' OF STRUCTURE <fs_data> TO <fs_value1>.
              ASSIGN COMPONENT 'VERKF' OF STRUCTURE <fs_data> TO <fs_value2>.
              ASSIGN COMPONENT 'TELF1' OF STRUCTURE <fs_data> TO <fs_value3>.
              IF <fs_value1> IS ASSIGNED AND <fs_value1> IS NOT INITIAL.
                READ TABLE lt_pursal INTO ls_pursal WITH KEY lifnr = <fs_value1> .
                IF <fs_value2> IS ASSIGNED AND <fs_value2> IS INITIAL.
                  <fs_value2> = ls_pursal-verkf.
                ENDIF.
                IF <fs_value3> IS ASSIGNED AND <fs_value3> IS INITIAL.
                  <fs_value3> = ls_pursal-telf1.
                ENDIF.
              ENDIF.
            ENDLOOP.
          ENDIF.
        ENDIF.
      ENDIF.

      IF id_entitytype = 'ZPURCHINF'.
        LOOP AT <ft_data> ASSIGNING <fs_data>.
          ASSIGN COMPONENT 'PEINH_P' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_peinh>).
          IF <fs_peinh> IS ASSIGNED AND <fs_peinh> = '0'.
            <fs_peinh> = lc_peinh.
          ENDIF.
          ASSIGN COMPONENT 'BPUMN' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_bpumn>).
          IF <fs_bpumn> IS ASSIGNED AND <fs_bpumn> = '0'.
            <fs_bpumn> = lc_peinh.
          ENDIF.
          ASSIGN COMPONENT 'BPUMZ' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_bpumz>).
          IF <fs_bpumz> IS ASSIGNED AND <fs_bpumz> = '0'.
            <fs_bpumz> = lc_peinh.
          ENDIF.
          ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <fs_data> TO <fs_value>.
          CHECK <fs_value> IS NOT INITIAL.
          ls_sel-fieldname = 'MATERIAL'.
          ls_sel-sign = 'I'.
          ls_sel-option = 'EQ'.
          ls_sel-low = <fs_value>.
          READ TABLE lt_sel FROM ls_sel TRANSPORTING NO FIELDS.
          IF sy-subrc <> 0.
            INSERT ls_sel INTO TABLE lt_sel.
          ENDIF.
          CLEAR : ls_sel.

          ASSIGN COMPONENT 'LIFNR' OF STRUCTURE <fs_data> TO <fs_value2>.
          ASSIGN COMPONENT 'EKORG' OF STRUCTURE <fs_data> TO <fs_value3>.
          IF <fs_value2> IS ASSIGNED AND <fs_value2> IS NOT INITIAL
            AND <fs_value3> IS ASSIGNED AND <fs_value3> IS NOT INITIAL.
            ls_lifnr-lifnr = <fs_value2>.
            ls_lifnr-ekorg = <fs_value3>.
            APPEND ls_lifnr TO lt_lifnr.
            CLEAR : ls_lifnr.
          ENDIF.
        ENDLOOP.

        "Derive order price unit
        IF lt_sel IS NOT INITIAL.
          io_model->create_data_reference( EXPORTING i_fieldname = 'ZPURCHGEN' i_struct = 'KATTR' IMPORTING er_data = lr_data1 ).
          ASSIGN lr_data1->* TO <ft_data2>.
          CHECK <ft_data2> IS ASSIGNED.
          io_model->read_char_value( EXPORTING i_fieldname = 'ZPURCHGEN' it_sel = lt_sel IMPORTING et_data = <ft_data2> ).
          IF  <ft_data2> IS NOT INITIAL.
            LOOP AT <ft_data> ASSIGNING <fs_data>.
              ASSIGN COMPONENT 'LIFNR' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_lifnr_eina>).
              ASSIGN COMPONENT 'BPRME' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_bprme>).
          ASSIGN COMPONENT 'MEIN3' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_m3>).
          ASSIGN COMPONENT 'MEIN4' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_m4>).
              LOOP AT <ft_data2> ASSIGNING <fs_data2>.
                ASSIGN COMPONENT 'LIFNR' OF STRUCTURE <fs_data2> TO FIELD-SYMBOL(<fs_lifnr_eine>).
                ASSIGN COMPONENT 'MEINS_P' OF STRUCTURE <fs_data2> TO FIELD-SYMBOL(<fs_meins_p>).
                IF <fs_lifnr_eine> IS ASSIGNED AND <fs_lifnr_eine> IS NOT INITIAL
                  AND <fs_meins_p> IS ASSIGNED AND <fs_meins_p> IS NOT INITIAL
                  AND <fs_lifnr_eina> IS ASSIGNED AND <fs_lifnr_eina> IS NOT INITIAL
                  AND <fs_bprme> IS ASSIGNED AND <fs_bprme> IS INITIAL
                  AND <fs_lifnr_eina> = <fs_lifnr_eine>.
                  <fs_bprme> = <fs_meins_p>.
                  IF <fs_m3> IS ASSIGNED AND <fs_m3> IS INITIAL AND <fs_m4> IS ASSIGNED AND <fs_m4> IS INITIAL.
                       <fs_m3> = <fs_meins_p>.
                       <fs_m4> = <fs_meins_p>.
                  ENDIF.
                ENDIF.
              ENDLOOP.
            ENDLOOP.
          ENDIF.
          "Derive Purchasing group from Plant Purchasing if Plant is entered.
          io_model->create_data_reference( EXPORTING i_fieldname = 'MARCPURCH' i_struct = 'KATTR' IMPORTING er_data = lr_data2 ).
          ASSIGN lr_data2->* TO <ft_data3>.
          CHECK <ft_data3> IS ASSIGNED.
          io_model->read_char_value( EXPORTING i_fieldname = 'MARCPURCH' it_sel = lt_sel IMPORTING et_data = <ft_data3> ).
          IF <ft_data3> IS NOT INITIAL.
            LOOP AT <ft_data3> ASSIGNING <fs_data3>.
              ASSIGN COMPONENT 'WERKS' OF STRUCTURE <fs_data3> TO FIELD-SYMBOL(<fv_werks>).
              ASSIGN COMPONENT 'EKGRP' OF STRUCTURE <fs_data3> TO FIELD-SYMBOL(<fv_ekgrp>).
              IF <fv_werks> IS ASSIGNED AND <fv_werks> IS NOT INITIAL
                AND <fv_ekgrp> IS ASSIGNED AND <fv_ekgrp> IS NOT INITIAL.
                ls_ekgrp-werks = <fv_werks>.
                ls_ekgrp-ekgrp = <fv_ekgrp>.
                APPEND ls_ekgrp TO lt_ekgrp.
                CLEAR : ls_ekgrp.
              ENDIF.
            ENDLOOP.
          ENDIF.

          "Derive Purchasing group, Currency and Purchasing group.
          IF lt_lifnr IS NOT INITIAL.
            SELECT lifnr plifz waers ekgrp ekorg inco1 webre incov inco2_l inco3_l
               FROM lfm1 INTO TABLE lt_aplfz
               FOR ALL ENTRIES IN lt_lifnr
               WHERE lifnr = lt_lifnr-lifnr AND ekorg = lt_lifnr-ekorg.
            LOOP AT <ft_data> ASSIGNING <fs_data>.
              ASSIGN COMPONENT 'LIFNR' OF STRUCTURE <fs_data> TO <fs_value>.
              ASSIGN COMPONENT 'EKORG' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_value4>).
              ASSIGN COMPONENT 'APLFZ' OF STRUCTURE <fs_data> TO <fs_value1>.
              ASSIGN COMPONENT 'WAERS' OF STRUCTURE <fs_data> TO <fs_value2>.
              ASSIGN COMPONENT 'EKGRP_P' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_ekgrp>).
              ASSIGN COMPONENT 'INCOV' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_incov>).
              ASSIGN COMPONENT 'INCO1' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_inco1>).
              ASSIGN COMPONENT 'INCO2_L' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_inco2l>).
              ASSIGN COMPONENT 'INCO3_L' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_inco3l>).
              ASSIGN COMPONENT 'WEBRE' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_webre>).
              ASSIGN COMPONENT 'EKWRK' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_plant>).
              IF <fs_value> IS ASSIGNED AND <fs_value> IS NOT INITIAL AND <fs_value4> IS ASSIGNED AND <fs_value4> IS NOT INITIAL.
                READ TABLE lt_aplfz INTO ls_aplfz WITH KEY lifnr = <fs_value> ekorg = <fs_value4>.
                IF sy-subrc IS NOT INITIAL.
                  CONTINUE.
                ENDIF.
                IF <fs_value1> IS ASSIGNED AND <fs_value1> IS INITIAL.
                  <fs_value1> = ls_aplfz-aplfz.
                ENDIF.
                IF <fs_value2> IS ASSIGNED AND <fs_value2> IS INITIAL.
                  <fs_value2> = ls_aplfz-waers.
                ENDIF.
                IF <fs_ekgrp> IS ASSIGNED AND <fs_ekgrp> IS INITIAL
                  AND <fs_plant> IS ASSIGNED AND <fs_plant> IS NOT INITIAL.
                  READ TABLE lt_ekgrp WITH KEY werks = <fs_plant> INTO ls_ekgrp.
                  IF ls_ekgrp-ekgrp IS NOT INITIAL.
                    <fs_ekgrp> = ls_ekgrp-ekgrp.
                  ELSE.
                    <fs_ekgrp> = ls_aplfz-ekgrp.
                  ENDIF.
                ENDIF.
                IF <fs_incov> IS ASSIGNED AND <fs_incov> IS INITIAL.
                  <fs_incov> = ls_aplfz-incov.
                ENDIF.
                IF <fs_inco2l> IS ASSIGNED AND <fs_inco2l> IS INITIAL.
                  <fs_inco2l> = ls_aplfz-inco2_l.
                ENDIF.
                IF <fs_inco1> IS ASSIGNED AND <fs_inco1> IS INITIAL.
                  <fs_inco1> = ls_aplfz-inco1.
                ENDIF.
                IF <fs_inco3l> IS ASSIGNED AND <fs_inco3l> IS INITIAL.
                  <fs_inco3l> = ls_aplfz-inco3_l.
                ENDIF.
                IF <fs_webre> IS ASSIGNED AND <fs_webre> IS INITIAL.
                  <fs_webre> = ls_aplfz-webre.
                ENDIF.
              ENDIF.
            ENDLOOP.
          ENDIF.

          IF lt_ekgrp IS NOT INITIAL.
            LOOP AT <ft_data> ASSIGNING <fs_data>.
              ASSIGN COMPONENT 'EKWRK' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fv_wrk>).
              ASSIGN COMPONENT 'EKGRP_P' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fv_egrp>).
              ASSIGN COMPONENT 'LIFNR' OF STRUCTURE <fs_data> TO <fs_value>.
              ASSIGN COMPONENT 'EKORG_D' OF STRUCTURE <fs_data> TO <fs_value1>.
              IF <fv_wrk> IS ASSIGNED AND <fv_wrk> IS NOT INITIAL.
                READ TABLE lt_ekgrp WITH KEY werks = <fv_wrk> INTO ls_ekgrp.
                IF sy-subrc IS INITIAL.
                  IF <fv_egrp> IS ASSIGNED AND <fv_egrp> IS INITIAL AND ls_ekgrp-ekgrp IS NOT INITIAL.
                    <fv_egrp> = ls_ekgrp-ekgrp.

                  ELSEIF <fv_egrp> IS ASSIGNED AND <fv_egrp> IS INITIAL AND ls_ekgrp-ekgrp IS INITIAL
                      AND <fs_value> IS ASSIGNED AND <fs_value> IS NOT INITIAL
                      AND <fs_value1> IS ASSIGNED AND <fs_value1> IS NOT INITIAL.

                    READ TABLE lt_aplfz INTO ls_aplfz WITH KEY lifnr = <fs_value> ekorg = <fs_value1>.
                    IF ls_aplfz-ekgrp IS NOT INITIAL.
                      <fv_egrp> = ls_aplfz-ekgrp.
                    ENDIF.

                  ENDIF.
                ENDIF.
              ENDIF.
            ENDLOOP.
          ENDIF.
        ENDIF.
      ENDIF.

      IF id_entitytype = 'ZPIRCOND'.

        LOOP AT <ft_data> ASSIGNING <fs_data>.
          ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <fs_data> TO <fs_value>.
          CHECK <fs_value> IS NOT INITIAL.
          ls_sel-fieldname = 'MATERIAL'.
          ls_sel-sign = 'I'.
          ls_sel-option = 'EQ'.
          ls_sel-low = <fs_value>.
          READ TABLE lt_sel FROM ls_sel TRANSPORTING NO FIELDS.
          IF sy-subrc <> 0.
            INSERT ls_sel INTO TABLE lt_sel.
          ENDIF.
          CLEAR : ls_sel.
        ENDLOOP.
        IF lt_sel IS NOT INITIAL.
          io_model->create_data_reference( EXPORTING i_fieldname = 'ZPURCHINF' i_struct = 'KATTR' IMPORTING er_data = lr_data2 ).
          ASSIGN lr_data2->* TO <ft_data3>.
          CHECK <ft_data3> IS ASSIGNED.
          io_model->read_char_value( EXPORTING i_fieldname = 'ZPURCHINF' it_sel = lt_sel IMPORTING et_data = <ft_data3> ).
          LOOP AT <ft_data3> ASSIGNING <fs_data3>.
            ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <fs_data3> TO FIELD-SYMBOL(<fs_mat_c>).
            ASSIGN COMPONENT 'LIFNR' OF STRUCTURE <fs_data3> TO FIELD-SYMBOL(<fs_lifnr_c>).
            ASSIGN COMPONENT 'EKORG' OF STRUCTURE <fs_data3> TO <fs_ekorg_c>.
            ASSIGN COMPONENT 'EKWRK' OF STRUCTURE <fs_data3> TO FIELD-SYMBOL(<fs_ekwrk_c>).
            ASSIGN COMPONENT 'PEINH_P' OF STRUCTURE <fs_data3> TO FIELD-SYMBOL(<fs_peinh_c>).
            ASSIGN COMPONENT 'WAERS' OF STRUCTURE <fs_data3> TO FIELD-SYMBOL(<fs_waers_c>).
            ASSIGN COMPONENT 'BPRME' OF STRUCTURE <fs_data3> TO FIELD-SYMBOL(<fs_bprme_c>).
            ASSIGN COMPONENT 'NETPR' OF STRUCTURE <fs_data3> TO <fs_netpr_c>.

            IF <fs_mat_c> IS ASSIGNED AND <fs_mat_c> IS NOT INITIAL
              AND <fs_lifnr_c> IS ASSIGNED AND <fs_lifnr_c> IS NOT INITIAL
              AND <fs_ekorg_c> IS ASSIGNED AND <fs_ekorg_c> IS NOT INITIAL
              AND <fs_ekwrk_c> IS ASSIGNED
              AND <fs_peinh_c> IS ASSIGNED AND <fs_waers_c> IS ASSIGNED
              AND <fs_bprme_c> IS ASSIGNED AND <fs_netpr_c> IS ASSIGNED.

              ls_cond-matnr = <fs_mat_c>.
              ls_cond-lifnr = <fs_lifnr_c>.
              ls_cond-werks = <fs_ekwrk_c>.
              ls_cond-ekorg = <fs_ekorg_c>.
              ls_cond-kbetr = <fs_netpr_c>.
              ls_cond-konwa = <fs_waers_c>.
              ls_cond-kpein = <fs_peinh_c>.
              ls_cond-kmein = <fs_bprme_c>.
              ls_cond-datab = sy-datlo.
              ls_cond-datbi = '99991231'.
              APPEND ls_cond TO lt_cond.
              CLEAR : ls_cond.
            ENDIF.
          ENDLOOP.

          LOOP AT <ft_data> ASSIGNING <fs_data>.
            ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <fs_data> TO <fs_value>.
            ASSIGN COMPONENT 'EKORG' OF STRUCTURE <fs_data> TO <fs_value1>.
            ASSIGN COMPONENT 'LIFNR' OF STRUCTURE <fs_data> TO <fs_value2>.
            ASSIGN COMPONENT 'EKWRK' OF STRUCTURE <fs_data> TO <fs_value3>.
            ASSIGN COMPONENT 'DATBI' OF STRUCTURE <fs_data> TO <fs_datbi_c>.
            IF <fs_value> IS ASSIGNED AND <fs_value> IS NOT INITIAL
              AND <fs_value1> IS ASSIGNED AND <fs_value1> IS NOT INITIAL
              AND <fs_value2> IS ASSIGNED AND <fs_value2> IS NOT INITIAL
              AND <fs_value3> IS ASSIGNED.

              READ TABLE lt_cond INTO ls_cond WITH KEY matnr = <fs_value> ekorg = <fs_value1> lifnr = <fs_value2> werks = <fs_value3>.
              IF sy-subrc IS INITIAL.
                ASSIGN COMPONENT 'DATAB' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_datab>).
                IF <fs_datab> IS ASSIGNED AND <fs_datab> IS INITIAL.
                  <fs_datab> = ls_cond-datab.
                ENDIF.
                ASSIGN COMPONENT 'KBETR' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_kbetr>).
                IF <fs_kbetr> IS ASSIGNED AND <fs_kbetr> IS INITIAL.
                  <fs_kbetr> = ls_cond-kbetr.
                ENDIF.
                ASSIGN COMPONENT 'KMEIN' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_kmein>).
                IF <fs_kmein> IS ASSIGNED AND <fs_kmein> IS INITIAL.
                  <fs_kmein> = ls_cond-kmein.
                ENDIF.
                ASSIGN COMPONENT 'KPEIN' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_kpein>).
                IF <fs_kpein> IS ASSIGNED AND <fs_kpein> IS INITIAL.
                  <fs_kpein> = ls_cond-kpein.
                ENDIF.
                ASSIGN COMPONENT 'KRECH' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_krech>).
                IF <fs_krech> IS ASSIGNED AND <fs_krech> IS INITIAL.
                  <fs_krech> = 'C'.
                ENDIF.
                ASSIGN COMPONENT 'KONWA' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_konwa>).
                IF <fs_konwa> IS ASSIGNED AND <fs_konwa> IS INITIAL.
                  <fs_konwa> = ls_cond-konwa.
                ENDIF.
              ENDIF.
            ENDIF.
          ENDLOOP.
        ENDIF.
      ENDIF.


  endmethod.
ENDCLASS.
