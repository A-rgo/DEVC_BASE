class ZZMDG_CL_PIR_CROSS_ENTITY_DER definition
  public
  final
  create public .

public section.

  interfaces IF_BADI_INTERFACE .
  interfaces IF_EX_USMD_RULE_SERVICE2 .
protected section.
private section.
ENDCLASS.



CLASS ZZMDG_CL_PIR_CROSS_ENTITY_DER IMPLEMENTATION.


  method IF_EX_USMD_RULE_SERVICE2~DERIVE.

    TYPES : BEGIN OF ty_cond,
              matnr TYPE matnr,
              ekorg TYPE ekorg,
              lifnr TYPE lifnr,
              datab TYPE datab,
              datbi TYPE datbi,
              werks TYPE werks_d,
              kbetr TYPE kbetr_kond,
              konwa TYPE konwa,
              esokz TYPE esokz,
            END OF ty_cond.

    DATA: lt_cond   TYPE TABLE OF ty_cond,
          ls_cond   LIKE LINE OF lt_cond.

    DATA: lo_usmd_app_context TYPE REF TO if_usmd_app_context,
          lt_data_entity      TYPE usmd_ts_data_entity,
          lr_t_mod_class      TYPE REF TO data,
          lr_t_mod_char       TYPE REF TO data,
          lr_t_mod_mat        TYPE REF TO data,
          lr_t_mod_vendor     TYPE REF TO data,
          lt_sel              TYPE usmd_ts_sel,
          ls_sel              LIKE LINE OF lt_sel,
          lv_datum_f          TYPE datum,
          lv_datum_t          TYPE datum,
          lv_sop_flag         TYPE flag,
          lv_mop_flag         TYPE flag.

    CONSTANTS: lc_material        TYPE usmd_fieldname VALUE 'MATERIAL',
               lc_material_entity TYPE usmd_entity VALUE 'MATERIAL',
               lc_marapurch       TYPE usmd_entity VALUE 'MARAPURCH'.

    DATA : lr_data_por_ins TYPE REF TO data,
           lr_data_por_upd TYPE REF TO data,
           lr_data_por_mod TYPE REF TO data,
           lr_data_por_del TYPE REF TO data,
           lr_data_pur_ins TYPE REF TO data,
           lr_data_pur_upd TYPE REF TO data,
           lr_data_pur_mod TYPE REF TO data,
           lr_data_pur_del TYPE REF TO data,
           lr_cond_mod     TYPE REF TO data,
           lr_cond_upd     TYPE REF TO data,
           lr_cond_data    TYPE REF TO data,
           lr_cond_data_s  TYPE REF TO data,
           lr_data2        TYPE REF TO data,
           lo_cond_context TYPE REF TO if_usmd_app_context,
           ls_entity       TYPE usmd_entity,
           lt_entity       TYPE usmd_t_entity.

    FIELD-SYMBOLS : <ft_purorg_data> TYPE ANY TABLE,
                    <ft_pureina_data> TYPE ANY TABLE,
                    <ft_pureina_mdata> TYPE ANY TABLE,
                    <ft_matnr_data>  TYPE ANY TABLE,
                    <ft_cond>        TYPE ANY TABLE,
                    <ft_pcond_data>  TYPE ANY TABLE,
                    <fs_pcond_data>  TYPE any,
                    <fs_purorg_data> TYPE any,
                    <fs_pureina_data> TYPE any,
                    <fs_matnr_c>     TYPE any,
                    <fs_vend>        TYPE any,
                    <fs_werks>       TYPE any,
                    <fs_ekorg>       TYPE any,
                    <fs_netpr>       TYPE any,
                    <fs_bprme>       TYPE any,
                    <fs_peinh>       TYPE any,
                    <fs_waers>       TYPE any,
                    <fs_esokz>       TYPE any,
                    <fs_vend_c>      TYPE any,
                    <fs_matnr>       TYPE any,
                    <fs_werks_c>     TYPE any,
                    <fs_ekorg_c>     TYPE any,
                    <fs_netpr_c>     TYPE any,
                    <fs_konwa_c>     TYPE any,
                    <fs_kmein_c>     TYPE any,
                    <fs_krech_c>     TYPE any,
                    <fs_datab_c>     TYPE any,
                    <fs_kpeinh_c>    TYPE any,
                    <fs_datbi_c>     TYPE any,
                    <ft_data3>       TYPE ANY TABLE,
                    <ft_data4>       TYPE ANY TABLE,
                    <fs_esokz_c>     TYPE any,
                    <ft_purog>       TYPE ANY TABLE,
                    <fv_esokz>       TYPE any.

    "Retrieve change request information via application contexts
    lo_usmd_app_context = cl_usmd_app_context=>get_context( ).

    IF lo_usmd_app_context IS BOUND.
      lo_usmd_app_context->get_attributes(
      IMPORTING
        ev_crequest_id   = DATA(lv_cr_number)
        ev_crequest_type = DATA(lv_cr_type)
      ).
    ENDIF.

    SELECT SINGLE usmd_single_obj FROM usmd110c INTO lv_sop_flag WHERE usmd_creq_type = lv_cr_type.
    IF sy-subrc = 0.
      IF lv_sop_flag IS INITIAL.
        lv_mop_flag = abap_true.
      ENDIF.
    ENDIF.

