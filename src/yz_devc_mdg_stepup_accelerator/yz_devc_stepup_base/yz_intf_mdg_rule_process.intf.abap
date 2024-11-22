interface YZ_INTF_MDG_RULE_PROCESS
  public .


  methods EXECUTE_DYNAMIC_CLASS_METHOD
    importing
      !IS_RULE_EXE type YZTABL_RULE_EXE optional
    exporting
      !ET_MESSAGE type USMD_T_MESSAGE
    returning
      value(RV_BOOLEAN) type BOOLEAN .
  methods EXECUTE_STANDARD_VALIDATIONS
    importing
      !IO_MODEL type ref to IF_USMD_MODEL_EXT optional
      !ID_EDITION type USMD_EDITION
      !ID_CREQUEST type USMD_CREQUEST optional
      !ID_ENTITYTYPE type USMD_ENTITY
      !IF_ONLINE_CHECK type USMD_FLG default ABAP_TRUE
      !IT_DATA type ANY TABLE
    exporting
      !ET_MESSAGE type USMD_T_MESSAGE .
  methods EXECUTE_STANDARD_DERIVATIONS
    importing
      !IO_MODEL type ref to IF_USMD_MODEL_EXT
      !IO_CHANGED_DATA type ref to IF_USMD_DELTA_BUFFER_READ
      !IO_WRITE_DATA type ref to IF_USMD_DELTA_BUFFER_WRITE
    exporting
      !ET_MESSAGE_INFO type USMD_T_MESSAGE .
endinterface.
