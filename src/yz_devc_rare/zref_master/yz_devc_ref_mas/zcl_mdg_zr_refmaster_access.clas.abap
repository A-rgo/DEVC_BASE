class ZCL_MDG_ZR_REFMASTER_ACCESS definition
  public
  final
  create public .

public section.

  interfaces IF_USMD_PP_ACCESS .
  interfaces IF_USMD_PP_BLOCKLIST .
  interfaces IF_USMD_PP_HANA_SEARCH .
protected section.
private section.
ENDCLASS.



CLASS ZCL_MDG_ZR_REFMASTER_ACCESS IMPLEMENTATION.


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

    DATA:lr_data         TYPE REF TO data,
         lt_sel_zmain    TYPE RANGE OF kotabnr,
         ls_sel_zmain    LIKE LINE OF lt_sel_zmain,
         lt_sel_zobj_cls TYPE RANGE OF kschl,
         ls_sel_zobj_cls LIKE LINE OF lt_sel_zobj_cls.
    FIELD-SYMBOLS: <fs_data>     TYPE any.

* Initialize output
    CLEAR:
      et_data,
      et_message.

*    SELECT sign,option,low,high FROM @it_sel AS lt_sel WHERE fieldname = 'ZOBJ_CLS' INTO
*                                                                  TABLE @DATA(lrt_sel_zobj_cls) .

*    APPEND VALUE #( sign = 'I' option = 'EQ' low = 'PR00' ) to lt_sel_zobj_cls.

    LOOP AT it_sel ASSIGNING FIELD-SYMBOL(<fs_sel>) WHERE fieldname = 'ZMAIN'.
      DATA(lv_zmain) = <fs_sel>-low+1(4).
      DATA(lv_tabname) = <fs_sel>-low.
      ls_sel_zmain-sign = 'I'.
      ls_sel_zmain-option = 'EQ'.
      ls_sel_zmain-low = lv_zmain.
      APPEND ls_sel_zmain TO lt_sel_zmain.
    ENDLOOP.


    LOOP AT it_sel ASSIGNING <fs_sel> WHERE fieldname = 'ZOBJ_CLS'.
*      DATA(lv_zmain) = <fs_sel>-low+1(4).
      ls_sel_zobj_cls-sign = 'I'.
      ls_sel_zobj_cls-option = 'EQ'.
      ls_sel_zobj_cls-low = 'PR00'.
      APPEND ls_sel_zobj_cls TO lt_sel_zobj_cls.


    ENDLOOP.
    IF ( lt_sel_zobj_cls IS INITIAL AND lt_sel_zmain IS INITIAL AND it_sel IS NOT INITIAL ).
      "no supported search attribute
      RETURN.
    ENDIF.

    "Replace table KONH with view name
    DATA(lv_knumh) = '0000013025'.   """KNUMH no. , we will get it from UI which needs to be passed here
    SELECT  kh~knumh, kh~kschl, kp~kmein, kh~kotabnr, kp~kbetr, kp~kpein, kp~loevm_ko, kp~kstbm, kp~konwa FROM konp AS kp
         INNER JOIN konh AS kh ON kp~knumh = kh~knumh AND kotabnr = @ls_sel_zmain-low AND kh~kschl = @ls_sel_zobj_cls-low
         AND kh~knumh = @lv_knumh INTO TABLE @DATA(lt_searched_data).

    DATA: lt_a305 TYPE STANDARD TABLE OF a305.
    IF lv_tabname = 'A304'.
      SELECT * FROM a304 INTO CORRESPONDING FIELDS OF TABLE lt_a305 WHERE knumh = lv_knumh.
    ELSEIF lv_tabname = 'A305'.
      SELECT * FROM a305 INTO TABLE lt_a305 WHERE knumh = lv_knumh.
    ENDIF.

    CASE i_entity.
      WHEN 'ZMAIN'.
        """Create local data structure
        CREATE DATA lr_data LIKE LINE OF et_data.
        ASSIGN lr_data->* TO <fs_data>.
        ASSIGN COMPONENT 'ZMAIN' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<lv_zmain>).     "ZMAIN is our access table
        ASSIGN COMPONENT 'ZOBJ_CLS' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<lv_zobj_cls>). "ZOBJ_CLS is our condition type

        """Convert data from DB format into MDG format
        LOOP AT lt_searched_data ASSIGNING FIELD-SYMBOL(<fs_searched_data>).
          ASSIGN COMPONENT 'ZMAIN' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_zmain>).
          IF <fs_zmain> IS ASSIGNED.
            CONCATENATE 'A' <fs_searched_data>-kotabnr INTO DATA(lv_acctab).
            <fs_zmain> = lv_tabname.
          ENDIF.
          ASSIGN COMPONENT 'ZOBJ_CLS' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_zobj_cls>).
          IF <fs_zobj_cls> IS ASSIGNED.
            <fs_zobj_cls> = <fs_searched_data>-kschl.
          ENDIF.
          ASSIGN COMPONENT 'LANGU' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_langu>).
          IF <fs_langu> IS ASSIGNED.
            <fs_langu> = 'E'.
          ENDIF.
          INSERT <fs_data> INTO TABLE et_data.
        ENDLOOP.

      WHEN 'ZVALUE'.
        CHECK sy-uname = 'RAJGOPAL'.

        DATA: lv_cond_type TYPE zde_ref_master_obj_class,
              ls_elemdesc  TYPE rsddtel.

        CLEAR: lr_data.

        CREATE DATA lr_data LIKE LINE OF et_data.
        ASSIGN lr_data->* TO <fs_data>.

        """Convert data from DB format into MDG format
        LOOP AT lt_searched_data ASSIGNING <fs_searched_data>.
          ASSIGN COMPONENT 'ZOBJ_CLS' OF STRUCTURE <fs_data> TO <fs_zobj_cls>.
          ASSIGN COMPONENT 'ZMAIN' OF STRUCTURE <fs_data> TO <fs_zmain>.


          ASSIGN COMPONENT 'ZFIELD' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_field>).
          ASSIGN COMPONENT 'ZFLD_VAL' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_fvalue>).
          ASSIGN COMPONENT 'ZFLD_DESC' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_fdesc>).

          IF <fs_zobj_cls> IS ASSIGNED AND <fs_zmain> IS ASSIGNED AND <fs_field> IS ASSIGNED AND <fs_fvalue> IS ASSIGNED AND <fs_fdesc> IS ASSIGNED.
            <fs_zobj_cls> = <fs_searched_data>-kschl.
            <fs_zmain> = lv_tabname.

            CLEAR: <fs_field>, <fs_fvalue>, <fs_fdesc>, ls_elemdesc.
            <fs_field> = 'KNUMH'.
            CALL FUNCTION 'RSD_DTEL_GET'
              EXPORTING
                i_dtelnm = <fs_field>
