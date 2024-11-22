interface YZ_INTF_MDG_ACCELERATOR_CONFIG
  public .


  class-methods PROCESS_CONFIG_RECORDS
    importing
      !IV_EVENT_ID type CHAR30 optional
      !IV_VIEW_ENTITY type STRING optional
      !IV_ACTION type ANY optional
      !IT_SUPER_SET_CONFIG type ANY TABLE optional
    changing
      !CS_DATA type ANY optional
      !CT_DATA type ANY TABLE optional
    returning
      value(RT_MESSAGES) type USMD_T_MESSAGE .
  class-methods PROCESS_YZ_VIEW_RULE_DEF
    importing
      !IV_EVENT_ID type CHAR30 optional
      !IV_VIEW_ENTITY type STRING optional
      !IV_ACTION type ANY optional
      !IT_SUPER_SET_CONFIG type ANY TABLE optional
    changing
      !CS_DATA type ANY optional
      !CT_DATA type ANY TABLE optional
    returning
      value(RT_MESSAGES) type USMD_T_MESSAGE .
  class-methods PROCESS_YZ_VIEW_RULE_DOM
    importing
      !IV_EVENT_ID type CHAR30 optional
      !IV_VIEW_ENTITY type STRING optional
      !IV_ACTION type ANY optional
      !IT_SUPER_SET_CONFIG type ANY TABLE optional
    changing
      !CS_DATA type ANY optional
      !CT_DATA type ANY TABLE optional
    returning
      value(RT_MESSAGES) type USMD_T_MESSAGE .
  class-methods PROCESS_YZ_VIEW_RULE_VAL
    importing
      !IV_EVENT_ID type CHAR30 optional
      !IV_VIEW_ENTITY type STRING optional
      !IV_ACTION type ANY optional
      !IT_SUPER_SET_CONFIG type ANY TABLE optional
    changing
      !CS_DATA type ANY optional
      !CT_DATA type ANY TABLE optional
    returning
      value(RT_MESSAGES) type USMD_T_MESSAGE .
  class-methods PROCESS_YZ_VIEW_RULE_EXE
    importing
      !IV_EVENT_ID type CHAR30 optional
      !IV_VIEW_ENTITY type STRING optional
      !IV_ACTION type ANY optional
      !IT_SUPER_SET_CONFIG type ANY TABLE optional
    changing
      !CS_DATA type ANY optional
      !CT_DATA type ANY TABLE optional
    returning
      value(RT_MESSAGES) type USMD_T_MESSAGE .
  class-methods PROCESS_YZ_VIEW_RULE_TMP
    importing
      !IV_EVENT_ID type CHAR30 optional
      !IV_VIEW_ENTITY type STRING optional
      !IV_ACTION type ANY optional
      !IT_SUPER_SET_CONFIG type ANY TABLE optional
    changing
      !CS_DATA type ANY optional
      !CT_DATA type ANY TABLE optional
    returning
      value(RT_MESSAGES) type USMD_T_MESSAGE .
  class-methods PROCESS_YZ_VIEW_TEMP_ITM
    importing
      !IV_EVENT_ID type CHAR30 optional
      !IV_VIEW_ENTITY type STRING optional
      !IV_ACTION type ANY optional
      !IT_SUPER_SET_CONFIG type ANY TABLE optional
    changing
      !CS_DATA type ANY optional
      !CT_DATA type ANY TABLE optional
    returning
      value(RT_MESSAGES) type USMD_T_MESSAGE .
  class-methods GET_NR_DEF_ID_FOR_RULE
    importing
      !IV_RULE_TYPE type YZ_DTEL_RULE_TYPE
    returning
      value(RV_DEF_ID) type NUMC08 .
  class-methods GET_NR_EXE_ID_FOR_RULE
    importing
      !IV_DEF_ID type YZ_DTEL_RULE_ID
      !IV_RULE_SEC type YZ_DTEL_RULE_SEC
      !IT_TAB type ANY TABLE optional
    returning
      value(RV_EXE_ID) type CHAR04 .
  class-methods GET_NR_VAL_ID_FOR_RULE
    importing
      !IV_RULE_SEC type YZ_DTEL_RULE_SEC optional
    returning
      value(RV_VAL_ID) type NUMC04 .
  class-methods GET_NR_TMP_ID_FOR_RULE
    returning
      value(RV_TMP_ID) type CHAR10 .
  class-methods GET_NR_ITM_ID_FOR_RULE
    importing
      !IV_TEMP_ID type YZ_DTEL_TEMP_ID
      !IV_RULE_SEC type YZ_DTEL_RULE_SEC
      !IT_TAB type ANY TABLE optional
    returning
      value(RV_ITM_ID) type CHAR04 .
endinterface.
