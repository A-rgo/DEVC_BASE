class YZ_CLAS_MDG_EVENT_PROCESS definition
  public
  inheriting from YZ_CLAS_MDG_UTILITY
  create public .

public section.

  interfaces IF_SWF_IFS_WORKITEM_EXIT .
  interfaces IF_BADI_INTERFACE .
  interfaces IF_BADI_SDQ_PP_INITIAL_LOAD_ES .
  interfaces IF_EX_USMD_REMOTE_WHERE_USED .
  interfaces YZ_INTF_MDG_ACCELERATOR_CONST .
  interfaces IF_DRF_ALE_AUDIT_GET_KM_DATA .
  interfaces IF_EX_USMD_ENTITY_UI .
  interfaces IF_EX_USMD_RULE_SERVICE .
  interfaces IF_EX_USMD_RULE_SERVICE2 .
  interfaces IF_BADI_SDQ_PP_SEARCH .
  interfaces IF_DRF_FILTER .
  interfaces IF_DRF_OUTBOUND .
  interfaces IF_EX_BDCP_BEFORE_WRITE .
  interfaces IF_EX_MDG_FILECONVERTER .
  interfaces IF_EX_MDG_GW_FIORI_DERIVATIONS .
  interfaces IF_EX_USMD_ACC_FLD_PROP_CDS .
  interfaces IF_EX_USMD_CREQUEST_CLEANUP .
  interfaces IF_EX_USMD_CREQUEST_INTEGR .
  interfaces IF_EX_USMD_CR_OBJECT_LIST .
  interfaces IF_EX_USMD_DATA_TRANSFER_UPL .
  interfaces IF_EX_USMD_GENERIC_GENIL_TEXT .
  interfaces IF_EX_USMD_MODEL_ACTIVATION .
  interfaces IF_EX_USMD_SEARCH .
  interfaces IF_EX_USMD_TRANSACTION_EVENTS .
  interfaces IF_FPM_WIRE_MODEL .
  interfaces IF_FPM_OVP .
  interfaces IF_FPM_OVP_CONF_EXIT .
  interfaces IF_MDG_DQR_DQ_SERVICE .
  interfaces IF_SERIALIZABLE_OBJECT .
  interfaces IF_MDG_EXTR_BADI .
  interfaces IF_USMD_ENRICHMENT_ADAPTER .
  interfaces IF_USMD_ENRICHMENT_FEEDER .
  interfaces IF_USMD_PP_ACCESS .
  interfaces IF_USMD_PP_BLOCKLIST .
  interfaces IF_USMD_PP_HANA_SEARCH .
  interfaces IF_USMD_SEARCH_DATA .
  interfaces IF_USMD_SSW_DYNAMIC_AGT_SELECT .
  interfaces IF_USMD_SSW_PARA_RSLT_HANDLER .
  interfaces IF_USMD_SSW_RULE_CHK_AGENT_TAB .
  interfaces IF_USMD_SSW_RULE_CNTX_PREPARE .
  interfaces IF_USMD_SSW_SYST_METHOD_CALLER .
  interfaces YZ_INTF_MDG_BADI_IMPL .
  interfaces /PLMU/IF_EX_FRW_APPCC_OVP .
  interfaces IF_MDG_DQR_EVENT_HANDLER .

  aliases CS_ACTIVITY
    for IF_USMD_PP_ACCESS~CS_ACTIVITY .
  aliases CS_CHANGE_TYPE
    for IF_FPM_WIRE_MODEL~CS_CHANGE_TYPE .
  aliases CS_KEY_HANDLING
    for IF_USMD_PP_ACCESS~CS_KEY_HANDLING .
  aliases CS_TABL_KIND
    for IF_EX_USMD_MODEL_ACTIVATION~CS_TABL_KIND .
  aliases D_FLDPROP_HIDDEN_SUPPORTED
    for IF_USMD_PP_ACCESS~D_FLDPROP_HIDDEN_SUPPORTED .
  aliases GC_ACTION_ARCHIVING
    for IF_EX_USMD_CREQUEST_CLEANUP~GC_ACTION_ARCHIVING .
  aliases GC_ACTION_DELETION
    for IF_EX_USMD_CREQUEST_CLEANUP~GC_ACTION_DELETION .
  aliases GC_BP_HEADER
    for YZ_INTF_MDG_ACCELERATOR_CONST~GC_BP_HEADER .
  aliases GC_CONTEXT_SAVE
    for IF_USMD_PP_ACCESS~GC_CONTEXT_SAVE .
  aliases GC_CRSTEP_DEFAULT
    for YZ_INTF_MDG_ACCELERATOR_CONST~GC_CRSTEP_DEFAULT .
  aliases GC_CRTYPE_DEFAULT
    for YZ_INTF_MDG_ACCELERATOR_CONST~GC_CRTYPE_DEFAULT .
  aliases GC_DATA_PROCESS_CLASS_NAME
    for YZ_INTF_MDG_ACCELERATOR_CONST~GC_DATA_PROCESS_CLASS_NAME .
  aliases GC_ENTITY_YYORGUNIT
    for YZ_INTF_MDG_ACCELERATOR_CONST~GC_ENTITY_YYORGUNIT .
  aliases GC_ENTITY_YYUSAGE
    for YZ_INTF_MDG_ACCELERATOR_CONST~GC_ENTITY_YYUSAGE .
  aliases GC_EXECUTE_DERIVATION
    for YZ_INTF_MDG_ACCELERATOR_CONST~GC_EXECUTE_DERIVATION .
  aliases GC_EXECUTE_DYNAMIC_AGENT
    for YZ_INTF_MDG_ACCELERATOR_CONST~GC_EXECUTE_DYNAMIC_AGENT .
  aliases GC_EXECUTE_DYN_UNIQUE
    for YZ_INTF_MDG_ACCELERATOR_CONST~GC_EXECUTE_DYN_UNIQUE .
  aliases GC_EXECUTE_FLDPROP
    for YZ_INTF_MDG_ACCELERATOR_CONST~GC_EXECUTE_FLDPROP .
  aliases GC_EXECUTE_HIDEUIBB
    for YZ_INTF_MDG_ACCELERATOR_CONST~GC_EXECUTE_HIDEUIBB .
  aliases GC_EXECUTE_VALIDATION
    for YZ_INTF_MDG_ACCELERATOR_CONST~GC_EXECUTE_VALIDATION .
  aliases GC_EXECUTE_VALIDATION_UNIQUE
    for YZ_INTF_MDG_ACCELERATOR_CONST~GC_EXECUTE_VALIDATION_UNIQUE .
  aliases GC_FIXED_VALUE
    for YZ_INTF_MDG_ACCELERATOR_CONST~GC_FIXED_VALUE .
  aliases GC_FLD_PROP_MANDATORY
    for YZ_INTF_MDG_ACCELERATOR_CONST~GC_FLD_PROP_MANDATORY .
  aliases GC_MAPPER_MESSAGE_ID
    for YZ_INTF_MDG_ACCELERATOR_CONST~GC_MAPPER_MESSAGE_ID .
  aliases GC_MAPPER_MESSAGE_NO
    for YZ_INTF_MDG_ACCELERATOR_CONST~GC_MAPPER_MESSAGE_NO .
  aliases GC_MDG_BADI_TRACE
    for YZ_INTF_MDG_ACCELERATOR_CONST~GC_MDG_BADI_TRACE .
  aliases GC_MM_MODEL
    for YZ_INTF_MDG_ACCELERATOR_CONST~GC_MM_MODEL .
  aliases GC_PROCESS_TYPE_BADI_TRACE
    for YZ_INTF_MDG_ACCELERATOR_CONST~GC_PROCESS_TYPE_BADI_TRACE .
  aliases GC_PROCESS_TYPE_DYNAMIC_AGENT
    for YZ_INTF_MDG_ACCELERATOR_CONST~GC_PROCESS_TYPE_DYNAMIC_AGENT .
  aliases GC_RIGHT_OUTER
    for YZ_INTF_MDG_ACCELERATOR_CONST~GC_RIGHT_OUTER .
  aliases GC_RULE_CONTEXT_CR
    for YZ_INTF_MDG_ACCELERATOR_CONST~GC_RULE_CONTEXT_CR .
  aliases GC_RULE_SECTION_CONDITION
    for YZ_INTF_MDG_ACCELERATOR_CONST~GC_RULE_SECTION_CONDITION .
  aliases GC_RULE_SECTION_SCOPE
    for YZ_INTF_MDG_ACCELERATOR_CONST~GC_RULE_SECTION_SCOPE .
  aliases GC_RULE_SECTION_USAGE
    for YZ_INTF_MDG_ACCELERATOR_CONST~GC_RULE_SECTION_USAGE .
  aliases GC_RULE_STAT_TABNAME
    for YZ_INTF_MDG_ACCELERATOR_CONST~GC_RULE_STAT_TABNAME .
  aliases GC_RULE_TASK_CHECK
    for YZ_INTF_MDG_ACCELERATOR_CONST~GC_RULE_TASK_CHECK .
  aliases GC_RULE_TASK_EXECUTE
    for YZ_INTF_MDG_ACCELERATOR_CONST~GC_RULE_TASK_EXECUTE .
  aliases GC_SPT_APPROVER
    for YZ_INTF_MDG_ACCELERATOR_CONST~GC_SPT_APPROVER .
  aliases GC_STRUCT_KEY_ATTR
    for YZ_INTF_MDG_ACCELERATOR_CONST~GC_STRUCT_KEY_ATTR .
  aliases GC_USAGE_MDF_CHECK
    for YZ_INTF_MDG_ACCELERATOR_CONST~GC_USAGE_MDF_CHECK .
  aliases MC_FIELDNAME
    for IF_EX_USMD_ACC_FLD_PROP_CDS~MC_FIELDNAME .
  aliases MC_FLD_PROP_SRC
    for IF_EX_USMD_ACC_FLD_PROP_CDS~MC_FLD_PROP_SRC .
  aliases MC_FLD_PROP_VAL
    for IF_EX_USMD_ACC_FLD_PROP_CDS~MC_FLD_PROP_VAL .
  aliases MO_MODEL_EXT
    for IF_USMD_PP_BLOCKLIST~MO_MODEL_EXT .
  aliases ADAPT_RESULT_LIST
    for IF_USMD_PP_HANA_SEARCH~ADAPT_RESULT_LIST .
  aliases ADAPT_SEL_FIELDS
    for IF_USMD_PP_HANA_SEARCH~ADAPT_SEL_FIELDS .
  aliases ADAPT_WHERE_CLAUSE
    for IF_USMD_PP_HANA_SEARCH~ADAPT_WHERE_CLAUSE .
  aliases ADD_CONTENT_AREA
    for IF_FPM_OVP~ADD_CONTENT_AREA .
  aliases ADD_DEFAULT_ACTION
    for IF_FPM_OVP~ADD_DEFAULT_ACTION .
  aliases ADD_EXTERNAL_NAVIGATION
    for IF_FPM_OVP~ADD_EXTERNAL_NAVIGATION .
  aliases ADD_PAGE_HEADER_AREA
    for IF_FPM_OVP~ADD_PAGE_HEADER_AREA .
  aliases ADD_PAGE_HEADER_UIBB
    for IF_FPM_OVP~ADD_PAGE_HEADER_UIBB .
  aliases ADD_PAGE_MASTER_AREA
    for IF_FPM_OVP~ADD_PAGE_MASTER_AREA .
  aliases ADD_PAGE_MASTER_UIBB
    for IF_FPM_OVP~ADD_PAGE_MASTER_UIBB .
  aliases ADD_SECTION
    for IF_FPM_OVP~ADD_SECTION .
  aliases ADD_TOOLBAR_BUTTON
    for IF_FPM_OVP~ADD_TOOLBAR_BUTTON .
  aliases ADD_TOOLBAR_BUTTON_CHOICE
    for IF_FPM_OVP~ADD_TOOLBAR_BUTTON_CHOICE .
  aliases ADD_TOOLBAR_DROP_DOWN_LIST
    for IF_FPM_OVP~ADD_TOOLBAR_DROP_DOWN_LIST .
  aliases ADD_TOOLBAR_TOGGLE_BUTTON
    for IF_FPM_OVP~ADD_TOOLBAR_TOGGLE_BUTTON .
  aliases ADD_UIBB
    for IF_FPM_OVP~ADD_UIBB .
  aliases ADD_WIRE
    for IF_FPM_OVP~ADD_WIRE .
  aliases ADJUST_SELECTION_ATTR
    for IF_USMD_PP_ACCESS~ADJUST_SELECTION_ATTR .
  aliases AFTER_AFTER_FAILED_EVENT
    for /PLMU/IF_EX_FRW_APPCC_OVP~AFTER_AFTER_FAILED_EVENT .
  aliases AFTER_CLEANUP
    for /PLMU/IF_EX_FRW_APPCC_OVP~AFTER_CLEANUP .
  aliases AFTER_FAILED_EVENT
    for /PLMU/IF_EX_FRW_APPCC_OVP~AFTER_FAILED_EVENT .
  aliases AFTER_FLUSH
    for /PLMU/IF_EX_FRW_APPCC_OVP~AFTER_FLUSH .
  aliases AFTER_NEEDS_CONFIRMATION
    for /PLMU/IF_EX_FRW_APPCC_OVP~AFTER_NEEDS_CONFIRMATION .
  aliases AFTER_PROCESS_BEFORE_OUTPUT
    for /PLMU/IF_EX_FRW_APPCC_OVP~AFTER_PROCESS_BEFORE_OUTPUT .
  aliases AFTER_PROCESS_EVENT
    for /PLMU/IF_EX_FRW_APPCC_OVP~AFTER_PROCESS_EVENT .
  aliases AFTER_SAVE
    for /PLMU/IF_EX_FRW_APPCC_OVP~AFTER_SAVE .
  aliases ANALYZE_CHANGES_BY_CHG_POINTER
    for IF_DRF_OUTBOUND~ANALYZE_CHANGES_BY_CHG_POINTER .
  aliases ANALYZE_CHANGES_BY_MDG_CP
    for IF_DRF_OUTBOUND~ANALYZE_CHANGES_BY_MDG_CP .
  aliases ANALYZE_CHANGES_BY_OTHERS
    for IF_DRF_OUTBOUND~ANALYZE_CHANGES_BY_OTHERS .
  aliases APPLY_FILTER
    for IF_DRF_FILTER~APPLY_FILTER .
  aliases APPLY_NODE_INST_FILTER_MULTI
    for IF_DRF_OUTBOUND~APPLY_NODE_INST_FILTER_MULTI .
  aliases APPLY_NODE_INST_FILTER_SINGLE
    for IF_DRF_OUTBOUND~APPLY_NODE_INST_FILTER_SINGLE .
  aliases BUILD_PARALLEL_PACKAGE
    for IF_DRF_OUTBOUND~BUILD_PARALLEL_PACKAGE .
  aliases CALL_SYSTEM_METHOD
    for IF_USMD_SSW_SYST_METHOD_CALLER~CALL_SYSTEM_METHOD .
  aliases CANCEL_EVENT
    for IF_FPM_OVP~CANCEL_EVENT .
  aliases CHANGE_APPLICATION_PARAMETERS
    for IF_FPM_OVP~CHANGE_APPLICATION_PARAMETERS .
  aliases CHANGE_CONTENT_AREA
    for IF_FPM_OVP~CHANGE_CONTENT_AREA .
  aliases CHANGE_DEFAULT_ACTION
    for IF_FPM_OVP~CHANGE_DEFAULT_ACTION .
  aliases CHANGE_EXTERNAL_NAVIGATION
    for IF_FPM_OVP~CHANGE_EXTERNAL_NAVIGATION .
  aliases CHANGE_PAGE_HEADER_AREA
    for IF_FPM_OVP~CHANGE_PAGE_HEADER_AREA .
  aliases CHANGE_PAGE_HEADER_UIBB
    for IF_FPM_OVP~CHANGE_PAGE_HEADER_UIBB .
  aliases CHANGE_PAGE_MASTER_AREA
    for IF_FPM_OVP~CHANGE_PAGE_MASTER_AREA .
  aliases CHANGE_PAGE_MASTER_UIBB
    for IF_FPM_OVP~CHANGE_PAGE_MASTER_UIBB .
  aliases CHANGE_PAGE_SELECTOR
    for IF_FPM_OVP~CHANGE_PAGE_SELECTOR .
  aliases CHANGE_SECTION
    for IF_FPM_OVP~CHANGE_SECTION .
  aliases CHANGE_TOOLBAR_BUTTON
    for IF_FPM_OVP~CHANGE_TOOLBAR_BUTTON .
  aliases CHANGE_TOOLBAR_BUTTON_CHOICE
    for IF_FPM_OVP~CHANGE_TOOLBAR_BUTTON_CHOICE .
  aliases CHANGE_TOOLBAR_DROP_DOWN_LIST
    for IF_FPM_OVP~CHANGE_TOOLBAR_DROP_DOWN_LIST .
  aliases CHANGE_TOOLBAR_TOGGLE_BUTTON
    for IF_FPM_OVP~CHANGE_TOOLBAR_TOGGLE_BUTTON .
  aliases CHANGE_UIBB
    for IF_FPM_OVP~CHANGE_UIBB .
  aliases CHANGE_UIBB_SELECTOR
    for IF_FPM_OVP~CHANGE_UIBB_SELECTOR .
  aliases CHECK
    for IF_EX_USMD_CR_OBJECT_LIST~CHECK .
  aliases CHECK_AGENT_TABLES
    for IF_USMD_SSW_RULE_CHK_AGENT_TAB~CHECK_AGENT_TABLES .
  aliases CHECK_AUTHORITY
    for IF_USMD_PP_ACCESS~CHECK_AUTHORITY .
  aliases CHECK_AUTHORITY_MASS
    for IF_USMD_PP_ACCESS~CHECK_AUTHORITY_MASS .
  aliases CHECK_CREQUEST
    for IF_EX_USMD_RULE_SERVICE~CHECK_CREQUEST .
  aliases CHECK_CREQUEST_FINAL
    for IF_EX_USMD_RULE_SERVICE~CHECK_CREQUEST_FINAL .
  aliases CHECK_CREQUEST_HIERARCHY
    for IF_EX_USMD_RULE_SERVICE~CHECK_CREQUEST_HIERARCHY .
  aliases CHECK_CREQUEST_START
    for IF_EX_USMD_RULE_SERVICE~CHECK_CREQUEST_START .
  aliases CHECK_CREQUEST_SUBMIT_FOR_NOTE
    for IF_EX_USMD_CREQUEST_INTEGR~CHECK_CREQUEST_SUBMIT_FOR_NOTE .
  aliases CHECK_DATA
    for IF_USMD_PP_ACCESS~CHECK_DATA .
  aliases CHECK_EDITION
    for IF_EX_USMD_RULE_SERVICE~CHECK_EDITION .
  aliases CHECK_EDITION_FINAL
    for IF_EX_USMD_RULE_SERVICE~CHECK_EDITION_FINAL .
  aliases CHECK_EDITION_HIERARCHY
    for IF_EX_USMD_RULE_SERVICE~CHECK_EDITION_HIERARCHY .
  aliases CHECK_EDITION_START
    for IF_EX_USMD_RULE_SERVICE~CHECK_EDITION_START .
  aliases CHECK_ENTITY
    for IF_EX_USMD_RULE_SERVICE~CHECK_ENTITY .
  aliases CHECK_ENTITY_HIERARCHY
    for IF_EX_USMD_RULE_SERVICE~CHECK_ENTITY_HIERARCHY .
  aliases CHECK_EXISTENCE_MASS
    for IF_USMD_PP_ACCESS~CHECK_EXISTENCE_MASS .
  aliases CLEAR_FILTER_CRITERIA
    for IF_MDG_DQR_DQ_SERVICE~CLEAR_FILTER_CRITERIA .
  aliases CONVERT
    for IF_EX_USMD_DATA_TRANSFER_UPL~CONVERT .
  aliases CONVERT_ACTION_RESULT
    for IF_USMD_ENRICHMENT_FEEDER~CONVERT_ACTION_RESULT .
  aliases CREQUEST_CLEANUP
    for IF_EX_USMD_CREQUEST_CLEANUP~CREQUEST_CLEANUP .
  aliases DELTA_DATA_LOAD
    for IF_BADI_SDQ_PP_INITIAL_LOAD_ES~DELTA_DATA_LOAD .
  aliases DEQUEUE
    for IF_USMD_PP_ACCESS~DEQUEUE .
  aliases DERIVE
    for IF_EX_USMD_RULE_SERVICE2~DERIVE .
  aliases DERIVE_DATA
    for IF_USMD_PP_ACCESS~DERIVE_DATA .
  aliases DERIVE_DATA_ON_KEY_CHANGE
    for IF_USMD_PP_ACCESS~DERIVE_DATA_ON_KEY_CHANGE .
  aliases DERIVE_DATA_ON_SUBMIT
    for IF_EX_MDG_GW_FIORI_DERIVATIONS~DERIVE_DATA_ON_SUBMIT .
  aliases DERIVE_ENTITY
    for IF_EX_USMD_RULE_SERVICE~DERIVE_ENTITY .
  aliases DISABLE_NAVIGATION
    for IF_EX_USMD_ENTITY_UI~DISABLE_NAVIGATION .
  aliases DISCARD_READ_BUFFER
    for IF_USMD_PP_ACCESS~DISCARD_READ_BUFFER .
  aliases ENQUEUE
    for IF_USMD_PP_ACCESS~ENQUEUE .
  aliases ENRICH_FILTER_CRITERIA
    for IF_DRF_OUTBOUND~ENRICH_FILTER_CRITERIA .
  aliases EXECUTE
    for IF_USMD_ENRICHMENT_ADAPTER~EXECUTE .
  aliases FILTER_BDCPV_BEFORE_WRITE
    for IF_EX_BDCP_BEFORE_WRITE~FILTER_BDCPV_BEFORE_WRITE .
  aliases FILTER_COMPONENT
    for IF_EX_USMD_ENTITY_UI~FILTER_COMPONENT .
  aliases FILTER_CREQUEST_TYPE
    for IF_EX_USMD_CREQUEST_INTEGR~FILTER_CREQUEST_TYPE .
  aliases FILTER_EDITION
    for IF_MDG_DQR_DQ_SERVICE~FILTER_EDITION .
  aliases FINALIZE
    for IF_DRF_OUTBOUND~FINALIZE .
  aliases FLUSH
    for /PLMU/IF_EX_FRW_APPCC_OVP~FLUSH .
  aliases GET_ACA_API
    for IF_FPM_OVP~GET_ACA_API .
  aliases GET_ADAPTER_DATA
    for IF_USMD_ENRICHMENT_FEEDER~GET_ADAPTER_DATA .
  aliases GET_ADDITIONAL_KEYS
    for IF_USMD_ENRICHMENT_FEEDER~GET_ADDITIONAL_KEYS .
  aliases GET_APPLICATION_PARAMETERS
    for IF_FPM_OVP~GET_APPLICATION_PARAMETERS .
  aliases GET_BLOCKLIST_FOR_READ
    for IF_USMD_PP_BLOCKLIST~GET_BLOCKLIST_FOR_READ .
  aliases GET_BLOCKLIST_FOR_WRITE
    for IF_USMD_PP_BLOCKLIST~GET_BLOCKLIST_FOR_WRITE .
  aliases GET_CHANGE_DOCUMENT
    for IF_USMD_PP_ACCESS~GET_CHANGE_DOCUMENT .
  aliases GET_CONFIGURATION_FIELDS
    for IF_EX_MDG_FILECONVERTER~GET_CONFIGURATION_FIELDS .
  aliases GET_CONTENT_AREAS
    for IF_FPM_OVP~GET_CONTENT_AREAS .
  aliases GET_CONTENT_AREA_PERS
    for IF_FPM_OVP~GET_CONTENT_AREA_PERS .
  aliases GET_CREQUEST_ATTRIBUTES
    for IF_EX_USMD_CREQUEST_INTEGR~GET_CREQUEST_ATTRIBUTES .
  aliases GET_CREQUEST_FLD_PROP
    for IF_EX_USMD_CREQUEST_INTEGR~GET_CREQUEST_FLD_PROP .
  aliases GET_CURRENT_CONTENT_AREA
    for IF_FPM_OVP~GET_CURRENT_CONTENT_AREA .
  aliases GET_CURRENT_UI_DATA
    for IF_USMD_ENRICHMENT_FEEDER~GET_CURRENT_UI_DATA .
  aliases GET_DATA
    for IF_EX_MDG_FILECONVERTER~GET_DATA .
  aliases GET_DEFAULT_ACTION
    for IF_FPM_OVP~GET_DEFAULT_ACTION .
  aliases GET_DUP_CHECK_ATTR
    for IF_USMD_SEARCH_DATA~GET_DUP_CHECK_ATTR .
  aliases GET_DYNAMIC_AGENTS
    for IF_USMD_SSW_DYNAMIC_AGT_SELECT~GET_DYNAMIC_AGENTS .
  aliases GET_ENTITY_PROPERTIES
    for IF_USMD_PP_ACCESS~GET_ENTITY_PROPERTIES .
  aliases GET_EVENT
    for IF_FPM_OVP~GET_EVENT .
  aliases GET_EXPORT_TYPES
    for IF_MDG_EXTR_BADI~GET_EXPORT_TYPES .
  aliases GET_EXTERNAL_NAVIGATIONS
    for IF_FPM_OVP~GET_EXTERNAL_NAVIGATIONS .
  aliases GET_FAILED_RECORDS
    for IF_MDG_DQR_DQ_SERVICE~GET_FAILED_RECORDS .
  aliases GET_FIELD_PROPERTIES
    for IF_USMD_PP_ACCESS~GET_FIELD_PROPERTIES .
  aliases GET_FILTER_CRITERIA
    for IF_MDG_DQR_DQ_SERVICE~GET_FILTER_CRITERIA .
  aliases GET_FILTER_METADATA
    for IF_MDG_DQR_DQ_SERVICE~GET_FILTER_METADATA .
  aliases GET_GROUP_FIELDS
    for IF_MDG_EXTR_BADI~GET_GROUP_FIELDS .
  aliases GET_HRY_ATTR_DEFAULT_VALUES
    for IF_EX_USMD_ENTITY_UI~GET_HRY_ATTR_DEFAULT_VALUES .
  aliases GET_KEY_HANDLING
    for IF_USMD_PP_ACCESS~GET_KEY_HANDLING .
  aliases GET_KM_INFO_FROM_AUDIT_IDOC
    for IF_DRF_ALE_AUDIT_GET_KM_DATA~GET_KM_INFO_FROM_AUDIT_IDOC .
  aliases GET_MAPPING_CD
    for IF_USMD_PP_ACCESS~GET_MAPPING_CD .
  aliases GET_MAPPING_INFO
    for IF_USMD_PP_HANA_SEARCH~GET_MAPPING_INFO .
  aliases GET_MDG_DATA
    for IF_USMD_ENRICHMENT_FEEDER~GET_MDG_DATA .
  aliases GET_MDT
    for IF_EX_MDG_FILECONVERTER~GET_MDT .
  aliases GET_OBJECTS
    for IF_MDG_EXTR_BADI~GET_OBJECTS .
  aliases GET_PAGE_HEADER_AREA
    for IF_FPM_OVP~GET_PAGE_HEADER_AREA .
  aliases GET_PAGE_HEADER_UIBBS
    for IF_FPM_OVP~GET_PAGE_HEADER_UIBBS .
  aliases GET_PAGE_MASTER_AREA
    for IF_FPM_OVP~GET_PAGE_MASTER_AREA .
  aliases GET_PAGE_MASTER_AREA_PERS
    for IF_FPM_OVP~GET_PAGE_MASTER_AREA_PERS .
  aliases GET_PAGE_MASTER_UIBBS
    for IF_FPM_OVP~GET_PAGE_MASTER_UIBBS .
  aliases GET_PAGE_SELECTOR
    for IF_FPM_OVP~GET_PAGE_SELECTOR .
  aliases GET_POSITION_OF_UIBB
    for IF_FPM_OVP~GET_POSITION_OF_UIBB .
  aliases GET_PROXY_CLASS
    for IF_MDG_EXTR_BADI~GET_PROXY_CLASS .
  aliases GET_QUERY_PROPERTIES
    for IF_USMD_PP_ACCESS~GET_QUERY_PROPERTIES .
  aliases GET_RELEVANT_ENTITIES
    for IF_USMD_ENRICHMENT_FEEDER~GET_RELEVANT_ENTITIES .
  aliases GET_REUSE_VIEW_CONTENT
    for IF_USMD_PP_HANA_SEARCH~GET_REUSE_VIEW_CONTENT .
  aliases GET_SEARCH_ATTR
    for IF_USMD_SEARCH_DATA~GET_SEARCH_ATTR .
  aliases GET_SECTIONS
    for IF_FPM_OVP~GET_SECTIONS .
  aliases GET_SECTION_PERS
    for IF_FPM_OVP~GET_SECTION_PERS .
  aliases GET_SELECTION_TABLES
    for IF_MDG_EXTR_BADI~GET_SELECTION_TABLES .
  aliases GET_SEL_FIELDS
    for IF_MDG_EXTR_BADI~GET_SEL_FIELDS .
  aliases GET_TARGET_CONTENT_AREA
    for IF_FPM_OVP~GET_TARGET_CONTENT_AREA .
  aliases GET_TEXT_ATTRIBUTE
    for IF_EX_USMD_GENERIC_GENIL_TEXT~GET_TEXT_ATTRIBUTE .
  aliases GET_TEXT_VALUES_4_ATTRIBUTE
    for IF_EX_USMD_GENERIC_GENIL_TEXT~GET_TEXT_VALUES_4_ATTRIBUTE .
  aliases GET_TOOLBAR_BUTTON
    for IF_FPM_OVP~GET_TOOLBAR_BUTTON .
  aliases GET_TOOLBAR_BUTTON_CHOICE
    for IF_FPM_OVP~GET_TOOLBAR_BUTTON_CHOICE .
  aliases GET_TOOLBAR_DROP_DOWN_LIST
    for IF_FPM_OVP~GET_TOOLBAR_DROP_DOWN_LIST .
  aliases GET_TOOLBAR_ELEMENTS
    for IF_FPM_OVP~GET_TOOLBAR_ELEMENTS .
  aliases GET_TOOLBAR_TOGGLE_BUTTON
    for IF_FPM_OVP~GET_TOOLBAR_TOGGLE_BUTTON .
  aliases GET_UIBBS
    for IF_FPM_OVP~GET_UIBBS .
  aliases GET_UIBB_PERS
    for IF_FPM_OVP~GET_UIBB_PERS .
  aliases GET_UIBB_SELECTOR
    for IF_FPM_OVP~GET_UIBB_SELECTOR .
  aliases GET_WHERE_USED_LIST
    for IF_EX_USMD_REMOTE_WHERE_USED~GET_WHERE_USED_LIST .
  aliases GET_WIRES
    for IF_FPM_OVP~GET_WIRES .
  aliases HANDLE_PARALLEL_RESULT
    for IF_USMD_SSW_PARA_RSLT_HANDLER~HANDLE_PARALLEL_RESULT .
  aliases HANDLE_WD_EVENT
    for IF_MDG_DQR_EVENT_HANDLER~HANDLE_WD_EVENT .
  aliases INITIALIZATION
    for /PLMU/IF_EX_FRW_APPCC_OVP~INITIALIZATION .
  aliases INITIALIZE
    for IF_DRF_OUTBOUND~INITIALIZE .
  aliases INITIALIZE_SELECTION
    for IF_MDG_EXTR_BADI~INITIALIZE_SELECTION .
  aliases INITIAL_DATA_LOAD
    for IF_BADI_SDQ_PP_INITIAL_LOAD_ES~INITIAL_DATA_LOAD .
  aliases INIT_TABLE
    for IF_EX_USMD_MODEL_ACTIVATION~INIT_TABLE .
  aliases IS_EVENT_CANCELLED
    for IF_FPM_OVP~IS_EVENT_CANCELLED .
  aliases IS_FIELD_PROP_HIDDEN_SUPPORTED
    for IF_EX_USMD_ACC_FLD_PROP_CDS~IS_FIELD_PROP_HIDDEN_SUPPORTED .
  aliases IS_RELEVANT
    for IF_USMD_ENRICHMENT_FEEDER~IS_RELEVANT .
  aliases LOAD_DATA
    for IF_EX_MDG_GW_FIORI_DERIVATIONS~LOAD_DATA .
  aliases MAP_DATA2MESSAGE
    for IF_DRF_OUTBOUND~MAP_DATA2MESSAGE .
  aliases MERGE_REUSE_AUTHORIZATION
    for IF_USMD_PP_HANA_SEARCH~MERGE_REUSE_AUTHORIZATION .
  aliases MODIFY_ENTITY_PROPERTIES
    for IF_EX_USMD_ACC_FLD_PROP_CDS~MODIFY_ENTITY_PROPERTIES .
  aliases MODIFY_FLD_PROP_ATTR
    for IF_EX_USMD_ACC_FLD_PROP_CDS~MODIFY_FLD_PROP_ATTR .
  aliases NEEDS_CONFIRMATION
    for /PLMU/IF_EX_FRW_APPCC_OVP~NEEDS_CONFIRMATION .
  aliases OVERRIDE_CONFIG_TABBED
    for /PLMU/IF_EX_FRW_APPCC_OVP~OVERRIDE_CONFIG_TABBED .
  aliases OVERRIDE_EVENT_OVP
    for /PLMU/IF_EX_FRW_APPCC_OVP~OVERRIDE_EVENT_OVP .
  aliases PACKAGING_ALLOWED
    for IF_MDG_EXTR_BADI~PACKAGING_ALLOWED .
  aliases POSTPROCESSING
    for IF_EX_USMD_MODEL_ACTIVATION~POSTPROCESSING .
  aliases PREPARE_RULE_CONTEXT
    for IF_USMD_SSW_RULE_CNTX_PREPARE~PREPARE_RULE_CONTEXT .
  aliases PREPARE_UI_DATA
    for IF_USMD_ENRICHMENT_FEEDER~PREPARE_UI_DATA .
  aliases PROCESS_BEFORE_OUTPUT
    for /PLMU/IF_EX_FRW_APPCC_OVP~PROCESS_BEFORE_OUTPUT .
  aliases PROCESS_EVENT
    for /PLMU/IF_EX_FRW_APPCC_OVP~PROCESS_EVENT .
  aliases QUERY
    for IF_USMD_PP_ACCESS~QUERY .
  aliases READ_COMPLETE_DATA
    for IF_DRF_OUTBOUND~READ_COMPLETE_DATA .
  aliases READ_VALUE
    for IF_USMD_PP_ACCESS~READ_VALUE .
  aliases REMOVE_CONTENT_AREA
    for IF_FPM_OVP~REMOVE_CONTENT_AREA .
  aliases REMOVE_DEFAULT_ACTION
    for IF_FPM_OVP~REMOVE_DEFAULT_ACTION .
  aliases REMOVE_EXTERNAL_NAVIGATION
    for IF_FPM_OVP~REMOVE_EXTERNAL_NAVIGATION .
  aliases REMOVE_PAGE_HEADER_AREA
    for IF_FPM_OVP~REMOVE_PAGE_HEADER_AREA .
  aliases REMOVE_PAGE_HEADER_UIBB
    for IF_FPM_OVP~REMOVE_PAGE_HEADER_UIBB .
  aliases REMOVE_PAGE_MASTER_AREA
    for IF_FPM_OVP~REMOVE_PAGE_MASTER_AREA .
  aliases REMOVE_PAGE_MASTER_UIBB
    for IF_FPM_OVP~REMOVE_PAGE_MASTER_UIBB .
  aliases REMOVE_SECTION
    for IF_FPM_OVP~REMOVE_SECTION .
  aliases REMOVE_TOOLBAR_ELEMENT
    for IF_FPM_OVP~REMOVE_TOOLBAR_ELEMENT .
  aliases REMOVE_UIBB
    for IF_FPM_OVP~REMOVE_UIBB .
  aliases REMOVE_WIRE
    for IF_FPM_OVP~REMOVE_WIRE .
  aliases REQUEST_FOCUS_ON_FIRST_FIELD
    for IF_FPM_OVP~REQUEST_FOCUS_ON_FIRST_FIELD .
  aliases REQUEST_FOCUS_ON_FIRST_TB_ELEM
    for IF_FPM_OVP~REQUEST_FOCUS_ON_FIRST_TB_ELEM .
  aliases REQUEST_FOCUS_ON_PAGE_HEADER
    for IF_FPM_OVP~REQUEST_FOCUS_ON_PAGE_HEADER .
  aliases REQUEST_FOCUS_ON_STD_FUNC
    for IF_FPM_OVP~REQUEST_FOCUS_ON_STD_FUNC .
  aliases REQUEST_FOCUS_ON_TB_ELEM
    for IF_FPM_OVP~REQUEST_FOCUS_ON_TB_ELEM .
  aliases REQUEST_FOCUS_ON_UIBB
    for IF_FPM_OVP~REQUEST_FOCUS_ON_UIBB .
  aliases SEARCH_PP
    for IF_BADI_SDQ_PP_SEARCH~SEARCH_PP .
  aliases SELECT_OBJECTS
    for IF_MDG_EXTR_BADI~SELECT_OBJECTS .
  aliases SEND_MESSAGE
    for IF_DRF_OUTBOUND~SEND_MESSAGE .
  aliases SET_CONFIGURATION
    for IF_EX_MDG_FILECONVERTER~SET_CONFIGURATION .
  aliases SET_CONFIGURATION_FIELDS
    for IF_EX_MDG_FILECONVERTER~SET_CONFIGURATION_FIELDS .
  aliases SET_CREQUEST_ATTRIBUTES
    for IF_MDG_DQR_DQ_SERVICE~SET_CREQUEST_ATTRIBUTES .
  aliases SET_DQS_ID
    for IF_MDG_DQR_DQ_SERVICE~SET_DQS_ID .
  aliases SET_EVENT
    for IF_FPM_OVP~SET_EVENT .
  aliases SET_FILTER_CRITERIA
    for IF_MDG_DQR_DQ_SERVICE~SET_FILTER_CRITERIA .
  aliases SET_GENERIC_BUTTON_ACTION_TYPE
    for IF_FPM_OVP~SET_GENERIC_BUTTON_ACTION_TYPE .
  aliases TABLE_CONVERSION
    for IF_EX_USMD_MODEL_ACTIVATION~TABLE_CONVERSION .
  aliases UPDATE_EVENT
    for IF_EX_USMD_TRANSACTION_EVENTS~UPDATE_EVENT .
  aliases CHANGED
    for IF_FPM_WIRE_MODEL~CHANGED .
  aliases INITIALIZED
    for IF_FPM_WIRE_MODEL~INITIALIZED .
  aliases GTYS_RANGE_ROW
    for IF_EX_MDG_FILECONVERTER~GTYS_RANGE_ROW .
  aliases GTYT_RANGE
    for IF_EX_MDG_FILECONVERTER~GTYT_RANGE .
  aliases GTY_ACTION
    for IF_EX_USMD_CREQUEST_CLEANUP~GTY_ACTION .
  aliases KEY_HANDLING
    for IF_USMD_PP_ACCESS~KEY_HANDLING .
  aliases S_TMP_KEY_MAP
    for IF_USMD_PP_ACCESS~S_TMP_KEY_MAP .
  aliases TABL_KIND
    for IF_EX_USMD_MODEL_ACTIVATION~TABL_KIND .
  aliases TS_TMP_KEY_MAP
    for IF_USMD_PP_ACCESS~TS_TMP_KEY_MAP .
  aliases TY_CHANGE_TYPE
    for IF_FPM_WIRE_MODEL~TY_CHANGE_TYPE .
  aliases TY_S_APPLICATION_PARAMETERS
    for IF_FPM_OVP~TY_S_APPLICATION_PARAMETERS .
  aliases TY_S_COLUMN_LAYOUT
    for IF_FPM_OVP~TY_S_COLUMN_LAYOUT .
  aliases TY_S_COLUMN_LAYOUT_PERS
    for IF_FPM_OVP~TY_S_COLUMN_LAYOUT_PERS .
  aliases TY_S_CONTENT_AREA
    for IF_FPM_OVP~TY_S_CONTENT_AREA .
  aliases TY_S_CONTENT_AREA_PERS
    for IF_FPM_OVP~TY_S_CONTENT_AREA_PERS .
  aliases TY_S_DEFAULT_ACTION
    for IF_FPM_OVP~TY_S_DEFAULT_ACTION .
  aliases TY_S_EXT_NAVIGATION
    for IF_FPM_OVP~TY_S_EXT_NAVIGATION .
  aliases TY_S_PAGE_HEADER_AREA
    for IF_FPM_OVP~TY_S_PAGE_HEADER_AREA .
  aliases TY_S_PAGE_HEADER_UIBB
    for IF_FPM_OVP~TY_S_PAGE_HEADER_UIBB .
  aliases TY_S_PAGE_MASTER_AREA
    for IF_FPM_OVP~TY_S_PAGE_MASTER_AREA .
  aliases TY_S_PAGE_MASTER_AREA_PERS
    for IF_FPM_OVP~TY_S_PAGE_MASTER_AREA_PERS .
  aliases TY_S_PAGE_MASTER_UIBB
    for IF_FPM_OVP~TY_S_PAGE_MASTER_UIBB .
  aliases TY_S_PAGE_SELECTOR_ITEM
    for IF_FPM_OVP~TY_S_PAGE_SELECTOR_ITEM .
  aliases TY_S_SECTION
    for IF_FPM_OVP~TY_S_SECTION .
  aliases TY_S_SECTION_PERS
    for IF_FPM_OVP~TY_S_SECTION_PERS .
  aliases TY_S_TOOLBAR_BUTTON
    for IF_FPM_OVP~TY_S_TOOLBAR_BUTTON .
  aliases TY_S_TOOLBAR_BUTTON_CHOICE
    for IF_FPM_OVP~TY_S_TOOLBAR_BUTTON_CHOICE .
  aliases TY_S_TOOLBAR_DROP_DOWN
    for IF_FPM_OVP~TY_S_TOOLBAR_DROP_DOWN .
  aliases TY_S_TOOLBAR_DROP_DOWN_ITEM
    for IF_FPM_OVP~TY_S_TOOLBAR_DROP_DOWN_ITEM .
  aliases TY_S_TOOLBAR_ELEMENT
    for IF_FPM_OVP~TY_S_TOOLBAR_ELEMENT .
  aliases TY_S_TOOLBAR_ELEMENT_SUB_ITEM
    for IF_FPM_OVP~TY_S_TOOLBAR_ELEMENT_SUB_ITEM .
  aliases TY_S_TOOLBAR_TOGGLE_BUTTON
    for IF_FPM_OVP~TY_S_TOOLBAR_TOGGLE_BUTTON .
  aliases TY_S_UIBB
    for IF_FPM_OVP~TY_S_UIBB .
  aliases TY_S_UIBB_KEY
    for IF_FPM_OVP~TY_S_UIBB_KEY .
  aliases TY_S_UIBB_PERS
    for IF_FPM_OVP~TY_S_UIBB_PERS .
  aliases TY_S_UIBB_SELECTOR_ITEM
    for IF_FPM_OVP~TY_S_UIBB_SELECTOR_ITEM .
  aliases TY_S_WIRE
    for IF_FPM_WIRE_MODEL~TY_S_WIRE .
  aliases TY_S_WIRE_CHANGE
    for IF_FPM_WIRE_MODEL~TY_S_WIRE_CHANGE .
  aliases TY_S_WIRE_DATA
    for IF_FPM_WIRE_MODEL~TY_S_WIRE_DATA .
  aliases TY_T_COLUMN_LAYOUT
    for IF_FPM_OVP~TY_T_COLUMN_LAYOUT .
  aliases TY_T_COLUMN_LAYOUT_PERS
    for IF_FPM_OVP~TY_T_COLUMN_LAYOUT_PERS .
  aliases TY_T_CONTENT_AREA
    for IF_FPM_OVP~TY_T_CONTENT_AREA .
  aliases TY_T_CONTENT_AREA_PERS
    for IF_FPM_OVP~TY_T_CONTENT_AREA_PERS .
  aliases TY_T_EXT_NAVIGATION
    for IF_FPM_OVP~TY_T_EXT_NAVIGATION .
  aliases TY_T_PAGE_HEADER_AREA
    for IF_FPM_OVP~TY_T_PAGE_HEADER_AREA .
  aliases TY_T_PAGE_HEADER_UIBB
    for IF_FPM_OVP~TY_T_PAGE_HEADER_UIBB .
  aliases TY_T_PAGE_MASTER_AREA
    for IF_FPM_OVP~TY_T_PAGE_MASTER_AREA .
  aliases TY_T_PAGE_MASTER_AREA_PERS
    for IF_FPM_OVP~TY_T_PAGE_MASTER_AREA_PERS .
  aliases TY_T_PAGE_MASTER_UIBB
    for IF_FPM_OVP~TY_T_PAGE_MASTER_UIBB .
  aliases TY_T_PAGE_SELECTOR_ITEM
    for IF_FPM_OVP~TY_T_PAGE_SELECTOR_ITEM .
  aliases TY_T_SECTION
    for IF_FPM_OVP~TY_T_SECTION .
  aliases TY_T_SECTION_PERS
    for IF_FPM_OVP~TY_T_SECTION_PERS .
  aliases TY_T_TOOLBAR_BUTTON
    for IF_FPM_OVP~TY_T_TOOLBAR_BUTTON .
  aliases TY_T_TOOLBAR_BUTTON_CHOICE
    for IF_FPM_OVP~TY_T_TOOLBAR_BUTTON_CHOICE .
  aliases TY_T_TOOLBAR_DROP_DOWN
    for IF_FPM_OVP~TY_T_TOOLBAR_DROP_DOWN .
  aliases TY_T_TOOLBAR_DROP_DOWN_ITEM
    for IF_FPM_OVP~TY_T_TOOLBAR_DROP_DOWN_ITEM .
  aliases TY_T_TOOLBAR_ELEMENT
    for IF_FPM_OVP~TY_T_TOOLBAR_ELEMENT .
  aliases TY_T_TOOLBAR_ELEMENT_SUB_ITEM
    for IF_FPM_OVP~TY_T_TOOLBAR_ELEMENT_SUB_ITEM .
  aliases TY_T_TOOLBAR_TOGGLE_BUTTON
    for IF_FPM_OVP~TY_T_TOOLBAR_TOGGLE_BUTTON .
  aliases TY_T_UIBB
    for IF_FPM_OVP~TY_T_UIBB .
  aliases TY_T_UIBB_KEY
    for IF_FPM_OVP~TY_T_UIBB_KEY .
  aliases TY_T_UIBB_PERS
    for IF_FPM_OVP~TY_T_UIBB_PERS .
  aliases TY_T_UIBB_SELECTOR_ITEM
    for IF_FPM_OVP~TY_T_UIBB_SELECTOR_ITEM .
  aliases TY_T_WIRE
    for IF_FPM_WIRE_MODEL~TY_T_WIRE .

  class-methods EXECUTE_HIDE_UIBB_RULES
    importing
      !IV_MODEL type USMD_MODEL
      !IV_CREQUEST type USMD_CREQUEST
      !IO_OVP type ref to IF_FPM_OVP .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS YZ_CLAS_MDG_EVENT_PROCESS IMPLEMENTATION.


  METHOD /plmu/if_ex_frw_appcc_ovp~after_after_failed_event.
  ENDMETHOD.


  METHOD /plmu/if_ex_frw_appcc_ovp~after_failed_event.
  ENDMETHOD.


  METHOD /plmu/if_ex_frw_appcc_ovp~after_process_event.
  ENDMETHOD.


  METHOD /plmu/if_ex_frw_appcc_ovp~flush.
    RETURN.
  ENDMETHOD.


  METHOD /plmu/if_ex_frw_appcc_ovp~initialization.
    RETURN.
  ENDMETHOD.


  METHOD /plmu/if_ex_frw_appcc_ovp~needs_confirmation.
  ENDMETHOD.


  METHOD /plmu/if_ex_frw_appcc_ovp~override_event_ovp.
    CHECK get_cr_number( ) IS NOT INITIAL.
    DATA(my) = yz_clas_mdg_accelerator=>get_accl_service( iv_model = get_data_model( )
                                                          is_app_context = VALUE #( rule_type = gc_execute_hideuibb o_ovp = io_ovp ) ).
    IF my IS BOUND.
      my->execute_business_rules( ip_app_context = VALUE #( rule_type = gc_execute_hideuibb o_ovp = io_ovp ) ).
    ENDIF.
  ENDMETHOD.


  METHOD /plmu/if_ex_frw_appcc_ovp~process_event.
  ENDMETHOD.


  METHOD if_badi_sdq_pp_initial_load_es~delta_data_load.
  ENDMETHOD.


  METHOD if_badi_sdq_pp_initial_load_es~initial_data_load.
  ENDMETHOD.


  METHOD if_badi_sdq_pp_search~search_pp.

*    DATA(lv_messge) = 'Event Triggered :' && get_current_event( ) && | | && 'Method:' &&  'IF_BADI_SDQ_PP_SEARCH~SEARCH_PP'.
*    create_application_log( is_message        = CONV char100( lv_messge )                " Character 100
*                            iv_exe_type = yz_intf_mdg_accelerator_const=>gc_process_type_badi_trace                " Process Type
*                            iv_model          = iv_data_model ).
  ENDMETHOD.


  METHOD if_drf_filter~apply_filter.

  ENDMETHOD.


  METHOD if_drf_outbound~analyze_changes_by_chg_pointer.

  ENDMETHOD.


  METHOD if_drf_outbound~analyze_changes_by_mdg_cp.

  ENDMETHOD.


  METHOD if_drf_outbound~analyze_changes_by_others.

  ENDMETHOD.


  METHOD if_drf_outbound~apply_node_inst_filter_multi.

  ENDMETHOD.


  METHOD if_drf_outbound~apply_node_inst_filter_single.

  ENDMETHOD.


  METHOD if_drf_outbound~build_parallel_package.

  ENDMETHOD.


  METHOD if_drf_outbound~enrich_filter_criteria.

  ENDMETHOD.


  METHOD if_drf_outbound~finalize.

  ENDMETHOD.


  METHOD if_drf_outbound~initialize.

  ENDMETHOD.


  METHOD if_drf_outbound~map_data2message.

  ENDMETHOD.


  METHOD if_drf_outbound~read_complete_data.

  ENDMETHOD.


  METHOD if_drf_outbound~send_message.

  ENDMETHOD.


  METHOD if_ex_bdcp_before_write~filter_bdcpv_before_write.
*    DATA(lv_messge) = 'Event Triggered :' && get_current_event( ) && | | && 'Method:' &&  'IF_EX_BDCP_BEFORE_WRITE~FILTER_BDCPV_BEFORE_WRITE'.
**    me->create_application_log( is_message        = conv char100( lv_messge )                " Character 100
**                            iv_exe_type = yz_intf_mdg_accelerator_const=>gc_process_type_badi_trace ).

  ENDMETHOD.


  METHOD if_ex_mdg_fileconverter~get_configuration_fields.
*    DATA(lv_messge) = 'Event Triggered :' && get_current_event( ) && | | && 'Method:' &&  'IF_EX_MDG_FILECONVERTER~GET_CONFIGURATION_FIELDS'.
*    create_application_log( is_message        = CONV char100( lv_messge )                " Character 100
*                            iv_exe_type = yz_intf_mdg_accelerator_const=>gc_process_type_badi_trace ).
  ENDMETHOD.


  METHOD if_ex_mdg_fileconverter~get_data.
*    DATA(lv_messge) = 'Event Triggered :' && get_current_event( ) && | | && 'Method:' &&  'IF_EX_MDG_FILECONVERTER~GET_DATA'.
*    create_application_log( is_message        = CONV char100( lv_messge )                " Character 100
*                            iv_exe_type = yz_intf_mdg_accelerator_const=>gc_process_type_badi_trace ).
  ENDMETHOD.


  METHOD if_ex_mdg_fileconverter~get_mdt.
*    DATA(lv_messge) = 'Event Triggered :' && get_current_event( ) && | | && 'Method:' &&  'IF_EX_MDG_FILECONVERTER~GET_MDT'.
*    create_application_log( is_message        = CONV char100( lv_messge )                " Character 100
*                            iv_exe_type = yz_intf_mdg_accelerator_const=>gc_process_type_badi_trace ).
  ENDMETHOD.


  METHOD if_ex_mdg_fileconverter~set_configuration.
    DATA(lv_messge) = 'Event Triggered :' && get_current_event( ) && | | && 'Method:' &&  'IF_EX_MDG_FILECONVERTER~SET_CONFIGURATION'.
*    create_application_log( is_message        = CONV char100( lv_messge )                " Character 100
*                            iv_exe_type = yz_intf_mdg_accelerator_const=>gc_process_type_badi_trace ).
  ENDMETHOD.


  METHOD if_ex_mdg_fileconverter~set_configuration_fields.
    DATA(lv_messge) = 'Event Triggered :' && get_current_event( ) && | | && 'Method:' &&  'IF_EX_MDG_FILECONVERTER~SET_CONFIGURATION_FIELDS'.
*    create_application_log( is_message        = CONV char100( lv_messge )                " Character 100
*                            iv_exe_type = yz_intf_mdg_accelerator_const=>gc_process_type_badi_trace ).
  ENDMETHOD.


  METHOD if_ex_mdg_gw_fiori_derivations~derive_data_on_submit.
    DATA(lv_messge) = 'Event Triggered :' && get_current_event( ) && | | && 'Method:' &&  'IF_EX_MDG_GW_FIORI_DERIVATIONS~DERIVE_DATA_ON_SUBMIT'.
*    create_application_log( is_message        = CONV char100( lv_messge )                " Character 100
*                            iv_exe_type = yz_intf_mdg_accelerator_const=>gc_process_type_badi_trace  ).
  ENDMETHOD.


  METHOD if_ex_mdg_gw_fiori_derivations~load_data.
    DATA(lv_messge) = 'Event Triggered :'(001) && get_current_event( ) && | | && 'Method:'(002) &&  'IF_EX_MDG_GW_FIORI_DERIVATIONS~LOAD_DATA'(003).
*    create_application_log( is_message        = CONV char100( lv_messge )                " Character 100
*                            iv_exe_type = yz_intf_mdg_accelerator_const=>gc_process_type_badi_trace  ).
  ENDMETHOD.


  METHOD if_ex_usmd_acc_fld_prop_cds~is_field_prop_hidden_supported.
*    DATA(lv_messge) = 'Event Triggered :' && get_current_event( ) && | | && 'Method:' &&  'IF_EX_USMD_ACC_FLD_PROP_CDS~IS_FIELD_PROP_HIDDEN_SUPPORTED'.
*    create_application_log( is_message        = CONV char100( lv_messge )                " Character 100
*                            iv_exe_type = yz_intf_mdg_accelerator_const=>gc_process_type_badi_trace                " Process Type
*                            iv_model          = iv_model ).
  ENDMETHOD.


  METHOD if_ex_usmd_acc_fld_prop_cds~modify_entity_properties.
*    DATA(lv_messge) = 'Event Triggered :' && get_current_event( ) && | | && 'Method:' &&  'IF_EX_USMD_ACC_FLD_PROP_CDS~MODIFY_ENTITY_PROPERTIES'.
*    create_application_log( is_message        = CONV char100( lv_messge )                " Character 100
*                            iv_exe_type = yz_intf_mdg_accelerator_const=>gc_process_type_badi_trace                " Process Type
*                            iv_model          = get_data_model( ) ).
  ENDMETHOD.


  METHOD if_ex_usmd_acc_fld_prop_cds~modify_fld_prop_attr.

    DATA ls_flp_context TYPE yztabl_flp_context.

    CHECK iv_crequest IS NOT INITIAL.

    DATA(ls_app_context) = VALUE yztabl_application_context( rule_type = gc_execute_fldprop crequest = iv_crequest current_entity  = iv_entity  ).

    yz_clas_mdg_accelerator=>get_accl_service( iv_model       = get_data_model( iv_crequest )
                                               is_app_context = ls_app_context ).

    IF yz_clas_mdg_accelerator=>my IS BOUND.

      GET REFERENCE OF ct_fld_prop INTO ls_flp_context-fld_prop.

      yz_clas_mdg_accelerator=>my->execute_business_rules( CHANGING cp_flp_context = ls_flp_context ).

    ENDIF.

  ENDMETHOD.


  METHOD if_ex_usmd_crequest_cleanup~crequest_cleanup.
*    DATA(lv_messge) = 'Event Triggered :' && get_current_event( ) && | | && 'Method:' &&  'IF_EX_USMD_CREQUEST_CLEANUP~CREQUEST_CLEANUP'.
*    create_application_log( is_message        = CONV char100( lv_messge )                " Character 100
*                            iv_exe_type = yz_intf_mdg_accelerator_const=>gc_process_type_badi_trace                " Process Type
*                            iv_model          = get_data_model( crequest_id ) ).
*
*    DATA(lo_obj) = NEW cl_mdg_sdq_delete_de_link( ).
*
*    lo_obj->if_ex_usmd_crequest_cleanup~crequest_cleanup(
*      EXPORTING
*        crequest_id = crequest_id                 " Change Request
*        object_keys = object_keys                 " Keys of Entity Types in Change Request
*        action      = action                " Archiving or deletion
*      CHANGING
*        messages    =  messages                " Messages
*    ).
  ENDMETHOD.


  METHOD if_ex_usmd_crequest_integr~check_crequest_submit_for_note.
    DATA(lv_messge) = 'Event Triggered :' && get_current_event( ) && | | && 'Method:' &&  'IF_EX_USMD_CREQUEST_INTEGR~CHECK_CREQUEST_SUBMIT_FOR_NOTE'.
*    create_application_log( is_message        = CONV char100( lv_messge )                " Character 100
*                            iv_exe_type = yz_intf_mdg_accelerator_const=>gc_process_type_badi_trace                " Process Type
*                            iv_model          = get_data_model( iv_crequest_id ) ).
  ENDMETHOD.


  METHOD if_ex_usmd_crequest_integr~filter_crequest_type.
*    DATA(lv_messge) = 'Event Triggered :' && get_current_event( ) && | | && 'Method:' &&  'IF_EX_USMD_CREQUEST_INTEGR~FILTER_CREQUEST_TYPE'.
*    create_application_log( is_message        = CONV char100( lv_messge )                " Character 100
*                            iv_exe_type = yz_intf_mdg_accelerator_const=>gc_process_type_badi_trace                " Process Type
*                            iv_model          = iv_model ).
  ENDMETHOD.


  METHOD if_ex_usmd_crequest_integr~get_crequest_attributes.
*    DATA(lv_messge) = 'Event Triggered :' && get_current_event( ) && | | && 'Method:' &&  'IF_EX_USMD_CREQUEST_INTEGR~GET_CREQUEST_ATTRIBUTES'.
*    create_application_log( is_message        = CONV char100( lv_messge )                " Character 100
*                            iv_exe_type = yz_intf_mdg_accelerator_const=>gc_process_type_badi_trace                " Process Type
*                            iv_model          = iv_model ).

*data: lv_desc type USMD_TXTLG.
*
*lv_desc = 'Pricing master record creation'.
*cv_description = lv_desc.


  ENDMETHOD.


  METHOD if_ex_usmd_crequest_integr~get_crequest_fld_prop.
    DATA(lv_messge) = 'Event Triggered :' && get_current_event( ) && | | && 'Method:' &&  'IF_EX_USMD_CREQUEST_INTEGR~GET_CREQUEST_FLD_PROP'.
*    create_application_log( is_message        = CONV char100( lv_messge )                " Character 100
*                            iv_exe_type = yz_intf_mdg_accelerator_const=>gc_process_type_badi_trace                " Process Type
*                            iv_model          = iv_model ).
  ENDMETHOD.


  METHOD if_ex_usmd_generic_genil_text~get_text_attribute.
    DATA(lv_messge) = 'Event Triggered :' && get_current_event( ) && | | && 'Method:' &&  'IF_EX_USMD_GENERIC_GENIL_TEXT~GET_TEXT_ATTRIBUTE'.
*    create_application_log( is_message        = CONV char100( lv_messge )                " Character 100
*                            iv_exe_type = yz_intf_mdg_accelerator_const=>gc_process_type_badi_trace                " Process Type
*                            iv_model          = get_data_model( ) ).
  ENDMETHOD.


  METHOD if_ex_usmd_generic_genil_text~get_text_values_4_attribute.
    DATA(lv_messge) = 'Event Triggered :' && get_current_event( ) && | | && 'Method:' &&  'IF_EX_USMD_GENERIC_GENIL_TEXT~GET_TEXT_VALUES_4_ATTRIBUTE'.
*    create_application_log( is_message        = CONV char100( lv_messge )                " Character 100
*                            iv_exe_type = yz_intf_mdg_accelerator_const=>gc_process_type_badi_trace                " Process Type
*                            iv_model          = get_data_model( ) ).
  ENDMETHOD.


  METHOD if_ex_usmd_model_activation~init_table.

  ENDMETHOD.


  METHOD if_ex_usmd_model_activation~postprocessing.

  ENDMETHOD.


  METHOD if_ex_usmd_model_activation~table_conversion.

  ENDMETHOD.


  METHOD if_ex_usmd_rule_service2~derive.

    BREAK-POINT ID yz_acid_stepup_event_cpg.
    LOG-POINT   ID yz_acid_stepup_event_cpg
            SUBKEY sy-cprog
            FIELDS get_data_model( ) get_cr_number( ).

    is_my_obj_registered( ).

    IF io_changed_data IS BOUND.
      yz_clas_mdg_accelerator=>get_data_service( iv_model = get_data_model( ) ).
      IF yz_clas_mdg_accelerator=>data IS BOUND.
        yz_clas_mdg_accelerator=>data->set_entity_data( io_changed_data = io_changed_data ).
      ENDIF.

      io_changed_data->get_entity_types( IMPORTING et_entity_mod = DATA(lt_entity_mod) ).

      IF lt_entity_mod IS NOT INITIAL.

        LOOP AT lt_entity_mod INTO DATA(ls_entity_mod).
          IF ls_entity_mod-struct = gc_kattr.


          DATA(ls_app_context) = VALUE yztabl_application_context(  model          = get_data_model( )
                                                                    crequest       = get_cr_number( )
                                                                    rule_type      = gc_execute_derivation
                                                                    current_entity = ls_entity_mod-entity
                                                                    o_model        = io_model
                                                                    o_changed_data = io_changed_data
                                                                    o_write_data   = io_write_data
                                                                  ).

          yz_clas_mdg_accelerator=>get_accl_service( iv_model       = get_data_model( )
                                                     is_app_context = ls_app_context ).

          IF yz_clas_mdg_accelerator=>my IS BOUND.

            yz_clas_mdg_accelerator=>my->execute_business_rules(
                  IMPORTING
                    et_message     = et_message_info                " Messages
            ).

          ENDIF.
         ENDIF.
        ENDLOOP.
      ENDIF.
    ENDIF.

  ENDMETHOD.


  METHOD if_ex_usmd_rule_service~check_crequest_final.
  ENDMETHOD.


  METHOD if_ex_usmd_rule_service~check_crequest_start.
  ENDMETHOD.


  METHOD if_ex_usmd_rule_service~check_edition.
  ENDMETHOD.


  METHOD if_ex_usmd_rule_service~check_edition_final.
  ENDMETHOD.


  METHOD if_ex_usmd_rule_service~check_edition_hierarchy.
  ENDMETHOD.


  METHOD if_ex_usmd_rule_service~check_edition_start.
  ENDMETHOD.


  METHOD if_ex_usmd_rule_service~check_entity.

    BREAK-POINT ID yz_acid_stepup_event_cpg.
    LOG-POINT   ID yz_acid_stepup_event_cpg
            SUBKEY sy-cprog
            FIELDS id_crequest id_entitytype.

    CHECK id_crequest IS NOT INITIAL AND id_entitytype IS NOT INITIAL.

    DATA : lt_app_context TYPE STANDARD TABLE OF yztabl_application_context.

    lt_app_context = VALUE #(  ( rule_type = gc_execute_validation         crequest = id_crequest current_entity = id_entitytype
                                 o_model   = io_model usmd_edition = id_edition online_check = if_online_check  )
                               ( rule_type = gc_execute_validation_unique  crequest = id_crequest current_entity = id_entitytype
                                 o_model   = io_model usmd_edition = id_edition online_check = if_online_check  ) ).

    LOOP AT lt_app_context INTO DATA(ls_app_context).

      yz_clas_mdg_accelerator=>get_accl_service( iv_model       = get_data_model( id_crequest )
                                                 is_app_context = ls_app_context ).

      IF yz_clas_mdg_accelerator=>my IS BOUND.

        yz_clas_mdg_accelerator=>my->execute_business_rules(
            IMPORTING
              et_message     = DATA(lt_message)  " Messages
        ).

        et_message = VALUE #( BASE et_message FOR ls_message IN lt_message ( ls_message ) ).

      ENDIF.

    ENDLOOP.

  ENDMETHOD.


  METHOD if_ex_usmd_rule_service~check_entity_hierarchy.
  ENDMETHOD.


  METHOD if_ex_usmd_rule_service~derive_entity.
    BREAK-POINT ID yz_acid_stepup_check_point_grp.
    LOG-POINT   ID yz_acid_stepup_check_point_grp
            SUBKEY sy-cprog
            FIELDS id_entitytype.
  ENDMETHOD.


  METHOD if_ex_usmd_search~initialize.
    DATA(lv_messge) = 'Event Triggered :' && get_current_event( ) && | | && 'Method:' &&  'IF_EX_USMD_SEARCH~INITIALIZE'.