*               I_BYPASS_BUFFER       = RS_C_FALSE
              IMPORTING
                e_s_dtel = ls_elemdesc.

            <fs_fdesc> = ls_elemdesc-txtmd.
            <fs_fvalue> = lv_knumh.
            SHIFT <fs_fvalue> LEFT DELETING LEADING space.
            INSERT <fs_data> INTO TABLE et_data.

            CLEAR: <fs_field>, <fs_fvalue>,<fs_fdesc>, ls_elemdesc.
            <fs_field> = 'KBETR'.
            CALL FUNCTION 'RSD_DTEL_GET'
              EXPORTING
                i_dtelnm = <fs_field>
*               I_BYPASS_BUFFER       = RS_C_FALSE
              IMPORTING
                e_s_dtel = ls_elemdesc.

            <fs_fdesc> = ls_elemdesc-txtmd.
            <fs_fvalue> = <fs_searched_data>-kbetr.
            SHIFT <fs_fvalue> LEFT DELETING LEADING space.
            INSERT <fs_data> INTO TABLE et_data.

            CLEAR: <fs_field>, <fs_fvalue>,<fs_fdesc>, ls_elemdesc.
            <fs_field> = 'KPEIN'.
            CALL FUNCTION 'RSD_DTEL_GET'
              EXPORTING
                i_dtelnm = <fs_field>
*               I_BYPASS_BUFFER       = RS_C_FALSE
              IMPORTING
                e_s_dtel = ls_elemdesc.

            <fs_fdesc> = ls_elemdesc-txtmd.
            <fs_fvalue> = <fs_searched_data>-kpein.
            SHIFT <fs_fvalue> LEFT DELETING LEADING space.
            INSERT <fs_data> INTO TABLE et_data.

            CLEAR: <fs_field>, <fs_fvalue>, <fs_fdesc>,  ls_elemdesc.
            <fs_field> = 'LOEVM_KO'.
            CALL FUNCTION 'RSD_DTEL_GET'
              EXPORTING
                i_dtelnm = <fs_field>
*               I_BYPASS_BUFFER       = RS_C_FALSE
              IMPORTING
                e_s_dtel = ls_elemdesc.

            <fs_fdesc> = ls_elemdesc-txtmd.
            <fs_fvalue> = <fs_searched_data>-loevm_ko.
            SHIFT <fs_fvalue> LEFT DELETING LEADING space.
            INSERT <fs_data> INTO TABLE et_data.

            CLEAR: <fs_field>, <fs_fvalue>, <fs_fdesc>, ls_elemdesc.
            <fs_field> = 'KSTBM'.
            CALL FUNCTION 'RSD_DTEL_GET'
              EXPORTING
                i_dtelnm = <fs_field>
*               I_BYPASS_BUFFER       = RS_C_FALSE
              IMPORTING
                e_s_dtel = ls_elemdesc.

            <fs_fdesc> = ls_elemdesc-txtmd.
            <fs_fvalue> = <fs_searched_data>-kstbm.
            SHIFT <fs_fvalue> LEFT DELETING LEADING space.
            INSERT <fs_data> INTO TABLE et_data.

            CLEAR: <fs_field>, <fs_fvalue>, <fs_fdesc>, ls_elemdesc.
            <fs_field> = 'KONWA'.
            CALL FUNCTION 'RSD_DTEL_GET'
              EXPORTING
                i_dtelnm = <fs_field>