*****Deriving ZPIRCOND Entity based on ZPURCHINF Entity
      io_changed_data->read_data(
          EXPORTING
            i_entity               =  'ZPURCHINF'       "Entity Type
            i_struct               = if_usmd_model_ext=>gc_struct_key_attr " Type of Data Structure
          IMPORTING
            er_t_data_ins          =  lr_data_por_ins                                     " Newly Added Data Records
            er_t_data_upd          =  lr_data_por_upd                                     " Data Records Changed                                     " Data Records Deleted
            er_t_data_mod          =  lr_data_por_mod
            er_t_data_del          =  lr_data_por_del                                " "Modified" Data Records (INSERT+UPDATE)
                                           " Unchanged Attributes Are Also Filled
        ).

      io_changed_data->read_data(
        EXPORTING
          i_entity               = 'ZPIRCOND'                                       " Entity Type
          i_struct               = if_usmd_model_ext=>gc_struct_key_attr " Type of Data Structure
        IMPORTING
          er_t_data_upd          = lr_cond_upd                                       " Newly Added Data Records
          er_t_data_mod          = lr_cond_mod                                       " "Modified" Data Records (INSERT+UPDATE)
      ).
      io_changed_data->read_data(
          EXPORTING
            i_entity               =  'ZPURCHGEN'       "Entity Type
            i_struct               = if_usmd_model_ext=>gc_struct_key_attr " Type of Data Structure
          IMPORTING
            er_t_data_ins          =  lr_data_pur_ins                                     " Newly Added Data Records
            er_t_data_upd          =  lr_data_pur_upd                                     " Data Records Changed                                     " Data Records Deleted
            er_t_data_mod          =  lr_data_pur_mod
            er_t_data_del          =  lr_data_pur_del                                " "Modified" Data Records (INSERT+UPDATE)
                                           " Unchanged Attributes Are Also Filled
        ).
      ASSIGN lr_data_pur_ins->* TO <ft_pureina_data>.
      IF <ft_pureina_data> IS NOT ASSIGNED.
        ASSIGN lr_data_pur_upd->* TO <ft_pureina_data>.
      ENDIF.
      ASSIGN lr_data_pur_mod->* TO <ft_pureina_mdata>.
      ASSIGN lr_data_por_ins->* TO <ft_purorg_data>.
      IF <ft_purorg_data> IS NOT ASSIGNED.
        ASSIGN lr_data_por_upd->* TO <ft_purorg_data>.
      ENDIF.

      ASSIGN lr_cond_mod->* TO <ft_cond>.