*    create_application_log( is_message        = CONV char100( lv_messge )                " Character 100
*                            iv_exe_type = yz_intf_mdg_accelerator_const=>gc_process_type_badi_trace   ).

*    DATA(lo_obj) = NEW CL_MDG_BS_SEARCH_SUPPLIER( ).
*
*    lo_obj->if_ex_usmd_search~initialize(
*      EXPORTING
*        is_search_context       = is_search_context                 " Search Context
*      IMPORTING
*        et_additional_attribute = et_additional_attribute                " Special attributes
*        et_additional_event     = et_additional_event                " Search: Events
*        et_standard_event       = et_standard_event                 " Search: Standard Events
*      CHANGING
*        ct_search_attribute     = ct_search_attribute               " Search Criteria and Their Properties
*    ).

  ENDMETHOD.


  METHOD if_ex_usmd_search~process_event.

    DATA(lv_messge) = 'Event Triggered :' && get_current_event( ) && | | && 'Method:' &&  'IF_EX_USMD_SEARCH~PROCESS_EVENT'.
*    create_application_log( is_message        = CONV char100( lv_messge )                " Character 100
*                            iv_exe_type = yz_intf_mdg_accelerator_const=>gc_process_type_badi_trace   ).

*    DATA(lo_obj) = NEW CL_MDG_BS_SEARCH_SUPPLIER( ).
*
*    lo_obj->if_ex_usmd_search~process_event(
*      EXPORTING
*        is_search_context =  is_search_context                " Search Context
*        id_fpm_event      =  id_fpm_event               " ID of FPM Event
*      IMPORTING
*        ev_usmd_action    =  ev_usmd_action                " Action
*        es_navigation     =  es_navigation               " Search: Navigation When Events Occur
*        et_message        =  et_message               " Messages
*    ).
  ENDMETHOD.


  METHOD if_ex_usmd_transaction_events~update_event.
    DATA(lv_messge) = 'Event Triggered :' && get_current_event( ) && | | && 'Method:' &&  'IF_EX_USMD_TRANSACTION_EVENTS~UPDATE_EVENT'.