*               I_BYPASS_BUFFER       = RS_C_FALSE
              IMPORTING
                e_s_dtel = ls_elemdesc.

            <fs_fdesc> = ls_elemdesc-txtmd.
            <fs_fvalue> = <fs_searched_data>-konwa.
            SHIFT <fs_fvalue> LEFT DELETING LEADING space.
            INSERT <fs_data> INTO TABLE et_data.

            CLEAR: <fs_field>, <fs_fvalue>, <fs_fdesc>, ls_elemdesc.
            <fs_field> = 'KMEIN'.
            CALL FUNCTION 'RSD_DTEL_GET'
              EXPORTING
                i_dtelnm = <fs_field>
*               I_BYPASS_BUFFER       = RS_C_FALSE
              IMPORTING
                e_s_dtel = ls_elemdesc.

            <fs_fdesc> = ls_elemdesc-txtmd.
            <fs_fvalue> = <fs_searched_data>-kmein.
            SHIFT <fs_fvalue> LEFT DELETING LEADING space.
            INSERT <fs_data> INTO TABLE et_data.

            READ TABLE lt_a305 ASSIGNING FIELD-SYMBOL(<fs_a305>) WITH KEY knumh = lv_knumh.
            IF sy-subrc = 0.
              CLEAR: <fs_field>, <fs_fvalue>, <fs_fdesc>, ls_elemdesc.
              <fs_field> = 'KFRST'.
              CALL FUNCTION 'RSD_DTEL_GET'
                EXPORTING
                  i_dtelnm = <fs_field>
*                 I_BYPASS_BUFFER       = RS_C_FALSE
                IMPORTING
                  e_s_dtel = ls_elemdesc.

              <fs_fdesc> = ls_elemdesc-txtmd.
              <fs_fvalue> = <fs_a305>-kfrst.
              SHIFT <fs_fvalue> LEFT DELETING LEADING space.
              INSERT <fs_data> INTO TABLE et_data.

              CLEAR: <fs_field>, <fs_fvalue>, <fs_fdesc>, ls_elemdesc.
              <fs_field> = 'KAPPL'.
              CALL FUNCTION 'RSD_DTEL_GET'
                EXPORTING
                  i_dtelnm = <fs_field>
*                 I_BYPASS_BUFFER       = RS_C_FALSE
                IMPORTING
                  e_s_dtel = ls_elemdesc.

              <fs_fdesc> = ls_elemdesc-txtmd.
              <fs_fvalue> = <fs_a305>-kappl.
              SHIFT <fs_fvalue> LEFT DELETING LEADING space.
              INSERT <fs_data> INTO TABLE et_data.

              CLEAR: <fs_field>, <fs_fvalue>, <fs_fdesc>, ls_elemdesc.
              <fs_field> = 'KSCHL'.
              CALL FUNCTION 'RSD_DTEL_GET'
                EXPORTING
                  i_dtelnm = <fs_field>
*                 I_BYPASS_BUFFER       = RS_C_FALSE
                IMPORTING
                  e_s_dtel = ls_elemdesc.

              <fs_fdesc> = ls_elemdesc-txtmd.
              <fs_fvalue> = <fs_a305>-kschl.
              SHIFT <fs_fvalue> LEFT DELETING LEADING space.
              INSERT <fs_data> INTO TABLE et_data.

              CLEAR: <fs_field>, <fs_fvalue>, <fs_fdesc>, ls_elemdesc.
              <fs_field> = 'VKORG'.
              CALL FUNCTION 'RSD_DTEL_GET'
                EXPORTING
                  i_dtelnm = <fs_field>
*                 I_BYPASS_BUFFER       = RS_C_FALSE
                IMPORTING
                  e_s_dtel = ls_elemdesc.

              <fs_fdesc> = ls_elemdesc-txtmd.
              <fs_fvalue> = <fs_a305>-vkorg.
              SHIFT <fs_fvalue> LEFT DELETING LEADING space.
              INSERT <fs_data> INTO TABLE et_data.

              CLEAR: <fs_field>, <fs_fvalue>, <fs_fdesc>, ls_elemdesc.
              <fs_field> = 'VTWEG'.
              CALL FUNCTION 'RSD_DTEL_GET'
                EXPORTING
                  i_dtelnm = <fs_field>
*                 I_BYPASS_BUFFER       = RS_C_FALSE
                IMPORTING
                  e_s_dtel = ls_elemdesc.

              <fs_fdesc> = ls_elemdesc-txtmd.
              <fs_fvalue> = <fs_a305>-vtweg.
              SHIFT <fs_fvalue> LEFT DELETING LEADING space.
              INSERT <fs_data> INTO TABLE et_data.

              CLEAR: <fs_field>, <fs_fvalue>, <fs_fdesc>, ls_elemdesc.
              <fs_field> = 'MATNR'.
              CALL FUNCTION 'RSD_DTEL_GET'
                EXPORTING
                  i_dtelnm = <fs_field>
