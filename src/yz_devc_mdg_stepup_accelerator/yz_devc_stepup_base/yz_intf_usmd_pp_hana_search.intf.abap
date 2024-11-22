interface YZ_INTF_USMD_PP_HANA_SEARCH
  public .


  class-methods ADAPT_SEL_FIELDS
    importing
      !IV_MODEL type USMD_MODEL
      !IV_OTC type USMD_OTC
      !IV_MAIN_ENTITY type USMD_ENTITY
    changing
      !CT_SEL_ATTRIBUTES type MDG_HDB_TT_SEL_ATTRIBUTES .
  class-methods GET_REUSE_VIEW_CONTENT
    importing
      !IV_MODEL type USMD_MODEL
      !IV_OTC type USMD_OTC
      !IV_MAIN_ENTITY type USMD_ENTITY
      !IT_ENTITIES type USMD_T_ENTITY
      !IT_MODEL_ATTRIBUTES type USMD_TS_ENTITY_FIELDNAME
      !IV_MAIN_TABLE type USMD_TAB_SOURCE
    exporting
      !EV_MAIN_TABLE type USMD_TAB_SOURCE
      !ET_JOIN_CONDITIONS type MDG_HDB_TT_XML_JOIN_TABLE
      !ET_REUSE_ATTRIBUTES type MDG_HDB_TT_REUSE_ATTRIBUTES
      !ET_MESSAGES type USMD_T_MESSAGE .
  class-methods MERGE_REUSE_AUTHORIZATION
    importing
      !IS_SEARCH_CONTEXT type USMD_S_SEARCH_CONTEXT
    exporting
      !EV_NO_AUTHORIZATION type BOOLEAN
      !ET_AUTH_ATTRIBUTES type USMD_TS_SEL
    changing
      !CT_SEARCH_ATTRIBUTES type USMD_TS_SEL .
  class-methods GET_MAPPING_INFO
    importing
      !IV_MODEL type USMD_MODEL
      !IV_OTC type USMD_OTC
      !IS_SEARCH_CONTEXT type USMD_S_SEARCH_CONTEXT
    exporting
      !ET_MESSAGES type USMD_T_MESSAGE
    changing
      !CT_MAPPING_INFO type MDG_HDB_TT_REUSE_MAPPING .
  class-methods ADAPT_WHERE_CLAUSE
    importing
      !IS_SEARCH_CONTEXT type USMD_S_SEARCH_CONTEXT
      !IT_SEARCH_ATTRIBUTES type USMD_TS_SEL
    changing
      !CV_WHERE_CLAUSE type STRING optional
      !CV_WHERE_CLAUSE_MDG_NAMES type STRING optional .
  class-methods ADAPT_RESULT_LIST
    importing
      !IS_SEARCH_CONTEXT type USMD_S_SEARCH_CONTEXT
      !IR_STAGING_STRUCT_TYPE_REF type ref to CL_ABAP_STRUCTDESCR
      !IT_REUSE_DATA type USMD_T_SEARCH_RESULT optional
      !IT_REUSE_DATA_MDG_NAMES type USMD_T_SEARCH_RESULT optional
    exporting
      !ET_DATA type USMD_T_SEARCH_RESULT .
endinterface.