*    create_application_log( is_message        = CONV char100( lv_messge )                " Character 100
*                            iv_exe_type = yz_intf_mdg_accelerator_const=>gc_process_type_badi_trace                " Process Type
*                            iv_model          = io_model->d_usmd_model ).
  ENDMETHOD.


  METHOD if_fpm_ovp_conf_exit~override_event_ovp.

  ENDMETHOD.


  METHOD if_fpm_ovp~add_content_area.

  ENDMETHOD.


  METHOD if_fpm_ovp~add_default_action.

  ENDMETHOD.


  METHOD if_fpm_ovp~add_external_navigation.

  ENDMETHOD.


  METHOD if_fpm_ovp~add_page_header_area.

  ENDMETHOD.


  METHOD if_fpm_ovp~add_page_header_uibb.

  ENDMETHOD.


  METHOD if_fpm_ovp~add_page_master_area.

  ENDMETHOD.


  METHOD if_fpm_ovp~add_page_master_uibb.

  ENDMETHOD.


  METHOD if_fpm_ovp~add_section.

  ENDMETHOD.


  METHOD if_fpm_ovp~add_toolbar_button.

  ENDMETHOD.


  METHOD if_fpm_ovp~add_toolbar_button_choice.

  ENDMETHOD.


  METHOD if_fpm_ovp~add_toolbar_drop_down_list.

  ENDMETHOD.


  METHOD if_fpm_ovp~add_toolbar_toggle_button.

  ENDMETHOD.


  METHOD if_fpm_ovp~add_uibb.

  ENDMETHOD.


  METHOD if_fpm_ovp~cancel_event.

  ENDMETHOD.


  METHOD if_fpm_ovp~change_application_parameters.

  ENDMETHOD.


  METHOD if_fpm_ovp~change_content_area.

  ENDMETHOD.


  METHOD if_fpm_ovp~change_default_action.

  ENDMETHOD.


  METHOD if_fpm_ovp~change_external_navigation.

  ENDMETHOD.


  METHOD if_fpm_ovp~change_page_header_area.

  ENDMETHOD.


  METHOD if_fpm_ovp~change_page_header_uibb.

  ENDMETHOD.


  METHOD if_fpm_ovp~change_page_master_area.

  ENDMETHOD.


  METHOD if_fpm_ovp~change_page_master_uibb.

  ENDMETHOD.


  METHOD if_fpm_ovp~change_page_selector.

  ENDMETHOD.


  METHOD if_fpm_ovp~change_section.

  ENDMETHOD.


  METHOD if_fpm_ovp~change_toolbar_button.

  ENDMETHOD.


  METHOD if_fpm_ovp~change_toolbar_button_choice.

  ENDMETHOD.


  METHOD if_fpm_ovp~change_toolbar_drop_down_list.

  ENDMETHOD.


  METHOD if_fpm_ovp~change_toolbar_toggle_button.

  ENDMETHOD.


  METHOD if_fpm_ovp~change_uibb.

  ENDMETHOD.


  METHOD if_fpm_ovp~change_uibb_selector.

  ENDMETHOD.


  METHOD if_fpm_ovp~get_aca_api.

  ENDMETHOD.


  METHOD if_fpm_ovp~get_application_parameters.

  ENDMETHOD.


  METHOD if_fpm_ovp~get_content_areas.

  ENDMETHOD.


  METHOD if_fpm_ovp~get_content_area_pers.

  ENDMETHOD.


  METHOD if_fpm_ovp~get_current_content_area.

  ENDMETHOD.


  METHOD if_fpm_ovp~get_default_action.

  ENDMETHOD.


  METHOD if_fpm_ovp~get_event.

  ENDMETHOD.


  METHOD if_fpm_ovp~get_external_navigations.

  ENDMETHOD.


  METHOD if_fpm_ovp~get_page_header_area.

  ENDMETHOD.


  METHOD if_fpm_ovp~get_page_header_uibbs.

  ENDMETHOD.


  METHOD if_fpm_ovp~get_page_master_area.

  ENDMETHOD.


  METHOD if_fpm_ovp~get_page_master_area_pers.

  ENDMETHOD.


  METHOD if_fpm_ovp~get_page_master_uibbs.

  ENDMETHOD.


  METHOD if_fpm_ovp~get_page_selector.

  ENDMETHOD.


  METHOD if_fpm_ovp~get_position_of_uibb.

  ENDMETHOD.


  METHOD if_fpm_ovp~get_sections.

  ENDMETHOD.


  METHOD if_fpm_ovp~get_section_pers.

  ENDMETHOD.


  METHOD if_fpm_ovp~get_target_content_area.

  ENDMETHOD.


  METHOD if_fpm_ovp~get_toolbar_button.

  ENDMETHOD.


  METHOD if_fpm_ovp~get_toolbar_button_choice.

  ENDMETHOD.


  METHOD if_fpm_ovp~get_toolbar_drop_down_list.

  ENDMETHOD.


  METHOD if_fpm_ovp~get_toolbar_elements.

  ENDMETHOD.


  METHOD if_fpm_ovp~get_toolbar_toggle_button.

  ENDMETHOD.


  METHOD if_fpm_ovp~get_uibbs.

  ENDMETHOD.


  METHOD if_fpm_ovp~get_uibb_pers.

  ENDMETHOD.


  METHOD if_fpm_ovp~get_uibb_selector.

  ENDMETHOD.


  METHOD if_fpm_ovp~is_event_cancelled.

  ENDMETHOD.


  METHOD if_fpm_ovp~remove_content_area.

  ENDMETHOD.


  METHOD if_fpm_ovp~remove_default_action.

  ENDMETHOD.


  METHOD if_fpm_ovp~remove_external_navigation.

  ENDMETHOD.


  METHOD if_fpm_ovp~remove_page_header_area.

  ENDMETHOD.


  METHOD if_fpm_ovp~remove_page_header_uibb.

  ENDMETHOD.


  METHOD if_fpm_ovp~remove_page_master_area.

  ENDMETHOD.


  METHOD if_fpm_ovp~remove_page_master_uibb.

  ENDMETHOD.


  METHOD if_fpm_ovp~remove_section.

  ENDMETHOD.


  METHOD if_fpm_ovp~remove_toolbar_element.

  ENDMETHOD.


  METHOD if_fpm_ovp~remove_uibb.

  ENDMETHOD.


  METHOD if_fpm_ovp~request_focus_on_first_field.

  ENDMETHOD.


  METHOD if_fpm_ovp~request_focus_on_first_tb_elem.

  ENDMETHOD.


  METHOD if_fpm_ovp~request_focus_on_page_header.

  ENDMETHOD.


  METHOD if_fpm_ovp~request_focus_on_std_func.

  ENDMETHOD.


  METHOD if_fpm_ovp~request_focus_on_tb_elem.

  ENDMETHOD.


  METHOD if_fpm_ovp~request_focus_on_uibb.

  ENDMETHOD.


  METHOD if_fpm_ovp~set_event.

  ENDMETHOD.


  METHOD if_fpm_ovp~set_generic_button_action_type.

  ENDMETHOD.


  METHOD if_fpm_wire_model~add_wire.

  ENDMETHOD.


  METHOD if_fpm_wire_model~get_wires.

  ENDMETHOD.


  METHOD if_fpm_wire_model~remove_wire.

  ENDMETHOD.


  METHOD if_mdg_dqr_dq_service~check.

  ENDMETHOD.


  METHOD if_mdg_dqr_dq_service~clear_filter_criteria.

  ENDMETHOD.


  METHOD if_mdg_dqr_dq_service~filter_crequest_type.

  ENDMETHOD.


  METHOD if_mdg_dqr_dq_service~filter_edition.

  ENDMETHOD.


  METHOD if_mdg_dqr_dq_service~get_crequest_attributes.

  ENDMETHOD.


  METHOD if_mdg_dqr_dq_service~get_failed_records.

  ENDMETHOD.


  METHOD if_mdg_dqr_dq_service~get_filter_criteria.

  ENDMETHOD.


  METHOD if_mdg_dqr_dq_service~get_filter_metadata.

  ENDMETHOD.


  METHOD if_mdg_dqr_dq_service~set_crequest_attributes.

  ENDMETHOD.


  METHOD if_mdg_dqr_dq_service~set_dqs_id.

  ENDMETHOD.


  METHOD if_mdg_dqr_dq_service~set_filter_criteria.

  ENDMETHOD.


  METHOD if_mdg_extr_badi~get_export_types.
