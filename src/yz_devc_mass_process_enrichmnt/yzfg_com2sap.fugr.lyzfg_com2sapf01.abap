*----------------------------------------------------------------------*
***INCLUDE LYZFG_COM2SAPF01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_model_value
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> I_MODE
*&      --> I_ACTIONID
*&      --> I_MODEL
*&      <-- I_INPUT_TAB
*&---------------------------------------------------------------------*
FORM get_model_value  USING    i_mode
                               i_actionid
                               i_model
                      CHANGING i_input_tab        TYPE yzm_s_input_tab
                               lv_scope_required  TYPE flag.
  IF i_model IS INITIAL.
    ""ADD error message here
    i_input_tab-e_status = 'Error'.
    i_input_tab-e_message = 'Specify Valid value for model'.
    RETURN.
  ELSEIF i_model EQ 'XX' AND i_actionid EQ '01'. ""User Requesting for data
    yz_class_com2sap_utility=>get_model_data(
      CHANGING
        ct_input_tab = i_input_tab        " Input Tab
    ).
  ELSEIF i_actionid EQ '01'.
    lv_scope_required = abap_true.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_scope_model
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> I_MODEL
*&      <-- I_INPUT_TAB
*&      <-- LV_TEMPID_REQUIRED
*&---------------------------------------------------------------------*
FORM get_scope_model  USING    i_model
                               i_scope
                      CHANGING i_input_tab        TYPE yzm_s_input_tab
                               lv_tempid_required TYPE flag.
  IF i_scope IS INITIAL.
    ""ADD error message here
    i_input_tab-e_status = 'Error'.
    i_input_tab-e_message = 'Specify Valid value for scope'.
    RETURN.
  ELSEIF i_scope EQ 'XX'. ""User Requesting for data
    yz_class_com2sap_utility=>get_scope_model_data(
      EXPORTING
        lv_model     = i_model                 " Data Model value for mass process enrichment
      CHANGING
        ct_input_tab = i_input_tab                  " Input Tab
    ).
  ELSE.
    lv_tempid_required = abap_true.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_template_from_scope
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> I_MODEL
*&      --> I_SCOPE
*&      --> I_TEMPID
*&      <-- I_INPUT_TAB
*&      <-- LV_TEMPID_REQUIRED
*&---------------------------------------------------------------------*
FORM get_template_from_scope  USING    i_model
                                       i_scope
                                       i_tempid
                              CHANGING i_input_tab        TYPE yzm_s_input_tab
                                       lv_tempid_required TYPE flag.
  IF i_tempid IS INITIAL.
    ""ADD error message here
    i_input_tab-e_status = 'Error'.
    i_input_tab-e_message = 'Specify Valid value for tempid'.
    RETURN.
  ELSEIF i_tempid EQ 'XX'. ""User Requesting for data
    yz_class_com2sap_utility=>get_templateid_from_scope_data(
      EXPORTING
        lv_model     = i_model                 " Data Model value for mass process enrichment
        lv_scope     = i_scope                 " Scope Id for Data model
      CHANGING
        ct_input_tab = i_input_tab                 " Input Tab
    ).
  ELSE.
    lv_tempid_required = abap_true.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_template_from_template_id
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> I_MODEL
*&      --> I_SCOPE
*&      --> I_TEMPID
*&      <-- I_INPUT_TAB
*&---------------------------------------------------------------------*
FORM get_template_from_template_id  USING    i_model
                                             i_scope
                                             i_tempid
                                    CHANGING i_input_tab TYPE yzm_s_input_tab
                                             et_template TYPE yzm_t_templt_det.

  DATA: lt_template TYPE TABLE OF yztab_templt_det.

  CHECK i_tempid IS NOT INITIAL AND i_tempid NE 'XX'.

  yz_class_com2sap_utility=>get_template_from_id(
    EXPORTING
        iv_model      = i_model                 " Data Model value for mass process enrichment
        iv_scope      = i_scope                 " Scope Id for Data model
        iv_templateid = i_tempid
    IMPORTING
        et_template   = et_template                 " Input Tab
    ).
    SORT et_template BY view_id column_id.
ENDFORM.