*      CLEAR: lv_zaehl.
      IF <ft_purorg_data> IS ASSIGNED.
        LOOP AT <ft_purorg_data> ASSIGNING <fs_purorg_data>.
          ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <fs_purorg_data> TO <fs_matnr_c>.
          IF <fs_matnr_c> IS ASSIGNED AND <fs_matnr_c> IS NOT INITIAL.
            ls_sel-fieldname = 'MATERIAL'.
            ls_sel-sign = 'I'.
            ls_sel-option = 'EQ'.
            ls_sel-low = <fs_matnr_c>.
            READ TABLE lt_sel FROM ls_sel TRANSPORTING NO FIELDS.
            IF sy-subrc <> 0.
              INSERT ls_sel INTO TABLE lt_sel.
            ENDIF.
            CLEAR : ls_sel.
          ENDIF.
          ASSIGN COMPONENT 'LIFNR' OF STRUCTURE <fs_purorg_data> TO <fs_vend>.
          ASSIGN COMPONENT 'EKORG' OF STRUCTURE <fs_purorg_data> TO <fs_ekorg>.
          ASSIGN COMPONENT 'EKWRK' OF STRUCTURE <fs_purorg_data> TO <fs_werks>.
          ASSIGN COMPONENT 'ESOKZ' OF STRUCTURE <fs_purorg_data> TO <fs_esokz>.
          ASSIGN COMPONENT 'NETPR' OF STRUCTURE <fs_purorg_data> TO <fs_netpr>.
          ASSIGN COMPONENT 'BPRME' OF STRUCTURE <fs_purorg_data> TO <fs_bprme>.
          ASSIGN COMPONENT 'PEINH_P' OF STRUCTURE <fs_purorg_data> TO <fs_peinh>.
          ASSIGN COMPONENT 'WAERS'  OF STRUCTURE <fs_purorg_data> TO <fs_waers>.
          IF ( <fs_vend> IS ASSIGNED AND <fs_vend> IS NOT INITIAL )
            AND ( <fs_ekorg> IS ASSIGNED AND <fs_ekorg> IS NOT INITIAL )
            AND ( <fs_esokz> IS ASSIGNED AND <fs_esokz> IS NOT INITIAL )
            AND ( <fs_netpr> IS ASSIGNED AND <fs_netpr> IS NOT INITIAL )
            AND <fs_werks> IS ASSIGNED.

            TRY.
                io_write_data->create_data_reference(
                  EXPORTING
                    i_entity     = 'ZPIRCOND'                 " Entity Type
                    i_struct     =  if_usmd_model_ext=>gc_struct_key_attr                " Type of Data Structure
                        " Field Names
                  RECEIVING
                    er_data      = lr_cond_data
                ).

                ASSIGN lr_cond_data->* TO <ft_pcond_data>.
                CREATE DATA lr_cond_data_s LIKE LINE OF <ft_pcond_data>.
                ASSIGN lr_cond_data_s->* TO <fs_pcond_data>.
              CATCH cx_usmd_write_error. " Error while writing to buffer
            ENDTRY.

*            TRY. **commented by ashwansingh