*    DATA(lv_messge) = 'Event Triggered :' && get_current_event( ) && | | && 'Method:' &&  'IF_MDG_EXTR_BADI~GET_EXPORT_TYPES'.
*    create_application_log( is_message        = CONV char100( lv_messge )                " Character 100
*                            iv_exe_type = yz_intf_mdg_accelerator_const=>gc_process_type_badi_trace                " Process Type
*                            iv_model          = get_data_model( ) ).
  ENDMETHOD.


  METHOD if_mdg_extr_badi~get_group_fields.
*    DATA(lv_messge) = 'Event Triggered :' && get_current_event( ) && | | && 'Method:' &&  'IF_MDG_EXTR_BADI~GET_GROUP_FIELDS'.
*    create_application_log( is_message        = CONV char100( lv_messge )                " Character 100
*                            iv_exe_type = yz_intf_mdg_accelerator_const=>gc_process_type_badi_trace                " Process Type
*                            iv_model          = get_data_model( ) ).
  ENDMETHOD.


  METHOD if_mdg_extr_badi~get_objects.
    DATA(lv_messge) = 'Event Triggered :' && get_current_event( ) && | | && 'Method:' &&  'IF_MDG_EXTR_BADI~GET_OBJECTS'.
*    create_application_log( is_message        = CONV char100( lv_messge )                " Character 100
*                            iv_exe_type = yz_intf_mdg_accelerator_const=>gc_process_type_badi_trace                " Process Type
*                            iv_model          = get_data_model( ) ).
  ENDMETHOD.


  METHOD if_mdg_extr_badi~get_proxy_class.
    DATA(lv_messge) = 'Event Triggered :' && get_current_event( ) && | | && 'Method:' &&  'IF_MDG_EXTR_BADI~GET_PROXY_CLASS'.
