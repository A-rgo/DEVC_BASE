*&---------------------------------------------------------------------*
*& Report ZREP_DREF_GOV_LAUNCH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrep_dref_gov_launch.

DATA: lv_url TYPE string.
lv_url = 'https://usawscl0147.us.deloitte.com:8002/sap/bc/webdynpro/sap/usmd_ovp_gen?sap-wd-configId=YZR_USMD_OVP_GEN_TEMPLATE&sap-client=100&sap-language=EN#'.
CALL METHOD cl_gui_frontend_services=>execute
  EXPORTING
    document = lv_url
  EXCEPTIONS
    OTHERS   = 1.
IF sy-subrc <> 0.
ENDIF.