*                lo_cond_context ?= cl_usmd_app_context=>get_context( ).
*              CATCH cx_sy_move_cast_error.
*                RETURN.
*            ENDTRY.
*            IF lo_cond_context IS NOT BOUND.
*              RETURN.
*            ENDIF.
*            lo_cond_context->get_attributes( IMPORTING ev_edition = lv_edition ).

            IF <fs_pcond_data> IS ASSIGNED.

              ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <fs_pcond_data> TO <fs_matnr>.
              IF <fs_matnr> IS ASSIGNED AND <fs_matnr> IS INITIAL.
                <fs_matnr> = <fs_matnr_c>.
              ENDIF.

              ASSIGN COMPONENT 'LIFNR' OF STRUCTURE <fs_pcond_data> TO <fs_vend_c>.
              IF <fs_vend_c> IS ASSIGNED AND <fs_vend_c> IS INITIAL.
                <fs_vend_c> = <fs_vend>.
              ENDIF.

              ASSIGN COMPONENT 'EKORG' OF STRUCTURE <fs_pcond_data> TO <fs_ekorg_c>.
              IF <fs_ekorg_c> IS ASSIGNED AND <fs_ekorg_c> IS INITIAL.
                <fs_ekorg_c> = <fs_ekorg>.
              ENDIF.

              ASSIGN COMPONENT 'EKWRK' OF STRUCTURE <fs_pcond_data> TO <fs_werks_c>.
              IF <fs_werks_c> IS ASSIGNED AND <fs_werks_c> IS INITIAL.
                <fs_werks_c> = <fs_werks>.
              ENDIF.
              ASSIGN COMPONENT 'ESOKZ' OF STRUCTURE <fs_pcond_data> TO <fs_esokz_c>.

              IF <fs_esokz_c> IS ASSIGNED AND <fs_esokz_c> IS INITIAL.
                <fs_esokz_c> = <fs_esokz>.
              ENDIF.

              ASSIGN COMPONENT 'KONWA' OF STRUCTURE <fs_pcond_data> TO <fs_konwa_c>.
              IF <fs_konwa_c> IS ASSIGNED AND <fs_konwa_c> IS INITIAL.
                IF <fs_waers> IS NOT INITIAL.
                  <fs_konwa_c> = <fs_waers>.
                ELSE.
                  <fs_konwa_c> = 'USD'.
                ENDIF.
              ENDIF.

              ASSIGN COMPONENT 'KBETR' OF STRUCTURE <fs_pcond_data> TO <fs_netpr_c>.
              IF <fs_netpr_c> IS ASSIGNED AND <fs_netpr_c> IS INITIAL.
                IF <fs_waers> IS ASSIGNED AND ( <fs_waers> = 'CLP' ).
                  <fs_netpr_c> = <fs_netpr> * 100.
                ELSE.
                  <fs_netpr_c> = <fs_netpr>.
                ENDIF.
              ENDIF.

              ASSIGN COMPONENT 'KMEIN' OF STRUCTURE <fs_pcond_data> TO <fs_kmein_c>.
              IF <fs_kmein_c> IS ASSIGNED AND <fs_kmein_c> IS INITIAL.
                IF <fs_bprme> IS NOT INITIAL.
                  <fs_kmein_c> = <fs_bprme>.
                ELSE.
                  <fs_kmein_c> = 'EA'.
                ENDIF.
              ENDIF.

              ASSIGN COMPONENT 'KRECH' OF STRUCTURE <fs_pcond_data> TO <fs_krech_c>.
              IF <fs_krech_c> IS ASSIGNED AND <fs_krech_c> IS INITIAL.
                <fs_krech_c> = 'C'.
              ENDIF.

              ASSIGN COMPONENT 'KPEIN' OF STRUCTURE <fs_pcond_data> TO <fs_kpeinh_c>.
              IF <fs_kpeinh_c> IS ASSIGNED AND <fs_kpeinh_c> IS INITIAL.
                IF <fs_peinh> IS NOT INITIAL.
                  <fs_kpeinh_c> = <fs_peinh>.
                ELSE.
                  <fs_kpeinh_c> = '1'.
                ENDIF.
              ENDIF.

              ASSIGN COMPONENT 'DATAB' OF STRUCTURE <fs_pcond_data> TO <fs_datab_c>.
              IF <fs_datab_c> IS ASSIGNED AND <fs_datab_c> IS INITIAL.
                lv_datum_f = sy-datum.
                <fs_datab_c> = lv_datum_f.
              ENDIF.

              ASSIGN COMPONENT 'DATBI' OF STRUCTURE <fs_pcond_data> TO <fs_datbi_c>.
              IF <fs_datbi_c> IS ASSIGNED AND <fs_datbi_c> IS INITIAL.
                lv_datum_t = '99991231'.
                <fs_datbi_c> = lv_datum_t.
              ENDIF.

              TRY.
                  INSERT <fs_pcond_data> INTO TABLE <ft_pcond_data>.
                  io_write_data->write_data(
                    EXPORTING
                      i_entity     =  'ZPIRCOND'                " Entity Type
*        it_key       =                  " Fixings
*              it_attribute = lt_attribute                 " Financials MDM: Field Name
                      it_data      = <ft_pcond_data>
                  ).
                CATCH cx_usmd_write_error. " Error while writing to buffer
              ENDTRY.
            ENDIF.

          ENDIF.
        ENDLOOP.
      ENDIF.

      CLEAR: lt_sel.
      IF <ft_cond> IS ASSIGNED.

        LOOP AT <ft_cond> ASSIGNING FIELD-SYMBOL(<fs_cond>).
          ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <fs_cond> TO FIELD-SYMBOL(<fv_mat>).
          IF <fv_mat> IS ASSIGNED AND <fv_mat> IS NOT INITIAL.
            ls_sel-fieldname = 'MATERIAL'.
            ls_sel-sign = 'I'.
            ls_sel-option = 'EQ'.
            ls_sel-low = <fv_mat>.
            READ TABLE lt_sel FROM ls_sel TRANSPORTING NO FIELDS.
            IF sy-subrc <> 0.
              INSERT ls_sel INTO TABLE lt_sel.
            ENDIF.
            CLEAR : ls_sel.
          ENDIF.
          ASSIGN COMPONENT 'LIFNR' OF STRUCTURE <fs_cond> TO FIELD-SYMBOL(<fv_lifnr1>).
          ASSIGN COMPONENT 'EKORG' OF STRUCTURE <fs_cond> TO FIELD-SYMBOL(<fv_ekorg1>).
          ASSIGN COMPONENT 'EKWRK' OF STRUCTURE <fs_cond> TO FIELD-SYMBOL(<fs_werkc>).
          ASSIGN COMPONENT 'DATAB' OF STRUCTURE <fs_cond> TO FIELD-SYMBOL(<fv_datab>).
          ASSIGN COMPONENT 'DATBI' OF STRUCTURE <fs_cond> TO FIELD-SYMBOL(<fv_datbi>).
          ASSIGN COMPONENT 'KBETR' OF STRUCTURE <fs_cond> TO FIELD-SYMBOL(<fv_kbetr>).
          ASSIGN COMPONENT 'KONWA' OF STRUCTURE <fs_cond> TO FIELD-SYMBOL(<fv_konwa>).
          UNASSIGN <fv_esokz>.
          ASSIGN COMPONENT 'ESOKZ' OF STRUCTURE <fs_cond> TO <fv_esokz>.

          IF <fv_mat> IS ASSIGNED AND <fv_lifnr1> IS ASSIGNED AND <fv_ekorg1> IS ASSIGNED
            AND <fv_datab> IS ASSIGNED AND <fv_datbi> IS ASSIGNED AND <fv_kbetr> IS ASSIGNED
            AND <fs_werkc> IS ASSIGNED AND ( <fs_werkc> IS NOT INITIAL OR <fs_werkc> IS INITIAL )
            AND <fv_mat> IS NOT INITIAL AND <fv_lifnr1> IS NOT INITIAL AND <fv_ekorg1> IS NOT INITIAL
            AND <fv_datab> IS NOT INITIAL AND <fv_datbi> IS NOT INITIAL AND <fv_kbetr> IS NOT INITIAL
            AND <fv_konwa> IS ASSIGNED AND <fv_konwa> IS NOT INITIAL AND <fv_esokz> IS ASSIGNED.

            ls_cond-matnr = <fv_mat>.
            ls_cond-lifnr = <fv_lifnr1>.
            ls_cond-ekorg = <fv_ekorg1>.
            ls_cond-datab = <fv_datab>.
            ls_cond-datbi = <fv_datbi>.
            ls_cond-werks = <fs_werkc>.
            ls_cond-kbetr = <fv_kbetr>.
            ls_cond-konwa = <fv_konwa>.
            ls_cond-esokz = <fv_esokz>.
            APPEND ls_cond TO lt_cond.
            CLEAR : ls_cond.
          ENDIF.

        ENDLOOP.
        IF lt_sel IS NOT INITIAL AND lt_cond IS NOT INITIAL.
          io_model->create_data_reference( EXPORTING i_fieldname = 'ZPURCHINF' i_struct = 'KATTR' IMPORTING er_data = lr_data2 ).
          ASSIGN lr_data2->* TO <ft_data3>.
          ASSIGN lr_data2->* TO <ft_purog>.
          io_model->read_char_value( EXPORTING i_fieldname = 'ZPURCHINF' it_sel = lt_sel IMPORTING et_data = <ft_data3> ).
          LOOP AT <ft_data3> ASSIGNING FIELD-SYMBOL(<fs_data3>).
            ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <fs_data3> TO FIELD-SYMBOL(<fv_mat1>).
            ASSIGN COMPONENT 'LIFNR' OF STRUCTURE <fs_data3> TO FIELD-SYMBOL(<fv_lifnr2>).
            ASSIGN COMPONENT 'EKORG' OF STRUCTURE <fs_data3> TO FIELD-SYMBOL(<fv_ekorg2>).
            ASSIGN COMPONENT 'EKWRK' OF STRUCTURE <fs_data3> TO FIELD-SYMBOL(<fv_ekwrk>).
            ASSIGN COMPONENT 'NETPR' OF STRUCTURE <fs_data3> TO FIELD-SYMBOL(<fv_netpr>).
            ASSIGN COMPONENT 'WAERS' OF STRUCTURE <fs_data3> TO FIELD-SYMBOL(<fv_waers>).
            ASSIGN COMPONENT 'EFFPR' OF STRUCTURE <fs_data3> TO FIELD-SYMBOL(<fv_effpr>).
            UNASSIGN <fv_esokz>.
            ASSIGN COMPONENT 'ESOKZ' OF STRUCTURE <fs_data3> TO <fv_esokz>.

            IF <fv_mat1> IS ASSIGNED AND <fv_mat1> IS NOT INITIAL
              AND <fv_lifnr2> IS ASSIGNED AND <fv_lifnr2> IS NOT INITIAL
              AND <fv_ekorg2> IS ASSIGNED AND <fv_ekorg2> IS NOT INITIAL
              AND <fv_effpr> IS ASSIGNED
              AND <fv_netpr> IS ASSIGNED AND <fv_netpr> IS NOT INITIAL
              AND <fv_waers> IS ASSIGNED AND <fv_waers> IS NOT INITIAL
              AND <fv_esokz> IS ASSIGNED AND <fv_esokz> IS NOT INITIAL.