*    create_application_log( is_message        = CONV char100( lv_messge )                " Character 100
*                            iv_exe_type = yz_intf_mdg_accelerator_const=>gc_process_type_badi_trace                " Process Type
*                            iv_model          = get_data_model( ) ).
  ENDMETHOD.


  METHOD if_mdg_extr_badi~get_selection_tables.
*    DATA(lv_messge) = 'Event Triggered :' && get_current_event( ) && | | && 'Method:' &&  'IF_MDG_EXTR_BADI~GET_SELECTION_TABLES'.
*    create_application_log( is_message        = CONV char100( lv_messge )                " Character 100
*                            iv_exe_type = yz_intf_mdg_accelerator_const=>gc_process_type_badi_trace                " Process Type
*                            iv_model          = get_data_model( ) ).
  ENDMETHOD.


  METHOD if_mdg_extr_badi~get_sel_fields.
    DATA(lv_messge) = 'Event Triggered :' && get_current_event( ) && | | && 'Method:' &&  'IF_MDG_EXTR_BADI~GET_SEL_FIELDS'.
*    create_application_log( is_message        = CONV char100( lv_messge )                " Character 100
*                            iv_exe_type = yz_intf_mdg_accelerator_const=>gc_process_type_badi_trace                " Process Type
*                            iv_model          = get_data_model( ) ).
  ENDMETHOD.


  METHOD if_mdg_extr_badi~initialize_selection.
