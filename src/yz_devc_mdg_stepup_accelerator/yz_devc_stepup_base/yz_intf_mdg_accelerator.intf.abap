interface YZ_INTF_MDG_ACCELERATOR
  public .


  methods EXECUTE_BUSINESS_RULES
    importing
      !IP_APP_CONTEXT type YZTABL_APPLICATION_CONTEXT optional
      !IV_DEF_ID type MDQ_RULE_DEFINITION_ID optional
      !IV_RULE_SEC type YZ_DTEL_RULE_SEC optional
    exporting
      !ET_DATA type ANY TABLE
      !ET_MESSAGE type USMD_T_MESSAGE
    changing
      !CP_FLP_CONTEXT type YZTABL_FLP_CONTEXT optional
      !CP_DYN_CONTEXT type YZTABL_DYN_CONTEXT optional
    returning
      value(RV_RESULT) type BOOLEAN .
endinterface.