*            READ TABLE lt_cond INTO ls_cond WITH KEY matnr = <fv_mat1> lifnr = <fv_lifnr2> ekorg = <fv_ekorg2>.
              CLEAR ls_cond.
              LOOP AT lt_cond INTO ls_cond WHERE matnr = <fv_mat1>
                                             AND lifnr = <fv_lifnr2>
                                             AND ekorg = <fv_ekorg2>
                                             AND datbi GE sy-datum
                                             AND datab LE sy-datum
                                             AND esokz = <fv_esokz>.
                EXIT.
              ENDLOOP.
              IF ls_cond IS NOT INITIAL.
                IF ls_cond-kbetr <> <fv_netpr>.
                  IF ls_cond-konwa = 'CLP' .
                    <fv_netpr> = ls_cond-kbetr / 100.
                    <fv_effpr> = ls_cond-kbetr / 100.
                  ELSE.
                    <fv_netpr> = ls_cond-kbetr.
                    <fv_effpr> = ls_cond-kbetr.
                  ENDIF.
                  <fv_waers> = ls_cond-konwa.
                  INSERT <fs_data3> INTO TABLE <ft_purog>.
                ENDIF.
*              ENDIF.
              ENDIF.
            ENDIF.
          ENDLOOP.
        ENDIF.
        IF <ft_purog> IS ASSIGNED AND <ft_purog> IS NOT INITIAL.
          TRY.
              io_write_data->write_data(
                EXPORTING
                  i_entity     =  'ZPURCHINF'                " Entity Type
                  it_data      = <ft_purog>
              ).
            CATCH cx_usmd_write_error. " Error while writing to buffer
          ENDTRY.
        ENDIF.
      ENDIF.