*    DATA(lv_messge) = 'Event Triggered :' && get_current_event( ) && | | && 'Method:' &&  'IF_MDG_EXTR_BADI~INITIALIZE_SELECTION'.
*    create_application_log( is_message        = CONV char100( lv_messge )                " Character 100
*                            iv_exe_type = yz_intf_mdg_accelerator_const=>gc_process_type_badi_trace                " Process Type
*                            iv_model          = get_data_model( ) ).
  ENDMETHOD.


  METHOD if_mdg_extr_badi~packaging_allowed.
    DATA(lv_messge) = 'Event Triggered :' && get_current_event( ) && | | && 'Method:' &&  'IF_MDG_EXTR_BADI~PACKAGING_ALLOWED'.
*    create_application_log( is_message        = CONV char100( lv_messge )                " Character 100
*                            iv_exe_type = yz_intf_mdg_accelerator_const=>gc_process_type_badi_trace                " Process Type
*                            iv_model          = get_data_model( ) ).
  ENDMETHOD.


  METHOD if_mdg_extr_badi~select_objects.

    DATA(lv_messge) = 'Event Triggered :' && get_current_event( ) && | | && 'Method:' &&  'IF_MDG_EXTR_BADI~SELECT_OBJECTS'.
*    create_application_log( is_message        = CONV char100( lv_messge )                " Character 100
*                            iv_exe_type = yz_intf_mdg_accelerator_const=>gc_process_type_badi_trace                " Process Type
*                            iv_model          = get_data_model( ) ).
  ENDMETHOD.


  METHOD if_usmd_enrichment_adapter~execute.

  ENDMETHOD.


  METHOD if_usmd_enrichment_feeder~convert_action_result.

  ENDMETHOD.


  METHOD if_usmd_enrichment_feeder~get_adapter_data.

  ENDMETHOD.


  METHOD if_usmd_enrichment_feeder~get_additional_keys.

  ENDMETHOD.


  METHOD if_usmd_enrichment_feeder~get_current_ui_data.

  ENDMETHOD.


  METHOD if_usmd_enrichment_feeder~get_mdg_data.

  ENDMETHOD.


  METHOD if_usmd_enrichment_feeder~get_relevant_entities.

  ENDMETHOD.


  METHOD if_usmd_enrichment_feeder~is_relevant.

  ENDMETHOD.


  METHOD if_usmd_enrichment_feeder~prepare_ui_data.

  ENDMETHOD.


  METHOD if_usmd_pp_access~adjust_selection_attr.

  ENDMETHOD.


  METHOD if_usmd_pp_access~check_authority.

  ENDMETHOD.


  METHOD if_usmd_pp_access~check_authority_mass.

  ENDMETHOD.


  METHOD if_usmd_pp_access~check_data.

  ENDMETHOD.


  METHOD if_usmd_pp_access~check_existence_mass.

  ENDMETHOD.


  METHOD if_usmd_pp_access~dequeue.

  ENDMETHOD.


  METHOD if_usmd_pp_access~derive_data.

  ENDMETHOD.


  METHOD if_usmd_pp_access~derive_data_on_key_change.

  ENDMETHOD.


  METHOD if_usmd_pp_access~discard_read_buffer.

  ENDMETHOD.


  METHOD if_usmd_pp_access~enqueue.

  ENDMETHOD.


  METHOD if_usmd_pp_access~get_change_document.

  ENDMETHOD.


  METHOD if_usmd_pp_access~get_entity_properties.

  ENDMETHOD.


  METHOD if_usmd_pp_access~get_field_properties.

  ENDMETHOD.


  METHOD if_usmd_pp_access~get_key_handling.

  ENDMETHOD.


  METHOD if_usmd_pp_access~get_mapping_cd.

  ENDMETHOD.


  METHOD if_usmd_pp_access~get_query_properties.

  ENDMETHOD.


  METHOD if_usmd_pp_access~query.

  ENDMETHOD.


  METHOD if_usmd_pp_access~read_value.

  ENDMETHOD.


  METHOD if_usmd_pp_access~save.

  ENDMETHOD.


  METHOD if_usmd_pp_blocklist~get_blocklist_for_read.

  ENDMETHOD.


  METHOD if_usmd_pp_blocklist~get_blocklist_for_write.

  ENDMETHOD.


  METHOD if_usmd_pp_hana_search~adapt_result_list.

  ENDMETHOD.


  METHOD if_usmd_pp_hana_search~adapt_sel_fields.

  ENDMETHOD.


  METHOD if_usmd_pp_hana_search~adapt_where_clause.

  ENDMETHOD.


  METHOD if_usmd_pp_hana_search~get_mapping_info.

  ENDMETHOD.


  METHOD if_usmd_pp_hana_search~get_reuse_view_content.

  ENDMETHOD.


  METHOD if_usmd_pp_hana_search~merge_reuse_authorization.

  ENDMETHOD.


  METHOD if_usmd_search_data~execute.

  ENDMETHOD.


  METHOD if_usmd_search_data~get_dup_check_attr.

  ENDMETHOD.


  METHOD if_usmd_search_data~get_search_attr.

  ENDMETHOD.


  METHOD if_usmd_ssw_dynamic_agt_select~get_dynamic_agents.

    CHECK iv_cr_number IS NOT INITIAL.

    DATA lt_app_context TYPE STANDARD TABLE OF yztabl_application_context.

    lt_app_context = VALUE #( ( rule_type  = gc_execute_dyn_unique    crequest = iv_cr_number service_name = iv_service_name  )
                              ( rule_type  = gc_execute_dynamic_agent crequest = iv_cr_number service_name = iv_service_name  )
                              ( rule_type  = 'LWF'                    crequest = iv_cr_number service_name = iv_service_name  ) ).

    LOOP AT lt_app_context INTO DATA(ls_app_context).

      DATA(my) = yz_clas_mdg_accelerator=>get_accl_service( iv_model = get_data_model( iv_cr_number )
                                                            is_app_context = ls_app_context ). "Code needs to be adjusted for fetching DM dynamically.

