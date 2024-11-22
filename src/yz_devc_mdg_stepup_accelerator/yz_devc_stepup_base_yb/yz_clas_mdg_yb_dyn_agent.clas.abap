class YZ_CLAS_MDG_YB_DYN_AGENT definition
  public
  final
  create public .

public section.

  interfaces IF_BADI_INTERFACE .
  interfaces IF_USMD_SSW_DYNAMIC_AGT_SELECT .
protected section.
private section.
ENDCLASS.



CLASS YZ_CLAS_MDG_YB_DYN_AGENT IMPLEMENTATION.


  METHOD if_usmd_ssw_dynamic_agt_select~get_dynamic_agents.

    DATA: non_user_agt TYPE usmd_t_non_user_agent_group,
          non_agent    LIKE LINE OF non_user_agt.
    DATA: ls_user_agent       TYPE  usmd_s_user_agent,
          ls_user_agent_group TYPE  usmd_s_user_agent_group.
    DATA: lo_crequest_api TYPE REF TO if_usmd_crequest_api.

    TYPES : BEGIN OF ty_bank,
              Name  TYPE String,
              Value TYPE string,
            END OF ty_bank.

    DATA: lt_bank TYPE STANDARD TABLE OF ty_bank WITH EMPTY KEY,
          ls_bank LIKE LINE OF lt_bank.
    DATA: lt_recipients TYPE TABLE OF swragent.
    DATA: lv_uname      TYPE bapibname-bapibname.
    DATA: usr_data      TYPE qisrsuser_data. " bcsy_text.
    DATA: lv_email      TYPE adr6-smtp_addr.
    DATA: lx_root TYPE REF TO cx_root, lv_body TYPE string.
    DATA: lv_err_text   TYPE string.

    DATA(lo_email_api) = cl_smtg_email_api=>get_instance( iv_template_id = 'YZ_EMAIL_YB_TEMPLATE' )."Create instance of class
    "CL_SMTG_EMAIL_API.
    DATA(lo_bcs) = cl_bcs=>create_persistent( )."Create instance of class CL_BCS.

    IF iv_cr_number IS NOT INITIAL.
      CALL METHOD cl_usmd_crequest_api=>get_instance
        EXPORTING
          iv_crequest          = iv_cr_number
        IMPORTING
*         ET_MESSAGE           =
          re_inst_crequest_api = lo_crequest_api.

      CALL METHOD lo_crequest_api->read_crequest
        IMPORTING
          es_crequest = DATA(ls_crequest_head).

      lt_bank = VALUE #( ( name = 'crnumber'  value = iv_cr_number ) ).
      lo_email_api->render_bcs( io_bcs = lo_bcs iv_language = 'E' it_data_key = lt_bank ).
      DATA(lo_sender) = cl_sapuser_bcs=>create( sy-uname ).
      lo_bcs->set_sender( i_sender = lo_sender ).
      IF ls_crequest_head-usmd_created_by IS NOT INITIAL.
        lv_uname = ls_crequest_head-usmd_created_by.
        CALL FUNCTION 'ISR_GET_USER_DETAILS'
          EXPORTING
            id_user_id   = lv_uname
          CHANGING
            is_user_data = usr_data.
      ENDIF.
      lv_email = usr_data-e_mail.
      IF lv_email IS NOT INITIAL.
        TRY.
            " Set Email Receiver(s)
            DATA(lo_recipient_email) = cl_cam_address_bcs=>create_internet_address( lv_email ).
            lo_bcs->add_recipient( EXPORTING i_recipient = lo_recipient_email ).
            " Send Email
            lo_bcs->send( ).
*               CATCH cx_bcs_send INTO lx_bcs_send.
          CATCH cx_root INTO lx_root.
            lv_err_text = lx_root->get_text( ).
            MESSAGE lv_err_text TYPE 'E'.
        ENDTRY.
      ENDIF.
    ENDIF.

    CASE iv_service_name.
      WHEN 'YB_APPROVE'.

        IF ct_user_agent_group IS INITIAL.
          ls_user_agent_group-agent_group = '001'.
          ls_user_agent_group-step_type = 'Z'.
          ls_user_agent-user_type = 'SU'.
          ls_user_agent-user_value = 'INIT'.
          APPEND ls_user_agent TO ls_user_agent_group-user_agent.
          APPEND ls_user_agent_group TO ct_user_agent_group.
        ENDIF.



*        IF ct_user_agent_group IS NOT INITIAL. "Trasferring the control to system caller for Email Notification
*          non_agent-agent_group = '005'.
*          non_agent-process_pattern = '02'.
*          non_agent-service_name = 'YB_EMAIL'.
*          APPEND non_agent TO ct_non_user_agent_group.
*          cv_new_step = 'IA'.
*          cv_new_cr_status = 'IA'.
*        ENDIF.

      WHEN OTHERS.
    ENDCASE.



  ENDMETHOD.
ENDCLASS.
