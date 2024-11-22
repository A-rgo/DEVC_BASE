class YZ_CLAS_RARE_BASE definition
  public
  final
  create public .

public section.

  interfaces IF_HTTP_EXTENSION .
  interfaces BI_OBJECT .
  interfaces BI_PERSISTENT .
  interfaces IF_WORKFLOW .

  types:
    BEGIN OF ty_multiple_screens_shots ,
        sequesnce     TYPE char03,
        mime_type_str TYPE string,
        image         TYPE xstring,
      END OF ty_multiple_screens_shots .
  types:
    tty_multiple_screens_shots TYPE STANDARD TABLE OF ty_multiple_screens_shots .
  types:
    BEGIN OF ty_instance ,
        guid     TYPE swxformabs-formnumber,
        instance TYPE REF TO yz_clas_rare_base,
      END   OF ty_instance .
  types:
    tty_instances TYPE STANDARD TABLE OF ty_instance .
  types:
    BEGIN OF tabl_message_details ,
        varkey    TYPE mepo_bal_context_db-varkey,
        objtyp    TYPE mepo_bal_context_db-objtyp,
        context   TYPE mmpur_context,
        metafield TYPE mmpur_metafield,
        msgty     LIKE sy-msgty,
        msgid     LIKE sy-msgid,
        msgno     LIKE sy-msgno,
        msgv1     LIKE sy-msgv1,
        msgv2     LIKE sy-msgv2,
        msgv3     LIKE sy-msgv3,
        msgv4     LIKE sy-msgv4,
        bo        TYPE REF TO if_message_obj_mm,
        msg_obj   TYPE REF TO cl_message_mm,
        sequence  TYPE i,
      END OF tabl_message_details .
  types:
    ttyp_message_details TYPE SORTED TABLE OF tabl_message_details
                                       WITH NON-UNIQUE KEY varkey objtyp context sequence .
  types:
    BEGIN OF ty_itbl,
        jobname   TYPE   tbtcp-jobname,
        jobcount  TYPE   tbtcp-jobcount,
        stepcount TYPE   i, "tbtcp-stepcount,
        sdldate   TYPE   tbtcp-sdldate,
        sdltime   TYPE   tbtcp-sdltime,
        sdluname  TYPE   tbtcp-sdluname,
        status    TYPE   tbtco-status,
      END OF ty_itbl .
  types:
    BEGIN OF ty_e070,
        objname TYPE e071-obj_name,
        trkorr  TYPE trkorr,
        as4user TYPE e070-as4user,
        as4date TYPE e070-as4date,
        as4time TYPE e070-as4time,
        strkorr TYPE e070-strkorr,
      END OF ty_e070 .
  types:
    BEGIN OF ty_buffer.
            INCLUDE TYPE ccm_rstune50_01_alv.
    TYPES: buffer(10) TYPE c,
           color      TYPE  slis_t_specialcol_alv,
           END OF ty_buffer .

  class-data CS_RARE_SEC type YZTABL_RARE_SEC .
  class-data CS_HELP_INFO type HELP_INFO .
  class-data:
    ct_rare_swch TYPE  STANDARD TABLE OF  yztabl_rare_swch .
  class-data CV_FULLPATH type STRING .
  class-data CV_FOLDER type STRING .
  class-data CV_FILE_NAME type STRING .
  class-data CV_DOCPARAMS type SFPDOCPARAMS .
  class-data CV_FUNCNAME type FUNCNAME .
  class-data CV_SMART_FUNCNAME type FUNCNAME .
  class-data CV_OUTPUTPARAMS type SFPOUTPUTPARAMS .
  class-data CV_TCODE_CHECK type FLAG .
*    CLASS-DATA cv_data TYPE xstring .
*    CLASS-DATA cv_pdf TYPE string .
* Global Counts For Headers
  class-data CV_ISSUE_HEADER_MSGCOUNT type INT3 .
  class-data CV_BASIC_HEADER_MSGCOUNT type INT3 .
  class-data CV_SESSION_HEADER_MSGCOUNT type INT3 .
  class-data CV_SYSTEM_HEADER_MSGCOUNT type INT3 .
  class-data CV_TECHNICAL_HEADER_MSGCOUNT type INT3 .
  class-data CV_CUSTOM_HEADER_MSGCOUNT type INT3 .
  class-data CV_MONITOR_HEADER_MSGCOUNT type INT3 .
  class-data CV_RCA_HEADER_MSGCOUNT type INT3 .
  class-data CV_CRITICAL_HEADER_MSGCOUNT type INT3 .
*Global Interface
  class-data CS_RARE_INTERFACE type YZTABL_RARE_INTERFACE .
  class-data CV_TCODE type SY-TCODE .
  class-data CO_RARE_BASE type ref to YZ_CLAS_RARE_BASE .
  constants CC_ACTION_LAUNCHED type CHAR02 value '01' ##NO_TEXT.
  constants CC_ACTION_CLOSED type CHAR02 value '07' ##NO_TEXT.
  constants CC_ACTION_DISPLAYED type CHAR02 value '02' ##NO_TEXT.
  constants CC_ACTION_DOWNLOADED type CHAR02 value '03' ##NO_TEXT.
  constants CC_ACTION_INCIDENT_SUCCESS type CHAR02 value '05' ##NO_TEXT.
  constants CC_ACTION_INCIDENT_ERROR type CHAR02 value '06' ##NO_TEXT.
  constants CC_ACTION_EMAILED type CHAR02 value '04' ##NO_TEXT.
  constants CC_ACTION_INCIDENT_RESUBMITED type CHAR02 value '09' ##NO_TEXT.
  constants CC_ACTION_INCIDENT_REQUESTED type CHAR02 value '08' ##NO_TEXT.
  class-data CV_RARE_ACTION type CHAR02 .
  class-data CV_GUID type SYSUUID_C32 .
  data CO_LPOR type SIBFLPOR .
  class-data CT_INSTANCES type TTY_INSTANCES .
  class-data CV_WORKFLOW_LAUNCHED type FLAG .
  class-data CV_WORKFLOW_CONTAINER_UPDATED type FLAG .
  class-data CS_FAILED_EXCEL_ATTACH type SFPATTACHMENTS .
  class-data CV_MOBILE_FLAG type XFELD .
  class-data CT_LINES type TLINET .
  class-data CT_MULTIPLE_SCREENS_SHOTS type TTY_MULTIPLE_SCREENS_SHOTS .
  class-data CV_MULTISCREEN_FLAG type FLAG .
  class-data CV_SCREEN_COUNT type CHAR03 .

  events START_WF
    exporting
      value(KEY) type SYSUUID_C32
      value(RARE_DATA) type YZTABL_RARE_INTERFACE optional
      value(RARE_ACTION) type CHAR02 .
  events UPDATE_WF_CONTAINER
    exporting
      value(KEY) type SYSUUID_C32
      value(RARE_DATA) type YZTABL_RARE_INTERFACE optional
      value(RARE_ACTION) type CHAR02 optional .
  events START_APPROVAL
    exporting
      value(KEY) type SYSUUID_C32 optional
      value(RARE_DATA) type YZTABL_RARE_INTERFACE optional
      value(RARE_ACTION) type CHAR02 optional
      value(RARE_HELP_INFO) type HELP_INFO optional .

  class-methods BIND_PDF_DATA
    returning
      value(RV_SUBRC) type SUBRC .
  class-methods CALL_METHODS .
  class-methods CHECK_ADS_CONNECTION
    returning
      value(EV_MSG) type STRING .
  class-methods CLASS_CONSTRUCTOR .
  class-methods CLEAR_ALL .
  class-methods CLOSE_PDF_JOB
    returning
      value(RV_SUBRC) type SUBRC .
  class-methods COLLECT_HEADER_DATA
    importing
      !IV_HEADER_TYPE type CHAR02 default 'IH'
      !IV_HEADER_MSG type STRING optional
      !IV_HEADER_CRITICALITY type CHAR01 default 'L' .
  class-methods COLLECT_MESG
    importing
      !IV_MSG type STRING optional .
  class-methods COLLECT_RCA_DATA
    importing
      !IV_MESG type STRING optional .
  class-methods COMMIT_WORK .
  class-methods CONNECT_SNOW_USING_REST_API
    importing
      !IS_RARE_INCI type YZTABL_RARE_INCI optional .
  class-methods CONNECT_SNOW
    importing
      !IS_RARE_INCI type YZTABL_RARE_INCI optional .
  methods CONSTRUCTOR
    importing
      !IV_GUID type SYSUUID_C32 optional .
  class-methods CREATE_TICKET .
  class-methods DOWNLOAD_PDF
    importing
      !IS_RARE_INCI type YZTABL_RARE_INCI optional .
  class-methods EXECUTE_RARE
    importing
      !IV_CALLING_TCODE type TCODE optional .
  class-methods GENERATE_GUID
    returning
      value(RV_GUID) type SYSUUID_C32 .
  class-methods GET_ADOBE_FUNCTION_MODULE_NAME
    returning
      value(RV_FUNCNAME) type FUNCNAME .
  class-methods GET_AL11_DATA
    importing
      !IV_DIRNAME type OCS_FILE-NAME optional
      !IV_FILENAME type OCS_FILE-NAME default '*' .
  class-methods GET_ASSOCIATED_FIELD_VAL_DATA .
  class-methods GET_ASSOCIATED_SCREEN_DATA .
  class-methods GET_AUTH_CHECK_DATA
    importing
      !IV_USER type XUBNAME default SY-UNAME .
  class-methods GET_BADI_DATA
    importing
      !IV_TCODE type TSTC-TCODE optional
    exporting
      !ET_BADI type YZ_TTYP_TADIR_BADI .
  class-methods GET_BUFFER_DATA .
  class-methods GET_CONFIG_DATA .
  class-methods GET_CONTAINER_DATA
    importing
      !IV_WI_ID type SWW_WIID optional
    exporting
      !ES_RARE_DATA type YZTABL_RARE_INTERFACE .
  class-methods GET_DB_PERFORMANCE_DATA .
  class-methods GET_DME_DATA .
  class-methods GET_DUMP_DATA
    importing
      !IV_DATE type SYDATUM optional .
  class-methods GET_FIREFIGHTER_DATA .
  class-methods GET_IDOC_DATA .
  class-methods GET_INBOUND_QUEUE_DATA .
  class-methods GET_INCIDENT_HISTORY_DATA .
  class-methods GET_JOB_DATA .
  class-methods GET_LATEST_RARE_STATUS
    returning
      value(RV_RARE_ACTION) type CHAR02 .
  class-methods GET_LOCK_DATA .
  class-methods GET_LOGGED_IN_USER_DATA .
  class-methods GET_LOGO .
  class-methods GET_MESSAGE_WHERE_USED_DATA
    importing
      !IS_MSG type BAL_S_MSG optional .
  class-methods GET_MODIFICATION_DATA
    exporting
      !ET_MOD_OBJECTS type TRDIR_IT .
  class-methods GET_NAST_DATA .
  class-methods GET_OUTBOUND_QUEUE_DATA .
  class-methods GET_PDF_FORM
    importing
      !IV_VIEW type FLAG optional
      !IS_RARE_INCI type YZTABL_RARE_INCI optional .
  class-methods GET_PREPARED_ATTACHMENT .
  class-methods GET_PRINTER_CONFIG_DATA .
  class-methods GET_PRINT_SCREEN_DATA .
  class-methods GET_PROXY_DATA .
  class-methods GET_RARE_INCIDENT_HEADER .
  class-methods GET_RFC_DEST_DATA .
  class-methods GET_ROOT_CAUSE_DATA .
  class-methods GET_SAPCONNECT_DATA .
  class-methods GET_SAP_SYSTEM_DATA .
  class-methods GET_SECURE_TCODE_DETAILS .
  class-methods GET_SNOTE_DATA .
  class-methods GET_SNOW_CAT_GRP_DETAILS
    returning
      value(RS_CATG) type YZTABL_RARE_CATG .
  class-methods GET_SPOOL_DATA .
  class-methods GET_STACK_DATA .
  class-methods GET_SWI1_INFO .
  class-methods GET_T20_DATA .
  class-methods GET_TAB_DETAILS .
  class-methods GET_TCODE_DATA
    importing
      !IV_TCODE type SYTCODE optional .
  class-methods GET_TNAPR_DATA .
  class-methods GET_TRANSPORT_DATA .
  class-methods GET_TRFC_STUCK_DATA .
  class-methods GET_UPDATE_TASK_DATA .
  class-methods GET_UPLOADED_FILE_DATA
    importing
      !DATA_TAB type ANY optional
      !FILENAME type STRING optional
      !FILETYPE type CHAR10 optional
      !FILELENGTH type I optional .
  class-methods GET_USER_CONFIG_DATA .
  class-methods GET_USER_DATA .
  class-methods GET_USER_EXIT_DATA
    importing
      !IV_TCODE type SY-TCODE optional
    exporting
      !ET_EXIT_DETAILS type YZ_TTYP_TADIR_BADI .
  class-methods GET_USER_SESSION_INFO .
  class-methods GET_WEB_SERVICE_DATA .
  class-methods GET_WORKFLOW_DATA .
  class-methods GET_WORKITEMID
    importing
      !IS_RARE_INCI type YZTABL_RARE_INCI optional
    returning
      value(RV_WI_ID) type SWW_WIID .
  class-methods GET_WP_DATA .
  class-methods GET_WP_TRACE .
  class-methods INIT
    importing
      !IV_CALLING_TCODE type TCODE optional .
  class-methods LAUNCH_POPUP_SCREEN
    importing
      !IS_RARE_INCI type YZTABL_RARE_INCI optional .
  class-methods LAUNCH_WORKFLOW .
  class-methods OPEN_FILE_SAVE_DIALOG
    returning
      value(RV_SUBRC) type SUBRC .
  class-methods OPEN_PDF_JOB
    returning
      value(RV_SUBRC) type SUBRC .
  class-methods POPUP_CONTROL
    importing
      !IS_RARE_INCI type YZTABL_RARE_INCI optional .
  class-methods PREPARE_SAVE_RARE_DATA .
  class-methods RAISE_WORKFLOW_EVENT
    importing
      !IV_EVENT type SIBFEVENT optional .
  class-methods RECOVER_PDF_FORM
    returning
      value(RV_SUBRC) type SUBRC .
  class-methods RETRY_PDF_FORM
    returning
      value(RV_SUBRC) type SUBRC .
  class-methods SAVE_WORKITEM .
  class-methods SEND_APPROVAL_EMAIL
    importing
      !RARE_DATA type YZTABL_RARE_INTERFACE optional .
  class-methods SEND_EMAIL_WITH_ATTACHMENT
    importing
      !SUBJECT type STRING optional .
  class-methods SEND_EXCEPTIONS
    importing
      !IT_EXCEPTIONS type CTS_STRINGS optional .
  class-methods SEND_RARE_ATTACHMENT
    importing
      !IS_RARE_INCI type YZTABL_RARE_INCI optional .
  class-methods SEND_REJECTION_EMAIL
    importing
      !IS_TICKET type YZTABL_RARE_INTERFACE-RARE_INCI optional
      !IV_KEY type CHAR32 optional
    exporting
      !EV_REJ_EMAIL_SENT type OS_BOOLEAN .
  class-methods SEND_TICKET_NUMBER
    importing
      !IS_TICKET type YZTABL_RARE_INCIDENTDETAILS optional
      !IV_KEY type CHAR32 optional
    exporting
      !EV_SUCCESS type OS_BOOLEAN .
  class-methods SET_CONTAINER_DATA
    importing
      !IV_WI_ID type SWW_WIID optional
    returning
      value(RV_RC) type SYSUBRC .
  class-methods SYNC_WORKITEM
    importing
      !IS_RARE_INCI type YZTABL_RARE_INCI optional
    returning
      value(RV_WI_ID) type SWW_WIID .
  class-methods CREATE_SOL_INC_WITH_ATTACH .
  class-methods GET_FAILED_EXCEL_ATTACHMENT .
  class-methods GET_SMARTFORM .
  class-methods GET_MULTIPLE_SCREEN_SHOTS .
  class-methods GET_MULTIPLE_IMAGES
    importing
      !P_TASK type CLIKE .
  class-methods CREATE_SERVICE_REQUEST
    importing
      !IV_CALLING_TCODE type TCODE optional .
  class-methods INIT_SR
    importing
      !IV_CALLING_TCODE type TCODE optional .
  class-methods GET_RARE_SERVICE_HEADER .
  class-methods CREATE_SERVICE .
  class-methods GET_SNOW_BASE_URL
    returning
      value(EV_BASE_URL) type STRING .
  class-methods GET_SNOW_URL_ATTACH_RESOURCE
    returning
      value(EV_RESOURCE) type STRING .
  class-methods GET_SNOW_URL_INCIDENT_RESOURCE
    returning
      value(EV_RESOURCE) type STRING .
  class-methods GET_SNOW_AUTH_DETAILS
    exporting
      !EV_USER_ID type STRING
      !EV_PASSWORD type STRING .
protected section.
private section.
ENDCLASS.



CLASS YZ_CLAS_RARE_BASE IMPLEMENTATION.


  METHOD bind_pdf_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Bind data to PDF form
*&---------------------------------------------------------------------*

    DATA: mo_oref_root TYPE REF TO cx_root,
          mv_text      TYPE string.

    DATA: mo_dyn_call_illegal_func    TYPE REF TO  cx_sy_dyn_call_illegal_func,
          mo_dyn_call_illegal_type    TYPE REF TO  cx_sy_dyn_call_illegal_type,
          mo_dyn_call_param_missing   TYPE REF TO  cx_sy_dyn_call_param_missing,
          mo_dyn_call_param_not_found TYPE REF TO  cx_sy_dyn_call_param_not_found.

    TRY.

        TRY.

            CALL METHOD cl_progress_indicator=>progress_indicate
              EXPORTING
                i_text               = 'Bind Data to PDF'(206)
                i_output_immediately = abap_true
                i_processed          = 2
                i_total              = 4.

            CALL FUNCTION cv_funcname "'/1BCDWB/SM00000397'
              EXPORTING
                /1bcdwb/docparams     = cv_docparams
**              IT_EDIDD              =
**              IS_EDIDC              =
                is_rare_screen_fields = cs_rare_interface-rare_screen_fields
                it_wpinfo             = cs_rare_interface-wpinfo
*               IT_NOTES              =
                it_uinfo              = cs_rare_interface-uinfo
*              IT_VERSNO_LIST        =
*              IS_CALLSTACK          =
*              IS_XSTRING            =
                it_infotab            = cs_rare_interface-infotab
                it_callstack          = cs_rare_interface-callstack
                it_qview              = cs_rare_interface-qview
                it_qtable             = cs_rare_interface-qtable
                it_cvers              = cs_rare_interface-cvers
                is_logo               = cs_rare_interface-logo
                is_logo_mime          = cs_rare_interface-logo_mime
                is_watermark          = cs_rare_interface-watermark
                is_watermark_mime     = cs_rare_interface-watermark_mime
                is_data               = cs_rare_interface-data       "Printscreen Data
                is_mime               = cs_rare_interface-mime
                it_enq                = cs_rare_interface-enq
                is_userinfo           = cs_rare_interface-userinfo "Suppressed due to warning in SFP
*                is_userinfo           = cs_rare_interface-userinfo "Suppressed due to warning in SFP
               it_roles              = cs_rare_interface-roles
               it_modes              = cs_rare_interface-modes
               is_session_info       = cs_rare_interface-session_info ""Suppressed due to warning in SFP
               it_component_all      = cs_rare_interface-component_all
               it_version_lists      = cs_rare_interface-version_lists
                it_userlist           = cs_rare_interface-userlist
               it_userparams         = cs_rare_interface-userparams
*               IT_USERPROFILES       = cs_rare_interface-
               is_logon              = cs_rare_interface-logon
                iv_rqident            = cs_rare_interface-rqident
                it_spool_buffer       = cs_rare_interface-spool_buffer
                is_printer_info       = cs_rare_interface-printer_info
                it_st04               = cs_rare_interface-st04
                it_mod_object         = cs_rare_interface-mod_object     "Suppressed due to warning in SFP
                it_sm58               = cs_rare_interface-sm58
               it_sm37_log           = cs_rare_interface-sm37_log
                it_sp01               = cs_rare_interface-sp01
                it_al11               = cs_rare_interface-al11
                it_sost               = cs_rare_interface-sost           "Suppressed due to warning in SFP
                is_tcode_data         = cs_rare_interface-tcode_data
                it_msg_info           = cs_rare_interface-msg_info
               it_badi               = cs_rare_interface-badi            "Suppressed due to warning in SFP
*              IT_DATA_TAB           =
                it_exit_details       = cs_rare_interface-exit_details
                it_config_data        = cs_rare_interface-config_data
                it_fields             = cs_rare_interface-fields
                it_rca                = cs_rare_interface-rca
                it_client_job         = cs_rare_interface-client_jobs
                it_issue_header       = cs_rare_interface-issue_header
                it_basic_header       = cs_rare_interface-basic_header
                it_session_header     = cs_rare_interface-session_header
                it_system_header      = cs_rare_interface-system_header
                it_technical_header   = cs_rare_interface-technical_header
                it_custom_obj_header  = cs_rare_interface-custom_obj_header
                it_monitor_log_header = cs_rare_interface-monitor_log_header
                it_rca_header         = cs_rare_interface-rca_header
                it_d010tab            = cs_rare_interface-d010tab
                it_swi1_info          = cs_rare_interface-swi1_info
                it_su53_info          = cs_rare_interface-su53_info
                is_syst               = cs_rare_interface-syst
                it_msg_whereused      = cs_rare_interface-msg_whereused
                it_t20_data           = cs_rare_interface-t20_data
                it_printer_info       = cs_rare_interface-printer_info
                it_buffer_st02        = cs_rare_interface-buffer_st02
                it_idoc_info_inbound  = cs_rare_interface-idoc_info_inbound
                it_idoc_info_outbound = cs_rare_interface-idoc_info_outbound
                is_rare_inci          = cs_rare_interface-rare_inci "Suppressed due to warning in SFP
                iv_mobile             = cv_mobile_flag
              IMPORTING
                /1bcdwb/formoutput    = cs_rare_interface-xstring
              EXCEPTIONS
                usage_error           = 1
                system_error          = 2
                internal_error        = 3
                OTHERS                = 4.

            rv_subrc = sy-subrc.

          CATCH cx_sy_dyn_call_illegal_func INTO mo_dyn_call_illegal_func.
            mv_text =  mo_dyn_call_illegal_func->get_text( ).
            APPEND mv_text TO cs_rare_interface-exceptions.
            collect_mesg( mv_text ).
            CLEAR mv_text.
            rv_subrc = 8.

          CATCH cx_sy_dyn_call_illegal_type INTO mo_dyn_call_illegal_type.
            mv_text =  mo_dyn_call_illegal_type->get_text( ).
            APPEND mv_text TO cs_rare_interface-exceptions.
            collect_mesg( mv_text ).
            CLEAR mv_text.
            rv_subrc = 8.


          CATCH cx_sy_dyn_call_param_missing INTO mo_dyn_call_param_missing.
            mv_text =  mo_dyn_call_param_missing->get_text( ).
            APPEND mv_text TO cs_rare_interface-exceptions.
            collect_mesg( mv_text ).
            CLEAR mv_text.
            rv_subrc = 8.


          CATCH cx_sy_dyn_call_param_not_found INTO mo_dyn_call_param_not_found.
            mv_text =  mo_dyn_call_param_not_found->get_text( ).
            APPEND mv_text TO cs_rare_interface-exceptions.
            collect_mesg( mv_text ).
            CLEAR mv_text.
            rv_subrc = 8.

        ENDTRY.



        IF cs_rare_interface-xstring IS INITIAL.
          CASE  rv_subrc.

            WHEN 1.
              mv_text = 'usage_error exception is catched while calling cv_funcname in BIND_PDF_DATA'(189).
              APPEND mv_text TO cs_rare_interface-exceptions.

            WHEN 2.
              mv_text = 'system_error exception is catched while calling cv_funcname in BIND_PDF_DATA'(190).
              APPEND mv_text TO cs_rare_interface-exceptions.

            WHEN 3.
              mv_text = 'internal_error  exception is catched while calling cv_funcname in BIND_PDF_DATA'(191).
              APPEND mv_text TO cs_rare_interface-exceptions.

            WHEN 4.
              mv_text = 'other exception is catched while calling cv_funcname in BIND_PDF_DATA'(192).
              APPEND mv_text TO cs_rare_interface-exceptions.

            WHEN 8.
              mv_text = 'Exception cx_sy_dyn_call_error caught in method BIND_PDF_DATA'(193).
              APPEND mv_text TO cs_rare_interface-exceptions.

          ENDCASE.

          collect_mesg( mv_text ).
          CLEAR mv_text.

          "To Get Error From ADOBE
          CALL FUNCTION 'FP_GET_LAST_ADS_ERRSTR'
            IMPORTING
              e_adserrstr = mv_text.

          collect_mesg( mv_text ).
          CLEAR mv_text.

        ENDIF.

        "Call get uploaded file data to get failed excel attachment in generated PDF only if check box is ticked
        IF cs_failed_excel_attach-data IS NOT INITIAL AND cs_rare_interface-rare_inci-data_file = abap_true .
          get_failed_excel_attachment( ).
        ENDIF.
        "end

      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
        rv_subrc = 8.
    ENDTRY.

  ENDMETHOD.


  METHOD bi_object~default_attribute_value ##NEEDED.
  ENDMETHOD.


  METHOD bi_object~execute_default_method ##NEEDED.
  ENDMETHOD.


  METHOD bi_object~release ##NEEDED.
  ENDMETHOD.


  METHOD bi_persistent~find_by_lpor.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Object creation
*&---------------------------------------------------------------------*

    DATA: mo_oref_root TYPE REF TO cx_root,
          mv_text      TYPE string.

*- BEGIN OF LOCAL DATA
    DATA: mo_rare_base   TYPE REF TO yz_clas_rare_base.
    DATA: mv_guid        TYPE swxformabs-formnumber.
    DATA: ms_instance    TYPE ty_instance.
    DATA: mv_typename     TYPE seoclsname.
*- end   of local data

    TRY.

*        mv_guid = lpor-instid.
*        CREATE OBJECT result TYPE yz_clas_rare_base
*          EXPORTING
*            iv_guid = mv_guid.    " 16 Byte UUID in 32 Characters (Hexadecimal Encoded)

        CHECK lpor-instid IS NOT INITIAL.

*- set typename
        IF lpor-typeid IS INITIAL.
          mv_typename = 'YZ_CLAS_RARE_BASE'.
        ELSE.
          mv_typename = lpor-typeid.
        ENDIF.

*- instid is the key of the object
        mv_guid = lpor-instid.

        READ TABLE ct_instances WITH KEY guid = mv_guid INTO ms_instance.

        IF sy-subrc <> 0.

          TRY.
              CREATE OBJECT mo_rare_base TYPE (mv_typename)
              EXPORTING
                iv_guid = mv_guid.

              mo_rare_base->co_lpor-typeid = mv_typename.
            CATCH cx_bo_error .
*------ object not found
              EXIT.
          ENDTRY.

          ms_instance-guid   = mv_guid.
          ms_instance-instance = mo_rare_base.
          APPEND ms_instance TO ct_instances.

        ENDIF.

        result = ms_instance-instance.


      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.
  ENDMETHOD.


  METHOD bi_persistent~lpor ##NEEDED.

    result = me->co_lpor.

  ENDMETHOD.


  METHOD bi_persistent~refresh ##NEEDED.
  ENDMETHOD.


  METHOD call_methods.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Calls all methods of the class
*&---------------------------------------------------------------------*

    DATA: mt_methodlist TYPE STANDARD TABLE OF yztabl_rare_exe,
          ms_methodlist TYPE yztabl_rare_exe.

    DATA: mo_oref_root TYPE REF TO cx_root,
          mv_text      TYPE string.

    DATA: mv_tabix TYPE sy-tabix,
          mv_total TYPE sy-tabix.

    DATA:
          exc_ref TYPE REF TO cx_sy_dyn_call_error.

    DATA: oref_excp_not_found  TYPE REF TO cx_sy_dyn_call_excp_not_found,
          oref_illegal_class   TYPE REF TO cx_sy_dyn_call_illegal_class,
          oref_illegal_method  TYPE REF TO cx_sy_dyn_call_illegal_method,
          oref_illegal_type    TYPE REF TO cx_sy_dyn_call_illegal_type,
          oref_param_missing   TYPE REF TO cx_sy_dyn_call_param_missing,
          oref_param_not_found TYPE REF TO cx_sy_dyn_call_param_not_found,
          oref_ref_is_initial  TYPE REF TO cx_sy_ref_is_initial.

    TRY.

*EXTRACT ALL METHOD LIST
        SELECT *                                        "#EC CI_NOFIELD
          FROM yztabl_rare_exe
    INTO TABLE mt_methodlist
         WHERE active = 'X'.                            "#EC CI_NOFIELD

        IF sy-subrc = 0.

          SORT mt_methodlist BY section_id ASCENDING.

          mv_total = lines( mt_methodlist ).

          LOOP AT  mt_methodlist INTO ms_methodlist.

            mv_tabix = mv_tabix + 1.

            IF mv_tabix <> 1.
              "To Skip progress bar message to override error message
              TRY.
                  CALL METHOD cl_progress_indicator=>progress_indicate
                    EXPORTING
                      i_text               = ms_methodlist-description
                      i_output_immediately = abap_true
                      i_processed          = mv_tabix
                      i_total              = mv_total.

                CATCH cx_root INTO mo_oref_root.
                  mv_text = mo_oref_root->get_text( ) .
                  APPEND mv_text TO cs_rare_interface-exceptions.
                  collect_mesg( mv_text ).
                  CLEAR mv_text.

              ENDTRY.
            ENDIF.

* call method dynamically.
            TRY.
                CALL METHOD (ms_methodlist-method).

              CATCH cx_sy_dyn_call_excp_not_found INTO oref_excp_not_found.
                mv_text = oref_excp_not_found->get_text( ).
                APPEND mv_text TO cs_rare_interface-exceptions.
                collect_mesg( mv_text ).
                CLEAR mv_text.

              CATCH cx_sy_dyn_call_illegal_class INTO oref_illegal_class.
                mv_text = oref_illegal_class->get_text( ).
                APPEND mv_text TO cs_rare_interface-exceptions.
                collect_mesg( mv_text ).
                CLEAR mv_text.

              CATCH cx_sy_dyn_call_illegal_method INTO oref_illegal_method.
                mv_text = oref_illegal_method->get_text( ).
                APPEND mv_text TO cs_rare_interface-exceptions.
                collect_mesg( mv_text ).
                CLEAR mv_text.

              CATCH cx_sy_dyn_call_illegal_type INTO oref_illegal_type.
                mv_text = oref_illegal_type->get_text( ).
                APPEND mv_text TO cs_rare_interface-exceptions.
                collect_mesg( mv_text ).
                CLEAR mv_text.

              CATCH cx_sy_dyn_call_param_missing INTO oref_param_missing.
                mv_text = oref_param_missing->get_text( ).
                APPEND mv_text TO cs_rare_interface-exceptions.
                collect_mesg( mv_text ).
                CLEAR mv_text.

              CATCH cx_sy_dyn_call_param_not_found INTO oref_param_not_found.
                mv_text = oref_param_not_found->get_text( ).
                APPEND mv_text TO cs_rare_interface-exceptions.
                collect_mesg( mv_text ).
                CLEAR mv_text.

              CATCH cx_sy_ref_is_initial INTO oref_ref_is_initial.
                mv_text = oref_ref_is_initial->get_text( ).
                APPEND mv_text TO cs_rare_interface-exceptions.
                collect_mesg( mv_text ).
                CLEAR mv_text.

              CATCH cx_sy_dyn_call_error INTO exc_ref.
                mv_text = exc_ref->get_text( ) .
                APPEND mv_text TO cs_rare_interface-exceptions.
                collect_mesg( mv_text ).
                CLEAR mv_text.

              CATCH cx_root INTO mo_oref_root.
                mv_text = mo_oref_root->get_text( ).
                APPEND mv_text TO cs_rare_interface-exceptions.
                collect_mesg( mv_text ).
                CLEAR mv_text.
            ENDTRY.

          ENDLOOP.

        ENDIF.

      CATCH cx_root INTO mo_oref_root.
        mv_text = mo_oref_root->get_text( ) .
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.

    ENDTRY.

  ENDMETHOD.


  METHOD check_ads_connection.


     DATA : mo_oref_root TYPE REF TO cx_root,
            mv_text      TYPE string.

    DATA: fm_name           TYPE rs38l_fnam,
          fp_docparams      TYPE sfpdocparams,
          fp_outputparams   TYPE sfpoutputparams,
          itf               TYPE tsftext,
          itf_line          TYPE tline,
          itf_line_pattern1 TYPE tdline VALUE 'Line % on page #', "#EC NOTEXT
          itf_line_pattern2 TYPE tdline,
          page_nr           TYPE string,
          line_nr           TYPE string,
          result            TYPE sfpjoboutput,
          l_spoolid         TYPE rspoid.

    data : mv_conn   TYPE rfcdest      value 'ADS',
           mv_form   TYPE fpwbformname value 'FP_TEST_00',
           mv_langu  TYPE spras        value 'D',
           mv_countr TYPE land1        value 'DE',
           mv_pages  TYPE fppagecount  value 2,
           mv_loop   TYPE i            value 1.

      DATA: ms_sfpdocparams TYPE  sfpdocparams,
            mv_msg type EMG_MSGV1,
            mv_msg_type type EMG_MSGV1.


DATA: ms_params TYPE sfpoutputparams.
 CONSTANTS:    mc_ads        TYPE rfcdest VALUE 'ADS',
               mc_adstrlevel TYPE fpadstrl VALUE '00',
               mc_device     TYPE fpmedium VALUE 'LP01'.

                 ms_params-device =  'PRINTER'.
                 ms_params-nodialog = abap_true.
                 ms_params-preview  = abap_true.
                 ms_params-getpdf   = abap_true.
                 ms_params-connection = mc_ads.
                 ms_params-adstrlevel = mc_adstrlevel.
                 ms_params-dest = 'LP01'.


try.
    MOVE cl_fp=>get_ads_connection( ) TO mv_conn.
    DO mv_pages TIMES.
      page_nr = sy-index.
      itf_line_pattern2 = itf_line_pattern1.
      REPLACE '#' IN itf_line_pattern2 WITH page_nr IN CHARACTER MODE.
      DO 15 TIMES.
        line_nr = sy-index.
        itf_line-tdline = itf_line_pattern2.
        REPLACE '%' IN itf_line-tdline WITH line_nr IN CHARACTER MODE.
        APPEND itf_line TO itf.
      ENDDO.
    ENDDO.


    CALL FUNCTION 'FP_JOB_OPEN'
      CHANGING
        ie_outputparams = ms_params
      EXCEPTIONS
        cancel          = 1
        usage_error     = 2
        system_error    = 3
        internal_error  = 4
        OTHERS          = 5.

if sy-subrc = 0.


    ms_sfpdocparams-langu = 'D'.
    CALL FUNCTION '/1BCDWB/SM00000001'
      EXPORTING
        /1bcdwb/docparams = ms_sfpdocparams
        textlines         = itf.

if sy-MSGTY = 'E'.
ev_msg = sy-MSGV1.
ENDIF.

else.

     CASE sy-subrc.
           WHEN 1.
              mv_text  = 'cancel  while exception is captured calling FP_JOB_OPEN in CHECK_ADS_CONNECTION method'.
              APPEND mv_text TO cs_rare_interface-exceptions.

            WHEN 2.
              mv_text  = 'usage_error  exception is captured calling FP_JOB_OPEN in CHECK_ADS_CONNECTION method'.
              APPEND mv_text TO cs_rare_interface-exceptions.

            WHEN 3.
              mv_text  = 'system_error exception is captured calling FP_JOB_OPEN in CHECK_ADS_CONNECTION method'.
              APPEND mv_text TO cs_rare_interface-exceptions.

            WHEN 4.
              mv_text  = ' internal_error exception is captured  while calling FP_JOB_OPEN in CHECK_ADS_CONNECTION method '.
              APPEND mv_text TO cs_rare_interface-exceptions.

            WHEN 5.
              mv_text  =  'OTHERS  exception is captured while calling FP_JOB_OPEN in CHECK_ADS_CONNECTION method '.
              APPEND mv_text TO cs_rare_interface-exceptions.

          ENDCASE.
endif.


      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.


  ENDMETHOD.


  METHOD class_constructor.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Default Method To be called
*&---------------------------------------------------------------------*
*Declaration
    DATA: mo_oref_root TYPE REF TO cx_root,
          mv_text      TYPE string.

    TRY.

*You Need to Fetch data from YZTABL_RARE_SWCH table to get constant value like TO_EMAIL_FOR_EXCEPTION
        SELECT *
          FROM yztabl_rare_swch
    INTO TABLE ct_rare_swch
         WHERE active = abap_true.

      CATCH cx_root INTO mo_oref_root.
        mv_text = mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.

  ENDMETHOD.


  METHOD clear_all.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team Innovation and Automation Team
*&Transport request :
*&Description       : Initialize all Variable
*&---------------------------------------------------------------------*

    DATA : mo_oref_root TYPE REF TO cx_root,
           mv_text      TYPE string.

    TRY.
        CLEAR   :   cs_rare_interface-xstring,
                    cs_rare_interface-mime,
                    cs_rare_interface-data,
                    cs_rare_interface-userinfo ,
                    cs_rare_interface-session_info,
                    cs_rare_interface-edidc,
                    cs_rare_interface-printer_info,
                    cs_rare_interface-rare_screen_fields,
                    cs_rare_interface-pdf,
                    cs_rare_interface-logon,
                    cs_rare_interface-tcode_data,
                    cs_rare_interface-logo,
                    cs_rare_interface-logo_mime,
                    cs_rare_interface-watermark,
                    cs_rare_interface-watermark_mime,
                    cs_rare_interface-syst,
                    cs_rare_interface-rare_inci.

        REFRESH :
*                    cs_rare_interface-abapstack[],
*                    cs_rare_interface-callstack[],
*                    cs_rare_interface-infotab[],
*                    cs_rare_interface-callstack[],
*                    cs_rare_interface-screen[],
*                    cs_rare_interface-msg_whereused[],
*                    cs_rare_interface-rca[],

                    cs_rare_interface-enq[],
                    cs_rare_interface-cvers[],
                    cs_rare_interface-component_all[],
                    cs_rare_interface-qtable[],
                    cs_rare_interface-qview[],
                    cs_rare_interface-version_lists[],
                    cs_rare_interface-versno_list[],
                    cs_rare_interface-uinfo[],
                    cs_rare_interface-userlist[],
                    cs_rare_interface-notes[],
*                    cs_rare_interface-wpinfo[],
                    cs_rare_interface-modes[],
                    cs_rare_interface-message_details[],
                    cs_rare_interface-edidd[],
                    cs_rare_interface-spool_buffer[],
                    cs_rare_interface-profiles[],
                    cs_rare_interface-userparams[],
                    cs_rare_interface-su53_info[],
                    cs_rare_interface-sost[],
                    cs_rare_interface-exceptions[],
                    cs_rare_interface-sm37_log[],
                    cs_rare_interface-st04[],
                    cs_rare_interface-sp01[],
                    cs_rare_interface-sm58[],
*                    cs_rare_interface-buffer[],
                    cs_rare_interface-al11[],
                    cs_rare_interface-mod_object[],
                    cs_rare_interface-config_data[],
                    cs_rare_interface-fields[],
                    cs_rare_interface-exit_details[],
                    cs_rare_interface-badi[],
                    cs_rare_interface-msg_info[],
                    cs_rare_interface-idoc_info_outbound[],
                    cs_rare_interface-idoc_info_inbound[],
                    cs_rare_interface-client_jobs[],
                    cs_rare_interface-abap_objects[],
                    cs_rare_interface-d010tab[],

                    cs_rare_interface-swi1_info[],
                    cs_rare_interface-issue_header[],
                    cs_rare_interface-basic_header[],
                    cs_rare_interface-session_header[],
                    cs_rare_interface-system_header[],
                    cs_rare_interface-technical_header[],
                    cs_rare_interface-custom_obj_header[],
                    cs_rare_interface-monitor_log_header[],
                    cs_rare_interface-rca_header[],
                    cs_rare_interface-critical_header[],
                    cs_rare_interface-t20_data[].


      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.
  ENDMETHOD.


  METHOD close_pdf_job.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Display PDF form - Close pdf Job
*&---------------------------------------------------------------------*

    DATA: mo_oref_root TYPE REF TO cx_root,
          mv_text      TYPE string.
    TRY.

        CALL METHOD cl_progress_indicator=>progress_indicate
          EXPORTING
            i_text               = 'Close PDF form with Optimization'(205)
            i_output_immediately = abap_true
            i_processed          = 1
            i_total              = 4.

        CALL FUNCTION 'FP_JOB_CLOSE'
          EXCEPTIONS
            usage_error    = 1
            system_error   = 2
            internal_error = 3
            OTHERS         = 4.

        rv_subrc = sy-subrc.

        IF rv_subrc <> 0.
          CASE rv_subrc.
            WHEN 1.
              mv_text = 'usage_error exception is catched while calling FP_JOB_CLOSE in CLOSE_PDF_JOB'(185).
              APPEND mv_text TO cs_rare_interface-exceptions.

            WHEN 2.
              mv_text = 'system_error exception is catched while calling FP_JOB_CLOSE in CLOSE_PDF_JOB'(186).
              APPEND mv_text TO cs_rare_interface-exceptions.

            WHEN 3.
              mv_text = 'internal_error  exception is catched while calling FP_JOB_CLOSE in CLOSE_PDF_JOB'(187).
              APPEND mv_text TO cs_rare_interface-exceptions.

            WHEN 4.
              mv_text = 'other exception is catched while calling FP_JOB_CLOSE in CLOSE_PDF_JOB'(188).
              APPEND mv_text TO cs_rare_interface-exceptions.

          ENDCASE.
          collect_mesg( mv_text ).
          CLEAR mv_text.
        ENDIF.

      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.

  ENDMETHOD.


  METHOD collect_header_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Collect header data
*&---------------------------------------------------------------------*
*Declaration
    DATA: mo_oref_root TYPE REF TO cx_root,
          mv_text      TYPE string.

    DATA: ms_header    TYPE yztabl_header_details.

    TRY.
*Decide and assign criticality
        CASE iv_header_criticality.
          WHEN 'L'.
            ms_header-criticality = 'LOW'.
          WHEN 'M'.
            ms_header-criticality = 'MEDIUM'.
          WHEN 'H'.
            ms_header-criticality = 'HIGH'.
        ENDCASE.

*Common for all header
        ms_header-message       = iv_header_msg.

        CASE iv_header_type.

*Issue Header
          WHEN 'IH'.
            cv_issue_header_msgcount = cv_issue_header_msgcount + 1.
            ms_header-serial_number  = cv_issue_header_msgcount.

            APPEND ms_header TO cs_rare_interface-issue_header.
            CLEAR :  mv_text ,ms_header.

*Basic Header
          WHEN 'BH'.
            cv_basic_header_msgcount = cv_basic_header_msgcount + 1.
            ms_header-serial_number  = cv_basic_header_msgcount.

            APPEND ms_header TO cs_rare_interface-basic_header.
            CLEAR :  mv_text ,ms_header.

*Session Header
          WHEN 'SH'.
            cv_session_header_msgcount = cv_session_header_msgcount + 1.
            ms_header-serial_number  = cv_session_header_msgcount.

            APPEND ms_header TO cs_rare_interface-session_header.
            CLEAR :  mv_text ,ms_header.

*System Info Header
          WHEN 'YH'.
            cv_system_header_msgcount = cv_system_header_msgcount + 1.
            ms_header-serial_number  = cv_system_header_msgcount.

            APPEND ms_header TO cs_rare_interface-system_header.
            CLEAR :  mv_text ,ms_header.

*Techi Header
          WHEN 'TH'.
            cv_technical_header_msgcount = cv_technical_header_msgcount + 1.
            ms_header-serial_number  = cv_technical_header_msgcount.

            APPEND ms_header TO cs_rare_interface-technical_header.
            CLEAR :  mv_text ,ms_header.

*Custom Header
          WHEN 'CH'.
            cv_custom_header_msgcount = cv_custom_header_msgcount + 1.
            ms_header-serial_number  = cv_custom_header_msgcount.

            APPEND ms_header TO cs_rare_interface-custom_obj_header.
            CLEAR :  mv_text ,ms_header.

*Monitor Header
          WHEN 'MH'.
            cv_monitor_header_msgcount = cv_monitor_header_msgcount + 1.
            ms_header-serial_number  = cv_monitor_header_msgcount.

            APPEND ms_header TO cs_rare_interface-monitor_log_header.
            CLEAR :  mv_text ,ms_header.

        ENDCASE.


      CATCH cx_root INTO mo_oref_root.
        mv_text = mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.

  ENDMETHOD.


  METHOD collect_mesg.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Collects all messages
*&---------------------------------------------------------------------*

    DATA :
      ms_msg_collect_info TYPE yztabl_msg_collect_info,
      mo_oref_root        TYPE REF TO cx_root,
      mv_text             TYPE string.

    DATA:
      mt_text     TYPE STANDARD TABLE OF bapitgb,
      mv_full_msg TYPE bapiret2-message,
      ms_return   TYPE bapiret2 ##NEEDED.

    TRY.


        IF sy-msgid IS NOT INITIAL AND sy-msgno IS NOT INITIAL.
          CALL FUNCTION 'BAPI_MESSAGE_GETDETAIL'
            EXPORTING
              id                    = sy-msgid
              number                = sy-msgno
*             language              = sy-langu
              textformat            = 'NON'
              message_v1            = sy-msgv1
              message_v2            = sy-msgv2
              message_v3            = sy-msgv3
              message_v4            = sy-msgv4
            IMPORTING
              message               = mv_full_msg
              return                = ms_return
            TABLES
              text                  = mt_text
            EXCEPTIONS
              communication_failure = 1
              system_failure        = 2.
        ENDIF.

        IF mv_full_msg IS NOT INITIAL.
          ms_msg_collect_info-meth_name = 'SYSTEM_MESSAGE'.
          ms_msg_collect_info-type      = sy-msgty.
          ms_msg_collect_info-message   = mv_full_msg.
          APPEND ms_msg_collect_info TO cs_rare_interface-msg_info.
          APPEND ms_msg_collect_info TO cs_rare_interface-exceptions.

        ENDIF.


        IF iv_msg IS NOT INITIAL.
          ms_msg_collect_info-meth_name = 'CALL_METHOD'.
          ms_msg_collect_info-type      = 'W'.
          ms_msg_collect_info-message   = iv_msg.
          APPEND ms_msg_collect_info         TO cs_rare_interface-msg_info.
          APPEND ms_msg_collect_info-message TO cs_rare_interface-exceptions.
        ENDIF.


      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.

  ENDMETHOD.


  METHOD collect_rca_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Collect Root Cause Analysis Information
*&---------------------------------------------------------------------*
*Declaration
    DATA: mo_oref_root TYPE REF TO cx_root,
          mv_text      TYPE string,
          ms_rca       LIKE LINE OF cs_rare_interface-rca.

    TRY.

        IF iv_mesg IS NOT INITIAL.
          GET TIME STAMP FIELD ms_rca-timestamp.
          ms_rca-user   = sy-uname.
          ms_rca-action = iv_mesg.
          APPEND ms_rca TO cs_rare_interface-rca.
          SORT cs_rare_interface-rca BY action.
          DELETE ADJACENT DUPLICATES FROM cs_rare_interface-rca COMPARING action.
          SORT cs_rare_interface-rca BY timestamp.
        ENDIF.

      CATCH cx_root INTO mo_oref_root.
        mv_text = mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.

  ENDMETHOD.


  METHOD commit_work.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Commit Work
*&---------------------------------------------------------------------*
*Declaration
    DATA :
      mo_oref_root TYPE REF TO cx_root,
      mv_text      TYPE string.

    TRY.

        CALL FUNCTION 'DB_COMMIT'.
        CALL METHOD cl_os_transaction_end_notifier=>raise_commit_requested.

      CATCH cx_root INTO mo_oref_root.
        mv_text = mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.

  ENDMETHOD.


  METHOD connect_snow.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Connects Service now
*&---------------------------------------------------------------------*

    TYPES: string_table TYPE STANDARD TABLE OF string WITH DEFAULT KEY .

    DATA: mo_oref_root                TYPE REF TO cx_root,
          mv_text                     TYPE string,
          mo_oref_create_object_error TYPE REF TO cx_sy_create_object_error,
          mo_oref_name                TYPE seoclname             VALUE 'ZCO_SERVICE_NOW_SOAP',
          mo_lp_soap                  TYPE prx_logical_port_name VALUE 'ZLP_SERVICE_NOW_SOAP',
          mo_oref_rare                TYPE REF TO zco_service_now_soap,
          ms_rare_out                 TYPE zinsert_soap_in,
          mv_rare_out_type            TYPE typename              VALUE 'ZINSERT_SOAP_IN',
          mv_rare_in_type             TYPE typename              VALUE 'ZINSERT_SOAP_OUT',
          ms_rare_in                  TYPE zinsert_soap_out
          .



    TRY.

*Checking the call - Internal or External
        IF is_rare_inci IS SUPPLIED.
          IF is_rare_inci IS NOT INITIAL.
            CLEAR cs_rare_interface.
            get_container_data( EXPORTING iv_wi_id     = sync_workitem( is_rare_inci )
                                IMPORTING es_rare_data = cs_rare_interface ).
          ENDIF.
        ENDIF.

        IF cs_rare_interface-rare_inci-inc_no IS INITIAL.

          CALL METHOD cl_progress_indicator=>progress_indicate
            EXPORTING
              i_text               = 'Creating incident in ServiceNow'(002)
              i_output_immediately = abap_true.

*Assigning Values
          ms_rare_out-u_attachment1          = cs_rare_interface-pdf.
          ms_rare_out-u_attahcment1_name     = 'Incident_info.pdf'(003).
*         ms_rare_out-u_attachment2_data     = ''.
*         ms_rare_out-u_attachment2_name     = ''.
          ms_rare_out-u_caller               = sy-uname.
          ms_rare_out-u_category             = 'SAP applications'(004).
*          ms_rare_out-subcategory           = 'SAP General'(005).
          ms_rare_out-u_description          = cs_rare_interface-rare_inci-long_description.
          ms_rare_out-u_short_description    = cs_rare_interface-rare_inci-short_description.
          ms_rare_out-u_urgency              = cs_rare_interface-rare_inci-urgency.
          ms_rare_out-u_impact               = cs_rare_interface-rare_inci-impact.
*
*          IF ms_rare_out-urgency IS INITIAL.
*            ms_rare_out-urgency = cs_rare_interface-rare_inci-urgency = '2'.
*          ENDIF.
*
*          IF ms_rare_out-impact  IS INITIAL.
*            ms_rare_out-urgency = cs_rare_interface-rare_inci-impact  = '3'.
*          ENDIF.

          ms_rare_out-u_assigned_to          = cs_rare_interface-snow_cat_grp_details-assignment_grp.
*          ms_rare_out-u_sub_category         = cs_rare_interface-snow_cat_grp_details-sub_category.

          TRY.


              CREATE OBJECT mo_oref_rare
                EXPORTING
                  logical_port_name = mo_lp_soap.

              TRY.
                  mo_oref_rare->insert(
                    EXPORTING
                      input  = ms_rare_out
                    IMPORTING
                      output = ms_rare_in
                  ).
                CATCH cx_ai_system_fault INTO DATA(o_exp). " Communication Error
                  DATA(exp_txt) = o_exp->get_longtext( ).
              ENDTRY.


              DATA(lv_xml_req) = cl_proxy_xml_transform=>abap_to_xml_xstring( EXPORTING abap_data = ms_rare_out ddic_type = mv_rare_out_type ).

              DATA(lr_proxy) = cl_proxy_gen_clnt_factory=>create_proxy_for_class(
                                             class_name = mo_oref_name
                                      logical_port_name = mo_lp_soap ).

              TRY.
                  DATA(lv_xml_res) = lr_proxy->execute_xml_xstring( request = lv_xml_req ).
                CATCH cx_ai_xml_application_fault INTO DATA(lr_xml_fault).
                  DATA(lv_error_data) = lr_xml_fault->xml.
                  DATA(exception_class_name) = lr_xml_fault->exception.
              ENDTRY.

              IF NOT exception_class_name IS INITIAL.
                DATA(call_failed) = 'X'.
                DATA(response) = lv_error_data.
              ELSE.
*                DATA(lv_str_res) = cl_soap_xml_helper=>xstring_to_string( input  = lv_xml_res ).
                DATA lt_xml_table TYPE TABLE OF smum_xmltb.
                DATA lt_ret       TYPE TABLE OF bapiret2.

                CALL FUNCTION 'SMUM_XML_PARSE'
                  EXPORTING
                    xml_input = lv_xml_res
                  TABLES
                    xml_table = lt_xml_table
                    return    = lt_ret
                  EXCEPTIONS
                    OTHERS    = 0.

*                create_sol_inc_with_attach( ).
                cl_proxy_xml_transform=>xml_xstring_to_abap( EXPORTING ddic_type = mv_rare_in_type xml = lv_xml_res IMPORTING abap_data = ms_rare_in ).
              ENDIF.

            CATCH cx_ai_application_fault. " Application Integration: Application Error
            CATCH cx_xms_system_error.     " XI: System Error
            CATCH cx_ai_system_fault.      " Application Integration: Technical Error
            CATCH cx_proxy_fault.          " Proxy Fault
            CATCH cx_transformation_error. " General Error When Performing CALL TRANSFORMATION
            CATCH cx_dynamic_check.        " Exceptions with Dynamic Check Only of the RAISING Clause
            CATCH cx_proxy_mapping_fault.  " Mapping failed(
          ENDTRY.

          LOOP AT lt_xml_table INTO DATA(ls_data).
            IF ls_data-cname CS 'DISPLAY_VALUE' OR ls_data-cname CS 'display_value'.
              DATA(lv_incident) = ls_data-cvalue.
              EXIT.
            ENDIF.
          ENDLOOP.


          IF lv_incident CS 'INC'.
            mv_text = 'Ticket Successfully Created in ServiceNow : '(006).
            CONCATENATE mv_text  lv_incident INTO mv_text.
            MESSAGE mv_text TYPE 'I' DISPLAY LIKE 'I'.

            cs_rare_interface-rare_inci-inc_no      = lv_incident.
            cs_rare_interface-rare_inci-status_mesg = mv_text.
            collect_mesg( mv_text ).
*            send_email_with_attachment( lv_incident ).
            cv_rare_action = cc_action_incident_success.


          ELSE.
            mv_text = 'Issue While raising Automated incident using Rare'(007) && ' because of '(128) && mv_text.
            MESSAGE mv_text TYPE 'I' DISPLAY LIKE 'I'.
            cs_rare_interface-rare_inci-inc_no      = ms_rare_in-display_value.
            cs_rare_interface-rare_inci-status_mesg = mv_text.
            collect_mesg( mv_text ).
            cv_rare_action = cc_action_incident_error.
          ENDIF.

        ELSE.
          mv_text = 'You can not create Incident again as Incident has been raised already : '(167)  && cs_rare_interface-rare_inci-inc_no.
          MESSAGE mv_text TYPE 'I' DISPLAY LIKE 'I'.
          cs_rare_interface-rare_inci-status_mesg = mv_text.
          collect_mesg( mv_text ).
        ENDIF.

        IF cs_rare_interface-rare_inci-guid IS NOT INITIAL.

          TRY.
              cs_rare_interface-rare_inci-command     = 'ENT'.
              GET TIME STAMP FIELD cs_rare_interface-rare_inci-inc_timestamp.

              UPDATE yztabl_rare_inci
                 SET inc_no        = cs_rare_interface-rare_inci-inc_no
                     inc_timestamp = cs_rare_interface-rare_inci-inc_timestamp
                     command       = cs_rare_interface-rare_inci-command
                     status_mesg   = cs_rare_interface-rare_inci-status_mesg
               WHERE guid          = cs_rare_interface-rare_inci-guid.

              IF sy-subrc = 0.
                CALL FUNCTION 'DB_COMMIT'.
              ELSE.
                mv_text =  'Error While updating Table! yztabl_rare_inci - CONNECT_SNOW'(001) && mv_text.
                APPEND mv_text TO cs_rare_interface-exceptions.
                collect_mesg( mv_text ).
              ENDIF.

            CATCH cx_sy_dynamic_osql_error.
              mv_text =  'Error While updating Table! yztabl_rare_inci - CONNECT_SNOW'(001) && mv_text.
              APPEND mv_text TO cs_rare_interface-exceptions.
              collect_mesg( mv_text ).
          ENDTRY.
        ENDIF.


      CATCH cx_root INTO mo_oref_root.
        mv_text = mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
        cv_rare_action = cc_action_incident_error.
    ENDTRY.
  ENDMETHOD.


  METHOD constructor.

    IF iv_guid IS INITIAL.
      cv_guid = generate_guid( ).

    ELSE.
      cv_guid = iv_guid.
    ENDIF.

    co_lpor-catid  = 'CL'.
    co_lpor-instid = cv_guid.
    co_lpor-typeid = 'YZ_CLAS_RARE_BASE'.

  ENDMETHOD.


  method CREATE_SERVICE.
*{   INSERT         DIMK902864                                        1
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Creates Service Request
*&---------------------------------------------------------------------*

*Declaration
    DATA: mo_oref_root TYPE REF TO cx_root,
          mv_text      TYPE string.

    TRY.

        IF sy-ucomm = 'INIT' or cv_tcode CP 'NWBC*'.
*To Overcome Infinite Loop
          mv_text = 'Launched'(008) && ` ` && cv_tcode && ` ` && '-> Help Menu - > Create Incident'(031).
          collect_rca_data( iv_mesg = mv_text ).

**Get all information - stack screen and etc
*          call_methods( ).
**Popup window to collect input and raise/download incident/pdf
*          popup_control( ).
**Exception handling - email to group
*          send_exceptions( ).
        ENDIF.

      CATCH cx_root INTO mo_oref_root.
        mv_text = mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.
*}   INSERT
  endmethod.


  method create_service_request.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Service Request Creation
*&---------------------------------------------------------------------*
*    submit zsdn_dynselscr.

    data: mo_oref_root type ref to cx_root,
          mv_text      type string,
          ms_rca       type yztabl_rare_rca.

    try.
*Refresh All variables For RaRe
        clear_all( ).

*PreLoad Default functions For RaRe
        init_sr( iv_calling_tcode = iv_calling_tcode ).

*Get rare service header details
        get_rare_service_header( ).

*Get secure tcode details to skip print screen automatically
        get_secure_tcode_details( ).

*Create Service Request
        create_service( ).

      catch cx_root into mo_oref_root.
        mv_text = mo_oref_root->get_text( ).
        append mv_text to cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        clear mv_text.
    endtry.

  endmethod.


  METHOD create_sol_inc_with_attach.

    TYPES: BEGIN OF bapi_notif_ext_type,
             numb(12)      TYPE c,
             refnum(20)    TYPE c,
             type_notif(6) TYPE c,
             category(12)  TYPE c,
             subject(60)   TYPE c,
             priority(1)   TYPE c,
             language      TYPE lang,
           END OF bapi_notif_ext_type,

           BEGIN OF bapi_notif_crm_type,
             code(4)      TYPE c,
             codegroup(8) TYPE c,
             category(3)  TYPE c,
           END OF bapi_notif_crm_type,

           BEGIN OF bapi_notif_p_ext_type,
             parnr(12)     TYPE c,
             type_par(2)   TYPE c,
             func_par(2)   TYPE c,
             par_active(1) TYPE c,
           END OF bapi_notif_p_ext_type,

           BEGIN OF bapi_notif_n_ext_type,
             type_note(4)    TYPE c,
             ident(30)       TYPE c,
             description(60) TYPE c,
           END OF bapi_notif_n_ext_type,

           BEGIN OF bapi_notif_s_ext_type,
             instn(10)        TYPE c,
             mnumm(24)        TYPE n,
             mstat(1)         TYPE c,
             comp(20)         TYPE c,
             ossys(30)        TYPE c,
             dbsys(30)        TYPE c,
             front(30)        TYPE c,
             swcomp(30)       TYPE c,
             swrel(10)        TYPE c,
             swptch(10)       TYPE c,
             add_swcomp(1)    TYPE c,
             systype(1)       TYPE c,
             sysid(8)         TYPE c,
             mandt(3)         TYPE c,
             sap_tstmp(8)     TYPE p DECIMALS 0,
             s2sap_tstmp(8)   TYPE p DECIMALS 0,
             rel_sap_tstmp(8) TYPE p DECIMALS 0,
             solnumb(15)      TYPE n,
             busprocobj1(10)  TYPE n,
             busprocobj2(10)  TYPE n,
             busprocobj3(10)  TYPE n,
             busprocobj4(10)  TYPE n,
             busprocobj5(10)  TYPE n,
             swcomponent1(10) TYPE n,
             swcomponent2(10) TYPE n,
             swcomponent3(10) TYPE n,
             swcomponent4(10) TYPE n,
             swcomponent5(10) TYPE n,
             projectnumb(10)  TYPE c,
             rolloutphase(10) TYPE n,
             sessino_src(13)  TYPE c,
             sessitype_src(2) TYPE c,
             sessino_trg(13)  TYPE c,
             sessitype_trg(2) TYPE c,
             s2sap_first(8)   TYPE p DECIMALS 0,
             s2sap_last(8)    TYPE p DECIMALS 0,
             sfrsap_first(8)  TYPE p DECIMALS 0,
             sfrsap_last(8)   TYPE p DECIMALS 0,
             time_at_sdesk    TYPE int4,
             time_at_sap      TYPE int4,
             step1(10)        TYPE n,
             step2(10)        TYPE n,
             step3(10)        TYPE n,
             step4(10)        TYPE n,
             step5(10)        TYPE n,
             sysno(18)        TYPE c,
           END OF bapi_notif_s_ext_type,

           BEGIN OF bapi_text_header_ext_type,
             txt_num(4)   TYPE n,
             language     TYPE lang,
             type_text(2) TYPE c,
             timestamp(8) TYPE p DECIMALS 0,
             last_usr(12) TYPE c,
           END OF bapi_text_header_ext_type,

           BEGIN OF bapi_text_lines_ext_type,
             txt_num(4)  TYPE n,
             tdformat(2) TYPE c,
             tdline(132) TYPE c,
           END OF bapi_text_lines_ext_type,

           BEGIN OF bapi_notif_appx_type,
             descr(60)    TYPE c,
             appxno(4)    TYPE n,
             filetyp(3)   TYPE c,
             filenam(128) TYPE c,
             filelen(12)  TYPE n,
             firstl(8)    TYPE n,
             lastl(8)     TYPE n,
             filefm_ul(3) TYPE c,
             timestamp(8) TYPE p DECIMALS 0,
             last_usr(12) TYPE c,
             objkey(70)   TYPE c,
           END OF bapi_notif_appx_type,

           BEGIN OF bapi_notif_soli_type,
             line(255) TYPE c,
           END OF bapi_notif_soli_type,

           BEGIN OF bapi_notif_solix_type,
             line(255) TYPE x,
           END OF bapi_notif_solix_type.

*--Other types
    TYPES: BEGIN OF t_tvarvc,
             name TYPE tvarvc-name,
             low  TYPE tvarvc-low,
           END OF t_tvarvc.

    TYPES:
*             BEGIN OF ty_service,
*             guid      TYPE crmt_object_guid,
*             component TYPE /aicrm/dtel001c,
*           END OF ty_service,

      BEGIN OF ty_text,
        guid TYPE crmt_object_guid,
        text TYPE string,
      END OF ty_text.

    TYPES: BEGIN OF ty_activity,
             guid     TYPE crmt_object_guid,
             priority TYPE crmt_priority,
           END OF ty_activity.

    TYPES: BEGIN OF ty_crby,
             crby(20) TYPE c,
           END OF ty_crby.
    TYPES: BEGIN OF ty_but000,
             partner  TYPE bu_partner,
             bu_sort1 TYPE bu_sort1,
           END OF ty_but000.

*    TYPES: BEGIN OF ty_final,
*             guid        TYPE crmt_object_guid,
*             bpno        TYPE crmt_created_by,
*             priority    TYPE crmt_priority,
*             text        TYPE string,
*             description TYPE crmt_process_description,
*             component   TYPE /aicrm/dtel001c,
*           END OF ty_final.
*
*    DATA: it_final TYPE TABLE OF ty_final,
*          wa_final TYPE ty_final.

*    DATA: it_service TYPE TABLE OF ty_service,
*          wa_service TYPE ty_service.

    DATA: it_text      TYPE TABLE OF ty_text,
          it_text_text TYPE TABLE OF ty_text,
          wa_text_text TYPE ty_text,
          wa_text      TYPE ty_text.

    DATA: it_notif_ext          TYPE bapi_notif_ext_type,
          it_notif_crm          TYPE bapi_notif_crm_type,

          it_text_line          TYPE TABLE OF bapi_text_lines_ext_type,
          wa_text_line          TYPE bapi_text_lines_ext_type,

          it_partners           TYPE TABLE OF bapi_notif_p_ext_type,
          wa_partners           TYPE bapi_notif_p_ext_type,

          it_sap_data           TYPE TABLE OF bapi_notif_s_ext_type,
          wa_sap_data           TYPE bapi_notif_s_ext_type,

          su_number             TYPE bapi_notif_ext_type-refnum,

          it_appx_headers       TYPE TABLE OF bapi_notif_appx_type,
          wa_appx_headers       TYPE bapi_notif_appx_type,

          it_appx_lines         TYPE TABLE OF bapi_notif_soli_type,
          wa_appx_lines         TYPE bapi_notif_soli_type,

          it_appx_lines_bin     TYPE TABLE OF bapi_notif_solix_type,
          wa_appx_lines_bin     TYPE bapi_notif_solix_type,

          it_notif_notes        TYPE TABLE OF bapi_notif_n_ext_type,
          wa_notif_notes        TYPE bapi_notif_n_ext_type,

          it_notif_text_headers TYPE TABLE OF bapi_text_header_ext_type,
          wa_notif_text_headers TYPE bapi_text_header_ext_type.


    DATA: it_crmd TYPE TABLE OF crmd_orderadm_h,
          wa_crmd TYPE crmd_orderadm_h.

    DATA number TYPE n LENGTH 24.
    DATA numb   TYPE n LENGTH 24.

    DATA : l_timestamp  TYPE tzntstmpl,
           l_timestamp1 TYPE tzonref-tstamps,
           l_seconds    TYPE i.

    DATA: i_tvarvc  TYPE TABLE OF t_tvarvc,
          wa_tvarvc TYPE t_tvarvc.

    DATA: lt_text_all TYPE comt_text_textdata_t.

    DATA: it_activity TYPE TABLE OF ty_activity,
          wa_activity TYPE ty_activity.
    FIELD-SYMBOLS: <ls_textdata> LIKE LINE OF lt_text_all.

    DATA: lt_text_table TYPE string_table,
          lv_string     TYPE string,
          lv_flag(1)    TYPE c.
    DATA: it_crby TYPE TABLE OF ty_crby,
          wa_crby TYPE ty_crby.
    DATA: it_but000 TYPE TABLE OF ty_but000,
          wa_but000 TYPE ty_but000.

    CONSTANTS: c_crlf        TYPE abap_cr_lf VALUE cl_abap_char_utilities=>cr_lf.


    DATA: mo_oref_root TYPE REF TO cx_root,
          mv_text      TYPE string,
          mv_ref_no    TYPE string,
          mv_status    TYPE string.

*--Collecting values to pass to BAPI
*--For IT_NOTIF_EXT
    it_notif_ext-subject = cs_rare_interface-rare_inci-short_description.
    it_notif_ext-priority = cs_rare_interface-rare_inci-urgency.
    it_notif_ext-type_notif = 'SMIN'.
    it_notif_ext-language = 'E'.


*--For IT_PARTNERS
    wa_partners-parnr = '0000000923'.
    wa_partners-type_par = 'BP'.
    wa_partners-func_par = 'RP'.
    APPEND wa_partners TO it_partners.
    CLEAR wa_partners.

*--For IT_SAP_DATA
    wa_sap_data-instn = '0020773879'.
*    wa_sap_data-comp =  wa_final-component.
*    wa_sap_data-swcomp = 'SAP_BASIS'.
*    wa_sap_data-ossys = 'AIX 5.3'.
*    wa_sap_data-dbsys = 'ORACLE 10.2.0.2.0'.
*    wa_sap_data-swrel = '700'.
*    wa_sap_data-swptch = '0008'.
    wa_sap_data-systype = 'T'.
    wa_sap_data-mandt = '100'.
    wa_sap_data-sysid = 'SAM'.
    APPEND wa_sap_data TO it_sap_data.
    CLEAR wa_sap_data.


    wa_appx_headers-filenam = 'incident_info.pdf'.
    wa_appx_headers-filetyp = 'PDF'.
    wa_appx_headers-objkey  = 'incident_info.pdf'.
    wa_appx_headers-descr   = 'Smart PDF'.
    APPEND wa_appx_headers TO it_appx_headers.

    CALL FUNCTION 'SWA_STRING_SPLIT'
      EXPORTING
        input_string         = cs_rare_interface-pdf
        max_component_length = 255
*       TERMINATING_SEPARATORS             =
*       OPENING_SEPARATORS   =
      TABLES
        string_components    = it_appx_lines_bin
* EXCEPTIONS
*       MAX_COMPONENT_LENGTH_INVALID       = 1
*       OTHERS               = 2
      .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.


*    it_appx_lines_bin[] = cs_rare_interface-pdf.
    TRY.

*--Support Message Creation using BAPI
        CALL FUNCTION 'BAPI_NOTIFICATION_CREATE'
          DESTINATION 'SAM100'
          EXPORTING
            notif_ext      = it_notif_ext           "Has values
            notif_crm      = it_notif_crm           "Has values
          IMPORTING
            number         = number
            numb           = numb
          TABLES
            notif_partners = it_partners            "Has values
*           notif_notes    = it_notif_notes
            notif_sap_data = it_sap_data            "Has values
*           notif_text_headers = it_notif_text_headers  "Has values
*           notif_text_lines   = it_text_line           "Has values
            appx_headers   = it_appx_headers
            appx_lines     = it_appx_lines
            appx_lines_bin = it_appx_lines_bin.

        IF sy-subrc EQ 0.
          REFRESH: it_partners, it_sap_data, it_notif_text_headers, it_text_line.
          CLEAR: it_notif_ext, it_notif_crm.
        ENDIF.

*        CALL FUNCTION 'ZFM_SAP_SOLMAN_WITH_ATTACH'
*          DESTINATION 'SM1CLNT100'
*          EXPORTING
*            source                = cs_rare_interface-userinfo-email
*            subject               = cs_rare_interface-rare_inci-short_description
*            attach                = cs_rare_interface-xstring-pdf
*          IMPORTING
*            ref_no                = mv_ref_no
*            status                = mv_status
*          EXCEPTIONS
*            system_failure        = 1 MESSAGE cs_rare_interface-rare_inci-status_mesg
*            communication_failure = 2 MESSAGE cs_rare_interface-rare_inci-status_mesg
*            OTHERS                = 3.

        CASE sy-subrc.
          WHEN 1.

            mv_text = 'SYSTEM_FAILURE exception caught while creating incident in SOLMAN.'.
            APPEND mv_text TO cs_rare_interface-exceptions.
            CLEAR mv_text.
          WHEN 2.

            mv_text = 'COMMUNICATION_FAILURE exception caught while creating incident in SOLMAN.'.
            APPEND mv_text TO cs_rare_interface-exceptions.
            CLEAR mv_text.
          WHEN 3.

            mv_text = 'OTHERS exception caught while creating incident in SOLMAN.'.
            APPEND mv_text TO cs_rare_interface-exceptions.
            CLEAR mv_text.
        ENDCASE.

        IF mv_ref_no  IS NOT INITIAL.
          cs_rare_interface-rare_inci-inc_no = mv_ref_no.
          cs_rare_interface-rare_inci-status_mesg = mv_status.
          MESSAGE cs_rare_interface-rare_inci-status_mesg TYPE 'I'.
        ELSE.
          MESSAGE  'Error while creating incident in SOLMAN' TYPE 'I'.
        ENDIF.

      CATCH cx_root INTO mo_oref_root.
        mv_text = mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.
  ENDMETHOD.


  METHOD create_ticket.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Creates ticket for the incident
*&---------------------------------------------------------------------*

*Declaration
    DATA: mo_oref_root TYPE REF TO cx_root,
          mv_text      TYPE string.

    TRY.

        IF sy-ucomm = 'INIT' or cv_tcode CP 'NWBC*'.
*To Overcome Infinite Loop
          mv_text = 'Launched'(008) && ` ` && cv_tcode && ` ` && '-> Help Menu - > Create Incident'(031).
          collect_rca_data( iv_mesg = mv_text ).

*Get all information - stack screen and etc
          call_methods( ).
*Popup window to collect input and raise/download incident/pdf
          popup_control( ).
*Exception handling - email to group
          send_exceptions( ).
        ENDIF.

      CATCH cx_root INTO mo_oref_root.
        mv_text = mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.

  ENDMETHOD.


  METHOD download_pdf.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Method for implementing download functionality for the PDF
*&---------------------------------------------------------------------*

    DATA :
      mo_oref     TYPE REF TO cx_root,
      mv_text     TYPE string,
      mt_data_tab TYPE TABLE OF x255,
      mv_anwser.

    TRY.

*Checking the call - Internal or External
        IF is_rare_inci IS SUPPLIED.
          IF is_rare_inci IS NOT INITIAL.
            CLEAR cs_rare_interface.
            get_container_data( EXPORTING iv_wi_id     = sync_workitem( is_rare_inci )
                                IMPORTING es_rare_data = cs_rare_interface ).
            cs_rare_interface-rare_inci = is_rare_inci.
            cs_rare_interface-rare_inci-user_name = sy-uname.
          ENDIF.
        ENDIF.


        IF open_file_save_dialog( ) = 0.

          DO.

            IF cv_file_name IS INITIAL OR
            cv_folder       IS INITIAL OR
            cv_fullpath     IS INITIAL .

              mv_text = 'Do You Want To Re-Enter Path To Download ("Yes") else ("No") To Skip Download and Go Back To Previous Screen'(198).

              CALL FUNCTION 'POPUP_TO_CONFIRM'
                EXPORTING
                  titlebar              = 'Forgot to Enter Path To Download PDF'(201)
                  text_question         = mv_text
                  text_button_1         = 'Yes'(202)
                  icon_button_1         = 'ICON_CHC'
                  text_button_2         = 'No'(203)
                  icon_button_2         = 'ICON_CANCEL'
                  default_button        = '1'
                  display_cancel_button = 'X'
                  popup_type            = 'ICON_MESSAGE_ERROR'
                IMPORTING
                  answer                = mv_anwser
                EXCEPTIONS
                  text_not_found        = 1
                  OTHERS                = 2.

              IF sy-subrc <> 0.

                CASE sy-subrc.

                  WHEN 1.
                    mv_text = 'text_not_found is catched while calling POPUP_TO_CONFIRM in DOWNLOAD_PDF method.'(199).
                    APPEND mv_text TO cs_rare_interface-exceptions.

                  WHEN 2.
                    mv_text = 'OTHERS is catched while calling POPUP_TO_CONFIRM in DOWNLOAD_PDF method.'(200).
                    APPEND mv_text TO cs_rare_interface-exceptions.
                ENDCASE.
                collect_mesg(  mv_text ).
                CLEAR mv_text.

                EXIT.

              ELSE.
                CASE mv_anwser.

                  WHEN 'A'.
                    EXIT.

                  WHEN '1'.
                    IF open_file_save_dialog( ) = 0.
                      CONTINUE.
                    ELSE.
                      EXIT.
                    ENDIF.

                  WHEN '2'.
                    EXIT.

                  WHEN OTHERS.
                    EXIT.

                ENDCASE.
              ENDIF.
            ELSE.
              EXIT.
            ENDIF.
          ENDDO.

          IF cv_file_name IS NOT INITIAL AND
          cv_folder       IS NOT INITIAL AND
          cv_fullpath     IS NOT INITIAL .

            CALL METHOD cl_progress_indicator=>progress_indicate
              EXPORTING
                i_text               = 'Converting into Binary'(067)
                i_output_immediately = abap_true
                i_processed          = 3
                i_total              = 4.

            IF cs_rare_interface-xstring-pdf IS INITIAL.
              get_pdf_form( ).
            ENDIF.

            CALL FUNCTION 'SCMS_XSTRING_TO_BINARY'
              EXPORTING
                buffer     = cs_rare_interface-xstring-pdf
              TABLES
                binary_tab = mt_data_tab.

            CALL METHOD cl_progress_indicator=>progress_indicate
              EXPORTING
                i_text               = 'Download Start'(066)
                i_output_immediately = abap_true
                i_processed          = 3
                i_total              = 4.

            cl_gui_frontend_services=>gui_download(
            EXPORTING
              filename                  = cv_fullpath
              filetype                  = 'BIN'
            CHANGING
              data_tab                  =  mt_data_tab    " Transfer table
            EXCEPTIONS
              file_write_error          = 1
              no_batch                  = 2
              gui_refuse_filetransfer   = 3
              invalid_type              = 4
              no_authority              = 5
              unknown_error             = 6
              header_not_allowed        = 7
              separator_not_allowed     = 8
              filesize_not_allowed      = 9
              header_too_long           = 10
              dp_error_create           = 11
              dp_error_send             = 12
              dp_error_write            = 13
              unknown_dp_error          = 14
              access_denied             = 15
              dp_out_of_memory          = 16
              disk_full                 = 17
              dp_timeout                = 18
              file_not_found            = 19
              dataprovider_exception    = 20
              control_flush_error       = 21
              not_supported_by_gui      = 22
              error_no_gui              = 23
              OTHERS                    = 24
              ).

            IF sy-subrc <> 0.
              CASE sy-subrc.
                WHEN 1.
                  mv_text = 'file_write_error is catched while calling gui_download in DOWNLOAD_PDF method.'(132).
                  APPEND mv_text TO cs_rare_interface-exceptions.

                WHEN 2.
                  mv_text = 'no_batch is catched while calling gui_download in DOWNLOAD_PDF method.'(133).
                  APPEND mv_text TO cs_rare_interface-exceptions.

                WHEN 3.
                  mv_text = 'gui_refuse_filetransfer is catched while calling gui_download in DOWNLOAD_PDF method.'(134).
                  APPEND mv_text TO cs_rare_interface-exceptions.

                WHEN 4.
                  mv_text = 'invalid_type is catched while calling gui_download in DOWNLOAD_PDF method.'(135).
                  APPEND mv_text TO cs_rare_interface-exceptions.

                WHEN 5.
                  mv_text = ' no_authority is catched while calling gui_download in DOWNLOAD_PDF method.'(136).
                  APPEND mv_text TO cs_rare_interface-exceptions.
                  CLEAR mv_text.
                WHEN 6.
                  mv_text = 'unknown_error is catched while calling gui_download in DOWNLOAD_PDF method.'(137).
                  APPEND mv_text TO cs_rare_interface-exceptions.

                WHEN 7.
                  mv_text = 'header_not_allowed is catched while calling gui_download in DOWNLOAD_PDF method.'(138).
                  APPEND mv_text TO cs_rare_interface-exceptions.

                WHEN 8.
                  mv_text = 'separator_not_allowed is catched while calling gui_download in DOWNLOAD_PDF method.'(139).
                  APPEND mv_text TO cs_rare_interface-exceptions.

                WHEN 9.
                  mv_text = 'filesize_not_allowed is catched while calling gui_download in DOWNLOAD_PDF method.'(140).
                  APPEND mv_text TO cs_rare_interface-exceptions.

                WHEN 10.
                  mv_text = 'header_too_long is catched while calling gui_download in DOWNLOAD_PDF method.'(141).
                  APPEND mv_text TO cs_rare_interface-exceptions.

                WHEN 11.
                  mv_text = 'dp_error_create  is catched while calling gui_download in DOWNLOAD_PDF method.'(154).
                  APPEND mv_text TO cs_rare_interface-exceptions.

                WHEN 12.
                  mv_text = 'dp_error_send is catched while calling gui_download in DOWNLOAD_PDF method.'(155).
                  APPEND mv_text TO cs_rare_interface-exceptions.

                WHEN 13.
                  mv_text = 'dp_error_write is catched while calling gui_download in DOWNLOAD_PDF method.'(156).
                  APPEND mv_text TO cs_rare_interface-exceptions.

                WHEN 14.
                  mv_text = 'unknown_dp_error is catched while calling gui_download in DOWNLOAD_PDF method.'(157).
                  APPEND mv_text TO cs_rare_interface-exceptions.

                WHEN 15.
                  mv_text = 'access_denied is catched while calling gui_download in DOWNLOAD_PDF method.'(158).
                  APPEND mv_text TO cs_rare_interface-exceptions.

                WHEN 16.
                  mv_text = 'dp_out_of_memory is catched while calling gui_download in DOWNLOAD_PDF method.'(159).
                  APPEND mv_text TO cs_rare_interface-exceptions.

                WHEN 17.
                  mv_text = 'disk_full is catched while calling gui_download in DOWNLOAD_PDF method.'(160).
                  APPEND mv_text TO cs_rare_interface-exceptions.

                WHEN 18.
                  mv_text = 'dp_timeout is catched while calling gui_download in DOWNLOAD_PDF method.'(161).
                  APPEND mv_text TO cs_rare_interface-exceptions.

                WHEN 19.
                  mv_text = 'file_not_found is catched while calling gui_download in DOWNLOAD_PDF method.'(162).
                  APPEND mv_text TO cs_rare_interface-exceptions.

                WHEN 20.
                  mv_text = 'dataprovider_exception is catched while calling gui_download in DOWNLOAD_PDF method.'(163).
                  APPEND mv_text TO cs_rare_interface-exceptions.

                WHEN 21.
                  mv_text = 'control_flush_error is catched while calling gui_download in DOWNLOAD_PDF method.'(164).
                  APPEND mv_text TO cs_rare_interface-exceptions.

                WHEN 22.
                  mv_text = 'not_supported_by_gui is catched while calling gui_download in DOWNLOAD_PDF method.'(165).
                  APPEND mv_text TO cs_rare_interface-exceptions.

                WHEN 23.
                  mv_text = 'no_batch is catched while calling gui_download in DOWNLOAD_PDF method.'(133).
                  APPEND mv_text TO cs_rare_interface-exceptions.

                WHEN 24.
                  mv_text = 'OTHERS  is catched while calling gui_download in DOWNLOAD_PDF method.'(166).
                  APPEND mv_text TO cs_rare_interface-exceptions.

              ENDCASE.

*Collect Exception Message
              cs_rare_interface-rare_inci-status_mesg = mv_text.
              collect_mesg( mv_text ).

            ELSE.
              MESSAGE i007(yz_msag_rare) DISPLAY LIKE 'I'.
              cs_rare_interface-rare_inci-download_count = cs_rare_interface-rare_inci-download_count + 1.
              cs_rare_interface-rare_inci-status_mesg = 'pdf downloaded successfully'(142).
              cv_rare_action = cc_action_downloaded.

            ENDIF.

            TRY.

                GET TIME STAMP FIELD cs_rare_interface-rare_inci-last_d_timestamp.
                cs_rare_interface-rare_inci-command     = 'DOW'.

                UPDATE yztabl_rare_inci
                   SET status_mesg      = cs_rare_interface-rare_inci-status_mesg
                       last_d_timestamp = cs_rare_interface-rare_inci-last_d_timestamp
                       download_count   = cs_rare_interface-rare_inci-download_count
                       command          = cs_rare_interface-rare_inci-command
                 WHERE guid             = cs_rare_interface-rare_inci-guid.

                IF sy-subrc = 0.
                  CALL FUNCTION 'DB_COMMIT'.
                ELSE.
                  mv_text =  'Error While updating Table! yztabl_rare_inci : pdf download'(180).
                  APPEND mv_text TO cs_rare_interface-exceptions.
                  collect_mesg( mv_text ).
                ENDIF.

              CATCH cx_sy_dynamic_osql_error.
                mv_text =  'Error While updating Table! yztabl_rare_inci : pdf download'(180).
                APPEND mv_text TO cs_rare_interface-exceptions.
                collect_mesg( mv_text ).
            ENDTRY.

          ENDIF.

        ELSE.
          mv_text = 'Error while downloading PDF'(068).
          collect_mesg(  mv_text ).
          APPEND mv_text TO cs_rare_interface-exceptions.
        ENDIF.

      CATCH cx_root INTO mo_oref.
        mv_text = mo_oref->get_text( ).
        MESSAGE mv_text TYPE 'I'.
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.

  ENDMETHOD.


  METHOD execute_rare.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Excecutes RaRe
*&---------------------------------------------------------------------*

    DATA: mo_oref_root TYPE REF TO cx_root,
          mv_text      TYPE string,
          ms_rca       TYPE yztabl_rare_rca.

    TRY.
*Refresh All variables For RaRe
        clear_all( ).

*PreLoad Default functions For RaRe
        init( iv_calling_tcode = iv_calling_tcode ).

*Get rare incident header details
        get_rare_incident_header( ).

*Get secure tcode details to skip print screen automatically
        get_secure_tcode_details( ).

*Create Ticket
        create_ticket( ).

      CATCH cx_root INTO mo_oref_root.
        mv_text = mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.

  ENDMETHOD.


METHOD generate_guid.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Triggers the pop-up screen to be displayed
*&---------------------------------------------------------------------*
  DATA:  mo_oref_root TYPE REF TO cx_root,
         mv_text      TYPE string.

  TRY.

      TRY.
          rv_guid = cl_system_uuid=>create_uuid_c32_static( ).
        CATCH cx_uuid_error.
          mv_text =  'Error while creating guid'(119).
          APPEND mv_text TO cs_rare_interface-exceptions.
          collect_mesg( mv_text ).
      ENDTRY.

    CATCH cx_root INTO  mo_oref_root .
      mv_text =  mo_oref_root->get_text( ).
      APPEND mv_text TO cs_rare_interface-exceptions.
      collect_mesg( mv_text ).
      CLEAR mv_text.
  ENDTRY.

ENDMETHOD.


  METHOD get_adobe_function_module_name.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Get Function Module name of Adobe Form
*&---------------------------------------------------------------------*
    DATA: mo_oref_root TYPE REF TO cx_root,
          mv_text      TYPE string.

    DATA: mv_subrc TYPE sy-subrc.

    DATA: mo_oref_cx_fp_api_repository TYPE REF TO  cx_fp_api_repository,
          mo_oref_cx_fp_api_usage      TYPE REF TO  cx_fp_api_usage,
          mo_oref_cx_fp_api_internal   TYPE REF TO  cx_fp_api_internal,
          mo_oref_cx_fp_api            TYPE REF TO  cx_fp_api.

    TRY.

        TRY.

            CALL METHOD cl_progress_indicator=>progress_indicate
              EXPORTING
                i_text               = 'GET PDF FM NAME'
                i_output_immediately = abap_true
                i_processed          = 1
                i_total              = 4.

            CALL FUNCTION 'FP_FUNCTION_MODULE_NAME'
              EXPORTING
                i_name     = 'YZ_FORM_RARE_PDF'
              IMPORTING
                e_funcname = rv_funcname.

          CATCH cx_fp_api_repository INTO mo_oref_cx_fp_api_repository.
            mv_text = mo_oref_cx_fp_api_repository->get_text( ).
            APPEND mv_text TO cs_rare_interface-exceptions.
            CLEAR mv_text.
            mv_subrc = 1.

          CATCH  cx_fp_api_usage INTO mo_oref_cx_fp_api_usage.
            mv_text = mo_oref_cx_fp_api_usage->get_text( ).
            APPEND mv_text TO cs_rare_interface-exceptions.
            CLEAR mv_text.
            mv_subrc = 2.

          CATCH cx_fp_api_internal INTO mo_oref_cx_fp_api_internal.
            mv_text = mo_oref_cx_fp_api_internal->get_text( ).
            APPEND mv_text TO cs_rare_interface-exceptions.
            CLEAR mv_text.
            mv_subrc = 3.

          CATCH cx_fp_api INTO mo_oref_cx_fp_api.
            mv_text = mo_oref_cx_fp_api->get_text( ).
            APPEND mv_text TO cs_rare_interface-exceptions.
            CLEAR mv_text.
            mv_subrc = 8.

        ENDTRY.

        IF mv_subrc <> 0.
          CASE mv_subrc.
            WHEN 1.
              mv_text = 'cx_fp_api_repository exception is catched while calling FP_FUNCTION_MODULE_NAME in GET_ADOBE_FUNCTION_MODULE_NAME'(194).
              APPEND mv_text TO cs_rare_interface-exceptions.

            WHEN 2.
              mv_text = 'cx_fp_api_usage exception is catched while calling FP_FUNCTION_MODULE_NAME in GET_ADOBE_FUNCTION_MODULE_NAME'(195).
              APPEND mv_text TO cs_rare_interface-exceptions.

            WHEN 3.
              mv_text = 'cx_fp_api_internal exception is catched while calling FP_FUNCTION_MODULE_NAME in GET_ADOBE_FUNCTION_MODULE_NAME'(196).
              APPEND mv_text TO cs_rare_interface-exceptions.

            WHEN 4.
              mv_text = 'Others exception is catched while calling FP_FUNCTION_MODULE_NAME in GET_ADOBE_FUNCTION_MODULE_NAME'(197).
              APPEND mv_text TO cs_rare_interface-exceptions.

          ENDCASE.
          collect_mesg( mv_text ).
          CLEAR mv_text.
        ELSE.
          cv_funcname = rv_funcname.
          cs_rare_interface-funcname = cv_funcname.
        ENDIF.


      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.
  ENDMETHOD.


  METHOD get_al11_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : AL11: latest modified file details
*&---------------------------------------------------------------------*
    DATA:  mo_oref_root TYPE REF TO cx_root,
           mv_text      TYPE string,
           mv_msg       TYPE string,
           mv_sysid     TYPE sy-sysid,
           mv_dirname   TYPE ocs_file-name.

    TRY.

        CALL FUNCTION 'TR_SYS_PARAMS'
          IMPORTING
            systemname    = mv_sysid
          EXCEPTIONS
            no_systemname = 1
            no_systemtype = 2
            OTHERS        = 3.

        IF sy-subrc <> 0.
          CASE sy-subrc.
            WHEN 1.
              mv_text = 'no_systemname exception is catched while calling TR_SYS_PARAMS in GET_AL11_DATA.'(098).
              APPEND mv_text TO cs_rare_interface-exceptions.
              CLEAR mv_text.
            WHEN 2.
              mv_text = 'no_systemtype exception is catched while calling TR_SYS_PARAMS in GET_AL11_DATA.'(099).
              APPEND mv_text TO cs_rare_interface-exceptions.
              CLEAR mv_text.
            WHEN 3.
              mv_text = 'Others exception is catched while calling TR_SYS_PARAMS in GET_AL11_DATA.'(100).
              APPEND mv_text TO cs_rare_interface-exceptions.
              CLEAR mv_text.
          ENDCASE.
        ENDIF.

        IF iv_dirname IS INITIAL.
          mv_dirname = `/interface/` && mv_sysid.
        ELSE.
          mv_dirname = iv_dirname.
        ENDIF.

        CALL FUNCTION 'OCS_GET_FILE_INFO'
          EXPORTING
            dir_name                  = mv_dirname
            file_name                 = iv_filename
          TABLES
            dir_list                  = cs_rare_interface-al11
          EXCEPTIONS
            no_authority              = 1
            activity_unknown          = 2
            not_a_directory           = 3
            no_media_in_drive         = 4
            too_many_errors           = 5
            too_many_files            = 6
            bracket_error_in_filename = 7
            no_such_parameter         = 8
            OTHERS                    = 9.

        IF sy-subrc <> 0.
          CASE sy-subrc.

            WHEN 1.
              mv_msg = 'No-Authority to Al11'(010).
            WHEN 2.
              mv_msg = 'Activity of AL11 is unknown'(011).
            WHEN 3.
              mv_msg = 'Directory doesnot exist'(012).
            WHEN OTHERS.
              mv_msg = 'Error in fetching directory of AL11'(013).
          ENDCASE.
          collect_mesg( mv_msg ).

        ELSE.

*show only top 20 rows rest delete it
          SORT cs_rare_interface-al11 BY mod_date DESCENDING mod_time DESCENDING.
          IF lines( cs_rare_interface-al11 ) > 20.
            DELETE cs_rare_interface-al11 FROM 21.
          ENDIF.

          "AL11 deatisl for given directory
          IF cs_rare_interface-al11 IS NOT INITIAL.
            MESSAGE i027(yz_msag_rare) INTO mv_text WITH  mv_dirname.
            collect_header_data( iv_header_type = 'MH' iv_header_msg = mv_text iv_header_criticality = 'L').
          ENDIF.

        ENDIF.

      CATCH cx_root INTO mo_oref_root.
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.
  ENDMETHOD.


  METHOD get_associated_field_val_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Field value data
*&---------------------------------------------------------------------*

    DATA: mo_oref_root TYPE REF TO cx_root,
          mv_text      TYPE string.

    TRY.
        FIELD-SYMBOLS: <fv> TYPE any.
        DATA   mv TYPE string.
        DATA   mv_typ(10).

        DATA: ms_et_callstack LIKE LINE OF cs_rare_interface-callstack.
        DATA: mt_field LIKE cs_rare_interface-fields.
        DATA: ms_field LIKE LINE OF cs_rare_interface-fields.
        DATA: mt_d020t TYPE STANDARD TABLE OF d020t.
        DATA: mt_d021t TYPE STANDARD TABLE OF d021t.
        DATA: ms_d021t LIKE LINE OF mt_d021t.
        IF NOT ( cv_tcode CP 'NWBC*' ).
          IF  cs_rare_sec IS INITIAL.

            LOOP AT cs_rare_interface-callstack INTO ms_et_callstack.

              SELECT *
                FROM d020t
          INTO TABLE mt_d020t
               WHERE prog = ms_et_callstack-progname.

              CASE sy-subrc.

                WHEN 0.

                  SELECT *
                    FROM d021t
              INTO TABLE mt_d021t
      FOR ALL ENTRIES IN mt_d020t
                   WHERE prog = mt_d020t-prog
                     AND dynr = mt_d020t-dynr
                     AND lang = sy-langu.

                  CASE sy-subrc.

                    WHEN 0.

                      LOOP AT mt_d021t INTO ms_d021t.
                        mv = `(` && ms_d021t-prog && `)` && ms_d021t-fldn .

                        TRY.

                            ASSIGN (mv) TO <fv>.

                          CATCH cx_sy_assign_cast_illegal_cast ##NO_HANDLER.
                          CATCH cx_sy_assign_cast_unknown_type ##NO_HANDLER .
                          CATCH cx_sy_assign_out_of_range  ##NO_HANDLER.
                        ENDTRY.


                        IF <fv> IS ASSIGNED.
                          IF <fv> IS NOT INITIAL.
                            DESCRIBE FIELD <fv> TYPE mv_typ.
*--------------------------------------------------------------------*
* implement logic to check mv_typ should one of like char , string or ,datetime
*( it should not be internal table or completex type)
*--------------------------------------------------------------------*
                            IF mv_typ = 'c' OR mv_typ = 'C' OR mv_typ = 'd' OR mv_typ = 'D'.
                              ms_field-field     = ms_d021t-fldn .
                              ms_field-fieldname = ms_d021t-dtxt.
                              ms_field-value     = <fv>.
                              APPEND ms_field TO mt_field.
                            ENDIF.
                          ENDIF.
                        ENDIF.
                      ENDLOOP.

                  ENDCASE.

              ENDCASE.

            ENDLOOP.

            SORT mt_field BY field.
            DELETE ADJACENT DUPLICATES FROM mt_field COMPARING field.
            cs_rare_interface-fields[] = mt_field[].

          ELSE.
            REFRESH cs_rare_interface-fields[].
            MESSAGE w046(yz_msag_rare) INTO mv_text .
            collect_header_data( iv_header_type = 'TH' iv_header_msg = mv_text iv_header_criticality = 'L').
            collect_mesg( mv_text ).
          ENDIF.
        ELSE.
          " Get MDG details for display
          CALL METHOD yz_clas_rare_nwbc=>get_cr_header_fields
            CHANGING
              cv_fields = cs_rare_interface-fields[].
        ENDIF.

      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.
  ENDMETHOD.


  METHOD get_associated_screen_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team Innovation and Automation Team
*&Transport request :
*&Description       : Screen data
*&---------------------------------------------------------------------*
    DATA: mo_oref_root TYPE REF TO cx_root,
          mv_text      TYPE string.

    DATA ms_screen       TYPE screen.
    DATA mt_rare_scr     TYPE STANDARD TABLE OF yztabl_rare_scr.
    DATA ms_rare_scr     LIKE LINE OF mt_rare_scr.
    DATA ms_callstack    LIKE LINE OF cs_rare_interface-callstack.

    TRY.
*Collect Screen Details using APIs
        ms_screen = screen.
        APPEND ms_screen TO cs_rare_interface-screen.

        LOOP AT SCREEN.
          ms_screen = screen.
          APPEND ms_screen TO cs_rare_interface-screen.
        ENDLOOP.

* Find all Child / Subscreen with T code and include in cs_rare_interface-SCREEN
        SELECT *
          FROM yztabl_rare_scr
    INTO TABLE mt_rare_scr
         WHERE tcode = cs_rare_interface-tcode_data-tcode
          AND  active = abap_true.

        IF sy-subrc = 0.
          CLEAR ms_screen.
          LOOP AT mt_rare_scr INTO ms_rare_scr.
            ms_callstack-progname = ms_screen-name = ms_rare_scr-screen_name.
            APPEND ms_screen TO cs_rare_interface-screen.
            APPEND ms_callstack TO cs_rare_interface-callstack.
          ENDLOOP.
*HEADER*
        ELSE.
*HEADER*
          mv_text = 'No Config Data found from table yztabl_rare_scr table in GET_ASSOCIATED_SCREEN_DATA method.'(101).
          APPEND mv_text TO cs_rare_interface-exceptions.
          collect_mesg( mv_text ).
          CLEAR mv_text.
        ENDIF.

      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.
  ENDMETHOD.


  METHOD get_auth_check_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Authorization checks
*&---------------------------------------------------------------------*

    CONSTANTS:          mc_last_seconds TYPE i VALUE 10800,
                        mc_last_entries TYPE i VALUE 100.

    DATA:   BEGIN OF usr07key,
              objct TYPE usr07-objct,
              fiel1 TYPE usr07-fiel0,
              fiel2 TYPE usr07-fiel0,
              fiel3 TYPE usr07-fiel0,
              fiel4 TYPE usr07-fiel0,
              fiel5 TYPE usr07-fiel0,
              fiel6 TYPE usr07-fiel0,
              fiel7 TYPE usr07-fiel0,
              fiel8 TYPE usr07-fiel0,
              fiel9 TYPE usr07-fiel0,
              fiel0 TYPE usr07-fiel0,
            END OF usr07key.

    DATA:   BEGIN OF usr07val1,
              val01 TYPE usr07-val01,
              val02 TYPE usr07-val01,
              val03 TYPE usr07-val01,
              val04 TYPE usr07-val01,
              val05 TYPE usr07-val01,
              val06 TYPE usr07-val01,
            END OF usr07val1.

    DATA:   BEGIN OF usr07val2,
              val07 TYPE usr07-val01,
              val08 TYPE usr07-val01,
              val09 TYPE usr07-val01,
              val10 TYPE usr07-val01,
            END OF usr07val2.

    DATA:  mo_oref_root         TYPE REF TO cx_root,
           mv_text              TYPE string,
           mv_new_kernel_avail  TYPE          abap_bool,
           mv_checks_since_time TYPE          timestampl,
           mt_usr07_new         TYPE TABLE OF usr07,
           mv_instance          TYPE         msxxlist-name,
           mv_bname             TYPE xubname,
           ms_usr07_new         TYPE          usr07,
           mv_retcode           TYPE          sy-subrc,
           mt_su53buf           TYPE          cl_susr_tools_kernel=>tt_usr07p,
           mr_su53buf           TYPE REF TO   cl_susr_tools_kernel=>ty_usr07p,
           ms_usr07             TYPE          usr07,
           mv_since_hours       TYPE          timestampl,
           mv_status            TYPE          char01.




    TRY.

        CLEAR: mt_usr07_new,
               mv_checks_since_time.

        IF iv_user IS NOT INITIAL .
          mv_bname = iv_user.
        ELSE.
          mv_bname = sy-uname.
        ENDIF.

        CALL METHOD cl_susr_tools_kernel=>get_su53_status
          RECEIVING
            rv_status = mv_status.

        IF mv_status  NE 'F'.
          mv_new_kernel_avail = abap_true.
        ENDIF.

        " Get local instance
        mv_instance = cl_abap_syst=>get_instance_name( ).

        IF mv_new_kernel_avail EQ abap_true.
          " ----  New kernel -------
          " Read last hours from shared memory
          GET TIME STAMP FIELD mv_checks_since_time.

          TRY.
              CALL METHOD cl_abap_tstmp=>subtractsecs
                EXPORTING
                  tstmp   = mv_checks_since_time
                  secs    = mc_last_seconds
                RECEIVING
                  r_tstmp = mv_checks_since_time.

            CATCH cx_parameter_invalid_range cx_parameter_invalid_type.
              GET TIME STAMP FIELD mv_checks_since_time.

          ENDTRY.

          mv_since_hours = mv_checks_since_time.

          CALL METHOD cl_susr_tools_kernel=>get_su53_buffer
            EXPORTING
              iv_bname         = mv_bname
              iv_no_auth_only  = abap_true
              iv_max_entries   = mc_last_entries
              iv_entries_since = mv_checks_since_time
            IMPORTING
              et_su53_buffer   = mt_su53buf
              ev_entries_since = mv_checks_since_time
              ev_retcode       = mv_retcode.

          IF mv_retcode EQ 0.
            SORT mt_su53buf BY timestamp DESCENDING.

            LOOP AT mt_su53buf REFERENCE INTO mr_su53buf.
              MOVE-CORRESPONDING mr_su53buf->* TO ms_usr07_new.
              IF mr_su53buf->authrc = 'A'.
                ms_usr07_new-rc = 40.
              ELSE.
                ms_usr07_new-rc = mr_su53buf->authrc * 4.
              ENDIF.
              " Set instance
              ms_usr07_new-instance = mv_instance.
              APPEND ms_usr07_new TO mt_usr07_new.
            ENDLOOP.

            " Time since checks..
            IF mv_checks_since_time LT mv_since_hours.
              mv_checks_since_time = mv_since_hours.
            ENDIF.
            IF lines( mt_su53buf ) EQ mc_last_entries.
              READ TABLE mt_su53buf REFERENCE INTO mr_su53buf INDEX lines( mt_su53buf ).
              IF sy-subrc EQ 0.
                mv_checks_since_time = mr_su53buf->timestamp.
              ENDIF.
            ENDIF.
          ENDIF.
        ELSE.
          " ---- Old kernel with parameter ---------------
          IF sy-uname EQ mv_bname ##USER_OK.
            " Get result of last authorization check
            GET PARAMETER ID 'XU1' FIELD usr07key.          "#EC EXISTS
            GET PARAMETER ID 'XU2' FIELD usr07val1.         "#EC EXISTS
            GET PARAMETER ID 'XU7' FIELD usr07val2.         "#EC EXISTS

            " Store result of last authorization check
            CLEAR ms_usr07.
            ms_usr07-bname = mv_bname.
            MOVE-CORRESPONDING usr07key  TO ms_usr07.
            MOVE-CORRESPONDING usr07val1 TO ms_usr07.
            MOVE-CORRESPONDING usr07val2 TO ms_usr07.
            MOVE-CORRESPONDING ms_usr07 TO ms_usr07_new.
            APPEND ms_usr07_new TO mt_usr07_new.
          ENDIF.
        ENDIF.
        SORT mt_usr07_new.
        DELETE ADJACENT DUPLICATES FROM mt_usr07_new.
        cs_rare_interface-su53_info[] = mt_usr07_new[].

        """Change Category & Assignment Group for t-code authorization issue.
        IF cs_rare_interface-rare_inci-tcode = 'SESSION_MANAGER'
          AND line_exists( cs_rare_interface-su53_info[ OBJCT = 'S_TCODE' FIEL1 = 'TCD' rc = 4 ] ).
          READ TABLE cs_rare_interface-su53_info[] INTO ms_usr07_new
          WITH KEY objct = 'S_TCODE' FIEL1 = 'TCD'.
          IF sy-subrc = 0.
            REPLACE ALL OCCURRENCES OF cv_tcode IN
            cs_rare_interface-rare_inci-short_description WITH
            cs_rare_interface-rare_inci-short_description.
            cv_tcode = ms_usr07_new-val01.
            cs_rare_interface-rare_inci-tcode = cv_tcode.
          ENDIF.
        ENDIF.
            """"

        IF cs_rare_interface-su53_info[] IS NOT INITIAL.
          MESSAGE w006(yz_msag_rare) INTO mv_text WITH sy-uname.
          collect_header_data( iv_header_type = 'BH' iv_header_msg = mv_text iv_header_criticality = 'M').
        ELSE.
*HEADER*
        ENDIF.

      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.

  ENDMETHOD.


  METHOD get_badi_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Get BADIs for a specific tcode
*&---------------------------------------------------------------------*

    DATA : mt_tadir    TYPE STANDARD TABLE OF tadir,
           ms_tadir    TYPE                   tadir,
           mv_devclass TYPE                   tadir-devclass,
           ms_tstc     TYPE                   tstc,
           ms_trdir    TYPE                   trdir,
           ms_tfdir    TYPE                   tfdir,
           ms_enlfdir  TYPE                   enlfdir,
           ms_tstct    TYPE                   tstct.

    DATA : mv_tcode    TYPE                   sy-tcode.

    DATA:   mo_oref_root  TYPE REF TO cx_root,
            mv_text       TYPE string,
            mv_badi_count TYPE i.

    TRY.

        IF iv_tcode IS INITIAL.
          mv_tcode = cv_tcode.
        ELSE.
          mv_tcode = iv_tcode.
        ENDIF.

        SELECT SINGLE *                                 "#EC CI_GENBUFF
          FROM tstc
          INTO ms_tstc
          WHERE tcode EQ mv_tcode.                      "#EC CI_GENBUFF

        IF sy-subrc = 0.

          SELECT SINGLE *                               "#EC CI_GENBUFF
            FROM tadir
            INTO ms_tadir
           WHERE pgmid = 'R3TR' AND
                 object = 'PROG' AND
                 obj_name = ms_tstc-pgmna.              "#EC CI_GENBUFF

          IF sy-subrc = 0.

            MOVE : ms_tadir-devclass TO mv_devclass.

            IF sy-subrc NE 0.

              SELECT SINGLE *                           "#EC CI_GENBUFF
                       FROM trdir
                       INTO ms_trdir
                      WHERE name = ms_tstc-pgmna.       "#EC CI_GENBUFF

              IF sy-subrc = 0 AND ms_trdir-subc EQ 'F'.

                SELECT SINGLE *                         "#EC CI_GENBUFF
                  FROM tfdir
                  INTO ms_tfdir
                 WHERE pname = ms_tstc-pgmna.           "#EC CI_GENBUFF

                IF sy-subrc = 0.

                  SELECT SINGLE *                       "#EC CI_GENBUFF
                    FROM enlfdir
                    INTO ms_enlfdir
                   WHERE funcname = ms_tfdir-funcname.  "#EC CI_GENBUFF

                  IF sy-subrc = 0.

                    SELECT SINGLE *                     "#EC CI_GENBUFF
                      FROM tadir
                      INTO ms_tadir
                     WHERE pgmid = 'R3TR' AND
                           object = 'FUGR' AND
                           obj_name EQ ms_enlfdir-area. "#EC CI_GENBUFF

                    IF sy-subrc = 0.

                      MOVE : ms_tadir-devclass TO mv_devclass.

                    ENDIF.

                  ENDIF.

                ENDIF.

              ENDIF.

            ENDIF.

          ENDIF.

          SELECT *                                      "#EC CI_GENBUFF
            FROM tadir
      INTO TABLE mt_tadir
           WHERE pgmid = 'R3TR' AND
                 object IN ('SXSD') AND
                 devclass = mv_devclass.                "#EC CI_GENBUFF

          IF sy-subrc = 0.

            SELECT SINGLE *                             "#EC CI_GENBUFF
              FROM tstct
              INTO ms_tstct
             WHERE sprsl EQ sy-langu AND
                   tcode EQ mv_tcode.                   "#EC CI_GENBUFF

            IF sy-subrc = 0 AND mt_tadir[] IS NOT INITIAL.

              et_badi[] = mt_tadir[].
              cs_rare_interface-badi[] = mt_tadir[].

              mv_badi_count = lines( cs_rare_interface-badi ).
              IF mv_badi_count > 0.
                MESSAGE i017(yz_msag_rare) INTO mv_text WITH mv_badi_count  mv_tcode.
                collect_header_data( iv_header_type = 'CH' iv_header_msg = mv_text iv_header_criticality = 'L').

              ELSE.
                MESSAGE i013(yz_msag_rare) INTO mv_text WITH mv_tcode.
                collect_header_data( iv_header_type = 'CH' iv_header_msg = mv_text iv_header_criticality = 'L').
              ENDIF.

            ENDIF.

          ENDIF.

        ENDIF.

      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.

  ENDMETHOD.


  METHOD get_buffer_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : ST02-Buffer data
*&---------------------------------------------------------------------*

    DATA:  mo_oref_root TYPE REF TO cx_root,
           mv_text      TYPE string,
           mt_outtab    TYPE yz_ttyp_st02_buffer,
           mo_data      TYPE REF TO data,
           mt_rsparams  TYPE TABLE OF rsparams,
           ms_rsparams  TYPE   rsparams ##NEEDED.

    FIELD-SYMBOLS: <ft_buffer> TYPE ANY TABLE.

    TRY.
        cl_salv_bs_runtime_info=>set(
         EXPORTING
           display  = abap_false
           metadata = abap_false
           data     = abap_true
        ).

        CLEAR   :  ms_rsparams.
        REFRESH :  mt_rsparams[].

        CALL FUNCTION 'SUBMIT_REPORT'
          EXPORTING
            report           = 'RSTUNE50'
            ret_via_leave    = abap_false
            skip_selscreen   = abap_true
          TABLES
            selection_table  = mt_rsparams
          EXCEPTIONS
            just_via_variant = 1
            no_submit_auth   = 2
            OTHERS           = 3.

        IF sy-subrc <> 0.
          CASE sy-subrc.
            WHEN 1.
              mv_text =   'Exception just_via_variant caught while running report RSTUNE50'(151).
              APPEND mv_text TO cs_rare_interface-exceptions.

            WHEN 2.
              mv_text =   'Exception no_submit_auth caught while running report RSTUNE50'(152).
              APPEND mv_text TO cs_rare_interface-exceptions.

            WHEN 3.
              mv_text =   'Exception OTHERS caught while running report RSTUNE50'(153).
              APPEND mv_text TO cs_rare_interface-exceptions.

          ENDCASE.
          collect_mesg( mv_text ).
          CLEAR mv_text.

        ENDIF.

        TRY.
            cl_salv_bs_runtime_info=>get_data_ref(
                IMPORTING
                  r_data = mo_data ).

          CATCH cx_salv_bs_sc_runtime_info.
            mv_text =   'Exception while running report RSTUNE50'(120).
            APPEND mv_text TO cs_rare_interface-exceptions.
            collect_mesg( mv_text ).
            CLEAR mv_text.
        ENDTRY.

        ASSIGN mt_outtab TO  <ft_buffer>.

        IF <ft_buffer> IS ASSIGNED  .
          ASSIGN mo_data->* TO  <ft_buffer>.
          IF  <ft_buffer> IS ASSIGNED AND <ft_buffer> IS NOT INITIAL  .
            cs_rare_interface-buffer_st02[] =  <ft_buffer>[].
          ENDIF.
        ENDIF.

        "Workitem details for past two days
        IF cs_rare_interface-buffer_st02[] IS INITIAL.
          MESSAGE i033(yz_msag_rare) INTO mv_text.
          collect_header_data( iv_header_type = 'YH' iv_header_msg = mv_text iv_header_criticality = 'L').
        ENDIF.



      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.

  ENDMETHOD.


  METHOD get_config_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Configuration details
*&---------------------------------------------------------------------*

    TYPES:BEGIN OF ty_text ,
            trkorr  TYPE e07t-trkorr,
            as4text TYPE e07t-as4text,
          END OF ty_text.

    DATA:   mo_oref_root   TYPE REF TO cx_root,
            mv_text        TYPE string,
            mt_config_data TYPE yz_ttyp_config_data,
            ms_config_data LIKE LINE OF  mt_config_data,
            mt_e070        TYPE e070_t,
            mv_date        TYPE sy-datum,
            mt_text        TYPE TABLE OF ty_text,
            ms_text        TYPE          ty_text.



    FIELD-SYMBOLS <fs_config_data> TYPE  LINE OF yz_ttyp_config_data .
    FIELD-SYMBOLS <fs_e070> TYPE LINE OF e070_t .


    TRY.

        mv_date = sy-datum - 20 .

        REFRESH mt_config_data .
        REFRESH cs_rare_interface-config_data.

        SELECT *
          FROM e070
    INTO TABLE mt_e070
         WHERE trfunction = 'W'
           AND as4date BETWEEN mv_date AND sy-datum.

        IF sy-subrc = 0 AND mt_e070 IS NOT INITIAL.

          SORT mt_e070 BY as4date DESCENDING as4time DESCENDING.

          SELECT trkorr as4text
            FROM e07t
      INTO TABLE mt_text
FOR ALL ENTRIES IN mt_e070
           WHERE trkorr = mt_e070-trkorr.

          IF sy-subrc = 0 AND mt_text IS NOT INITIAL.

            ASSIGN ms_config_data TO <fs_config_data> .

            IF <fs_config_data> IS ASSIGNED .

              LOOP AT mt_e070 ASSIGNING <fs_e070>.

                IF  <fs_e070> IS ASSIGNED .

                  READ TABLE mt_text
                        INTO ms_text
                TRANSPORTING as4text
                    WITH KEY trkorr =  <fs_e070>-trkorr.


                  MOVE <fs_e070>-trkorr     TO <fs_config_data>-trkorr.
                  MOVE <fs_e070>-trfunction TO <fs_config_data>-trfunction.
                  MOVE <fs_e070>-trstatus   TO  <fs_config_data>-trstatus.
                  MOVE <fs_e070>-tarsystem  TO  <fs_config_data>-tarsystem.
                  MOVE <fs_e070>-korrdev    TO  <fs_config_data>-korrdev.
                  MOVE <fs_e070>-as4user    TO  <fs_config_data>-as4user.
                  MOVE <fs_e070>-as4date    TO   <fs_config_data>-as4date.
                  MOVE <fs_e070>-as4time    TO   <fs_config_data>-as4time.
                  MOVE <fs_e070>-strkorr    TO   <fs_config_data>-strkorr.


                  <fs_config_data>-as4text =  ms_text-as4text   .

                  APPEND <fs_config_data>  TO mt_config_data.

                ENDIF.

              ENDLOOP.

            ENDIF.

            APPEND LINES OF mt_config_data FROM 1 TO 10 TO cs_rare_interface-config_data.

          ENDIF.
        ELSE.
          MESSAGE i011(yz_msag_rare) INTO mv_text WITH mv_date sy-datum.
          collect_header_data( iv_header_type = 'CH' iv_header_msg = mv_text iv_header_criticality = 'L').
        ENDIF.

      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.
  ENDMETHOD.


  METHOD get_container_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Get Container data
*&---------------------------------------------------------------------*

    DATA: mr_wi_handle TYPE REF TO if_swf_run_wim_internal,
          mr_cnt       TYPE REF TO if_swf_cnt_container,
          ms_data      TYPE yztabl_rare_interface.

    DATA :
      mo_oref TYPE REF TO cx_root,
      mv_text TYPE string.

    TRY.
* Get the instance of the workitem
        CALL METHOD cl_swf_run_wim_factory=>find_by_wiid
          EXPORTING
            im_wiid     = iv_wi_id
          RECEIVING
            re_instance = mr_wi_handle.

*Get the container
        mr_cnt = mr_wi_handle->get_wi_container( ).

* Get the required attribute from the container
        CALL METHOD mr_cnt->if_swf_ifs_parameter_container~get
          EXPORTING
            name  = 'RARE_DATA'
          IMPORTING
            value = ms_data.

        IF ms_data IS NOT INITIAL.
          es_rare_data = ms_data.
        ENDIF.

      CATCH cx_root INTO mo_oref.
        mv_text = mo_oref->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.

  ENDMETHOD.


  METHOD get_db_performance_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : ST04: Database performance check
*&---------------------------------------------------------------------*
    DATA:   mo_oref_root TYPE REF TO cx_root,
            mv_text      TYPE string.

    TRY.

*        CALL FUNCTION 'DB6_PM_1ST4'
*          EXPORTING
*            action                = '12'
*            partitn               = '0'
*          TABLES
*            it_db6pm1st4          = cs_rare_interface-st04
*          EXCEPTIONS
*            error_calculating     = 1
*            invalid_parameter_set = 2
*            adbc_error            = 3
*            OTHERS                = 4.
*
*        IF  sy-subrc <> 0.
*          CASE sy-subrc.
*            WHEN 1.
*              mv_text = 'error_calculating exception is catched while calling DB6_PM_1ST4 in GET_DB_PERFORMANCE_DATA.'(122).
*              APPEND mv_text TO cs_rare_interface-exceptions.
*              CLEAR mv_text.
*            WHEN 2.
*              mv_text = 'invalid_parameter_set exception is catched while calling DB6_PM_1ST4 in GET_DB_PERFORMANCE_DATA.'(123) .
*              APPEND mv_text TO cs_rare_interface-exceptions.
*              CLEAR mv_text.
*            WHEN 3.
*              mv_text = 'adbc_error  exception is catched while calling while calling DB6_PM_1ST4 in GET_DB_PERFORMANCE_DATA.'(124) .
*              APPEND mv_text TO cs_rare_interface-exceptions.
*              CLEAR mv_text.
*            WHEN 4.
*              mv_text = 'other exception is catched while calling while calling DB6_PM_1ST4 in GET_DB_PERFORMANCE_DATA.'(125) .
*              APPEND mv_text TO cs_rare_interface-exceptions.
*              CLEAR mv_text.
*          ENDCASE.
*        ENDIF.

      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.
  ENDMETHOD.


  METHOD get_dme_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       :
*&---------------------------------------------------------------------*
*Declaration
    DATA: mo_oref_root TYPE REF TO cx_root,
          mv_text      TYPE string.

    TRY.


      CATCH cx_root INTO mo_oref_root.
        mv_text = mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.
  ENDMETHOD.


  METHOD get_dump_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : ST22-Dump details
*&---------------------------------------------------------------------*

    DATA:  mo_oref_root TYPE REF TO cx_root,
           mv_text      TYPE string.
    DATA:  mv_day         TYPE d,
           mv_dumps_count TYPE i,
           ms_info        TYPE rsdumpinfo,
           mv_count       TYPE i.

    TRY.

        IF iv_date IS INITIAL.
          mv_day = sy-datum.
        ELSE.
          mv_day = iv_date.
        ENDIF.

        CALL FUNCTION 'RS_ST22_GET_DUMPS'
          EXPORTING
            p_day        = mv_day
          IMPORTING
            p_infotab    = cs_rare_interface-infotab
          EXCEPTIONS
            no_authority = 1
            OTHERS       = 2.

        IF sy-subrc <> 0.

          CASE sy-subrc.

            WHEN 1.
              mv_text = 'No authority exception is catched while calling RS_ST22_GET_DUMPS in GET_DUMP_DATA method.'(077).
              APPEND mv_text TO cs_rare_interface-exceptions.

            WHEN 2.
              mv_text = 'Others exception is catched while calling RS_ST22_GET_DUMPS in GET_DUMP_DATA method.'(078).
              APPEND mv_text TO cs_rare_interface-exceptions.

          ENDCASE.
          collect_mesg( mv_text ).
          CLEAR mv_text.
        ENDIF.

        mv_dumps_count = lines( cs_rare_interface-infotab ).
        LOOP AT cs_rare_interface-infotab INTO ms_info.
          IF ms_info-syuser = sy-uname ##USER_OK.
            mv_count = mv_count + 1.
          ENDIF.
        ENDLOOP.

        MESSAGE e004(yz_msag_rare) INTO mv_text WITH mv_dumps_count mv_count sy-uname.
        collect_header_data( iv_header_type = 'YH' iv_header_msg = mv_text iv_header_criticality = 'H').


      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.

    ENDTRY.

  ENDMETHOD.


  METHOD get_failed_excel_attachment.

    DATA: mo_oref_root TYPE REF TO cx_root,
          mv_text      TYPE string.

    DATA: mo_pdfobj      TYPE REF TO if_fp_pdf_object,
          mv_pdf         TYPE fpcontent,
          mx_fpex        TYPE REF TO cx_fp_runtime,
          mv_separator   TYPE c,
          mv_filename    TYPE skwf_filnm,
          mv_mimetype    TYPE skwf_mime,
          ms_attachment  TYPE sfpattachments,
          mt_attachments TYPE tfpattachments,
          mv_pdf_string  TYPE xstring.

    TRY.

*      Create PDF Object.
        mo_pdfobj = cl_fp=>get_reference( )->create_pdf_object( connection = cl_fp=>get_ads_connection( ) ).

*     Set document.
        mo_pdfobj->set_document( pdfdata = cs_rare_interface-xstring-pdf ).

*     Set attachment.
        ms_attachment-name = |Attachment { sy-uzeit }|.

        cl_gui_frontend_services=>get_file_separator( CHANGING file_separator = mv_separator ).

        ms_attachment-filename = segment( val = cs_failed_excel_attach-filename index = -1 sep = mv_separator ).

        mv_filename = ms_attachment-filename.

        CALL FUNCTION 'SKWF_MIMETYPE_OF_FILE_GET'
          EXPORTING
            filename = mv_filename
          IMPORTING
            mimetype = mv_mimetype.

        ms_attachment-mimetype    = mv_mimetype.

        ms_attachment-description = ms_attachment-name.

        ms_attachment-data =  cs_failed_excel_attach-data.

        ms_attachment-filesize = cs_failed_excel_attach-filesize.

        INSERT ms_attachment INTO TABLE mt_attachments.

        mo_pdfobj->set_attachments( attachments = mt_attachments ).

*     Execute, call ADS.
        mo_pdfobj->execute( ).

        mo_pdfobj->get_document( IMPORTING pdfdata = mv_pdf_string ).

        CLEAR cs_rare_interface-xstring-pdf.

        cs_rare_interface-xstring-pdf = mv_pdf_string.

      CATCH cx_root INTO mo_oref_root.
        mv_text = mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.

  ENDMETHOD.


  METHOD get_firefighter_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Get firefighter details
*&---------------------------------------------------------------------*
*Declaration
    DATA: mo_oref_root TYPE REF TO cx_root,
          mv_text      TYPE string.

    TRY.


      CATCH cx_root INTO mo_oref_root.
        mv_text = mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.

  ENDMETHOD.


  METHOD get_idoc_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : IDOC data
*&---------------------------------------------------------------------*
    TYPES :      BEGIN OF ty_edidc,
                   docnum TYPE edidc-docnum,
                   status TYPE edidc-status,
                   credat TYPE edidc-credat,
                   mestyp TYPE edidc-mestyp,
                 END OF ty_edidc.

    DATA:  mo_oref_root     TYPE REF TO cx_root,
           mv_text          TYPE string,

           "OUTBOUND
           mt_edidc         TYPE STANDARD TABLE OF ty_edidc,
           mt_delvry_os     TYPE STANDARD TABLE OF ty_edidc,
           mt_delvry_or     TYPE STANDARD TABLE OF ty_edidc,
           mt_delvry_oe     TYPE STANDARD TABLE OF ty_edidc,
           mt_orders_os     TYPE STANDARD TABLE OF ty_edidc,
           mt_orders_or     TYPE STANDARD TABLE OF ty_edidc,
           mt_orders_oe     TYPE STANDARD TABLE OF ty_edidc,
           mt_shpmnt_q_os   TYPE STANDARD TABLE OF ty_edidc,
           mt_shpmnt_q_or   TYPE STANDARD TABLE OF ty_edidc,
           mt_shpmnt_q_oe   TYPE STANDARD TABLE OF ty_edidc,
           mt_cond_q_os     TYPE STANDARD TABLE OF ty_edidc,
           mt_cond_q_or     TYPE STANDARD TABLE OF ty_edidc,
           mt_cond_q_oe     TYPE STANDARD TABLE OF ty_edidc,
           mt_shpmnt_os     TYPE STANDARD TABLE OF ty_edidc,
           mt_shpmnt_or     TYPE STANDARD TABLE OF ty_edidc,
           mt_shpmnt_oe     TYPE STANDARD TABLE OF ty_edidc,
           mt_others_os     TYPE STANDARD TABLE OF ty_edidc,
           mt_others_or     TYPE STANDARD TABLE OF ty_edidc,
           mt_others_oe     TYPE STANDARD TABLE OF ty_edidc,
           mt_tot_os        TYPE STANDARD TABLE OF ty_edidc,
           mt_tot_or        TYPE STANDARD TABLE OF ty_edidc,
           mt_tot_oe        TYPE STANDARD TABLE OF ty_edidc,

           "INBOUND
           mt_delvry_is     TYPE STANDARD TABLE OF ty_edidc,
           mt_delvry_ir     TYPE STANDARD TABLE OF ty_edidc,
           mt_delvry_ie     TYPE STANDARD TABLE OF ty_edidc,
           mt_orders_is     TYPE STANDARD TABLE OF ty_edidc,
           mt_orders_ir     TYPE STANDARD TABLE OF ty_edidc,
           mt_orders_ie     TYPE STANDARD TABLE OF ty_edidc,
           mt_shpmnt_q_is   TYPE STANDARD TABLE OF ty_edidc,
           mt_shpmnt_q_ir   TYPE STANDARD TABLE OF ty_edidc,
           mt_shpmnt_q_ie   TYPE STANDARD TABLE OF ty_edidc,
           mt_cond_q_is     TYPE STANDARD TABLE OF ty_edidc,
           mt_cond_q_ir     TYPE STANDARD TABLE OF ty_edidc,
           mt_cond_q_ie     TYPE STANDARD TABLE OF ty_edidc,
           mt_shpmnt_is     TYPE STANDARD TABLE OF ty_edidc,
           mt_shpmnt_ir     TYPE STANDARD TABLE OF ty_edidc,
           mt_shpmnt_ie     TYPE STANDARD TABLE OF ty_edidc,
           mt_others_is     TYPE STANDARD TABLE OF ty_edidc,
           mt_others_ir     TYPE STANDARD TABLE OF ty_edidc,
           mt_others_ie     TYPE STANDARD TABLE OF ty_edidc,
           mt_tot_is        TYPE STANDARD TABLE OF ty_edidc,
           mt_tot_ir        TYPE STANDARD TABLE OF ty_edidc,
           mt_tot_ie        TYPE STANDARD TABLE OF ty_edidc,
           ms_idoc_info_out TYPE yztabl_rare_idoc,
           ms_idoc_info_in  TYPE yztabl_rare_idoc,
           ms_edidc         TYPE ty_edidc,
           mv_date          TYPE sy-datum.

    TRY.

        mv_date = sy-datum.

        SELECT docnum status credat mestyp
          FROM edidc
    INTO TABLE mt_edidc
         WHERE upddat >= mv_date
*          AND mestyp IN ( 'ZDELVRY_QII' , 'ZORDERS_QII' , 'ZSHPMNT_QII' , 'ZCOND_QII' , 'ZSHPMNT' )
           AND credat  = mv_date
           AND cretim BETWEEN '000000' AND '240000'
          ORDER BY PRIMARY KEY.

        IF sy-subrc = 0.

          LOOP AT mt_edidc INTO ms_edidc.
            CASE ms_edidc-mestyp.

              WHEN 'ZDELVRY_QII'.
                CASE ms_edidc-status.
                  WHEN 01 OR 03  OR 12.
                    APPEND ms_edidc TO mt_delvry_os.
                  WHEN 30.
                    APPEND ms_edidc TO mt_delvry_or.
                  WHEN 02 OR 29.
                    APPEND ms_edidc TO mt_delvry_oe.
                  WHEN 51.
                    APPEND ms_edidc TO mt_delvry_ie.
                  WHEN 53.
                    APPEND ms_edidc TO mt_delvry_is.
                  WHEN 64.
                    APPEND ms_edidc TO mt_delvry_ir.
                ENDCASE.

              WHEN 'ZORDERS_QII'.
                CASE ms_edidc-status.
                  WHEN 01 OR 03  OR 12.
                    APPEND ms_edidc TO mt_orders_os.
                  WHEN 30.
                    APPEND ms_edidc TO mt_orders_or.
                  WHEN 02 OR 29.
                    APPEND ms_edidc TO mt_orders_oe.
                  WHEN 51.
                    APPEND ms_edidc TO mt_orders_ie.
                  WHEN 53.
                    APPEND ms_edidc TO mt_orders_is.
                  WHEN 64.
                    APPEND ms_edidc TO mt_orders_ir.
                ENDCASE.

              WHEN 'ZSHPMNT_QII'.
                CASE ms_edidc-status.
                  WHEN 01 OR 03  OR 12.
                    APPEND ms_edidc TO mt_shpmnt_q_os.
                  WHEN 30.
                    APPEND ms_edidc TO mt_shpmnt_q_or.
                  WHEN 02 OR 29.
                    APPEND ms_edidc TO mt_shpmnt_q_oe.
                  WHEN 51.
                    APPEND ms_edidc TO mt_shpmnt_q_ie.
                  WHEN 53.
                    APPEND ms_edidc TO mt_shpmnt_q_is.
                  WHEN 64.
                    APPEND ms_edidc TO mt_shpmnt_q_ir.
                ENDCASE.


              WHEN 'ZCOND_QII'.
                CASE ms_edidc-status.
                  WHEN 01 OR 03  OR 12.
                    APPEND ms_edidc TO mt_cond_q_os.
                  WHEN 30.
                    APPEND ms_edidc TO mt_cond_q_or.
                  WHEN 02 OR 29.
                    APPEND ms_edidc TO mt_cond_q_oe.
                  WHEN 51.
                    APPEND ms_edidc TO mt_cond_q_ie.
                  WHEN 53.
                    APPEND ms_edidc TO mt_cond_q_is.
                  WHEN 64.
                    APPEND ms_edidc TO mt_cond_q_ir.
                ENDCASE.

              WHEN 'ZSHPMNT'.
                CASE ms_edidc-status.
                  WHEN 01 OR 03  OR 12.
                    APPEND ms_edidc TO mt_shpmnt_os.
                  WHEN 30.
                    APPEND ms_edidc TO mt_shpmnt_or.
                  WHEN 02 OR 29.
                    APPEND ms_edidc TO mt_shpmnt_oe.
                  WHEN 51.
                    APPEND ms_edidc TO mt_shpmnt_ie.
                  WHEN 53.
                    APPEND ms_edidc TO mt_shpmnt_is.
                  WHEN 64.
                    APPEND ms_edidc TO mt_shpmnt_ir.
                ENDCASE.

              WHEN OTHERS.
                CASE ms_edidc-status.
                  WHEN 01 OR 03  OR 12.
                    APPEND ms_edidc TO mt_others_os.
                  WHEN 30.
                    APPEND ms_edidc TO mt_others_or.
                  WHEN 02 OR 29.
                    APPEND ms_edidc TO mt_others_oe.
                  WHEN 51.
                    APPEND ms_edidc TO mt_others_ie.
                  WHEN 53.
                    APPEND ms_edidc TO mt_others_is.
                  WHEN 64.
                    APPEND ms_edidc TO mt_others_ir.
                ENDCASE.


            ENDCASE.

            CASE ms_edidc-status.
              WHEN 01 OR 03  OR 12.
                APPEND ms_edidc TO mt_tot_os.
              WHEN 30.
                APPEND ms_edidc TO mt_tot_or.
              WHEN 02 OR 29.
                APPEND ms_edidc TO mt_tot_oe.
              WHEN 51.
                APPEND ms_edidc TO mt_tot_ie.
              WHEN 53.
                APPEND ms_edidc TO mt_tot_is.
              WHEN 64.
                APPEND ms_edidc TO mt_tot_ir.
            ENDCASE.

          ENDLOOP.

*HEADER*

        ELSE.
*HEADER*
          mv_text = 'No Data found from edidc table in GET_IDOC_DATA method'(089).
          APPEND mv_text TO cs_rare_interface-exceptions.
          collect_mesg( mv_text ).
          CLEAR mv_text.

        ENDIF.



        ms_idoc_info_out-mess_type = 'Total_idocs'(017).
        ms_idoc_info_out-success   =  lines( mt_tot_os ).
        ms_idoc_info_out-error     =  lines( mt_tot_oe ).
        ms_idoc_info_out-ready     =  lines( mt_tot_or ).
        APPEND ms_idoc_info_out TO cs_rare_interface-idoc_info_outbound.
        CLEAR ms_idoc_info_out.

        ms_idoc_info_in-mess_type = 'Total_idocs'(017).
        ms_idoc_info_in-success   =  lines( mt_tot_is ).
        ms_idoc_info_in-error     =  lines( mt_tot_ie ).
        ms_idoc_info_in-ready     =  lines( mt_tot_ir ).
        APPEND ms_idoc_info_in TO cs_rare_interface-idoc_info_inbound.
        CLEAR ms_idoc_info_in.

        ms_idoc_info_out-mess_type = 'ZDELVRY_QII'.
        ms_idoc_info_out-success   = lines( mt_delvry_os ).
        ms_idoc_info_out-error     = lines( mt_delvry_oe ).
        ms_idoc_info_out-ready     = lines( mt_delvry_or ).
        APPEND ms_idoc_info_out TO cs_rare_interface-idoc_info_outbound.
        CLEAR ms_idoc_info_out.

        ms_idoc_info_in-mess_type = 'ZDELVRY_QII'.
        ms_idoc_info_in-success   = lines( mt_delvry_is ).
        ms_idoc_info_in-error     = lines( mt_delvry_ie ).
        ms_idoc_info_in-ready     = lines( mt_delvry_ir ).
        APPEND ms_idoc_info_in TO cs_rare_interface-idoc_info_inbound.
        CLEAR ms_idoc_info_in.

        ms_idoc_info_out-mess_type = 'ZORDERS_QII'.
        ms_idoc_info_out-success   = lines( mt_orders_os ).
        ms_idoc_info_out-error     = lines( mt_orders_oe ).
        ms_idoc_info_out-ready     = lines( mt_orders_or ).
        APPEND ms_idoc_info_out TO cs_rare_interface-idoc_info_outbound.
        CLEAR ms_idoc_info_out.

        ms_idoc_info_in-mess_type = 'ZORDERS_QII'.
        ms_idoc_info_in-success   = lines( mt_orders_is ).
        ms_idoc_info_in-error     = lines( mt_orders_ie ).
        ms_idoc_info_in-ready     = lines( mt_orders_ir ).
        APPEND ms_idoc_info_in TO cs_rare_interface-idoc_info_inbound.
        CLEAR ms_idoc_info_in.

        ms_idoc_info_out-mess_type = 'ZSHPMNT_QII'.
        ms_idoc_info_out-success   = lines( mt_shpmnt_q_os ).
        ms_idoc_info_out-error     = lines( mt_shpmnt_q_oe ).
        ms_idoc_info_out-ready     = lines( mt_shpmnt_q_or ).
        APPEND ms_idoc_info_out TO cs_rare_interface-idoc_info_outbound.
        CLEAR ms_idoc_info_out.

        ms_idoc_info_in-mess_type = 'ZORDERS_QII'.
        ms_idoc_info_in-success   = lines( mt_shpmnt_q_is ).
        ms_idoc_info_in-error     = lines( mt_shpmnt_q_ie ).
        ms_idoc_info_in-ready     = lines( mt_shpmnt_q_ir ).
        APPEND ms_idoc_info_in TO cs_rare_interface-idoc_info_inbound.
        CLEAR ms_idoc_info_in.

        ms_idoc_info_out-mess_type = 'ZCOND_QII'.
        ms_idoc_info_out-success   = lines( mt_cond_q_os ).
        ms_idoc_info_out-error     = lines( mt_cond_q_oe ).
        ms_idoc_info_out-ready     = lines( mt_cond_q_or ).
        APPEND ms_idoc_info_out TO cs_rare_interface-idoc_info_outbound.
        CLEAR ms_idoc_info_out.

        ms_idoc_info_in-mess_type = 'ZCOND_QII'.
        ms_idoc_info_in-success   = lines( mt_cond_q_is ).
        ms_idoc_info_in-error     = lines( mt_cond_q_ie ).
        ms_idoc_info_in-ready     = lines( mt_cond_q_ir ).
        APPEND ms_idoc_info_in TO cs_rare_interface-idoc_info_inbound.
        CLEAR ms_idoc_info_in.

        ms_idoc_info_out-mess_type = 'ZSHPMNT'.
        ms_idoc_info_out-success   = lines( mt_shpmnt_os ).
        ms_idoc_info_out-error     = lines( mt_shpmnt_oe ).
        ms_idoc_info_out-ready     = lines( mt_shpmnt_or ).
        APPEND ms_idoc_info_out TO cs_rare_interface-idoc_info_outbound.
        CLEAR ms_idoc_info_out.

        ms_idoc_info_in-mess_type = 'ZSHPMNT'.
        ms_idoc_info_in-success    = lines( mt_shpmnt_is ).
        ms_idoc_info_in-error      = lines( mt_shpmnt_ie ).
        ms_idoc_info_in-ready      = lines( mt_shpmnt_ir ).
        APPEND ms_idoc_info_in TO cs_rare_interface-idoc_info_inbound.
        CLEAR ms_idoc_info_in.

        ms_idoc_info_out-mess_type = 'OTHERS'.
        ms_idoc_info_out-success   = lines( mt_others_os ).
        ms_idoc_info_out-error     = lines( mt_others_oe ).
        ms_idoc_info_out-ready     = lines( mt_others_or ).
        APPEND ms_idoc_info_out TO cs_rare_interface-idoc_info_outbound.
        CLEAR ms_idoc_info_out.

        ms_idoc_info_in-mess_type = 'OTHERS'.
        ms_idoc_info_in-success    = lines( mt_others_is ).
        ms_idoc_info_in-error      = lines( mt_others_ie ).
        ms_idoc_info_in-ready      = lines( mt_others_ir ).
        APPEND ms_idoc_info_in TO cs_rare_interface-idoc_info_inbound.
        CLEAR ms_idoc_info_in.

      CATCH cx_root INTO mo_oref_root.
        mv_text = mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.

  ENDMETHOD.


  METHOD get_inbound_queue_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Display the list of waiting inbound queues
*&---------------------------------------------------------------------*

    DATA:  mo_oref_root      TYPE REF TO cx_root,
           mv_text           TYPE string,
           mv_msg            TYPE string,
           mv_inboundq_count TYPE  i.

    TRY.

        CALL FUNCTION 'TRFC_QIN_GET_CURRENT_QUEUES'
          TABLES
            qview = cs_rare_interface-qview.

        IF cs_rare_interface-qview IS INITIAL.
          mv_msg = 'No current inbound queues'(018).
          collect_mesg( mv_msg ).
          MESSAGE i023(yz_msag_rare) INTO mv_text .
          collect_header_data( iv_header_type = 'MH' iv_header_msg = mv_text iv_header_criticality = 'L').

        ELSE.
          mv_inboundq_count = lines( cs_rare_interface-qview ).
          MESSAGE w024(yz_msag_rare) INTO mv_text WITH mv_inboundq_count.
          collect_header_data( iv_header_type = 'MH' iv_header_msg = mv_text iv_header_criticality = 'H').
        ENDIF.


      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.

  ENDMETHOD.


  METHOD get_incident_history_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Get incident history data
*&---------------------------------------------------------------------*
*Declaration
    DATA: mo_oref_root TYPE REF TO cx_root,
          mv_text      TYPE string.

    TRY.


      CATCH cx_root INTO mo_oref_root.
        mv_text = mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.

  ENDMETHOD.


  METHOD get_job_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : SM37- Batch job details
*&---------------------------------------------------------------------*
    CONSTANTS : mc_x        TYPE c VALUE 'X',
                mc_jobname1 TYPE string VALUE 'Z_HUB_MAC_REPRICING',
                mc_jobname2 TYPE string VALUE 'ZHUB_MAC_ALV_REP03',
                mc_jobname3 TYPE string VALUE 'ZHUB_MAC_CHECK_PROCES_ORD',
                mc_jobname4 TYPE string VALUE 'ZNYR_PM_ATP_CHECK',
                mc_jobname5 TYPE string VALUE 'ZHUB_MRA_EXPOSURE'.


    DATA: mv_jobsel_param_in TYPE btcselect,
          mv_today           TYPE sy-datum,
          mv_yesterday       TYPE sy-datum,
          mt_final           TYPE yz_ttyp_sm37_log,
          ms_final           LIKE LINE OF  mt_final,
          mv_duration        TYPE i,
          mv_delay           TYPE i,
          mv_status          TYPE char10.


    DATA:    mt_joblist    TYPE STANDARD TABLE OF tbtcjob_bk,
             ms_joblist    LIKE LINE OF  mt_joblist,
             mo_oref_root  TYPE REF TO cx_root,
             mv_text       TYPE string,
             mv_delta_date TYPE i,
             mv_delta_time TYPE i,
             mv_time_diff  TYPE i.



    TRY.
        mv_today   = sy-datum.

        mv_yesterday = mv_today - 1.

        mv_jobsel_param_in-jobname     =  '*'.
        mv_jobsel_param_in-username    =  '*'.
        mv_jobsel_param_in-from_date   =  mv_yesterday .
        mv_jobsel_param_in-to_date     =  mv_today .
*       mv_jobsel_param_in-schedul     =  mc_x.
*       mv_jobsel_param_in-ready       =  mc_x.
*       mv_jobsel_param_in-running     =  mc_x.
*       mv_jobsel_param_in-finished    =  mc_x.
        mv_jobsel_param_in-aborted     =  mc_x.

        CALL FUNCTION 'BP_JOB_SELECT_SM37B'
          EXPORTING
            jobselect_dialog    = 'N'
            jobsel_param_in     = mv_jobsel_param_in
          TABLES
            jobselect_joblist_b = mt_joblist
          EXCEPTIONS
            invalid_dialog_type = 1
            jobname_missing     = 2
            no_jobs_found       = 3
            selection_canceled  = 4
            username_missing    = 5
            OTHERS              = 6.

        IF sy-subrc = 0.

          SORT mt_joblist BY jobname sdluname strtdate strttime .

          CLEAR : ms_joblist, mv_delta_date,  mv_delta_time.
          LOOP AT mt_joblist INTO ms_joblist.

            mv_delta_date = ms_joblist-enddate - ms_joblist-strtdate.
            mv_delta_time = ms_joblist-endtime - ms_joblist-strttime.

            IF mv_delta_date < 0.                   " irregular situation
              mv_time_diff = 0.
            ELSEIF mv_delta_date > 2000.             " avoid overflow
              mv_time_diff = 0.
            ELSE.
              mv_time_diff = mv_delta_date * 86400 + mv_delta_time.
              IF mv_time_diff < 0.                  " irregular situation
                mv_time_diff = 0.
              ENDIF.
            ENDIF.

            mv_duration = mv_time_diff.
            CLEAR : mv_time_diff,  mv_delta_date, mv_delta_time.

            mv_delta_date = ms_joblist-strtdate  - ms_joblist-sdlstrtdt .
            mv_delta_time = ms_joblist-strttime  - ms_joblist-sdlstrttm .

            IF mv_delta_date < 0.                   " irregular situation
              mv_time_diff = 0.
            ELSEIF mv_delta_date > 2000.             " avoid overflow
              mv_time_diff = 0.
            ELSE.
              mv_time_diff = mv_delta_date * 86400 + mv_delta_time.
              IF mv_time_diff < 0.                  " irregular situation
                mv_time_diff = 0.
              ENDIF.
            ENDIF.

            mv_delay = mv_time_diff.
            CLEAR : mv_time_diff,  mv_delta_date, mv_delta_time.

            IF ms_joblist-status = 'F'.
              mv_status = 'Finished'(019).
            ELSEIF ms_joblist-status = 'A'.
              mv_status = 'Canceled'(020).
            ELSEIF ms_joblist-status = 'S'.
              mv_status = 'Realeased'(021).
            ELSEIF ms_joblist-status = 'R'.
              mv_status = 'Active'(022).
            ENDIF.

            ms_final-jobname     = ms_joblist-jobname.
            ms_final-sdluname    = ms_joblist-sdluname.
            ms_final-start_date  = ms_joblist-strtdate.
            ms_final-start_time  = ms_joblist-strttime.
            ms_final-status      = mv_status.
            ms_final-duration    = mv_duration.
            ms_final-delay       = mv_delay.

            APPEND ms_final TO mt_final.
            cs_rare_interface-sm37_log[] = mt_final[].
            CLEAR ms_final.

            IF ms_joblist-jobname =  mc_jobname1 OR
               ms_joblist-jobname =  mc_jobname2 OR
               ms_joblist-jobname =  mc_jobname3 OR
               ms_joblist-jobname =  mc_jobname4 OR
               ms_joblist-jobname =  mc_jobname5.

              ms_final-jobname     = ms_joblist-jobname.
              ms_final-sdluname    = ms_joblist-sdluname.
              ms_final-start_date  = ms_joblist-strtdate.
              ms_final-start_time  = ms_joblist-strttime.
              ms_final-status      = mv_status.
              ms_final-duration    = mv_duration.
              ms_final-delay       = mv_delay.

              APPEND ms_final TO cs_rare_interface-client_jobs.
            ENDIF.
          ENDLOOP.

          "Background jobs aborted in last two days
          IF cs_rare_interface-sm37_log IS NOT INITIAL.
            MESSAGE i014(yz_msag_rare) INTO mv_text.
            collect_header_data( iv_header_type = 'MH' iv_header_msg = mv_text iv_header_criticality = 'M').
          ENDIF.

        ELSE.

          CASE sy-subrc.

            WHEN 1.
              mv_text  = 'invalid_dialog_type while exception is captured calling BP_JOB_SELECT_SM37B in GET_JOB_DATA method '(079).
              APPEND mv_text TO cs_rare_interface-exceptions.

            WHEN 2.
              mv_text  = 'jobname_missing while exception is captured calling BP_JOB_SELECT_SM37B in GET_JOB_DATA method '(080).
              APPEND mv_text TO cs_rare_interface-exceptions.

            WHEN 3.
              mv_text  = 'no_jobs_found while exception is captured calling BP_JOB_SELECT_SM37B in GET_JOB_DATA method '(081).
              APPEND mv_text TO cs_rare_interface-exceptions.

            WHEN 4.
              mv_text  = 'selection_canceled exception is captured  while calling BP_JOB_SELECT_SM37B in GET_JOB_DATA method '(082).
              APPEND mv_text TO cs_rare_interface-exceptions.

            WHEN 5.
              mv_text  =  'username_missing exception is captured while calling BP_JOB_SELECT_SM37B in GET_JOB_DATA method '(083).
              APPEND mv_text TO cs_rare_interface-exceptions.

            WHEN 6.
              mv_text  = ' OTHERS exception is captured while calling BP_JOB_SELECT_SM37B in GET_JOB_DATA method '(084).
              APPEND mv_text TO cs_rare_interface-exceptions.

          ENDCASE.

          collect_mesg( mv_text ).
          CLEAR mv_text.
        ENDIF.

        "Exception handling
      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.

    ENDTRY.

  ENDMETHOD.


  METHOD get_latest_rare_status.
    rv_rare_action = cv_rare_action.
  ENDMETHOD.


  METHOD get_lock_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Display Lock details
*&---------------------------------------------------------------------*
    DATA:    mo_oref_root TYPE REF TO cx_root,
             mv_text      TYPE string,
             mt_enq       TYPE STANDARD TABLE OF seqg3,
             ms_enq       TYPE seqg3,
             mv_msg       TYPE string,
             mv_count     TYPE i,
             ms_sm12      TYPE yztabl_sm12_info.
    TRY.

        REFRESH cs_rare_interface-enq.

        CALL FUNCTION 'ENQUEUE_READ'
          EXPORTING
            guname                = '*'
          TABLES
            enq                   = mt_enq
          EXCEPTIONS
            communication_failure = 1
            system_failure        = 2.

        IF sy-subrc = 0 AND mt_enq[] IS NOT INITIAL.

          LOOP AT mt_enq INTO ms_enq.
            ms_sm12-gclient   = ms_enq-gclient.
            ms_sm12-gmode     = ms_enq-gmode.
            ms_sm12-gname     = ms_enq-gname.
            ms_sm12-gobj      = ms_enq-gobj.
            ms_sm12-gtcode    = ms_enq-gtcode.
            ms_sm12-gtdate    = ms_enq-gtdate.
            ms_sm12-gthost    = ms_enq-gthost.
            ms_sm12-gtsysnr   = ms_enq-gtsysnr.
            ms_sm12-gttime    = ms_enq-gttime.
            ms_sm12-gtusec    = ms_enq-gtusec.
            ms_sm12-gtwp      = ms_enq-gtusec.
            ms_sm12-guname    = ms_enq-guname.
            ms_sm12-gusetxt   = ms_enq-gusetxt.
            ms_sm12-gusevbt   = ms_enq-gusevbt.
            APPEND ms_sm12 TO cs_rare_interface-enq.
            CLEAR :  ms_sm12 ,ms_enq.
          ENDLOOP.

          mv_count = lines( cs_rare_interface-enq[] ).
          MESSAGE i035(yz_msag_rare) INTO mv_text WITH mv_count.
          collect_header_data( iv_header_type = 'SH' iv_header_msg = mv_text iv_header_criticality = 'L').
        ELSE.
          mv_msg = 'No lock data'(023) .
          collect_mesg( mv_msg ).
        ENDIF.

      CATCH cx_root INTO mo_oref_root.
        mv_text = mo_oref_root->get_text( ).
        APPEND  mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.
  ENDMETHOD.


  METHOD get_logged_in_user_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Details of users currently logged in the system
*&---------------------------------------------------------------------*
    DATA:  mo_oref_root  TYPE REF TO cx_root,
           mv_text       TYPE string,
           mv_user_count TYPE i.

    TRY.

        CALL FUNCTION 'TH_USER_LIST'
          TABLES
            list          = cs_rare_interface-uinfo
            usrlist       = cs_rare_interface-userlist
          EXCEPTIONS
            auth_misssing = 1
            OTHERS        = 2.

        IF sy-subrc = 0.
          IF cs_rare_interface-userlist IS NOT INITIAL.
            mv_user_count = lines( cs_rare_interface-userlist ).
            MESSAGE i021(yz_msag_rare) INTO mv_text WITH mv_user_count sy-sysid.
            collect_header_data( iv_header_type = 'BH' iv_header_msg = mv_text iv_header_criticality = 'M').

          ELSE.
            MESSAGE i022(yz_msag_rare) INTO mv_text WITH sy-sysid.
            collect_header_data( iv_header_type = 'BH' iv_header_msg = mv_text iv_header_criticality = 'L').
          ENDIF.


        ELSE.
          CASE sy-subrc.
            WHEN 1.
              mv_text = 'Auth_missing exception is catched while calling TH_USER_LIST in GET_LOGGED_IN_USER_DATA'(085).
              APPEND mv_text TO cs_rare_interface-exceptions.

            WHEN 2.
              mv_text = 'Others exception is catched while calling TH_USER_LIST in GET_LOGGED_IN_USER_DATA'(086).
              APPEND mv_text TO cs_rare_interface-exceptions.

          ENDCASE.
          collect_mesg( mv_text ).
          CLEAR mv_text.
        ENDIF.



      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.

  ENDMETHOD.


  METHOD get_logo.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Get logo
*&---------------------------------------------------------------------*

    DATA: mv_object    TYPE tdobjectgr,
          mv_name      TYPE tdobname,
          mv_id        TYPE tdidgr,
          mv_btype     TYPE tdbtype,
          mo_oref_root TYPE REF TO cx_root,
          mv_text      TYPE string,
          ms_rare_swch TYPE yztabl_rare_swch.


    mv_object  = 'GRAPHICS'.
    mv_id      = 'BMAP'.
    mv_btype   = 'BCOL'.
    cs_rare_interface-logo_mime = 'image/png'(015).

    TRY.

        "Get logo name and watermark name from switch table
        SORT ct_rare_swch .
        READ TABLE ct_rare_swch INTO DATA(ls_data) TRANSPORTING ALL FIELDS WITH KEY  obj_name  = 'GET_LOGO'
                                                                                     task_name = 'LOGO_DETERMINATION'
                                                                                     vakey1    = 'LOGO_NAME'
                                                                                     active    = abap_true
                                                                                     BINARY SEARCH.
*                                                            TRANSPORTING vadata1.

        IF sy-subrc = 0 AND ls_data-vadata1 IS NOT INITIAL.
          mv_name = ls_data-vadata1."'CG_LOGO_AUTOMATION'.

          CALL METHOD cl_ssf_xsf_utilities=>get_bds_graphic_as_bmp
            EXPORTING
              p_object       = mv_object
              p_name         = mv_name
              p_id           = mv_id
              p_btype        = mv_btype
            RECEIVING
              p_bmp          = cs_rare_interface-logo
            EXCEPTIONS
              not_found      = 1
              internal_error = 2.

          IF sy-subrc <> 0.
            CASE sy-subrc.
              WHEN 1.
                mv_text  =   'Exception not_found caught while running  method GET_LOGO in YZ_CLAS_RARE_BASE'(168).
                APPEND mv_text  TO cs_rare_interface-exceptions.
                CLEAR mv_text .

              WHEN 2.
                mv_text  =   'Exception  internal_error caught while running method GET_LOGO in YZ_CLAS_RARE_BASE'(169).
                APPEND mv_text  TO  cs_rare_interface-exceptions.
                CLEAR mv_text .

            ENDCASE.
            collect_mesg( mv_text ).
            CLEAR mv_text.
          ENDIF.
        ELSE.
          mv_text = 'Error in getting logo while running method GET_LOGO in YZ_CLAS_RARE_BASE'(015).
          collect_mesg( mv_text ).
          APPEND mv_text TO cs_rare_interface-exceptions.
          CLEAR mv_text.
        ENDIF.

      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.


    TRY.
        CLEAR : ms_rare_swch , mv_name.
        READ TABLE ct_rare_swch INTO ls_data TRANSPORTING ALL FIELDS WITH KEY  obj_name  = 'GET_LOGO'
                                                                               task_name = 'WATERMARK_DETERMINATION'
                                                                               vakey1    = 'WATERMARK_NAME'
                                                                               active    = abap_true
                                                                               BINARY SEARCH.
*                                                            TRANSPORTING vadata1.

        IF  sy-subrc = 0 AND ls_data-vadata1 IS NOT INITIAL.

          mv_name = ls_data-vadata1."'ZNY_WATERMARK'.

          cs_rare_interface-watermark_mime = 'image/bmp'(016).

          CALL METHOD cl_ssf_xsf_utilities=>get_bds_graphic_as_bmp
            EXPORTING
              p_object       = mv_object
              p_name         = mv_name
              p_id           = mv_id
              p_btype        = mv_btype
            RECEIVING
              p_bmp          = cs_rare_interface-watermark
            EXCEPTIONS
              not_found      = 1
              internal_error = 2.


          IF sy-subrc <> 0.
            CASE sy-subrc.
              WHEN 1.
                mv_text  =   'Exception not_found caught while running  method GET_LOGO in YZ_CLAS_RARE_BASE'(168).
                APPEND mv_text  TO cs_rare_interface-exceptions.
                CLEAR mv_text .

              WHEN 2.
                mv_text  =   'Exception  internal_error caught while running method GET_LOGO in YZ_CLAS_RARE_BASE'(169).
                APPEND mv_text  TO  cs_rare_interface-exceptions.
                CLEAR mv_text .

            ENDCASE.
          ENDIF.

        ELSE.
          mv_text  =   'Error in getting watermark while running method GET_LOGO in YZ_CLAS_RARE_BASE'(170).
          APPEND mv_text  TO  cs_rare_interface-exceptions.
          collect_mesg( mv_text ).
          CLEAR mv_text .
        ENDIF.

      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.

  ENDMETHOD.


  METHOD get_message_where_used_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Message details
*&---------------------------------------------------------------------*

    DATA:   mo_oref_root         TYPE REF TO cx_root,
            mv_text              TYPE string,
            mt_message_whereused TYPE                   yz_ttyp_msg_whereused,
            ms_message_whereused LIKE LINE OF           mt_message_whereused,
            mv_msg               TYPE char200,
            mt_text              TYPE STANDARD TABLE OF bapitgb,
            mv_full_msg          TYPE bapiret2-message,
            ms_return            TYPE bapiret2 ##NEEDED,
            mv_count             TYPE i.


    TRY.

        IF is_msg IS NOT INITIAL.
          CLEAR : mv_msg, ms_message_whereused.
          REFRESH : mt_message_whereused[].

          CALL FUNCTION 'BAPI_MESSAGE_GETDETAIL'
            EXPORTING
              id                    = is_msg-msgid
              number                = is_msg-msgno
*             language              = sy-langu
              textformat            = 'NON'
              message_v1            = is_msg-msgv1
              message_v2            = is_msg-msgv2
              message_v3            = is_msg-msgv3
              message_v4            = is_msg-msgv4
            IMPORTING
              message               = mv_full_msg
              return                = ms_return
            TABLES
              text                  = mt_text
            EXCEPTIONS
              communication_failure = 1
              system_failure        = 2.

          IF sy-subrc = 0 AND mv_full_msg IS NOT INITIAL.
            mv_msg = mv_full_msg.

            ms_message_whereused-msg       = mv_msg.
            ms_message_whereused-msg_typ   = is_msg-msgty.
            ms_message_whereused-user_name = sy-uname.
            ms_message_whereused-tcode     = cv_tcode.
            GET TIME STAMP FIELD ms_message_whereused-timestamp.

            IF ms_message_whereused-msg_typ = 'E'.
              mv_text = mv_msg.
              collect_rca_data( iv_mesg = mv_text ).
            ENDIF.

            APPEND ms_message_whereused          TO mt_message_whereused.
            APPEND LINES OF mt_message_whereused TO  cs_rare_interface-msg_whereused[].

            SORT cs_rare_interface-msg_whereused BY msg ASCENDING.
            DELETE ADJACENT DUPLICATES FROM cs_rare_interface-msg_whereused COMPARING msg.

            SORT cs_rare_interface-msg_whereused BY timestamp ASCENDING.

            mv_count = lines( cs_rare_interface-msg_whereused ).

            MESSAGE i036(yz_msag_rare) INTO mv_text WITH mv_count sy-uname.
            collect_header_data( iv_header_type = 'IH' iv_header_msg = mv_text iv_header_criticality = 'H').

          ELSE.
*ELSE*
          ENDIF.
        ENDIF.

** Use FM CRMOST_WHERE_USED_LIST

      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.

  ENDMETHOD.


  METHOD get_modification_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Get possible modification points
*&---------------------------------------------------------------------*


    TYPES : BEGIN OF ty_adir,
              obj_name TYPE adiraccess-obj_name,
            END OF ty_adir.


    DATA:  mo_oref_root TYPE REF TO cx_root,
           mv_text      TYPE string,
           mt_adir      TYPE STANDARD TABLE OF ty_adir,
           mv_mod_count TYPE  i.


    TRY.

        SELECT obj_name
          FROM adiraccess
    INTO TABLE mt_adir
         WHERE pgmid = 'R3TR'.

        IF sy-subrc = 0 AND mt_adir IS NOT  INITIAL .

          SELECT *
            FROM trdir
      INTO TABLE et_mod_objects
FOR ALL ENTRIES IN mt_adir
           WHERE name = mt_adir-obj_name.

          IF  sy-subrc = 0 AND et_mod_objects IS NOT INITIAL.
            SORT et_mod_objects BY udat DESCENDING stime DESCENDING.
            APPEND LINES OF et_mod_objects FROM 1 TO 5 TO cs_rare_interface-mod_object.

            mv_mod_count = lines( cs_rare_interface-mod_object ).
            MESSAGE w020(yz_msag_rare) INTO mv_text WITH mv_mod_count .
            collect_header_data( iv_header_type = 'CH' iv_header_msg = mv_text iv_header_criticality = 'M').

          ELSE.
            MESSAGE i019(yz_msag_rare) INTO mv_text .
            collect_header_data( iv_header_type = 'CH' iv_header_msg = mv_text iv_header_criticality = 'L').

          ENDIF.
        ENDIF.
      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.
  ENDMETHOD.


  METHOD get_multiple_images.

    DATA:  mv_ans,
           mo_oref_root TYPE REF TO cx_root,
           mv_text      TYPE string.

    TRY.

        RECEIVE RESULTS FROM FUNCTION 'YZ_FUNC_MULTI_SCREEN_SHOTS'
         CHANGING
          cv_ans  = mv_ans.


        IF  mv_ans = 1..
          cv_multiscreen_flag = 1.
        ELSE.
          cv_multiscreen_flag = 2.
        ENDIF.

      CATCH cx_root INTO mo_oref_root.
        mv_text = mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.


  ENDMETHOD.


  METHOD get_multiple_screen_shots.
*
*    DATA : mv_text          TYPE string,
*           mo_oref_root     TYPE REF TO cx_root,
*           mv_mime_type_str TYPE string,
*           mv_image         TYPE xstring,
*           ms_screen_shots  LIKE LINE OF ct_multiple_screens_shots,
*           mv_graphic_size  TYPE i.
*
*    TRY.
*
*        CALL FUNCTION 'RM_FREE_SESSION_CHECK'
*          EXCEPTIONS
*            no_free_session = 1
*            OTHERS          = 2.
*
*        IF sy-subrc = 0.
*
*
*          cv_screen_count = cv_screen_count + 1.
*
*          CALL FUNCTION 'YZ_FUNC_MULTI_SCREEN_SHOTS'
*          STARTING NEW TASK 'NEW'
*          DESTINATION 'NONE'
*          CALLING get_multiple_images ON END OF TASK.
*
*
*          WAIT FOR ASYNCHRONOUS TASKS UNTIL cv_multiscreen_flag IS NOT INITIAL .
*
*          IF cv_multiscreen_flag = 1.
*
*            cl_gui_frontend_services=>get_screenshot(
*            IMPORTING
*              mime_type_str        = mv_mime_type_str
*              image                = mv_image
*            EXCEPTIONS
*              access_denied        = 1
*              cntl_error           = 2
*              error_no_gui         = 3
*              not_supported_by_gui = 4
*              OTHERS               = 5      ).
*
*            CLEAR ms_screen_shots.
*            ms_screen_shots-sequesnce     = cv_screen_count.
*            ms_screen_shots-image         = mv_image.
*            ms_screen_shots-mime_type_str = mv_mime_type_str.
*            APPEND ms_screen_shots TO ct_multiple_screens_shots.
*
*            CLEAR cv_multiscreen_flag.
*
*            get_multiple_screen_shots( ).
*
*
*          ELSE.
**            cv_multiscreen_flag = abap_true.
*
*          ENDIF.
*
*        ELSE. "No free session
*          MESSAGE 'No free session available' TYPE 'I'.
**          cv_multiscreen_flag = abap_true.
*        ENDIF.
*
*      CATCH cx_root INTO mo_oref_root.
*        mv_text = mo_oref_root->get_text( ).
*        APPEND mv_text TO cs_rare_interface-exceptions.
*        collect_mesg( mv_text ).
*        CLEAR mv_text.
*    ENDTRY.
  ENDMETHOD.


  METHOD get_nast_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Get nast data
*&---------------------------------------------------------------------*
    DATA: mt_nast      TYPE yz_ttyp_nast_details,
          mt_nast1     TYPE yz_ttyp_nast_details,
          mo_oref_root TYPE REF TO cx_root,
          mv_text      TYPE string.

    DATA: mv_line  TYPE i.

    TRY.

        SELECT kappl objky kschl spras parnr parvw erdat eruhr usnam vstat aktiv tcode ldest objtype
          FROM nast
    INTO TABLE mt_nast
         WHERE kappl EQ 'RW'
           AND erdat EQ sy-datum.

        IF sy-subrc EQ 0.

          SORT mt_nast BY eruhr DESCENDING.

          mt_nast1[] = mt_nast[].
          DELETE mt_nast1 WHERE usnam NE sy-uname.

          DELETE mt_nast WHERE usnam EQ sy-uname.
          DESCRIBE TABLE mt_nast LINES mv_line.

          IF mv_line GT 20.
            DELETE mt_nast FROM 21.
          ENDIF.

        ENDIF.

      CATCH cx_root INTO mo_oref_root.
        mv_text = mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.

    ENDTRY.
  ENDMETHOD.


  METHOD get_outbound_queue_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Display the error outbound queues
*&---------------------------------------------------------------------*

    DATA: mo_oref_root       TYPE REF TO cx_root,
          mv_text            TYPE string,
          mv_msg             TYPE string,
          mv_outboundq_count TYPE i.

    TRY .

        CALL FUNCTION 'TRFC_QOUT_GET_CURRENT_QUEUES'
          EXPORTING
            qname  = '*'
            dest   = '*'
            client = sy-mandt
            nosend = 'X'
          TABLES
            qview  = cs_rare_interface-qtable.

        IF cs_rare_interface-qtable IS INITIAL.
          IF cs_rare_interface-callstack IS NOT INITIAL.
            mv_msg = 'No outbound Error Queues found'(025).
            collect_mesg( mv_msg ).
          ENDIF.

          MESSAGE i025(yz_msag_rare) INTO mv_text .
          collect_header_data( iv_header_type = 'MH' iv_header_msg = mv_text iv_header_criticality = 'L').

        ELSE.
          mv_outboundq_count = lines( cs_rare_interface-qtable ).
          MESSAGE w026(yz_msag_rare) INTO mv_text WITH mv_outboundq_count.
          collect_header_data( iv_header_type = 'MH' iv_header_msg = mv_text iv_header_criticality = 'H').
        ENDIF.


      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.

  ENDMETHOD.


  METHOD get_pdf_form.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Display PDF form
*&---------------------------------------------------------------------*

    DATA: mo_oref_root TYPE REF TO cx_root,
          mv_text      TYPE string.

    DATA: mv_subrc                      TYPE sy-subrc.

    TRY.
*progress Bar
        CALL METHOD cl_progress_indicator=>progress_indicate
          EXPORTING
            i_text               = 'Generating Final PDF'(027)
            i_output_immediately = abap_true
            i_processed          = 1
            i_total              = 3.

*Checking the call - Internal or External
        IF is_rare_inci IS SUPPLIED.
          IF is_rare_inci IS NOT INITIAL.
            CLEAR cs_rare_interface.
            get_container_data( EXPORTING iv_wi_id     = sync_workitem( is_rare_inci )
                                IMPORTING es_rare_data = cs_rare_interface ).
            cs_rare_interface-rare_inci = is_rare_inci.
            cs_rare_interface-rare_inci-user_name = sy-uname.
          ENDIF.
        ENDIF.


        IF get_adobe_function_module_name( ) IS NOT INITIAL.
          cv_outputparams-nodialog = abap_true.
          cv_outputparams-preview  = abap_false.
          cv_outputparams-getpdf   = abap_true.

          IF iv_view IS SUPPLIED.
            IF iv_view = abap_true.
              cv_outputparams-dest     = 'LP01'.
              cv_outputparams-nodialog = abap_true.
              cv_outputparams-preview  = abap_true.
              cv_outputparams-getpdf   = abap_false.
            ENDIF.
          ENDIF.

          IF open_pdf_job( ) = 0.

            CALL METHOD cl_progress_indicator=>progress_indicate
              EXPORTING
                i_text               = 'Generating Final PDF'(027)
                i_output_immediately = abap_true
                i_processed          = 2
                i_total              = 3.

            cv_docparams-dynamic  = 'X'.
            cv_docparams-fillable = 'X'.

            IF bind_pdf_data( ) <> 0.
              close_pdf_job( ).
              IF retry_pdf_form( ) <> 0.
                IF recover_pdf_form( ) = 0.
                  CALL METHOD cl_progress_indicator=>progress_indicate
                    EXPORTING
                      i_text               = 'PDF Generated Successfully'(026)
                      i_output_immediately = abap_true
                      i_processed          = 2
                      i_total              = 4.
                ENDIF.
              ENDIF.
            ELSE.
              close_pdf_job( ).
            ENDIF.
          ENDIF.
        ENDIF.

      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.

  ENDMETHOD.


  METHOD get_prepared_attachment.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Fetch prepared attachment
*&---------------------------------------------------------------------*

    DATA:  mo_oref_root TYPE REF TO cx_root,
           mv_text      TYPE string.
    TRY.

        CALL METHOD cl_progress_indicator=>progress_indicate
          EXPORTING
            i_text               = 'Converting PDF To Base64'(028)
            i_output_immediately = abap_true
            i_processed          = 2
            i_total              = 3.


        IF cs_rare_interface-xstring-pdf IS INITIAL.
          MESSAGE 'Issue While Generating pdf - Converted PDF is empty - Kindly retry with Tcode : YZ_TRAN_RARE_MANAGE'(030) TYPE 'I'.
        ELSE.

          CALL FUNCTION 'SSFC_BASE64_ENCODE'
            EXPORTING
              bindata                  = cs_rare_interface-xstring-pdf
            IMPORTING
              b64data                  = cs_rare_interface-pdf
            EXCEPTIONS
              ssf_krn_error            = 1
              ssf_krn_noop             = 2
              ssf_krn_nomemory         = 3
              ssf_krn_opinv            = 4
              ssf_krn_input_data_error = 5
              ssf_krn_invalid_par      = 6
              ssf_krn_invalid_parlen   = 7
              OTHERS                   = 8.

          IF sy-subrc <> 0 OR cs_rare_interface-pdf IS INITIAL .
            mv_text = 'Error while getting prepared attachment'(029).
            APPEND mv_text TO cs_rare_interface-exceptions.
            collect_mesg( mv_text ).
            CLEAR mv_text.
          ENDIF.

        ENDIF.

      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.
  ENDMETHOD.


  METHOD get_printer_config_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Printer Configuration data
*&---------------------------------------------------------------------*

    DATA:  mo_oref_root TYPE REF TO cx_root,
           mv_text      TYPE string.

    DATA : mv_name TYPE rspopshort.


    TRY.
        CALL FUNCTION 'ADS_GET_PRINTER_DEFAULTS'
          EXPORTING
            bname      = sy-uname
          IMPORTING
            sname      = mv_name
          EXCEPTIONS
            wrong_user = 1
            OTHERS     = 2.

        IF sy-subrc = 0 AND mv_name IS NOT INITIAL .
          CALL FUNCTION 'SPCPC_I_PICK_PRINTER_INFO'
            EXPORTING
              iv_printer = mv_name
            IMPORTING
              ev_tsp03d  = cs_rare_interface-printer_info
            EXCEPTIONS
              not_found  = 1
              OTHERS     = 2.
          IF sy-subrc <> 0.
            CASE sy-subrc.
              WHEN 1.
                mv_text = 'not_found exception is catched while calling SPCPC_I_PICK_PRINTER_INFO in GET_PRINTER_CONFIG_DATA method.'(094).
                APPEND mv_text TO cs_rare_interface-exceptions.

              WHEN 2.
                mv_text = 'Others exception is catched while calling SPCPC_I_PICK_PRINTER_INFO in GET_PRINTER_CONFIG_DATA method.'(095).
                APPEND mv_text TO cs_rare_interface-exceptions.

            ENDCASE.
            collect_mesg( mv_text ).
            CLEAR mv_text.
          ELSE.
*HEADER*
          ENDIF.

        ELSE.
          CASE sy-subrc.
            WHEN 1.
              mv_text = 'wrong_user exception is catched while calling ADS_GET_PRINTER_DEFAULTS in GET_PRINTER_CONFIG_DATA method.'(096).
              APPEND mv_text TO cs_rare_interface-exceptions.

            WHEN 2.
              mv_text = 'Others exception is catched while calling ADS_GET_PRINTER_DEFAULTS in GET_PRINTER_CONFIG_DATA method.'(097).
              APPEND mv_text TO cs_rare_interface-exceptions.

          ENDCASE.
          collect_mesg( mv_text ).
          CLEAR mv_text.
        ENDIF.

      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.
  ENDMETHOD.


  METHOD get_print_screen_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Get Print Screen data
*&---------------------------------------------------------------------*
    DATA:
      mo_oref_root TYPE REF TO cx_root,
      mv_text      TYPE string.

    DATA:
          mv_graphic_size TYPE i.

    DATA:
          mt_doc_content  TYPE solix_tab ##NEEDED.

    TRY.
        "secure tcode to skip print screen automatically
        IF  cs_rare_sec IS INITIAL.

          cl_gui_frontend_services=>get_screenshot(
          IMPORTING
            mime_type_str        =  cs_rare_interface-mime
            image                =  cs_rare_interface-data
          EXCEPTIONS
            access_denied        = 1
            cntl_error           = 2
            error_no_gui         = 3
            not_supported_by_gui = 4
            OTHERS               = 5
            ).


          IF sy-subrc = 0.

            mv_graphic_size = xstrlen( cs_rare_interface-data ).
            IF mv_graphic_size > 0.

              CALL METHOD cl_bcs_convert=>xstring_to_solix
                EXPORTING
                  iv_xstring = cs_rare_interface-data
                RECEIVING
                  et_solix   = mt_doc_content
                EXCEPTIONS
                  OTHERS     = 1.

              MESSAGE w037(yz_msag_rare) INTO mv_text .
              collect_header_data( iv_header_type = 'IH' iv_header_msg = mv_text iv_header_criticality = 'L').
            ENDIF.

*            get_multiple_screen_shots( ).
*            WAIT UNTIL cv_multiscreen_flag = abap_true.

          ELSE.
*EXCEption HANDLING ?
*HEADER*
            MESSAGE w034(yz_msag_rare) INTO mv_text .
            collect_header_data( iv_header_type = 'IH' iv_header_msg = mv_text iv_header_criticality = 'L').

          ENDIF.

        ELSE.
          MESSAGE w046(yz_msag_rare) INTO mv_text .
          collect_header_data( iv_header_type = 'IH' iv_header_msg = mv_text iv_header_criticality = 'L').
        ENDIF.

        IF cs_rare_interface-data IS INITIAL.
          MESSAGE w000(yz_msag_rare) INTO mv_text WITH sy-uname.
          collect_header_data( iv_header_type = 'IH' iv_header_msg = mv_text iv_header_criticality = 'L').
        ENDIF.

      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.

  ENDMETHOD.


  METHOD get_proxy_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Proxy data
*&---------------------------------------------------------------------*
    DATA:   mo_oref_root TYPE REF TO cx_root,
            mv_text      TYPE string.

    TRY.


      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.
  ENDMETHOD.


  METHOD get_rare_incident_header.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       :  Get header details of  incident
*&---------------------------------------------------------------------*

*Declaration
    DATA: mo_oref_root TYPE REF TO cx_root,
          mv_text      TYPE string.

    TRY.
        cs_rare_interface-rare_inci-guid = cv_guid = generate_guid( ).
        cs_rare_interface-rare_inci-user_name  =  sy-uname.
        cs_rare_interface-rare_inci-tcode      =  cv_tcode .
        GET TIME STAMP FIELD cs_rare_interface-rare_inci-req_timestamp.


      CATCH cx_root INTO mo_oref_root.
        mv_text = mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.
  ENDMETHOD.


  method GET_RARE_SERVICE_HEADER.
*{   INSERT         DIMK902864                                        1
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Get Header Details of Service
*&---------------------------------------------------------------------*

*Declaration
    DATA: mo_oref_root TYPE REF TO cx_root,
          mv_text      TYPE string.

    TRY.
        cs_rare_interface-rare_srvc-guid       = cv_guid = generate_guid( ).
        cs_rare_interface-rare_srvc-user_name  = sy-uname.
        cs_rare_interface-rare_srvc-tcode      = cv_tcode.
        GET TIME STAMP FIELD cs_rare_interface-rare_srvc-req_timestamp.


      CATCH cx_root INTO mo_oref_root.
        mv_text = mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.
*}   INSERT
  endmethod.


  METHOD get_rfc_dest_data ##NEEDED.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Fetch details of RFC destination
*&---------------------------------------------------------------------*

  ENDMETHOD.


  METHOD get_root_cause_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Root cause analysis details
*&---------------------------------------------------------------------*

    DATA : mo_oref_root TYPE REF TO cx_root,
           mv_text      TYPE string,
           ms_msg       TYPE yztabl_msg_collect_info,
           ms_rca       TYPE yztabl_rare_rca,
           count        TYPE i,
           ms_enq       TYPE yztabl_sm12_info,
           dumps        TYPE i,
           ms_info      TYPE rsdumpinfo,
           ms_header    LIKE LINE OF cs_rare_interface-issue_header.

    TRY.

*message collected from RaRe Execution
        SORT cs_rare_interface-msg_info.
        DELETE ADJACENT DUPLICATES FROM cs_rare_interface-msg_info COMPARING ALL FIELDS.
        LOOP AT cs_rare_interface-msg_info INTO ms_msg.
          IF ms_msg-type  = 'E'
*         or ms_msg-type = 'W'
*         or ms_msg-type = 'U'
              .
            GET TIME STAMP FIELD ms_rca-timestamp.
            ms_rca-user   = sy-uname.
            ms_rca-action = ms_msg-message.
            APPEND ms_rca TO cs_rare_interface-rca.
          ENDIF.
        ENDLOOP.


*Lock Details
        LOOP AT cs_rare_interface-enq INTO  ms_enq.
          IF ms_enq-gtcode = cv_tcode AND ms_enq-guname <> sy-uname ##USER_OK.

            GET TIME STAMP FIELD ms_rca-timestamp.
            ms_rca-user   = ms_enq-guname.
            CONCATENATE 'The user'(064) ms_enq-guname 'has locked entries of'(065) ms_enq-gtcode
            INTO ms_rca-action
            SEPARATED BY space.
            APPEND ms_rca TO cs_rare_interface-rca.

          ENDIF.
        ENDLOOP.

*Issue Header
        LOOP AT cs_rare_interface-issue_header INTO ms_header.
          IF ms_header-criticality = 'HIGH'.
            mv_text = ms_header-message.
            collect_rca_data( iv_mesg = mv_text ).
          ENDIF.
        ENDLOOP.

*Basic Header
        LOOP AT cs_rare_interface-basic_header INTO ms_header.
          IF ms_header-criticality = 'HIGH'.
            mv_text = ms_header-message.
            collect_rca_data( iv_mesg = mv_text ).
          ENDIF.
        ENDLOOP.

*Session Header
        LOOP AT cs_rare_interface-session_header INTO ms_header.
          IF ms_header-criticality = 'HIGH'.
            mv_text = ms_header-message.
            collect_rca_data( iv_mesg = mv_text ).
          ENDIF.
        ENDLOOP.

*System Header
        LOOP AT cs_rare_interface-system_header INTO ms_header.
          IF ms_header-criticality = 'HIGH'.
            mv_text = ms_header-message.
            collect_rca_data( iv_mesg = mv_text ).
          ENDIF.
        ENDLOOP.

*Techincal Header
        LOOP AT cs_rare_interface-technical_header INTO ms_header.
          IF ms_header-criticality = 'HIGH'.
            mv_text = ms_header-message.
            collect_rca_data( iv_mesg = mv_text ).
          ENDIF.
        ENDLOOP.

*Custom Header
        LOOP AT cs_rare_interface-custom_obj_header INTO ms_header.
          IF ms_header-criticality = 'HIGH'.
            mv_text = ms_header-message.
            collect_rca_data( iv_mesg = mv_text ).
          ENDIF.
        ENDLOOP.

*Monitoring Header
        LOOP AT cs_rare_interface-monitor_log_header INTO ms_header.
          IF ms_header-criticality = 'HIGH'.
            mv_text = ms_header-message.
            collect_rca_data( iv_mesg = mv_text ).
          ENDIF.
        ENDLOOP.

      CATCH cx_root INTO mo_oref_root.
        mv_text = mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.

  ENDMETHOD.


  METHOD get_sapconnect_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : SOST: SAPConnect details
*&---------------------------------------------------------------------*

    DATA: mt_date   TYPE sxdatrngt,
          ms_date   TYPE sxdatrngl,
          ms_status TYPE  soststatus.

    DATA:   mo_oref_root TYPE REF TO cx_root,
            mv_text      TYPE string.

    TRY.

        ms_date-sign    = 'I'.
        ms_date-option  = 'EQ'.
        ms_date-low     = sy-datum.
        ms_date-high    = ' '.
        APPEND  ms_date TO mt_date.

        ms_status-error =  abap_true.
        ms_status-wait =  abap_true.
        ms_status-transit =  abap_true.

        CALL FUNCTION 'SX_SNDREC_SELECT'
          EXPORTING
            snd_art     = '*'
            snd_date    = mt_date
            status      = ms_status
            maxsel      = '500'
            all_waiting = abap_true
          IMPORTING
            sndrecs     = cs_rare_interface-sost.

        IF cs_rare_interface-sost IS NOT INITIAL.
*HEADER*
        ELSE.
*HEADER*
        ENDIF.


      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.


  ENDMETHOD.


  METHOD get_sap_system_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Fetch SAP system details
*&---------------------------------------------------------------------*

    DATA:   mo_oref_root     TYPE REF TO cx_root,
            mv_text          TYPE string,
            ms_component_all LIKE LINE OF  cs_rare_interface-component_all,
            mv_version       TYPE          /sdf/keyandvalue-value.

    TRY.

        CALL 'SAPCORE' ID 'ID'    FIELD 'VERSION'         "#EC CI_CCALL
                       ID 'TABLE' FIELD cs_rare_interface-component_all. "#EC CI_CCALL

        IF sy-subrc <> 0.
          mv_text = ' Issue in retrieving System Details'(075) .
          collect_mesg( mv_text ).
        ENDIF.

        READ TABLE cs_rare_interface-component_all INTO ms_component_all WITH KEY key = 'SAP version'(074).
        IF sy-subrc = 0.
          mv_version = ms_component_all-value.
          MESSAGE i005(yz_msag_rare) INTO mv_text WITH mv_version.
          collect_header_data( iv_header_type = 'YH' iv_header_msg = mv_text iv_header_criticality = 'L').
        ELSE.
*HEADER*
        ENDIF.


      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.
  ENDMETHOD.


  METHOD get_secure_tcode_details.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Get secure Tcode details
*&---------------------------------------------------------------------*
*Declaration
    DATA :
      mo_oref_root TYPE REF TO cx_root,
      mv_text      TYPE string.

    TRY.

        SELECT SINGLE *
           FROM yztabl_rare_sec
           INTO cs_rare_sec
          WHERE tcode =  cv_tcode
            AND flag  = abap_true.

      CATCH cx_root INTO mo_oref_root.
        mv_text = mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.

  ENDMETHOD.


  METHOD get_smartform.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team Innovation and Automation Team
*&Transport request :
*&Description       : Synchronize Work item
*&---------------------------------------------------------------------*
*Declaration
    DATA: mo_oref_root TYPE REF TO cx_root,
          mv_text      TYPE string.
    DATA : mt_job_output_info      TYPE ssfcrescl,
           mt_document_output_info TYPE ssfcrespd,
           mt_job_output_options   TYPE ssfcresop,
           mt_output_options       TYPE ssfcompop,
           mv_e_devtype            TYPE rspoptype,
           mt_lines                TYPE STANDARD TABLE OF tline,
           mt_control_parameters   TYPE ssfctrlop.
    TRY.

        CALL FUNCTION 'SSF_GET_DEVICE_TYPE'
          EXPORTING
            i_language    = 'E'
            i_application = 'SAPDEFAULT'
          IMPORTING
            e_devtype     = mv_e_devtype.
        mt_output_options-tdprinter = mv_e_devtype.
        mt_control_parameters-no_dialog = 'X'.
        mt_control_parameters-getotf = 'X'.

        CALL FUNCTION 'SSF_FUNCTION_MODULE_NAME'
          EXPORTING
            formname           = 'YZ_RARE_SMARTFORM_OUTPUT'
*           VARIANT            = ' '
*           DIRECT_CALL        = ' '
          IMPORTING
            fm_name            = cv_funcname
          EXCEPTIONS
            no_form            = 1
            no_function_module = 2
            OTHERS             = 3.
        IF sy-subrc <> 0.
          MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
          WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
        ENDIF.

        CALL FUNCTION cv_funcname
          EXPORTING
*           ARCHIVE_INDEX         =
*           ARCHIVE_INDEX_TAB     =
*           ARCHIVE_PARAMETERS    =
            control_parameters    = mt_control_parameters
*           MAIL_APPL_OBJ         =
*           MAIL_RECIPIENT        =
*           MAIL_SENDER           =
            output_options        = mt_output_options
*           USER_SETTINGS         = 'X'
            /1bcdwb/docparams     = cv_docparams
**              IT_EDIDD        =
**              IS_EDIDC        =
            is_rare_screen_fields = cs_rare_interface-rare_screen_fields
*            it_wpinfo             = cs_rare_interface-wpinfo
*           IT_NOTES              =
            it_uinfo              = cs_rare_interface-uinfo
**              IT_VERSNO_LIST        =
**              IS_CALLSTACK          =
**              IS_XSTRING            =
            it_infotab            = cs_rare_interface-infotab
            it_callstack          = cs_rare_interface-callstack
            it_qview              = cs_rare_interface-qview
            it_qtable             = cs_rare_interface-qtable
            it_cvers              = cs_rare_interface-cvers
            is_logo               = cs_rare_interface-logo
            is_logo_mime          = cs_rare_interface-logo_mime
            is_watermark          = cs_rare_interface-watermark
            is_watermark_mime     = cs_rare_interface-watermark_mime
            is_data               = cs_rare_interface-data       "Printscreen Data
            is_mime               = cs_rare_interface-mime
            it_enq                = cs_rare_interface-enq
            is_userinfo           = cs_rare_interface-userinfo
            it_roles              = cs_rare_interface-roles
            it_modes              = cs_rare_interface-modes
            is_session_info       = cs_rare_interface-session_info
            it_component_all      = cs_rare_interface-component_all
            it_version_lists      = cs_rare_interface-version_lists
            it_userlist           = cs_rare_interface-userlist
            it_userparams         = cs_rare_interface-userparams
*           IT_USERPROFILES       = cs_rare_interface-
            is_logon              = cs_rare_interface-logon
            iv_rqident            = cs_rare_interface-rqident
            it_spool_buffer       = cs_rare_interface-spool_buffer
            is_printer_info       = cs_rare_interface-printer_info
            it_st04               = cs_rare_interface-st04
            it_mod_object         = cs_rare_interface-mod_object
            it_sm58               = cs_rare_interface-sm58
            it_sm37_log           = cs_rare_interface-sm37_log
            it_sp01               = cs_rare_interface-sp01
            it_al11               = cs_rare_interface-al11
            it_sost               = cs_rare_interface-sost
            is_tcode_data         = cs_rare_interface-tcode_data
            it_msg_info           = cs_rare_interface-msg_info
            it_badi               = cs_rare_interface-badi
**           IT_DATA_TAB           =
            it_exit_details       = cs_rare_interface-exit_details
            it_config_data        = cs_rare_interface-config_data
            it_fields             = cs_rare_interface-fields
            it_rca                = cs_rare_interface-rca
            it_client_job         = cs_rare_interface-client_jobs
            it_issue_header       = cs_rare_interface-issue_header
            it_basic_header       = cs_rare_interface-basic_header
            it_session_header     = cs_rare_interface-session_header
            it_system_header      = cs_rare_interface-system_header
            it_technical_header   = cs_rare_interface-technical_header
            it_custom_obj_header  = cs_rare_interface-custom_obj_header
            it_monitor_log_header = cs_rare_interface-monitor_log_header
            it_rca_header         = cs_rare_interface-rca_header
            it_d010tab            = cs_rare_interface-d010tab
            it_swi1_info          = cs_rare_interface-swi1_info
            it_su53_info          = cs_rare_interface-su53_info
            is_syst               = cs_rare_interface-syst
            it_msg_whereused      = cs_rare_interface-msg_whereused
            it_t20_data           = cs_rare_interface-t20_data
            it_printer_info       = cs_rare_interface-printer_info
            it_buffer_st02        = cs_rare_interface-buffer_st02
            it_idoc_info_inbound  = cs_rare_interface-idoc_info_inbound
            it_idoc_info_outbound = cs_rare_interface-idoc_info_outbound
            is_rare_inci          = cs_rare_interface-rare_inci
          IMPORTING
            document_output_info  = mt_document_output_info
            job_output_info       = mt_job_output_info
            job_output_options    = mt_job_output_options
            /1bcdwb/formoutput    = cs_rare_interface-xstring
          EXCEPTIONS
            formatting_error      = 1
            internal_error        = 2
            send_error            = 3
            user_canceled         = 4
            OTHERS                = 5.
        IF sy-subrc <> 0.
          MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
          WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
        ENDIF.

        CALL FUNCTION 'CONVERT_OTF'
          EXPORTING
            format                = 'PDF'
**   MAX_LINEWIDTH               = 132
**   ARCHIVE_INDEX               = ' '
**   COPYNUMBER                  = 0
**   ASCII_BIDI_VIS2LOG          = ' '
**   PDF_DELETE_OTFTAB           = ' '
**   PDF_USERNAME                = ' '
**   PDF_PREVIEW                 = ' '
**   USE_CASCADING               = ' '
*IMPORTING
**   BIN_FILESIZE                =
**   BIN_FILE                    =
          TABLES
            otf                   = mt_job_output_info-otfdata
            lines                 = mt_lines
          EXCEPTIONS
            err_max_linewidth     = 1
            err_format            = 2
            err_conv_not_possible = 3
            err_bad_otf           = 4
            OTHERS                = 5.
        IF sy-subrc <> 0.
          MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
          WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
        ENDIF.

       ct_lines[] = mt_lines[].

      CATCH cx_root INTO mo_oref_root.
        mv_text = mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.
  ENDMETHOD.


  METHOD get_snote_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : SNOTE details
*&---------------------------------------------------------------------*
    DATA:  mo_oref_root TYPE REF TO cx_root,
           mv_text      TYPE string.

    DATA: ms_searchterm TYPE searchelem.
    DATA: mv_res_l      TYPE sy-langu.
    DATA: mv_date       TYPE sy-datum.
    DATA: mv_ncat       TYPE anst_note_cat VALUE '*'.
    DATA: mv_maxno      TYPE i VALUE 100.
    DATA: mv_range      TYPE char64 VALUE 'OBJECTS'.
    DATA: mv_search_rfc TYPE anst_settings-rfcdest.
    DATA: mv_number_all TYPE i ##NEEDED.
    DATA: mv_error_text TYPE string.
    DATA: mt_appl       TYPE TABLE OF anst_range.

    TRY.

        IF ms_searchterm IS NOT INITIAL.

          CALL FUNCTION 'ANST_SEARCH_NOTES'
            EXPORTING
              i_searchterm       = ms_searchterm
              i_srch_l           = 'E'
              i_res_l            = mv_res_l
*             I_APPL             = I_APPL
              i_category         = mv_ncat
              i_released_after   = mv_date
              i_output           = ''
              i_maxno            = mv_maxno
              i_sort_crit        = 'N'
              i_sort_order       = 'A'
              i_convert_implstat = 'X'
              i_method           = '1'
              i_range            = mv_range
              i_rfc              = mv_search_rfc
            IMPORTING
              et_notes           = cs_rare_interface-notes
              e_number_all       = mv_number_all
              e_err_text         = mv_error_text
            TABLES
              it_appl            = mt_appl
            EXCEPTIONS
              rfc_error          = 1
              no_oss_rfc         = 2
              internal_error     = 3
              OTHERS             = 4.

          IF sy-subrc = 0.
            SORT cs_rare_interface-notes BY nummer ASCENDING.
            DELETE ADJACENT DUPLICATES FROM cs_rare_interface-notes COMPARING nummer.
          ELSE.
            MESSAGE i001(anst) WITH mv_error_text.
          ENDIF.

        ENDIF.

      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.

  ENDMETHOD.


  METHOD get_snow_cat_grp_details.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Get Service Now Category group details
*&---------------------------------------------------------------------*
    DATA: mo_oref_root TYPE REF TO cx_root,
          mv_text      TYPE string.

    DATA : mv_rare_catg TYPE yztabl_rare_catg.

    TRY.
        cs_rare_interface-rare_inci-category = 'SAP General'(005).

        SELECT SINGLE *
                 FROM yztabl_rare_catg
                 INTO cs_rare_interface-snow_cat_grp_details
                WHERE tcode = cv_tcode
                  AND active = abap_true.

        rs_catg =  cs_rare_interface-snow_cat_grp_details.

*        IF ct_rare_swch[] IS NOT  INITIAL AND cs_rare_interface-snow_cat_grp_details IS NOT INITIAL.
*
**IF switch IS active THEN below LINES OF CODE will be executed
*          READ TABLE ct_rare_swch  TRANSPORTING NO FIELDS WITH  KEY obj_name     = 'YZ_TABL_RARE_CATG'
*                                                                    task_name    = 'AUTO_CATG_DETERMINATION'
*                                                                    vakey1       = 'ALL_ON'
*                                                                    vadata1      = 'ALL_ON'
*                                                                    active       = abap_true
*                                                                    BINARY SEARCH.
*
*          IF sy-subrc <> 0.
*
*            SORT ct_rare_swch ASCENDING.
*            READ TABLE ct_rare_swch  TRANSPORTING NO FIELDS WITH  KEY obj_name     = 'YZ_TABL_RARE_CATG'
*                                                                      task_name    = 'AUTO_CATG_DETERMINATION'
*                                                                      vakey1       = 'ASSIGNMENT_GRP'
*                                                                      vadata1      = 'ON'
*                                                                      active       = abap_true
*                                                                      BINARY SEARCH.
*
*            IF  sy-subrc = 0.
*              cs_rare_interface-snow_cat_grp_details-sub_category            = 'SAP General'(005).
*
*            ELSE.
*              SORT ct_rare_swch ASCENDING.
*              READ TABLE ct_rare_swch  TRANSPORTING NO FIELDS WITH  KEY obj_name = 'YZ_TABL_RARE_CATG'
*                                                                       task_name = 'AUTO_CATG_DETERMINATION'
*                                                                          vakey1 = 'SUBCATOGRY'
*                                                                         vadata1 = 'ON'
*                                                                          active = abap_true
*                                                                          BINARY SEARCH.
*
*              IF  sy-subrc = 0.
*                cs_rare_interface-snow_cat_grp_details-assignment_grp  = 'CG_SD_L1'.
*
*              ELSE.
*                cs_rare_interface-snow_cat_grp_details-sub_category    = 'SAP General'(005).
*                cs_rare_interface-snow_cat_grp_details-assignment_grp  = 'CG_SD_L1'.
*              ENDIF.
*            ENDIF.
*          ENDIF.
*        ELSE.
*          cs_rare_interface-snow_cat_grp_details-sub_category    = 'SAP General'(005).
*          cs_rare_interface-snow_cat_grp_details-assignment_grp  = 'CG_SD_L1'.
*        ENDIF.

        cs_rare_interface-rare_inci-sub_category   =  cs_rare_interface-snow_cat_grp_details-sub_category   .
        cs_rare_interface-rare_inci-assignment_grp =  cs_rare_interface-snow_cat_grp_details-assignment_grp .

      CATCH cx_root INTO mo_oref_root.
        mv_text = mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.

  ENDMETHOD.


  METHOD get_spool_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : SP01-Spool Data
*&---------------------------------------------------------------------*

    DATA: mv_sp_no       TYPE rspoid,
          mv_date_yester TYPE sy-datum,
          mo_oref_root   TYPE REF TO cx_root,
          mv_text        TYPE string.

    DATA:mv_date     TYPE sy-datum,
         mv_time     TYPE sy-uzeit,
         mv_page     TYPE i,
         mt_spoolreq TYPE STANDARD TABLE OF rsporq,
         mv_title    TYPE string,
         mt_final    TYPE yz_ttyp_spool_data,
         ms_final    TYPE yztabl_spool_data,
         mv_spool_no TYPE string.



    FIELD-SYMBOLS : <fs_rsporq> TYPE rsporq.

    TRY.

        mv_date_yester = sy-datum - 1.

        CALL FUNCTION 'RSPO_FIND_SPOOL_REQUESTS'
          EXPORTING
            allclients          = ' '
            authority           = 'RSPO_GET_TEMSEOBJ_OF'
            datatype            = '*'
            has_output_requests = '*'
            rq0name             = '*'
            rq1name             = '*'
            rq2name             = '*'
            rqdest              = '*'
            rqident             = 0
            rqowner             = '*'
          TABLES
            spoolrequests       = mt_spoolreq
          EXCEPTIONS
            no_permission       = 1
            OTHERS              = 2.

        IF sy-subrc <> 0.
          CASE sy-subrc.
            WHEN 1.
              mv_text = 'No_permission exception is catched while calling RSPO_FIND_SPOOL_REQUESTS in GET_SPOOL_DATA method.'(090).
              APPEND mv_text TO cs_rare_interface-exceptions.

            WHEN 2.
              mv_text = 'Others exception is catched while calling RSPO_FIND_SPOOL_REQUESTS in GET_SPOOL_DATA method.'(091).
              APPEND mv_text TO cs_rare_interface-exceptions.

          ENDCASE.
          collect_mesg( mv_text ).
          CLEAR mv_text.
        ENDIF.

        IF mt_spoolreq IS NOT INITIAL.
          LOOP AT mt_spoolreq ASSIGNING <fs_rsporq> .

            IF <fs_rsporq> IS ASSIGNED.

              mv_date = <fs_rsporq>-rqcretime+0(8).
              mv_time = <fs_rsporq>-rqcretime+8(6).
              mv_spool_no = <fs_rsporq>-rqident+4(6).
              mv_sp_no = mv_spool_no.
              mv_date =  mv_date ##NEEDED.
              CONCATENATE <fs_rsporq>-rq0name <fs_rsporq>-rq1name <fs_rsporq>-rq2name INTO mv_title SEPARATED BY space.

              CALL FUNCTION 'RSPO_GET_PAGES_SPOOLJOB' "get number of pages depending on spool number
                EXPORTING
                  rqident     = mv_sp_no
                IMPORTING
                  pages       = mv_page
                EXCEPTIONS
                  no_such_job = 1
                  OTHERS      = 2.

              IF sy-subrc <> 0.
                CASE sy-subrc.
                  WHEN 1.
                    mv_text = 'no_such_job exception is catched while calling RSPO_GET_PAGES_SPOOLJOB in GET_SPOOL_DATA method.'(092).
                    APPEND mv_text TO cs_rare_interface-exceptions.

                  WHEN 2.
                    mv_text = 'Others exception is catched while calling RSPO_GET_PAGES_SPOOLJOB in GET_SPOOL_DATA method.'(093).
                    APPEND mv_text TO cs_rare_interface-exceptions.

                ENDCASE.
                collect_mesg( mv_text ).
                CLEAR mv_text.
              ENDIF.

              IF mv_date = mv_date_yester.
                ms_final-rqid_char        = <fs_rsporq>-rqident.
                ms_final-rqdate           = mv_date.
                ms_final-rqtime_v         = mv_time.
*                ms_final-rqstatus_v       = lc_dash.
                ms_final-rqtitle_v        = mv_title.
                ms_final-page_no          = mv_page.

                APPEND ms_final TO mt_final.

              ENDIF.
            ENDIF.
          ENDLOOP.
        ENDIF.

        IF mt_final IS NOT INITIAL.
          cs_rare_interface-sp01[] = mt_final[].
          "SPOOL data for last two days
          MESSAGE i030(yz_msag_rare) INTO mv_text.
          collect_header_data( iv_header_type = 'MH' iv_header_msg = mv_text iv_header_criticality = 'L').

        ELSE.
          "No Spool data in last 2 days
          MESSAGE i031(yz_msag_rare) INTO mv_text.
          collect_header_data( iv_header_type = 'MH' iv_header_msg = mv_text iv_header_criticality = 'L').
        ENDIF.

      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.

  ENDMETHOD.


  METHOD get_stack_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Display Stack data
*&---------------------------------------------------------------------*

    DATA:  mo_oref_root      TYPE REF TO cx_root,
           mv_text           TYPE string,
           mt_abap_callstack TYPE abap_callstack,
           ms_abap_callstack LIKE LINE OF mt_abap_callstack,
           mt_callstack      TYPE sys_callst,
           ms_callstack      LIKE LINE OF cs_rare_interface-callstack.


    TRY.

*--- record format as returned by kernel function ABAP_CALLSTACK ---
        CALL FUNCTION 'SYSTEM_CALLSTACK'
          EXPORTING
            max_level    = 99
          IMPORTING
            callstack    = mt_abap_callstack
            et_callstack = mt_callstack
          EXCEPTIONS
            OTHERS       = 1.

        IF sy-subrc = 0.
          APPEND LINES OF mt_callstack      TO cs_rare_interface-callstack.
          APPEND LINES OF mt_abap_callstack TO cs_rare_interface-abap_callstack.

          ms_abap_callstack-blockname = ms_callstack = '----------------------------'.

          APPEND ms_callstack      TO cs_rare_interface-callstack.
          APPEND ms_abap_callstack TO cs_rare_interface-abap_callstack.

          IF cv_tcode IS NOT INITIAL AND cv_tcode_check EQ abap_false.
            READ TABLE cs_rare_interface-callstack TRANSPORTING NO FIELDS WITH KEY progname = cv_tcode.
            IF sy-subrc <> 0.
              ms_callstack-progname  = cv_tcode.
              ms_callstack-eventtype = 'TRANSACTION'.
              ms_callstack-eventname = 'CALL_TRANSACTION'.
              APPEND ms_callstack TO cs_rare_interface-callstack.
              cv_tcode_check = abap_true.
            ENDIF.
          ENDIF.
        ELSE.
          mv_text = 'Other exception is catched while calling function SYSTEM_CALLSTACK in GET_STACK_DATA method.'(131).
          APPEND mv_text TO cs_rare_interface-exceptions.
          collect_mesg( mv_text ).
          CLEAR mv_text.
        ENDIF.

        IF cs_rare_interface-callstack IS INITIAL.
          MESSAGE i012(yz_msag_rare) INTO mv_text.
          collect_header_data( iv_header_type = 'TH' iv_header_msg = mv_text iv_header_criticality = 'L').
        ENDIF.

      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.

  ENDMETHOD.


  METHOD get_swi1_info.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : SWI1-get worklist details
*&---------------------------------------------------------------------*
    DATA: mo_oref_root TYPE REF TO cx_root,
          mv_text      TYPE string,
          mt_outtab    TYPE swfatalvitm,
          mo_data      TYPE REF TO data,
          mt_rsparams  TYPE TABLE OF rsparams,
          ms_rsparams  TYPE   rsparams.

    FIELD-SYMBOLS: <ft_buffer> TYPE ANY TABLE.


    TRY.
        CALL METHOD cl_progress_indicator=>progress_indicate
          EXPORTING
            i_text               = 'Fetching data for workitem details'(060)
            i_output_immediately = abap_true.

        cl_salv_bs_runtime_info=>set(
         EXPORTING
           display  = abap_false
           metadata = abap_false
           data     = abap_true
        ).

        CLEAR   :  ms_rsparams.
        REFRESH :  mt_rsparams[].
*
        ms_rsparams-selname = 'CD'.
        ms_rsparams-sign    = 'I'.
        ms_rsparams-option  = 'EQ'.
        ms_rsparams-low     =  sy-datum.
        ms_rsparams-high    = ' '.

        APPEND ms_rsparams TO mt_rsparams.

        CALL FUNCTION 'SUBMIT_REPORT'
          EXPORTING
            report           = 'RSWIWILS'
            ret_via_leave    = abap_false
            skip_selscreen   = abap_true
          TABLES
            selection_table  = mt_rsparams
          EXCEPTIONS
            just_via_variant = 1
            no_submit_auth   = 2
            OTHERS           = 3.
        IF sy-subrc <> 0.
          CASE sy-subrc.
            WHEN 1.
              mv_text =   'Exception just_via_variant caught while running report RSWIWILS'(148).
              APPEND mv_text TO cs_rare_interface-exceptions.

            WHEN 2.
              mv_text =   'Exception no_submit_auth caught while running report RSWIWILS'(149).
              APPEND mv_text TO cs_rare_interface-exceptions.

            WHEN 3.
              mv_text =   'Exception OTHERS caught while running report RSWIWILS'(150).
              APPEND mv_text TO cs_rare_interface-exceptions.

          ENDCASE.
          collect_mesg( mv_text ).
          CLEAR mv_text.
        ENDIF.

        TRY.
            cl_salv_bs_runtime_info=>get_data_ref(
                IMPORTING
                  r_data = mo_data ).

          CATCH cx_salv_bs_sc_runtime_info.
            mv_text =   'Exception while running report RSWIWILS'(121) .
            APPEND mv_text TO cs_rare_interface-exceptions.
            collect_mesg( mv_text ).
            CLEAR mv_text.
        ENDTRY.

        ASSIGN mt_outtab TO  <ft_buffer>.
        IF <ft_buffer> IS ASSIGNED  .
          ASSIGN mo_data->* TO  <ft_buffer>.
          IF  <ft_buffer> IS ASSIGNED AND <ft_buffer> IS NOT INITIAL  .
            mt_outtab[] =  <ft_buffer>[].
            DELETE mt_outtab FROM 21.
*            cs_rare_interface-swi1_info[] =  <ft_buffer>[].
            cs_rare_interface-swi1_info[] =   mt_outtab[].
          ENDIF.
        ENDIF.

        "Workitem details for past two days
        IF cs_rare_interface-swi1_info IS INITIAL.
          MESSAGE i032(yz_msag_rare) INTO mv_text.
          collect_header_data( iv_header_type = 'YH' iv_header_msg = mv_text iv_header_criticality = 'L').
        ENDIF.

      CATCH cx_root INTO mo_oref_root.
        mv_text = mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.
  ENDMETHOD.


  METHOD get_t20_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Top 20 Last updated ABAP Objects Info with TR and Data Time
*&---------------------------------------------------------------------*

    TYPES : BEGIN OF mty_object_trdir,
              prog TYPE trdir-name,
            END OF mty_object_trdir.

    TYPES : BEGIN OF mty_object_e071,
              prog TYPE  e071-obj_name,
            END OF mty_object_e071.


    DATA:     mo_oref_root    TYPE REF TO            cx_root,
              mv_text         TYPE                   string,
              mt_trdir        TYPE STANDARD TABLE OF mty_object_trdir,
              mt_tr_71        TYPE STANDARD TABLE OF mty_object_e071,
              ms_tr_71        TYPE                   mty_object_e071,
              mt_e071         TYPE STANDARD TABLE OF e071,
              mt_date         TYPE                   date_t_range,
              ms_date         LIKE LINE OF           mt_date,
              mv_tkorr_cleint TYPE string.

    FIELD-SYMBOLS :  <fs_trdir> TYPE   mty_object_trdir,
                     <fs_tr_71> TYPE   mty_object_e071.

    TRY.

        CLEAR   : ms_date .
        REFRESH : mt_date .

        ms_date-sign      = 'I'.
        ms_date-option    = 'BT'.
        ms_date-low       = sy-datum - 5.
        ms_date-high      = sy-datum.

        APPEND ms_date TO mt_date.

        SELECT name
          FROM trdir
    INTO TABLE  mt_trdir
         WHERE ( name LIKE 'Z%' OR  name LIKE 'Y%'  )
           AND udat IN mt_date.

        IF  sy-subrc = 0 AND mt_trdir IS NOT INITIAL .


          REFRESH : mt_tr_71.

          LOOP AT mt_trdir ASSIGNING <fs_trdir>.
            IF  <fs_trdir> IS ASSIGNED .
              ASSIGN ms_tr_71 TO <fs_tr_71>.
              IF <fs_tr_71> IS  ASSIGNED.
                <fs_tr_71>-prog = <fs_trdir>-prog.
                APPEND <fs_tr_71> TO mt_tr_71.
              ENDIF.
            ENDIF.
          ENDLOOP.

          IF  mt_tr_71 IS NOT INITIAL .

            mv_tkorr_cleint = sy-sysid(2) && '%'.

            SELECT *
              FROM e071
        INTO TABLE mt_e071
FOR ALL ENTRIES IN mt_tr_71
             WHERE trkorr   LIKE mv_tkorr_cleint"'NY%'
               AND obj_name =    mt_tr_71-prog .

            IF sy-subrc = 0.

              SORT mt_e071 BY   obj_name.
              DELETE ADJACENT DUPLICATES FROM mt_e071 COMPARING   obj_name .
              cs_rare_interface-t20_data[] = mt_e071[].

              "custom objects changes in last 5 days
              MESSAGE i015(yz_msag_rare) INTO mv_text.
              collect_header_data( iv_header_type = 'CH' iv_header_msg = mv_text iv_header_criticality = 'L').
            ELSE.
              MESSAGE i014(yz_msag_rare) INTO mv_text.
              collect_header_data( iv_header_type = 'CH' iv_header_msg = mv_text iv_header_criticality = 'L').
            ENDIF.
          ENDIF.
        ELSE.

          "No custom objects changes in last 5 days
          IF cs_rare_interface-t20_data IS INITIAL.
            MESSAGE i014(yz_msag_rare) INTO mv_text.
            collect_header_data( iv_header_type = 'CH' iv_header_msg = mv_text iv_header_criticality = 'L').
          ENDIF.
        ENDIF.

      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.
  ENDMETHOD.


  METHOD get_tab_details.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Get table details
*&---------------------------------------------------------------------*
    DATA: mo_oref_root TYPE REF TO cx_root,
          mv_text      TYPE string.

    TRY.

        IF cs_rare_interface-callstack IS NOT INITIAL.

          SELECT *
            FROM d010tab
      INTO TABLE cs_rare_interface-d010tab
FOR ALL ENTRIES IN cs_rare_interface-callstack
           WHERE master = cs_rare_interface-callstack-progname.

          IF sy-subrc = 0.

            SORT cs_rare_interface-d010tab BY tabname.

            DELETE cs_rare_interface-d010tab
             WHERE tabname NP 'Y*'
               AND tabname NP 'Z*' .

            IF cs_rare_interface-d010tab[] IS NOT INITIAL.
*HEADER*
              MESSAGE i038(yz_msag_rare) INTO mv_text  .
              collect_header_data( iv_header_type = 'TH' iv_header_msg = mv_text iv_header_criticality = 'L').
            ELSE.
*HEADER*
              MESSAGE i039(yz_msag_rare) INTO mv_text  .
              collect_header_data( iv_header_type = 'TH' iv_header_msg = mv_text iv_header_criticality = 'L').
            ENDIF.

          ELSE.
*EXCEPTION*

          ENDIF.
        ENDIF.


      CATCH cx_root INTO mo_oref_root.
        mv_text = mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.
  ENDMETHOD.


  METHOD get_tcode_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Fetch details about a Transaction Code
*&---------------------------------------------------------------------*

    DATA : mv_oref TYPE REF TO cx_root,
           mv_text TYPE string.

    DATA:  mt_tstc     TYPE STANDARD TABLE OF tstc,
           ms_tstc     TYPE tstc,
           mv_ttext    TYPE ttext_stct,
           mv_obj      TYPE xuobject,
           mv_devclass TYPE devclass,
           mv_msg      TYPE string,
           mv_tcode    TYPE sy-tcode.

    TRY.

        IF iv_tcode IS INITIAL.
          mv_tcode = cv_tcode.
        ELSE.
          mv_tcode = iv_tcode.
        ENDIF.

        IF mv_tcode IS INITIAL .
          mv_msg  = ' Error while getting tcode : ' &&  mv_tcode.
          collect_mesg( mv_msg ).
        ENDIF.

        CALL FUNCTION 'RPY_TRANSACTION_READ'
          EXPORTING
            transaction      = mv_tcode
          TABLES
            tcodes           = mt_tstc
          EXCEPTIONS
            permission_error = 1
            cancelled        = 2
            not_found        = 3
            object_not_found = 4
            OTHERS           = 5.

        IF sy-subrc <> 0.
          CONCATENATE 'No details found for transaction  '(033) mv_tcode
                 INTO  mv_msg
         SEPARATED BY space.
          collect_mesg( mv_msg ).
        ELSE.

          IF mt_tstc IS NOT INITIAL.

            SELECT SINGLE ttext                         "#EC CI_GENBUFF
                     INTO mv_ttext
                     FROM tstct
                    WHERE sprsl = 'E'
                      AND tcode = mv_tcode.             "#EC CI_GENBUFF

            IF sy-subrc = 0.

              SELECT SINGLE objct                       "#EC CI_GENBUFF
                       INTO mv_obj
                       FROM tstca
                      WHERE tcode = mv_tcode.           "#EC CI_GENBUFF

              IF sy-subrc <> 0.
                mv_msg = ' No Application object for the Transaction code '(034) .
                collect_mesg( mv_msg ).
              ENDIF.

              SELECT SINGLE devclass                    "#EC CI_GENBUFF
                       INTO mv_devclass
                       FROM tadir
                      WHERE object = 'TRAN'
                        AND obj_name = mv_tcode.        "#EC CI_GENBUFF

              IF sy-subrc <> 0.
                CONCATENATE  ' No package for the Transaction code '(035) mv_tcode
                       INTO  mv_msg
               SEPARATED BY space .
                collect_mesg( mv_msg ).
              ENDIF.

              READ TABLE mt_tstc INTO ms_tstc INDEX 1.

              cs_rare_interface-tcode_data-tcode       = ms_tstc-tcode.
              cs_rare_interface-tcode_data-tcode_text  = mv_ttext.
              cs_rare_interface-tcode_data-zpackage    = mv_devclass.
              cs_rare_interface-tcode_data-zprogram    = ms_tstc-pgmna.
              cs_rare_interface-tcode_data-dynpro_num  = ms_tstc-dypno.
              cs_rare_interface-tcode_data-auth_object = mv_obj.

            ENDIF.
          ENDIF.
        ENDIF.


        IF cs_rare_interface-tcode_data IS INITIAL.
          MESSAGE i001(yz_msag_rare) INTO mv_text WITH mv_tcode .
          collect_header_data( iv_header_type = 'BH' iv_header_msg = mv_text iv_header_criticality = 'L').
        ENDIF.

      CATCH cx_root INTO mv_oref.
        mv_text = mv_oref->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.
  ENDMETHOD.


  METHOD get_tnapr_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : TNAPR data
*&---------------------------------------------------------------------*
    DATA: mo_oref_root TYPE REF TO cx_root,
          mv_text      TYPE string.

    TRY.

        get_nast_data( ).

      CATCH cx_root INTO mo_oref_root.
        mv_text = mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.
  ENDMETHOD.


  METHOD get_transport_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Fetch Transport details
*&---------------------------------------------------------------------*

    TYPES:
      BEGIN OF ty_e070,
        trkorr  TYPE trkorr,
        as4user TYPE e070-as4user,
        as4date TYPE e070-as4date,
        as4time TYPE e070-as4time,
        strkorr TYPE e070-strkorr,
      END OF ty_e070,

      BEGIN OF ty_final,
        objname TYPE e071-obj_name,
        trkorr  TYPE trkorr,
        as4user TYPE e070-as4user,
        as4date TYPE e070-as4date,
        as4time TYPE e070-as4time,
        strkorr TYPE e070-strkorr,
      END OF ty_final,

      BEGIN OF ty_e071,
        trkorr   TYPE trkorr,
        obj_name TYPE e071-obj_name,
      END OF ty_e071.

    TYPES: BEGIN OF ty_final1,
             obj_name TYPE e071-obj_name,
           END OF ty_final1.

    DATA mv_v1                 TYPE vrsd_old-objname.
    DATA mv_v2                 TYPE string ##NEEDED.
    DATA mt1_version_list      TYPE TABLE OF  vrsd_old.


    DATA:  mo_oref_root TYPE REF TO cx_root,
           mv_text      TYPE string.

    DATA :mt_e071         TYPE STANDARD TABLE OF ty_e071,
          ms_e071         TYPE ty_e071,
          mt_e070         TYPE TABLE OF ty_e070,
          ms_e070         TYPE ty_e070,
*         ms_final TYPE yztabl_e070,
          ms_final        TYPE ty_final,
*         mt_final TYPE STANDARD TABLE OF yztabl_e070,
          mv_tkorr_cleint TYPE string.


    FIELD-SYMBOLS : <f1> TYPE sys_calls,
                    <f2> TYPE vrsd_old.

    DATA : mt_callstack TYPE TABLE OF ty_final1,
           ms_callstack TYPE ty_final1.

    DATA : mt_stack     TYPE STANDARD TABLE OF sys_calls.

    TRY.

        mt_stack[]  = cs_rare_interface-callstack[].
        DELETE  mt_stack WHERE progname(2) CN 'YZ'.
        SORT mt_stack BY progname .
        DELETE ADJACENT DUPLICATES FROM mt_stack.

        LOOP AT mt_stack ASSIGNING <f1>.
          SPLIT <f1>-progname AT '=' INTO mv_v1 mv_v2.
          MOVE mv_v1 TO ms_callstack-obj_name.
          APPEND ms_callstack TO mt_callstack.
        ENDLOOP.

        SORT mt_callstack DESCENDING.
        DELETE ADJACENT DUPLICATES FROM mt_callstack.

        IF mt_callstack IS NOT INITIAL.

          mv_tkorr_cleint = sy-sysid(2) && '%'.

          SELECT trkorr obj_name
            FROM e071
      INTO TABLE mt_e071
FOR ALL ENTRIES IN mt_callstack
           WHERE trkorr   LIKE mv_tkorr_cleint"'NY%'
             AND obj_name = mt_callstack-obj_name.

          IF sy-subrc = 0 AND  mt_e071 IS NOT INITIAL.

            SELECT trkorr
                   as4user
                   as4date
                   as4time
                   strkorr
              FROM e070
        INTO TABLE mt_e070
FOR ALL ENTRIES IN mt_e071
             WHERE trkorr = mt_e071-trkorr.

            IF sy-subrc = 0.

              SORT mt_e070 BY strkorr DESCENDING.
              DELETE ADJACENT DUPLICATES FROM mt_e070.

              SORT mt_e071 BY obj_name.
              SORT mt_e070 BY trkorr.

              LOOP AT mt_callstack INTO ms_callstack.

                READ TABLE mt_e071 INTO ms_e071 WITH KEY obj_name = ms_callstack-obj_name BINARY SEARCH.

                IF sy-subrc = 0.

                  READ TABLE mt_e070 INTO ms_e070 WITH KEY trkorr = ms_e071-trkorr BINARY SEARCH.

                  IF ms_e070 IS NOT INITIAL.

                    MOVE-CORRESPONDING ms_e070 TO ms_final.
                    ms_final-objname = ms_callstack-obj_name.
                    APPEND ms_final TO cs_rare_interface-version_lists.
                    CLEAR ms_final.

                  ENDIF.

                ELSE.

                  mv_v1 = ms_callstack-obj_name.
                  CALL FUNCTION 'SVRS_GET_VERSION_DIRECTORY'
                    EXPORTING
                      objname      = mv_v1
                      objtype      = 'REPO'
                    TABLES
                      lversno_list = cs_rare_interface-versno_list
                      version_list = mt1_version_list
                    EXCEPTIONS
                      no_entry     = 1
                      OTHERS       = 2.


                  IF sy-subrc <> 0.
*
                    CALL FUNCTION 'SVRS_GET_VERSION_DIRECTORY'
                      EXPORTING
                        objname      = mv_v1
                        objtype      = 'CLAS'
                      TABLES
                        lversno_list = cs_rare_interface-versno_list
                        version_list = mt1_version_list
                      EXCEPTIONS
                        no_entry     = 1
                        OTHERS       = 2.

                    IF sy-subrc <> 0.

                      CALL FUNCTION 'SVRS_GET_VERSION_DIRECTORY'
                        EXPORTING
                          objname      = mv_v1
                          objtype      = 'FUNC'
                        TABLES
                          lversno_list = cs_rare_interface-versno_list
                          version_list = mt1_version_list
                        EXCEPTIONS
                          no_entry     = 1
                          OTHERS       = 2.

                      IF sy-subrc <> 0.
                        CASE sy-subrc.
                          WHEN 1.
                            mv_text = 'no_entry exception is catched while calling SVRS_GET_VERSION_DIRECTORY in GET_TRANSPORT_DATA method.'(009).
                            APPEND mv_text TO cs_rare_interface-exceptions.

                          WHEN 2.
                            mv_text = 'Others exception is catched while calling SVRS_GET_VERSION_DIRECTORY in GET_TRANSPORT_DATA method.'(014).
                            APPEND mv_text TO cs_rare_interface-exceptions.

                        ENDCASE.

                      ENDIF.

                    ENDIF.

                  ENDIF.
                  SORT mt1_version_list BY datum DESCENDING zeit DESCENDING.

                  READ TABLE mt1_version_list ASSIGNING <f2> WITH KEY objname = mv_v1.
                  IF sy-subrc = 0.
                    MOVE  <f2>-objname TO ms_final-objname.
                    MOVE <f2>-author   TO ms_final-as4user.
                    MOVE <f2>-datum    TO ms_final-as4date.
                    MOVE <f2>-zeit     TO ms_final-as4time.
                    APPEND ms_final    TO cs_rare_interface-version_lists.
                    CLEAR ms_final.
                  ENDIF.

                ENDIF.

              ENDLOOP.

              SORT cs_rare_interface-version_lists DESCENDING.
              DELETE ADJACENT DUPLICATES FROM cs_rare_interface-version_lists.

*HEADER*
            ENDIF.
          ENDIF.
        ENDIF.

      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.


  ENDMETHOD.


  METHOD get_trfc_stuck_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : SM59-data stuck in tRFC
*&---------------------------------------------------------------------*

    DATA : mo_oref_root  TYPE REF TO cx_root,
           mv_text       TYPE string,
           mt_arfcsstate TYPE STANDARD TABLE OF arfcsstate,
           ma_arfcsstate TYPE arfcsstate,
           ma_arfcistate TYPE yztabl_trfc_output,
           mv_acttid     TYPE sxmsrefval,
           ms_reserv     TYPE arfcreserv,
           mv_trfc_count TYPE          n.
    TRY .

        SELECT *
          FROM arfcsstate
    INTO TABLE mt_arfcsstate
         WHERE arfcstate <> 'EXECUTED'
           AND arfcdatum = sy-datum.

        IF sy-subrc = 0.

          LOOP AT mt_arfcsstate INTO ma_arfcsstate.

            mv_acttid = ma_arfcsstate(24)  .

            MOVE-CORRESPONDING ma_arfcsstate TO ma_arfcistate.

            MOVE mv_acttid  TO ma_arfcistate-actid .

            ms_reserv = ma_arfcsstate-arfcreserv.

            ma_arfcistate-cprog = ms_reserv-cprog.
            ma_arfcistate-mandt = ms_reserv-mandt.

            CALL FUNCTION 'CONVERSION_EXIT_PDATE_OUTPUT'
              EXPORTING
                input  = ma_arfcsstate-arfcdatum
              IMPORTING
                output = ma_arfcistate-arfcdatum.

            WRITE ma_arfcsstate-arfcuzeit TO ma_arfcistate-arfcuzeit USING EDIT MASK '__:__:__'.

            IF ma_arfcsstate-arfcmsg <> space.
              ma_arfcistate-arfcmsg = ma_arfcsstate-arfcmsg.
            ENDIF.
            ma_arfcistate-state = ma_arfcsstate-arfcstate.
            APPEND ma_arfcistate TO cs_rare_interface-sm58.

          ENDLOOP.

          SORT cs_rare_interface-sm58.
          DELETE ADJACENT DUPLICATES FROM cs_rare_interface-sm58.

        ENDIF.

        IF cs_rare_interface-sm58 IS NOT INITIAL.
          mv_trfc_count = lines( cs_rare_interface-sm58 ).
          MESSAGE w028(yz_msag_rare) INTO mv_text WITH mv_trfc_count sy-datum.
          collect_header_data( iv_header_type = 'MH' iv_header_msg = mv_text iv_header_criticality = 'H').

        ELSE.
          MESSAGE i029(yz_msag_rare) INTO mv_text WITH sy-datum.
          collect_header_data( iv_header_type = 'MH' iv_header_msg = mv_text iv_header_criticality = 'L').
        ENDIF.

      CATCH cx_root INTO mo_oref_root.
        mv_text = mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.

    ENDTRY.
  ENDMETHOD.


  METHOD get_update_task_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Update task details
*&---------------------------------------------------------------------*

    DATA:  mo_oref_root TYPE REF TO cx_root,
           mv_text      TYPE string.

    FIELD-SYMBOLS :
    <fv>  TYPE any.

*  DATA: BEGIN OF upd_records OCCURS 0.
*    INCLUDE STRUCTURE vbhdr.
*    DATA: datum       LIKE sy-datum,
*          zeit        LIKE sy-uzeit,
*          info(255),
*          info1(30),
*          info2(30),
*          info3(30),
*          info4(30),
*          info5(30),
*          info6(30),
*          info7(30),
*          info8(30),
*          status(20),
*          marked,
*          line_col(3),
*          field_col   TYPE slis_t_specialcol_alv.
*  DATA: END OF upd_records.


    TRY.

        PERFORM load_upd_records IN PROGRAM sapmsm13.

        ASSIGN '(SAPMSM13)UPD_RECORDS' TO <fv>.

      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.

  ENDMETHOD.


  METHOD get_uploaded_file_data ##NEEDED.

    TYPES: BEGIN OF mty_text,
             rec(4096) TYPE c,
           END OF mty_text.

    DATA: mo_oref_root TYPE REF TO cx_root,
          mv_text      TYPE string,
          mt_raw       TYPE STANDARD TABLE OF  mty_text,             "Raw data after uplaod
          mv_length    TYPE i.

    TRY.

*        mt_raw = data_tab.

        CALL FUNCTION 'SCMS_BINARY_TO_XSTRING'
          EXPORTING
            input_length = filelength
          IMPORTING
            buffer       = cs_failed_excel_attach-data
          TABLES
            binary_tab   = mt_raw
          EXCEPTIONS
            failed       = 1
            OTHERS       = 2.

        cs_failed_excel_attach-filename = filename.
        cs_failed_excel_attach-filesize = filelength.

        IF sy-subrc IS NOT INITIAL.
          mv_text = 'Exception while converting binary to xstring in method GET_UPLOADED_FILE_DATA'.
          APPEND mv_text TO cs_rare_interface-exceptions.
          collect_mesg( mv_text ).
          CLEAR mv_text.
        ENDIF.

      CATCH cx_root INTO mo_oref_root.
        mv_text = mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.


  ENDMETHOD.


  METHOD get_user_config_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Fetch user configuration data
*&---------------------------------------------------------------------*
    DATA:   mo_oref_root TYPE REF TO cx_root,
            mv_text      TYPE string.

    TRY.


      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.
  ENDMETHOD.


  METHOD get_user_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : User details
*&---------------------------------------------------------------------*

    DATA :  mo_oref_root TYPE REF TO cx_root,
            mv_text      TYPE string,
            ms_address   TYPE bapiaddr3,
            mt_return    TYPE TABLE OF bapiret2,
            ms_return    TYPE          bapiret2.

    TRY.

        CALL FUNCTION 'BAPI_USER_GET_DETAIL'
          EXPORTING
            username       = sy-uname
          IMPORTING
            logondata      = cs_rare_interface-logon
            address        = ms_address
          TABLES
            parameter      = cs_rare_interface-userparams
            profiles       = cs_rare_interface-profiles
            activitygroups = cs_rare_interface-roles
            return         = mt_return
          EXCEPTIONS
            OTHERS         = 1.

        IF mt_return IS NOT INITIAL OR sy-subrc <> 0.
          CLEAR : ms_return.
          LOOP AT mt_return INTO ms_return.
            IF ms_return-type EQ 'E'.
              mv_text  = ms_return-message.
              APPEND mv_text TO cs_rare_interface-exceptions.
            ENDIF.
          ENDLOOP.
        ENDIF.

*User Info:
        cs_rare_interface-userinfo-uname    = sy-uname.
        cs_rare_interface-userinfo-date     = sy-datum.
        cs_rare_interface-userinfo-time     = sy-uzeit.
        cs_rare_interface-userinfo-sysid    = sy-sysid.
        cs_rare_interface-userinfo-langu    = sy-langu.
        cs_rare_interface-userinfo-mandt    = sy-mandt.
        cs_rare_interface-userinfo-username = ms_address-fullname.
        cs_rare_interface-userinfo-email    = ms_address-e_mail.
        cs_rare_interface-userinfo-usrlangu = ms_address-langu_iso.

        IF cs_rare_interface-userinfo-date < sy-datum.
          MESSAGE w009(yz_msag_rare) INTO mv_text WITH sy-uname.
          collect_header_data( iv_header_type = 'BH' iv_header_msg = mv_text iv_header_criticality = 'M').
        ENDIF.

        IF cs_rare_interface-userinfo-langu <> sy-langu.
          MESSAGE w003(yz_msag_rare) INTO mv_text WITH sy-uname.
          collect_header_data( iv_header_type = 'BH' iv_header_msg = mv_text iv_header_criticality = 'M').
        ENDIF.

        IF cs_rare_interface-userinfo-email IS INITIAL.
          MESSAGE w002(yz_msag_rare) INTO mv_text WITH sy-uname.
          collect_header_data( iv_header_type = 'BH' iv_header_msg = mv_text iv_header_criticality = 'M').
        ENDIF.

      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.

  ENDMETHOD.


  METHOD get_user_exit_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Fetch user exits for specific tcode
*&---------------------------------------------------------------------*

    DATA:  mo_oref_root    TYPE REF TO cx_root,
           mv_text         TYPE string,
           mv_devclass     TYPE tadir-devclass,
           ms_dir          TYPE trdir,
           mt_exit_details TYPE TABLE OF tadir,
           ms_tstc         TYPE tstc,
           ms_tadir        TYPE tadir,
           ms_tfdir        TYPE tfdir,
           ms_enlfdir      TYPE enlfdir,
           ms_tadir1       TYPE tadir,
           mv_exit_count   TYPE i,
           mv_tcode        TYPE sy-tcode.

    TRY.

        IF iv_tcode IS INITIAL.
          mv_tcode = cv_tcode.
        ELSE.
          mv_tcode = iv_tcode.
        ENDIF.

        SELECT SINGLE *                                 "#EC CI_GENBUFF
                 FROM tstc
                 INTO ms_tstc
                WHERE tcode EQ mv_tcode.                "#EC CI_GENBUFF


        SELECT SINGLE *                                 "#EC CI_GENBUFF
                  FROM tadir
                  INTO ms_tadir
                 WHERE pgmid = 'R3TR'
                   AND object = 'PROG'
                   AND obj_name = ms_tstc-pgmna.        "#EC CI_GENBUFF

        MOVE : ms_tadir-devclass TO mv_devclass.

        IF sy-subrc NE 0.

          SELECT SINGLE *                               "#EC CI_GENBUFF
                   FROM trdir
                   INTO ms_dir
                  WHERE name = ms_tstc-pgmna.           "#EC CI_GENBUFF

          IF ms_dir-subc EQ 'F'.

            SELECT SINGLE *                             "#EC CI_GENBUFF
                     FROM tfdir
                     INTO ms_tfdir
                    WHERE pname = ms_tstc-pgmna.        "#EC CI_GENBUFF

            SELECT SINGLE *                             "#EC CI_GENBUFF
                     FROM enlfdir
                     INTO ms_enlfdir
                    WHERE funcname = ms_tfdir-funcname. "#EC CI_GENBUFF

            SELECT SINGLE *                             "#EC CI_GENBUFF
                     FROM tadir
                     INTO ms_tadir1
                    WHERE pgmid  = 'R3TR'
                      AND object = 'FUGR'
                      AND obj_name EQ ms_enlfdir-area.  "#EC CI_GENBUFF

            MOVE : ms_tadir1-devclass TO mv_devclass.

          ENDIF.

        ENDIF.

        SELECT *                                        "#EC CI_GENBUFF
          FROM tadir
    INTO TABLE mt_exit_details
         WHERE pgmid = 'R3TR'
           AND object IN ('SMOD')
           AND devclass = mv_devclass.                  "#EC CI_GENBUFF

        IF sy-subrc EQ 0.

          et_exit_details[] = mt_exit_details[].
          cs_rare_interface-exit_details[] = mt_exit_details[].

          " user exits implemented for followig tcode
          mv_exit_count = lines( cs_rare_interface-exit_details[] ).
          MESSAGE i018(yz_msag_rare) INTO mv_text WITH mv_exit_count cv_tcode.
          collect_header_data( iv_header_type = 'CH' iv_header_msg = mv_text iv_header_criticality = 'L').

        ELSE.

          "No user exits implemented for followig tcode
          MESSAGE i016(yz_msag_rare) INTO mv_text WITH   cv_tcode.
          collect_header_data( iv_header_type = 'CH' iv_header_msg = mv_text iv_header_criticality = 'L').

        ENDIF.


      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.

  ENDMETHOD.


  METHOD get_user_session_info.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : User session information
*&---------------------------------------------------------------------*

    DATA:   mo_oref_root TYPE REF TO cx_root,
            mv_text      TYPE string.
    DATA:
      BEGIN OF ms_session_info,
        hostaddr            TYPE  msxxlist-hostadr,
        terminal                                  ,
        act_sessions        TYPE  sm04dic-counter,
        max_sessions        TYPE  sm04dic-counter,
        my_session          TYPE  sm04dic-counter,
        my_internal_session TYPE  sm04dic-counter,
        task_state          TYPE  sm04dic-counter,
        update_rec_exist    TYPE  thfb_bool,
        tid                 TYPE  sy-index,
        gui_check_failed    TYPE  sy-index,
        addrstr             TYPE  ni_nodeaddr,
        rc                  TYPE  i,
      END OF ms_session_info .

    TRY.

        CALL FUNCTION 'TH_USER_INFO'
          EXPORTING
            client              = sy-mandt
            user                = sy-uname
            check_gui           = 0
          IMPORTING
            hostaddr            = ms_session_info-hostaddr
            terminal            = ms_session_info-terminal
            act_sessions        = ms_session_info-act_sessions
            max_sessions        = ms_session_info-max_sessions
            my_session          = ms_session_info-my_session
            my_internal_session = ms_session_info-my_internal_session
            task_state          = ms_session_info-task_state
            update_rec_exist    = ms_session_info-update_rec_exist
            tid                 = ms_session_info-tid
            gui_check_failed    = ms_session_info-gui_check_failed
            addrstr             = ms_session_info-addrstr
            rc                  = ms_session_info-rc.

        cs_rare_interface-session_info-hostaddr              = ms_session_info-hostaddr.
        cs_rare_interface-session_info-terminal              = ms_session_info-terminal.
        cs_rare_interface-session_info-act_sessions          = ms_session_info-act_sessions.
        cs_rare_interface-session_info-max_sessions          = ms_session_info-max_sessions.
        cs_rare_interface-session_info-my_session            = ms_session_info-my_session.
        cs_rare_interface-session_info-my_internal_session   = ms_session_info-my_internal_session.
        cs_rare_interface-session_info-task_state            = ms_session_info-task_state.
        cs_rare_interface-session_info-update_rec_exist      = ms_session_info-update_rec_exist.
        cs_rare_interface-session_info-tid                   = ms_session_info-tid.
        cs_rare_interface-session_info-gui_check_failed      = ms_session_info-gui_check_failed.
        cs_rare_interface-session_info-addrstr               = ms_session_info-addrstr.

*HEADER*

      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.

  ENDMETHOD.


  METHOD get_web_service_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Fetch data from Webservice
*&---------------------------------------------------------------------*
    DATA:
      mt_consumer_overview_list TYPE  srt_perf_consumer_overview_tab,
      mt_consumer_detail_list   TYPE  srt_perf_consumer_detail_tab,
      mt_provider_overview_list TYPE  srt_perf_provider_overview_tab,
      mt_provider_detail_list   TYPE  srt_perf_provider_detail_tab,
      mt_shortcut_overview_list TYPE  srt_perf_shortcut_overview_tab,
      mt_shortcut_detail_list   TYPE  srt_perf_shortcut_detail_tab,
      mt_error_info_list        TYPE  srt_error_info_tab,
      mv_tcode                  TYPE  sysuuid_c.

    DATA:  mo_oref_root TYPE REF TO cx_root,
           mv_text      TYPE string.


    TRY.
*download top 10 eneteries based on recent time on table srt_util_trcperf

        CALL FUNCTION 'SRTUTIL_PERF_GET_SUMMARY'
          EXPORTING
            transaction_id         = mv_tcode
          TABLES
            consumer_overview_list = mt_consumer_overview_list
            consumer_detail_list   = mt_consumer_detail_list
            provider_overview_list = mt_provider_overview_list
            provider_detail_list   = mt_provider_detail_list
            shortcut_overview_list = mt_shortcut_overview_list
            shortcut_detail_list   = mt_shortcut_detail_list
            error_info_list        = mt_error_info_list
          EXCEPTIONS
            OTHERS                 = 1.

        IF sy-subrc <> 0.
          mv_text = 'Error while calling function SRTUTIL_PERF_GET_SUMMARY in GET_WEB_SERVICE_DATA method'(076).
          APPEND mv_text TO cs_rare_interface-exceptions.
          collect_mesg( mv_text ).
          CLEAR mv_text.
        ENDIF.

      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.


  ENDMETHOD.


  METHOD get_workflow_data ##NEEDED.
  ENDMETHOD.


  METHOD get_workitemid.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Get work item ID
*&---------------------------------------------------------------------*
    DATA :
      mo_oref      TYPE REF TO cx_root,
      mv_text      TYPE string,
      mv_user      TYPE string,
      mv_task      TYPE char14,
      ms_rare_swch TYPE yztabl_rare_swch.


    TRY.

        CALL METHOD cl_progress_indicator=>progress_indicate
          EXPORTING
            i_text               = 'Get WorkItem ID'(172)
            i_output_immediately = abap_true
            i_processed          = 2
            i_total              = 3.


        IF is_rare_inci-guid IS NOT INITIAL.

          mv_user = 'US' && is_rare_inci-user_name.

          "Get  wf template no. from switch table
          SORT ct_rare_swch .
          READ TABLE ct_rare_swch INTO         ms_rare_swch
                                  TRANSPORTING vadata2
                                  WITH KEY     obj_name  = 'GET_WORKITEMID'
                                               task_name = 'WORKFLOW_DETERMINATION'
                                               vakey1    = 'WF_TEMPLATE'
                                               vadata1   = 'ON'
                                               active    = abap_true
                                               BINARY SEARCH .

          IF  sy-subrc = 0 AND ms_rare_swch-vadata2 IS NOT INITIAL .

            mv_task = ms_rare_swch-vadata2.

            SELECT SINGLE wi_id
                     FROM swwwihead
                     INTO rv_wi_id
                    WHERE wi_type    EQ 'F'
                      AND wi_creator EQ mv_user
                      AND wi_lang    EQ sy-langu
                      AND wi_text    EQ is_rare_inci-guid
                      AND wi_cd      EQ sy-datum
                      AND wi_rh_task EQ mv_task."'WS99500020'.

            IF sy-subrc = 0.

              mv_text = 'RaRe Data successfully saved with WorkItem Id : '(173) && rv_wi_id.
              CALL METHOD cl_progress_indicator=>progress_indicate
                EXPORTING
                  i_text               = mv_text
                  i_output_immediately = abap_true
                  i_processed          = 3
                  i_total              = 3.
            ELSE.

              SELECT SINGLE wi_id
                       FROM swwwihead
                       INTO rv_wi_id
                      WHERE wi_type    EQ 'F'
                        AND wi_text    EQ is_rare_inci-guid
                        AND wi_rh_task EQ mv_task."'WS99500020'.

              IF sy-subrc = 0.

                mv_text = 'RaRe Data successfully saved with WorkItem Id : '(173) && rv_wi_id.
                CALL METHOD cl_progress_indicator=>progress_indicate
                  EXPORTING
                    i_text               = mv_text
                    i_output_immediately = abap_true
                    i_processed          = 3
                    i_total              = 3.

              ELSE.

                mv_text = 'Workitem ID will be sync at the end of the session'(174).
                CALL METHOD cl_progress_indicator=>progress_indicate
                  EXPORTING
                    i_text               = mv_text
                    i_output_immediately = abap_true
                    i_processed          = 3
                    i_total              = 3.

              ENDIF.

            ENDIF.
          ELSE. "No data in switch table
            mv_text =  'No wf template found'.
            APPEND mv_text TO cs_rare_interface-exceptions.
            collect_mesg( mv_text ).
            CLEAR mv_text.
          ENDIF.
        ELSE.
          mv_text = 'we could not find Workitem ID as GUID is Empty'(175).
          APPEND mv_text TO cs_rare_interface-exceptions.
          collect_mesg( mv_text ).
          CLEAR mv_text.
        ENDIF.

        collect_mesg( mv_text ).
        CLEAR mv_text.

      CATCH cx_root INTO mo_oref.
        mv_text = mo_oref->get_text( ).

    ENDTRY.

  ENDMETHOD.


  METHOD get_wp_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team Innovation and Automation Team
*&Transport request :
*&Description       : Display Work Process details
*&---------------------------------------------------------------------*

    DATA:  mo_oref_root TYPE REF TO cx_root,
           mv_text      TYPE string.

    TRY.

        CALL FUNCTION 'TH_WPINFO'
          TABLES
            wplist     = cs_rare_interface-wpinfo
          EXCEPTIONS
            send_error = 1
            OTHERS     = 2.

        IF sy-subrc = 0.
*HEADER*
        ELSE.
          CASE sy-subrc.
            WHEN 1.
              mv_text = 'Send error exception is catched while calling TH_WPINFO in GET_WP_DATA method'(087).
              APPEND mv_text TO cs_rare_interface-exceptions.

            WHEN 2.
              mv_text = 'others exception is catched while calling TH_WPINFO in GET_WP_DATA method'(088).
              APPEND mv_text TO cs_rare_interface-exceptions.

          ENDCASE.
          collect_mesg( mv_text ).
          CLEAR mv_text.
        ENDIF.


      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.

  ENDMETHOD.


  METHOD get_wp_trace.
*Declaration
    DATA: mo_oref_root TYPE REF TO cx_root,
          mv_text      TYPE string,
          mv_file_name TYPE string,
          mt_file      TYPE STANDARD TABLE OF spflist,
          ms_wpinfo    TYPE wpinfo,
          mt_server    TYPE STANDARD TABLE OF   msxxlist_v6,
          ms_server    TYPE                     msxxlist_v6.


    TRY.

        CALL FUNCTION 'TH_SERVER_LIST'
          TABLES
            list_ipv6      = mt_server
          EXCEPTIONS
            no_server_list = 1
            OTHERS         = 2.

        IF sy-subrc <> 0.
          mv_text = 'Exception caught in FM TH_SERVER_LIST in method  GET_WP_TRACE'.
          APPEND mv_text TO cs_rare_interface-exceptions.
          collect_mesg( mv_text ).
          CLEAR mv_text.
        ENDIF.

        READ TABLE mt_server INTO ms_server INDEX 1.

        IF sy-subrc = 0.

          SORT cs_rare_interface-wpinfo BY wp_bname.

          READ TABLE cs_rare_interface-wpinfo INTO ms_wpinfo
                                          WITH KEY wp_bname = sy-uname
                                     BINARY SEARCH
                                      TRANSPORTING wp_no.

          IF sy-subrc = 0 .

            mv_file_name = 'DEV_W' && ms_wpinfo-wp_no.

            "RZL_READ_FILE.
            CALL FUNCTION 'RZL_READ_FILE'
              EXPORTING
                directory      = '.'
                name           = mv_file_name
                srvname        = ms_server-name
              TABLES
                line_tbl       = mt_file
              EXCEPTIONS
                argument_error = 1
                not_found      = 2
                send_error     = 3
                system_failure = 4
                OTHERS         = 5.

            IF sy-subrc <> 0.
              mv_text = 'Exception caught in FM RZL_READ_FILE in method  GET_WP_TRACE'.
              APPEND mv_text TO cs_rare_interface-exceptions.
              collect_mesg( mv_text ).
              CLEAR mv_text.
            ENDIF.

          ENDIF. " no wp_no exist

        ENDIF. "no server details found


      CATCH cx_root INTO mo_oref_root.
        mv_text = mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.

  ENDMETHOD.


  METHOD if_http_extension~handle_request ##NEEDED.

*local variable declaration
    DATA: mv_path     TYPE string,
          mv_wf_id    TYPE swwwihead-wi_id,
          mv_wi_id    TYPE swwwihead-wi_id,
          mv_wf_text  TYPE swwwihead-wi_text,
          mv_wf_stat  TYPE swwwihead-wi_stat,
          mv_wi_stat  TYPE swwwihead-wi_stat,
          mv_response TYPE swr_decikey,
          mv_message  TYPE string,
          mv_ret_code TYPE sy-subrc.

*local internal table and workarea declaration
    DATA: mt_request TYPE STANDARD TABLE OF string,
          ms_request LIKE LINE OF mt_request.

    DATA:   mo_oref_root TYPE REF TO cx_root,
            mv_text      TYPE string.



*local constants declaration
    CONSTANTS: lc_dec_app TYPE swr_decikey VALUE '0001',
               lc_dec_rej TYPE swr_decikey VALUE '0002'.

    CLEAR: mv_path,
    mt_request,
    ms_request,
    mv_wf_id,
    mv_wi_id,
    mv_wf_text,
    mv_wf_stat,
    mv_wi_stat,
    mv_response,
    mv_message,
    mv_ret_code.

    TRY.

* get the request attributes
        mv_path = server->request->get_header_field( name = '~path_info' ).
        SHIFT mv_path LEFT BY 1 PLACES.
        SPLIT mv_path AT '/' INTO TABLE mt_request.

*check the input request
        CLEAR: ms_request.
        READ TABLE mt_request INTO ms_request INDEX 1.
        IF sy-subrc EQ 0.
          mv_wf_id        = ms_request.
        ENDIF.

        CLEAR: ms_request.
        READ TABLE mt_request INTO ms_request INDEX 2.
        IF sy-subrc EQ 0.
          mv_response        = ms_request.
        ENDIF.

        IF mv_wf_id IS NOT INITIAL AND mv_response IS NOT INITIAL.
****
*          SELECT SINGLE wi_text wi_stat
*            FROM swwwihead
*            INTO (mv_wf_text, mv_wf_stat)
*           WHERE wi_id EQ mv_wf_id.
***
*          IF sy-subrc EQ 0 AND mv_wf_stat EQ 'STARTED'.

*            SELECT SINGLE wi_id wi_stat
*              FROM swwwihead
*              INTO (mv_wi_id, mv_wi_stat)
*             WHERE wi_type EQ 'W' AND
*                   wi_rh_task = 'TS90000009' AND
*                   parent_wi = mv_wf_id.
*
*            IF sy-subrc EQ 0.
*
*              IF mv_wi_id IS NOT INITIAL AND mv_wi_stat EQ 'READY'.
*
*                CALL FUNCTION 'SAP_WAPI_DECISION_COMPLETE'
*                  EXPORTING
*                    workitem_id  = mv_wi_id
*                    user         = sy-uname
*                    decision_key = mv_response
*                    do_commit    = 'X'
*                  IMPORTING
*                    return_code  = mv_ret_code.
*
**                IF mv_ret_code EQ 0.

          IF mv_response EQ lc_dec_app.

            get_container_data( EXPORTING iv_wi_id     = mv_wf_id
                               IMPORTING es_rare_data = cs_rare_interface ).
*            connect_snow( ).
            connect_snow_using_rest_api( ).
            send_rare_attachment( ).
            CONCATENATE 'Request successfully approved. Incident created : '(037) cs_rare_interface-rare_inci-inc_no  INTO mv_message
            SEPARATED BY space.


          ELSEIF mv_response EQ lc_dec_rej.

            CONCATENATE 'Request declined. Requestor will be notified via email.'(038) mv_wf_text  INTO mv_message
            SEPARATED BY space.

          ENDIF.
*
*                ELSE.
*
*                  mv_message = 'Error in processing request.'(039).

*                ENDIF.
*
*              ENDIF.
*            ENDIF.
*          ELSE.
*
*            mv_message = 'Request is already processed.'(040).
*
*          ENDIF.

        ENDIF.

        server->response->set_cdata( mv_message ).


      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
    ENDTRY.


  ENDMETHOD.


  METHOD init.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Initialize
*&---------------------------------------------------------------------*

*Declaration
    DATA: mo_oref_root TYPE REF TO cx_root,
          mv_text      TYPE string.

    DATA: ms_help_info TYPE string.

    FIELD-SYMBOLS : <fs_help_info> TYPE any.
    TRY.
        IF iv_calling_tcode IS INITIAL.
          ms_help_info = '(SAPMSHLP)HELP_INFO'.
          ASSIGN  (ms_help_info) TO <fs_help_info>.
          IF  <fs_help_info> IS ASSIGNED.
            IF <fs_help_info> IS NOT INITIAL.
              cs_help_info = <fs_help_info>.
              cv_tcode = cs_help_info-tcode.
              cs_rare_interface-tcode_data-tcode = cs_help_info-tcode.
            ENDIF.
          ENDIF.
        ELSE.
          cv_tcode = iv_calling_tcode.
          cs_rare_interface-tcode_data-tcode = iv_calling_tcode.
        ENDIF.


        get_snow_cat_grp_details( ).
*Store System variables
        cs_rare_interface-syst = sy.

      CATCH cx_root INTO mo_oref_root.
        mv_text = mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.

  ENDMETHOD.


  method INIT_SR.
*{   INSERT         DIMK902864                                        1
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Initialize
*&---------------------------------------------------------------------*

*Declaration
    DATA: mo_oref_root TYPE REF TO cx_root,
          mv_text      TYPE string.

    DATA: ms_help_info TYPE string.

    FIELD-SYMBOLS : <fs_help_info> TYPE any.
    TRY.
        IF iv_calling_tcode IS INITIAL.
          ms_help_info = '(SAPMSHLP)HELP_INFO'.
          ASSIGN  (ms_help_info) TO <fs_help_info>.
          IF  <fs_help_info> IS ASSIGNED.
            IF <fs_help_info> IS NOT INITIAL.
              cs_help_info = <fs_help_info>.
              cv_tcode = cs_help_info-tcode.
              cs_rare_interface-tcode_data-tcode = cs_help_info-tcode.
            ENDIF.
          ENDIF.
        ELSE.
          cv_tcode = iv_calling_tcode.
          cs_rare_interface-tcode_data-tcode = iv_calling_tcode.
        ENDIF.

*Store System variables
        cs_rare_interface-syst = sy.

      CATCH cx_root INTO mo_oref_root.
        mv_text = mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.
*}   INSERT
  endmethod.


  METHOD launch_popup_screen.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Triggers the pop-up screen to be displayed
*&---------------------------------------------------------------------*
    DATA:  mo_oref_root TYPE REF TO cx_root,
           mv_text      TYPE string,
           mv_msg       TYPE string,
           ms_rare_inci TYPE yztabl_rare_inci.

    DATA:  mv_screen_field_updated TYPE flag.

    TRY.

*Progress Bar info
        CALL METHOD cl_progress_indicator=>progress_indicate
          EXPORTING
            i_text               = 'Launching ITSM Screen'(041)
            i_output_immediately = abap_true.

*Store Info for Audit
        IF cs_rare_interface-rare_inci-guid IS INITIAL.
          cs_rare_interface-rare_inci-guid = generate_guid( ).
        ENDIF.

        CALL FUNCTION 'YZ_FUNC_RARE_LAUNCH_POPUP'
          IMPORTING
            screen_fields_updated = mv_screen_field_updated
          CHANGING
            cs_rare_inci          = cs_rare_interface-rare_inci.

*Get Entered Data by User
        SELECT SINGLE *
                 FROM yztabl_rare_inci
                 INTO cs_rare_interface-rare_inci
                WHERE guid = cs_rare_interface-rare_inci-guid.

*Transfer to Global ITSM Details
        IF sy-subrc = 0.
          CONCATENATE 'Inputs are provided by User'(042) sy-uname INTO mv_msg SEPARATED BY space.
          collect_mesg( mv_msg ).
        ELSE.
          mv_msg = 'Inputs are missing'(043).
          collect_mesg( mv_msg ).
        ENDIF.


      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.

  ENDMETHOD.


  METHOD launch_workflow.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Launches the Workflow
*&---------------------------------------------------------------------*

* Data Declarations
    DATA:
      mo_oref_root TYPE REF TO cx_root,
      mv_text      TYPE string.

    DATA: mv_return_code TYPE sy-subrc,
          mv_workitem_id TYPE swr_struct-workitemid,
          mv_new_status  TYPE swr_wistat.

    DATA: mv_creator          TYPE swwwihead-wi_creator,
          mo_container_handle TYPE REF TO if_swf_cnt_container,
          mo_data             TYPE REF TO data,
          mv_task             TYPE sww_task,
          ms_rare_swch        TYPE yztabl_rare_swch.

    DATA mx_swf_cnt_container TYPE REF TO cx_swf_cnt_container.

    DATA wf_initiator TYPE swhactor.

    TRY.
        CALL METHOD cl_progress_indicator=>progress_indicate
          EXPORTING
            i_text               = 'Launching Automated Workflow To Save RaRe Data'(171)
            i_output_immediately = abap_true
            i_processed          = 1
            i_total              = 3.


*        IF cv_workflow_launched = abap_false.
*          raise_workflow_event( 'START_WF' ).
*          cv_workflow_launched = abap_true.
*        ELSE.
*          raise_workflow_event( 'UPDATE_WF_CONTAINER' ).
*          cv_workflow_container_updated = abap_true.
*        ENDIF.
*
*        IF 1 = 1.
*          EXIT.
*        ENDIF.

        mo_container_handle = cl_swf_cnt_factory=>create( ).
        IF mo_container_handle IS BOUND.

          wf_initiator-otype = 'US'.
          wf_initiator-objid = sy-uname.

          TRY.
              CALL METHOD mo_container_handle->element_set
                EXPORTING
                  name             = '_WF_INITIATOR'
                  value            = wf_initiator
                IMPORTING
                  exception_return = mx_swf_cnt_container.     " First Exception That Occurred (If Queried: No RAISE)

            CATCH cx_swf_cnt_cont_access_denied.    "
            CATCH cx_swf_cnt_elem_not_found.    "
            CATCH cx_swf_cnt_elem_access_denied.    "
            CATCH cx_swf_cnt_elem_type_conflict.    "
            CATCH cx_swf_cnt_unit_type_conflict.    "
            CATCH cx_swf_cnt_elem_def_invalid.    "
            CATCH cx_swf_cnt_invalid_qname.    "
            CATCH cx_swf_cnt_container.    "

          ENDTRY.

          TRY.
              CALL METHOD mo_container_handle->element_set
                EXPORTING
                  name             = 'KEY'
                  value            = cs_rare_interface-rare_inci-guid
                IMPORTING
                  exception_return = mx_swf_cnt_container.     " First Exception That Occurred (If Queried: No RAISE)

            CATCH cx_swf_cnt_cont_access_denied.    "
            CATCH cx_swf_cnt_elem_not_found.    "
            CATCH cx_swf_cnt_elem_access_denied.    "
            CATCH cx_swf_cnt_elem_type_conflict.    "
            CATCH cx_swf_cnt_unit_type_conflict.    "
            CATCH cx_swf_cnt_elem_def_invalid.    "
            CATCH cx_swf_cnt_invalid_qname.    "
            CATCH cx_swf_cnt_container.    "

          ENDTRY.

          TRY.
              CALL METHOD mo_container_handle->element_set
                EXPORTING
                  name             = 'RARE_ACTION'
                  value            = cv_rare_action
                IMPORTING
                  exception_return = mx_swf_cnt_container.     " First Exception That Occurred (If Queried: No RAISE)

            CATCH cx_swf_cnt_cont_access_denied.    "
            CATCH cx_swf_cnt_elem_not_found.    "
            CATCH cx_swf_cnt_elem_access_denied.    "
            CATCH cx_swf_cnt_elem_type_conflict.    "
            CATCH cx_swf_cnt_unit_type_conflict.    "
            CATCH cx_swf_cnt_elem_def_invalid.    "
            CATCH cx_swf_cnt_invalid_qname.    "
            CATCH cx_swf_cnt_container.    "

          ENDTRY.


          TRY.

              IF co_rare_base IS NOT BOUND.
                CREATE OBJECT co_rare_base.
              ENDIF.
              co_rare_base->cs_rare_interface = cs_rare_interface.


              CALL METHOD mo_container_handle->element_set
                EXPORTING
                  name             = 'RARE_OBJECT'
                  value            = co_rare_base
                IMPORTING
                  exception_return = mx_swf_cnt_container.     " First Exception That Occurred (If Queried: No RAISE)

            CATCH cx_swf_cnt_cont_access_denied.    "
            CATCH cx_swf_cnt_elem_not_found.    "
            CATCH cx_swf_cnt_elem_access_denied.    "
            CATCH cx_swf_cnt_elem_type_conflict.    "
            CATCH cx_swf_cnt_unit_type_conflict.    "
            CATCH cx_swf_cnt_elem_def_invalid.    "
            CATCH cx_swf_cnt_invalid_qname.    "
            CATCH cx_swf_cnt_container.    "

          ENDTRY.

          TRY.

* Get the required attribute from the container
              CALL METHOD mo_container_handle->element_set
                EXPORTING
                  name             = 'RARE_DATA'
                  value            = cs_rare_interface
                IMPORTING
                  exception_return = mx_swf_cnt_container.     " First Exception That Occurred (If Queried: No RAISE)

            CATCH cx_swf_cnt_cont_access_denied.    "
            CATCH cx_swf_cnt_elem_not_found.    "
            CATCH cx_swf_cnt_elem_access_denied.    "
            CATCH cx_swf_cnt_elem_type_conflict.    "
            CATCH cx_swf_cnt_unit_type_conflict.    "
            CATCH cx_swf_cnt_elem_def_invalid.    "
            CATCH cx_swf_cnt_invalid_qname.    "
            CATCH cx_swf_cnt_container.    "

          ENDTRY.

        ELSE.
*"handle exception
          EXIT.
        ENDIF.

        IF cs_rare_interface-rare_inci-wi_id IS INITIAL.

          "Get  wf template no. from switch table
          SORT ct_rare_swch .
          READ TABLE ct_rare_swch INTO      ms_rare_swch
                                  WITH KEY  obj_name  = 'LAUNCH_WORKFLOW'
                                            task_name = 'WORKFLOW_DETERMINATION'
                                            vakey1    = 'WF_TEMPLATE'
                                            vadata1   = 'ON'
                                            active    = abap_true
                                            BINARY SEARCH
                                            TRANSPORTING vadata2.
          IF sy-subrc = 0 .

            DATA: l_creator             TYPE swwwihead-wi_creator,
                  l_wi_type             TYPE swwwihead-wi_type,
                  t_agents              TYPE STANDARD TABLE OF  swhactor,
                  t_deadline_agents     TYPE STANDARD TABLE OF  swhactor,
                  t_excluded_agents     TYPE STANDARD TABLE OF  swhactor,
                  t_notification_agents TYPE STANDARD TABLE OF  swhactor,
                  t_secondary_methods   TYPE STANDARD TABLE OF  swwmethods,
                  t_wi_container        TYPE STANDARD TABLE OF  swcont,
                  t_comp_events         TYPE STANDARD TABLE OF  swwcompevt.


            mv_creator = sy-uname.
            mv_task    = ms_rare_swch-vadata2."'WS99500020'.

* get workitem type (WF, WS, T, TS, ...?)
            CALL FUNCTION 'RH_GET_WORKITEM_TYPE'
              EXPORTING
                task_object        = mv_task
              IMPORTING
                wi_type            = l_wi_type
              EXCEPTIONS
                no_valid_task_type = 01.

            CALL FUNCTION 'SWW_WI_START'
              EXPORTING
                creator                      = mv_creator
                task                         = mv_task
                workitem_type                = l_wi_type
                do_commit                    = ' '
*               DO_SYNC_CALLBACK             = ' '
*               TEXT                         = ' '
                do_sync_wi_chain             = 'X'
                created_by_user              = sy-uname
*               CREATED_BY_ADDRESS           = ' '
*               CALLED_IN_BACKGROUND         = 'X'
*               STEP_MODELED_WI_DISPLAY      = ' '
*               NO_DEADLINE_PARAMETERS       = ' '
*               RESTRICTED_LOG               = ' '
*               SECONDS_UNTIL_TIMEOUT        =
                create_event                 = 'X'
*               STATUS_EVENT                 = ' '
*               XML_PROTOCOL                 =
*               WLC_FLAGS                    =
*               START_PROPERTIES             =
*               DEBUG_FLAG                   = ' '
*               TRACE_FLAG                   = ' '
                wi_container_handle          = mo_container_handle
*               START_ASYNCHRONOUS           = ' '
              IMPORTING
                wi_id                        = mv_workitem_id
*               WI_HEADER                    =
*               RETURN                       =
*               WI_RESULT                    =
*               SWF_RETURN                   =
*               NEW_STATUS                   =
              TABLES
                agents                       = t_agents
                deadline_agents              = t_deadline_agents
                excluded_agents              = t_excluded_agents
                notification_agents          = t_notification_agents
                secondary_methods            = t_secondary_methods
                wi_container                 = t_wi_container
                comp_events                  = t_comp_events
              EXCEPTIONS
                id_not_created               = 1
                read_failed                  = 2
                immediate_start_not_possible = 3
                execution_failed             = 4
                invalid_status               = 5
                OTHERS                       = 6.

            IF sy-subrc <> 0.
              mv_text =  'Exception in starting workflow'.
              APPEND mv_text TO cs_rare_interface-exceptions.
              collect_mesg( mv_text ).
              CLEAR mv_text.
            ELSE.
              cs_rare_interface-rare_inci-wi_id = mv_workitem_id.
              commit_work( ).
            ENDIF.

          ELSE."No WF template found in switch table
            mv_text =  'No WF template found in switch table'.
            APPEND mv_text TO cs_rare_interface-exceptions.
            collect_mesg( mv_text ).
            CLEAR mv_text.
          ENDIF.

        ELSE.
          set_container_data( cs_rare_interface-rare_inci-wi_id ).
          commit_work( ).
*          CALL FUNCTION 'SAP_WAPI_WORKITEM_COMPLETE'
*            EXPORTING
*              workitem_id = cs_rare_interface-rare_inci-wi_id.

        ENDIF.

      CATCH cx_root INTO mo_oref_root.
        mv_text = mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.

    ENDTRY.


  ENDMETHOD.


  METHOD open_file_save_dialog.

*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Method for implementing download functionality for the PDF
*&---------------------------------------------------------------------*

    DATA :
      mo_oref              TYPE REF TO cx_root,
      mv_text              TYPE string,
      mv_default_file_name TYPE string.

    mv_default_file_name = 'Incident_info'(208).

    TRY.

        CALL METHOD cl_progress_indicator=>progress_indicate
          EXPORTING
            i_text               = 'Select Path'(069)
            i_output_immediately = abap_true
            i_processed          = 3
            i_total              = 4.

        CALL METHOD cl_gui_frontend_services=>file_save_dialog
          EXPORTING
            default_extension         = 'PDF'
            default_file_name         = mv_default_file_name
          CHANGING
            filename                  = cv_file_name
            path                      = cv_folder
            fullpath                  = cv_fullpath
          EXCEPTIONS
            cntl_error                = 1
            error_no_gui              = 2
            not_supported_by_gui      = 3
*            invalid_default_file_name = 4
            OTHERS                    = 5.

        rv_subrc = sy-subrc.

        IF rv_subrc <> 0.
          CASE rv_subrc.

            WHEN 1.
              mv_text = 'cntl_error  is catched while OPEN_FILE_SAVE_DIALOG method'(209).
              APPEND mv_text TO cs_rare_interface-exceptions.

            WHEN 2.
              mv_text = 'error_no_gui is catched while OPEN_FILE_SAVE_DIALOG method'(210).
              APPEND mv_text TO cs_rare_interface-exceptions.

            WHEN 3.
              mv_text = 'not_supported_by_gui  is catched while OPEN_FILE_SAVE_DIALOG method'(211).
              APPEND mv_text TO cs_rare_interface-exceptions.

            WHEN 4.
              mv_text = 'invalid_default_file_name is catched while OPEN_FILE_SAVE_DIALOG method'(212).
              APPEND mv_text TO cs_rare_interface-exceptions.

            WHEN 5.
              mv_text = 'OTHERS  is catched while OPEN_FILE_SAVE_DIALOG method'(213).
              APPEND mv_text TO cs_rare_interface-exceptions.

          ENDCASE.
          collect_mesg( mv_text ).
          CLEAR mv_text.

        ENDIF.

      CATCH cx_root INTO mo_oref.
        mv_text = mo_oref->get_text( ).
        MESSAGE mv_text TYPE 'I'.
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.

  ENDMETHOD.


  METHOD open_pdf_job.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Display PDF form - pre Job
*&---------------------------------------------------------------------*

    DATA: mo_oref_root TYPE REF TO cx_root,
          mv_text      TYPE string.

    TRY.

        CALL METHOD cl_progress_indicator=>progress_indicate
          EXPORTING
            i_text               = 'Open PDF form with Optimization'(204)
            i_output_immediately = abap_true
            i_processed          = 1
            i_total              = 4.

        CALL FUNCTION 'FP_JOB_OPEN'
          CHANGING
            ie_outputparams = cv_outputparams
          EXCEPTIONS
            cancel          = 1
            usage_error     = 2
            system_error    = 3
            internal_error  = 4
            OTHERS          = 5.

        rv_subrc = sy-subrc.
        CASE rv_subrc.
          WHEN 1.
            mv_text = 'cancel exception is catched while calling FP_JOB_OPEN in OPEN_PDF_JOB method'(179).
            APPEND mv_text TO cs_rare_interface-exceptions.

          WHEN 2.
            mv_text = 'usage_error exception is catched while calling FP_JOB_OPEN in OPEN_PDF_JOB method'(181).
            APPEND mv_text TO cs_rare_interface-exceptions.

          WHEN 3.
            mv_text = 'system_error exception is catched while calling FP_JOB_OPEN in OPEN_PDF_JOB method'(182).
            APPEND mv_text TO cs_rare_interface-exceptions.

          WHEN 4.
            mv_text = 'internal_error exception is catched while calling FP_JOB_OPEN in OPEN_PDF_JOB method'(183).
            APPEND mv_text TO cs_rare_interface-exceptions.

          WHEN 5.
            mv_text = 'Others exception is catched while calling FP_JOB_OPEN in OPEN_PDF_JOB method'(184).
            APPEND mv_text TO cs_rare_interface-exceptions.

        ENDCASE.
        collect_mesg( mv_text ).
        CLEAR mv_text.

      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.

  ENDMETHOD.


  METHOD popup_control.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Popup control
*&---------------------------------------------------------------------*
*Declaration
    DATA: mo_oref_root TYPE REF TO cx_root,
          mv_text      TYPE string,
          mv_msg       TYPE string.
    data: lv_msg type string.
    TRY.

*RaRe Action
        cv_rare_action = cc_action_launched.


*Checking the call - Internal or External
        IF is_rare_inci IS SUPPLIED.
          IF is_rare_inci IS NOT INITIAL.
            CLEAR cs_rare_interface.
            get_container_data( EXPORTING iv_wi_id     = sync_workitem( is_rare_inci )
                                IMPORTING es_rare_data = cs_rare_interface ).
            cs_rare_interface-rare_inci           = is_rare_inci.
            cs_rare_interface-rare_inci-user_name = sy-uname.
            cv_rare_action = cc_action_incident_resubmited.
          ENDIF.
        ENDIF.

*Launch workflow prior to popup
        save_workitem( ).           "Launch worklfow & Get workitem ID

*Launch popup for User to insert ITSM Details
        launch_popup_screen( ).
*        mv_msg = CHECK_ADS_CONNECTION( ).
        CLEAR cv_mobile_flag.

        CASE  cs_rare_interface-rare_inci-command.

*User has pressed Enter Button - Clicked on Green Icon
          WHEN 'ENT'.

            IF mv_msg IS INITIAL.

              IF cs_rare_interface-rare_inci-user_name      IS NOT INITIAL AND
              cs_rare_interface-rare_inci-short_description IS NOT INITIAL.

                cv_rare_action = cc_action_incident_requested.
                prepare_save_rare_data( ). "prepare data and then save in workitem

                "Launch Workflow for approval to create servicenow incident with approval
                IF cs_help_info-menufunct = 'YZFC_INSNA' .
                  cv_rare_action = '09'.
                  CONCATENATE 'Incident sent for Approval with reference Id : ' cs_rare_interface-rare_inci-guid into lv_msg SEPARATED BY space.
                  MESSAGE lv_msg type 'I'.
*                  MESSAGE 'Incident sent for Approval with reference Id : ' && cs_rare_interface-rare_inci-guid  TYPE 'I'.
                  save_workitem( ).
                ELSE.
                  "Creat incident in SOLMAN with attchment
                  IF cs_help_info-menufunct = 'YZFC_INSMD'.
                    create_sol_inc_with_attach( ).
                    send_rare_attachment(  ).
                  ELSE.
*                    connect_snow( ).           "pass data to Snow
                     connect_snow_using_rest_api( ).
                    send_rare_attachment(  ).
                  ENDIF.
                ENDIF.

              ENDIF.

            ELSE.
              MESSAGE 'ADS connection is not working' TYPE 'I'.
              popup_control( ).
            ENDIF.

*User Has pressed Download Button - Clicked on SAVE Icon
          WHEN 'DOW'.
            IF mv_msg IS INITIAL.
              prepare_save_rare_data( ).  "prepare Data and then save in workitem
              download_pdf( ).            "Download pdf Data
              popup_control( ).           "To hold Screen after Download
            ELSE.
              MESSAGE 'ADS connection is not working' TYPE 'I'.
              popup_control( ).
            ENDIF.

*Exit or Cancel
          WHEN 'EXI'.
*we are anyways Saving All Data in Workflow          "Launch worklfow & Get workitem ID
            cv_rare_action = cc_action_closed.

*Diplay pdf directly
          WHEN 'DIS'.
            IF mv_msg IS INITIAL.
              cv_rare_action = cc_action_displayed.

              get_pdf_form( iv_view = abap_true  ). "View pdf

              popup_control( ).           "To hold Screen after view
            ELSE.
              MESSAGE 'ADS connection is not working' TYPE 'I'.
              popup_control( ).
            ENDIF.

          WHEN 'EMA'.
            cv_mobile_flag = 'X'.
            prepare_save_rare_data( ).
            send_rare_attachment( ).
            popup_control( ).

          WHEN OTHERS.
*we are anyways Saving All Data in Workflow
            cv_rare_action = cc_action_closed.
        ENDCASE.

*Save updated content to WF container
        save_workitem( ).           "Launch worklfow & Get workitem ID

      CATCH cx_root INTO mo_oref_root.
        mv_text = mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.

  ENDMETHOD.


  METHOD prepare_save_rare_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Prepare and Save RaRe Data
*&---------------------------------------------------------------------*
*Declaration
    DATA: mo_oref_root TYPE REF TO cx_root,
          mv_text      TYPE string.

    TRY.

        get_pdf_form( ).

        get_prepared_attachment( ).

      CATCH cx_root INTO mo_oref_root.
        mv_text = mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.


  ENDMETHOD.


  METHOD raise_workflow_event.

* Data Declarations
    DATA: mv_objtype         TYPE sibftypeid,
          mv_event           TYPE sibfevent,
          mv_objkey          TYPE sibfinstid,
          mr_event_container TYPE REF TO if_swf_ifs_parameter_container,
          mv_param_name      TYPE swfdname,
          mo_oref_root       TYPE REF TO cx_root,
          mv_text            TYPE string.

    DATA:
      mo_swf_cnt_cont_access_denied TYPE REF TO  cx_swf_cnt_cont_access_denied,
      mo_swf_cnt_elem_access_denied TYPE REF TO  cx_swf_cnt_elem_access_denied,
      mo_swf_cnt_elem_not_found     TYPE REF TO  cx_swf_cnt_elem_not_found,
      mo_swf_cnt_elem_type_conflict TYPE REF TO  cx_swf_cnt_elem_type_conflict,
      mo_swf_cnt_unit_type_conflict TYPE REF TO  cx_swf_cnt_unit_type_conflict,
      mo_swf_cnt_elem_def_invalid   TYPE REF TO  cx_swf_cnt_elem_def_invalid,
      mo_swf_cnt_container          TYPE REF TO  cx_swf_cnt_container,
      mo_swf_evt_invalid_objtype    TYPE REF TO  cx_swf_evt_invalid_objtype,
      mo_swf_evt_invalid_event      TYPE REF TO  cx_swf_evt_invalid_event.

    IF cs_rare_interface-rare_inci-guid IS NOT INITIAL.
      mv_objtype = 'YZ_CLAS_RARE_BASE'. " Class Name
      mv_event   = iv_event."'START_WF'.  " Event Name.
      mv_objkey  = cs_rare_interface-rare_inci-guid.

* Instantiate an empty event container
      CALL METHOD cl_swf_evt_event=>get_event_container
        EXPORTING
          im_objcateg  = cl_swf_evt_event=>mc_objcateg_cl
          im_objtype   = mv_objtype
          im_event     = mv_event
        RECEIVING
          re_reference = mr_event_container.

*          TRY.
** Set up the name/value pair to be added to the container
      mv_param_name  = 'KEY'.  " parameter name of the event

      TRY.
* Add the name/value pair to the event conainer
          CALL METHOD mr_event_container->set
            EXPORTING
              name       = mv_param_name                 " Name of Parameter Whose Value Is to Be Set
              value      = mv_objkey                 " Value
*             unit       =                  " Unit
            IMPORTING
              returncode = DATA(lv_returncode).                 " Errors Occurred (If Asked -> No RAISE)
          .
        CATCH cx_swf_cnt_cont_access_denied. " Changed Access Not Allowed
        CATCH cx_swf_cnt_elem_access_denied. " Value/Unit Must Not Be Changed
        CATCH cx_swf_cnt_elem_not_found.     " Element Not in the Container
        CATCH cx_swf_cnt_elem_type_conflict. " Type Conflict Between Value and Current Parameter
        CATCH cx_swf_cnt_unit_type_conflict. " Type Conflict Between Unit and Current Parameter
        CATCH cx_swf_cnt_elem_def_invalid.   " Element Definition Is Invalid (Internal Error)
        CATCH cx_swf_cnt_container.          " Exception in the Container Service

      ENDTRY.


** Set up the name/value pair to be added to the container
      mv_param_name  = 'RARE_ACTION'.  " parameter name of the event

* Add the name/value pair to the event conainer
      TRY.

          CALL METHOD mr_event_container->set
            EXPORTING
              name       = mv_param_name               " Name of Parameter Whose Value Is to Be Set
              value      = cv_rare_action               " Value
*             unit       =                  " Unit
            IMPORTING
              returncode = lv_returncode.                 " Errors Occurred (If Asked -> No RAISE)

        CATCH cx_swf_cnt_cont_access_denied. " Changed Access Not Allowed
        CATCH cx_swf_cnt_elem_access_denied. " Value/Unit Must Not Be Changed
        CATCH cx_swf_cnt_elem_not_found.     " Element Not in the Container
        CATCH cx_swf_cnt_elem_type_conflict. " Type Conflict Between Value and Current Parameter
        CATCH cx_swf_cnt_unit_type_conflict. " Type Conflict Between Unit and Current Parameter
        CATCH cx_swf_cnt_elem_def_invalid.   " Element Definition Is Invalid (Internal Error)
        CATCH cx_swf_cnt_container.          " Exception in the Container Service
      ENDTRY.

** Set up the name/value pair to be added to the container
      mv_param_name  = 'RARE_DATA'.  " parameter name of the event

* Add the name/value pair to the event conainer
      TRY.

          CALL METHOD mr_event_container->set
            EXPORTING
              name       = mv_param_name               " Name of Parameter Whose Value Is to Be Set
              value      = cs_rare_interface               " Value
*             unit       =                  " Unit
            IMPORTING
              returncode = lv_returncode.                 " Errors Occurred (If Asked -> No RAISE)
        CATCH cx_swf_cnt_cont_access_denied. " Changed Access Not Allowed
        CATCH cx_swf_cnt_elem_access_denied. " Value/Unit Must Not Be Changed
        CATCH cx_swf_cnt_elem_not_found.     " Element Not in the Container
        CATCH cx_swf_cnt_elem_type_conflict. " Type Conflict Between Value and Current Parameter
        CATCH cx_swf_cnt_unit_type_conflict. " Type Conflict Between Unit and Current Parameter
        CATCH cx_swf_cnt_elem_def_invalid.   " Element Definition Is Invalid (Internal Error)
        CATCH cx_swf_cnt_container.          " Exception in the Container Service
      ENDTRY.

* Raise the event passing the prepared event container
      TRY.
          CALL METHOD cl_swf_evt_event=>raise
            EXPORTING
              im_objcateg        = cl_swf_evt_event=>mc_objcateg_cl
              im_objtype         = mv_objtype
              im_event           = mv_event
              im_objkey          = mv_objkey
              im_event_container = mr_event_container.

          commit_work( ).

        CATCH cx_swf_evt_invalid_objtype  INTO mo_swf_evt_invalid_objtype.
          mv_text = mo_swf_evt_invalid_objtype->get_text( ).
          APPEND mv_text TO cs_rare_interface-exceptions.
          collect_mesg( mv_text ).
          CLEAR mv_text.

        CATCH cx_swf_evt_invalid_event  INTO mo_swf_evt_invalid_event.
          mv_text = mo_swf_evt_invalid_event->get_text( ).
          APPEND mv_text TO cs_rare_interface-exceptions.
          collect_mesg( mv_text ).
          CLEAR mv_text.


      ENDTRY.

    ENDIF.

  ENDMETHOD.


  METHOD recover_pdf_form.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Recover PDF form
*&---------------------------------------------------------------------*
    TYPES : BEGIN OF mty_smart_analyzer,
              adobe_importing TYPE string,
              rare_data       TYPE string,
              success         TYPE boolean,
            END OF mty_smart_analyzer.

    DATA : mt_details                   TYPE abap_compdescr_tab,
           ms_details                   LIKE LINE OF mt_details,
           mo_ref_table_des             TYPE REF TO cl_abap_structdescr,
           mt_params                    TYPE TABLE OF fupararef,
           ms_params                    LIKE LINE OF mt_params,
           mv_search                    TYPE string,
           mv_fname                     TYPE string,
           mt_ptab                      TYPE abap_func_parmbind_tab,
           mt_ptab_final                TYPE abap_func_parmbind_tab,
           ms_ptab                      TYPE abap_func_parmbind,
           mt_etab                      TYPE abap_func_excpbind_tab,
           ms_etab                      TYPE abap_func_excpbind,
           mt_smart_analyzer            TYPE STANDARD TABLE OF mty_smart_analyzer,
           ms_smart_analyzer            LIKE LINE OF mt_smart_analyzer,
           mv_param_interface           TYPE char50,
           mo_oref_root                 TYPE REF TO cx_root,
           mv_text                      TYPE string,
           mv_tabix                     TYPE sy-tabix,
           mo_oref_cx_fp_api_repository TYPE REF TO  cx_fp_api_repository,
           mo_oref_cx_fp_api_usage      TYPE REF TO  cx_fp_api_usage,
           mo_oref_cx_fp_api_internal   TYPE REF TO  cx_fp_api_internal,
           mv_outputparams              TYPE sfpoutputparams.


    FIELD-SYMBOLS : <fs_itab> TYPE any.

    TRY.
* Get the structure of the table.
        mo_ref_table_des ?= cl_abap_typedescr=>describe_by_name( 'YZTABL_RARE_INTERFACE' ).

        mt_details[] = mo_ref_table_des->components[].

        IF mt_details[] IS NOT  INITIAL.

          CALL FUNCTION '/SDF/GEN_FUNCS_FUNC_INFO_GET'
            EXPORTING
              funcname               = cv_funcname
            TABLES
              pt_params              = mt_params
            EXCEPTIONS
              function_not_available = 1
              OTHERS                 = 2.

          IF sy-subrc <> 0.
            CASE sy-subrc.
              WHEN  1 .
                mv_text = 'Exception function_not_available caught in method RECOVER_PDF_FORM '(073).
                APPEND mv_text TO cs_rare_interface-exceptions.
                CLEAR mv_text.
              WHEN  2.
                mv_text = 'Exception others caught in method RECOVER_PDF_FORM '(122).
                APPEND mv_text TO cs_rare_interface-exceptions.
                CLEAR mv_text.
              WHEN OTHERS.
            ENDCASE.

          ELSE.

            SORT mt_params BY paramtype.
*set global variables to non pdf display mode
            mv_outputparams = cv_outputparams.
            cv_outputparams-preview  = abap_false.
            cv_outputparams-getpdf   = abap_true.
            CLEAR cv_outputparams-dest.



***Exporting Default
            ms_ptab-name = '/1BCDWB/DOCPARAMS'.
            ms_ptab-kind = abap_func_exporting.           .
            GET REFERENCE OF cv_docparams INTO ms_ptab-value.
            INSERT ms_ptab INTO TABLE mt_ptab.
            INSERT ms_ptab INTO TABLE mt_ptab_final.

***Exceptions
            ms_etab-name = 'USAGE_ERROR'.
            ms_etab-value = 1.
            INSERT ms_etab INTO TABLE mt_etab.
            ms_etab-name = 'SYSTEM_ERROR'.
            ms_etab-value = 2.
            INSERT ms_etab INTO TABLE mt_etab.
            ms_etab-name = 'INTERNAL_ERROR'.
            ms_etab-value = 3.
            INSERT ms_etab INTO TABLE mt_etab.
            ms_etab-name = 'OTHERS'.
            ms_etab-value = 4.
            INSERT ms_etab INTO TABLE mt_etab.

*Importing
            ms_ptab-name = '/1BCDWB/FORMOUTPUT'.
            ms_ptab-kind = abap_func_importing.           .
            GET REFERENCE OF cs_rare_interface-xstring INTO ms_ptab-value.
            INSERT ms_ptab INTO TABLE mt_ptab.
            INSERT ms_ptab INTO TABLE mt_ptab_final.

            LOOP AT mt_params INTO ms_params WHERE paramtype = 'I'.
              mv_tabix = sy-tabix.
              IF  ms_params-parameter CS '/'.
                CONTINUE.
              ENDIF.

              mv_search = ms_params-parameter+3.

              READ TABLE mt_details INTO ms_details WITH TABLE KEY name = mv_search.
              IF sy-subrc <> 0.
                CONTINUE.
              ENDIF.

*Except importing and 1st importing parameter delete rest
              DELETE mt_ptab FROM 3.

*** Exporting Parameters
              mv_param_interface = 'CS_RARE_INTERFACE-' && ms_params-parameter+3.
              ms_ptab-name = ms_params-parameter.
              ms_ptab-kind = abap_func_exporting.

              ASSIGN (mv_param_interface) TO <fs_itab> .

              IF <fs_itab> IS ASSIGNED AND open_pdf_job( ) = 0.
                GET REFERENCE OF <fs_itab> INTO ms_ptab-value.
                INSERT ms_ptab INTO TABLE mt_ptab.
              ELSE.
                CONTINUE.
              ENDIF.

              TRY.
***Call FM
                  mv_text = 'RECOVERY CHECK FOR' && ` ` && ms_params-parameter.
                  CALL METHOD cl_progress_indicator=>progress_indicate
                    EXPORTING
                      i_text               = mv_text
                      i_output_immediately = abap_true
                      i_processed          = mv_tabix
                      i_total              = lines( mt_params ).


                  CALL FUNCTION cv_funcname "'/1BCDWB/SM00000052'
                    PARAMETER-TABLE
                    mt_ptab
                    EXCEPTION-TABLE
                    mt_etab.

                CATCH cx_sy_dyn_call_illegal_func.
                  mv_text = 'Exception cx_sy_dyn_call_illegal_func caught in method RECOVER_PDF_FORM '(123).
                  APPEND mv_text TO cs_rare_interface-exceptions.
                  collect_mesg( mv_text ).
                  CLEAR mv_text.

                CATCH cx_sy_dyn_call_illegal_type .
                  mv_text = 'Exception cx_sy_dyn_call_illegal_type caught in method RECOVER_PDF_FORM '(124).
                  APPEND mv_text TO cs_rare_interface-exceptions.
                  collect_mesg( mv_text ).
                  CLEAR mv_text.

                CATCH cx_sy_dyn_call_param_missing.
                  mv_text = 'Exception cx_sy_dyn_call_param_missing caught in method RECOVER_PDF_FORM '(125).
                  APPEND mv_text TO cs_rare_interface-exceptions.
                  collect_mesg( mv_text ).
                  CLEAR mv_text.

                CATCH cx_sy_dyn_call_param_not_found.
                  mv_text = 'Exception cx_sy_dyn_call_param_not_found caught in method RECOVER_PDF_FORM '(127).
                  APPEND mv_text TO cs_rare_interface-exceptions.
                  collect_mesg( mv_text ).
                  CLEAR mv_text.

                CATCH cx_sy_dyn_call_error.
                  mv_text = 'Exception cx_sy_dyn_call_error caught in method RECOVER_PDF_FORM '(143).
                  APPEND mv_text TO cs_rare_interface-exceptions.
                  collect_mesg( mv_text ).
                  CLEAR mv_text.

              ENDTRY.

              IF sy-subrc = 0.
                ms_smart_analyzer-adobe_importing = ms_params-parameter.
                ms_smart_analyzer-rare_data       = mv_param_interface.
                ms_smart_analyzer-success         = abap_true.
                APPEND ms_smart_analyzer TO mt_smart_analyzer.
                CLEAR ms_smart_analyzer.
                INSERT ms_ptab INTO TABLE mt_ptab_final.
              ELSE.
                mv_text = 'Issue while rendering pdf with'(144) && ` ` &&  ms_params-parameter && ` = ` && mv_param_interface.
                CONDENSE mv_param_interface.

                "Auto Update Config Table
                UPDATE yztabl_rare_exe SET active = abap_false WHERE interface_element = mv_param_interface.
                IF sy-subrc = 0.
                  CALL FUNCTION 'DB_COMMIT'.
                ENDIF.
                collect_mesg( mv_text ).
                CLEAR mv_text.
              ENDIF.

*Close pdf job
              close_pdf_job( ).
            ENDLOOP.

          ENDIF.

*Restore settings
          cv_outputparams = mv_outputparams.
          IF open_pdf_job( ) = 0.

            CALL METHOD cl_progress_indicator=>progress_indicate
              EXPORTING
                i_text               = 'RECOVERING PDF FORM'
                i_output_immediately = abap_true
                i_processed          = 2
                i_total              = 3.

***Final FM Call
            TRY.
                CALL FUNCTION cv_funcname
                  PARAMETER-TABLE
                  mt_ptab_final
                  EXCEPTION-TABLE
                  mt_etab.

                rv_subrc = sy-subrc.

              CATCH cx_sy_dyn_call_error.
                rv_subrc = 8.
                mv_text = 'Exception cx_sy_dyn_call_error caught in method RECOVER_PDF_FORM '(143).
                APPEND mv_text TO cs_rare_interface-exceptions.
                collect_mesg( mv_text ).
                CLEAR mv_text.
            ENDTRY.


            IF rv_subrc <> 0.

              CASE rv_subrc.
                WHEN 1.
                  mv_text = 'usage_error exception is catched while calling cv_funcname in RECOVER_PDF_FORM '(146).
                  APPEND mv_text TO cs_rare_interface-exceptions.

                WHEN 2.
                  mv_text = 'system_error exception is catched while calling cv_funcname in RECOVER_PDF_FORM '(147).
                  APPEND mv_text TO cs_rare_interface-exceptions.

                WHEN 3.
                  mv_text = 'internal_error  exception is catched while calling cv_funcname in RECOVER_PDF_FORM '(177).
                  APPEND mv_text TO cs_rare_interface-exceptions.

                WHEN 4.
                  mv_text = 'other exception is catched while calling cv_funcname in RECOVER_PDF_FORM '(178).
                  APPEND mv_text TO cs_rare_interface-exceptions.

                WHEN 8.
                  mv_text = 'Exception cx_sy_dyn_call_error caught in method RECOVER_PDF_FORM '(143).
                  APPEND mv_text TO cs_rare_interface-exceptions.

              ENDCASE.
              collect_mesg( mv_text ).
              CLEAR mv_text.
            ENDIF.

*Close pdf job
            close_pdf_job( ).
          ENDIF.

        ENDIF.

      CATCH cx_root INTO mo_oref_root.
        rv_subrc = 8.
        mv_text = mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.
  ENDMETHOD.


  METHOD retry_pdf_form.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Re-try Display PDF form
*&---------------------------------------------------------------------*

    DATA: mo_oref_root TYPE REF TO cx_root,
          mv_text      TYPE string.

    DATA: mv_cprog     TYPE sy-cprog.


    TRY.
*progress bar
        CALL METHOD cl_progress_indicator=>progress_indicate
          EXPORTING
            i_text               = 'Retry PDF form with Optimization'(207)
            i_output_immediately = abap_true
            i_processed          = 1
            i_total              = 4.

*Store Cprog
        mv_cprog = sy-cprog.

*As per the Adobe solution - Update Cprog
        sy-cprog = sy-repid.

*Retry with updated cprog
        IF open_pdf_job( ) = 0.
          rv_subrc = bind_pdf_data( ).
          close_pdf_job( ).
        ENDIF.

*Restore Cprog
        sy-cprog = mv_cprog.

      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.


  ENDMETHOD.


  METHOD save_workitem.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Save Work Item
*&---------------------------------------------------------------------*
*Declaration
    DATA: mo_oref_root TYPE REF TO cx_root,
          mv_text      TYPE string.

    TRY.

        launch_workflow( ).         "Launch Workflow
        sync_workitem( ).           "Sync WorkItemID

      CATCH cx_root INTO mo_oref_root.
        mv_text = mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.


  ENDMETHOD.


  METHOD send_approval_email ##NEEDED.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Method for Sending approval mail
*&---------------------------------------------------------------------*

*Data Declaration

    DATA: mv_tmp_str      TYPE string,
          mt_html         TYPE STANDARD TABLE OF w3html,   "Html
          mt_message_body TYPE  bcsy_text,
          ms_html         LIKE LINE OF mt_html.

    DATA:
      mv_subject       TYPE so_obj_des,
      mo_send_request  TYPE REF TO cl_bcs,
      mo_bcs_exception TYPE REF TO cx_bcs,
      mo_recipient     TYPE REF TO if_recipient_bcs,
      mo_sender        TYPE REF TO cl_sapuser_bcs,
      mo_document      TYPE REF TO cl_document_bcs,
      mt_recipient     LIKE TABLE OF mo_recipient,
      mv_sent_to_all   TYPE os_boolean,
      mr_bcs_exception TYPE REF TO cx_bcs,
      mv_text          TYPE        string.

    DATA: mv_wf_id TYPE swwwihead-wi_id.
    DATA: mv_attachment TYPE xstring.

    CLEAR: mv_wf_id.

    SELECT SINGLE wi_id
      FROM swwwihead
      INTO mv_wf_id
     WHERE wi_type EQ 'F' AND
           wi_text EQ rare_data-rare_inci-guid AND
           wi_stat EQ 'STARTED' AND
           wi_rh_task EQ 'WS90000010'.

    IF sy-subrc EQ 0.

*Prepare Body
      ms_html-line = `<html>`.
      APPEND ms_html TO mt_html.

      ms_html-line = `<body>`.
      APPEND ms_html TO mt_html.

      CONCATENATE `<br/>Dear Approver, `  `&nbsp;`  `<br/><br/><br/>` INTO ms_html-line.
      APPEND ms_html TO mt_html.

      ms_html-line = 'Could you please validate below request from  '(045) &&  rare_data-rare_inci-user_name &&  ' for  ' && rare_data-rare_inci-short_description.
      APPEND ms_html TO mt_html.

      ms_html-line = `<p></p>`.
      APPEND ms_html TO mt_html.

      ms_html-line = `<BR></BR><BR></BR>`.
      APPEND ms_html TO mt_html.

      ms_html-line = `<p> </p>`.
      APPEND ms_html TO mt_html.

      ms_html-line = `<BR>`.
      APPEND ms_html TO mt_html.

      ms_html-line = `<BR>`.
      APPEND ms_html TO mt_html.

      ms_html-line =

      `<a href="http://in-blr-sfs.corp.capgemini.com:50000/sap/bc/gui/sap/its/approval_rare/param1/0001">[[Approve]]</a>`.
      REPLACE 'param1' IN ms_html-line WITH mv_wf_id.
      APPEND ms_html TO mt_html.

      ms_html-line = `    `.
      APPEND ms_html TO mt_html.

      ms_html-line = `<a href="http://in-blr-sfs.corp.capgemini.com:50000/sap/bc/gui/sap/its/approval_rare/param1/0002">[[Reject]]</a>`.
      REPLACE 'param1' IN ms_html-line WITH mv_wf_id.
      APPEND ms_html TO mt_html.
      CLEAR : ms_html.

      ms_html-line = `<BR>`.
      APPEND ms_html TO mt_html.

*Prepare End
      ms_html-line = '<br/><br/>Best&nbsp;regards.<br/>'(047).
      APPEND ms_html TO mt_html.

      ms_html-line = 'Capgemini Smart Team<br/>'(046).
      APPEND ms_html TO mt_html.

      ms_html = `</body>`.
      APPEND ms_html TO mt_html.

      ms_html = `</html>`.
      APPEND ms_html TO mt_html.

      TRY.
*Create send request
          mo_send_request = cl_bcs=>create_persistent( ).

*Subject Line
          mv_subject = 'Approval For '(048) &&  rare_data-rare_inci-short_description && ` REFNO: ` && rare_data-rare_inci-guid.


*Email Body
          mt_message_body[] = mt_html[].
          mo_document = cl_document_bcs=>create_document(
          i_type    = 'HTM'
          i_text    = mt_message_body
          i_subject = mv_subject ).

*  add attachment
          DATA: mv_attach_name    TYPE sood-objdes,
                mv_attach_content TYPE solix_tab,
                mv_size           TYPE so_obj_len.

          mv_attach_name = 'Incident_info'.
          mv_attachment =  rare_data-xstring-pdf.

*   get PDF xstring and convert it to BCS format
          mv_size = xstrlen( mv_attachment ).

          mv_attach_content = cl_document_bcs=>xstring_to_solix(
          ip_xstring = mv_attachment ).

          mo_document->add_attachment(
          i_attachment_type    = 'pdf'                      "#EC NOTEXT
          i_attachment_subject = mv_attach_name             "#EC NOTEXT
          i_attachment_size    = mv_size
          i_att_content_hex    = mv_attach_content ).


*Add Document To Send Request
          CALL METHOD mo_send_request->set_document( mo_document ).

*Email From...
          mo_sender = cl_sapuser_bcs=>create( 'WF-BATCH' ).


*Add Sender To Send Request
          CALL METHOD mo_send_request->set_sender
            EXPORTING
              i_sender = mo_sender.

*Email To...
          mo_recipient = cl_cam_address_bcs=>create_internet_address( 'rahul.bhayani@capgemini.com' ).

*Add recipient to send request
          CALL METHOD mo_send_request->add_recipient
            EXPORTING
              i_recipient = mo_recipient
              i_express   = 'X'.

          CALL METHOD mo_send_request->set_status_attributes
            EXPORTING
              i_requested_status = 'E'
              i_status_mail      = 'E'.

          CALL METHOD mo_send_request->enqueue.

*Send Document
          CALL METHOD mo_send_request->send(
            EXPORTING
              i_with_error_screen = 'X'
            RECEIVING
              result              = mv_sent_to_all ).

          CASE mv_sent_to_all.
            WHEN 'X'.

              CALL FUNCTION 'DB_COMMIT'.
              SUBMIT rsconn01 WITH mode = 'INT' AND RETURN.


            WHEN OTHERS.
              CALL FUNCTION 'DB_ROLLBACK'.


          ENDCASE.
        CATCH cx_bcs INTO mr_bcs_exception.
          MESSAGE e445(so) INTO mv_text.
          APPEND mv_text TO cs_rare_interface-exceptions.
      ENDTRY.
    ENDIF.


  ENDMETHOD.


  METHOD send_email_with_attachment ##NEEDED.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Send email with attachment
*&---------------------------------------------------------------------*

*Send an Email to SNOW
*    DATA:
*      mv_subject     TYPE so_obj_des,
*      mv_email_to    TYPE adr6-smtp_addr ##NEEDED,
*      mv_text        TYPE soli,
*      mv_type_raw    TYPE so_obj_tp,
*      mv_att_type    TYPE soodk-objtp,
*      mv_att_subject TYPE sood-objdes.
*
*    DATA:
*      mt_text           TYPE soli_tab, " Table which contains email body text
*      mt_attachment_hex TYPE solix_tab, " Table which contains the attached file
*      mv_sent_to_all    TYPE os_boolean, " Receive the information if email was sent
*      mv_error_message  TYPE string, " Used to get the error message
*      mo_send_request   TYPE REF TO cl_bcs, " Email object
*      mo_recipient      TYPE REF TO if_recipient_bcs, " Who will receive the email
*      mo_sender         TYPE REF TO cl_sapuser_bcs, " Who is sending the email
*      mo_document       TYPE REF TO cl_document_bcs, " Email body
*      mx_bcs_exception  TYPE REF TO cx_bcs,
*      mv_sysid          TYPE sy-sysid.
*
*    DATA: mv_attachment TYPE xstring,
*          mv_size       TYPE so_obj_len.


*    TRY.
*
*        CALL METHOD cl_progress_indicator=>progress_indicate
*          EXPORTING
*            i_text               = 'Sending an Email With Attachment to Support Team'(178)
*            i_output_immediately = abap_true
*            i_processed          = 2
*            i_total              = 3.
*
*
*        CALL FUNCTION 'TR_SYS_PARAMS'
*          IMPORTING
*            systemname    = mv_sysid
*          EXCEPTIONS
*            no_systemname = 1
*            no_systemtype = 2
*            OTHERS        = 3.
*
*        IF sy-subrc <> 0.
*          CASE sy-subrc.
*            WHEN 1.
*              mv_text = 'no_systemname exception is catched while calling TR_SYS_PARAMS in SEND_EMAIL_WITH_ATTACHMENT.'.
*              APPEND mv_text TO cs_rare_interface-exceptions.
*              CLEAR mv_text.
*            WHEN 2.
*              mv_text = 'no_systemtype exception is catched while calling TR_SYS_PARAMS in SEND_EMAIL_WITH_ATTACHMENT.'.
*              APPEND mv_text TO cs_rare_interface-exceptions.
*              CLEAR mv_text.
*            WHEN 3.
*              mv_text = 'Others exception is catched while calling TR_SYS_PARAMS in SEND_EMAIL_WITH_ATTACHMENT.'.
*              APPEND mv_text TO cs_rare_interface-exceptions.
*              CLEAR mv_text.
*          ENDCASE.
*
*        ELSE.
*          IF mv_sysid       = 'SFS'.
*            mv_email_to     =  'nyFrstarsndev@service-now.com'(144). " Valid email
*          ELSEIF mv_sysid   = 'NYQ'.
*            mv_email_to     =  'nyrstarsnquality@service-now.com'. " Valid email
*          ELSEIF mv_sysid   = 'NYP'.
*            mv_email_to     =  'nyrstarsnprod@service-now.com'. " Valid email
*          ENDIF.
*
*        ENDIF.
*
*        mv_email_to    =   'nyrstarsndev@service-now.com'(144). " Valid email
*        mv_text        =   'Automated Mail From RaRe Tool to attach Incident in ServiceNow'(146). " Text used into the email body
*        mv_type_raw    =   'RAW'. " Email type
*        mv_att_type    =   'PDF'. " Attachment type
*        mv_att_subject =   'Incident_info'(147). " Attachment title
*
*        "Create send request
*        mo_send_request = cl_bcs=>create_persistent( ).
*
*        "Email FROM...
*        mo_sender = cl_sapuser_bcs=>create( sy-uname ).
*
*        "Add sender to send request
*        mo_send_request->set_sender( i_sender = mo_sender ).
*
*        "Email TO...
*        mo_recipient = cl_cam_address_bcs=>create_internet_address( mv_email_to ).
*
*        "Add recipient to send request
*        mo_send_request->add_recipient(
*        EXPORTING
*          i_recipient = mo_recipient
*          i_express   = abap_true
*          ).
*
*        mv_subject = `RE:` && subject.
*
*        "Email BODY
*        APPEND mv_text TO mt_text.
*        mo_document = cl_document_bcs=>create_document(
*                                      i_type    = mv_type_raw
*                                      i_text    = mt_text
*                                      i_length  = '12'
*                                      i_subject = mv_subject ).
*
*
*        "You should populate the table gt_attachment_hex
*        "with the binary data from your file!
*        "For example: gt_attachment_hex = binary_data_from_file.
*        mv_attachment = cs_rare_interface-xstring-pdf.
*
*        "get PDF xstring and convert it to BCS format
*        mv_size = xstrlen( mv_attachment ).
*
*        mt_attachment_hex = cl_document_bcs=>xstring_to_solix( ip_xstring = mv_attachment ).
*
**      "Attachment
*        mo_document->add_attachment(
*        EXPORTING
*          i_attachment_type    = mv_att_type
*          i_attachment_subject = mv_att_subject
*          i_attachment_size    = mv_size
*          i_att_content_hex    = mt_attachment_hex
*          ).
*
*        "Add document to send request
*        mo_send_request->set_document( mo_document ).
*
*        "Send email and get the result
*        mv_sent_to_all = mo_send_request->send( i_with_error_screen = abap_true ).
*        IF mv_sent_to_all = abap_true.
*          WRITE 'Email sent!'(001).
*          CALL METHOD cl_progress_indicator=>progress_indicate
*            EXPORTING
*              i_text               = 'Email Successfully Sent'(179)
*              i_output_immediately = abap_true
*              i_processed          = 3
*              i_total              = 3.
*        ENDIF.
*
*        "Commit to send email
*        COMMIT WORK.
*
*        "Exception handling
*      CATCH cx_bcs INTO mx_bcs_exception.
*        mv_error_message = mx_bcs_exception->get_text( ).
*        WRITE mv_error_message.
*        APPEND mv_error_message TO cs_rare_interface-exceptions.
*        collect_mesg( mv_error_message ).
*        CLEAR mv_text.
*
*    ENDTRY.

  ENDMETHOD.


  METHOD send_exceptions.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Send exceptions through mail
*&---------------------------------------------------------------------*
    DATA :
      mo_oref_root      TYPE REF TO cx_root            ##NEEDED,
      mv_text           TYPE string,
      mv_string         TYPE string,                   "declare string
      mv_data_string    TYPE string,                   "declare string
      mv_xstring        TYPE xstring ,                 "Convert string data into xstring using function module HR_KR_STRING_TO_XSTRING.
      mt_binary_content TYPE solix_tab,                "Convert xstring data to binary data using function module SCMS_XSTRING_TO_BINARY .
      mr_send_request   TYPE REF TO cl_bcs,            "Send request
      mt_body           TYPE bcsy_text,                "Mail body
      mr_document       TYPE REF TO cl_document_bcs,   "Mail body
      mv_sender         TYPE REF TO if_sender_bcs,     "Sender address
      ms_recipient      TYPE REF TO if_recipient_bcs,  "Recipient
      mt_recipient      LIKE TABLE OF ms_recipient,    "Recipient
      mv_email          TYPE ad_smtpadr,               "Email ID
      mv_extension      TYPE soodk-objtp VALUE 'XLS',  "TXT format
      mv_sent_to_all    TYPE os_boolean,
      mr_bcs_exception  TYPE REF TO cx_bcs              ##NEEDED,
      mv_subject        TYPE so_obj_des,
      ms_exceptions     LIKE LINE OF cs_rare_interface-exceptions,
      ms_rare_swch      TYPE yztabl_rare_swch.

    TRY .

        "Get email address from switch table
        SORT ct_rare_swch .
        READ TABLE ct_rare_swch INTO      ms_rare_swch
                                WITH KEY  obj_name  = 'SEND_EXCEPTIONS'
                                          task_name = 'EMAIL_ADDRESS_DETERMINATION'
                                          vakey1    = 'EMAIL_ID'
                                          vadata1   = 'ON'
                                          active    = abap_true
                                          BINARY SEARCH
                                          TRANSPORTING comments.

        IF  sy-subrc = 0 AND ms_rare_swch-comments IS NOT INITIAL .

          TRANSLATE ms_rare_swch-comments TO LOWER CASE.
          mv_email = ms_rare_swch-comments.

          IF it_exceptions IS NOT INITIAL.
            cs_rare_interface-exceptions[] = it_exceptions[].
          ENDIF.

          IF cs_rare_interface-exceptions IS NOT INITIAL.

            LOOP AT cs_rare_interface-exceptions INTO  ms_exceptions.

              AT FIRST.
                mv_data_string =  'CAUGHT EXCEPTIONS'.
              ENDAT.

              mv_string =  ms_exceptions.
              CONCATENATE mv_data_string mv_string INTO mv_data_string SEPARATED BY cl_abap_char_utilities=>newline.
              CLEAR: mv_string.
            ENDLOOP.

            CALL FUNCTION 'SCMS_STRING_TO_XSTRING'
              EXPORTING
                text   = mv_data_string
              IMPORTING
                buffer = mv_xstring
              EXCEPTIONS
                failed = 1
                OTHERS = 2.

            IF sy-subrc <> 0.
* Implement suitable error handling here
            ENDIF.


***Xstring to binary
            CALL FUNCTION 'SCMS_XSTRING_TO_BINARY'
              EXPORTING
                buffer     = mv_xstring
              TABLES
                binary_tab = mt_binary_content.

            APPEND 'Hi, '(059)                                                                      TO mt_body.
            APPEND '                                              '                                 TO mt_body.
            APPEND 'Please find the attach sheet for caught exceptions while executing RaRe. '(058) TO mt_body.
            APPEND '                                              '                                 TO mt_body.
            APPEND '                                          '                                     TO mt_body.
            APPEND 'Regards, '(057)                                                                 TO mt_body.
            APPEND 'SAP Automation Team'(056)                                                       TO mt_body.

*          CONCATENATE 'Nyrstar RaRe execution for tcode'(055) cv_tcode  INTO mv_subject SEPARATED BY space.
            mv_subject = 'Nyrstar '(219) && sy-sysid && sy-mandt && ' RaRe execution for tcode '(220) && cv_tcode.
*  creates persistent send request
            mr_send_request = cl_bcs=>create_persistent( ).

*  craete document for mail body
            mr_document = cl_document_bcs=>create_document(
                           i_type    = 'RAW'
                           i_text    = mt_body
                           i_subject = mv_subject ).

*  add attchment
            CALL METHOD mr_document->add_attachment
              EXPORTING
                i_attachment_type    = mv_extension    "XLS
                i_attachment_subject = mv_subject
                i_att_content_hex    = mt_binary_content.

*add the document to send request
            CALL METHOD mr_send_request->set_document( mr_document ).

*  sender addess
            mv_sender = cl_sapuser_bcs=>create( 'WF-BATCH' ).
            CALL METHOD mr_send_request->set_sender
              EXPORTING
                i_sender = mv_sender.

            ms_recipient = cl_cam_address_bcs=>create_internet_address( mv_email ).
            APPEND ms_recipient TO mt_recipient.

**To Add Multiple IDs in 'TO'
            LOOP AT mt_recipient INTO ms_recipient.
*Add recipient to send request
              CALL METHOD mr_send_request->add_recipient
                EXPORTING
                  i_recipient = ms_recipient
                  i_express   = 'X'.

            ENDLOOP.

*  trigger e-mail immediately
            mr_send_request->set_send_immediately( 'X' ).

*  send mail
            CALL METHOD mr_send_request->send(
              EXPORTING
                i_with_error_screen = 'X'
              RECEIVING
                result              = mv_sent_to_all ).

            CASE mv_sent_to_all.
              WHEN 'X'.
                CALL FUNCTION 'DB_COMMIT'.
              WHEN OTHERS.
                CALL FUNCTION 'DB_ROLLBACK'.
            ENDCASE.
          ENDIF.

        ELSE."No email address maintained
          mv_text =  'No  email address maintained'.
          APPEND mv_text TO cs_rare_interface-exceptions.
          CLEAR mv_text.
        ENDIF.

        "Exception handling
      CATCH cx_bcs INTO mr_bcs_exception.
        mv_text =  mr_bcs_exception->get_text( ).
        WRITE : mv_text.
*        MESSAGE mv_text TYPE 'I'.
        collect_mesg( mv_text ).
        CLEAR mv_text.

      CATCH cx_root INTO mo_oref_root.
        mv_text =  mo_oref_root->get_text( ).
        WRITE : mv_text.
*        MESSAGE mv_text TYPE 'I'.
        collect_mesg( mv_text ).
        CLEAR mv_text.

    ENDTRY.
  ENDMETHOD.


  METHOD send_rare_attachment.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Send email with attachment
*&---------------------------------------------------------------------*

*Send an Email to SNOW
    DATA:
      mo_oref_root   TYPE REF TO cx_root            ##NEEDED,
      mv_text        TYPE string,
      mv_subject     TYPE so_obj_des,
      mv_email_to    TYPE adr6-smtp_addr ##NEEDED,
      mv_type_raw    TYPE so_obj_tp,
      mv_att_type    TYPE soodk-objtp,
      mv_att_subject TYPE sood-objdes.

    DATA:
      mt_text           TYPE soli_tab, " Table which contains email body text
      mt_attachment_hex TYPE solix_tab, " Table which contains the attached file
      mv_sent_to_all    TYPE os_boolean, " Receive the information if email was sent
      mv_error_message  TYPE string, " Used to get the error message
      mo_send_request   TYPE REF TO cl_bcs, " Email object
      mo_recipient      TYPE REF TO if_recipient_bcs, " Who will receive the email
      mo_sender         TYPE REF TO cl_sapuser_bcs, " Who is sending the email
      mo_document       TYPE REF TO cl_document_bcs, " Email body
      mx_bcs_exception  TYPE REF TO cx_bcs,
      mv_sysid          TYPE sy-sysid.

    DATA: mv_attachment TYPE xstring,
          mv_size       TYPE so_obj_len,
          mv_return     TYPE char01,
          mt_fields     TYPE STANDARD TABLE OF sval,
          ms_fields     TYPE                   sval.


    TRY.

        IF cs_rare_interface-rare_inci-command = 'EMA' OR is_rare_inci-command = 'EMA'.

          "Check switch table if email funtionality in ON/OFF
          SORT ct_rare_swch .
          READ TABLE ct_rare_swch TRANSPORTING NO FIELDS WITH KEY  obj_name  = 'SEND_RARE_ATTACHMENT'
                                                                   task_name = 'EMAIL_FUNCTIONALITY_DETERMINATION'
                                                                   vakey1    = 'EMAIL_BUTTON'
                                                                   vadata1   = 'ON'
                                                                   active    = abap_true
                                                                   BINARY SEARCH.

          IF sy-subrc = 0.

            "Email functionality starts with popup for email address
            IF  cs_rare_interface-xstring IS INITIAL .
              get_pdf_form( is_rare_inci = is_rare_inci ) .
            ENDIF.



            CLEAR : ms_fields.
            REFRESH : mt_fields.

            ms_fields-tabname = 'ADR6'.
            ms_fields-fieldname = 'SMTP_ADDR'.
            ms_fields-field_obl = abap_true.
            APPEND ms_fields TO mt_fields.

            CALL FUNCTION 'POPUP_GET_VALUES'
              EXPORTING
                popup_title     = 'Please provide Email Address'(221)
                start_column    = '5'
                start_row       = '5'
              IMPORTING
                returncode      = mv_return
              TABLES
                fields          = mt_fields
              EXCEPTIONS
                error_in_fields = 1
                OTHERS          = 2.

            IF mv_return <> 'A'.

              READ TABLE mt_fields INTO ms_fields INDEX 1.
              "Hanlding of email address
              "If command is Enter - email address form SU01
              "If command is Mail  - email address is enterd on popup
              IF sy-subrc = 0. .
                mv_email_to    =   ms_fields-value.
              ELSE.
                MESSAGE 'Error Occurred while reading  mail id'(222) TYPE 'S' DISPLAY LIKE 'E'.
              ENDIF.
            ELSE.
              MESSAGE 'Action Cancelled by user'(223) TYPE 'S' .
            ENDIF.
          ELSE.
            mv_error_message =  'Email functionality OFF'.
            MESSAGE mv_error_message TYPE 'I'.
            APPEND mv_error_message TO cs_rare_interface-exceptions.
            collect_mesg( mv_error_message ).
            CLEAR mv_text.
          ENDIF. "  email functionality OFF
        ENDIF. "No email button pressed

        IF cs_rare_interface-rare_inci-command = 'ENT'.

          SORT ct_rare_swch .
          READ TABLE ct_rare_swch TRANSPORTING NO FIELDS WITH KEY obj_name  = 'SEND_RARE_ATTACHMENT'
                                                                  task_name = 'EMAIL_FUNCTIONALITY_DETERMINATION'
                                                                  vakey1    = 'CREATE_INCIDENT'
                                                                  vadata1   = 'ON'
                                                                  active    = abap_true
                                                                  BINARY SEARCH.
          IF sy-subrc = 0 .

            IF mv_email_to IS INITIAL.
              mv_email_to    = cs_rare_interface-userinfo-email.
            ENDIF.
          ELSE.
            mv_error_message =  'No mail sent to user as email functionality OFF'.
            MESSAGE mv_error_message TYPE 'I'.
            APPEND mv_error_message TO cs_rare_interface-exceptions.
            collect_mesg( mv_error_message ).
            CLEAR mv_text.
          ENDIF.
        ENDIF."No create incident button pressed

        IF   mv_email_to IS NOT INITIAL.

          CALL METHOD cl_progress_indicator=>progress_indicate
            EXPORTING
              i_text               = 'Sending Mail with Attachment'(214)
              i_output_immediately = abap_true
              i_processed          = 2
              i_total              = 3.


          mv_text        =   'Automated Mail From RaRe Tool'(224). " Text used into the email body
          mv_type_raw    =   'RAW'. " Email type
          mv_att_type    =   'PDF'. " Attachment type
          mv_att_subject =   'Incident_info'(208). " Attachment title

          "Create send request
          mo_send_request = cl_bcs=>create_persistent( ).

          "Email FROM...
          mo_sender = cl_sapuser_bcs=>create( sy-uname ).

          "Add sender to send request
          mo_send_request->set_sender( i_sender = mo_sender ).

          "Email TO...
          mo_recipient = cl_cam_address_bcs=>create_internet_address( mv_email_to ).

          "Add recipient to send request
          mo_send_request->add_recipient(
          EXPORTING
            i_recipient = mo_recipient
            i_express   = abap_true
            ).

          "Email BODY
          APPEND mv_text TO mt_text.
          mo_document = cl_document_bcs=>create_document(
                                        i_type    = mv_type_raw
                                        i_text    = mt_text
*                                        i_length  = '12'
                                        i_subject = 'RaRe Incident Info'(225) ).


          "You should populate the table gt_attachment_hex
          "with the binary data from your file!
          "For example: gt_attachment_hex = binary_data_from_file.
          mv_attachment = cs_rare_interface-xstring-pdf.

          "get PDF xstring and convert it to BCS format
          mv_size = xstrlen( mv_attachment ).

          mt_attachment_hex = cl_document_bcs=>xstring_to_solix( ip_xstring = mv_attachment ).

*      "Attachment
          mo_document->add_attachment(
          EXPORTING
            i_attachment_type    = mv_att_type
            i_attachment_subject = mv_att_subject
            i_attachment_size    = mv_size
            i_att_content_hex    = mt_attachment_hex
            ).

          "Add document to send request
          mo_send_request->set_document( mo_document ).

          "Send email and get the result
          mv_sent_to_all = mo_send_request->send( i_with_error_screen = abap_true ).


*            WRITE 'Email sent!'(001).
          CASE mv_sent_to_all.
            WHEN 'X'.
              CALL FUNCTION 'DB_COMMIT'.
              MESSAGE i047(yz_msag_rare) WITH  mv_email_to.
              CALL METHOD cl_progress_indicator=>progress_indicate
                EXPORTING
                  i_text               = 'Email Successfully Sent'(227)
                  i_output_immediately = abap_true
                  i_processed          = 3
                  i_total              = 3.

            WHEN OTHERS.
              CALL FUNCTION 'DB_ROLLBACK'.
          ENDCASE.
        ENDIF.

        "Exception handling
      CATCH cx_bcs INTO mx_bcs_exception.
        mv_error_message = mx_bcs_exception->get_text( ).
        WRITE mv_error_message.
        APPEND mv_error_message TO cs_rare_interface-exceptions.
        collect_mesg( mv_error_message ).
        CLEAR mv_text.

      CATCH cx_root INTO mo_oref_root.
        mv_text =  mo_oref_root->get_text( ).
        WRITE : mv_text.
*        MESSAGE mv_text TYPE 'I'.
        collect_mesg( mv_text ).
        CLEAR mv_text.

    ENDTRY.

  ENDMETHOD.


  METHOD send_rejection_email ##NEEDED.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Method for Sending rejection mail
*&---------------------------------------------------------------------*

*Data Declaration

    DATA: mv_tmp_str      TYPE string,
          mt_html         TYPE STANDARD TABLE OF w3html,   "Html
          mt_message_body TYPE  bcsy_text,
          ms_html         LIKE LINE OF mt_html.

    DATA: mv_conlength     TYPE i,
          mv_conlengths    TYPE so_obj_len,
          mr_bcs_exception TYPE REF TO cx_bcs,
          mv_text          TYPE        string.

    DATA:
      mv_subject       TYPE so_obj_des,
      mo_send_request  TYPE REF TO cl_bcs,
      mo_bcs_exception TYPE REF TO cx_bcs,
      mo_recipient     TYPE REF TO if_recipient_bcs,
      mo_sender        TYPE REF TO cl_sapuser_bcs,
      mo_document      TYPE REF TO cl_document_bcs,
      mt_recipient     LIKE TABLE OF mo_recipient,
      mv_sent_to_all   TYPE os_boolean.

*Prepare Body
    ms_html-line = `<html>`.
    APPEND ms_html TO mt_html.

    ms_html-line = `<body>`.
    APPEND ms_html TO mt_html.

    CONCATENATE `<br/>Dear Requester, `  `&nbsp;`  `<br/><br/><br/>` INTO ms_html-line.
    APPEND ms_html TO mt_html.


    ms_html-line = 'Request for ticket creation of '(049) && iv_key && 'is rejected'(073) .
    APPEND ms_html TO mt_html.

    ms_html-line = 'Please contact rahul.bhayani@capgemini.com for further details'(050).
    APPEND ms_html TO mt_html.


    ms_html-line = `<p></p>`.
    APPEND ms_html TO mt_html.

    ms_html-line = `<BR></BR><BR></BR>`.
    APPEND ms_html TO mt_html.

    ms_html-line = `<p> </p>`.
    APPEND ms_html TO mt_html.

    ms_html-line = `<BR>`.
    APPEND ms_html TO mt_html.

    ms_html-line = `<BR>`.
    APPEND ms_html TO mt_html.

    ms_html-line = `<BR>`.
    APPEND ms_html TO mt_html.

*Prepare End
    ms_html-line = `<br/><br/>Best&nbsp;regards.<br/>`.
    APPEND ms_html TO mt_html.

    ms_html-line = 'Capgemini Smart Team<br/>'(046).
    APPEND ms_html TO mt_html.

    ms_html = `</body>`.
    APPEND ms_html TO mt_html.

    ms_html = `</html>`.
    APPEND ms_html TO mt_html.

    mv_conlength = strlen( mv_tmp_str ) + 10000 .
    mv_conlengths = mv_conlength .
    TRY.

*Create send request
        mo_send_request = cl_bcs=>create_persistent( ).

*Subject Line
        mv_subject = 'Ticket creation request for '(051) && iv_key && ' is rejected'(052).

*Email Body
        mt_message_body[] = mt_html[].
        mo_document = cl_document_bcs=>create_document(
        i_type    = 'HTM'
        i_text    = mt_message_body
        i_subject = mv_subject ).

*Add Document To Send Request
        CALL METHOD mo_send_request->set_document( mo_document ).

*Email From...
        mo_sender = cl_sapuser_bcs=>create( 'WF-BATCH' ).

*Add Sender To Send Request
        CALL METHOD mo_send_request->set_sender
          EXPORTING
            i_sender = mo_sender.

*Email To...
        mo_recipient = cl_cam_address_bcs=>create_internet_address( 'akshay.gosavi@capgemini.com' ).

*Add recipient to send request
        CALL METHOD mo_send_request->add_recipient
          EXPORTING
            i_recipient = mo_recipient
            i_express   = 'X'.

        CALL METHOD mo_send_request->set_status_attributes
          EXPORTING
            i_requested_status = 'E'
            i_status_mail      = 'E'.

        CALL METHOD mo_send_request->enqueue.

*Send Document
        CALL METHOD mo_send_request->send(
          EXPORTING
            i_with_error_screen = 'X'
          RECEIVING
            result              = mv_sent_to_all ).

        CASE mv_sent_to_all.
          WHEN 'X'.
            CALL FUNCTION 'DB_COMMIT'.
            SUBMIT rsconn01 WITH mode = 'INT' AND RETURN.

          WHEN OTHERS.
            CALL FUNCTION 'DB_ROLLBACK'.

        ENDCASE.
      CATCH cx_bcs INTO mr_bcs_exception.
        MESSAGE e445(so) INTO mv_text.
        APPEND mv_text TO cs_rare_interface-exceptions.
    ENDTRY.

    ev_rej_email_sent = mv_sent_to_all.


  ENDMETHOD.


  METHOD send_ticket_number ##NEEDED.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Method for Sending mail with incident number/ticket number
*&---------------------------------------------------------------------*

*Data Declaration

*    DATA: mv_tmp_str      TYPE string,
*
*          mt_html         TYPE STANDARD TABLE OF w3html,   "Html
*          mt_message_body TYPE  bcsy_text,
*          ms_html         LIKE LINE OF mt_html.
*
*    DATA: mv_conlength  TYPE i,
*          mv_conlengths TYPE so_obj_len.
*
*    DATA:
*      mv_subject       TYPE so_obj_des,
*      mo_send_request  TYPE REF TO cl_bcs,
*      mo_recipient     TYPE REF TO if_recipient_bcs,
*      mo_sender        TYPE REF TO cl_sapuser_bcs,
*      mo_document      TYPE REF TO cl_document_bcs,
*      mv_sent_to_all   TYPE os_boolean,
*      mr_bcs_exception TYPE REF TO cx_bcs,
*      mv_text          TYPE        string.
*
**Prepare Body
*    ms_html-line = `<html>`.
*    APPEND ms_html TO mt_html.
*
*    ms_html-line = `<body>`.
*    APPEND ms_html TO mt_html.
*
*    CONCATENATE `<br/>Dear Requester, `  `&nbsp;`  `<br/><br/><br/>` INTO ms_html-line.
*    APPEND ms_html TO mt_html.
*
*    ms_html-line = 'Ticket '(054) && is_ticket-number && ' is successfully created for request number'(053) &&  iv_key.
*    APPEND ms_html TO mt_html.
*
*    ms_html-line = `<p></p>`.
*    APPEND ms_html TO mt_html.
*
*    ms_html-line = `<BR></BR><BR></BR>`.
*    APPEND ms_html TO mt_html.
*
*    ms_html-line = `<p> </p>`.
*    APPEND ms_html TO mt_html.
*
*    ms_html-line = `<BR>`.
*    APPEND ms_html TO mt_html.
*
*    ms_html-line = `<BR>`.
*    APPEND ms_html TO mt_html.
*
*
*    ms_html-line = `<BR>`.
*    APPEND ms_html TO mt_html.
*
**Prepare End
*    ms_html-line = '<br/><br/>Best&nbsp;regards.<br/>'(047).
*    APPEND ms_html TO mt_html.
*
*    ms_html-line = 'Capgemini Smart Team<br/>'(046).
*    APPEND ms_html TO mt_html.
*
*    ms_html = `</body>`.
*    APPEND ms_html TO mt_html.
*
*    ms_html = `</html>`.
*    APPEND ms_html TO mt_html.
*
*    mv_conlength = strlen( mv_tmp_str ) + 10000 .
*    mv_conlengths = mv_conlength .
*    TRY.
**Create send request
*        mo_send_request = cl_bcs=>create_persistent( ).
*
**Subject Line
*        mv_subject = 'Ticket '(054) && is_ticket-number && ' created successfully.'(072).
*
**Email Body
*        mt_message_body[] = mt_html[].
*        mo_document = cl_document_bcs=>create_document(
*        i_type    = 'HTM'
*        i_text    = mt_message_body
*        i_subject = mv_subject ).
*
*
*
**Add Document To Send Request
*        CALL METHOD mo_send_request->set_document( mo_document ).
*
**Email From...
*        mo_sender = cl_sapuser_bcs=>create( 'WF-BATCH' ).
*
**Add Sender To Send Request
*        CALL METHOD mo_send_request->set_sender
*          EXPORTING
*            i_sender = mo_sender.
*
**Email To...
*        mo_recipient = cl_cam_address_bcs=>create_internet_address( 'vidhi.kamdar@capgemini.com' ).
*
**Add recipient to send request
*        CALL METHOD mo_send_request->add_recipient
*          EXPORTING
*            i_recipient = mo_recipient
*            i_express   = 'X'.
*
*        CALL METHOD mo_send_request->set_status_attributes
*          EXPORTING
*            i_requested_status = 'E'
*            i_status_mail      = 'E'.
*
*        CALL METHOD mo_send_request->enqueue.
*
**Send Document
*        CALL METHOD mo_send_request->send(
*          EXPORTING
*            i_with_error_screen = 'X'
*          RECEIVING
*            result              = mv_sent_to_all ).
*
*        CASE mv_sent_to_all.
*          WHEN 'X'.
*
*            CALL FUNCTION 'DB_COMMIT'.
*            SUBMIT rsconn01 WITH mode = 'INT' AND RETURN.
*
*          WHEN OTHERS.
*            CALL FUNCTION 'DB_ROLLBACK'.
*
*        ENDCASE.
*      CATCH cx_bcs INTO mr_bcs_exception.
*        mv_text = mr_bcs_exception->get_text( ).
*        APPEND mv_text TO cs_rare_interface-exceptions.
*    ENDTRY.
*
*    ev_success = mv_sent_to_all.

  ENDMETHOD.


  METHOD set_container_data.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Get Container data
*&---------------------------------------------------------------------*

    DATA:
      mr_wi_handle TYPE REF TO if_swf_run_wim_internal,
      mr_cnt       TYPE REF TO if_swf_cnt_container,
      ms_data      TYPE yztabl_rare_interface.

    DATA :
      mo_oref      TYPE REF TO cx_root,
      mv_text      TYPE string.


    DATA:
      mo_workitm_cntxt    TYPE REF TO cl_swf_run_workitem_context,
      mo_wi_conv          TYPE REF TO if_swf_cnt_conversion,
      mo_wi_cnt           TYPE REF TO cl_swf_cnt_container,
      mif_wi_cnt          TYPE REF TO if_swf_ifs_parameter_container,
      mo_exception_return TYPE REF TO cx_swf_cnt_container.

***--- Get work Item Context
    TRY.
        TRY.

            CALL METHOD cl_swf_run_workitem_context=>get_instance
              EXPORTING
                im_wiid     = iv_wi_id
              RECEIVING
                re_instance = mo_workitm_cntxt.

          CATCH cx_swf_run_wim INTO mo_oref.
            mv_text = mo_oref->get_text( ).

        ENDTRY.

***--- Get Instance of the work Item Container

        CALL METHOD mo_workitm_cntxt->if_wapi_workitem_context~get_wi_container
          RECEIVING
            re_container = mif_wi_cnt.

***--- Type casting work item container into class CL_SWF_CNT_CONTAINRER

        mo_wi_cnt ?= mif_wi_cnt.

***-- Set the value

        TRY.

            mo_wi_cnt->if_swf_cnt_element_access_1~element_set_value( name =  'KEY' value = cs_rare_interface-rare_inci-guid ).

          CATCH cx_swf_cnt_cont_access_denied.    " Change Access to Container Not Allowed

          CATCH cx_swf_cnt_elem_not_found.    " Element Not Found

          CATCH cx_swf_cnt_elem_access_denied.    " Element Must Not Be Changed

          CATCH cx_swf_cnt_elem_type_conflict.    " Type Conflict Between Value and Current Parameter

          CATCH cx_swf_cnt_unit_type_conflict.    " Type Conflict Between Unit and Current Parameter

          CATCH cx_swf_cnt_elem_def_invalid.    " Element Definition (For Example, Type Name) Is Invalid

          CATCH cx_swf_cnt_invalid_qname.    " Qualified Name Invalid/Already Being Used

          CATCH cx_swf_cnt_container.    " Exception in the Container Service

        ENDTRY.

        IF co_rare_base IS NOT BOUND.
          CREATE OBJECT co_rare_base.
        ENDIF.
        co_rare_base->cs_rare_interface = cs_rare_interface.

        TRY.

            mo_wi_cnt->if_swf_cnt_element_access_1~element_set_value( name =  'RARE_OBJECT' value = co_rare_base ).

          CATCH cx_swf_cnt_cont_access_denied.    " Change Access to Container Not Allowed

          CATCH cx_swf_cnt_elem_not_found.    " Element Not Found

          CATCH cx_swf_cnt_elem_access_denied.    " Element Must Not Be Changed

          CATCH cx_swf_cnt_elem_type_conflict.    " Type Conflict Between Value and Current Parameter

          CATCH cx_swf_cnt_unit_type_conflict.    " Type Conflict Between Unit and Current Parameter

          CATCH cx_swf_cnt_elem_def_invalid.    " Element Definition (For Example, Type Name) Is Invalid

          CATCH cx_swf_cnt_invalid_qname.    " Qualified Name Invalid/Already Being Used

          CATCH cx_swf_cnt_container.    " Exception in the Container Service

        ENDTRY.


        TRY.

            mo_wi_cnt->if_swf_cnt_element_access_1~element_set_value( name =  'RARE_DATA' value = cs_rare_interface ).

          CATCH cx_swf_cnt_cont_access_denied.    " Change Access to Container Not Allowed

          CATCH cx_swf_cnt_elem_not_found.    " Element Not Found

          CATCH cx_swf_cnt_elem_access_denied.    " Element Must Not Be Changed

          CATCH cx_swf_cnt_elem_type_conflict.    " Type Conflict Between Value and Current Parameter

          CATCH cx_swf_cnt_unit_type_conflict.    " Type Conflict Between Unit and Current Parameter

          CATCH cx_swf_cnt_elem_def_invalid.    " Element Definition (For Example, Type Name) Is Invalid

          CATCH cx_swf_cnt_invalid_qname.    " Qualified Name Invalid/Already Being Used

          CATCH cx_swf_cnt_container.    " Exception in the Container Service

        ENDTRY.


        TRY.

            mo_wi_cnt->if_swf_cnt_element_access_1~element_set_value( name =  'RARE_ACTION' value = cv_rare_action ).

          CATCH cx_swf_cnt_cont_access_denied.    " Change Access to Container Not Allowed

          CATCH cx_swf_cnt_elem_not_found.    " Element Not Found

          CATCH cx_swf_cnt_elem_access_denied.    " Element Must Not Be Changed

          CATCH cx_swf_cnt_elem_type_conflict.    " Type Conflict Between Value and Current Parameter

          CATCH cx_swf_cnt_unit_type_conflict.    " Type Conflict Between Unit and Current Parameter

          CATCH cx_swf_cnt_elem_def_invalid.    " Element Definition (For Example, Type Name) Is Invalid

          CATCH cx_swf_cnt_invalid_qname.    " Qualified Name Invalid/Already Being Used

          CATCH cx_swf_cnt_container.    " Exception in the Container Service

        ENDTRY.
* VERY IMPORTANT -- Save changes to DB

        TRY.

            mo_wi_cnt->save_to_database( ).

          CATCH cx_swf_cnt_invalid_por.    " Invalid Persistent Object Reference

        ENDTRY.

        mo_workitm_cntxt->publish( ).

      CATCH cx_root INTO mo_oref.
        mv_text = mo_oref->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.

  ENDMETHOD.


  METHOD sync_workitem.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Synchronize Work item
*&---------------------------------------------------------------------*
*Declaration
    DATA: mo_oref_root TYPE REF TO cx_root,
          mv_text      TYPE string.

    TRY.

        IF is_rare_inci IS SUPPLIED AND is_rare_inci IS NOT INITIAL.
          cs_rare_interface-rare_inci = is_rare_inci.
        ENDIF.

        IF cs_rare_interface-rare_inci-wi_id IS INITIAL.
          rv_wi_id = cs_rare_interface-rare_inci-wi_id = get_workitemid( cs_rare_interface-rare_inci ).
        ENDIF.

        IF cs_rare_interface-rare_inci-wi_id IS NOT INITIAL.
          TRY.
              rv_wi_id = cs_rare_interface-rare_inci-wi_id.
              cs_rare_interface-rare_inci-status_mesg = cs_rare_interface-rare_inci-status_mesg  && ' Data saved in workflow'(145).

              IF cs_rare_interface-rare_inci-guid IS INITIAL.
                cs_rare_interface-rare_inci-guid = generate_guid( ).
              ENDIF.

              UPDATE yztabl_rare_inci
                 SET wi_id          = cs_rare_interface-rare_inci-wi_id
                     status_mesg    = cs_rare_interface-rare_inci-status_mesg
               WHERE guid = cs_rare_interface-rare_inci-guid.

              IF sy-subrc = 0.
                CALL FUNCTION 'DB_COMMIT'.
              ELSE.
                mv_text =  'Error While updating Table! yztabl_rare_inci - WorkitemID'(176).
                APPEND mv_text TO cs_rare_interface-exceptions.
                collect_mesg( mv_text ).
              ENDIF.

            CATCH cx_sy_dynamic_osql_error.
              mv_text =  'Error While updating Table! yztabl_rare_inci - WorkitemID'(176).
              APPEND mv_text TO cs_rare_interface-exceptions.
              collect_mesg( mv_text ).
          ENDTRY.

        ENDIF.

      CATCH cx_root INTO mo_oref_root.
        mv_text = mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.

  ENDMETHOD.


  METHOD connect_snow_using_rest_api.
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Connects Service now
*&---------------------------------------------------------------------*
    TYPES: BEGIN OF lty_data,
             short_description TYPE string,
             urgency           TYPE i,
             caller_id         TYPE string,
             category          TYPE string,
             description       TYPE string,
             impact            TYPE string,
             assigned_to       TYPE string,
             assignment_group  TYPE string,
             subcategory      TYPE string,
*            number            type string,
*            sys_id            type string,
           END OF lty_data.
    TYPES: BEGIN OF lty_resp_data,
             number TYPE string,
             sys_id TYPE string,
           END OF lty_resp_data.

    TYPES: BEGIN OF lty_response,
             result TYPE lty_resp_data,
           END OF lty_response.
    TYPES: BEGIN OF itab,
             raw(255) TYPE x,
           END OF itab .

    DATA lt_params    TYPE zss_consume_rest=>url_param_tt.
    DATA lw_params    TYPE zss_consume_rest=>url_param.
    DATA lt_filetable TYPE filetable.
    DATA lv_rc        TYPE i.
    DATA lw_data      TYPE lty_data.
    DATA lw_data_resp TYPE lty_response.
    DATA lt_itab TYPE TABLE OF itab."xstring.
    DATA lv_file_data TYPE xstring.
    DATA lv_full_path TYPE pcfile-path.
    DATA lv_file_name TYPE string.
    DATA mv_text      TYPE string.
    DATA lt_errtab    TYPE TABLE OF RPBENERR.
    DATA lv_mail_addr TYPE string.


*    CONSTANTS lc_base_url   TYPE string VALUE 'https://dev84748.service-now.com/api/now/'.
*    CONSTANTS lc_inc_table  TYPE string VALUE 'table/incident'.
*    CONSTANTS lc_attachment TYPE string VALUE 'attachment/file'.
*    CONSTANTS lc_username   TYPE string VALUE 'admin'.
*    CONSTANTS lc_password   TYPE string VALUE 'iVpW9jn6BF-!'.

    TRY.

*Checking the call - Internal or External
        IF is_rare_inci IS SUPPLIED.
          IF is_rare_inci IS NOT INITIAL.
            CLEAR cs_rare_interface.
            get_container_data( EXPORTING iv_wi_id     = sync_workitem( is_rare_inci )
                                IMPORTING es_rare_data = cs_rare_interface ).
          ENDIF.
        ENDIF.

        IF cs_rare_interface-rare_inci-inc_no IS INITIAL.

          CALL METHOD cl_progress_indicator=>progress_indicate
            EXPORTING
              i_text               = 'Creating incident in ServiceNow'(002)
              i_output_immediately = abap_true.


          DATA(lo_rest_api) = NEW zss_consume_rest( ).

          DATA(lv_base_url) = get_snow_base_url( ).
          DATA(lv_inc_table) = get_snow_url_incident_resource( ).

          DATA(lo_client) = lo_rest_api->create_client(
            EXPORTING
              url      = lv_base_url "lc_base_url
              resource = lv_inc_table ). "lc_inc_table ).

          get_snow_auth_details(
            IMPORTING
              ev_user_id  = DATA(lv_username)
              ev_password = DATA(lv_password)
          ).

          lo_rest_api->set_authorization(
            EXPORTING
              io_client   = lo_client
              iv_username = lv_username "lc_username
              iv_password = lv_password "lc_password
          ).
          lo_rest_api->set_header_field(
            EXPORTING
              io_client = lo_client
              iv_name   = 'Content-Type'
              iv_value  = 'application/json'
          ).

          call function 'HR_FBN_GET_USER_EMAIL_ADDRESS'
            exporting
              user_id             = sy-uname
              reaction            = 'I'
           IMPORTING
             EMAIL_ADDRESS       = lv_mail_addr
            tables
              error_table         = lt_errtab.


          lw_data = VALUE #(
                    caller_id            = lv_mail_addr "sy-uname
                    category             = 'sap_application'(001) "'SAP applications'(004)
*                   subcategory          = 'SAP General'(005).
                    description          = cs_rare_interface-rare_inci-long_description
                    short_description    = cs_rare_interface-rare_inci-short_description
                    urgency              = cs_rare_interface-rare_inci-urgency
                    impact               = cs_rare_interface-rare_inci-impact
                    assignment_group     = cs_rare_interface-rare_inci-assignment_grp
                    subcategory         = cs_rare_interface-rare_inci-sub_category
                            ) .

          DATA(lv_data) = /ui2/cl_json=>serialize( data = lw_data pretty_name = 'L' ).
          lo_rest_api->set_cdata(
                                EXPORTING
                                  io_client = lo_client
                                  iv_data   = lv_data
                              ).

          lo_rest_api->send_request(
            EXPORTING
              io_client                  = lo_client
            EXCEPTIONS
              http_communication_failure = 1
              http_invalid_state         = 2
              http_processing_failed     = 3
              http_invalid_timeout       = 4
              OTHERS                     = 5
          ).

          IF sy-subrc <> 0.
            MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
          ELSE.
            lo_rest_api->get_response(
              EXPORTING
                io_client                  = lo_client
              EXCEPTIONS
                http_communication_failure = 1
                http_invalid_state         = 2
                http_processing_failed     = 3
                OTHERS                     = 4
            ).
            IF sy-subrc <> 0.
              MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
            ELSE.
              lv_data = lo_rest_api->get_response_data( io_client = lo_client ).
            ENDIF.
          ENDIF.

          IF lv_data IS NOT INITIAL.
            CALL METHOD /ui2/cl_json=>deserialize
              EXPORTING
                json = lv_data
              CHANGING
                data = lw_data_resp.
          ENDIF.

*Assigning Values
*          ms_rare_out-u_attachment1          = cs_rare_interface-pdf.
*          ms_rare_out-u_attahcment1_name     = 'Incident_info.pdf'(003).
**         ms_rare_out-u_attachment2_data     = ''.
**         ms_rare_out-u_attachment2_name     = ''.
*          ms_rare_out-u_caller               = sy-uname.
*          ms_rare_out-u_category             = 'SAP applications'(004).
**          ms_rare_out-subcategory           = 'SAP General'(005).
*          ms_rare_out-u_description          = cs_rare_interface-rare_inci-long_description.
*          ms_rare_out-u_short_description    = cs_rare_interface-rare_inci-short_description.
*          ms_rare_out-u_urgency              = cs_rare_interface-rare_inci-urgency.
*          ms_rare_out-u_impact               = cs_rare_interface-rare_inci-impact.
*
*          IF ms_rare_out-urgency IS INITIAL.
*            ms_rare_out-urgency = cs_rare_interface-rare_inci-urgency = '2'.
*          ENDIF.
*
*          IF ms_rare_out-impact  IS INITIAL.
*            ms_rare_out-urgency = cs_rare_interface-rare_inci-impact  = '3'.
*          ENDIF.

*          ms_rare_out-u_assigned_to          = cs_rare_interface-snow_cat_grp_details-assignment_grp.
*          ms_rare_out-u_sub_category         = cs_rare_interface-snow_cat_grp_details-sub_category.


          DATA(lv_incident) = lw_data_resp-result-number.

          lt_params = VALUE #( BASE lt_params ( key = 'table_name' value = 'incident'  )
                                               ( key = 'table_sys_id' value = lw_data_resp-result-sys_id )
                                               ( key = 'file_name' value = 'Incident_' && lw_data_resp-result-number && `.pdf`    )
                              ).

          DATA(lv_attachment) = get_snow_url_attach_resource( ).

          lo_client = lo_rest_api->create_client(
               EXPORTING
                 url       = lv_base_url "lc_base_url
                 resource  = lv_attachment "lc_attachment
                 url_param = lt_params ).

          lo_rest_api->set_authorization(
            EXPORTING
              io_client   = lo_client
              iv_username = lv_username "lc_username
              iv_password = lv_password "lc_password
          ).
          lo_rest_api->set_header_field(
            EXPORTING
              io_client = lo_client
              iv_name   = 'Content-Type'
              iv_value  = 'application/pdf'
          ).

          DATA pdf_binary TYPE xstring.


          CALL FUNCTION 'SSFC_BASE64_DECODE'
            EXPORTING
              b64data = cs_rare_interface-pdf
            IMPORTING
              bindata = pdf_binary.

          lo_rest_api->set_data(
            EXPORTING
              io_client = lo_client
              iv_data   = pdf_binary  "lv_data "'{ "short_description":"Unable to open mail" }'                 " Character data
          ).

          lo_rest_api->send_request(
            EXPORTING
              io_client                  = lo_client
            EXCEPTIONS
              http_communication_failure = 1
              http_invalid_state         = 2
              http_processing_failed     = 3
              http_invalid_timeout       = 4
              OTHERS                     = 5
          ).
          IF sy-subrc <> 0.
            MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
          ELSE.
            lo_rest_api->get_response(
              EXPORTING
                io_client                  = lo_client
              EXCEPTIONS
                http_communication_failure = 1
                http_invalid_state         = 2
                http_processing_failed     = 3
                OTHERS                     = 4
            ).
            IF sy-subrc <> 0.
              MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
            ELSE.
              lv_data = lo_rest_api->get_response_data( io_client = lo_client ).
*              WRITE lv_data.
            ENDIF.
          ENDIF.

          IF lv_incident CS 'INC'.
            mv_text = CONV string( 'Ticket Successfully Created in ServiceNow : ' ).
            CONCATENATE mv_text  lv_incident INTO mv_text.
*            MESSAGE mv_text TYPE 'I' DISPLAY LIKE 'I'.
          CALL METHOD cl_progress_indicator=>progress_indicate
            EXPORTING
              i_text               = mv_text
              i_output_immediately = abap_true.

            cs_rare_interface-rare_inci-inc_no      = lv_incident.
            cs_rare_interface-rare_inci-status_mesg = mv_text.
            collect_mesg( mv_text ).
*            send_email_with_attachment( lv_incident ).
            cv_rare_action = cc_action_incident_success.

*            call function 'C14Z_MESSAGES_SHOW_AS_POPUP'
*             EXPORTING
*               I_MSGID             = 'E4'
*               I_MSGTY             = 'S'
*               I_MSGNO             = '000'
*               I_MSGV1             = mv_text.
            call function 'POPUP_TO_DISPLAY_TEXT'
              exporting
               TITEL              = 'Success'
                textline1          = mv_text.


          ELSE.
            mv_text = 'Issue While raising Automated incident using Rare'(007) && ' because of '(128) && mv_text.
            MESSAGE mv_text TYPE 'I' DISPLAY LIKE 'I'.
*            cs_rare_interface-rare_inci-inc_no      = ms_rare_in-display_value.
            cs_rare_interface-rare_inci-status_mesg = mv_text.
            collect_mesg( mv_text ).
            cv_rare_action = cc_action_incident_error.
          ENDIF.
        ELSE.
          mv_text = 'You can not create Incident again as Incident has been raised already : '(167)  && cs_rare_interface-rare_inci-inc_no.
          MESSAGE mv_text TYPE 'I' DISPLAY LIKE 'I'.
          cs_rare_interface-rare_inci-status_mesg = mv_text.
          collect_mesg( mv_text ).
        ENDIF.

        IF cs_rare_interface-rare_inci-guid IS NOT INITIAL.

          TRY.
              cs_rare_interface-rare_inci-command     = 'ENT'.
              GET TIME STAMP FIELD cs_rare_interface-rare_inci-inc_timestamp.

              UPDATE yztabl_rare_inci
                 SET inc_no        = cs_rare_interface-rare_inci-inc_no
                     inc_timestamp = cs_rare_interface-rare_inci-inc_timestamp
                     command       = cs_rare_interface-rare_inci-command
                     status_mesg   = cs_rare_interface-rare_inci-status_mesg
               WHERE guid          = cs_rare_interface-rare_inci-guid.

              IF sy-subrc = 0.
                CALL FUNCTION 'DB_COMMIT'.
              ELSE.
                mv_text =  'Error While updating Table! yztabl_rare_inci - CONNECT_SNOW'(001) && mv_text.
                APPEND mv_text TO cs_rare_interface-exceptions.
                collect_mesg( mv_text ).
              ENDIF.

            CATCH cx_sy_dynamic_osql_error.
              mv_text =  'Error While updating Table! yztabl_rare_inci - CONNECT_SNOW'(001) && mv_text.
              APPEND mv_text TO cs_rare_interface-exceptions.
              collect_mesg( mv_text ).
          ENDTRY.
        ENDIF.


      CATCH cx_root INTO DATA(mo_oref_root).
        mv_text = mo_oref_root->get_text( ).
        APPEND mv_text TO cs_rare_interface-exceptions.
        collect_mesg( mv_text ).
        CLEAR mv_text.
        cv_rare_action = cc_action_incident_error.
    ENDTRY.
  ENDMETHOD.


  METHOD GET_SNOW_AUTH_DETAILS.
    READ TABLE ct_rare_swch INTO DATA(lw_rare_swch) WITH KEY obj_name = 'GET_SERVICE_NOW_AUTH'
                                                             task_name = 'USER_DETERMINATION'
                                                             vakey1 = 'USER_ID'.
    IF sy-subrc = 0.
      ev_user_id = lw_rare_swch-vadata1.
    ENDIF.

    READ TABLE ct_rare_swch INTO lw_rare_swch WITH KEY obj_name = 'GET_SERVICE_NOW_AUTH'
                                                             task_name = 'PASSWORD_DETERMINATION'
                                                             vakey1 = 'PASSWORD'.
    IF sy-subrc = 0.
      ev_password = lw_rare_swch-vadata1.
    ENDIF.
  ENDMETHOD.


METHOD GET_SNOW_BASE_URL.
  READ TABLE ct_rare_swch INTO DATA(lw_rare_swch) WITH KEY obj_name = 'GET_SERVICE_NOW_URL'
                                                           task_name = 'SERVICE_NOW_URL'
                                                           vakey1 = 'BASE_URL'.
  IF sy-subrc = 0.
    ev_base_url = lw_rare_swch-vadata1.
  ENDIF.
ENDMETHOD.


  METHOD GET_SNOW_URL_ATTACH_RESOURCE.
    READ TABLE ct_rare_swch INTO DATA(lw_rare_swch) WITH KEY obj_name = 'GET_SERVICE_NOW_URL'
                                                         task_name = 'ATTACHMENT'
                                                         vakey1 = 'RESOURCE_ATTACHMNT'.
    IF sy-subrc = 0.
      ev_resource = lw_rare_swch-vadata1.
    ENDIF.
  ENDMETHOD.


  METHOD GET_SNOW_URL_INCIDENT_RESOURCE.

    READ TABLE ct_rare_swch INTO DATA(lw_rare_swch) WITH KEY obj_name = 'GET_SERVICE_NOW_URL'
                                                         task_name = 'INCIDENT'
                                                         vakey1 = 'RESOURCE_INCIDENT'.
    IF sy-subrc = 0.
      ev_resource = lw_rare_swch-vadata1.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