*--------------------------------------------------------------------*
* Map Data and Send
*--------------------------------------------------------------------*
      DATA(ls_dyn_context) = VALUE yztabl_dyn_context(
                                non_user_agent_group = ct_non_user_agent_group
                                exp_comp_hours       = cv_exp_comp_hours
                                user_agent_group     = ct_user_agent_group
                                context_tab          = ct_context_tab
                                new_step             = cv_new_step
                                new_cr_status        = cv_new_cr_status
                                merge_type           = cv_merge_type
                                merge_param          = cv_merge_param
                               ).

*--------------------------------------------------------------------*
      DATA(lv_result) = my->execute_business_rules(
                          EXPORTING
                            ip_app_context = ls_app_context   " Application Context Data
                          IMPORTING
                            et_message     = et_message       " Messages
                          CHANGING
                            cp_dyn_context = ls_dyn_context   " Dynamic Agent Context
            ).

*--------------------------------------------------------------------*
*  Restore updated Data back to System
*--------------------------------------------------------------------*
      ct_non_user_agent_group = ls_dyn_context-non_user_agent_group.
      cv_exp_comp_hours       = ls_dyn_context-exp_comp_hours.
      ct_user_agent_group     = ls_dyn_context-user_agent_group.
      ct_context_tab          = ls_dyn_context-context_tab.
      cv_new_step             = ls_dyn_context-new_step.
      cv_new_cr_status        = ls_dyn_context-new_cr_status.
      cv_merge_type           = ls_dyn_context-merge_type.
      cv_merge_param          = ls_dyn_context-merge_param.
