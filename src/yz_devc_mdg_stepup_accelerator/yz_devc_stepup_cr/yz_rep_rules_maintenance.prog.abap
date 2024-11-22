*&---------------------------------------------------------------------*
*& Report YZ_REP_RULES_MAINTENANCE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT yz_rep_rules_maintenance.

DATA: lv_url TYPE string ##NEEDED.
lv_url = text-001."'http://usawscl0147.us.deloitte.com:8001/sap/bc/webdynpro/sap/usmd_ovp_gen?sap-language=EN&sap-wd-configId=YZ_USMD_OVP_GEN_YZ#'.
CALL METHOD cl_gui_frontend_services=>execute
  EXPORTING
    document = lv_url
  EXCEPTIONS
    OTHERS   = 1.
IF sy-subrc eq 1.
  RETURN.
ENDIF.
