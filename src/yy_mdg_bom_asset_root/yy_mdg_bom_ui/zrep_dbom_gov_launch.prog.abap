*&---------------------------------------------------------------------*
*& Report ZREP_DBOM_MASTER_LAUNCH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrep_dbom_gov_launch.

*
*DATA(lv_url) = 'https://ussltcsnl1304.solutions.glbsnet.com:8002/sap/bc/adt/businessservices/odatav2/' &&
*'feap?feapParams=ni%5DsXVsjFsfYZsaUghYfs%5CYUX77%5Cyuxy%C2%8677%C2%88%C2%83s%7D%C2%88y%C2%8177%5D%C2%88y%' &&
*'C2%8177ni%5DsXVsjFsfYZsaUghYfs%5CYUXsjUb77DDDE'.
DATA: lv_url TYPE string.
lv_url = 'https://ussltcsnl1304.solutions.glbsnet.com:8002/sap/bc/webdynpro/sap/MDG_BS_MAT_SEARCH?sap-wd-configId=MDG_BS_MAT_SEARCH_09&sap-client=100&sap-language=EN#'.
CALL METHOD cl_gui_frontend_services=>execute
  EXPORTING
    document = lv_url
  EXCEPTIONS
    OTHERS   = 1.
IF sy-subrc <> 0.
ENDIF.
