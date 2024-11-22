class ZZMDG_CL_CS_PIR_IDOC_DRF definition
  public
  create public .

public section.

  interfaces IF_DRF_OUTBOUND .

  types:
    t_edidc TYPE TABLE OF edidc .

  constants GC_PIR_KEY_TAB type STRING value 'ZZMDG_T_DRF_KF_PIR' ##NO_TEXT.
  constants GC_RCVPRT type CHAR2 value 'LS' ##NO_TEXT.
protected section.
private section.

  class-data GV_SENDCONFIG type MGALE-SENDALL .
  data MS_RUNTIME_PARAM type DRF_S_RUNTIME_PARAMETER_EXT .
  class-data GV_REPL_MODE type DRF_DLMOD .
  data MT_BUS_SYS_TECH type MDG_T_BUS_SYS_TECH .
  data MV_SEGMENT_IND type BOOLE_D .
  data MV_COUNT_CALL type C .
  class-data GR_DRF_PIR type ref to ZZMDG_CL_CS_PIR_IDOC_DRF .
  data MS_PIR_KEY_DATA type ZZMDG_S_DRF_KF_PIR .

  methods UPDATE_REPLICATION_DATA
    importing
      !IV_OBJECT_ID type DRF_OBJECT_ID optional
      !IT_IDOC_RESULT type T_EDIDC
      !IV_MESSAGETYPE type EDI_DOCTYP
    changing
      !CT_OBJ_REP_STA type DRF_T_OBJ_REP_STA_FULL .
ENDCLASS.



CLASS ZZMDG_CL_CS_PIR_IDOC_DRF IMPLEMENTATION.


  method IF_DRF_OUTBOUND~ANALYZE_CHANGES_BY_CHG_POINTER.
  endmethod.


  METHOD IF_DRF_OUTBOUND~ANALYZE_CHANGES_BY_MDG_CP.

    DATA: ls_change_pointer TYPE mdg_cp_s_cp_full,
          ls_pir_key        TYPE zzmdg_s_drf_kf_pir,
          lt_change_pointer TYPE mdg_cp_t_cp.

    lt_change_pointer = it_change_pointer.

**Delete duplicate records from the change pointer table
    SORT lt_change_pointer BY object_key.
    DELETE ADJACENT DUPLICATES FROM lt_change_pointer COMPARING object_key.

** Object keys are fetched from the change pointer
    LOOP AT lt_change_pointer INTO ls_change_pointer.
      ls_pir_key-matnr = substring( val = ls_change_pointer-object_key off = 0 len = 40 ).
      ls_pir_key-lifnr = substring( val = ls_change_pointer-object_key off = 40 len = 10 ).
      INSERT ls_pir_key INTO TABLE ct_changed_objects.
    ENDLOOP.

  ENDMETHOD.


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


  METHOD IF_DRF_OUTBOUND~FINALIZE.
    CLEAR: MS_PIR_KEY_DATA.
  ENDMETHOD.


  METHOD IF_DRF_OUTBOUND~INITIALIZE.

************************************************************************
* 1.) Create an instance of the class                                    *
*     The runtime parameters is filled with sorted table type used for  *
*     main filter                                     *
************************************************************************

*    CALL FUNCTION 'MVSE_GET_FLAGS'
*      IMPORTING
*        ev_send_all_active = gv_sendconfig.
*
*    gv_repl_mode = is_runtime_param-dlmod.

    CREATE OBJECT gr_drf_pir.

    MOVE is_runtime_param TO gr_drf_pir->ms_runtime_param.

    es_runtime_param_out_impl-table_type_name = gc_pir_key_tab.
    eo_if_drf_outbound = gr_drf_pir.
  ENDMETHOD.


  METHOD IF_DRF_OUTBOUND~MAP_DATA2MESSAGE.

    FIELD-SYMBOLS <ls_data> TYPE data.

    ASSIGN ir_relevant_object->* TO <ls_data>.
    ASSIGN COMPONENT 'MATNR' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_matnr>).
    ASSIGN COMPONENT 'LIFNR' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_lifnr>).


    IF <ls_data> IS ASSIGNED.
      ms_pir_key_data-matnr = <lv_matnr>.
      ms_pir_key_data-lifnr = <lv_lifnr>.
    ENDIF.

  ENDMETHOD.


  METHOD IF_DRF_OUTBOUND~READ_COMPLETE_DATA.

  ENDMETHOD.


  METHOD IF_DRF_OUTBOUND~SEND_MESSAGE.


    DATA :
      ls_bus_sys_tech        TYPE mdg_s_bus_sys_tech,
      ls_obj_rep             TYPE drf_s_obj_rep_sta_attr,
      ls_idoc_control        TYPE edidc,
      lt_idoc_infrec_control TYPE t_edidc,
      ls_pir_data            TYPE zzmdg_s_drf_kf_pir,
      lt_pir_data            TYPE zzmdg_t_drf_kf_pir.

* Fetch the business system for the replication model
    IF mv_count_call EQ 0.
      mv_count_call = 1.
      CALL METHOD cl_drf_access_cust_data=>select_business_sys_for_appl
        EXPORTING
          iv_appl         = ms_runtime_param-appl
          iv_outb_impl    = ms_runtime_param-outb_impl
        IMPORTING
          et_bus_sys_tech = mt_bus_sys_tech.
    ENDIF.

    READ TABLE ct_obj_rep_sta INTO ls_obj_rep INDEX 1.

    READ TABLE mt_bus_sys_tech INTO ls_bus_sys_tech WITH KEY business_system = ls_obj_rep-business_system.

    ls_idoc_control-rcvprn = ls_bus_sys_tech-logsys.
    ls_idoc_control-rcvprt = gc_rcvprt.

    APPEND ls_idoc_control TO lt_idoc_infrec_control.

