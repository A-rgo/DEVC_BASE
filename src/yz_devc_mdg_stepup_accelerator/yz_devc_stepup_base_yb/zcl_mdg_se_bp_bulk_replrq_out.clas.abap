class ZCL_MDG_SE_BP_BULK_REPLRQ_OUT definition
  public
  final
  create public .

public section.

  interfaces IF_MDG_SE_BP_BULK_REPLRQ_OUT .
  interfaces IF_BADI_INTERFACE .
protected section.
private section.
ENDCLASS.



CLASS ZCL_MDG_SE_BP_BULK_REPLRQ_OUT IMPLEMENTATION.


  METHOD if_mdg_se_bp_bulk_replrq_out~outbound_processing.
*    DATA: lt_out TYPE  mdg_bp_bp_suitebulk_repl_conf.
*
**--------------------------------------------------------------
***&-- Data Declarations
*    CONSTANTS: lc_e   TYPE msgty VALUE 'E',
*               lc_a   TYPE msgtyp VALUE 'A',
*               lc_mdg TYPE char3 VALUE 'MDG'.
*
*    DATA:
**      lt_out           TYPE mdg_bp_bp_suitebulk_repl_conf,
*      ls_cnf      TYPE mdg_bp_bpsuiterplct_conf_msg,
*      lt_cnf      TYPE mdg_bp_bpsuiterplct_conf_m_tab,
*      ls_item     TYPE mdg_fnd_log_item,
*      ls_log      TYPE applmsg,
*      lv_msgno    TYPE msgnr,
*      ls_msg_text TYPE string.
*
*
*    IF in_message_container IS BOUND.
*      DATA(lt_log) = in_message_container->get_messages( ).
*    ENDIF.
*
*    LOOP AT lt_log INTO DATA(ls_logs) WHERE type = lc_e OR type = lc_a.
*      CLEAR: ls_item,lv_msgno.
*      lv_msgno = ls_logs-number.
*      CALL FUNCTION 'MESSAGE_PREPARE'
*        EXPORTING
*          language               = sy-langu
*          msg_id                 = ls_logs-id
*          msg_no                 = lv_msgno
*          msg_var1               = ls_logs-message_v1
*          msg_var2               = ls_logs-message_v2
*          msg_var3               = ls_logs-message_v3
*          msg_var4               = ls_logs-message_v4
*        IMPORTING
*          msg_text               = ls_msg_text
*        EXCEPTIONS
*          function_not_completed = 1
*          message_not_found      = 2
*          OTHERS                 = 3.
*      IF sy-subrc = 0.
*        CONCATENATE ls_log-message ls_msg_text INTO ls_log-message SEPARATED BY space.
*        ls_item-type_id = ls_logs-type.
*        ls_item-severity_code = TEXT-005.
*        ls_item-note    =  ls_msg_text.
*        ls_item-log_item_note_placeholder_subs-first_placeholder_subst_text  = ls_logs-message_v1.
*        ls_item-log_item_note_placeholder_subs-second_placeholder_subst_text = ls_logs-message_v2.
*        ls_item-log_item_note_placeholder_subs-third_placeholder_subst_text  = ls_logs-message_v3.
*        ls_item-log_item_note_placeholder_subs-fourth_placeholder_subst_text = ls_logs-message_v4.
*        APPEND ls_item TO ls_cnf-log-item.
*      ENDIF.
*    ENDLOOP.
*    ls_cnf-message_header-sender_business_system_id    = 'send'.
*    ls_cnf-message_header-recipient_business_system_id = 'rcv'.
*    ls_cnf-business_partner-external_id-content = 'test'.
*    APPEND ls_cnf TO lt_cnf.
*    lt_out-bp_suitebulk_replct_conf-business_partner_suitereplicat = lt_cnf.
*
**--------------------------------------------------------------


    DATA: lt_out_test TYPE mdg_bp_bpsuiterplct_req_msg,
          lt_out_bp   TYPE mdg_bp_bp_suitebulk_repl_req,
          lt_out_aif  TYPE mdg_bp_bpsuiterplct_req_msg.
    DATA: lt_bapiret   TYPE TABLE OF bapiret2.
    MOVE-CORRESPONDING out TO lt_out_aif EXPANDING NESTED TABLES.
**--------------------------------------------------------------
*
    CALL FUNCTION '/AIF/SEND_WITH_PROXY'
      EXPORTING
        ns                   = 'ZB_BP'
        ifname               = 'ZB_AIF_INT'
        ifversion            = '0001'
        logical_port_name    = 'CO_MDG_BP_RPLCTRQ'                    " Logical Port Name
        do_commit            = abap_true
      TABLES
        add_return_tab       = lt_bapiret
      CHANGING
        resp_sap_struct      = lt_out_bp
        sap_struct           = lt_out_bp
      EXCEPTIONS
        persistency_error    = 1
        status_update_failed = 2
        missing_keys         = 3
        interface_not_found  = 4
        transformation_error = 5
        general_error        = 6
        OTHERS               = 7.
    IF sy-subrc <> 0.
      CLEAR: lt_out_test.
    ELSE.
      COMMIT WORK.
    ENDIF.

********************Trigger AIF interface***********************
*    CALL FUNCTION '/AIF/FILE_PROCESS_DATA'
*      EXPORTING
*        ns                     = 'ZB_BP'
*        ifname                 = 'ZB_AIF_INT'
*        ifversion              = '0001'
*        ximsgguid              = '977BDC9DF7F21EDEB19931045F9FE453'
*        xi_flag                = abap_true
*      CHANGING
*        data                   = lt_out_aif
*        raw_struct             = lt_out_aif
*      EXCEPTIONS
*        not_found              = 1
*        customizing_incomplete = 2
*        max_errors_reached     = 3
*        cancel                 = 4
*        err_log                = 5
*        OTHERS                 = 6.
*    IF sy-subrc <> 0.
*
*    ENDIF.


*   *********************************************************
  ENDMETHOD.
ENDCLASS.
