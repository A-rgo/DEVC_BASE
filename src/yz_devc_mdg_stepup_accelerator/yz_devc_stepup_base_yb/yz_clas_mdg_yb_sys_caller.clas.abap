class YZ_CLAS_MDG_YB_SYS_CALLER definition
  public
  final
  create public .

public section.

  interfaces IF_BADI_INTERFACE .
  interfaces IF_USMD_SSW_SYST_METHOD_CALLER .
protected section.
private section.
ENDCLASS.



CLASS YZ_CLAS_MDG_YB_SYS_CALLER IMPLEMENTATION.


  METHOD if_usmd_ssw_syst_method_caller~call_system_method.
    CASE iv_service_name.
      WHEN 'YB_EMAIL'.
        TYPES : BEGIN OF ty_bank,
                  Name  TYPE String,
                  Value TYPE string,
                END OF ty_bank.

        DATA : lt_bank TYPE STANDARD TABLE OF ty_bank WITH EMPTY KEY,
               ls_bank LIKE LINE OF lt_bank.

        DATA(lo_email_api) = cl_smtg_email_api=>get_instance( iv_template_id = 'YZ_EMAIL_YB_TEMPLATE' )."Create instance of class
        "CL_SMTG_EMAIL_API.
        DATA(lo_bcs) = cl_bcs=>create_persistent( )."Create instance of class CL_BCS.

        IF iv_cr_number IS NOT INITIAL.
*          SELECT * FROM usmd1213 INTO TABLE @DATA(lt_usmd1213) WHERE usmd_crequest = @iv_cr_number.
*          IF sy-subrc = 0.
*            READ TABLE lt_usmd1213 INTO DATA(ls_usmd1213) INDEX  1.
*            IF  sy-subrc = 0.
              lt_bank = VALUE #( ( name = 'crnumber'  value = iv_cr_number ) ).
              lo_email_api->render_bcs( io_bcs = lo_bcs iv_language = 'E' it_data_key = lt_bank ).
*            ENDIF.

*          ENDIF.

          " Set Email Sender
          DATA(lo_sender) = cl_sapuser_bcs=>create( sy-uname ).
          lo_bcs->set_sender( i_sender = lo_sender ).

          DATA: lt_recipients TYPE TABLE OF swragent.
          DATA: lv_uname      TYPE bapibname-bapibname.
          DATA: usr_data      TYPE qisrsuser_data. " bcsy_text.
          DATA: lv_email      TYPE adr6-smtp_addr.
          DATA: lx_root TYPE REF TO cx_root, lv_body TYPE string.
          DATA: lv_err_text   TYPE string.
          DATA: lo_crequest_api TYPE REF TO if_usmd_crequest_api.
          CALL METHOD cl_usmd_crequest_api=>get_instance
            EXPORTING
              iv_crequest          = iv_cr_number
            IMPORTING
*             ET_MESSAGE           =
              re_inst_crequest_api = lo_crequest_api.

          CALL METHOD lo_crequest_api->read_crequest
            IMPORTING
              es_crequest = DATA(ls_crequest_head).

          "get WI based on CR
          CALL METHOD cl_usmd_wf_service=>get_cr_wis
            EXPORTING
              id_crequest          = iv_cr_number
*             it_top_wiid          =
              iv_translate_wi_text = abap_false
            IMPORTING
              et_workitem          = DATA(lt_workitem).

          IF lt_workitem IS NOT INITIAL.
            LOOP AT lt_workitem ASSIGNING FIELD-SYMBOL(<lfs_workitem>).
              CALL FUNCTION 'SAP_WAPI_WORKITEM_RECIPIENTS'
                EXPORTING
                  workitem_id = <lfs_workitem>-wi_id
                  language    = sy-langu
                TABLES
                  recipients  = lt_recipients.
            ENDLOOP.

            LOOP AT lt_recipients ASSIGNING FIELD-SYMBOL(<lfs_recipients>).
              IF <lfs_recipients> IS ASSIGNED AND <lfs_recipients> IS NOT INITIAL.
                lv_uname = <lfs_recipients>-objid.
                IF lv_uname IS NOT  INITIAL.
                  CALL FUNCTION 'ISR_GET_USER_DETAILS'
                    EXPORTING
                      id_user_id   = lv_uname "<lfs_user>-objid "iv_recipient
                    CHANGING
                      is_user_data = usr_data.
**                  EXCEPTIONS
**                    user_not_found = 1
**                    OTHERS         = 2.
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
            ENDLOOP.
          ENDIF.
        ENDIF.
      WHEN OTHERS.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.