*                 I_BYPASS_BUFFER       = RS_C_FALSE
                IMPORTING
                  e_s_dtel = ls_elemdesc.


              <fs_fdesc> = ls_elemdesc-txtmd.
              <fs_fvalue> = <fs_a305>-matnr.
              SHIFT <fs_fvalue> LEFT DELETING LEADING space.
              INSERT <fs_data> INTO TABLE et_data.

              IF lv_tabname = 'A305'.
                CLEAR: <fs_field>, <fs_fvalue>, <fs_fdesc>, ls_elemdesc.
                <fs_field> = 'KUNNR'.
                CALL FUNCTION 'RSD_DTEL_GET'
                  EXPORTING
                    i_dtelnm = <fs_field>
*                   I_BYPASS_BUFFER       = RS_C_FALSE
                  IMPORTING
                    e_s_dtel = ls_elemdesc.

                <fs_fdesc> = ls_elemdesc-txtmd.
                <fs_fvalue> = <fs_a305>-kunnr.
                SHIFT <fs_fvalue> LEFT DELETING LEADING space.
                INSERT <fs_data> INTO TABLE et_data.
              ENDIF.

              CLEAR: <fs_field>, <fs_fvalue>, <fs_fdesc>, ls_elemdesc.
              <fs_field> = 'KBSTAT'.
              CALL FUNCTION 'RSD_DTEL_GET'
                EXPORTING
                  i_dtelnm = <fs_field>
*                 I_BYPASS_BUFFER       = RS_C_FALSE
                IMPORTING
                  e_s_dtel = ls_elemdesc.

              <fs_fdesc> = ls_elemdesc-txtmd.
              <fs_fvalue> = <fs_a305>-kbstat.
              SHIFT <fs_fvalue> LEFT DELETING LEADING space.
              INSERT <fs_data> INTO TABLE et_data.

              CLEAR: <fs_field>, <fs_fvalue>, <fs_fdesc>, ls_elemdesc.
              <fs_field> = 'DATAB'.
              CALL FUNCTION 'RSD_DTEL_GET'
                EXPORTING
                  i_dtelnm = <fs_field>
*                 I_BYPASS_BUFFER       = RS_C_FALSE
                IMPORTING
                  e_s_dtel = ls_elemdesc.

              <fs_fdesc> = ls_elemdesc-txtmd.
              <fs_fvalue> = <fs_a305>-datab.
              SHIFT <fs_fvalue> LEFT DELETING LEADING space.
              INSERT <fs_data> INTO TABLE et_data.

              CLEAR: <fs_field>, <fs_fvalue>, <fs_fdesc>, ls_elemdesc.
              <fs_field> = 'DATBI'.
              CALL FUNCTION 'RSD_DTEL_GET'
                EXPORTING
                  i_dtelnm = <fs_field>
*                 I_BYPASS_BUFFER       = RS_C_FALSE
                IMPORTING
                  e_s_dtel = ls_elemdesc.

              <fs_fdesc> = ls_elemdesc-txtmd.
              <fs_fvalue> = <fs_a305>-datbi.
              SHIFT <fs_fvalue> LEFT DELETING LEADING space.
              INSERT <fs_data> INTO TABLE et_data.
            ENDIF.
          ENDIF.

        ENDLOOP.

*        CALL METHOD cl_usmd_model_ext=>get_instance
*          EXPORTING
*            i_usmd_model = 'ZR'                " Data model
*          IMPORTING
*            eo_instance  = DATA(io_model).              " MDM Data Model for Access from Non-SAP Standard
*
*        IF io_model IS BOUND.
*          FIELD-SYMBOLS: <ft_zvalue> TYPE ANY TABLE.
*
*          CALL METHOD cl_usmd_app_context=>get_context( )->get_attributes(
*            IMPORTING
*              eo_model          =  DATA(lv_data_model)                " MDG Data Model EXT for Access from SAP Standard Delivery
*              ev_crequest_id    =  DATA(lv_crequest_id)                " Change Request
*              ev_crequest_type  =  DATA(lv_crequest_type)                " Type of Change Request
*              ev_crequest_step  =  DATA(lv_crequest_step) ).   " Workflow Step Number
*        ENDIF.
*      CALL METHOD cl_usmd_crequest_api=>get_instance
*        EXPORTING
*          iv_crequest          = lv_crequest_id
*          iv_model_name        = 'ZR'                 " Data Model
*        IMPORTING
**         et_message           =                  " Messages
*          re_inst_crequest_api = DATA(io_crapi).                " Change Request API Interface

*      io_crapi->read_crequest(
*        IMPORTING
*          es_crequest   = DATA(ls_crequest) ).                 " Change Request
**              et_note       =                  " Change Request Note
**              et_attachment =                  " Change request Attachment
**              et_message    =                  " Messages
**          ).
*      DATA(lv_crdesc) = ls_crequest-usmd_creq_text.
*      DATA: lv_knumh TYPE knumh.
*      lv_knumh = lv_crdesc+25.

*      IF lv_crequest_type = 'ZR_CREH1'.
*        CALL METHOD io_model->get_cr_objectlist
*          EXPORTING
*            i_crequest = lv_crequest_id                " Change Request
*          IMPORTING
*            et_key_all = DATA(lt_objdata).            " Keys of Objects in Change Request


