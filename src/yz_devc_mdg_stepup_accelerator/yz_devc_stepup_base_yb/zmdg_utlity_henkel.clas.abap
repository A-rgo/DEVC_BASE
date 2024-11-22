class ZMDG_UTLITY_HENKEL definition
  public
  final
  create public .

public section.

  class-methods GET_CR_URL
    importing
      !IV_CREQUEST type USMD_CREQUEST
      !IV_WI type SWW_WIID optional
    exporting
      !EV_URL type STRING .
  class-methods GEN_URL
    importing
      !IV_CREQUEST type USMD_CREQUEST
    exporting
      !EV_URL type STRING .
protected section.
private section.
ENDCLASS.



CLASS ZMDG_UTLITY_HENKEL IMPLEMENTATION.


  method GEN_URL.
      DATA:
    lv_url      TYPE string,
    lf_guid          TYPE sysuuid_c26,
    lt_para          TYPE tihttpnvp,
    lv_application_name TYPE string VALUE 'USMD_CREQUEST_PROCESS'.



  APPEND INITIAL LINE TO lt_para
  ASSIGNING FIELD-SYMBOL(<fs_para>).

  <fs_para>-name = 'CREQUEST'.
  <fs_para>-value = iv_crequest. "<Pass CR Number>.



*  APPEND INITIAL LINE TO lt_para
*  ASSIGNING <fs_para>.
*
*  <fs_para>-name = 'CREQUEST_WORKITEM'.
*  <fs_para>-value = <Pass Current active Workitem ID>.





  APPEND INITIAL LINE TO lt_para
  ASSIGNING <fs_para>.

  <fs_para>-name = 'SAP-CLIENT'.

  <fs_para>-value = sy-mandt.



* Generate URL for NWBC link of Direct CR

  cl_wd_utilities=>construct_wd_url(

    EXPORTING

      application_name = lv_application_name

      in_parameters    = lt_para

    IMPORTING

      out_absolute_url = lv_url ).
  endmethod.


  METHOD get_cr_url.
****************************************************************************************************
* Program Change History
*****************************************************************************************************
* MOD-XXX       : MOD-001
* Date          :
* Change No     :
* WRICEF-ID     :
* Defect-ID     :
* Transport     :
* User ID       :
* Release ID    :
*
* Change Description:
* (1) Create URL for send in mail
******************************************************************************************************

******************************************************************************************************
    DATA:

      lo_navigation_handler       TYPE REF TO if_usmd_wf_navigation_handler,

      ls_navigation_parameters    TYPE usmd_s_wf_obn_params,

      ls_navigation_parameter     TYPE usmd_s_namevalue,

      lv_application_id           TYPE string,

      lv_action                   TYPE usmd_action,

      key_value_pairs_for_mapping TYPE usmd_t_namevalue,

      url_parameters              TYPE usmd_t_value,

      lo_ui_service               TYPE REF TO if_usmd_ui_services,

      id_wi_id                    TYPE sww_wiid,

      lv_main_component           TYPE REF TO if_wd_component,

      lv_value_list               TYPE usmd_ts_seqnr_value,

      lv_url                      TYPE string,

      lv_wdy_key_value_table      TYPE wdy_key_value_table,

      lv_apb_lpd_t_params         TYPE apb_lpd_t_params,

      lt_para                     TYPE tihttpnvp,

      lv_para                     TYPE ihttpnvp.

    DATA:

    fieldname_value_pair TYPE usmd_s_value.

    DATA:

      lv_accessibility TYPE abap_bool,

      lv_langu(2)      TYPE c,

      lo_application   TYPE REF TO if_wd_application,

      lv_shm_instance  TYPE shm_inst_name,

      lv_guid          TYPE guid_32,

      ls_rfc           TYPE rfcsi.

    CONSTANTS : lc_client   TYPE string VALUE 'SAP-CLIENT',

                lc_language TYPE string VALUE 'SAP-LANGUAGE'.

    FIELD-SYMBOLS:

    <key_value_pair> TYPE powl_namevalue_sty.
    id_wi_id = iv_wi.

    lo_navigation_handler = cl_usmd_wf_navigation_handler=>get_instance(

    iv_workitem_id = id_wi_id

    iv_crequest_id = iv_crequest ).

    ls_navigation_parameters = lo_navigation_handler->get_navigation_parameters( ).

    lv_application_id = ls_navigation_parameters-ui_appl.

    READ TABLE ls_navigation_parameters-parameters INTO ls_navigation_parameter

    WITH KEY key = cl_usmd_wf_navigation_handler=>gc_par_logical_action.

    IF sy-subrc = 0.

      lv_action = ls_navigation_parameter-value.

    ELSE.

      CLEAR lv_action.

    ENDIF.

    key_value_pairs_for_mapping = ls_navigation_parameters-parameters.

*--------------------------------------------------------------------*

    LOOP AT key_value_pairs_for_mapping ASSIGNING <key_value_pair>.

      fieldname_value_pair-fieldname = <key_value_pair>-key.

      fieldname_value_pair-value = <key_value_pair>-value.

      APPEND fieldname_value_pair TO url_parameters.

    ENDLOOP.

    fieldname_value_pair-fieldname = lc_client.

    fieldname_value_pair-value = sy-mandt.

    INSERT fieldname_value_pair INTO TABLE url_parameters .

    CALL FUNCTION 'CONVERSION_EXIT_ISOLA_OUTPUT'
      EXPORTING
        input  = sy-langu
      IMPORTING
        output = lv_langu.

    fieldname_value_pair-fieldname = lc_language.

    fieldname_value_pair-value = lv_langu.

    INSERT fieldname_value_pair INTO TABLE url_parameters.


    LOOP AT url_parameters INTO fieldname_value_pair.

      IF fieldname_value_pair-fieldname NE 'WDAPPLICATIONID'.

        lv_para-name = fieldname_value_pair-fieldname.

        lv_para-value = fieldname_value_pair-value.

        INSERT lv_para INTO TABLE lt_para.

      ENDIF.

    ENDLOOP.

    cl_wd_utilities=>construct_wd_url(

    EXPORTING

    application_name = lv_application_id

    in_parameters = lt_para

    IMPORTING

    out_absolute_url = lv_url ).

    IF lv_url IS NOT INITIAL.

*move lv_url to ev_url.
      ev_url = lv_url.


    ENDIF.
  ENDMETHOD.
ENDCLASS.