******PIR Derivation logic for  ZPURCHGEN & ZPURCHINF Entity.
      IF <ft_pureina_data> IS ASSIGNED.
        LOOP AT <ft_pureina_data> ASSIGNING <fs_pureina_data>.
          ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <fs_pureina_data> TO <fs_matnr_c>.
          IF <fs_matnr_c> IS ASSIGNED AND <fs_matnr_c> IS NOT INITIAL.
            ls_sel-fieldname = 'MATERIAL'.
            ls_sel-sign = 'I'.
            ls_sel-option = 'EQ'.
            ls_sel-low = <fs_matnr_c>.
            READ TABLE lt_sel FROM ls_sel TRANSPORTING NO FIELDS.
            IF sy-subrc <> 0.
              INSERT ls_sel INTO TABLE lt_sel.
            ENDIF.
            CLEAR : ls_sel.
          ENDIF.
        ENDLOOP.
        ls_entity = 'MATERIAL'.
        APPEND ls_entity TO lt_entity.
        ls_entity = 'ZPURCHINF'.
        APPEND ls_entity TO lt_entity.
        io_model->read_entity_data_all(
          EXPORTING
            i_fieldname = lc_material
            if_active   = ' '
            it_sel      = lt_sel
            it_entity_filter = lt_entity
          IMPORTING
            et_data_entity = lt_data_entity
            ).
        IF lt_data_entity IS INITIAL.
          io_model->read_entity_data_all(
            EXPORTING
              i_fieldname = lc_material
              if_active   = abap_true
              it_sel      = lt_sel
              it_entity_filter = lt_entity
            IMPORTING
              et_data_entity = lt_data_entity
              ).
        ENDIF.
        CLEAR lt_entity.
        IF lt_sel IS NOT INITIAL AND lt_data_entity IS NOT INITIAL.
          READ TABLE lt_data_entity ASSIGNING FIELD-SYMBOL(<fs_data_entity_purorg1>) WITH KEY usmd_entity_cont = 'ZPURCHINF'. "#EC CI_SORTSEQ
          IF sy-subrc  = 0 AND <fs_data_entity_purorg1> IS ASSIGNED.
            ASSIGN <fs_data_entity_purorg1>-r_t_data->* TO <ft_data4>.
            LOOP AT <ft_data4> ASSIGNING FIELD-SYMBOL(<fs_data4>).
              ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <fs_data4> TO FIELD-SYMBOL(<fv_mat2>).
              ASSIGN COMPONENT 'LIFNR' OF STRUCTURE <fs_data4> TO FIELD-SYMBOL(<fv_lifnr3>).
              ASSIGN COMPONENT 'MEIN3' OF STRUCTURE <fs_data4> TO FIELD-SYMBOL(<fv_mein3>).
              ASSIGN COMPONENT 'MEIN4' OF STRUCTURE <fs_data4> TO FIELD-SYMBOL(<fv_mein4>).
              ASSIGN COMPONENT 'BPRME' OF STRUCTURE <fs_data4> TO FIELD-SYMBOL(<fv_bprme>).
                IF <ft_pureina_mdata> IS ASSIGNED.
                  LOOP AT <ft_pureina_mdata> ASSIGNING <fs_pureina_data> WHERE ('LIFNR = <fv_lifnr3>').
                       ASSIGN COMPONENT 'MEINS_P' OF STRUCTURE <fs_pureina_data> TO FIELD-SYMBOL(<fv_meins_p>).
                       IF <fv_meins_p> IS ASSIGNED AND <fv_meins_p> IS NOT INITIAL AND <fv_mein3> IS ASSIGNED AND <fv_mein4> IS ASSIGNED AND <fv_bprme> IS ASSIGNED..
                         <fv_mein3> = <fv_meins_p>.
                         <fv_mein4> = <fv_meins_p>.
                         <fv_bprme> = <fv_meins_p>.
                       ENDIF.
                  ENDLOOP.
                ENDIF.
            ENDLOOP.
          IF <ft_data4> IS ASSIGNED AND <ft_data4> IS NOT INITIAL.
            TRY.
                io_write_data->write_data(
                  EXPORTING
                    i_entity     =  'ZPURCHINF'                " Entity Type
*          it_key       =                  " Fixings
*                it_attribute = lt_attribute                 " Financials MDM: Field Name
                    it_data      = <ft_data4>
                ).
              CATCH cx_usmd_write_error. " Error while writing to buffer
            ENDTRY.
          ENDIF.
         ENDIF.
       ENDIF.
     ENDIF.
******End of PIR derivation Logic ********


  endmethod.
ENDCLASS.