*        FIELD-SYMBOLS: <ft_zmain> TYPE ANY TABLE.
*        DATA: lr_zmain TYPE REF TO data.
*
*        READ TABLE lt_objdata ASSIGNING FIELD-SYMBOL(<fs_zmain_ref>) WITH KEY entity = 'ZMAIN'.
*        IF sy-subrc = 0.
*          ASSIGN <fs_zmain_ref>-r_data->* TO <ft_zmain>.
*        ENDIF.

*        IF <ft_zmain> IS ASSIGNED.
*          LOOP AT <ft_zmain> ASSIGNING FIELD-SYMBOL(<fs_zmain_wa>).
*            ASSIGN COMPONENT 'ZMAIN' OF STRUCTURE <fs_zmain_wa> TO <fs_zmain>.
*            ASSIGN COMPONENT 'ZOBJ_CLS' OF STRUCTURE <fs_zmain_wa> TO <fs_zobj_cls>.
*            IF <fs_zmain> IS ASSIGNED AND <fs_zobj_cls> IS ASSIGNED.
*              lv_cond_type = <fs_zobj_cls>.
*              lv_tabname = <fs_zmain>.
*            ENDIF.
*          ENDLOOP.
*        ENDIF.


*        IF <ft_zvalue> IS ASSIGNED.
*          LOOP AT <ft_zvalue> ASSIGNING FIELD-SYMBOL(<fs_zvalue>).
*            ASSIGN COMPONENT 'ZFIELD' OF STRUCTURE <fs_zvalue> TO FIELD-SYMBOL(<fs_field>).
*            ASSIGN COMPONENT 'ZFLD_VAL' OF STRUCTURE <fs_zvalue> TO FIELD-SYMBOL(<fs_fvalue>).
*            IF <fs_field> IS ASSIGNED AND <fs_fvalue> IS ASSIGNED AND <fs_field> = 'KNUMH'.
**              lv_knumh = <fs_fvalue>.
*
*            ENDIF.
*          ENDLOOP.
*        ENDIF.
*
**      ENDIF.
*    ENDIF.

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

    DATA:lrt_data_inserted TYPE REF TO data,
         lrt_data_updated  TYPE REF TO data,
         lrt_data_deleted  TYPE REF TO data.

    DATA: lt_bapicondct      TYPE STANDARD TABLE OF bapicondct,
          ls_bapicondct      LIKE LINE OF lt_bapicondct,
          ls_bapicondct_upd  LIKE LINE OF lt_bapicondct,
          lt_bapicondhd      TYPE  STANDARD TABLE OF bapicondhd,
          ls_bapicondhd  LIKE LINE OF lt_bapicondhd,
          ls_bapicondhd_upd  LIKE LINE OF lt_bapicondhd,
          lt_bapicondit      TYPE STANDARD TABLE OF bapicondit,
          ls_bapicondit      LIKE LINE OF lt_bapicondit,
          ls_bapicondit_upd  LIKE LINE OF lt_bapicondit,
          lt_bapicondqs      TYPE STANDARD TABLE OF bapicondqs,
          lt_bapicondvs      TYPE STANDARD TABLE OF bapicondvs,
          lt_bapiret2        TYPE STANDARD TABLE OF bapiret2,
          ls_bapiret2        LIKE LINE OF lt_bapiret2,
          lt_bapiknumhs      TYPE STANDARD TABLE OF bapiknumhs,  " old and new KNUMH
          ls_bapiknumh       LIKE LINE OF lt_bapiknumhs,
          lt_cnd_mem_initial TYPE STANDARD TABLE OF cnd_mem_initial,
          ls_cnd_mem         LIKE LINE OF lt_cnd_mem_initial.

    DATA: lt_konhdb TYPE STANDARD TABLE OF konhdb,
          ls_konhdb LIKE LINE OF lt_konhdb,
          lt_konpdb TYPE STANDARD TABLE OF konpdb,
          ls_konpdb LIKE LINE OF lt_konpdb.

    FIELD-SYMBOLS: <lt_gen_data_insert> TYPE ANY TABLE.
    FIELD-SYMBOLS: <lt_gen_data_update> TYPE ANY TABLE.
    FIELD-SYMBOLS: <lt_identity_data_insert> TYPE ANY TABLE.
    FIELD-SYMBOLS: <lt_identity_data_update> TYPE ANY TABLE.

    CLEAR: et_message,et_tmp_key_map.

    io_delta->read_data(
      EXPORTING
        i_entity      = 'ZVALUE'                            " entity
        i_struct      = if_usmd_model_ext=>gc_struct_key_attr " keys and attributes
      IMPORTING
        er_t_data_ins = lrt_data_inserted                     " inserted data
        er_t_data_upd = lrt_data_updated                      " updated data
        er_t_data_del = lrt_data_deleted ).                   " deleted data


    io_delta->read_data(
      EXPORTING
        i_entity      = 'ZMAIN'                            " entity
        i_struct      = if_usmd_model_ext=>gc_struct_key_attr " keys and attributes
      IMPORTING
        er_t_data_ins = DATA(lrt_zmain_ins)                     " inserted data
        er_t_data_upd = DATA(lrt_zmain_updated)                      " updated data
        er_t_data_del = DATA(lrt_zmain_deleted) ).                   " deleted data

    IF lrt_zmain_ins IS NOT INITIAL.
      FIELD-SYMBOLS: <ft_zmain_ins> TYPE ANY TABLE.
      DATA: lv_access_table TYPE yz_dtel_objid,
            lv_cond_type    TYPE zde_ref_master_obj_class,
            lv_tabname      TYPE tabname.

      ASSIGN lrt_zmain_ins->* TO <ft_zmain_ins>.
      LOOP AT <ft_zmain_ins> ASSIGNING FIELD-SYMBOL(<fs_zmain_ins>).
        ASSIGN COMPONENT 'ZMAIN' OF STRUCTURE <fs_zmain_ins> TO FIELD-SYMBOL(<fs_zmain>).
        ASSIGN COMPONENT 'ZOBJ_CLS' OF STRUCTURE <fs_zmain_ins> TO FIELD-SYMBOL(<fs_zobj_cls>).
        IF <fs_zmain> IS ASSIGNED AND <fs_zobj_cls> IS ASSIGNED.
          lv_access_table = <fs_zmain>.
          lv_cond_type = <fs_zobj_cls>.
          lv_tabname = <fs_zmain>.
        ENDIF.
      ENDLOOP.
    ENDIF.

    DATA: lt_acctab TYPE STANDARD TABLE OF a305, "This table needs to be changed dynamically
          ls_acctab LIKE LINE OF lt_acctab.

    IF lrt_data_inserted IS NOT INITIAL.
      ASSIGN lrt_data_inserted->* TO <lt_gen_data_insert>.
      IF <lt_gen_data_insert> IS ASSIGNED AND <lt_gen_data_insert> IS NOT INITIAL.
        LOOP AT <lt_gen_data_insert> ASSIGNING FIELD-SYMBOL(<fs_inserted_values>).
          ASSIGN COMPONENT 'ZFIELD' OF STRUCTURE <fs_inserted_values> TO FIELD-SYMBOL(<fs_field>).
          ASSIGN COMPONENT 'ZFLD_VAL' OF STRUCTURE <fs_inserted_values> TO FIELD-SYMBOL(<fs_fvalue>).

          IF <fs_field> IS ASSIGNED AND <fs_field> = 'KBETR'.
            IF <fs_fvalue> IS ASSIGNED.
              ls_bapicondit-cond_value = <fs_fvalue>.
            ENDIF.
          ENDIF.
          IF <fs_field> IS ASSIGNED AND <fs_field> = 'KPEIN'.
            IF <fs_fvalue> IS ASSIGNED.
              ls_bapicondit-cond_p_unt = <fs_fvalue>.
            ENDIF.
          ENDIF.
          IF <fs_field> IS ASSIGNED AND <fs_field> = 'LOEVM_KO'.
            IF <fs_fvalue> IS ASSIGNED.
              ls_bapicondit-indidelete = <fs_fvalue>.
            ENDIF.
          ENDIF.
          IF <fs_field> IS ASSIGNED AND <fs_field> = 'KSTBM'.
            IF <fs_fvalue> IS ASSIGNED.
              ls_bapicondit-scale_qty = <fs_fvalue>.
            ENDIF.
          ENDIF.
          IF <fs_field> IS ASSIGNED AND <fs_field> = 'KONWA'.
            IF <fs_fvalue> IS ASSIGNED.
              ls_bapicondit-condcurr = <fs_fvalue>.
            ENDIF.
          ENDIF.
          IF <fs_field> IS ASSIGNED AND <fs_field> = 'KMEIN'.
            IF <fs_fvalue> IS ASSIGNED.
              ls_bapicondit-cond_unit = <fs_fvalue>.
            ENDIF.
          ENDIF.
          IF <fs_field> IS ASSIGNED AND <fs_field> = 'KRETCH'.
            IF <fs_fvalue> IS ASSIGNED.
              ls_bapicondit-calctypcon = <fs_fvalue>.
            ENDIF.
          ENDIF.



          IF <fs_field> IS ASSIGNED AND <fs_field> = 'KFRST'.
            IF <fs_fvalue> IS ASSIGNED.
              ls_bapicondit-status = <fs_fvalue>.

              ls_acctab-kfrst = <fs_fvalue>.
            ENDIF.
          ENDIF.
          IF <fs_field> IS ASSIGNED AND <fs_field> = 'KAPPL'.
            IF <fs_fvalue> IS ASSIGNED.
              ls_bapicondct-applicatio = <fs_fvalue>.
              ls_bapicondhd-applicatio = <fs_fvalue>.
              ls_bapicondit-applicatio = <fs_fvalue>.

              ls_acctab-kappl = <fs_fvalue>.
            ENDIF.
          ENDIF.
          IF <fs_field> IS ASSIGNED AND <fs_field> = 'KSCHL'.
            IF <fs_fvalue> IS ASSIGNED.
              <fs_fvalue> = 'PR00'.      """for now we only need PR00 as condition type, latter we can map it with condition type of type one entity key field
              ls_bapicondct-cond_type = <fs_fvalue>.
              ls_bapicondhd-cond_type = <fs_fvalue>.
              ls_bapicondit-cond_type = <fs_fvalue>.

              ls_acctab-kschl = <fs_fvalue>.
            ENDIF.
          ENDIF.
          IF <fs_field> IS ASSIGNED AND <fs_field> = 'VKORG'.
            IF <fs_fvalue> IS ASSIGNED.
              ls_acctab-vkorg = <fs_fvalue>.
            ENDIF.
          ENDIF.
          IF <fs_field> IS ASSIGNED AND <fs_field> = 'VTWEG'.
            IF <fs_fvalue> IS ASSIGNED.
              ls_acctab-vtweg = <fs_fvalue>.
            ENDIF.
          ENDIF.
          IF <fs_field> IS ASSIGNED AND <fs_field> = 'MATNR'.
            IF <fs_fvalue> IS ASSIGNED.
              ls_acctab-matnr = <fs_fvalue>.
            ENDIF.
          ENDIF.
          IF <fs_field> IS ASSIGNED AND <fs_field> = 'DATBI'.
            IF <fs_fvalue> IS ASSIGNED.
              ls_bapicondct-valid_to = <fs_fvalue>.
              ls_bapicondhd-valid_to = <fs_fvalue>.

              ls_acctab-datbi = <fs_fvalue>.
            ENDIF.
          ENDIF.
          IF <fs_field> IS ASSIGNED AND <fs_field> = 'DATAB'.
            IF <fs_fvalue> IS ASSIGNED.
              ls_bapicondct-valid_from = <fs_fvalue>.
              ls_bapicondhd-valid_from = <fs_fvalue>.

              ls_acctab-datab = <fs_fvalue>.
            ENDIF.
          ENDIF.

          IF <fs_field> IS ASSIGNED AND <fs_field> = 'KBSTAT'. """Missed mapping from A304 table
            IF <fs_fvalue> IS ASSIGNED.
              ls_acctab-kbstat = <fs_fvalue>.
            ENDIF.
          ENDIF.

          IF <fs_field> IS ASSIGNED AND <fs_field> = 'KNUMH'.
            IF <fs_fvalue> IS ASSIGNED.
              ls_bapicondct-cond_no = <fs_fvalue>.
              ls_bapicondhd-cond_no = <fs_fvalue>.
              ls_bapicondit-cond_no = <fs_fvalue>.

              ls_acctab-knumh = <fs_fvalue>.
            ENDIF.
          ENDIF.

          IF <fs_field> IS ASSIGNED AND <fs_field> = 'KUNNR'.
            IF <fs_fvalue> IS ASSIGNED.
              ls_acctab-kunnr = <fs_fvalue>.
            ENDIF.
          ENDIF.

          UNASSIGN: <fs_field>, <fs_fvalue>.
        ENDLOOP.


        DATA: ls_a305       TYPE  a305,  "this table decleration should be defined dynamically, as a workaround we did now
              lv_operation  TYPE msgfn,
              lv_knumh      TYPE knumh,
              lv_varkey     TYPE char100,
              lv_varkey_upd TYPE char100.


        IF lv_tabname = 'A304'.
          SELECT SINGLE * FROM a304 INTO CORRESPONDING FIELDS OF @ls_a305 WHERE vkorg = @ls_acctab-vkorg
                                                                      AND vtweg = @ls_acctab-vtweg
                                                                      AND matnr = @ls_acctab-matnr
                                                                      AND ( datab LT @ls_acctab-datbi )
                                                                      AND ( datbi BETWEEN @ls_acctab-datab AND @ls_acctab-datbi ).
        ELSEIF lv_tabname = 'A305'.
          SELECT SINGLE * FROM a305 INTO CORRESPONDING FIELDS OF @ls_a305 WHERE vkorg = @ls_acctab-vkorg
                                                                      AND vtweg = @ls_acctab-vtweg
                                                                      AND kunnr = @ls_acctab-kunnr
                                                                      AND matnr = @ls_acctab-matnr
                                                                      AND ( datab LT @ls_acctab-datbi )
                                                                      AND ( datbi BETWEEN @ls_acctab-datab AND @ls_acctab-datbi ).
        ENDIF.

        CLEAR: lv_varkey.
        IF ls_a305 IS INITIAL.
          lv_operation = '009'.
          lv_knumh = '$001'.
          CONCATENATE: ls_acctab-vkorg ls_acctab-vtweg ls_acctab-kunnr ls_acctab-matnr INTO lv_varkey.

          ls_bapicondct-table_no = lv_tabname+1(4).
          ls_bapicondct-cond_usage = 'A'.
          ls_bapicondct-operation = lv_operation.   " 009 for insertion and 004 for change process
          ls_bapicondct-varkey = lv_varkey.
          ls_bapicondct-cond_no = lv_knumh.

          ls_bapicondhd-cond_usage = 'A'.
          ls_bapicondhd-table_no = lv_tabname+1(4).
          ls_bapicondhd-operation = lv_operation.
          ls_bapicondhd-varkey = lv_varkey.
          ls_bapicondhd-cond_no = lv_knumh.

          ls_bapicondit-operation = lv_operation.
          ls_bapicondit-cond_count = '01'.
          ls_bapicondit-cond_no = lv_knumh.

        ELSEIF ls_a305 is not INITIAL and ls_a305-datab = ls_acctab-datab.
          lv_operation = '004'.
          lv_knumh = ls_a305-knumh.
          CONCATENATE: ls_a305-vkorg ls_a305-vtweg ls_a305-kunnr ls_a305-matnr INTO lv_varkey_upd.

          ls_bapicondct-table_no = lv_tabname+1(4).
          ls_bapicondct-cond_usage = 'A'.
          ls_bapicondct-operation = lv_operation.   " 009 for insertion and 004 for change process
          ls_bapicondct-varkey = lv_varkey_upd.
          ls_bapicondct-cond_no = lv_knumh.

          ls_bapicondhd-cond_usage = 'A'.
          ls_bapicondhd-table_no = lv_tabname+1(4).
          ls_bapicondhd-operation = lv_operation.
          ls_bapicondhd-varkey = lv_varkey_upd.
          ls_bapicondhd-cond_no = lv_knumh.

          ls_bapicondit-operation = lv_operation.
          ls_bapicondit-cond_count = '01'.
          ls_bapicondit-cond_no = lv_knumh.

        ELSEIF ls_a305 is not INITIAL and ls_acctab-datab GT ls_a305-datab.
          lv_operation = '004'.
          lv_knumh = ls_a305-knumh.
          CLEAR: lv_varkey, lv_varkey_upd.
          CONCATENATE: ls_a305-vkorg ls_a305-vtweg ls_a305-kunnr ls_a305-matnr INTO lv_varkey_upd.

          ls_bapicondct_upd-table_no = lv_tabname+1(4).
          ls_bapicondct_upd-cond_usage = 'A'.
          ls_bapicondct_upd-operation = lv_operation.   " 009 for insertion and 004 for change process
          ls_bapicondct_upd-varkey = lv_varkey_upd.
          ls_bapicondct_upd-cond_no = lv_knumh.
          ls_bapicondct_upd-valid_from = ls_a305-datab.
          ls_bapicondct_upd-valid_to = ls_acctab-datab - 1.
          ls_bapicondct_upd-applicatio = ls_a305-kappl.
          ls_bapicondct_upd-cond_type = ls_a305-kschl.

          ls_bapicondhd_upd-cond_usage = 'A'.
          ls_bapicondhd_upd-table_no = lv_tabname+1(4).
          ls_bapicondhd_upd-operation = lv_operation.
          ls_bapicondhd_upd-varkey = lv_varkey_upd.
          ls_bapicondhd_upd-cond_no = lv_knumh.
          ls_bapicondhd_upd-applicatio = ls_a305-kappl.
          ls_bapicondhd_upd-cond_type = ls_a305-kschl.

          ls_bapicondit_upd-operation = lv_operation.
          ls_bapicondit_upd-cond_count = '01'.
          ls_bapicondit_upd-cond_no = lv_knumh.
          ls_bapicondit_upd-applicatio = ls_a305-kappl.
          ls_bapicondit_upd-cond_type = ls_a305-kschl.

          APPEND ls_bapicondct_upd TO lt_bapicondct.
          APPEND ls_bapicondhd_upd TO lt_bapicondhd.
          APPEND ls_bapicondit_upd TO lt_bapicondit.

          """For creating new entry
          CLEAR: lv_knumh, lv_operation.
          lv_operation = '009'.
          lv_knumh = '$001'.
          CONCATENATE: ls_acctab-vkorg ls_acctab-vtweg ls_acctab-kunnr ls_acctab-matnr INTO lv_varkey.

          ls_bapicondct-table_no = lv_tabname+1(4).
          ls_bapicondct-cond_usage = 'A'.
          ls_bapicondct-operation = lv_operation.
          ls_bapicondct-varkey = lv_varkey.
          ls_bapicondct-cond_no = lv_knumh.

          ls_bapicondhd-cond_usage = 'A'.
          ls_bapicondhd-table_no = lv_tabname+1(4).
          ls_bapicondhd-operation = lv_operation.
          ls_bapicondhd-varkey = lv_varkey.
          ls_bapicondhd-cond_no = lv_knumh.

          ls_bapicondit-operation = lv_operation.
          ls_bapicondit-cond_count = '01'.
          ls_bapicondit-cond_no = lv_knumh.

        ENDIF.



        APPEND ls_bapicondct TO lt_bapicondct.
        APPEND ls_bapicondhd TO lt_bapicondhd.
        APPEND ls_bapicondit TO lt_bapicondit.

        TRY.
            CALL FUNCTION 'BAPI_PRICES_CONDITIONS'
              TABLES
                ti_bapicondct  = lt_bapicondct
                ti_bapicondhd  = lt_bapicondhd
                ti_bapicondit  = lt_bapicondit
                ti_bapicondqs  = lt_bapicondqs
                ti_bapicondvs  = lt_bapicondvs
                to_bapiret2    = lt_bapiret2
                to_bapiknumhs  = lt_bapiknumhs
                to_mem_initial = lt_cnd_mem_initial
              EXCEPTIONS
                update_error   = 1
                OTHERS         = 2.
          CATCH cx_root INTO DATA(lv_message).
        ENDTRY.


      ENDIF.
    ENDIF.


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
ENDCLASS.