*    INSERT MS_PIR_KEY_DATA INTO ls_pir_data.


      ls_pir_data-matnr = ms_pir_key_data-matnr.
      ls_pir_data-lifnr = ms_pir_key_data-lifnr.
      APPEND ls_pir_data TO lt_pir_data.

*    ls_pir_data  = mt_mat_segment_data .

TYPES: BEGIN OF ls_conditions.
TYPES : a_datbi TYPE datbi.
TYPES : a_datab TYPE datab.
TYPES : msgfn   TYPE msgfn.
TYPES : beakz TYPE beakz.
        INCLUDE TYPE konh.
TYPES : vakey TYPE vakey_long.
TYPES : vadat   TYPE vadat_ko_long.
TYPES: END OF ls_conditions.

DATA : lt_eina         TYPE TABLE OF eina,
       lt_a017         TYPE TABLE OF a017,
       lt_konh         TYPE TABLE OF konh,
       lt_conditions   TYPE TABLE OF ls_conditions,
       lt_idoc_control TYPE TABLE OF edidc.


*lt_mat_key = ls_mat_data-t_marakey.
*lt_mat_key = lt_pir_data.

WAIT UP TO 20 SECONDS.
* for PIR
*IF lt_mat_key IS NOT INITIAL.

IF lt_pir_data IS NOT INITIAL.

*  SELECT *
*    FROM eina
*    INTO TABLE lt_eina
*    FOR ALL ENTRIES IN lt_mat_key
*    WHERE matnr = lt_mat_key-matnr.

  SELECT *
    FROM eina
    INTO TABLE lt_eina
    FOR ALL ENTRIES IN lt_pir_data
    WHERE matnr = lt_pir_data-matnr.

  IF sy-subrc IS NOT INITIAL.
    CLEAR : lt_eina.
  ENDIF.
ENDIF.

IF lt_eina IS NOT INITIAL.

CALL FUNCTION 'MASTERIDOC_CREATE_REQ_INFREC'
  EXPORTING
    RCVPFC                     = ' '
    RCVPRN                     = ' '
    RCVPRT                     = ' '
    message_type               = 'INFREC'
   PARALLEL                    = ' '
  tables
    t_eina_all                 = lt_eina
    te_idoc_control            = lt_idoc_control.

*for conditions

  IF lt_pir_data IS NOT INITIAL.

    SELECT *
      FROM A017
      INTO TABLE lt_a017
      FOR ALL ENTRIES IN lt_pir_data
      WHERE matnr = lt_pir_data-matnr.
    IF sy-subrc IS NOT INITIAL.
      CLEAR: lt_a017.
    ENDIF.
   ENDIF.

  IF lt_a017 IS NOT INITIAL.
    SELECT *
      FROM konh
      INTO TABLE lt_konh
      FOR ALL ENTRIES IN lt_a017
      WHERE knumh = lt_a017-knumh.

    IF sy-subrc IS NOT INITIAL.
      CLEAR: lt_konh.
    ENDIF.
   ENDIF.

   MOVE-CORRESPONDING lt_konh TO lt_conditions.

IF lt_konh IS NOT INITIAL.
 CALL FUNCTION 'MASTERIDOC_CREATE_COND_A'
  EXPORTING
   pi_mestyp                       = 'COND_A'
   PI_LOGSYS                       = ' '
   PI_DIREKT                       = ' '
   PI_KONH_COMPLETE                = ' '
   PI_PROTOCOLL                    = 'X'
   WITHOUT_CUTOFF                  = ' '
* IMPORTING
*   CREATED_COMM_IDOCS              =
  TABLES
    pit_conditions                  = lt_conditions
    TE_IDOC_CONTROL                 = lt_idoc_control.

 IF sy-subrc <> 0.
* Implement suitable error handling here
 ENDIF.
ENDIF.

ENDIF.

  ENDMETHOD.


  METHOD UPDATE_REPLICATION_DATA.

    DATA:
      ls_idoc_control   TYPE edidc,
      ls_change_pointer TYPE mdg_cp_s_cp_full.
    FIELD-SYMBOLS : <ls_obj_rep> TYPE drf_s_obj_rep_sta_attr.

    IF iv_messagetype = 'INFREC'.
**Update replication parameter.
      LOOP AT it_idoc_result INTO ls_idoc_control.
        CLEAR : ls_change_pointer.
        READ TABLE ct_obj_rep_sta ASSIGNING <ls_obj_rep> WITH KEY object_id = iv_object_id.
        ASSERT sy-subrc = 0.
        <ls_obj_rep>-msg_link    = ls_idoc_control-docnum. " lv_msg_link.
      ENDLOOP.
    ENDIF.

    IF iv_messagetype = 'COND_A'.
**Update replication parameter.
      LOOP AT it_idoc_result INTO ls_idoc_control.
        CLEAR : ls_change_pointer.
        READ TABLE ct_obj_rep_sta ASSIGNING <ls_obj_rep> WITH KEY object_id = iv_object_id.
        ASSERT sy-subrc = 0.
        <ls_obj_rep>-msg_link    = ls_idoc_control-docnum. " lv_msg_link.
      ENDLOOP.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