*--------------------------------------------------------------------*

      IF lv_result IS NOT INITIAL AND ls_app_context-rule_type EQ gc_execute_dyn_unique .
        "if uniqueness check result was true then do not execute the DYN Rule type
        EXIT.
      ENDIF.

    ENDLOOP.


  ENDMETHOD.


  METHOD if_usmd_ssw_para_rslt_handler~handle_parallel_result.
    DATA(lv_messge) = 'Event Triggered :' && get_current_event( ) && | | && 'Method:' &&  'IF_USMD_SSW_PARA_RSLT_HANDLER~HANDLE_PARALLEL_RESULT'.
*    create_application_log( is_message        = CONV char100( lv_messge )                " Character 100
*                            iv_exe_type = yz_intf_mdg_accelerator_const=>gc_process_type_badi_trace                " Process Type
*                            iv_model          = get_data_model( iv_cr_number ) ).
  ENDMETHOD.


  METHOD if_usmd_ssw_rule_chk_agent_tab~check_agent_tables.

*    DATA(lv_messge) = 'Event Triggered :' && get_current_event( ) && | | && 'Method:' &&  'IF_USMD_SSW_RULE_CHK_AGENT_TAB~CHECK_AGENT_TABLES'.
*    create_application_log( is_message        = CONV char100( lv_messge )                " Character 100
*                            iv_exe_type = yz_intf_mdg_accelerator_const=>gc_process_type_badi_trace                " Process Type
*                            iv_model          = get_data_model( iv_cr_number ) ).
  ENDMETHOD.


  METHOD if_usmd_ssw_rule_cntx_prepare~prepare_rule_context.

*    DATA(lv_messge) = 'Event Triggered :' && get_current_event( ) && | | && 'Method:' &&  'IF_USMD_SSW_RULE_CNTX_PREPARE~PREPARE_RULE_CONTEXT'.
*    create_application_log( is_message        = CONV char100( lv_messge )                " Character 100
*                            iv_exe_type = yz_intf_mdg_accelerator_const=>gc_process_type_badi_trace                " Process Type
*                            iv_model          = get_data_model( ) ).
  ENDMETHOD.


  METHOD if_usmd_ssw_syst_method_caller~call_system_method.

    BREAK-POINT ID yz_acid_stepup_event_cpg.
    LOG-POINT   ID yz_acid_stepup_event_cpg
            SUBKEY sy-cprog
            FIELDS iv_cr_number iv_service_name.

    DATA(lv_messge) = 'Event Triggered :'(001) && get_current_event( ) && | | && 'Method:'(002) &&  'IF_USMD_SSW_SYST_METHOD_CALLER~CALL_SYSTEM_METHOD'(003).
*    create_application_log( is_message        = CONV char100( lv_messge )                " Character 100
*                            iv_exe_type = yz_intf_mdg_accelerator_const=>gc_process_type_badi_trace                " Process Type
*                            iv_model          = get_data_model( iv_cr_number ) ).
  ENDMETHOD.


  METHOD /plmu/if_ex_frw_appcc_ovp~after_cleanup.

  ENDMETHOD.


  METHOD /plmu/if_ex_frw_appcc_ovp~after_flush.

  ENDMETHOD.


  METHOD /plmu/if_ex_frw_appcc_ovp~after_needs_confirmation.

  ENDMETHOD.


  METHOD /plmu/if_ex_frw_appcc_ovp~after_process_before_output.

  ENDMETHOD.


  METHOD /plmu/if_ex_frw_appcc_ovp~after_save.

  ENDMETHOD.


  METHOD if_ex_usmd_cr_object_list~check.

  ENDMETHOD.


  METHOD if_ex_usmd_rule_service~check_crequest.

  ENDMETHOD.


  METHOD if_ex_usmd_rule_service~check_crequest_hierarchy.

  ENDMETHOD.


  METHOD if_ex_usmd_data_transfer_upl~convert.

  ENDMETHOD.


  METHOD if_ex_usmd_data_transfer_upl~finalize.

  ENDMETHOD.


  METHOD if_ex_usmd_remote_where_used~get_where_used_list.

  ENDMETHOD.


  METHOD /plmu/if_ex_frw_appcc_ovp~override_config_tabbed.

  ENDMETHOD.


  METHOD /plmu/if_ex_frw_appcc_ovp~process_before_output.

  ENDMETHOD.


  METHOD if_ex_usmd_entity_ui~disable_navigation.

  ENDMETHOD.


  METHOD if_ex_usmd_entity_ui~filter_component.

  ENDMETHOD.


  METHOD if_ex_usmd_entity_ui~get_hry_attr_default_values.

  ENDMETHOD.


  METHOD if_drf_ale_audit_get_km_data~get_km_info_from_audit_idoc.

  ENDMETHOD.


  METHOD if_mdg_dqr_event_handler~handle_wd_event.

  ENDMETHOD.


  METHOD if_mdg_dqr_event_handler~initialize.

  ENDMETHOD.


  METHOD if_swf_ifs_workitem_exit~event_raised.
*  Enhance User Decision TO ADD EXIT FOR email generation:
*  I CREATE custom CLASS implementing INTERFACE IF_SWF_IFS_WORKITEM_EXIT.
*  ii Implement METHOD EVENT_RAISED
*  1 IF IM_EVENT_NAME = IF_SWF_IFS_WORKITEM_EXIT~C_EVTTYP_AFTER_CREATE.
*  1 LWA_HEADER = IM_WORKITEM_CONTEXT->GET_HEADER( ).
*  2 SELECT CR NUMBER FROM USMD2400 passing LWA_HEADER-WI_CHCKWI
*  3 Use above CODE TO GENERATE URL.
*  4 CREATE email content & recipients.
*  5 Trigger email via CL_BCS.
  ENDMETHOD.


  METHOD execute_hide_uibb_rules.

    BREAK-POINT ID yz_acid_stepup_event_cpg.
    LOG-POINT   ID yz_acid_stepup_event_cpg
            SUBKEY sy-cprog
            FIELDS iv_model iv_crequest.


    DATA(lv_messge) = 'Event Triggered :' && yz_clas_mdg_utility=>get_current_event( ) && | | && 'Method:' &&  'IPO_YZ_ENHO_0G_OVP_ASSIST~OVERRIDE_EVENT_OVP'.

    DATA(ls_app_context) = VALUE yztabl_application_context( rule_type = gc_execute_hideuibb   model = iv_model crequest = iv_crequest o_ovp = io_ovp ) .

    yz_clas_mdg_accelerator=>get_accl_service( iv_model       = iv_model
                                               is_app_context = ls_app_context ).

    IF yz_clas_mdg_accelerator=>my IS BOUND.

      yz_clas_mdg_accelerator=>my->execute_business_rules( IMPORTING et_message = DATA(lt_message) ).

    ENDIF.

  ENDMETHOD.
ENDCLASS.
