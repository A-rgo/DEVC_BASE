CLASS yz_clas_mdg_accelerator DEFINITION
  PUBLIC
  INHERITING FROM yz_clas_mdg_rule_process
  CREATE PUBLIC

  GLOBAL FRIENDS yz_clas_mdg_event_process .

  PUBLIC SECTION.

    INTERFACES yz_intf_mdg_accelerator_const .
    INTERFACES yz_intf_mdg_accelerator .
    INTERFACES yz_intf_mdg_accelerator_config .

    ALIASES gc_bp_header
      FOR yz_intf_mdg_accelerator_const~gc_bp_header .
    ALIASES gc_crstep_default
      FOR yz_intf_mdg_accelerator_const~gc_crstep_default .
    ALIASES gc_crtype_default
      FOR yz_intf_mdg_accelerator_const~gc_crtype_default .
    ALIASES gc_data_process_class_name
      FOR yz_intf_mdg_accelerator_const~gc_data_process_class_name .
    ALIASES gc_entity_yyorgunit
      FOR yz_intf_mdg_accelerator_const~gc_entity_yyorgunit .
    ALIASES gc_entity_yyusage
      FOR yz_intf_mdg_accelerator_const~gc_entity_yyusage .
    ALIASES gc_execute_derivation
      FOR yz_intf_mdg_accelerator_const~gc_execute_derivation .
    ALIASES gc_execute_dynamic_agent
      FOR yz_intf_mdg_accelerator_const~gc_execute_dynamic_agent .
    ALIASES gc_execute_dyn_unique
      FOR yz_intf_mdg_accelerator_const~gc_execute_dyn_unique .
    ALIASES gc_execute_fldprop
      FOR yz_intf_mdg_accelerator_const~gc_execute_fldprop .
    ALIASES gc_execute_hideuibb
      FOR yz_intf_mdg_accelerator_const~gc_execute_hideuibb .
    ALIASES gc_execute_loop_wf
      FOR yz_intf_mdg_accelerator_const~gc_execute_loop_wf .
    ALIASES gc_execute_validation
      FOR yz_intf_mdg_accelerator_const~gc_execute_validation .
    ALIASES gc_execute_validation_unique
      FOR yz_intf_mdg_accelerator_const~gc_execute_validation_unique .
    ALIASES gc_fixed_value
      FOR yz_intf_mdg_accelerator_const~gc_fixed_value .
    ALIASES gc_fld_prop_mandatory
      FOR yz_intf_mdg_accelerator_const~gc_fld_prop_mandatory .
    ALIASES gc_mapper_message_id
      FOR yz_intf_mdg_accelerator_const~gc_mapper_message_id .
    ALIASES gc_mapper_message_no
      FOR yz_intf_mdg_accelerator_const~gc_mapper_message_no .
    ALIASES gc_mdg_badi_trace
      FOR yz_intf_mdg_accelerator_const~gc_mdg_badi_trace .
    ALIASES gc_process_type_badi_trace
      FOR yz_intf_mdg_accelerator_const~gc_process_type_badi_trace .
    ALIASES gc_rule_context_cr
      FOR yz_intf_mdg_accelerator_const~gc_rule_context_cr .
    ALIASES gc_rule_section_condition
      FOR yz_intf_mdg_accelerator_const~gc_rule_section_condition .
    ALIASES gc_rule_section_scope
      FOR yz_intf_mdg_accelerator_const~gc_rule_section_scope .
    ALIASES gc_rule_section_usage
      FOR yz_intf_mdg_accelerator_const~gc_rule_section_usage .
    ALIASES gc_rule_stat_tabname
      FOR yz_intf_mdg_accelerator_const~gc_rule_stat_tabname .
    ALIASES gc_rule_task_check
      FOR yz_intf_mdg_accelerator_const~gc_rule_task_check .
    ALIASES gc_rule_task_execute
      FOR yz_intf_mdg_accelerator_const~gc_rule_task_execute .
    ALIASES gc_spt_approver
      FOR yz_intf_mdg_accelerator_const~gc_spt_approver .
    ALIASES gc_struct_key_attr
      FOR yz_intf_mdg_accelerator_const~gc_struct_key_attr .
    ALIASES gc_usage_mdf_check
      FOR yz_intf_mdg_accelerator_const~gc_usage_mdf_check .
    ALIASES execute_business_rules
      FOR yz_intf_mdg_accelerator~execute_business_rules .
    ALIASES get_nr_def_id_for_rule
      FOR yz_intf_mdg_accelerator_config~get_nr_def_id_for_rule .
    ALIASES get_nr_exe_id_for_rule
      FOR yz_intf_mdg_accelerator_config~get_nr_exe_id_for_rule .
    ALIASES get_nr_itm_id_for_rule
      FOR yz_intf_mdg_accelerator_config~get_nr_itm_id_for_rule .
    ALIASES get_nr_tmp_id_for_rule
      FOR yz_intf_mdg_accelerator_config~get_nr_tmp_id_for_rule .
    ALIASES get_nr_val_id_for_rule
      FOR yz_intf_mdg_accelerator_config~get_nr_val_id_for_rule .
    ALIASES process_config_records
      FOR yz_intf_mdg_accelerator_config~process_config_records .
    ALIASES process_yz_view_rule_def
      FOR yz_intf_mdg_accelerator_config~process_yz_view_rule_def .
    ALIASES process_yz_view_rule_dom
      FOR yz_intf_mdg_accelerator_config~process_yz_view_rule_dom .
    ALIASES process_yz_view_rule_exe
      FOR yz_intf_mdg_accelerator_config~process_yz_view_rule_exe .
    ALIASES process_yz_view_rule_tmp
      FOR yz_intf_mdg_accelerator_config~process_yz_view_rule_tmp .
    ALIASES process_yz_view_rule_val
      FOR yz_intf_mdg_accelerator_config~process_yz_view_rule_val .
    ALIASES process_yz_view_temp_itm
      FOR yz_intf_mdg_accelerator_config~process_yz_view_temp_itm .

    TYPES:
      BEGIN OF ty_rule_def,
        def_id    TYPE yztabl_rule_def-def_id,
        reuse_scp TYPE yztabl_rule_def-reuse_scp,
        refruleid TYPE yztabl_rule_def-refruleid,
      END OF ty_rule_def .
    TYPES:
      tt_rule_def_id     TYPE SORTED TABLE OF ty_rule_def  WITH NON-UNIQUE KEY primary_key  COMPONENTS def_id.
    TYPES:
      BEGIN OF ty_rule_prc,
        def_id    TYPE yztabl_rule_def-def_id,
        rule_sec  TYPE yztabl_rule_exe-rule_sec,
        rule_typ  TYPE yztabl_rule_def-rule_type,
        reuse_scp TYPE yztabl_rule_def-reuse_scp,
        refruleid TYPE yztabl_rule_def-refruleid,
        result    TYPE boolean,
      END OF ty_rule_prc .
    TYPES:
    tt_rule_prc     TYPE STANDARD TABLE OF ty_rule_prc WITH NON-UNIQUE KEY primary_key       COMPONENTS def_id rule_sec rule_typ reuse_scp
                                                       WITH NON-UNIQUE SORTED KEY filter_key COMPONENTS def_id rule_sec rule_typ .
    TYPES:
      tt_rule_exe_id     TYPE STANDARD TABLE OF yz_dtel_exe_id WITH DEFAULT KEY .
    TYPES:
      tt_rule_text_table TYPE SORTED TABLE OF yztabl_br_context WITH DEFAULT KEY .
    TYPES:
      tt_yztabl_rule_val TYPE SORTED TABLE OF yztabl_rule_val  WITH NON-UNIQUE KEY primary_key             COMPONENTS mandt model otc rule_type def_id exe_id rule_sec val_id
                                                               WITH NON-UNIQUE SORTED KEY filter_val_type  COMPONENTS val_type .
    TYPES:
      tt_yztabl_rule_exe TYPE SORTED TABLE OF yztabl_rule_exe WITH NON-UNIQUE KEY primary_key        COMPONENTS mandt model otc rule_type def_id exe_id rule_sec
                                                              WITH NON-UNIQUE SORTED KEY filter_key  COMPONENTS rule_sec task entity
                                                              WITH NON-UNIQUE SORTED KEY key_attr    COMPONENTS attribute
                                                              WITH NON-UNIQUE SORTED KEY key_task    COMPONENTS task
                                                              WITH NON-UNIQUE SORTED KEY key_seq     COMPONENTS seq_no
                                                              WITH NON-UNIQUE SORTED KEY key_order   COMPONENTS order_id.
    TYPES:
      r_values           TYPE RANGE OF yz_dtel_value .                                                     " Range table for values
    TYPES:
      BEGIN OF gty_dyn_wf_exec_state,
        usmd_creq_num    TYPE usmd_crequest,
        usmd_creq_type   TYPE usmd_crequest_type,
        operator         TYPE vsoperator,
        value_id         TYPE yz_dtel_value_id,
        current_wf_step  TYPE usmd_crequest_appstep,
        next_wf_step     TYPE usmd_crequest_appstep,
        usmd_creq_status TYPE usmd_crequest_status,
      END OF gty_dyn_wf_exec_state .
    TYPES:
      gtt_dyn_wf_exec_state TYPE STANDARD TABLE OF gty_dyn_wf_exec_state .
    TYPES: gtt_key_value_nk TYPE TABLE OF yztabl_s_key_value WITH EMPTY KEY.

    CLASS-DATA gt_rule_prc TYPE tt_rule_prc . "
    CLASS-DATA:
      gt_yztabl_rule_typ  TYPE   SORTED TABLE OF yztabl_rule_typ WITH UNIQUE KEY rule_type .
    CLASS-DATA:
      gt_yztabl_rule_sec  TYPE   SORTED TABLE OF yztabl_rule_sec WITH UNIQUE KEY rule_sec .
    CLASS-DATA:
      gt_yztabl_rule_tas  TYPE   SORTED TABLE OF yztabl_rule_tas WITH UNIQUE KEY task .
    CLASS-DATA:
      gt_yztabl_rule_opr  TYPE   SORTED TABLE OF yztabl_rule_opr WITH UNIQUE KEY operation .
    CLASS-DATA:
      gt_yztabl_rule_ety  TYPE   SORTED TABLE OF yztabl_rule_ety WITH UNIQUE KEY exe_type .
    CLASS-DATA:
      gt_yztabl_rule_vlt  TYPE   SORTED TABLE OF yztabl_rule_vlt WITH UNIQUE KEY val_type .
    CLASS-DATA:
      gt_yztabl_rule_dom  TYPE   SORTED TABLE OF yztabl_rule_dom WITH NON-UNIQUE KEY primary_key           COMPONENTS mandt model otc
                                                                 WITH NON-UNIQUE SORTED KEY filter_app_log COMPONENTS app_log
                                                                 WITH NON-UNIQUE SORTED KEY filter_br_log  COMPONENTS br_log.
    CLASS-DATA:
      gt_yztabl_rule_exe_src TYPE  SORTED TABLE OF yztabl_rule_exe WITH NON-UNIQUE KEY primary_key        COMPONENTS mandt model otc rule_type def_id exe_id rule_sec
                                                                   WITH NON-UNIQUE SORTED KEY filter_key  COMPONENTS def_id entity
                                                                   WITH NON-UNIQUE SORTED KEY filter_def  COMPONENTS def_id rule_sec .
    CLASS-DATA:
      gt_yztabl_rule_exe_prc TYPE  SORTED TABLE OF yztabl_rule_exe WITH NON-UNIQUE KEY primary_key        COMPONENTS mandt model otc rule_type def_id exe_id rule_sec
                                                                   WITH NON-UNIQUE SORTED KEY filter_def  COMPONENTS def_id
                                                                   WITH NON-UNIQUE SORTED KEY filter_key  COMPONENTS rule_type entity .
    CLASS-DATA:
      gt_yztabl_rule_def TYPE  SORTED TABLE OF yztabl_rule_def WITH NON-UNIQUE DEFAULT KEY.
    CLASS-DATA:
      gt_yztabl_rule_log  TYPE SORTED TABLE OF yztabl_rule_log WITH NON-UNIQUE KEY model process obj.
    CLASS-DATA:
      gt_yztabl_rule_val_src  TYPE SORTED TABLE OF yztabl_rule_val WITH NON-UNIQUE KEY primary_key        COMPONENTS mandt model otc rule_type def_id exe_id rule_sec val_id
                                                                   WITH NON-UNIQUE SORTED KEY filter_exe  COMPONENTS exe_id
                                                                   WITH NON-UNIQUE SORTED KEY filter_def  COMPONENTS def_id .
    CLASS-DATA:
      gt_yztabl_rule_val_prc  TYPE SORTED TABLE OF yztabl_rule_val WITH NON-UNIQUE KEY primary_key        COMPONENTS mandt model otc rule_type def_id exe_id rule_sec val_id
                                                                   WITH NON-UNIQUE SORTED KEY filter_key  COMPONENTS model exe_id rule_sec val_type
                                                                   WITH NON-UNIQUE SORTED KEY filter_exe  COMPONENTS exe_id.
    CLASS-DATA:
      gt_yztabl_metadata  TYPE SORTED TABLE OF yztabl_ref_data WITH UNIQUE KEY model otc entity attribute .
    CLASS-DATA gs_app_context TYPE yztabl_application_context READ-ONLY .
    CLASS-DATA gt_definition_ids_src TYPE tt_rule_def_id READ-ONLY .
    CLASS-DATA gt_definition_ids_prc TYPE tt_rule_def_id READ-ONLY .

    CLASS-METHODS class_constructor .
    CLASS-METHODS execute_dqm_procedure
      IMPORTING
        !iv_model                   TYPE usmd_model
        !iv_rule_sec                TYPE yz_dtel_rule_sec
        !iv_rule_type               TYPE yz_dtel_rule_type
        !iv_mdqltytechnicalruleuuid TYPE mdq_brfplus_uuid OPTIONAL
        !iv_process_key             TYPE mdc_process_key OPTIONAL
        !is_dqm_eval_context        TYPE eval_context_dq_str OPTIONAL
        !is_dqm_derive_context      TYPE derive_context_dq_str OPTIONAL
      RETURNING
        VALUE(rv_boolean)           TYPE boolean .
    CLASS-METHODS execute_dqm_scope
      IMPORTING
        !iv_model                   TYPE usmd_model
        !iv_rule_type               TYPE yz_dtel_rule_type
        !iv_mdqltytechnicalruleuuid TYPE mdq_brfplus_uuid OPTIONAL
        !iv_process_key             TYPE mdc_process_key OPTIONAL
        !is_dqm_eval_context        TYPE eval_context_dq_str OPTIONAL
        !is_dqm_derive_context      TYPE derive_context_dq_str OPTIONAL
      EXPORTING
        !ev_boolean                 TYPE boolean
        !et_def_ids                 TYPE yz_ttyp_def_ids_r
      RETURNING
        VALUE(rv_def_ids)           TYPE string .
    CLASS-METHODS execute_dqm_condition
      IMPORTING
        !iv_model                   TYPE usmd_model
        !iv_rule_type               TYPE yz_dtel_rule_type
        !iv_mdqltytechnicalruleuuid TYPE c_mdqualitytechnicalrule-mdqltytechnicalruleuuid
        !iv_process_key             TYPE mdc_process_key
        !is_dqm_eval_context        TYPE eval_context_dq_str OPTIONAL
        !is_dqm_derive_context      TYPE derive_context_dq_str OPTIONAL
      EXPORTING
        !et_message                 TYPE usmd_t_message
      RETURNING
        VALUE(rv_boolean)           TYPE boolean .
    CLASS-METHODS get_accl_service
      IMPORTING
        !iv_model             TYPE usmd_model
        !is_app_context       TYPE yztabl_application_context OPTIONAL
      RETURNING
        VALUE(ro_accelerator) TYPE REF TO yz_clas_mdg_accelerator .
    METHODS constructor
      IMPORTING
        !iv_model       TYPE usmd_model
        !is_app_context TYPE yztabl_application_context OPTIONAL .
    CLASS-METHODS clean_up
      IMPORTING
        !iv_usmd_crequest TYPE usmd_crequest
        !iv_rule_type     TYPE yz_dtel_rule_type .
protected section.

  class-methods SET_APPLICATION_CONTEXT
    importing
      !IS_APP_CONTEXT type YZTABL_APPLICATION_CONTEXT optional .
private section.

  aliases GC_RIGHT_OUTER
    for YZ_INTF_MDG_UTILITY_CONST~GC_RIGHT_OUTER .
  aliases GC_RULE_TASK_PER_STR_1
    for YZ_INTF_MDG_ACCELERATOR_CONST~GC_RULE_TASK_PER_STR_1 .
  aliases GC_RULE_TASK_PER_STR_2
    for YZ_INTF_MDG_ACCELERATOR_CONST~GC_RULE_TASK_PER_STR_2 .
  aliases GC_RULE_TASK_PER_STR_3
    for YZ_INTF_MDG_ACCELERATOR_CONST~GC_RULE_TASK_PER_STR_3 .
  aliases GC_RULE_TASK_PER_STR_T
    for YZ_INTF_MDG_ACCELERATOR_CONST~GC_RULE_TASK_PER_STR_T .
  aliases ADAPT_RESULT_LIST
    for YZ_INTF_USMD_PP_HANA_SEARCH~ADAPT_RESULT_LIST .
  aliases ADAPT_SEL_FIELDS
    for YZ_INTF_USMD_PP_HANA_SEARCH~ADAPT_SEL_FIELDS .
  aliases ADAPT_WHERE_CLAUSE
    for YZ_INTF_USMD_PP_HANA_SEARCH~ADAPT_WHERE_CLAUSE .
  aliases GET_MAPPING_INFO
    for YZ_INTF_USMD_PP_HANA_SEARCH~GET_MAPPING_INFO .
  aliases GET_REUSE_VIEW_CONTENT
    for YZ_INTF_USMD_PP_HANA_SEARCH~GET_REUSE_VIEW_CONTENT .
  aliases MERGE_REUSE_AUTHORIZATION
    for YZ_INTF_USMD_PP_HANA_SEARCH~MERGE_REUSE_AUTHORIZATION .

  class-data MY type ref to YZ_CLAS_MDG_ACCELERATOR .

  methods EXECUTE_OPERATION_COUNT
    importing
      !IS_RULE_EXE type YZTABL_RULE_EXE
      !IT_DATA type ANY TABLE
    exporting
      !ER_DATA type ref to DATA .
  methods EXECUTE_OPERATION_MIN
    importing
      !IS_RULE_EXE type YZTABL_RULE_EXE
      !IT_DATA type ANY TABLE
    exporting
      !ER_DATA type ref to DATA .
  methods EXECUTE_OPERATION_MAX
    importing
      !IS_RULE_EXE type YZTABL_RULE_EXE
      !IT_DATA type ANY TABLE
    exporting
      !ER_DATA type ref to DATA .
  methods EXECUTE_OPERATION_AVG
    importing
      !IS_RULE_EXE type YZTABL_RULE_EXE
      !IT_DATA type ANY TABLE
    exporting
      !ER_DATA type ref to DATA .
  methods EXECUTE_OPERATION_SUM
    importing
      !IS_RULE_EXE type YZTABL_RULE_EXE
      !IT_DATA type ANY TABLE
    exporting
      !ER_DATA type ref to DATA .
  methods EXECUTE_OPERATION_SPLIT_AT
    importing
      !IS_RULE_EXE type YZTABL_RULE_EXE
      !IT_DATA type ANY TABLE
    exporting
      !ER_DATA type ref to DATA .
  methods EXECUTE_OPERATION_SPLIT_LEN
    importing
      !IS_RULE_EXE type YZTABL_RULE_EXE
      !IT_DATA type ANY TABLE
    exporting
      !ER_DATA type ref to DATA .
  class-methods GET_APPL_HEADER
    importing
      value(IV_EXE_TYPE) type YZ_DTEL_RULE_TYPE
      !IV_MODEL type MODEL optional
    returning
      value(RV_BALHDRI) type BALHDRI .
  class-methods GET_ORG_STR_VALUES_FOR_USER
    importing
      !IV_USER type SYUNAME
    returning
      value(RT_DATA) type TT_YYORGUNIT .
  methods AUTO_RULE_BASED_ON_RULE_DESC .
  class-methods BUILD_MESSAGE_FOR_EXCEPTION
    importing
      !IV_TEXT type STRING
    returning
      value(ET_MESSAGE) type USMD_T_MESSAGE .
  methods CHECK_DOMAIN_IS_ACTIVE
    importing
      !IT_SELECTION type USMD_TS_SEL
    returning
      value(RV_RETURN) type BOOLE_D .
  methods CREATE_APP_LOG
    importing
      !IT_MESSAGE type USMD_T_MESSAGE optional
      !IS_MESSAGE type CHAR100 optional
      !IS_RULE_STATUS type YZTABL_RULE_STA optional
      !IV_EXE_TYPE type YZ_DTEL_PROCESS optional
      !IV_MODEL type USMD_MODEL optional .
  methods EXECUTE_TASK
    importing
      !IT_VAL_PRC type TT_YZTABL_RULE_VAL optional
      !IV_ENTITY type USMD_ENTITY optional
      !IS_RULE_EXE type YZTABL_RULE_EXE optional
      !IP_APP_CONTEXT type YZTABL_APPLICATION_CONTEXT optional
    exporting
      !ER_DATA type ref to DATA
      !EV_EXCEPTION_TEXT type STRING
    returning
      value(RV_RESULT) type BOOLE_D .
  methods EXECUTE_DBLOOKUP
    importing
      !IT_VALUES type TT_YZTABL_RULE_VAL optional
      !IT_DATA type ANY TABLE optional
      !IS_RULE_EXE type YZTABL_RULE_EXE optional
      !IV_READ_FUNCTION type BOOLE_D optional
    exporting
      !ET_DATA type ANY TABLE
    returning
      value(RV_RESULT) type BOOLE_D .
  methods EXECUTE_DEFINITION_ID
    importing
      !IV_DEF_ID type YZ_DTEL_DEF_ID optional
      !IT_RULE_EXE_ENTRY type TT_YZTABL_RULE_EXE optional
      !IV_RULE_SEC type YZ_DTEL_RULE_SEC optional
      !IP_APP_CONTEXT type YZTABL_APPLICATION_CONTEXT optional
    exporting
      !ER_DATA type ref to DATA
      !ET_MESSAGE type USMD_T_MESSAGE
    changing
      !CP_FLP_CONTEXT type YZTABL_FLP_CONTEXT optional
      !CP_DYN_CONTEXT type YZTABL_DYN_CONTEXT optional
    returning
      value(RV_RETURN) type BOOLE_D .
  methods EXECUTE_DERIVE_CONDITION
    importing
      !IO_MODEL type ref to IF_USMD_MODEL_EXT optional
      !IO_CHANGED_DATA type ref to IF_USMD_DELTA_BUFFER_READ optional
      !IO_WRITE_DATA type ref to IF_USMD_DELTA_BUFFER_WRITE optional
      !IT_RULE_EXE_ENTRY type TT_YZTABL_RULE_EXE optional
      !IP_APP_CONTEXT type YZTABL_APPLICATION_CONTEXT optional
    exporting
      !ET_MESSAGE_INFO type USMD_T_MESSAGE
    returning
      value(RV_RESULT) type BOOLE_D .
  methods EXECUTE_DYNAMIC_AGENT_COND
    importing
      !IT_RULE_EXE_ENTRY type TT_YZTABL_RULE_EXE
    exporting
      !ET_MESSAGE type USMD_T_MESSAGE
    changing
      !CT_NON_USER_AGENT_GROUP type USMD_T_NON_USER_AGENT_GROUP optional
      !CV_EXP_COMP_HOURS type INT2 optional
      !CT_USER_AGENT_GROUP type USMD_T_USER_AGENT_GROUP optional
      !CT_CONTEXT_TAB type USMD_T_GENERIC_CONTEXT optional
      !CV_NEW_STEP type USMD_CREQUEST_APPSTEP optional
      !CV_NEW_CR_STATUS type USMD_CREQUEST_STATUS optional
      !CV_MERGE_TYPE type USMD_STATUS_MERGE_TYPE optional
      !CV_MERGE_PARAM type USMD_SERVICE_NAME optional
      !CP_DYN_CONTEXT type YZTABL_DYN_CONTEXT optional
    returning
      value(RV_RESULT) type BOOLE_D .
  methods EXECUTE_DYN_AGENT_UNIQUE_CHECK
    importing
      !IT_RULE_EXE_ENTRY type TT_YZTABL_RULE_EXE
      !IV_RULE_SEC type YZ_DTEL_RULE_SEC optional
    exporting
      !ET_MESSAGE type USMD_T_MESSAGE
    changing
      !CP_DYN_CONTEXT type YZTABL_DYN_CONTEXT optional
      !CV_NEW_STEP type USMD_CREQUEST_APPSTEP optional
      !CV_NEW_CR_STATUS type USMD_CREQUEST_STATUS optional
      !CT_USER_AGENT_GROUP type USMD_T_USER_AGENT_GROUP optional
      !CT_NON_USER_AGENT_GROUP type USMD_T_NON_USER_AGENT_GROUP optional
      !CV_EXP_COMP_HOURS type INT2 optional
      !CT_CONTEXT_TAB type USMD_T_GENERIC_CONTEXT optional
      !CV_MERGE_TYPE type USMD_STATUS_MERGE_TYPE optional
      !CV_MERGE_PARAM type USMD_SERVICE_NAME optional
    returning
      value(RV_RESULT) type BOOLE_D .
  methods EXECUTE_ENTITY_ATTR_COMPARE
    importing
      !IT_VALUES type TT_YZTABL_RULE_VAL optional
      !IT_DATA type ANY TABLE optional
      !IS_RULE_EXE type YZTABL_RULE_EXE optional
      !IV_READ_FUNCTION type BOOLE_D optional
    exporting
      !ET_DATA type ANY TABLE
    returning
      value(RV_RESULT) type BOOLE_D .
  methods EXECUTE_FIXED_VALUE_OPERATION
    importing
      !IT_VALUES type TT_YZTABL_RULE_VAL optional
      !IT_DATA type ANY TABLE optional
      !IS_RULE_EXE type YZTABL_RULE_EXE optional
      !IV_READ_FUNCTION type BOOLE_D optional
    returning
      value(RV_RESULT) type BOOLE_D .
  methods EXECUTE_VALUE_EXPRESSION
    importing
      !IT_VALUES type TT_YZTABL_RULE_VAL optional
      !IT_DATA type ANY TABLE optional
      !IS_RULE_EXE type YZTABL_RULE_EXE
      !IV_VAL_TYPE type YZTABL_RULE_VAL-VAL_TYPE
    exporting
      !EV_VAL type CHAR30
      !ER_DATA type ref to DATA
    returning
      value(RV_RESULT) type BOOLE_D .
  methods EXECUTE_FLD_PROP_CONDITION
    importing
      !IT_RULE_EXE_ENTRY type TT_YZTABL_RULE_EXE
    changing
      !CT_FLD_PROP type ANY TABLE optional
      !CP_FLP_CONTEXT type YZTABL_FLP_CONTEXT
    returning
      value(RV_RESULT) type BOOLE_D .
  methods EXECUTE_HIDE_UIBB_CONDITION
    importing
      !IO_OVP type ref to IF_FPM_OVP
      !IT_RULE_EXE_ENTRY type TT_YZTABL_RULE_EXE
    returning
      value(RV_RESULT) type BOOLE_D .
  methods EXECUTE_SCOPE_CONDITION
    importing
      !IV_RULE_SEC type YZ_DTEL_RULE_SEC optional
      !IT_RULE_EXE_ENTRY type TT_YZTABL_RULE_EXE optional
      !IP_APP_CONTEXT type YZTABL_APPLICATION_CONTEXT optional
    exporting
      !ER_DATA type ref to DATA
      !EV_EXCEPTION_TEXT type STRING
      !ET_MESSAGE type USMD_T_MESSAGE
    returning
      value(RV_RETURN) type BOOLE_D .
  methods EXECUTE_UNIQUENESS_CHECK
    exporting
      !EV_SQL_ERROR type STRING
    changing
      !CT_ENTITY_ATTR type GTT_ENTITY_ATTR
    returning
      value(RV_RESULT) type BOOLE_D .
  methods EXECUTE_VALIDATION_UNV
    importing
      !IV_RULE_SEC type YZ_DTEL_RULE_SEC optional
      !IT_RULE_EXE_ENTRY type TT_YZTABL_RULE_EXE optional
      !IV_RULE_TYPE type YZ_DTEL_RULE_TYPE optional
      !IV_DEF_ID type YZ_DTEL_DEF_ID optional
      !IP_APP_CONTEXT type YZTABL_APPLICATION_CONTEXT
    exporting
      !ER_DATA type ref to DATA
      !EV_EXCEPTION_TEXT type STRING
      !ET_MESSAGE type USMD_T_MESSAGE
    returning
      value(RV_RETURN) type BOOLE_D .
  methods FILTER_SCOPE_CONDITION
    importing
      !IV_DEF_ID type MDQ_RULE_DEFINITION_ID optional
      !IV_RULE_TYPE type YZ_DTEL_RULE_TYPE optional
      !IV_ENTITY type USMD_ENTITY optional
    returning
      value(RT_DEF_ID) like GT_DEFINITION_IDS_PRC .
  methods GET_ENTITY_ATTR_DATA_USING_CR
    changing
      !CT_ENTITY_ATTR type GTT_ENTITY_ATTR .
  methods GET_ENTITY_ATTR_DATA_USING_GOV
    changing
      !CT_ENTITY_ATTR type GTT_ENTITY_ATTR .
  methods GET_LAST_CHARACTER
    importing
      !IV_STRING type STRING
    returning
      value(RV_LAST_CHAR) type CHAR1 .
  methods GET_RESULT_OF_EXE_ID
    importing
      !IS_RULE_EXE type YZTABL_RULE_EXE
      !IT_VAL_PRC type TT_YZTABL_RULE_VAL
      !IV_ENTITY type USMD_ENTITY optional
      !IR_DATA type ref to DATA optional
    exporting
      !EV_EXCEPTION_TEXT type STRING
    returning
      value(RV_RETURN) type BOOLE_D .
  methods GET_RULE_EXE_RECORDS
    importing
      !IT_SELECTION type USMD_TS_SEL
    returning
      value(RT_RULE_EXE_ENTRIES) type TT_YZTABL_RULE_EXE .
  methods GET_RULE_VAL_RECORDS
    importing
      !IT_SELECTION type USMD_TS_SEL
    returning
      value(RT_RULE_VAL_ENTRIES) type TT_YZTABL_RULE_VAL .
  methods IS_LOG_MAINTAINANCE_REQ
    importing
      !IV_APP_LOG_REQUIRED type BOOLE_D optional
      !IV_BR_LOG_REQUIRED type BOOLE_D optional
    returning
      value(RV_REQUIRED) type BOOLE_D .
  methods UPDATE_RULE_STATUS
    importing
      !IV_STATUS type YZ_DTEL_STATUS optional
      !IV_CONFIG_ID type WDY_CONFIG_ID optional
      !IV_MSGTXT type MSGTXT optional
      !IS_BR_CONTEXT type YZTABL_BR_CONTEXT optional
      !IT_RULE_STATUS type YZ_TTYP_RULE_STAT optional
    exporting
      !ES_RULE_STATUS type YZTABL_RULE_STA
      !ET_MESSAGE type USMD_T_MESSAGE .
  methods VALIDATE_METADETA
    importing
      !IV_ATTRIBUTE type YZ_DTEL_USMD_ATTRIBUTE
      !IV_VALUE type YZ_DTEL_LOW
    returning
      value(RV_RESULT) type BOOLE_D .
  methods VALIDATE_PREPARE_MESSAGE
    importing
      !IT_RULE_EXE_ENTRY type TT_YZTABL_RULE_EXE
      !IR_DATA type ref to DATA optional
      !ID_ENTITYTYPE type USMD_ENTITY optional
      !IO_MODEL type ref to IF_USMD_MODEL_EXT optional
    exporting
      !ET_MESSAGE type USMD_T_MESSAGE .
  methods EXECUTE_REGEX_COMPARE
    importing
      !IT_VALUES type TT_YZTABL_RULE_VAL optional
      !IT_DATA type ANY TABLE optional
      !IS_RULE_EXE type YZTABL_RULE_EXE optional
      !IV_READ_FUNCTION type BOOLE_D optional
    returning
      value(RV_RESULT) type BOOLE_D .
  class-methods COLLECT_EXCEPTIONS
    importing
      !IV_EXCEPTION type STRING
    returning
      value(RT_MESSAGE) type USMD_T_MESSAGE .
  methods GET_DEPENDENT_FILTER
    importing
      !IV_ENTITY type USMD_ENTITY optional
      !IS_RULE_EXE type YZTABL_RULE_EXE optional
      !IP_APP_CONTEXT type YZTABL_APPLICATION_CONTEXT optional
    exporting
      value(ET_KEY_VAL) type GTT_KEY_VALUE_NK .
ENDCLASS.



CLASS YZ_CLAS_MDG_ACCELERATOR IMPLEMENTATION.


  METHOD class_constructor.
*****************************************************************************************
* Program Change History
*****************************************************************************************
* MOD-XXX       :
* Date          :
* Change No     :
* WRICEF-ID     :
* Defect-ID     :
* Transport     :
* Developer ID  :
* Release ID    :
*
**************************************************************************************
*--------------------------------------------------------------------*
*All Custom Tables Covered in Entire Application
*  Will be in Global Memory Always
*--------------------------------------------------------------------*
    "where clause for the mandt = sy-mandt given to remove the ATC checks
    "Rule Domain
    SELECT * FROM yztabl_rule_dom WHERE active = @abap_true INTO TABLE @gt_yztabl_rule_dom .
    "Rule Type Data
    SELECT * FROM yztabl_rule_typ WHERE rule_type IS NOT INITIAL INTO TABLE @gt_yztabl_rule_typ.
    "Rule Section Data
    SELECT * FROM yztabl_rule_sec WHERE rule_sec IS NOT INITIAL INTO TABLE @gt_yztabl_rule_sec.
    "Rule Task Data
    SELECT * FROM yztabl_rule_tas WHERE task IS NOT INITIAL INTO TABLE @gt_yztabl_rule_tas.
    "RUle Operation Data
    SELECT * FROM yztabl_rule_opr WHERE operation IS NOT INITIAL INTO TABLE @gt_yztabl_rule_opr.
    "Rule Execution Type
    SELECT * FROM yztabl_rule_ety WHERE exe_type IS NOT INITIAL INTO TABLE @gt_yztabl_rule_ety.
    "Rule Value Type
    SELECT * FROM yztabl_rule_vlt WHERE val_type IS NOT INITIAL INTO TABLE @gt_yztabl_rule_vlt.

    set_application_context( ).

  ENDMETHOD.


  METHOD execute_uniqueness_check.
    DATA : lo_data_tab TYPE REF TO data.
    FIELD-SYMBOLS: <lt_table> TYPE ANY TABLE.

    "get the CR data
    CASE gs_app_context-rule_type.
      WHEN gc_execute_validation_unique.
        get_entity_attr_data_using_cr( CHANGING ct_entity_attr =  ct_entity_attr ).
      WHEN gc_execute_dyn_unique.
        get_entity_attr_data_using_gov( CHANGING ct_entity_attr =  ct_entity_attr ).
      WHEN OTHERS.
    ENDCASE.



    get_dynamic_table_str( EXPORTING it_entity_attr = ct_entity_attr
                           IMPORTING eo_dataref       = DATA(lo_dataref) ).

    ASSIGN lo_dataref->* TO <lt_table>.

    IF <lt_table> IS ASSIGNED.
      DATA(lv_select_clause) = get_dynamic_select_clause( it_entity_attr =  ct_entity_attr ).
      DATA(lv_join_clause)   = get_dynamic_join_clause( it_entity_attr = ct_entity_attr ).
      DATA(lv_where_clause)  = get_dynamic_where_clause( it_entity_attr = ct_entity_attr ).

      "execute the dynamic SQL
      TRY .
          SELECT (lv_select_clause) FROM (lv_join_clause) WHERE (lv_where_clause) INTO TABLE @<lt_table> .
        CATCH cx_sy_dynamic_osql_syntax INTO DATA(lo_obj).
          data(lv_syntax_error) = lo_obj->get_text( ).
          collect_exceptions( lo_obj->get_text( )  ).
        CATCH cx_sy_dynamic_osql_semantics INTO DATA(lo_semantic).
          data(lv_semantic_error) = lo_semantic->get_text( ).
          collect_exceptions( lo_semantic->get_text( )  ).
      ENDTRY.
    ENDIF.

    rv_result = COND #( WHEN sy-subrc EQ 0 AND lv_syntax_error IS INITIAL  AND lv_semantic_error IS INITIAL AND <lt_table> IS NOT INITIAL
                        THEN abap_false
                        ELSE abap_true ).
    ev_sql_error = COND #( WHEN lv_syntax_error IS NOT INITIAL THEN lv_syntax_error
                           WHEN lv_semantic_error IS NOT INITIAL THEN lv_semantic_error
                           ELSE '' ).




  ENDMETHOD.


  METHOD get_appl_header.
    TRY .
        DATA(ls_log_stat)   = gt_yztabl_rule_log[ model = COND #( WHEN iv_model IS NOT INITIAL THEN iv_model
                                                                       ELSE get_model_by_cr( iv_crequest = get_cr_number( ) ) )
                                                process = iv_exe_type ].

        rv_balhdri-object    = ls_log_stat-obj.
        rv_balhdri-subobject = ls_log_stat-sub_obj.
      CATCH cx_sy_itab_line_not_found into data(lo_error).
        collect_exceptions( lo_error->get_text( )  ).

    ENDTRY.


  ENDMETHOD.


  METHOD build_message_for_exception.

    et_message = VALUE #( (  msgid = yz_intf_mdg_accelerator_const=>gc_mapper_message_id
                             msgno = '032'
                             msgty = 'I'
                             msgv1 = gs_app_context-rule_type
                             msgv2 = iv_text ) ).
  ENDMETHOD.


  METHOD constructor.

    super->constructor( iv_model ).

    set_application_context( is_app_context ).

    TRY.
        IF data IS BOUND.
          data->set_entity_data( iv_entity = gc_entity_yyorgunit
                                 it_data   = get_org_str_values_for_user( sy-uname ) ).
        ENDIF.

      CATCH cx_root INTO DATA(lr_error).
        collect_exceptions( lr_error->get_text( )  ).
    ENDTRY.

    "get the data from the all the table to create the source table
    filter_scope_condition( ).

  ENDMETHOD.


  METHOD execute_dblookup.

    DATA : lr_table_field     TYPE REF TO data.
    FIELD-SYMBOLS : <lt_data> TYPE ANY TABLE.

    IF iv_read_function IS NOT INITIAL.
      DATA(ls_table_field) = gt_yztabl_metadata[ model = gs_app_context-model entity = is_rule_exe-entity attribute = is_rule_exe-attribute ].
      DATA(lv_table_field) = ls_table_field-tabname && '-' && ls_table_field-fieldname.
      CREATE DATA lr_table_field TYPE (lv_table_field).

      create_attribute_range_table( EXPORTING iv_attribute   = CONV #( is_rule_exe-attribute )
                                              it_data        = it_data
                                              ir_table_field = lr_table_field
                                    IMPORTING er_data        = DATA(lr_data) ).
      ASSIGN lr_data->* TO <lt_data>.
    ELSE.
      ASSIGN it_data TO <lt_data>.
    ENDIF.

    IF <lt_data> IS ASSIGNED.

      LOOP AT it_values INTO DATA(ls_values).
        DATA(lv_db_table) = substring_before( val = ls_values-low sub = '-' ).
        DATA(lv_db_field) = substring_after(  val = ls_values-low sub = '-' ).

        IF lv_db_table IS NOT INITIAL AND lv_db_field IS NOT INITIAL .

          DATA(lv_where)  = | { lv_db_field } IN @<LT_DATA> |.
          "execute the dynamic SQL
          TRY .
              SELECT @abap_true AS data_exist
                FROM (lv_db_table)
               WHERE (lv_where)
                INTO @rv_result UP TO 1 ROWS. ENDSELECT.

              IF sy-subrc = 0.
                EXIT.
              ENDIF.

            CATCH cx_sy_dynamic_osql_syntax INTO DATA(lo_obj).
              collect_exceptions( lo_obj->get_text( ) ).
            CATCH cx_sy_dynamic_osql_semantics INTO DATA(lo_semantic).
              collect_exceptions( lo_semantic->get_text( ) ).
          ENDTRY.

        ENDIF.

      ENDLOOP.

    ENDIF.

  ENDMETHOD.


  METHOD execute_entity_attr_compare.

    DATA : lr_table_field     TYPE REF TO data.
    FIELD-SYMBOLS : <lt_data> TYPE ANY TABLE.

    LOOP AT it_values INTO DATA(ls_values).

      data->get_entity_data(
        EXPORTING
          iv_crequest  = gs_app_context-crequest
          it_key_value = gs_app_context-key_value
          iv_entity    = CONV #( substring_before( val = ls_values-low sub = '-' ) )
        IMPORTING
          er_data      = DATA(lr_entity_data) ).

      ASSIGN lr_entity_data->* TO FIELD-SYMBOL(<ft_data>).

      CASE is_rule_exe-task.

        WHEN gc_rule_task_check.
          DATA(lv_source) = '@<FT_DATA>'.
          IF iv_read_function IS NOT INITIAL.
            DATA(ls_table_field) = gt_yztabl_metadata[ model = gs_app_context-model entity    = CONV #( substring_before( val = ls_values-low sub = '-' ) )
                                                                                    attribute = CONV #( substring_after( val = ls_values-low sub = '-' ) ) ].
            DATA(lv_table_field) = ls_table_field-tabname && '-' && ls_table_field-fieldname.
            CREATE DATA lr_table_field TYPE (lv_table_field).

            create_attribute_range_table( EXPORTING iv_attribute   = CONV #( is_rule_exe-attribute )
                                                    it_data        = it_data
                                                    ir_table_field = lr_table_field
                                          IMPORTING er_data        = DATA(lr_data) ).
            ASSIGN lr_data->* TO <lt_data>.
          ELSE.
            ASSIGN it_data TO <lt_data>.
          ENDIF.

          DATA(lv_where)  = | { substring_after( val = ls_values-low sub = '-' ) } IN @<LT_DATA> |.

          TRY .
              SELECT SINGLE @abap_true   AS rv_result
                       FROM (lv_source)  AS itab
                      WHERE (lv_where) INTO @rv_result.

            CATCH cx_sy_dynamic_osql_semantics INTO DATA(lo_error).
              collect_exceptions( lo_error->get_text( ) ).
          ENDTRY.

          IF sy-subrc = 0.
            EXIT.
          ENDIF.

        WHEN OTHERS.
      ENDCASE.

    ENDLOOP.

  ENDMETHOD.


  METHOD execute_fixed_value_operation.

    DATA(lv_source) = '@IT_DATA'.
    DATA(lr_values) = VALUE r_values( FOR <fs_value> IN it_values  ( sign  = <fs_value>-sign
                                                                    option = <fs_value>-opt
                                                                       low = <fs_value>-low
                                                                      high = <fs_value>-high ) ).
    IF iv_read_function = abap_true.
      DATA(lv_where)  = | { is_rule_exe-attribute } IN @LR_VALUES |.
    ELSE.
      lv_where  = | LOW IN @LR_VALUES |.
    ENDIF.

    CASE is_rule_exe-task.
      WHEN gc_rule_task_check.
        TRY.
            SELECT  @abap_true AS rv_result
              FROM (lv_source) AS itab
             WHERE (lv_where)  INTO @rv_result UP TO 1 ROWS.
            ENDSELECT.

          CATCH cx_sy_dynamic_osql_semantics INTO DATA(lo_error).
            collect_exceptions( lo_error->get_text( )  ).
        ENDTRY.

      WHEN OTHERS.

    ENDCASE.

  ENDMETHOD.


  METHOD set_application_context.

*--------------------------------------------------------------------*
*Clean UP Buffer Global Context Objects
*--------------------------------------------------------------------*
    clean_up( iv_usmd_crequest = is_app_context-crequest iv_rule_type = is_app_context-rule_type ).

*--------------------------------------------------------------------*
*Overriding Parameters
*--------------------------------------------------------------------*
    IF is_app_context IS NOT INITIAL.

      gs_app_context-model          = COND #( WHEN is_app_context-model          IS NOT INITIAL THEN is_app_context-model
                                                                                                ELSE gs_app_context-model ).

      gs_app_context-otc            = COND #( WHEN is_app_context-otc            IS NOT INITIAL THEN is_app_context-otc
                                                                                                ELSE gs_app_context-otc ).

      gs_app_context-crequest_type  = COND #( WHEN is_app_context-crequest_type  IS NOT INITIAL THEN is_app_context-crequest_type
                                                                                                ELSE gs_app_context-crequest_type ).

      gs_app_context-crequest       = COND #( WHEN is_app_context-crequest       IS NOT INITIAL THEN is_app_context-crequest
                                                                                                ELSE gs_app_context-crequest ).

      gs_app_context-changerequest_id = gs_app_context-crequest.


      gs_app_context-crequest_step  = COND #( WHEN is_app_context-crequest_step  IS NOT INITIAL THEN is_app_context-crequest_step
                                                                                                ELSE gs_app_context-crequest_step ).

      gs_app_context-cr_created_by  = COND #( WHEN is_app_context-cr_created_by  IS NOT INITIAL THEN is_app_context-cr_created_by
                                                                                                ELSE gs_app_context-cr_created_by ).

      gs_app_context-rule_usage     = COND #( WHEN is_app_context-rule_usage     IS NOT INITIAL THEN is_app_context-rule_usage
                                                                                                ELSE gs_app_context-rule_usage ).

      gs_app_context-rule_stage     = COND #( WHEN is_app_context-rule_stage     IS NOT INITIAL THEN is_app_context-rule_stage
                                                                                                ELSE gs_app_context-rule_stage ).

      gs_app_context-rule_purpose   = COND #( WHEN is_app_context-rule_purpose   IS NOT INITIAL THEN is_app_context-rule_purpose
                                                                                                ELSE gs_app_context-rule_purpose ).

      gs_app_context-entity_main    = COND #( WHEN is_app_context-current_entity IS NOT INITIAL THEN is_app_context-entity_main
                                                                                                ELSE gs_app_context-entity_main ).

      gs_app_context-current_entity = is_app_context-current_entity."Current Entity needs to be Passed everytime


      gs_app_context-rule_type      = is_app_context-rule_type."Rule Type to be Passed everytime


      gs_app_context-creq_status    = COND #( WHEN is_app_context-creq_status    IS NOT INITIAL THEN is_app_context-creq_status
                                                                                                ELSE gs_app_context-creq_status ).

      gs_app_context-usmd_process   = COND #( WHEN is_app_context-usmd_process   IS NOT INITIAL THEN is_app_context-usmd_process
                                                                                                ELSE gs_app_context-usmd_process ).

      gs_app_context-service_name   = COND #( WHEN is_app_context-service_name   IS NOT INITIAL THEN is_app_context-service_name
                                                                                                ELSE gs_app_context-service_name ).

      gs_app_context-online_check   = COND #( WHEN is_app_context-online_check   IS NOT INITIAL THEN is_app_context-online_check
                                                                                                ELSE gs_app_context-online_check ).

      gs_app_context-parallel_cr    = COND #( WHEN is_app_context-online_check   IS NOT INITIAL THEN is_app_context-parallel_cr
                                                                                                ELSE gs_app_context-parallel_cr ).

      gs_app_context-usmd_edition   = COND #( WHEN is_app_context-usmd_edition   IS NOT INITIAL THEN is_app_context-usmd_edition
                                                                                                ELSE gs_app_context-usmd_edition ).

      gs_app_context-key_value      = COND #( WHEN is_app_context-key_value      IS NOT INITIAL THEN is_app_context-key_value
                                                                                                ELSE gs_app_context-key_value ).

      IF gs_app_context-rule_type  IS NOT INITIAL.
        DATA(ls_app_log_obj) = get_appl_header( iv_exe_type = gs_app_context-rule_type
                                                iv_model    = CONV #( gs_app_context-model )  ).
        IF ls_app_log_obj IS NOT INITIAL.
          gs_app_context-app_object  = ls_app_log_obj-object.
          gs_app_context-app_sub_obj = ls_app_log_obj-subobject.
        ENDIF.
      ENDIF.

*--------------------------------------------------------------------*
* Set API Instances
*--------------------------------------------------------------------*
      gs_app_context-o_model        = COND #( WHEN is_app_context-o_model        IS NOT INITIAL THEN is_app_context-o_model
                                                                                                ELSE gs_app_context-o_model ).

      gs_app_context-o_ovp          = COND #( WHEN is_app_context-o_ovp          IS NOT INITIAL THEN is_app_context-o_ovp
                                                                                                ELSE gs_app_context-o_ovp ).

      gs_app_context-o_changed_data = COND #( WHEN is_app_context-o_changed_data IS NOT INITIAL THEN is_app_context-o_changed_data
                                                                                                ELSE gs_app_context-o_changed_data ).

      gs_app_context-o_write_data   = COND #( WHEN is_app_context-o_write_data   IS NOT INITIAL THEN is_app_context-o_write_data
                                                                                                ELSE gs_app_context-o_write_data ).

    ENDIF.

*--------------------------------------------------------------------*
*Session Parameters
*--------------------------------------------------------------------*
    gs_app_context-crequest      = COND #( WHEN gs_app_context-crequest      IS INITIAL THEN get_cr_number( )
                                                                                        ELSE gs_app_context-crequest ).

    gs_app_context-model         = COND #( WHEN gs_app_context-model         IS INITIAL THEN get_data_model( gs_app_context-crequest )
                                                                                        ELSE gs_app_context-model ).

    gs_app_context-crequest_type = COND #( WHEN gs_app_context-crequest_type IS INITIAL THEN get_cr_type( gs_app_context-crequest )
                                                                                        ELSE gs_app_context-crequest_type ).

    gs_app_context-parallel_cr   = COND #( WHEN is_app_context-parallel_cr   IS INITIAL THEN cl_usmd2_cust_access_service=>is_parallel_cr_type( gs_app_context-crequest_type  )
                                                                                        ELSE gs_app_context-parallel_cr ).

    gs_app_context-usmd_process  = COND #( WHEN gs_app_context-usmd_process  IS INITIAL THEN get_cr_business_activity( gs_app_context-crequest_type )
                                                                                        ELSE gs_app_context-usmd_process ).

    gs_app_context-otc           = COND #( WHEN gs_app_context-otc           IS INITIAL THEN get_cr_otc( iv_model = gs_app_context-model )
                                                                                        ELSE gs_app_context-otc ).

    gs_app_context-crequest_step = COND #( WHEN gs_app_context-crequest_step IS INITIAL THEN get_cr_step( gs_app_context-crequest )
                                                                                        ELSE gs_app_context-crequest_step ).

    gs_app_context-cr_created_by = COND #( WHEN gs_app_context-cr_created_by IS INITIAL
                                           THEN get_cr_details( iv_cr_number = gs_app_context-crequest )-usmd_created_by
                                           ELSE gs_app_context-cr_created_by ).

*    gs_app_context-rule_stage    = COND #( WHEN gs_app_context-crequest IS NOT INITIAL AND gs_app_context-rule_stage IS INITIAL
*                                           THEN 'MDF' ELSE gs_app_context-rule_stage ).

    IF gs_app_context-rule_stage EQ 'MDF' AND gs_app_context-rule_usage IS INITIAL.
      gs_app_context-rule_usage = 'MDF_CHECK'.
    ENDIF.

    gs_app_context-entity_main   = COND #( WHEN gs_app_context-entity_main IS INITIAL  THEN get_cr_main_entity( iv_model              = gs_app_context-model
                                                                                                                iv_usmd_crequest_type = gs_app_context-crequest_type
                                                                                                                iv_otc                = gs_app_context-otc  )
                                           ELSE gs_app_context-entity_main ).

    IF gs_app_context-usmd_edition IS INITIAL.
      cl_usmd_crequest_util=>get_edition_from_cr( EXPORTING i_crequest = gs_app_context-crequest IMPORTING e_edition = gs_app_context-usmd_edition ).
    ENDIF.

    IF gs_app_context-rule_stage EQ 'MDF'.
      gs_app_context-context_name  = gs_app_context-rule_usage.
      gs_app_context-context_value = gs_app_context-crequest.
    ENDIF.

    IF data IS BOUND.

      IF gs_app_context-rule_stage IS INITIAL AND ( gs_app_context-crequest_type IS NOT INITIAL OR
                                                    gs_app_context-crequest_step IS NOT INITIAL ).

        gs_app_context-value_pair = VALUE #( ( element = 'RULE_STAG' value = 'MDG' )
                                             ( element = 'RULE_STAG' value = 'MDF' ) ).
      ELSE.
        gs_app_context-value_pair = VALUE #( ( element = 'RULE_STAG' value = gs_app_context-rule_stage ) ) .

      ENDIF.

      LOOP AT gs_app_context-value_pair INTO DATA(ls_data).

        data->set_entity_data( iv_entity = gc_entity_yyusage
                                it_data  = VALUE tt_yyusage( ( cr_type    = gs_app_context-crequest_type
                                                                cr_step   = gs_app_context-crequest_step
                                                                rule_stag = ls_data-value ) ) ).
      ENDLOOP.

    ENDIF.

  ENDMETHOD.


  METHOD yz_intf_mdg_accelerator~execute_business_rules.

    is_my_obj_registered( ).

    IF ip_app_context IS NOT INITIAL.
      set_application_context( ip_app_context ).
    ENDIF.

*--------------------------------------------------------------------*
*Convert MDC To Staging Data and Setting All Entites
*--------------------------------------------------------------------*
    IF gs_app_context-key_value IS NOT INITIAL
   AND gs_app_context-rule_stage <> 'MDF'
   AND gs_app_context-rule_stage <> 'MDG'.
*  Create Method in Data Class - and call it via below code
      get_data_service( iv_model = gs_app_context-model )->set_entity_data(
      EXPORTING
        iv_entity       = 'MDC2STAGE'
        it_data         = gs_app_context-key_value
        ).
    ENDIF.
*--------------------------------------------------------------------*

*--------------------------------------------------------------------*
*Get Data of Root Entity
*--------------------------------------------------------------------*
    IF data IS INITIAL.
      data ?= get_data_service( iv_model = gs_app_context-model ).
    ENDIF.
    IF data IS BOUND.

      data->get_entity_data(
        EXPORTING
          iv_crequest  = gs_app_context-crequest
          iv_entity    = gs_app_context-entity_main
          it_key_value = gs_app_context-key_value
        IMPORTING
          er_data      = DATA(lr_data) ).

      ASSIGN lr_data->* TO FIELD-SYMBOL(<ft_data>).

    ENDIF.
*--------------------------------------------------------------------*
    IF <ft_data> IS ASSIGNED.


      LOOP AT <ft_data> ASSIGNING FIELD-SYMBOL(<fs_data>).

        IF lines( <ft_data> ) > 1."Only Require For Mass CR Processing
          gs_app_context-key_value = get_key_value_table( iv_entity = gs_app_context-entity_main is_record = <fs_data> ).
        ENDIF.

        LOOP AT filter_scope_condition( iv_def_id = iv_def_id )  INTO DATA(ls_def_id_prc).

          DATA(lt_yztabl_rule_exe_prc) = FILTER tt_yztabl_rule_exe( gt_yztabl_rule_exe_prc USING KEY filter_def WHERE def_id = ls_def_id_prc-def_id ).

          IF ls_def_id_prc-reuse_scp  IS NOT INITIAL.
            lt_yztabl_rule_exe_prc  = VALUE #( BASE lt_yztabl_rule_exe_prc FOR ls_rule_exe IN gt_yztabl_rule_exe_src USING KEY filter_def
                                              WHERE ( def_id = ls_def_id_prc-refruleid AND rule_sec = gc_rule_section_scope ) ( ls_rule_exe ) ).
          ENDIF.


          IF iv_rule_sec = gc_rule_section_condition OR
             execute_definition_id( EXPORTING iv_def_id         = ls_def_id_prc-def_id
                                              it_rule_exe_entry = lt_yztabl_rule_exe_prc
                                              iv_rule_sec       = gc_rule_section_scope
                                              ip_app_context    = gs_app_context ) EQ abap_true.

            IF iv_rule_sec = gc_rule_section_scope.
              rv_result = abap_true.
              IF iv_def_id = ls_def_id_prc-def_id.
                EXIT.
              ELSE.
                CONTINUE.
              ENDIF.
            ENDIF.

*--------------------------------------------------------------------*
*Add Logic for Dynamic Agent , Loop Workflow And Uniqueness App
*--------------------------------------------------------------------*

*--------------------------------------------------------------------*
            DATA(lv_result) = execute_definition_id( EXPORTING iv_def_id         = ls_def_id_prc-def_id
                                                               it_rule_exe_entry = lt_yztabl_rule_exe_prc
                                                               iv_rule_sec       = gc_rule_section_condition
                                                               ip_app_context    = gs_app_context
                                                     IMPORTING et_message        = et_message
                                                     CHANGING  cp_flp_context    = cp_flp_context
                                                               cp_dyn_context    = cp_dyn_context ).

            IF iv_rule_sec = gc_rule_section_condition.
              rv_result = lv_result.
              IF iv_def_id = ls_def_id_prc-def_id.
                EXIT.
              ENDIF.
            ENDIF.

          ENDIF.

        ENDLOOP.

      ENDLOOP.

    ENDIF.

  ENDMETHOD.


  METHOD execute_fld_prop_condition.

    assign cp_flp_context-fld_prop->* to FIELD-SYMBOL(<lfs_ct_flp_prop>).
    IF <lfs_ct_flp_prop> IS ASSIGNED.


    LOOP AT it_rule_exe_entry INTO DATA(ls_rule_exe) USING KEY filter_key WHERE rule_sec EQ gc_rule_section_condition.

      DATA(lt_yztabl_rule_val_prc) = VALUE tt_yztabl_rule_val( FOR ls_rule_val IN gt_yztabl_rule_val_src USING KEY filter_exe WHERE ( exe_id = ls_rule_exe-exe_id ) ( ls_rule_val ) ).

      LOOP AT <lfs_ct_flp_prop> ASSIGNING FIELD-SYMBOL(<ls_ctfld>).
        IF <ls_ctfld> IS ASSIGNED.
          ASSIGN COMPONENT 'USMD_FP' OF STRUCTURE <ls_ctfld> TO FIELD-SYMBOL(<ls_usmd>).
          IF sy-subrc IS INITIAL AND <ls_usmd> IS ASSIGNED.

            TRY.
                DATA(lv_value) = lt_yztabl_rule_val_prc[ 1 ]-low.

                IF assign_to( EXPORTING component_name =  CONV #( ls_rule_exe-attribute )
                                                      value =  lv_value
                                            CHANGING structure = <ls_usmd>  ) EQ 0.
                  IF lv_value EQ 'M'.
                    "if the field proprty is SEt to M then check if the value is already populated.
                    "if not then raise the global message
                    TRY.

                        data->get_entity_data(
                           EXPORTING
                             iv_crequest  = gs_app_context-crequest
                             iv_entity    = ls_rule_exe-entity
                             it_key_value = gs_app_context-key_value
                           IMPORTING
                             er_data     = DATA(lr_data) ).

                            ASSIGN lr_data->* TO FIELD-SYMBOL(<lt_data>).
                            IF <lt_data> IS ASSIGNED.
                              LOOP AT <lt_data> ASSIGNING FIELD-SYMBOL(<fs_data>).
                                ASSIGN COMPONENT ls_rule_exe-attribute OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_val>).
                                IF <fs_val> IS NOT ASSIGNED OR <fs_val> IS INITIAL.
                                  add_to_global_message( it_message = VALUE #( ( msgid  = yz_intf_mdg_accelerator_const~gc_msg_clas_name
                                                                                 msgty  = yz_intf_mdg_accelerator_const~gc_msg_type_e
                                                                                 msgno  = 012
                                                                                 msgv1  = CONV #( ls_rule_exe-attribute  ) ) ) ).
                                ENDIF.
                              ENDLOOP.
                            ENDIF.

                      CATCH cx_root INTO DATA(lr_error).
                        collect_exceptions( lr_error->get_text( )  ).
                        DATA(lv_error) = lr_error->get_text( ).
                    ENDTRY.


                  ENDIF.
                  rv_result = 'S'.
                ELSE.

                  rv_result = 'F'.
                  EXIT.
                ENDIF.

              CATCH cx_sy_itab_line_not_found INTO DATA(lr_exception).
                collect_exceptions( lr_exception->get_text( )  ).
                DATA(lv_exception_fp_txt) = lr_exception->get_text( ).
                add_to_global_message( build_message_for_exception( lv_exception_fp_txt ) ).
                rv_result = 'F'.
                EXIT.
            ENDTRY.

          ENDIF.

        ENDIF.

      ENDLOOP.

      update_rule_status( EXPORTING iv_status      =  COND #( WHEN rv_result EQ gc_fail THEN gc_fail
                                                                       ELSE gc_pass )               " Status
                                             iv_msgtxt      = COND #( WHEN lv_exception_fp_txt IS NOT INITIAL THEN CONV char100( lv_exception_fp_txt ) )                " Message Text
                                             is_br_context  = VALUE #( model = gs_app_context-model
                                                                       def_id = ls_rule_exe-def_id
                                                                       entity = ls_rule_exe-entity
                                                                       attribute = ls_rule_exe-attribute
                                                                       exe_type = ls_rule_exe-rule_type )
                                   IMPORTING es_rule_status = DATA(ls_rule_status)  ).

      create_app_log( is_message        =  COND #( WHEN lv_exception_fp_txt IS NOT INITIAL THEN CONV char100( lv_exception_fp_txt ) )
                              is_rule_status    =  ls_rule_status ).
      CLEAR :  lv_exception_fp_txt.
    ENDLOOP.

    ENDIF.

  ENDMETHOD.


  METHOD execute_hide_uibb_condition.

    LOOP AT it_rule_exe_entry ASSIGNING FIELD-SYMBOL(<ls_rule_exe_entry>).

      IF <ls_rule_exe_entry>-entity EQ 'YYHIDEUI'.
      SELECT * FROM @gt_yztabl_rule_val_prc AS itab WHERE exe_id = @<ls_rule_exe_entry>-exe_id
          INTO TABLE @DATA(lt_val_hideuibb).

      LOOP AT lt_val_hideuibb INTO DATA(ls_value).
        TRY.
            io_ovp->get_uibbs( IMPORTING et_uibb = DATA(lt_uibb) ). " Getting All UIBBs from the Round Trip


            LOOP AT lt_uibb ASSIGNING FIELD-SYMBOL(<ls_uibbs>) WHERE config_id = ls_value-low ."where component = '<THE_UIBB_WD_COMPONENT>'.
              <ls_uibbs>-hidden = abap_true.                "Hiding the UIBB
              TRY.
                  CALL METHOD io_ovp->change_uibb
                    EXPORTING
                      is_uibb                  = <ls_uibbs>
                      iv_add_uibb_to_new_stack = abap_false.
                CATCH cx_fpm_floorplan INTO DATA(lo_fpm_floorplan).
                  collect_exceptions( lo_fpm_floorplan->get_text( )  ).
                  DATA(lv_fpm_exception) = lo_fpm_floorplan->get_text( ).
                  rv_result = 'O'.
                  EXIT.
              ENDTRY.

            ENDLOOP.
          CATCH cx_fpm_floorplan INTO DATA(lx_fpm_floorplan).
            collect_exceptions( lx_fpm_floorplan->get_text( )  ).
            lv_fpm_exception = lx_fpm_floorplan->get_text( ).
            rv_result = 'O'.
            EXIT.
        ENDTRY.

      ENDLOOP.

      update_rule_status( EXPORTING iv_status      =  COND #( WHEN lv_fpm_exception IS NOT INITIAL THEN yz_intf_mdg_accelerator_const=>gc_fail
                                                                       ELSE yz_intf_mdg_accelerator_const=>gc_pass )               " Status
                                             iv_msgtxt      = COND #( WHEN lv_fpm_exception IS NOT INITIAL THEN CONV char100( lv_fpm_exception ) )                " Message Text
                                             is_br_context  = VALUE #( model     = gs_app_context-model
                                                                       def_id    = <ls_rule_exe_entry>-def_id
                                                                       exe_type  = gs_app_context-rule_type )
                                   IMPORTING es_rule_status = DATA(ls_rule_status)  ).
      create_app_log( is_message        =  COND #( WHEN lv_fpm_exception IS NOT INITIAL THEN CONV char100( lv_fpm_exception ) )
                              is_rule_status    =  ls_rule_status ).

      ENDIF.

    ENDLOOP.

    rv_result = COND #( WHEN rv_result IS NOT INITIAL THEN rv_result
                        ELSE 'S' ).
  ENDMETHOD.


  METHOD get_org_str_values_for_user.

    DATA(lt_positions) = get_position_for_user( iv_user ).
    DATA(lt_jobs)      = get_job_for_user( iv_user ).
    DATA(lt_roles)     = get_roles_for_user( iv_user ).

    rt_data = VALUE tt_yyorgunit( BASE rt_data FOR ls_roles IN lt_roles ( role = ls_roles-agr_name ) ).
    rt_data = VALUE tt_yyorgunit( BASE rt_data FOR ls_position IN lt_positions ( position = ls_position-sobid ) ).
    rt_data = VALUE tt_yyorgunit( BASE rt_data FOR ls_jobs IN lt_jobs ( job = ls_jobs-sobid ) ).
    rt_data = VALUE tt_yyorgunit( BASE rt_data ( user = sy-uname ) ).
    rt_data = VALUE tt_yyorgunit( BASE rt_data ( function = to_upper( get_user_addr_detail( iv_user )-function ) ) ).
    rt_data = VALUE tt_yyorgunit( BASE rt_data ( department = to_upper( get_user_addr_detail( iv_user )-department ) ) ).

  ENDMETHOD.


  METHOD execute_dynamic_agent_cond.
    DATA: lt_user_agent_group	    TYPE usmd_t_user_agent_group,
          ls_user_agent_group     LIKE LINE OF lt_user_agent_group,
          lt_user_agent           TYPE usmd_t_user_agent,
          ls_user_agent           LIKE LINE OF lt_user_agent,
          lv_metadata_ok          TYPE boole_d VALUE abap_true,
          lt_non_user_agent_group	TYPE usmd_t_non_user_agent_group,
          ls_non_user_agent_group	LIKE LINE OF lt_non_user_agent_group.

    LOOP AT it_rule_exe_entry INTO DATA(ls_rule_exe) USING KEY key_task WHERE task EQ gc_rule_task_execute.
      DATA(lt_yztabl_rule_val_prc) = VALUE tt_yztabl_rule_val( FOR ls_rule_val IN gt_yztabl_rule_val_src
                                         USING KEY filter_exe WHERE ( exe_id = ls_rule_exe-exe_id ) ( ls_rule_val ) ).
      CASE ls_rule_exe-entity.
        WHEN 'YYDYNAGEN'.
          LOOP AT lt_yztabl_rule_val_prc INTO DATA(ls_rule_value).
            CASE ls_rule_exe-attribute.
              WHEN 'AGENT_GRP'.
                ls_user_agent_group-agent_group = ls_rule_value-low.
                ls_non_user_agent_group-agent_group = ls_rule_value-low.
              WHEN 'NWF_STEP'.
                lv_metadata_ok = validate_metadeta( iv_attribute = ls_rule_exe-attribute  iv_value = ls_rule_value-low ).
                IF lv_metadata_ok EQ abap_false.
                  et_message = VALUE #( ( msgid = 'YZMSG_MDG_ACC' ) ( msgno = '39' )
                                        ( msgty = 'E' ) ( msgv1 = ls_rule_exe-def_id ) ( msgv2 = 'New Workflow Step' )
                                        ( msgv3 = ls_rule_value-low ) ).
                  CLEAR: cp_dyn_context-new_step.
                  CONTINUE.
                ENDIF.
                cp_dyn_context-new_step       = ls_rule_value-low.
              WHEN 'CR_STATUS'.
                lv_metadata_ok = validate_metadeta( iv_attribute = ls_rule_exe-attribute  iv_value = ls_rule_value-low ).
                IF lv_metadata_ok EQ abap_false.
                  et_message = VALUE #( ( msgid = 'YZMSG_MDG_ACC' ) ( msgno = '39' )
                                        ( msgty = 'E' ) ( msgv1 = ls_rule_exe-def_id ) ( msgv2 = 'Change request status' )
                                        ( msgv3 = ls_rule_value-low ) ).
                  CLEAR: cp_dyn_context-new_cr_status.
                  CONTINUE.
                ENDIF.
                cp_dyn_context-new_cr_status  = ls_rule_value-low.
              WHEN 'STEP_TYPE'.
                lv_metadata_ok = validate_metadeta( iv_attribute = ls_rule_exe-attribute  iv_value = ls_rule_value-low ).
                IF lv_metadata_ok EQ abap_false.
                  et_message = VALUE #( ( msgid = 'YZMSG_MDG_ACC' ) ( msgno = '39' )
                                        ( msgty = 'E' ) ( msgv1 = ls_rule_exe-def_id ) ( msgv2 = 'Step Type' )
                                        ( msgv3 = ls_rule_value-low ) ).
                  CLEAR: ls_user_agent_group-step_type.
                  CONTINUE.
                ENDIF.
                ls_user_agent_group-step_type = ls_rule_value-low.
              WHEN 'USER_TYPE'.
                lv_metadata_ok = validate_metadeta( iv_attribute = ls_rule_exe-attribute  iv_value = ls_rule_value-low ).
                IF lv_metadata_ok EQ abap_false.
                  et_message = VALUE #( ( msgid = 'YZMSG_MDG_ACC' ) ( msgno = '39' )
                                        ( msgty = 'E' ) ( msgv1 = ls_rule_exe-def_id ) ( msgv2 = 'User Type' )
                                        ( msgv3 = ls_rule_value-low ) ).
                  CLEAR: ls_user_agent-user_type.
                  CONTINUE.
                ENDIF.
                ls_user_agent-user_type = ls_rule_value-low.
              WHEN 'USER_VALU'.
*                lv_metadata_ok = validate_metadeta( iv_attribute = ls_rule_exe-attribute  iv_value = ls_rule_value-low ).
                ls_user_agent-user_value = ls_rule_value-low.

              WHEN 'PRC_PATRN'.
                ls_non_user_agent_group-process_pattern = ls_rule_value-low.
                DATA(lv_non_agent_act) = abap_true.
              WHEN 'YZ_DYN_AGENT_WF_STEP'.
                ls_non_user_agent_group-service_name = ls_rule_value-low.
              WHEN OTHERS.
            ENDCASE.
            CLEAR lv_metadata_ok.
            IF ls_user_agent-user_type IS NOT INITIAL AND ls_user_agent-user_value IS NOT INITIAL.
              APPEND ls_user_agent TO ls_user_agent_group-user_agent.
              CLEAR: ls_user_agent.
            ENDIF.
          ENDLOOP.
        WHEN OTHERS.
      ENDCASE.
      CLEAR: ls_rule_exe.
    ENDLOOP.
    IF lv_non_agent_act IS NOT INITIAL.
      APPEND ls_non_user_agent_group TO lt_non_user_agent_group.
      IF lt_non_user_agent_group IS NOT INITIAL.
        CLEAR: cp_dyn_context-user_agent_group, cp_dyn_context-non_user_agent_group.
        cp_dyn_context-non_user_agent_group = lt_non_user_agent_group.
      ENDIF.
    ELSE.
      APPEND ls_user_agent_group TO lt_user_agent_group.
      IF lt_user_agent_group IS NOT INITIAL.
        CLEAR: cp_dyn_context-user_agent_group, cp_dyn_context-non_user_agent_group.
        cp_dyn_context-user_agent_group = lt_user_agent_group.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD filter_scope_condition.

    DATA lr_def_id    TYPE RANGE OF mdq_rule_definition_id.
    DATA lr_rule_type TYPE RANGE OF yz_dtel_rule_type.
    DATA lr_entity    TYPE RANGE OF usmd_entity.
    DATA lr_fieldname TYPE RANGE OF usmd_fieldname.
    DATA lr_attribute TYPE RANGE OF usmd_attribute.

    "STEP 1 : check if the data model is active or not
    CHECK check_domain_is_active( it_selection = VALUE usmd_ts_sel( ( fieldname = 'MODEL' sign = 'I'
                                                                      option    = 'EQ'    low  = gs_app_context-model )
                                                                    ( fieldname = 'OTC'   sign = 'I'
                                                                      option    = 'EQ'    low  = gs_app_context-otc ) )  ) IS NOT INITIAL.

    IF iv_def_id IS NOT INITIAL OR gs_app_context-rule_usage = 'MDQ_EVAL'.
      IF iv_def_id IS NOT INITIAL.
        lr_def_id = VALUE #( ( sign = 'I' option = 'EQ' low = iv_def_id ) ) .
      ENDIF.
      CLEAR : gt_definition_ids_src, gt_yztabl_rule_exe_src,gt_yztabl_rule_val_src ,
              gt_definition_ids_prc, gt_yztabl_rule_exe_prc,gt_yztabl_rule_val_prc."
    ENDIF.

    "STEP 2 : Source table for Definition id
    IF gt_definition_ids_src IS INITIAL .
*--------------------------------------------------------------------*
*DB Query
*--------------------------------------------------------------------*
      SELECT DISTINCT def_id, reuse_scp, refruleid
                 FROM yzc_ddls_rule
                WHERE model       = @gs_app_context-model
                  AND otc         = @gs_app_context-otc
                  AND rule_sec    = @gc_rule_section_usage
                  AND def_id     IN @lr_def_id
                  AND entity      = 'YYUSAGE'
                  AND ( attribute = 'CR_TYPE' OR attribute = 'CR_STEP' OR  attribute = 'RULE_STAG' )
                  AND active      = @abap_true AND def_active = @abap_true AND exe_active = @abap_true AND val_active = @abap_true
                  INTO TABLE @gt_definition_ids_src.
    ENDIF.

    "STEP 3 : Source table for Execution Table Entries
    IF gt_yztabl_rule_exe_src IS INITIAL.
      gt_yztabl_rule_exe_src = get_rule_exe_records( VALUE #( FOR ls_definition_id IN gt_definition_ids_src ( fieldname = 'DEF_ID' sign = 'I'
                                                                                                               option    = 'EQ'     low  = ls_definition_id-def_id ) ) ).
      gt_yztabl_rule_exe_src = VALUE #( BASE gt_yztabl_rule_exe_src
                                        FOR ls_exe_entry IN get_rule_exe_records( VALUE #( FOR ls_definition_id IN gt_definition_ids_src
                                                                                  WHERE ( reuse_scp EQ abap_true )
                                                                                 ( fieldname = 'DEF_ID' sign = 'I' option    = 'EQ' low  = ls_definition_id-refruleid ) )  )  ( ls_exe_entry ) ).

      DELETE ADJACENT DUPLICATES FROM gt_yztabl_rule_exe_src USING KEY primary_key .
    ENDIF.

    "STEP 4 : source table for Value Table Entries
    IF gt_yztabl_rule_val_src IS INITIAL.
      "Add Definition Ids from the _EXE table into IT_SELECTION
      gt_yztabl_rule_val_src = get_rule_val_records( VALUE #( FOR ls_rule_exe_src IN gt_yztabl_rule_exe_src ( fieldname = 'EXE_ID' sign = 'I'
                                                                                                              option    = 'EQ'     low  = ls_rule_exe_src-exe_id ) ) ).
    ENDIF.

    IF gt_yztabl_metadata IS INITIAL.
      SELECT * FROM yztabl_ref_data INTO TABLE @gt_yztabl_metadata WHERE model = @gs_app_context-model.
    ENDIF.

    "Filtering starts from here
    IF gt_definition_ids_prc IS INITIAL.
      LOOP AT gt_definition_ids_src INTO DATA(ls_def_id).
        "Add RULE_SEC = U - Another filter for execution table
        IF execute_definition_id( iv_def_id         = ls_def_id-def_id
                                  it_rule_exe_entry = FILTER tt_yztabl_rule_exe( gt_yztabl_rule_exe_src USING KEY filter_key WHERE def_id = ls_def_id-def_id AND entity = CONV #('YYUSAGE') )
                                  iv_rule_sec       = gc_rule_section_usage  ).

          gt_definition_ids_prc  = VALUE #( BASE gt_definition_ids_prc ( ls_def_id ) ) .
          gt_yztabl_rule_val_prc = VALUE #( BASE gt_yztabl_rule_val_prc
                                            FOR ls_rule_val IN gt_yztabl_rule_val_src USING KEY filter_def WHERE ( def_id = ls_def_id-def_id ) ( ls_rule_val  ) ).

          gt_yztabl_rule_exe_prc = VALUE #( BASE gt_yztabl_rule_exe_prc
                                            FOR ls_rule_exe IN gt_yztabl_rule_exe_src USING KEY filter_key WHERE ( def_id = ls_def_id-def_id ) ( ls_rule_exe ) ).
        ENDIF.
      ENDLOOP.
    ENDIF.

    IF rt_def_id IS REQUESTED.

      IF gt_yztabl_rule_exe_prc IS NOT INITIAL AND ( iv_rule_type IS NOT INITIAL OR  gs_app_context-rule_type      IS NOT INITIAL
                                                  OR iv_entity IS NOT INITIAL    OR  gs_app_context-current_entity IS NOT INITIAL ).

        lr_rule_type = VALUE #( ( sign = 'I' option = 'EQ' low = COND #( WHEN iv_rule_type IS INITIAL THEN gs_app_context-rule_type     ELSE iv_rule_type  ) ) ).

        DATA(lv_entity) = COND #( WHEN iv_entity IS INITIAL THEN gs_app_context-current_entity ELSE iv_entity  ).

        IF lv_entity IS INITIAL AND ( gs_app_context-rule_stage = 'MDG' OR gs_app_context-rule_stage = 'MDF' ).

          LOOP AT get_cr_changed_entity( gs_app_context-o_changed_data ) INTO DATA(ls_changed).
            lr_entity    = VALUE #( BASE lr_entity ( sign = 'I' option = 'EQ' low = ls_changed ) ).
          ENDLOOP.

          IF lr_entity IS INITIAL.
            DATA(lt_changed_fields) = get_cr_changed_fields(
            EXPORTING
                iv_crequest         = gs_app_context-crequest                 " Change Request
                iv_entity           = lv_entity                               " Entity Type
                io_model_ext        = gs_app_context-o_model ).               " MDG Data Model for Access from Non-SAP Standard Code

            LOOP AT lt_changed_fields INTO DATA(ls_changed_fields).
              lr_entity       = VALUE #( BASE lr_entity    (  sign = 'I' option = 'EQ' low = ls_changed_fields-usmd_entity  ) ).
              APPEND LINES OF ls_changed_fields-fieldname TO lr_attribute.
            ENDLOOP.
          ENDIF.

        ELSEIF lv_entity IS NOT INITIAL.
          lr_entity    = VALUE #( ( sign = 'I' option = 'EQ' low = lv_entity ) ).
        ENDIF.


        SELECT FROM  @gt_yztabl_rule_exe_prc AS it_exe_prc
             FIELDS  def_id
              WHERE  rule_type IN @lr_rule_type
                AND  entity    IN @lr_entity
*               AND  attribute IN @lr_attribute
         INTO TABLE  @rt_def_id.

        IF sy-subrc = 0.
          DELETE ADJACENT DUPLICATES FROM rt_def_id COMPARING def_id.

          CHECK line_exists( gt_definition_ids_src[ reuse_scp = abap_true ] ).

          LOOP AT rt_def_id ASSIGNING FIELD-SYMBOL(<ls_def_id>).
            DATA(ls_def_src) = VALUE #( gt_definition_ids_src[ KEY primary_key def_id = <ls_def_id>-def_id ] OPTIONAL ).
            <ls_def_id>-reuse_scp = ls_def_src-reuse_scp.
            <ls_def_id>-refruleid = ls_def_src-refruleid.
          ENDLOOP.
        ENDIF.
      ENDIF.
    ENDIF.

  ENDMETHOD.


  METHOD yz_intf_mdg_accelerator_config~process_config_records.

    DATA(method_name) = 'PROCESS_' && iv_view_entity.
    CONDENSE method_name.

    CALL METHOD (method_name)
      EXPORTING
        iv_event_id         = iv_event_id                 " Event
        iv_view_entity      = iv_view_entity
        iv_action           = iv_action
        it_super_set_config = it_super_set_config
      CHANGING
        cs_data             = cs_data
        ct_data             = ct_data
      RECEIVING
        rt_messages         = rt_messages.           " Boolean Variable (X = True, - = False, Space = Unknown)

  ENDMETHOD.


  METHOD yz_intf_mdg_accelerator_config~process_yz_view_rule_def.

    FIELD-SYMBOLS : <fs_data> TYPE yz_view_rule_def.

    DATA lt_yz_view_rule_dom TYPE STANDARD TABLE OF yz_view_rule_dom.
    DATA lt_yztabl_rule_def  TYPE STANDARD TABLE OF yztabl_rule_def.
    DATA : lv_entity      TYPE usmd_entity VALUE 'YZ_RULE_D',
           lv_att_model   TYPE usmd_fld_source VALUE 'MODEL',
           lv_att_otc     TYPE usmd_fld_source VALUE 'OTC',
           lv_att_tempid  TYPE usmd_fld_source VALUE 'TEMP_ID',
           lv_att_ruletyp TYPE usmd_fld_source VALUE 'RULE_TYPE',
           ls_message     LIKE LINE OF rt_messages.

*--------------------------------------------------------------------*
*  CR Validation
*--------------------------------------------------------------------*
    IF iv_event_id = 'CR_CHECK' AND ct_data[] IS NOT INITIAL.
      lt_yztabl_rule_def = CORRESPONDING #( ct_data ).
      LOOP AT lt_yztabl_rule_def INTO DATA(ls_yztabl_rule_def).

        IF ls_yztabl_rule_def-model IS NOT INITIAL.
*    Check Model
          SELECT COUNT(*) FROM usmd0022
                         BYPASSING BUFFER WHERE usmd_objstat EQ 'A'
                           AND usmd_model   EQ @ls_yztabl_rule_def-model .
          IF sy-subrc IS NOT INITIAL.
            CLEAR: ls_message.
            ls_message-msgid = 'YZMSG_MDG_ACC'.
            ls_message-msgno = '40'.
            ls_message-msgty = 'E'.
            ls_message-msgv1 = ls_yztabl_rule_def-model.
            ls_message-row = yz_clas_mdg_utility=>set_message_hyperlink( iv_model       = 'YZ'
                                                                         iv_entity      = lv_entity
                                                                         is_entity_data = ls_yztabl_rule_def
                                                                         iv_attribute   = lv_att_model ).
            APPEND ls_message TO rt_messages.
          ENDIF.
        ENDIF.

*    Check OTC
        IF ls_yztabl_rule_def-model IS NOT INITIAL AND ls_yztabl_rule_def-otc IS NOT INITIAL.
          SELECT COUNT(*) FROM yztabl_ref_data
                           WHERE model EQ @ls_yztabl_rule_def-model
                             AND otc   EQ @ls_yztabl_rule_def-otc.
          IF sy-subrc IS NOT INITIAL.
            CLEAR: ls_message.
            ls_message-msgid = 'YZMSG_MDG_ACC'.
            ls_message-msgno = '41'.
            ls_message-msgty = 'E'.
            ls_message-msgv1 = ls_yztabl_rule_def-otc.
            ls_message-row = yz_clas_mdg_utility=>set_message_hyperlink( iv_model       = 'YZ'
                                                                         iv_entity      = lv_entity
                                                                         is_entity_data = ls_yztabl_rule_def
                                                                         iv_attribute   = lv_att_otc ).
            APPEND ls_message TO rt_messages.
          ENDIF.
        ELSEIF ls_yztabl_rule_def-model IS INITIAL AND ls_yztabl_rule_def-otc IS NOT INITIAL.
          CLEAR: ls_message.
          ls_message-msgid = 'YZMSG_MDG_ACC'.
          ls_message-msgno = '46'.
          ls_message-msgty = 'E'.
          ls_message-row = yz_clas_mdg_utility=>set_message_hyperlink( iv_model       = 'YZ'
                                                                       iv_entity      = lv_entity
                                                                       is_entity_data = ls_yztabl_rule_def
                                                                       iv_attribute   = lv_att_model ).
          APPEND ls_message TO rt_messages.
        ENDIF.

*   Check Rule Type
        IF ls_yztabl_rule_def-rule_type IS NOT INITIAL AND ( ls_yztabl_rule_def-model IS NOT INITIAL
                                                       AND ls_yztabl_rule_def-otc IS NOT INITIAL ).
          SELECT COUNT(*) FROM yztabl_ref_data
                                 WHERE model     EQ @ls_yztabl_rule_def-model
                                    AND otc      EQ @ls_yztabl_rule_def-otc.

          IF sy-subrc IS NOT INITIAL.
            CLEAR: ls_message.
            ls_message-msgid = 'YZMSG_MDG_ACC'.
            ls_message-msgno = '42'.
            ls_message-msgty = 'E'.
            ls_message-msgv1 = ls_yztabl_rule_def-rule_type.
            ls_message-row = yz_clas_mdg_utility=>set_message_hyperlink( iv_model       = 'YZ'
                                                                         iv_entity      = lv_entity
                                                                         is_entity_data = ls_yztabl_rule_def
                                                                         iv_attribute   = lv_att_ruletyp ).
            APPEND ls_message TO rt_messages.
          ENDIF.

        ELSEIF ls_yztabl_rule_def-rule_type IS NOT INITIAL AND ( ls_yztabl_rule_def-model IS INITIAL
                                                            OR   ls_yztabl_rule_def-otc   IS INITIAL ).
          CLEAR: ls_message.
          ls_message-msgid = 'YZMSG_MDG_ACC'.
          ls_message-msgno = '47'.
          ls_message-msgty = 'E'.
          ls_message-msgv1 = ls_yztabl_rule_def-rule_type.
          ls_message-row = yz_clas_mdg_utility=>set_message_hyperlink( iv_model       = 'YZ'
                                                                       iv_entity      = lv_entity
                                                                       is_entity_data = ls_yztabl_rule_def
                                                                       iv_attribute   = lv_att_model ).
          APPEND ls_message TO rt_messages.
        ENDIF.

*   Check rule template id.
        IF ls_yztabl_rule_def-temp_id IS NOT INITIAL AND ( ls_yztabl_rule_def-model     IS NOT INITIAL
                                                     AND   ls_yztabl_rule_def-otc       IS NOT INITIAL
                                                     AND   ls_yztabl_rule_def-rule_type IS NOT INITIAL ).
          SELECT COUNT(*) FROM yztabl_rule_tmp
                               WHERE model      EQ @ls_yztabl_rule_def-model AND otc EQ @ls_yztabl_rule_def-otc
                                 AND rule_type  EQ @ls_yztabl_rule_def-rule_type
                                 AND temp_id    EQ @ls_yztabl_rule_def-temp_id.
          IF sy-subrc IS NOT INITIAL.
            CLEAR: ls_message.
            ls_message-msgid = 'YZMSG_MDG_ACC'.
            ls_message-msgno = '43'.
            ls_message-msgty = 'E'.
            ls_message-row = yz_clas_mdg_utility=>set_message_hyperlink( iv_model       = 'YZ'
                                                                         iv_entity      = lv_entity
                                                                         is_entity_data = ls_yztabl_rule_def
                                                                         iv_attribute   = lv_att_tempid ).
            APPEND ls_message TO rt_messages.
          ENDIF.
        ELSEIF ls_yztabl_rule_def-temp_id IS NOT INITIAL AND ( ls_yztabl_rule_def-model     IS INITIAL
                                                         OR    ls_yztabl_rule_def-otc       IS INITIAL
                                                         OR    ls_yztabl_rule_def-rule_type IS INITIAL ).
          CLEAR: ls_message.
          ls_message-msgid = 'YZMSG_MDG_ACC'.
          ls_message-msgno = '47'.
          ls_message-msgty = 'E'.
          ls_message-row = yz_clas_mdg_utility=>set_message_hyperlink( iv_model       = 'YZ'
                                                                       iv_entity      = lv_entity
                                                                       is_entity_data = ls_yztabl_rule_def
                                                                       iv_attribute   = lv_att_model ).
          APPEND ls_message TO rt_messages.
        ENDIF.

* Definition should be mandatory.
        IF ls_yztabl_rule_def-rule_def IS INITIAL AND ( ls_yztabl_rule_def-model     IS NOT INITIAL
                                                  AND   ls_yztabl_rule_def-otc       IS NOT INITIAL
                                                  AND   ls_yztabl_rule_def-rule_type IS NOT INITIAL ).
          CLEAR: ls_message.
          ls_message-msgid = 'YZMSG_MDG_ACC'.
          ls_message-msgno = '56'.
          ls_message-msgty = 'E'.
          ls_message-row = yz_clas_mdg_utility=>set_message_hyperlink( iv_model       = 'YZ'
                                                                       iv_entity      = lv_entity
                                                                       is_entity_data = ls_yztabl_rule_def
                                                                       iv_attribute   = 'RULE_DEF' ).
          APPEND ls_message TO rt_messages.
        ENDIF.
      ENDLOOP.
    ENDIF.

*--------------------------------------------------------------------*
*  GUI Validation
*--------------------------------------------------------------------*
    IF iv_event_id = 'ON_NEW_ENTRY' OR iv_event_id = 'INSTEAD_OF_STD_VALIDATION'.

      LOOP AT ct_data ASSIGNING FIELD-SYMBOL(<fsv_data>).
        ASSIGN: <fsv_data> TO <fs_data> CASTING.
        IF <fs_data> IS ASSIGNED.
          IF <fs_data>-rule_type IS INITIAL.
            MESSAGE 'Rule Type is mandatory' TYPE 'E' DISPLAY LIKE 'I'.
            RETURN.
          ENDIF.
        ENDIF.
      ENDLOOP.
    ENDIF.

*--------------------------------------------------------------------*
*    Logic To Generate Rule ID
*--------------------------------------------------------------------*
    IF iv_event_id = 'ON_NEW_ENTRY'.
      IF cs_data IS NOT INITIAL.
        ASSIGN: cs_data TO <fs_data> CASTING.
        CHECK <fs_data> IS ASSIGNED.
        IF <fs_data>-rule_type IS INITIAL.
          MESSAGE 'Rule Type is mandatory' TYPE 'E' DISPLAY LIKE 'I'.
          RETURN.
        ENDIF.
        IF <fs_data>-def_id IS INITIAL.
          <fs_data>-def_id = <fs_data>-model
                           && '_'
                           && <fs_data>-otc
                           && '_'
                           && <fs_data>-rule_type
                           && '_'
                           && get_nr_def_id_for_rule( <fs_data>-rule_type ).
          CONDENSE <fs_data>-def_id.
        ENDIF.

      ELSE.
        LOOP AT ct_data ASSIGNING <fsv_data>.
          ASSIGN: <fsv_data> TO <fs_data> CASTING.
          CHECK <fs_data> IS ASSIGNED.
          IF <fs_data>-def_id IS INITIAL.
            <fs_data>-def_id = <fs_data>-model
                             && '_'
                             && <fs_data>-otc
                             && '_'
                             && <fs_data>-rule_type
                             && '_'
                             && get_nr_def_id_for_rule( <fs_data>-rule_type ).
            CONDENSE <fs_data>-def_id.
          ENDIF.
        ENDLOOP.
      ENDIF.
    ENDIF.

  ENDMETHOD.


  METHOD yz_intf_mdg_accelerator_config~process_yz_view_rule_val.

    FIELD-SYMBOLS : <fs_data> TYPE yz_view_rule_val.

    DATA lt_yz_view_rule_exe TYPE STANDARD TABLE OF yz_view_rule_exe.
    DATA lt_yztabl_rule_val  TYPE STANDARD TABLE OF yztabl_rule_val.

*--------------------------------------------------------------------*
*  CR Validation
*--------------------------------------------------------------------*
    IF iv_event_id = 'CR_CHECK' AND ct_data[] IS NOT INITIAL.
      lt_yztabl_rule_val = CORRESPONDING #( ct_data ).
      LOOP AT lt_yztabl_rule_val INTO DATA(ls_yztabl_rule_val).
*    Check Model
*    ls_yztabl_rule_def-model
*        *
*        *
*        *
      ENDLOOP.
    ENDIF.

*--------------------------------------------------------------------*
*  GUI Set Key Field
*--------------------------------------------------------------------*
    DEFINE set_key_field.
      IF <fs_data>-val_id IS INITIAL.
        <fs_data>-val_id = <fs_data>-exe_id
        && '_'
        && get_nr_val_id_for_rule( <fs_data>-rule_sec ).
      ENDIF.
    END-OF-DEFINITION.


*--------------------------------------------------------------------*
*   GUI Set Non Key Field
*--------------------------------------------------------------------*
    DEFINE set_non_key_field.
      <fs_data>-rule_def  = COND #( WHEN <fs_data>-rule_def  IS INITIAL THEN lt_yz_view_rule_exe[ 1 ]-rule_def            ELSE <fs_data>-rule_def ).
      <fs_data>-entity    = COND #( WHEN <fs_data>-entity    IS INITIAL THEN lt_yz_view_rule_exe[ 1 ]-entity              ELSE <fs_data>-entity ).
      <fs_data>-attribute = COND #( WHEN <fs_data>-attribute IS INITIAL THEN lt_yz_view_rule_exe[ 1 ]-attribute           ELSE <fs_data>-attribute ).
      <fs_data>-type_desc = COND #( WHEN <fs_data>-type_desc IS INITIAL THEN gt_yztabl_rule_typ[ rule_type = <fs_data>-rule_type ]-type_desc
                                                                        ELSE <fs_data>-type_desc ).
      <fs_data>-sec_desc  = COND #( WHEN <fs_data>-sec_desc  IS INITIAL THEN gt_yztabl_rule_sec[ rule_sec = <fs_data>-rule_sec ]-sec_desc
                                                                        ELSE <fs_data>-sec_desc ).
    END-OF-DEFINITION.



    IF iv_event_id = 'ON_NEW_ENTRY'.
      IF cs_data IS NOT INITIAL.
        ASSIGN: cs_data TO <fs_data> CASTING.
        CHECK <fs_data> IS ASSIGNED.
        set_key_field.
      ELSE.

        LOOP AT ct_data ASSIGNING FIELD-SYMBOL(<fsv_data>).
          ASSIGN: <fsv_data> TO <fs_data> CASTING.
          CHECK <fs_data> IS ASSIGNED.
*          WHILE line_exists( ct_data[ key = <fs_data>-val_id ] ).
*            set_key_field.
*          ENDWHILE.
        ENDLOOP.
      ENDIF.
    ENDIF.


*--------------------------------------------------------------------*
*            Fill Non Key Fields
*--------------------------------------------------------------------*
    IF iv_event_id = 'BEFORE_NAVIGATION'.
      IF it_super_set_config IS NOT INITIAL.
        lt_yz_view_rule_exe[] = it_super_set_config[].
        IF ct_data IS INITIAL.
          INSERT INITIAL LINE INTO TABLE ct_data ASSIGNING <fs_data>  CASTING.
          IF sy-subrc = 0.
            <fs_data> = CORRESPONDING #( lt_yz_view_rule_exe[ 1 ] ).
            set_key_field.
            set_non_key_field.
            UNASSIGN <fs_data>.
          ENDIF.

        ELSE.
          LOOP AT ct_data ASSIGNING <fs_data> CASTING.
            set_non_key_field.
          ENDLOOP.
        ENDIF.
      ENDIF.
    ENDIF.

  ENDMETHOD.


  METHOD yz_intf_mdg_accelerator_config~process_yz_view_rule_dom.

  ENDMETHOD.


  METHOD yz_intf_mdg_accelerator_config~get_nr_def_id_for_rule.

    DATA lv_rc TYPE inri-returncode.

    CALL FUNCTION 'NUMBER_GET_NEXT'
      EXPORTING
        nr_range_nr             = '01'
        object                  = 'YZ_RULE_DE'
        subobject               = iv_rule_type
      IMPORTING
        number                  = rv_def_id
        returncode              = lv_rc
      EXCEPTIONS
        interval_not_found      = 1
        number_range_not_intern = 2
        object_not_found        = 3
        quantity_is_0           = 4
        quantity_is_not_1       = 5
        interval_overflow       = 6
        buffer_overflow         = 7
        OTHERS                  = 8.

    IF sy-subrc <> 0.

    ENDIF.

  ENDMETHOD.


  METHOD yz_intf_mdg_accelerator_config~process_yz_view_rule_exe.

    FIELD-SYMBOLS : <fs_data> TYPE yz_view_rule_exe.

    DATA lt_yz_view_rule_def TYPE STANDARD TABLE OF yz_view_rule_def.
    DATA lt_yztabl_rule_exe  TYPE STANDARD TABLE OF yztabl_rule_exe.
    DATA : lv_entity        TYPE usmd_entity VALUE 'YZ_RULE_E',
           lv_att_entity    TYPE usmd_fld_source VALUE 'ENTITY',
           lv_att_attribute TYPE usmd_fld_source VALUE 'ATTRIBUTE',
           lv_att_class     TYPE usmd_fld_source VALUE 'CLASS',
           lv_att_method    TYPE usmd_fld_source VALUE 'METHOD',
           lv_att_exetype   TYPE usmd_fld_source VALUE 'EXE_TYPE',
           lv_att_seqno     TYPE usmd_fld_source VALUE 'SEQ_NO',
           lv_att_task      TYPE usmd_fld_source VALUE 'TASK',
           ls_message       LIKE LINE OF rt_messages.

*--------------------------------------------------------------------*
*    validate_record macro
*--------------------------------------------------------------------*
    DEFINE validate_record.
      IF <fs_data>-rule_sec IS INITIAL.
        MESSAGE 'Rule Section is mandatory' TYPE 'E' DISPLAY LIKE 'I'.
        RETURN.
      ENDIF.
    END-OF-DEFINITION.

*--------------------------------------------------------------------*
*      set_key_field
*--------------------------------------------------------------------*
    DEFINE set_key_field.
      IF <fs_data>-exe_id IS INITIAL AND <fs_data>-rule_sec IS NOT INITIAL.
        <fs_data>-exe_id = <fs_data>-def_id
                        && '_'
                        && <fs_data>-rule_sec
                        && '_'
                        && get_nr_exe_id_for_rule( iv_def_id = <fs_data>-def_id  iv_rule_sec = <fs_data>-rule_sec it_tab = ct_data ).
      ENDIF.
    END-OF-DEFINITION.


*--------------------------------------------------------------------*
*    set_non_key_field macro
*--------------------------------------------------------------------*
    DEFINE set_non_key_field.
      <fs_data>-rule_def  = COND #( WHEN <fs_data>-rule_def  IS INITIAL THEN lt_yz_view_rule_def[ 1 ]-rule_def
                                                                        ELSE <fs_data>-rule_def ).
      IF <fs_data>-rule_type IS NOT INITIAL.
      <fs_data>-type_desc = COND #( WHEN <fs_data>-type_desc IS INITIAL THEN gt_yztabl_rule_typ[ rule_type = <fs_data>-rule_type ]-type_desc
                                                                        ELSE <fs_data>-type_desc ).
      ENDIF.
    END-OF-DEFINITION.



*--------------------------------------------------------------------*
*  CR Validation
*--------------------------------------------------------------------*
    IF iv_event_id = 'CR_CHECK' AND ct_data[] IS NOT INITIAL.
      lt_yztabl_rule_exe = CORRESPONDING #( ct_data ).
      LOOP AT lt_yztabl_rule_exe INTO DATA(ls_yztabl_rule_exe).

        IF ls_yztabl_rule_exe-entity IS NOT INITIAL.
*    Check Entity Type
          SELECT COUNT(*)      FROM yztabl_ref_data
                  WHERE model  EQ ls_yztabl_rule_exe-model
                    AND otc    EQ ls_yztabl_rule_exe-otc
                    AND entity EQ ls_yztabl_rule_exe-entity.
          IF sy-subrc IS NOT INITIAL.
            CLEAR: ls_message.
            ls_message-msgid = 'YZMSG_MDG_ACC'.
            ls_message-msgno = '44'.
            ls_message-msgty = 'E'.
            ls_message-msgv1 = ls_yztabl_rule_exe-entity.
            ls_message-msgv2 = ls_yztabl_rule_exe-model.
            ls_message-row   = yz_clas_mdg_utility=>set_message_hyperlink( iv_model       = 'YZ'
                                                                iv_entity      = lv_entity
                                                                is_entity_data = ls_yztabl_rule_exe
                                                                iv_attribute   = lv_att_entity ).
            APPEND ls_message TO rt_messages.
          ENDIF.
        ELSE.
          CLEAR: ls_message.
          ls_message-msgid = 'YZMSG_MDG_ACC'.
          ls_message-msgno = '49'.
          ls_message-msgty = 'E'.
          ls_message-msgv1 = ls_yztabl_rule_exe-exe_id.
          ls_message-row   = yz_clas_mdg_utility=>set_message_hyperlink( iv_model       = 'YZ'
                                                              iv_entity      = lv_entity
                                                              is_entity_data = ls_yztabl_rule_exe
                                                              iv_attribute   = lv_att_entity ).
          APPEND ls_message TO rt_messages.
        ENDIF.

*    Check Attribute
        IF ls_yztabl_rule_exe-attribute IS NOT INITIAL.

          SELECT COUNT(*)         FROM yztabl_ref_data
                  WHERE model     EQ ls_yztabl_rule_exe-model
                    AND otc       EQ ls_yztabl_rule_exe-otc
                    AND entity    EQ ls_yztabl_rule_exe-entity
                    AND attribute EQ ls_yztabl_rule_exe-attribute.

          IF sy-subrc IS NOT INITIAL.
            CLEAR: ls_message.
            ls_message-msgid = 'YZMSG_MDG_ACC'.
            ls_message-msgno = '45'. ls_message-msgty = 'E'.
            ls_message-msgv1 = ls_yztabl_rule_exe-attribute.
            ls_message-msgv2 = ls_yztabl_rule_exe-entity.
            ls_message-row   = yz_clas_mdg_utility=>set_message_hyperlink( iv_model       = 'YZ'
                                                                iv_entity      = lv_entity
                                                                is_entity_data = ls_yztabl_rule_exe
                                                                iv_attribute   = lv_att_attribute ).
            APPEND ls_message TO rt_messages.
          ENDIF.
        ELSEIF ls_yztabl_rule_exe-attribute IS INITIAL AND ls_yztabl_rule_exe-operation NE 'COUNT'.
          CLEAR: ls_message.
          "Attribute is requried for Exe ID Message
          ls_message-msgid = 'YZMSG_MDG_ACC'.
          ls_message-msgno = '48'.
          ls_message-msgty = 'E'.
          ls_message-msgv1 = ls_yztabl_rule_exe-exe_id.
          ls_message-row   = yz_clas_mdg_utility=>set_message_hyperlink( iv_model       = 'YZ'
                                                                         iv_entity      = lv_entity
                                                                         is_entity_data = ls_yztabl_rule_exe
                                                                         iv_attribute   = lv_att_attribute ).
          APPEND ls_message TO rt_messages.
        ENDIF.
*  If execution type is via class-method then class and method should be mandatory field.
        IF ls_yztabl_rule_exe-exe_type IS NOT INITIAL.
          DATA(lv_exetype) = substring( off = strlen( ls_yztabl_rule_exe-exe_type ) - 1 len = 1 val = ls_yztabl_rule_exe-exe_type ).
          CASE lv_exetype.
            WHEN 'C'.
              IF ls_yztabl_rule_exe-class IS INITIAL.
                CLEAR: ls_message.
                ls_message-msgid = 'YZMSG_MDG_ACC'.
                ls_message-msgno = '50'.
                ls_message-msgty = 'E'.
                ls_message-msgv1 = ls_yztabl_rule_exe-exe_id.
                ls_message-row   = yz_clas_mdg_utility=>set_message_hyperlink( iv_model = 'YZ'
                                                                    iv_entity           = lv_entity
                                                                    is_entity_data      = ls_yztabl_rule_exe
                                                                    iv_attribute        = lv_att_class ).
                APPEND ls_message TO rt_messages.
              ENDIF.
              IF ls_yztabl_rule_exe-class IS INITIAL.
                CLEAR: ls_message.
                ls_message-msgid = 'YZMSG_MDG_ACC'.
                ls_message-msgno = '51'. ls_message-msgty = 'E'.
                ls_message-msgv1 = ls_yztabl_rule_exe-exe_id.
                ls_message-row   = yz_clas_mdg_utility=>set_message_hyperlink( iv_model       = 'YZ'
                                                                               iv_entity      = lv_entity
                                                                               is_entity_data = ls_yztabl_rule_exe
                                                                               iv_attribute   = lv_att_method ).
                APPEND ls_message TO rt_messages.
              ENDIF.
          ENDCASE.
        ELSE.
          CLEAR: ls_message.
          ls_message-msgid = 'YZMSG_MDG_ACC'.
          ls_message-msgno = '52'.
          ls_message-msgty = 'E'.
          ls_message-msgv1 = ls_yztabl_rule_exe-exe_id.
          ls_message-row   = yz_clas_mdg_utility=>set_message_hyperlink( iv_model       = 'YZ'
                                                                         iv_entity      = lv_entity
                                                                         is_entity_data = ls_yztabl_rule_exe
                                                                         iv_attribute   = lv_att_exetype ).
          APPEND ls_message TO rt_messages.
        ENDIF.

* Sequence no should be mandatory field.
        IF ls_yztabl_rule_exe-seq_no IS INITIAL.
          CLEAR: ls_message.
          ls_message-msgid = 'YZMSG_MDG_ACC'.
          ls_message-msgno = '54'.
          ls_message-msgty = 'E'.
          ls_message-msgv1 = ls_yztabl_rule_exe-seq_no.
          ls_message-row   = yz_clas_mdg_utility=>set_message_hyperlink( iv_model       = 'YZ'
                                                                         iv_entity      = lv_entity
                                                                         is_entity_data = ls_yztabl_rule_exe
                                                                         iv_attribute   = lv_att_seqno ).
          APPEND ls_message TO rt_messages.
        ENDIF.

* Rule task should be mandatory field.
        IF ls_yztabl_rule_exe-task IS INITIAL.
          CLEAR: ls_message.
          ls_message-msgid = 'YZMSG_MDG_ACC'.
          ls_message-msgno = '55'.
          ls_message-msgty = 'E'.
          ls_message-msgv1 = ls_yztabl_rule_exe-task.
          ls_message-row   = yz_clas_mdg_utility=>set_message_hyperlink( iv_model       = 'YZ'
                                                                         iv_entity      = lv_entity
                                                                         is_entity_data = ls_yztabl_rule_exe
                                                                         iv_attribute   = lv_att_task ).
          APPEND ls_message TO rt_messages.
        ENDIF.
      ENDLOOP.
    ENDIF.

*--------------------------------------------------------------------*
*  GUI Validation
*--------------------------------------------------------------------*
    IF iv_event_id = 'ON_NEW_ENTRY' OR
       iv_event_id = 'INSTEAD_OF_STD_VALIDATION'.

      LOOP AT ct_data ASSIGNING FIELD-SYMBOL(<fsv_data>).
        ASSIGN: <fsv_data> TO <fs_data> CASTING.
        IF <fs_data> IS ASSIGNED.
          validate_record.
        ENDIF.
      ENDLOOP.
    ENDIF.

    IF iv_event_id = 'ON_NEW_ENTRY'.
      IF cs_data IS NOT INITIAL.
        ASSIGN: cs_data TO <fs_data> CASTING.
        CHECK <fs_data> IS ASSIGNED.
        validate_record.
        set_key_field.
      ELSE.

        LOOP AT ct_data ASSIGNING <fsv_data>.
          ASSIGN: <fsv_data> TO <fs_data> CASTING.
          CHECK <fs_data> IS ASSIGNED.
          validate_record.
          set_key_field.
        ENDLOOP.
      ENDIF.
    ENDIF.

*--------------------------------------------------------------------*
*            Fill Non Key Fields
*--------------------------------------------------------------------*
    IF iv_event_id = 'BEFORE_NAVIGATION'.
      IF it_super_set_config IS NOT INITIAL.
        lt_yz_view_rule_def[] = it_super_set_config[].
        IF ct_data IS INITIAL.
          INSERT INITIAL LINE INTO TABLE ct_data ASSIGNING <fs_data>  CASTING.
          IF sy-subrc = 0.
            <fs_data> = CORRESPONDING #( lt_yz_view_rule_def[ 1 ] ).
            IF <fs_data>-rule_sec IS INITIAL.
              <fs_data>-rule_sec  = 'U'.        <fs_data>-seq_no   = '001'.
              <fs_data>-task      = 'CHECK'.   <fs_data>-operation = 'IF'.
              <fs_data>-entity    = 'YY_USAGE'.<fs_data>-attribute = 'CR_TYPE'.
            ENDIF.
            set_key_field.
            set_non_key_field.
            UNASSIGN <fs_data>.
          ENDIF.

        ELSE.
          LOOP AT ct_data ASSIGNING <fs_data> CASTING.
            set_non_key_field.
          ENDLOOP.
        ENDIF.
      ENDIF.
    ENDIF.

  ENDMETHOD.


  METHOD yz_intf_mdg_accelerator_config~get_nr_exe_id_for_rule.

    DATA lv_rc       TYPE inri-returncode.
    DATA lt_rule_exe TYPE STANDARD TABLE OF yztabl_rule_exe WITH NON-UNIQUE KEY mandt model otc rule_type def_id exe_id.

    IF it_tab IS NOT INITIAL.
      lt_rule_exe = CORRESPONDING #( it_tab[] ).
    ENDIF.

    CALL FUNCTION 'NUMBER_GET_NEXT'
      EXPORTING
        nr_range_nr             = 'IN'
        object                  = 'YZ_RULE_EX'
        subobject               = iv_rule_sec
      IMPORTING
        number                  = rv_exe_id
        returncode              = lv_rc
      EXCEPTIONS
        interval_not_found      = 1
        number_range_not_intern = 2
        object_not_found        = 3
        quantity_is_0           = 4
        quantity_is_not_1       = 5
        interval_overflow       = 6
        buffer_overflow         = 7
        OTHERS                  = 8.

    IF sy-subrc = 0.
      DO.
        SELECT SINGLE @abap_true AS lv_ui_exist FROM @lt_rule_exe AS itab WHERE exe_id = @( | { iv_def_id && iv_rule_sec && rv_exe_id } | ) INTO @DATA(lv_ui_exist).
        SELECT SINGLE @abap_true AS lv_db_exist FROM yztabl_rule_exe      WHERE exe_id = @( | { iv_def_id && iv_rule_sec && rv_exe_id } | ) INTO @DATA(lv_db_exist).
        IF lv_ui_exist = abap_true OR lv_db_exist = abap_true.
          rv_exe_id = COND #( WHEN iv_rule_sec = '1' THEN | { 'U' && rv_exe_id } |
                              WHEN iv_rule_sec = '2' THEN | { 'S' && rv_exe_id } |
                              WHEN iv_rule_sec = '3' THEN | { 'C' && rv_exe_id } | ).
        ELSE.
          EXIT.
        ENDIF.
      ENDDO.
    ENDIF.

  ENDMETHOD.


  METHOD yz_intf_mdg_accelerator_config~get_nr_val_id_for_rule.

    DATA lv_rc TYPE inri-returncode.

    CALL FUNCTION 'NUMBER_GET_NEXT'
      EXPORTING
        nr_range_nr             = '01'
        object                  = 'YZ_RULE_VL'
      IMPORTING
        number                  = rv_val_id
        returncode              = lv_rc
      EXCEPTIONS
        interval_not_found      = 1
        number_range_not_intern = 2
        object_not_found        = 3
        quantity_is_0           = 4
        quantity_is_not_1       = 5
        interval_overflow       = 6
        buffer_overflow         = 7
        OTHERS                  = 8.

    IF sy-subrc <> 0.

    ENDIF.

  ENDMETHOD.


  METHOD check_domain_is_active.
    "get the data from the IT_SELECTION into diff tables

    SELECT sign,option,low,high FROM @it_selection AS lt_domain_filter WHERE fieldname =: 'MODEL' INTO TABLE @DATA(lt_sel_model),
                                                                                          'OTC'  INTO TABLE @DATA(lt_sel_otc).

    SELECT COUNT( * ) FROM @gt_yztabl_rule_dom AS lt_rule_dom WHERE model  IN @lt_sel_model
                                                              AND   otc    IN @lt_sel_otc
                                                              AND   active EQ @abap_true
                                                              INTO @DATA(lv_count) .
    IF sy-subrc EQ 0 AND lv_count IS NOT INITIAL.
      rv_return = abap_true.
    ENDIF.
  ENDMETHOD.


  METHOD execute_definition_id.

    DATA ls_rule_prc LIKE LINE OF gt_rule_prc.

    IF iv_rule_sec EQ gc_rule_section_scope  OR iv_rule_sec EQ gc_rule_section_usage.

*execute_validation_scope_condt
      IF line_exists( it_rule_exe_entry[ KEY filter_key rule_sec = iv_rule_sec ] ) .

        rv_return =  execute_scope_condition( EXPORTING iv_rule_sec       = iv_rule_sec                 " Rule Section
                                                        it_rule_exe_entry = it_rule_exe_entry
                                                        ip_app_context    = ip_app_context                  " Entity Type
                                              IMPORTING et_message        = et_message   ).
      ELSE.
        rv_return = abap_true.
      ENDIF.




    ELSEIF iv_rule_sec EQ gc_rule_section_condition.

      CASE ip_app_context-rule_type.

        WHEN gc_execute_fldprop.
          DATA(lv_result) = execute_fld_prop_condition( EXPORTING it_rule_exe_entry = it_rule_exe_entry
                                                        CHANGING  cp_flp_context  = cp_flp_context ).

        WHEN gc_execute_hideuibb.
          rv_return = execute_hide_uibb_condition( io_ovp = ip_app_context-o_ovp it_rule_exe_entry = it_rule_exe_entry  ).

        WHEN gc_execute_derivation.
          rv_return =  execute_derive_condition( EXPORTING ip_app_context     = ip_app_context
                                                           it_rule_exe_entry  = it_rule_exe_entry         " Derivation Rules for D-MDG Accelator
                                                 IMPORTING et_message_info    = et_message ).             " Messages


        WHEN gc_execute_validation.
          rv_return =  execute_scope_condition( EXPORTING iv_rule_sec       = iv_rule_sec                " Rule Section
                                                          it_rule_exe_entry = it_rule_exe_entry
                                                          ip_app_context    = ip_app_context                 " Business Rule Type
                                                IMPORTING et_message        = et_message ).

        WHEN gc_execute_validation_unique.
          rv_return =  execute_validation_unv( EXPORTING iv_def_id         = iv_def_id
                                                         iv_rule_sec       = iv_rule_sec                " Rule Section
                                                         it_rule_exe_entry = it_rule_exe_entry
                                                         ip_app_context    = ip_app_context                 " Business Rule Type
                                               IMPORTING et_message        = et_message ).

        WHEN gc_execute_dynamic_agent.
          rv_return = execute_dynamic_agent_cond( EXPORTING it_rule_exe_entry       = it_rule_exe_entry
                                                  IMPORTING et_message              = et_message                " Messages
                                                  CHANGING  cp_dyn_context          = cp_dyn_context ).

        WHEN gc_execute_dyn_unique.
          rv_return = execute_dyn_agent_unique_check( EXPORTING it_rule_exe_entry       = it_rule_exe_entry
                                                                iv_rule_sec             = iv_rule_sec               " Change Request
                                                      IMPORTING et_message              = et_message                 " Messages
                                                      CHANGING  cp_dyn_context          = cp_dyn_context ).

        WHEN gc_execute_loop_wf.
          rv_return = execute_dynamic_agent_cond( EXPORTING it_rule_exe_entry       = it_rule_exe_entry
                                                  IMPORTING et_message              = et_message                " Messages
                                                  CHANGING  cp_dyn_context          = cp_dyn_context ).
      ENDCASE.

    ENDIF.

    IF line_exists( gt_rule_prc[ key filter_key def_id = iv_def_id rule_sec = iv_rule_sec rule_typ = ip_app_context-rule_type ] ).
      gt_rule_prc[ KEY filter_key def_id = iv_def_id rule_sec = iv_rule_sec rule_typ = ip_app_context-rule_type ]-result = rv_return.
    ELSE.
      gt_rule_prc = VALUE #( BASE gt_rule_prc (  def_id = iv_def_id rule_sec = iv_rule_sec rule_typ = ip_app_context-rule_type result = rv_return ) ).
    ENDIF.

  ENDMETHOD.


  METHOD get_result_of_exe_id.

    DATA: lr_data TYPE REF TO data.

    FIELD-SYMBOLS: <ls_record>    TYPE any,
                   <lt_any_table> TYPE ANY TABLE,
                   <lt_standard>  TYPE STANDARD TABLE.

    ASSIGN ir_data->* TO <lt_any_table>.
    IF <lt_any_table> IS ASSIGNED.

      CREATE DATA lr_data LIKE LINE OF <lt_any_table>.
      ASSIGN lr_data->* TO <ls_record>.

      CREATE DATA lr_data LIKE STANDARD TABLE OF <ls_record>.
      ASSIGN lr_data->* TO <lt_standard>.

      <lt_standard> = <lt_any_table>.

      LOOP AT it_val_prc INTO DATA(ls_val_prc) GROUP BY ls_val_prc-val_type.

        IF
        execute_value_expression( it_values     = VALUE tt_yztabl_rule_val( FOR ls_val IN it_val_prc USING KEY filter_val_type WHERE ( val_type = ls_val_prc-val_type ) ( ls_val ) )
                                  it_data       = <lt_standard>
                                  is_rule_exe   = is_rule_exe
                                  iv_val_type   = ls_val_prc-val_type ) = abap_true.
          rv_return = abap_true.
          EXIT.
        ENDIF.

      ENDLOOP.
    ENDIF.

  ENDMETHOD.


  METHOD auto_rule_based_on_rule_desc.
*--------------------------------------------------------------------*
* 1)  based on Description - Get the template
* 2)  Execute Template so that user doesnt have to fill Data model , Object type and rule Type
* 3) Tryp to read /Parse Value from Description and once its validated also create Value Lines as well
*--------------------------------------------------------------------*
*Example :
*    Rule Descp :
*    For ALL CR TYPE if material type = Fert and mat Grp = MAT1 then UoM should be mandatory

*Word Sets - CR Type , Change Request Type , -> entity = usage attribute CT_TYPE
*Word Sets - For ALL -> $
*Word Sets - if description Containes Material or any of word from Material Attribute description then -DATA Mdoel -> MM Object Type ->194 or get template ID
*Word Sets - Mandatory , Hidden - Rule Type FLP
*Word sets - Validate , Check - Rule Type VAL
*Word Sets - Derive     - Rule Type DER
*Word Sets - get entity name based on description , get attribute name based on description
  ENDMETHOD.


  METHOD execute_scope_condition.

    DATA : lv_scope_result   TYPE boole_d.
    DATA : lv_prev_operator  TYPE yz_dtel_operator.
    DATA : lv_prev_seq_no    TYPE yz_dtel_seq_no.
    DATA : lv_scope_exe_skip TYPE boole_d.

    LOOP AT it_rule_exe_entry INTO DATA(ls_exe_entry) USING KEY key_order.

      CHECK ls_exe_entry-task <> gc_rule_task_execute AND ls_exe_entry-rule_sec EQ iv_rule_sec.
      "Below logic will handle multiple scope execution

      IF ls_exe_entry-seq_no NE lv_prev_seq_no AND lv_prev_seq_no IS NOT INITIAL.

        IF ( ls_exe_entry-operation EQ 'OTHERWISE' AND rv_return = abap_true ) OR ( ls_exe_entry-operation EQ 'IF' AND rv_return = abap_false ).
          lv_scope_exe_skip = abap_true.
          lv_prev_seq_no = ls_exe_entry-seq_no. "Remember the Seq_no to process in the next cycle
          CONTINUE. "since previous scope is already satisifed
        ENDIF.
        CLEAR : lv_scope_result,lv_prev_operator,rv_return, lv_scope_exe_skip.

      ENDIF.

      lv_prev_seq_no = ls_exe_entry-seq_no. "Remember the Seq_no to process in the next cycle
      IF lv_scope_exe_skip IS NOT INITIAL.
        CONTINUE.
      ENDIF.

      IF ls_exe_entry-operation EQ 'ELSEIF' OR ls_exe_entry-operation EQ 'OTHERWISE'.
        IF rv_return IS NOT INITIAL.
          "if the previous result is true then exist the loop. Since once block is already satisfied
          EXIT.
        ELSE.
          CLEAR : lv_scope_result,lv_prev_operator.
        ENDIF.
      ENDIF.

      IF ls_exe_entry-exe_type IS NOT INITIAL.

        CASE get_last_character( CONV #( ls_exe_entry-exe_type ) ).
          WHEN 'C'.
            DATA(lv_row_result) = rule->execute_dynamic_class_method( EXPORTING is_rule_exe = ls_exe_entry                " Business Rule Implementation
                                                                      IMPORTING et_message  = et_message ).
          WHEN 'V'.
            DATA(lt_yztabl_rule_val_prc) = VALUE tt_yztabl_rule_val( FOR ls_rule_val IN gt_yztabl_rule_val_src USING KEY filter_exe WHERE ( exe_id = ls_exe_entry-exe_id ) ( ls_rule_val ) ).
            IF lt_yztabl_rule_val_prc IS NOT INITIAL.

              lv_row_result = execute_task( EXPORTING it_val_prc        = lt_yztabl_rule_val_prc
                                                      ip_app_context    = ip_app_context                " Entity Type
                                                      is_rule_exe       = ls_exe_entry                 " Business Rule Implementation
                                            IMPORTING er_data           = er_data
                                                      ev_exception_text = ev_exception_text ).

              CHECK ls_exe_entry-task = gc_rule_task_check.

            ELSE.
              lv_row_result = abap_true.
            ENDIF.
          WHEN OTHERS.
        ENDCASE.
      ENDIF.

      IF ev_exception_text IS NOT INITIAL.
        create_app_log( is_message        =  COND #( WHEN ev_exception_text IS NOT INITIAL THEN CONV char100( ev_exception_text ) )
                        is_rule_status    =  VALUE yztabl_rule_sta( model     = gs_app_context-model
                                                                    def_id    = ls_exe_entry-def_id
                                                                    entity    = ls_exe_entry-entity
                                                                    attribute = ls_exe_entry-attribute
                                                                    exe_type  = ls_exe_entry-rule_type ) ).
        et_message = build_message_for_exception( ev_exception_text ).
        EXIT.

      ENDIF.

      DATA(lv_entity)    = ls_exe_entry-entity.     "to be passed to the YYMSG iteration
      DATA(lv_attribute) = ls_exe_entry-attribute.  "to be passed to the YYMSG iteration

      IF execute_conditional_operator( iv_operand1 = lv_scope_result
                                       iv_operand2 = COND #( WHEN ls_exe_entry-operator = 'OR' THEN abap_true ELSE lv_row_result )
                                       iv_operator = lv_prev_operator ) EQ abap_true.
*
*        lv_prev_operator    = ls_exe_entry-operator.
        lv_scope_result     = lv_row_result.
        rv_return           = lv_scope_result.
      ELSE.
        rv_return = abap_false.
      ENDIF.
      lv_scope_result     = lv_row_result.
      lv_prev_operator    = ls_exe_entry-operator.
    ENDLOOP.

    "below logic will execute only for Validation Framework
    IF ip_app_context-rule_type EQ gc_execute_validation AND iv_rule_sec EQ gc_rule_section_condition.

      IF lv_row_result EQ abap_false AND ev_exception_text IS INITIAL.

        validate_prepare_message( EXPORTING  it_rule_exe_entry  = it_rule_exe_entry
                                                  ir_data            = er_data
                                                  id_entitytype      = lv_entity
                                      IMPORTING   et_message         = DATA(lt_message) ).

        et_message = VALUE #( BASE et_message FOR ls_message IN lt_message ( ls_message ) ).
      ENDIF.

      "Update Log:
      update_rule_status( EXPORTING iv_status      = COND #( WHEN lv_row_result = abap_true THEN 'P' ELSE 'F' )               " Status
                                    is_br_context  = VALUE #( model     = gs_app_context-model
                                                              def_id    = ls_exe_entry-def_id
                                                              rule_type = ls_exe_entry-rule_type
                                                              rule_sec  = ls_exe_entry-rule_sec
                                                              entity    = lv_entity
                                                              attribute = lv_attribute
                                                              exe_type  = ls_exe_entry-exe_type )
                                    iv_msgtxt      = CONV char100( ev_exception_text )
                          IMPORTING es_rule_status = DATA(ls_rule_status)  ).

      IF ev_exception_text IS INITIAL.

        create_app_log( it_message        = COND #( WHEN et_message IS NOT INITIAL THEN et_message )                " Messages
                                is_rule_status    = ls_rule_status ).

      ENDIF.

      IF et_message IS INITIAL.
        rv_return = abap_true.
      ENDIF.
    ENDIF.

  ENDMETHOD.


  METHOD execute_dyn_agent_unique_check.

    DATA : lv_sql_error TYPE string.

    DATA : lt_entity_attr TYPE yz_clas_mdg_utility=>gtt_entity_attr.

    lt_entity_attr = VALUE #( FOR ls_rule_exe IN it_rule_exe_entry USING KEY filter_key WHERE ( rule_sec = iv_rule_sec AND task EQ gc_rule_task_check  )
                                                                                              ( entity   = ls_rule_exe-entity attribute = ls_rule_exe-attribute )  ).

    rv_result = execute_uniqueness_check( IMPORTING ev_sql_error   = lv_sql_error
                                           CHANGING ct_entity_attr = lt_entity_attr ).
    IF rv_result IS NOT INITIAL.
          execute_dynamic_agent_cond( EXPORTING it_rule_exe_entry  = it_rule_exe_entry
                                      IMPORTING et_message         = et_message                " Messages
                                      CHANGING  cp_dyn_context     = cp_dyn_context ).
    ENDIF.
  ENDMETHOD.


  METHOD get_accl_service.

    IF my IS NOT BOUND.
      my = NEW yz_clas_mdg_accelerator( iv_model = iv_model is_app_context = is_app_context ).
    ENDIF.

    IF my IS BOUND.
      IF ro_accelerator IS REQUESTED.
        ro_accelerator = my.
      ENDIF.
      set_application_context( is_app_context ).
    ELSE.
*      RAISE exception.
    ENDIF.

  ENDMETHOD.


  METHOD update_rule_status.
*--------------------------------------------------------------------*
*Change Method Impl, Based on only IS_BR_Context
*--------------------------------------------------------------------*

    DATA :lx_root        TYPE REF TO cx_root,
          lt_rule_status TYPE yz_ttyp_rule_stat,
          err_msg        TYPE string.


    IF it_rule_status IS NOT INITIAL.
      lt_rule_status = CORRESPONDING #( it_rule_status ).
      LOOP AT lt_rule_status ASSIGNING FIELD-SYMBOL(<is_rule_status>).
        <is_rule_status>-mandt          = sy-mandt.
        <is_rule_status>-context        = gs_app_context-context_name.
        <is_rule_status>-contextk       = gs_app_context-context_value.
        <is_rule_status>-rule_type      = gs_app_context-rule_type.
        <is_rule_status>-root_key       = gs_app_context-root_key.
        <is_rule_status>-status         = COND #( WHEN <is_rule_status>-status IS INITIAL THEN iv_status ).
        <is_rule_status>-msgtxt         = COND #( WHEN <is_rule_status>-status EQ gc_fail THEN iv_msgtxt ).
        <is_rule_status>-ersda          = sy-datum.
        <is_rule_status>-time           = sy-uzeit.
        <is_rule_status>-usname         = gs_app_context-cr_created_by .

      ENDLOOP.

    ELSE.
      es_rule_status = VALUE #( mandt       = sy-mandt
                                model       = gs_app_context-model
                                context     = gs_app_context-context_name
                                contextk    = gs_app_context-context_value
                                rule_type   = gs_app_context-rule_type
                                def_id      = is_br_context-def_id
                                root_key    = gs_app_context-root_key
                                seq_no      = is_br_context-seq_no
                                status      = iv_status
                                entity      = is_br_context-entity
                                attribute   = is_br_context-attribute
                                msgtxt      = iv_msgtxt
                                ersda       = sy-datum
                                time        = sy-uzeit
                                usname      = gs_app_context-cr_created_by ).
      APPEND es_rule_status TO lt_rule_status.

    ENDIF.


    CHECK is_log_maintainance_req(  EXPORTING iv_br_log_required  = abap_true ) EQ abap_true.

    TRY.
        MODIFY yztabl_rule_sta FROM TABLE lt_rule_status.

      CATCH cx_root INTO lx_root.
        et_message = collect_exceptions( lx_root->get_text( )  ).
    ENDTRY.

  ENDMETHOD.


  METHOD execute_derive_condition.
*
    DATA: lt_attribute     TYPE usmd_ts_fieldname,
          ls_attribute     TYPE usmd_fieldname,
          lv_status        TYPE yz_dtel_status,
          lr_entity_data_s TYPE REF TO data,
          lt_rule_status   TYPE yz_ttyp_rule_stat,
          is_rule_status   LIKE LINE OF lt_rule_status.


    FIELD-SYMBOLS : <lt_entity_data> TYPE ANY TABLE,
                    <it_data>        TYPE ANY TABLE.

***fetching usmd_entity for derivation

    DATA(it_derivation) = FILTER #( it_rule_exe_entry USING KEY filter_key WHERE rule_sec EQ '3' ).
*    DELETE it_derivation WHERE rule_sec NE '3'.
    DATA(lv_derivation_entity) = it_derivation[ 1 ]-entity.
***Fetching data reference for edition CR types
    IF gs_app_context-usmd_edition IS NOT INITIAL.
      get_derive_write_references( EXPORTING io_model = ip_app_context-o_model iv_fieldname = CONV #( lv_derivation_entity ) if_incl_edition_fld = abap_true
                                   IMPORTING er_s_write = DATA(ir_s_write)
                                             er_t_write = DATA(ir_t_write) ).
    ENDIF.

***Fetching erivation usmd_entity data from global tables
    TRY.
        IF data IS BOUND.
          data->get_entity_data(
            EXPORTING
              iv_crequest  = gs_app_context-crequest
              iv_entity    = lv_derivation_entity
              it_key_value = ip_app_context-key_value
            IMPORTING
              er_data   = DATA(er_data) ) .
        ENDIF.

      CATCH cx_root INTO DATA(lr_error).
        collect_exceptions( lr_error->get_text( )  ).
    ENDTRY.

    ASSIGN er_data->* TO FIELD-SYMBOL(<it_entity_data>).

    IF <it_entity_data> IS ASSIGNED AND <it_entity_data> IS NOT INITIAL.
****** Derive entity is active and derivation required for field(s) -Starts
      LOOP AT <it_entity_data> ASSIGNING FIELD-SYMBOL(<is_entity_data>).
        IF <is_entity_data> IS ASSIGNED AND <is_entity_data> IS NOT INITIAL.
          LOOP AT it_derivation INTO DATA(is_derivation).
            ASSIGN COMPONENT is_derivation-attribute OF STRUCTURE <is_entity_data> TO FIELD-SYMBOL(<fs_attribute>).
            IF <fs_attribute> IS ASSIGNED AND <fs_attribute> IS INITIAL.
              DATA(ls_yztabl_value) = gt_yztabl_rule_val_prc[ KEY filter_key
                                                              model     = is_derivation-model
                                                              exe_id    = is_derivation-exe_id
                                                              rule_sec  = is_derivation-rule_sec
                                                              val_type  = 'VR' ]. "Fetching data from value table
              <fs_attribute> = ls_yztabl_value-low.
              is_rule_status = CORRESPONDING #( is_derivation ).
              CLEAR ls_attribute.
              ls_attribute = is_derivation-attribute.
              INSERT ls_attribute INTO TABLE lt_attribute.
            ELSEIF <fs_attribute> IS ASSIGNED AND <fs_attribute> IS NOT INITIAL.
              is_rule_status = CORRESPONDING #( is_derivation ).
              is_rule_status-status = gc_na.
              INSERT ls_attribute INTO TABLE lt_attribute.
            ENDIF.
            APPEND is_rule_status TO lt_rule_status.
            CLEAR is_rule_status.
          ENDLOOP.

          IF  gs_app_context-usmd_edition IS NOT INITIAL.

            ASSIGN ir_s_write->* TO FIELD-SYMBOL(<fss_entity_data>).
            ASSIGN ir_t_write->* TO FIELD-SYMBOL(<fst_entity_data>).

            <fss_entity_data> = CORRESPONDING #( BASE ( <fss_entity_data> ) <is_entity_data> ).

            ASSIGN COMPONENT 'USMD_EDITION' OF STRUCTURE <fss_entity_data> TO FIELD-SYMBOL(<fs_edition>).

            <fs_edition> =  gs_app_context-usmd_edition.

            INSERT <fss_entity_data> INTO TABLE <fst_entity_data>.

          ENDIF.
        ENDIF.
      ENDLOOP.

      IF  gs_app_context-usmd_edition IS INITIAL.
        ASSIGN <it_entity_data> TO FIELD-SYMBOL(<ft_entity_data>).
      ELSE.
        ASSIGN <fst_entity_data> TO <ft_entity_data>.
      ENDIF.

      IF <ft_entity_data> IS ASSIGNED AND <ft_entity_data> IS NOT INITIAL.

        TRY.
            ip_app_context-o_write_data->write_data(
              EXPORTING
                i_entity     = lv_derivation_entity           " usmd_entity Type
                it_attribute = lt_attribute              " Financials MDM: Field Name
                it_data      = <ft_entity_data> ).

          CATCH cx_usmd_write_error INTO DATA(lv_usmd_write_error). " Error while writing to buffer
            collect_exceptions( lv_usmd_write_error->get_text( )  ).
            rv_result = 'F'.
        ENDTRY.
      ENDIF.

*******update log****** ""

      update_rule_status(
        EXPORTING
          it_rule_status  =  lt_rule_status
          iv_status      =  COND #( WHEN lv_usmd_write_error IS INITIAL THEN gc_pass ELSE gc_fail )
       IMPORTING
          es_rule_status = DATA(ls_rule_status)                    " Status
      ).

      create_app_log( is_rule_status = ls_rule_status ).


****  Derive entity field derivation -Ends

    ELSE. "Derive entity is inactive and entire usmd_entity has to be derived along with keys

      "fetching key fields of usmd_entity
      cl_usmd_services=>get_entity_key_attributes( EXPORTING iv_model     = gs_app_context-model iv_entity = lv_derivation_entity     " usmd_entity Type
                                                   RECEIVING rt_attribute =  DATA(lt_keys) ).

      TRY.
          ip_app_context-o_write_data->create_data_reference( EXPORTING i_entity     =  lv_derivation_entity i_struct     =  yz_intf_mdg_accelerator_const=>gc_struct_key_attr    " Type of Data Structure
                                                              RECEIVING er_data      =  DATA(lr_entity_data) ).
        CATCH cx_usmd_write_error INTO lv_usmd_write_error. " Error while creating object reference
          collect_exceptions( lv_usmd_write_error->get_text( )  ).
      ENDTRY.

      IF lr_entity_data IS INITIAL.
        RETURN.
      ELSE.
        ASSIGN lr_entity_data->* TO <lt_entity_data>.
        CREATE DATA lr_entity_data_s LIKE LINE OF <lt_entity_data>.
        ASSIGN lr_entity_data_s->* TO FIELD-SYMBOL(<ls_entity_data>).
        IF <ls_entity_data> IS ASSIGNED.
          LOOP AT lt_keys INTO DATA(ls_keys).
            IF line_exists( gt_entity_key[ field = ls_keys ] ).
              DATA(ls_entity_key) = gt_entity_key[ field = ls_keys ]..
              ASSIGN COMPONENT ls_keys OF STRUCTURE <ls_entity_data> TO FIELD-SYMBOL(<fs_key_field>).
              IF <fs_key_field> IS ASSIGNED AND <fs_key_field> IS INITIAL.
                <fs_key_field> = ls_entity_key-key_value.
              ENDIF.

            ELSE.
              CLEAR: is_derivation , ls_yztabl_value.
              is_derivation = it_derivation[ KEY key_attr attribute = ls_keys ]. "checking if the key attribute of entity is present in execution entry
              IF sy-subrc = 0.
                ASSIGN COMPONENT ls_keys OF STRUCTURE <ls_entity_data> TO <fs_key_field>.
                IF <fs_key_field> IS ASSIGNED AND <fs_key_field> IS INITIAL.
                  ls_yztabl_value = gt_yztabl_rule_val_prc[ KEY filter_key
                                                            model     = is_derivation-model
                                                            exe_id    = is_derivation-exe_id
                                                            rule_sec  = is_derivation-rule_sec
                                                            val_type  = 'VR' ]. "Fetching data from value table
                  <fs_key_field> = ls_yztabl_value-low.
                  DELETE it_derivation USING KEY key_attr WHERE attribute = ls_keys.
                ENDIF.

                "Update Global Table with current key value
*              IF line_exists( gt_entity_key[ entity = is_derivation-entity field = is_derivation-attribute  key_value = ls_yztabl_value-low ] ) = abap_false.
                READ TABLE gt_entity_key TRANSPORTING NO FIELDS
                                                       WITH KEY entity     = is_derivation-entity
                                                                field      = is_derivation-attribute
                                                                key_value  = ls_yztabl_value-low.
                IF sy-subrc NE 0. " If the entry is not present then we are adding it
                  ls_entity_key = VALUE #( entity = is_derivation-entity
                                           field  = is_derivation-attribute
                                           key_value  = ls_yztabl_value-low  ).
                  APPEND ls_entity_key TO yz_clas_mdg_utility=>gt_entity_key.
                ENDIF.
                CLEAR: ls_yztabl_value, is_derivation.
              ENDIF.
            ENDIF.

          ENDLOOP.

          INSERT <ls_entity_data> INTO TABLE <lt_entity_data>..
        ENDIF.

        IF <lt_entity_data> IS ASSIGNED AND <lt_entity_data> IS NOT INITIAL.
          LOOP AT <lt_entity_data> ASSIGNING FIELD-SYMBOL(<fs_entity_data1>).
            CLEAR is_derivation.
            LOOP AT it_derivation INTO is_derivation.
              ASSIGN COMPONENT is_derivation-attribute OF STRUCTURE <fs_entity_data1> TO FIELD-SYMBOL(<fs_attribute1>).
              IF <fs_attribute1> IS ASSIGNED AND <fs_attribute1> IS INITIAL.
                ls_yztabl_value = gt_yztabl_rule_val_prc[ KEY filter_key
                                                          model     = is_derivation-model
                                                          exe_id    = is_derivation-exe_id
                                                          rule_sec  = is_derivation-rule_sec
                                                          val_type  = 'VR' ]. "Fetching data from value table
                <fs_attribute1> = ls_yztabl_value-low.
                is_rule_status = CORRESPONDING #( is_derivation ).
              ENDIF.
              APPEND is_rule_status TO lt_rule_status.
              CLEAR is_rule_status.
            ENDLOOP.

            IF  gs_app_context-usmd_edition IS NOT INITIAL.

              ASSIGN ir_s_write->* TO <fss_entity_data>.
              ASSIGN ir_t_write->* TO <fst_entity_data>.

              <fss_entity_data> = CORRESPONDING #( BASE ( <fss_entity_data> ) <fs_entity_data1> ).

              ASSIGN COMPONENT 'USMD_EDITION' OF STRUCTURE <fss_entity_data> TO <fs_edition>.

              <fs_edition> =  gs_app_context-usmd_edition.

              INSERT <fss_entity_data> INTO TABLE <fst_entity_data>.

            ENDIF.
          ENDLOOP.
        ENDIF.

        IF  gs_app_context-usmd_edition IS INITIAL.
          ASSIGN <lt_entity_data> TO <ft_entity_data>.
        ELSE.
          ASSIGN <fst_entity_data> TO <ft_entity_data>.
        ENDIF.

        IF  <ft_entity_data> IS ASSIGNED AND <ft_entity_data> IS NOT INITIAL.
          TRY.
              ip_app_context-o_write_data->write_data(
                EXPORTING
                  i_entity     =  lv_derivation_entity                " usmd_entity Type
                  it_data      = <ft_entity_data>
              ).
            CATCH cx_usmd_write_error INTO lv_usmd_write_error. " Error while writing to buffer
              collect_exceptions( lv_usmd_write_error->get_text( )  ).
              rv_result = 'F'.
          ENDTRY.
        ENDIF.

*******update log******
        update_rule_status(
          EXPORTING
             it_rule_status  =  lt_rule_status
             iv_status       =  COND #( WHEN lv_usmd_write_error IS INITIAL THEN gc_pass ELSE gc_fail )
         IMPORTING
            es_rule_status = ls_rule_status                    " Status
        ).

        create_app_log( is_rule_status = ls_rule_status ).

      ENDIF.
    ENDIF.

    rv_result = COND #( WHEN rv_result IS INITIAL THEN 'S' ELSE rv_result ).

  ENDMETHOD.


  METHOD execute_dqm_scope.

    execute_dqm_procedure(
      EXPORTING
        iv_model                   = iv_model                   " Data Model
        iv_rule_sec                = gc_rule_section_scope      " Rule Section
        iv_rule_type               = iv_rule_type               " Business Rule Type
        iv_mdqltytechnicalruleuuid = iv_mdqltytechnicalruleuuid " Master Data Quality: UUID for BRFplus
        iv_process_key             = iv_process_key             " Master Data Consolidation: Key of Process Data Table
        is_dqm_eval_context        = is_dqm_eval_context        " Evaluation Context
        is_dqm_derive_context      = is_dqm_derive_context      " Derivation Context
      RECEIVING
        rv_boolean                 = ev_boolean                 " Boolean Variable (X = True, - = False, Space = Unknown)
      ).

    IF et_def_ids IS REQUESTED.

      SELECT FROM @gt_rule_prc AS itab
           FIELDS 'I' AS sign , 'EQ' AS options, def_id AS low , ' ' AS high
            WHERE rule_sec = @gc_rule_section_scope
              AND result   = @abap_true
             INTO TABLE @et_def_ids.

    ENDIF.

    SELECT FROM @gt_rule_prc AS itab
         FIELDS def_id
          WHERE rule_sec = @gc_rule_section_scope
            AND result    = @abap_true
     INTO TABLE @DATA(lt_def_ids).

    CONCATENATE LINES OF lt_def_ids INTO rv_def_ids SEPARATED BY cl_abap_char_utilities=>cr_lf.

  ENDMETHOD.


  METHOD execute_validation_unv.
    DATA : lv_sql_error TYPE string.
    DATA : lt_entity_attr TYPE yz_clas_mdg_utility=>gtt_entity_attr.

    lt_entity_attr = VALUE #( FOR ls_rule_exe IN it_rule_exe_entry USING KEY filter_key WHERE ( rule_sec = iv_rule_sec AND task EQ gc_rule_task_check  )
                                                                                              ( entity   = ls_rule_exe-entity attribute = ls_rule_exe-attribute )  ).

    DATA(lv_result) = execute_uniqueness_check( IMPORTING ev_sql_error  = lv_sql_error
                                                CHANGING ct_entity_attr = lt_entity_attr ).


    IF lv_result EQ abap_false AND lv_sql_error IS INITIAL.

      validate_prepare_message( EXPORTING  it_rule_exe_entry  = it_rule_exe_entry
                                     IMPORTING  et_message         = DATA(lt_message) ).

      et_message = VALUE #( BASE et_message FOR ls_message IN lt_message ( ls_message ) ).
    ENDIF.

    "Update Log:
    update_rule_status( EXPORTING iv_status      = COND #( WHEN lv_result = abap_true THEN 'F' ELSE 'P' )               " Status
                                           is_br_context  = VALUE #( model = gs_app_context-model
                                                                     def_id = iv_def_id
                                                                     exe_type = gs_app_context-rule_type )
                                           iv_msgtxt      = CONV char100( ev_exception_text )
                                 IMPORTING es_rule_status = DATA(ls_rule_status)  ).

    IF ev_exception_text IS INITIAL.

      create_app_log( it_message        = COND #( WHEN et_message IS NOT INITIAL THEN et_message )                " Messages
                              is_rule_status    = ls_rule_status ).

    ENDIF.

    IF et_message IS INITIAL.
      rv_return = abap_true.
    ENDIF.

  ENDMETHOD.


  METHOD get_entity_attr_data_using_cr.

    SORT ct_entity_attr BY entity attribute.
    LOOP AT ct_entity_attr ASSIGNING FIELD-SYMBOL(<lfs_entity_attr>).

      AT NEW entity.
        "at the start read usmd_entity data
        TRY.

            data->get_entity_data(
               EXPORTING
                 iv_crequest  = gs_app_context-crequest
                 iv_entity    = <lfs_entity_attr>-entity
                 it_key_value = gs_app_context-key_value
               IMPORTING
                 er_data      = DATA(lr_data)  ).

            ASSIGN lr_data->* TO FIELD-SYMBOL(<lfs_entity_data>).
          CATCH cx_root INTO DATA(lr_error).
            collect_exceptions( lr_error->get_text( )  ).
        ENDTRY.

      ENDAT.

      CHECK <lfs_entity_data> IS ASSIGNED.

      "for each attribute of the usmd_entity store the value somewhere
      IF <lfs_entity_data> IS ASSIGNED.
        LOOP AT <lfs_entity_data> ASSIGNING FIELD-SYMBOL(<lfs_data>).
          ASSIGN COMPONENT <lfs_entity_attr>-attribute OF STRUCTURE <lfs_data> TO FIELD-SYMBOL(<fs_val>).
          IF sy-subrc EQ 0 AND <fs_val> IS ASSIGNED.
            <lfs_entity_attr>-attr_value = <fs_val>.
          ENDIF.
        ENDLOOP.

      ENDIF.


      TRY .
          DATA(ls_metadata) = gt_yztabl_metadata[ model = gs_app_context-model entity = <lfs_entity_attr>-entity attribute = <lfs_entity_attr>-attribute ].
          <lfs_entity_attr>-tabname   = ls_metadata-tabname.
          <lfs_entity_attr>-fieldname = ls_metadata-fieldname.
        CATCH cx_sy_itab_line_not_found into data(lo_error).
          collect_exceptions( lo_error->get_text( )  ).

      ENDTRY.
      CLEAR : ls_metadata.
    ENDLOOP.

  ENDMETHOD.


  METHOD get_entity_attr_data_using_gov.

    DATA(lo_gov_api) = get_cr_gov_api( iv_crequest = gs_app_context-crequest ).

    IF lo_gov_api IS BOUND.

      lo_gov_api->get_crequest_data( EXPORTING iv_crequest_id          =  gs_app_context-crequest                " Change Request
                                     IMPORTING et_entity_data_inactive =  DATA(lt_data) ).
    ENDIF.

    SORT ct_entity_attr BY entity attribute.
    LOOP AT ct_entity_attr ASSIGNING FIELD-SYMBOL(<lfs_entity_attr>).

      AT NEW entity.
        "at the start read usmd_entity data
        TRY .
            IF <lfs_entity_attr>-entity EQ gs_app_context-entity_main.
              DATA(ls_data) = lt_data[ usmd_entity = gs_app_context-entity_main struct = 'KATTR' ].
            ELSE.
              ls_data = lt_data[ usmd_entity_cont = <lfs_entity_attr>-entity ].    " For other usmd_entity
            ENDIF.
            ASSIGN ls_data-r_data->* TO FIELD-SYMBOL(<lfs_entity_data>).
          CATCH cx_sy_itab_line_not_found into data(lo_error).
            collect_exceptions( lo_error->get_text( )  ).

        ENDTRY.
      ENDAT.
      "for each attribute of the usmd_entity store the value somewhere
      IF <lfs_entity_data> IS ASSIGNED.
        LOOP AT <lfs_entity_data> ASSIGNING FIELD-SYMBOL(<lfs_data>).
          ASSIGN COMPONENT <lfs_entity_attr>-attribute OF STRUCTURE <lfs_data> TO FIELD-SYMBOL(<fs_val>).
          IF sy-subrc EQ 0 AND <fs_val> IS ASSIGNED.
            <lfs_entity_attr>-attr_value = <fs_val>.
          ENDIF.
        ENDLOOP.

      ENDIF.


      TRY .
          DATA(ls_metadata) = gt_yztabl_metadata[ model = gs_app_context-model entity = <lfs_entity_attr>-entity attribute = <lfs_entity_attr>-attribute ].
          <lfs_entity_attr>-tabname   = ls_metadata-tabname.
          <lfs_entity_attr>-fieldname = ls_metadata-fieldname.
        CATCH cx_sy_itab_line_not_found into data(lo_error1).
          collect_exceptions( lo_error1->get_text( )  ).

      ENDTRY.
      CLEAR : ls_metadata.
    ENDLOOP.
  ENDMETHOD.


  method GET_LAST_CHARACTER.
    rv_last_char = substring( off = strlen( iv_string ) - 1 len = 1 val = iv_string ).
  endmethod.


  METHOD validate_metadeta.
    DATA : lt_usertype TYPE domtab_t,
           ls_message TYPE usmd_s_message.
    rv_result = abap_true.
    CASE iv_attribute.
      WHEN 'STEP_TYPE'.
        SELECT SINGLE usmd_cr_stype FROM usmd230c WHERE usmd_cr_stype EQ @iv_value INTO @DATA(lv_steptype).
        IF sy-subrc IS NOT INITIAL.
          rv_result = abap_false.
        ENDIF.
      WHEN 'NWF_STEP'.
        SELECT SINGLE usmd_creq_step FROM usmd202c_ssw WHERE usmd_creq_step EQ @iv_value INTO @DATA(lv_nwf_step).
        IF sy-subrc IS NOT INITIAL.
          rv_result = abap_false.
        ENDIF.
      WHEN 'CR_STATUS'.
        SELECT SINGLE usmd_creq_status FROM usmd130c WHERE usmd_creq_status EQ @iv_value INTO @DATA(lv_status).
        IF sy-subrc IS NOT INITIAL.
          rv_result = abap_false.
        ENDIF.
      WHEN 'USER_TYPE'.
        CALL FUNCTION 'FKK_DOMAINVALUE_GET'
          EXPORTING
            i_domname  = 'USMD_AGENT_TYPE'                " Name of ABAP Dictionary Object
          CHANGING
            c_domtable = lt_usertype.               " Table Type for DOMTAB
        IF NOT line_exists( lt_usertype[ domvalue_l = iv_value ] ).
            rv_result = abap_false.
        ENDIF.
    ENDCASE.
  ENDMETHOD.


  METHOD yz_intf_mdg_accelerator_config~get_nr_itm_id_for_rule.

    DATA lv_rc             TYPE inri-returncode.
    DATA lt_view_temp_itm  TYPE STANDARD TABLE OF yz_view_temp_itm WITH NON-UNIQUE KEY mandt model otc rule_type temp_id.

    IF it_tab IS NOT INITIAL.
      lt_view_temp_itm  = it_tab[].
    ENDIF.

    CALL FUNCTION 'NUMBER_GET_NEXT'
      EXPORTING
        nr_range_nr             = 'IN'
        object                  = 'YZ_RULE_IT'
        subobject               = iv_rule_sec
      IMPORTING
        number                  = rv_itm_id
        returncode              = lv_rc
      EXCEPTIONS
        interval_not_found      = 1
        number_range_not_intern = 2
        object_not_found        = 3
        quantity_is_0           = 4
        quantity_is_not_1       = 5
        interval_overflow       = 6
        buffer_overflow         = 7
        OTHERS                  = 8.

    IF sy-subrc = 0.
      DO.
        SELECT SINGLE @abap_true AS lv_ui_exist FROM @lt_view_temp_itm AS itab WHERE exe_id = @( | { iv_temp_id && iv_rule_sec && rv_itm_id } | ) INTO @DATA(lv_ui_exist).
        SELECT SINGLE @abap_true AS lv_db_exist FROM yztabl_temp_itm           WHERE exe_id = @( | { iv_temp_id && iv_rule_sec && rv_itm_id } | ) INTO @DATA(lv_db_exist).
        IF lv_ui_exist = abap_true OR lv_db_exist = abap_true.
          rv_itm_id = COND #( WHEN iv_rule_sec = '1' THEN | { 'U' && rv_itm_id } |
                              WHEN iv_rule_sec = '2' THEN | { 'S' && rv_itm_id } |
                              WHEN iv_rule_sec = '3' THEN | { 'C' && rv_itm_id } | ).
        ELSE.
          EXIT.
        ENDIF.
      ENDDO.
    ENDIF.

  ENDMETHOD.


  method YZ_INTF_MDG_ACCELERATOR_CONFIG~GET_NR_TMP_ID_FOR_RULE.

  DATA lv_rc TYPE inri-returncode.

  CALL FUNCTION 'NUMBER_GET_NEXT'
  EXPORTING
    nr_range_nr             = '01'
    object                  = 'YZ_RULE_TE'
*    subobject               = iv_rule_type
  IMPORTING
    NUMBER                  = rv_tmp_id
    returncode              = lv_rc
  EXCEPTIONS
    interval_not_found      = 1
    number_range_not_intern = 2
    object_not_found        = 3
    quantity_is_0           = 4
    quantity_is_not_1       = 5
    interval_overflow       = 6
    buffer_overflow         = 7
    OTHERS                  = 8.

  IF sy-subrc <> 0.

  ENDIF.

  endmethod.


  METHOD yz_intf_mdg_accelerator_config~process_yz_view_rule_tmp.

    FIELD-SYMBOLS : <fs_data> TYPE yz_view_rule_tmp.
    DATA lt_yztabl_rule_tmp   TYPE STANDARD TABLE OF yztabl_rule_tmp.

*--------------------------------------------------------------------*
*  CR Validation
*--------------------------------------------------------------------*
    IF iv_event_id = 'CR_CHECK' AND ct_data[] IS NOT INITIAL.
      lt_yztabl_rule_tmp = CORRESPONDING #( ct_data ).
      LOOP AT lt_yztabl_rule_tmp INTO DATA(ls_yztabl_rule_tmp).
*    Check Model
*    ls_yztabl_rule_def-model
*        *
*        *
*        *
      ENDLOOP.
    ENDIF.

*--------------------------------------------------------------------*
* GUI Validation
*--------------------------------------------------------------------*
    IF iv_event_id = 'ON_NEW_ENTRY' OR iv_event_id = 'INSTEAD_OF_STD_VALIDATION'.

      LOOP AT ct_data ASSIGNING FIELD-SYMBOL(<fsv_data>).
        ASSIGN: <fsv_data> TO <fs_data> CASTING.
        IF <fs_data> IS ASSIGNED.
          IF <fs_data>-rule_type IS INITIAL.
            MESSAGE 'Rule Type is mandatory' TYPE 'E' DISPLAY LIKE 'I'.
            RETURN.
          ENDIF.
        ENDIF.
      ENDLOOP.
    ENDIF.
*--------------------------------------------------------------------*
*    Logic To Generate Rule ID
*--------------------------------------------------------------------*
    IF iv_event_id = 'ON_NEW_ENTRY'.
      IF cs_data IS NOT INITIAL.
        ASSIGN: cs_data TO <fs_data> CASTING.
        CHECK <fs_data> IS ASSIGNED.
        IF <fs_data>-rule_type IS INITIAL.
          MESSAGE 'Rule Type is mandatory' TYPE 'E' DISPLAY LIKE 'I'.
          RETURN.
        ENDIF.
        IF <fs_data>-temp_id IS INITIAL.
          <fs_data>-temp_id =  get_nr_tmp_id_for_rule( ).
          CONDENSE <fs_data>-temp_id.
        ENDIF.

      ELSE.
        LOOP AT ct_data ASSIGNING <fsv_data>.
          ASSIGN: <fsv_data> TO <fs_data> CASTING.
          CHECK <fs_data> IS ASSIGNED.
          IF <fs_data>-temp_id IS INITIAL.
            <fs_data>-temp_id =  get_nr_tmp_id_for_rule( ).
            CONDENSE <fs_data>-temp_id.
          ENDIF.
        ENDLOOP.
      ENDIF.
    ENDIF.

  ENDMETHOD.


  METHOD yz_intf_mdg_accelerator_config~process_yz_view_temp_itm.

    FIELD-SYMBOLS : <fs_data> TYPE yz_view_temp_itm.

    DATA lt_yz_view_rule_temp TYPE STANDARD TABLE OF yz_view_rule_tmp.
    DATA lt_yztabl_temp_itm   TYPE STANDARD TABLE OF yztabl_temp_itm.

*--------------------------------------------------------------------*
*    validate_record macro
*--------------------------------------------------------------------*
    DEFINE validate_record.
      IF <fs_data>-rule_sec IS INITIAL.
        MESSAGE 'Rule Section is mandatory' TYPE 'E' DISPLAY LIKE 'I'.
        RETURN.
      ENDIF.
    END-OF-DEFINITION.

*--------------------------------------------------------------------*
*      set_key_field
*--------------------------------------------------------------------*
    DEFINE set_key_field.
      IF <fs_data>-exe_id IS INITIAL AND <fs_data>-rule_sec IS NOT INITIAL.
        <fs_data>-exe_id = <fs_data>-temp_id
        && '_'
        && <fs_data>-rule_sec
        && '_'
        && get_nr_itm_id_for_rule( iv_temp_id = <fs_data>-temp_id  iv_rule_sec = <fs_data>-rule_sec ).
      ENDIF.
    END-OF-DEFINITION.


*--------------------------------------------------------------------*
*    set_non_key_field macro
*--------------------------------------------------------------------*
    DEFINE set_non_key_field.
      <fs_data>-temp_desc  = COND #( WHEN <fs_data>-temp_desc  IS INITIAL THEN lt_yz_view_rule_temp[ 1 ]-temp_desc
                                                                          ELSE <fs_data>-temp_desc ).
      IF <fs_data>-rule_sec IS NOT INITIAL.
      <fs_data>-sec_desc = COND #( WHEN <fs_data>-sec_desc IS INITIAL THEN gt_yztabl_rule_sec[ rule_sec = <fs_data>-rule_sec ]-sec_desc
                                                                      ELSE <fs_data>-sec_desc ).
      ENDIF.
    END-OF-DEFINITION.

*--------------------------------------------------------------------*
*  CR Validation
*--------------------------------------------------------------------*
    IF iv_event_id = 'CR_CHECK' AND ct_data[] IS NOT INITIAL.
      lt_yztabl_temp_itm = CORRESPONDING #( ct_data ).
      LOOP AT lt_yztabl_temp_itm INTO DATA(ls_yztabl_temp_itm).
*    Check Model
*    ls_yztabl_rule_def-model
*        *
*        *
*        *
      ENDLOOP.
    ENDIF.

*--------------------------------------------------------------------*
*    Validation
*--------------------------------------------------------------------*
    IF iv_event_id = 'ON_NEW_ENTRY' OR
    iv_event_id = 'INSTEAD_OF_STD_VALIDATION'.

      LOOP AT ct_data ASSIGNING FIELD-SYMBOL(<fsv_data>).
        ASSIGN: <fsv_data> TO <fs_data> CASTING.
        IF <fs_data> IS ASSIGNED AND <fs_data> IS NOT INITIAL.
          validate_record.
        ENDIF.
      ENDLOOP.
    ENDIF.

    IF iv_event_id = 'ON_NEW_ENTRY'.
      IF cs_data IS NOT INITIAL.
        ASSIGN: cs_data TO <fs_data> CASTING.
        CHECK <fs_data> IS ASSIGNED.
        validate_record.
        set_key_field.
      ELSE.

        LOOP AT ct_data ASSIGNING <fsv_data>.
          ASSIGN: <fsv_data> TO <fs_data> CASTING.
          CHECK <fs_data> IS ASSIGNED.
          validate_record.
          set_key_field.
        ENDLOOP.
      ENDIF.
    ENDIF.

*--------------------------------------------------------------------*
*            Fill Non Key Fields
*--------------------------------------------------------------------*
    IF iv_event_id = 'BEFORE_NAVIGATION'.
      IF it_super_set_config IS NOT INITIAL.
        lt_yz_view_rule_temp[] = it_super_set_config[].
        IF ct_data IS INITIAL.
          INSERT INITIAL LINE INTO TABLE ct_data ASSIGNING <fs_data>  CASTING.
          IF sy-subrc = 0.
            <fs_data> = CORRESPONDING #( lt_yz_view_rule_temp[ 1 ] ).
            IF <fs_data>-rule_sec IS INITIAL.
              <fs_data>-rule_sec  = '1'.        <fs_data>-seq_no   = '1U01'.
              <fs_data>-task      = 'CHECK'.   <fs_data>-operation = 'IF'.
              <fs_data>-entity    = 'YY_USAGE'.<fs_data>-attribute = 'CR_TYPE'.
              <fs_data>-exe_type  = 'USAGE_V'.    <fs_data>-active = abap_true.
            ENDIF.
            set_key_field.
            set_non_key_field.
            UNASSIGN <fs_data>.
          ENDIF.

        ELSE.
          LOOP AT ct_data ASSIGNING <fs_data> CASTING.
            set_non_key_field.
          ENDLOOP.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD execute_dqm_condition.

    execute_dqm_procedure(
      EXPORTING
        iv_model                   = iv_model                   " Data Model
        iv_rule_sec                = gc_rule_section_condition  " Rule Section
        iv_rule_type               = iv_rule_type               " Business Rule Type
        iv_mdqltytechnicalruleuuid = iv_mdqltytechnicalruleuuid " Master Data Quality: UUID for BRFplus
        iv_process_key             = iv_process_key             " Master Data Consolidation: Key of Process Data Table
        is_dqm_eval_context        = is_dqm_eval_context        " Evaluation Context
        is_dqm_derive_context      = is_dqm_derive_context      " Derivation Context
      RECEIVING
        rv_boolean                 = rv_boolean                 " Boolean Variable (X = True, - = False, Space = Unknown)
      ).

  ENDMETHOD.


  METHOD execute_dqm_procedure.

    DATA ls_app_context LIKE gs_app_context.
*--------------------------------------------------------------------*
*Step 1 : Prepare Current Session App Context
*--------------------------------------------------------------------*
    ls_app_context = VALUE #( model        = iv_model
                              otc          = is_dqm_eval_context-businessobjecttype
                              crequest     = is_dqm_eval_context-changerequest_id
                              rule_stage   = is_dqm_eval_context-rule_stage
                              rule_usage   = is_dqm_eval_context-rule_usage
                              rule_purpose = is_dqm_eval_context-rule_purpose
                              rule_type    = iv_rule_type
                              key_value    = VALUE gty_t_key_value( ( key_field = get_cr_main_entity( iv_model = iv_model iv_otc = is_dqm_eval_context-businessobjecttype )
                                                                      value     = iv_process_key-source_id ) )
                             ).

*--------------------------------------------------------------------*
*Step 2 : Get Acceleration Service and Derive Rest of App Context
*--------------------------------------------------------------------*
    get_accl_service( iv_model  = iv_model is_app_context = ls_app_context ).

*--------------------------------------------------------------------*
*Step 3 : Using Derived App Context - Execute Business Rules
*--------------------------------------------------------------------*
    IF my IS BOUND.

      my->execute_business_rules(
        EXPORTING
          iv_def_id      = get_current_dqm_rule_id( iv_mdqltytechnicalruleuuid  )
          iv_rule_sec    = iv_rule_sec
          ip_app_context = my->gs_app_context
        RECEIVING
          rv_result      =  rv_boolean                " Result type of Technical rule evaluation in rule engine
          ).

    ENDIF.

  ENDMETHOD.


  METHOD GET_RULE_EXE_RECORDS.

    SELECT sign,option,low,high FROM @it_selection AS lt_execution_filter
                                WHERE fieldname =: 'DEF_ID'    INTO TABLE @DATA(lt_sel_def_id).
*
    IF lt_sel_def_id IS NOT INITIAL.
       SELECT * FROM yztabl_rule_exe WHERE def_id IN @lt_sel_def_id
                                     AND   active EQ @abap_true
                                     INTO TABLE @rt_rule_exe_entries.
     ENDIF.

  ENDMETHOD.


  METHOD GET_RULE_VAL_RECORDS.

    SELECT sign,option,low,high FROM @it_selection AS lt_exe_filter WHERE fieldname =: 'EXE_ID' INTO TABLE @DATA(lt_sel_exe_id).

    SELECT * FROM yztabl_rule_val INTO TABLE @rt_rule_val_entries WHERE exe_id  IN @lt_sel_exe_id
                                                                  AND   active EQ @abap_true.
  ENDMETHOD.


  METHOD validate_prepare_message.

    DATA : ls_message     TYPE usmd_s_message.
    DATA : lt_string_comp TYPE TABLE OF swastrtab.

    ASSIGN ir_data->*     TO FIELD-SYMBOL(<it_data>).

    SELECT * FROM @it_rule_exe_entry AS itab
     WHERE rule_sec EQ @gc_rule_section_condition
       AND entity = 'YYMSG'
INTO TABLE @DATA(lt_msg_exe).

    LOOP AT lt_msg_exe INTO DATA(ls_msg_exe).

      TRY .
          CASE ls_msg_exe-attribute.
            WHEN 'MSGID'.
              DATA(lv_msgid)   = gt_yztabl_rule_val_prc[ KEY filter_exe exe_id = ls_msg_exe-exe_id ]-low.
            WHEN 'MSGTYP'.
              DATA(lv_msgtyp)  = gt_yztabl_rule_val_prc[ KEY filter_exe exe_id = ls_msg_exe-exe_id ]-low.
            WHEN 'MSGNO'.
              DATA(lv_msgno)   = gt_yztabl_rule_val_prc[ KEY filter_exe exe_id = ls_msg_exe-exe_id ]-low.
            WHEN 'MSGTXT'.
              DATA(lv_msg_txt) = REDUCE #( INIT text = ` ` FOR ls_msg_txt IN gt_yztabl_rule_val_prc USING KEY filter_exe WHERE ( exe_id = ls_msg_exe-exe_id )
                                           NEXT text = text && ls_msg_txt-low ).
            WHEN OTHERS.
              DATA(ls_msg) = gt_yztabl_rule_val_prc[ KEY filter_exe exe_id = ls_msg_exe-exe_id ].
              IF ls_msg-val_type EQ 'EA'.
                DATA(lv_attr) = substring_after( val = ls_msg-low sub = '-').
                IF <it_data> IS NOT INITIAL AND <it_data> IS ASSIGNED.
                  LOOP AT <it_data> ASSIGNING FIELD-SYMBOL(<fs_data>).

                    ASSIGN COMPONENT lv_attr OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_val>).
                    IF <fs_val> IS ASSIGNED.
                      DATA(lv_msg_val) = CONV char30( <fs_val> ).
                    ENDIF.
                  ENDLOOP.
                ENDIF.

              ELSEIF ls_msg-val_type EQ 'VR'.
                lv_msg_val = ls_msg-low.
              ENDIF .
              CASE ls_msg_exe-attribute.
                WHEN 'MSGV1'.
                  DATA(ls_msgv1) = lv_msg_val.
                WHEN 'MSGV2'.
                  DATA(lv_msgv2) = lv_msg_val.
                WHEN 'MSGV3'.
                  DATA(lv_msgv3) = lv_msg_val.
                WHEN 'MSGV4'.
                  DATA(lv_msgv4) = lv_msg_val.
              ENDCASE.
          ENDCASE.



        CATCH cx_sy_itab_line_not_found INTO DATA(lo_error).
          collect_exceptions( lo_error->get_text( )  ).

      ENDTRY.
    ENDLOOP.

    IF lv_msgid IS NOT INITIAL AND lv_msgno IS NOT INITIAL.
      IF <it_data> IS NOT INITIAL AND <it_data> IS ASSIGNED.
        LOOP AT <it_data> ASSIGNING FIELD-SYMBOL(<ls_data>).
          EXIT.
        ENDLOOP.
      ENDIF.
*        message_hyperlink(
*          EXPORTING
*            is_entity_data =
*            iv_entity      = is_yztabl_validate-usmd_entity                 " usmd_entity Type
*            iv_attribute   = is_yztabl_validate-usmd_attribute                 " Source Field
*          IMPORTING
*            ev_row         =                 " MDG message navigation: row referencing a key
*        ).
      et_message = VALUE #( ( msgid = lv_msgid
                              msgno = lv_msgno
                              msgty = COND #( WHEN lv_msgtyp IS NOT INITIAL THEN lv_msgtyp
                                                                                ELSE gc_msg_type_e )
                              msgv1 = ls_msgv1
                              msgv2 = lv_msgv2
                              msgv3 = lv_msgv3
                              msgv4 = lv_msgv4 ) ).


    ENDIF.
    IF lv_msg_txt IS NOT INITIAL.
      CALL FUNCTION 'SWA_STRING_SPLIT'
        EXPORTING
          input_string         = lv_msg_txt      "string to be split
          max_component_length = 50
        TABLES
          string_components    = lt_string_comp.

      TRY .
          DATA(lv_substring1)  = lt_string_comp[ 1 ].
          DATA(lv_substring2)  = lt_string_comp[ 2 ].
          DATA(lv_substring3)  = lt_string_comp[ 3 ].
          DATA(lv_substring4)  = lt_string_comp[ 4 ].


        CATCH cx_sy_itab_line_not_found INTO DATA(lo_error1).
          collect_exceptions( lo_error1->get_text( )  ).

      ENDTRY.

      et_message = VALUE #( BASE et_message ( msgid = yz_intf_mdg_accelerator_const=>gc_mapper_message_id
                                              msgno = yz_intf_mdg_accelerator_const=>gc_mapper_message_no
                                              msgv1 = lv_substring1-str
                                              msgv2 = lv_substring2-str
                                              msgv3 = lv_substring3-str
                                              msgv4 = lv_substring4-str
                                              msgty = COND #( WHEN lv_msgtyp IS NOT INITIAL THEN lv_msgtyp
                                                              ELSE gc_msg_type_e ) ) ).
*                                              row = yz_clas_mdg_utility=>set_message_hyperlink(
*                                                                                                iv_model       = gs_app_context-model
*                                                                                                iv_entity      = id_entitytype
*                                                                                                is_entity_data = <fs_data>
*                                                                                                iv_attribute   =
*                                                                                              ) ) ).
    ENDIF.

    "Requirment is not clear


*    IF ls_msg-mapper_id IS NOT INITIAL.
*      CHECK <it_data> IS ASSIGNED AND <it_data> IS NOT INITIAL.
*      get_msg_from_mapper_table( EXPORTING io_model   = io_model
*                                           mapper_id  = ls_msg-mapper_id
*                                           it_data    = <it_data>
*                                           id_entitytype = id_entitytype
*                                 IMPORTING et_message = et_message ).
*
*
*
*    ENDIF.
  ENDMETHOD.


  METHOD clean_up.

    IF iv_usmd_crequest <> gs_app_context-crequest ."OR iv_rule_type <> gs_app_context-rule_type.
      CLEAR gs_app_context.
    ENDIF.

  ENDMETHOD.


  METHOD collect_exceptions.
    BREAK-POINT ID yz_acid_stepup_exception_cpg.
    LOG-POINT   ID yz_acid_stepup_exception_cpg
            SUBKEY sy-cprog
            FIELDS iv_exception.

    rt_message = build_message_for_exception( iv_exception ).
  ENDMETHOD.


  METHOD CREATE_APP_LOG.

    CHECK is_log_maintainance_req( iv_app_log_required = abap_true ) EQ abap_true.

    DATA : ls_bal_msg TYPE bal_s_msg,
           lt_balmi   TYPE STANDARD TABLE OF balmi.

    DATA: lo_datatype TYPE REF TO cl_abap_datadescr,
          lv_field(5) TYPE c.

    DATA(ls_balhdri)    = get_appl_header( iv_exe_type = gs_app_context-rule_type
                                           iv_model          = CONV #( gs_app_context-model ) ).
    IF ls_balhdri IS INITIAL.
      ls_balhdri-object    = yz_intf_mdg_accelerator_const=>gc_mdg_badi_trace.
      ls_balhdri-subobject = yz_intf_mdg_accelerator_const=>gc_mdg_badi_trace.
    ENDIF.

    IF ls_balhdri IS NOT INITIAL.

      IF is_rule_status IS NOT INITIAL.
        ls_bal_msg-msgid = yz_intf_mdg_accelerator_const=>gc_msg_clas_name.
        ls_bal_msg-msgno = 008.

        CASE is_rule_status-status.
          WHEN yz_intf_mdg_accelerator_const=>gc_pass.
            ls_bal_msg-msgty = yz_intf_mdg_accelerator_const=>gc_msg_type_i.
            ls_bal_msg-msgv3 = yz_intf_mdg_accelerator_const=>gc_pass_text.
          WHEN yz_intf_mdg_accelerator_const=>gc_fail.
            ls_bal_msg-msgty = yz_intf_mdg_accelerator_const=>gc_msg_type_e.
            ls_bal_msg-msgv3 = yz_intf_mdg_accelerator_const=>gc_fail_text.
          WHEN yz_intf_mdg_accelerator_const=>gc_na.
            ls_bal_msg-msgty = yz_intf_mdg_accelerator_const=>gc_msg_type_i.
            ls_bal_msg-msgv3 = yz_intf_mdg_accelerator_const=>gc_na_text.
          WHEN yz_intf_mdg_accelerator_const=>gc_error.
            ls_bal_msg-msgty = yz_intf_mdg_accelerator_const=>gc_msg_type_e.
            ls_bal_msg-msgv3 = yz_intf_mdg_accelerator_const=>gc_error_text.
          WHEN OTHERS.
            ls_bal_msg-msgty = yz_intf_mdg_accelerator_const=>gc_msg_type_i.
            ls_bal_msg-msgv3 = yz_intf_mdg_accelerator_const=>gc_pass_text.
        ENDCASE.

        ls_bal_msg-msgv1 = is_rule_status-def_id.
*        cl_reca_ddic_doma=>get_text_by_value(
*          EXPORTING
*            id_name   = conv #( 'YZ_DOMA_BR_TYPE' )                 " Domain (If Blank: Determine Via RTTI of ID_VALUE)
*            id_value  =  is_rule_status-process                  " Fixed Value
*            id_langu  = sy-langu         " Language
*          IMPORTING
*            ed_text   =  DATA(lv_process_text)                " Text
*          EXCEPTIONS
*            not_found = 1                " Domain or Fixed Value Does Not Exist
*            OTHERS    = 2 ).
*
*        IF sy-subrc EQ 0.
*          ls_bal_msg-msgv2 = lv_process_text.
*        ENDIF.

        DATA(ls_custom_fields) = CORRESPONDING yztabl_custom_slg1_str( is_rule_status ).
        ls_bal_msg-context-value = ls_custom_fields.
        ls_bal_msg-context-tabname = yz_intf_mdg_accelerator_const=>gc_rule_stat_tabname.


        IF it_message IS NOT INITIAL.
          lt_balmi = CORRESPONDING #( it_message ).
        ENDIF.

      ENDIF.
      DATA(ls_free_text) = is_message.
      CALL FUNCTION 'YZ_FUNC_APP_LOG_CREATE'
        EXPORTING
          balhdri      = ls_balhdri
          iv_bal_msg   = ls_bal_msg
          iv_free_text = ls_free_text
        TABLES
          messages     = lt_balmi.

    ENDIF.

  ENDMETHOD.


  METHOD EXECUTE_OPERATION_AVG.

    FIELD-SYMBOLS   <ft_data>      TYPE ANY TABLE.

    DATA(lv_source) = '@IT_DATA'.

    er_data = create_range_table( i_typename = CONV #( 'C' ) i_length = 9 ) .
    ASSIGN er_data->* TO <ft_data>.
    IF <ft_data> IS ASSIGNED.

      DATA(lv_field) = |'I'  AS SIGN, 'EQ' AS OPTION, AVG( { is_rule_exe-attribute } ) AS LOW, ` ` AS HIGH | .

      TRY .
          SELECT (lv_field) FROM (lv_source)    AS itab INTO TABLE @<ft_data>.
        CATCH cx_sy_dynamic_osql_semantics INTO DATA(lo_error) .
          collect_exceptions( lo_error->get_text( ) ).
      ENDTRY.

    ENDIF.

  ENDMETHOD.


  METHOD execute_operation_count.

    FIELD-SYMBOLS   <ft_data>      TYPE ANY TABLE.

    DATA(lv_result)     = condense( CONV string( lines( it_data ) ) ).
    er_data = create_range_table( i_typename = CONV #( 'C' ) i_length = 9 ) .
    ASSIGN er_data->* TO <ft_data>.

    DATA(lv_source) = '@IT_DATA'.

    IF <ft_data> IS ASSIGNED.
*      INSERT INITIAL LINE INTO TABLE <ft_data> ASSIGNING FIELD-SYMBOL(<fs_data>).
*      assign_to( EXPORTING component_name = 'LOW'    value = lv_result CHANGING structure = <fs_data> ).
*      assign_to( EXPORTING component_name = 'SIGN'   value = 'I'       CHANGING structure = <fs_data> ).
*      assign_to( EXPORTING component_name = 'OPTION' value = 'EQ'      CHANGING structure = <fs_data> ).
      IF <ft_data> IS ASSIGNED.

        DATA(lv_field) = |'I'  AS SIGN, 'EQ' AS OPTION, MAX( { lv_result } ) AS LOW, ` ` AS HIGH | .

        TRY .
            SELECT (lv_field) FROM (lv_source)    AS itab INTO TABLE @<ft_data>.
          CATCH cx_sy_dynamic_osql_semantics INTO DATA(lo_error) .
            collect_exceptions( lo_error->get_text( ) ).
        ENDTRY.

      ENDIF.

    ENDIF.

  ENDMETHOD.


  METHOD execute_operation_max.

    DATA            lr_table_field TYPE REF TO data.
    DATA            lv_result      TYPE string.
    FIELD-SYMBOLS   <ft_data>      TYPE ANY TABLE.

    DATA(lv_source) = '@IT_DATA'.

    IF is_rule_exe-attribute IS NOT INITIAL.
      DATA(ls_table_field) = gt_yztabl_metadata[ model = gs_app_context-model entity = is_rule_exe-entity attribute = is_rule_exe-attribute ].
      DATA(lv_table_field) = ls_table_field-tabname && '-' && ls_table_field-fieldname.
      CREATE DATA lr_table_field TYPE (lv_table_field).
    ENDIF.

    er_data = create_range_table( iv_data = lr_table_field ) .
    ASSIGN er_data->* TO <ft_data>.
    IF <ft_data> IS ASSIGNED.

      DATA(lv_field) = |'I'  AS SIGN, 'EQ' AS OPTION, MAX( { is_rule_exe-attribute } ) AS LOW, ` ` AS HIGH | .

      TRY .
          SELECT (lv_field) FROM (lv_source)    AS itab INTO TABLE @<ft_data>.
        CATCH cx_sy_dynamic_osql_semantics INTO DATA(lo_error) .
          collect_exceptions( lo_error->get_text( ) ).
      ENDTRY.

    ENDIF.

  ENDMETHOD.


  METHOD execute_operation_min.

    DATA            lr_table_field TYPE REF TO data.
    DATA            lv_result      TYPE string.
    FIELD-SYMBOLS   <ft_data>      TYPE ANY TABLE.

    DATA(lv_source) = '@IT_DATA'.

    IF is_rule_exe-attribute IS NOT INITIAL.
      DATA(ls_table_field) = gt_yztabl_metadata[ model = gs_app_context-model entity = is_rule_exe-entity attribute = is_rule_exe-attribute ].
      DATA(lv_table_field) = ls_table_field-tabname && '-' && ls_table_field-fieldname.
      CREATE DATA lr_table_field TYPE (lv_table_field).
    ENDIF.

    er_data = create_range_table( iv_data = lr_table_field ) .
    ASSIGN er_data->* TO <ft_data>.
    IF <ft_data> IS ASSIGNED.

      DATA(lv_field) = |'I'  AS SIGN, 'EQ' AS OPTION, MIN( { is_rule_exe-attribute } ) AS LOW, ` ` AS HIGH | .

      TRY .
          SELECT (lv_field) FROM (lv_source)    AS itab INTO TABLE @<ft_data>.
        CATCH cx_sy_dynamic_osql_semantics INTO DATA(lo_error) .
          collect_exceptions( lo_error->get_text( ) ).
      ENDTRY.

    ENDIF.

  ENDMETHOD.


  METHOD EXECUTE_OPERATION_SPLIT_AT.

    FIELD-SYMBOLS   <ft_data>      TYPE ANY TABLE.

    DATA(lv_source) = '@IT_DATA'.

    er_data = create_range_table( i_typename = CONV #( 'C' ) i_length = 9 ) .
    ASSIGN er_data->* TO <ft_data>.
    IF <ft_data> IS ASSIGNED.

      DATA(lv_field) = |'I'  AS SIGN, 'EQ' AS OPTION, SUM( { is_rule_exe-attribute } ) AS LOW, ` ` AS HIGH | .

      TRY .
          SELECT (lv_field) FROM (lv_source)    AS itab INTO TABLE @<ft_data>.
        CATCH cx_sy_dynamic_osql_semantics INTO DATA(lo_error) .
          collect_exceptions( lo_error->get_text( )  ).
      ENDTRY.

    ENDIF.

  ENDMETHOD.


  METHOD EXECUTE_OPERATION_SPLIT_LEN.

    FIELD-SYMBOLS   <ft_data>      TYPE ANY TABLE.

    DATA(lv_source) = '@IT_DATA'.

    er_data = create_range_table( i_typename = CONV #( 'C' ) i_length = 9 ) .
    ASSIGN er_data->* TO <ft_data>.
    IF <ft_data> IS ASSIGNED.

      DATA(lv_field) = |'I'  AS SIGN, 'EQ' AS OPTION, SUM( { is_rule_exe-attribute } ) AS LOW, ` ` AS HIGH | .

      TRY .
          SELECT (lv_field) FROM (lv_source)    AS itab INTO TABLE @<ft_data>.
        CATCH cx_sy_dynamic_osql_semantics INTO DATA(lo_error) .
          collect_exceptions( lo_error->get_text( )  ).
      ENDTRY.

    ENDIF.

  ENDMETHOD.


  METHOD execute_operation_sum.

    FIELD-SYMBOLS   <ft_data>      TYPE ANY TABLE.

    DATA(lv_source) = '@IT_DATA'.

    er_data = create_range_table( i_typename = CONV #( 'C' ) i_length = 9 ) .
    ASSIGN er_data->* TO <ft_data>.
    IF <ft_data> IS ASSIGNED.

      DATA(lv_field) = |'I'  AS SIGN, 'EQ' AS OPTION, SUM( { is_rule_exe-attribute } ) AS LOW, ` ` AS HIGH | .

      TRY .
          SELECT (lv_field) FROM (lv_source)    AS itab INTO TABLE @<ft_data>.
        CATCH cx_sy_dynamic_osql_semantics INTO DATA(lo_error) .
          collect_exceptions( lo_error->get_text( ) ).
      ENDTRY.

    ENDIF.

  ENDMETHOD.


  METHOD execute_regex_compare.

    DATA : lr_table_field TYPE REF TO data.
    FIELD-SYMBOLS : <lt_data> TYPE STANDARD TABLE.

    IF iv_read_function IS NOT INITIAL.
      DATA(ls_table_field) = gt_yztabl_metadata[ model = gs_app_context-model entity = is_rule_exe-entity attribute = is_rule_exe-attribute ].
      DATA(lv_table_field) = ls_table_field-tabname && '-' && ls_table_field-fieldname.
      CREATE DATA lr_table_field TYPE (lv_table_field).

      create_attribute_range_table( EXPORTING iv_attribute   = CONV #( is_rule_exe-attribute )
                                              it_data        = it_data
                                              ir_table_field = lr_table_field
                                    IMPORTING er_data        = DATA(lr_data) ).
      ASSIGN lr_data->* TO <lt_data>.
    ELSE.
      ASSIGN it_data TO <lt_data>.
    ENDIF.

    IF <lt_data> IS ASSIGNED.

      DATA(lv_source) = '@<LT_DATA> AS ITAB'.
      LOOP AT it_values INTO DATA(ls_values).

        TRY .
            SELECT COUNT( * ) FROM (lv_source) WHERE like_regexpr( pcre = @ls_values-low , value = low ) = '1'.
          CATCH cx_sy_dynamic_osql_semantics INTO DATA(lo_error).
            collect_exceptions( lo_error->get_text( ) ).
        ENDTRY.

        IF sy-subrc = 0.
          rv_result = abap_true.
          EXIT.
        ENDIF.

      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  method execute_task.

    try.
        if sy-uname = 'NIKHDESHPAND'.
          data->get_entity_data(
            exporting
              iv_crequest  = gs_app_context-crequest
              iv_entity    = is_rule_exe-entity
              it_key_value = ip_app_context-key_value "get_dependent_filter( entity,key v , it_key_value(return))
            importing
              er_data      = er_data ).
        else.
*      IF sy-uname = 'HARKUMARI'.
        me->get_dependent_filter(
          exporting
            iv_entity      = is_rule_exe-entity            " Entity Type
            is_rule_exe    = is_rule_exe                " Business Rule Implementation
            ip_app_context = ip_app_context                " Application Context Data
          importing
            et_key_val     = data(lt_key_val)               " Key Value Table Type
        ).
        data->get_entity_data(
          exporting
            iv_crequest  = gs_app_context-crequest
            iv_entity    = is_rule_exe-entity
            it_key_value = conv #( lt_key_val ) "get_dependent_filter( entity,key v , it_key_value(return))
          importing
            er_data      = er_data ).



*      ENDIF.
*        data->get_entity_data(
*           EXPORTING
*             iv_crequest  = gs_app_context-crequest
*             iv_entity    = is_rule_exe-entity
*             it_key_value = ip_app_context-key_value "get_dependent_filter( entity,key v , it_key_value(return))
*           IMPORTING
*             er_data     = er_data  ).
endif.
      catch cx_root into data(lr_error).
        collect_exceptions( lr_error->get_text( )  ).
    endtry.

    rv_result = get_result_of_exe_id( exporting is_rule_exe       = is_rule_exe
                                                it_val_prc        = it_val_prc
                                                ir_data           = er_data
                                      importing ev_exception_text = ev_exception_text ).

  endmethod.


  METHOD execute_value_expression.

    FIELD-SYMBOLS   <ft_data>      TYPE ANY TABLE.

    IF it_data IS NOT INITIAL.

      CASE is_rule_exe-operation.

        WHEN 'COUNT'. execute_operation_count( EXPORTING is_rule_exe = is_rule_exe it_data = it_data  IMPORTING er_data = er_data ).

        WHEN 'MAX'.   execute_operation_max(   EXPORTING is_rule_exe = is_rule_exe it_data = it_data  IMPORTING er_data = er_data ).

        WHEN 'MIN'.   execute_operation_min(   EXPORTING is_rule_exe = is_rule_exe it_data = it_data  IMPORTING er_data = er_data ).

        WHEN 'SUM'.   execute_operation_sum(   EXPORTING is_rule_exe = is_rule_exe it_data = it_data  IMPORTING er_data = er_data ).

        WHEN 'AVG'.   execute_operation_avg(   EXPORTING is_rule_exe = is_rule_exe it_data = it_data  IMPORTING er_data = er_data ).

        WHEN OTHERS."For all Non Arithmatic Operation
          DATA(lv_read_function) = abap_true.
          GET REFERENCE OF it_data INTO er_data.
      ENDCASE.

      ASSIGN er_data->* TO <ft_data>.

      CHECK <ft_data> IS ASSIGNED.

      CASE iv_val_type.
        WHEN 'VR'.
          rv_result = execute_fixed_value_operation( EXPORTING it_values            = it_values
                                                               iv_read_function     = lv_read_function                " Entity Type
                                                               it_data              = <ft_data>
                                                               is_rule_exe          = is_rule_exe ).

        WHEN 'RE'.
          rv_result = execute_regex_compare( EXPORTING it_values        = it_values
                                                       iv_read_function = lv_read_function
                                                       it_data          = <ft_data>
                                                       is_rule_exe      = is_rule_exe   ).

        WHEN 'EA'.
          rv_result = execute_entity_attr_compare( EXPORTING it_values        = it_values
                                                             iv_read_function = lv_read_function
                                                             it_data          = <ft_data>
                                                             is_rule_exe      = is_rule_exe   ).

        WHEN 'DB'.
          rv_result = execute_dblookup( EXPORTING it_values        = it_values
                                                  iv_read_function = lv_read_function
                                                  it_data          = <ft_data>
                                                  is_rule_exe      = is_rule_exe ).

      ENDCASE.

*--------------------------------------------------------------------*
*Set Entity For Perform Tasks
*--------------------------------------------------------------------*
      IF lv_read_function IS INITIAL AND is_rule_exe-task CS 'PER'.

        CASE is_rule_exe-task.

          WHEN gc_rule_task_per_str_t.
*Set virtual Entity YY_CONTEXT and attribute STR_T
          WHEN gc_rule_task_per_str_1.
*Set virtual Entity YY_CONTEXT and attribute STR_1
          WHEN gc_rule_task_per_str_2.
*Set virtual Entity YY_CONTEXT and attribute STR_2
          WHEN gc_rule_task_per_str_3.
*Set virtual Entity YY_CONTEXT and attribute STR_3.
          WHEN OTHERS.

        ENDCASE.
      ENDIF.

    ENDIF.

  ENDMETHOD.


  METHOD get_dependent_filter.

    DATA: lt_key_val TYPE yz_intf_mdg_data_types~gty_t_range_table,
          ls_key_val LIKE LINE OF lt_key_val.
    DATA : lt_key_value TYPE TABLE OF yztabl_s_key_value WITH EMPTY KEY,
           ls_key_value LIKE LINE OF lt_key_value.


    DATA(lo_conv_api) = get_cr_conv_api( iv_crequest = gs_app_context-crequest ).
    CHECK lo_conv_api IS BOUND.

    IF NOT iv_entity CP 'YY*' .

      lo_conv_api->get_entity_key_fields(
        EXPORTING
          iv_entity_name = iv_entity
          iv_struct      = lo_conv_api->gc_struct_key
        RECEIVING
          rt_key_fields  = DATA(lt_keyfields)
      ).
      IF sy-subrc EQ 0.
        LOOP AT lt_keyfields ASSIGNING FIELD-SYMBOL(<lv_keyfield>).
          CHECK <lv_keyfield> IS ASSIGNED AND <lv_keyfield> IS NOT INITIAL.
          IF <lv_keyfield> EQ is_rule_exe-attribute.
            DATA(lt_yztabl_rule_val_prc) = VALUE tt_yztabl_rule_val( FOR ls_rule_val IN gt_yztabl_rule_val_src
                                         USING KEY filter_exe WHERE ( exe_id = is_rule_exe-exe_id ) ( ls_rule_val ) ).

            LOOP AT lt_yztabl_rule_val_prc INTO DATA(ls_rule_value).
              ls_key_val-sign = 'I'.
              ls_key_val-opti = 'EQ'.
              ls_key_val-low = ls_rule_value-low.
              ls_key_val-high = is_rule_exe-attribute.
              APPEND ls_key_val TO lt_key_val.
              IF lt_key_val IS NOT INITIAL.
*                CLEAR et_key_val.
*                et_key_val = lt_key_val.

              ENDIF.
            ENDLOOP.
          ELSE. "" hANDLE SCENARIO FOR THE KEY ENTITy NOT MAINTAINED IN THE TABLE
            READ TABLE ip_app_context-key_value ASSIGNING FIELD-SYMBOL(<ls_key_value>) WITH KEY key_field = <lv_keyfield>.
            IF sy-subrc IS INITIAL AND <ls_key_value> IS ASSIGNED AND <ls_key_value> IS NOT INITIAL.
              ls_key_val-sign = 'I'.
              ls_key_val-opti = 'EQ'.
              ls_key_val-low = <ls_key_value>-value.
              ls_key_val-high = <ls_key_value>-key_field.
              APPEND ls_key_val TO lt_key_val.
              IF lt_key_val IS NOT INITIAL.
*                CLEAR et_key_val.
*                et_key_val = lt_key_val.
              ENDIF.
            ENDIF.
          ENDIF.
        ENDLOOP.
      ENDIF.
    ENDIF.

    LOOP AT lt_key_val ASSIGNING FIELD-SYMBOL(<ls_key_val>).
      CHECK sy-subrc IS INITIAL AND <ls_key_val> IS ASSIGNED AND <ls_key_val> IS NOT INITIAL.
      CLEAR ls_key_value.
      ls_key_value-key_field = <ls_key_val>-high.
      ls_key_value-value = <ls_key_val>-low.
      APPEND ls_key_value TO lt_key_value.
    ENDLOOP.
    CLEAR et_key_val.
    et_key_val = lt_key_value.
  ENDMETHOD.


  METHOD IS_LOG_MAINTAINANCE_REQ.

    "get the current ext mode api
    rv_required = COND boole_d( WHEN line_exists( gt_yztabl_rule_dom[ KEY filter_app_log app_log = abap_true ] ) AND
                                     iv_app_log_required IS NOT INITIAL THEN abap_true
                                WHEN line_exists( gt_yztabl_rule_dom[ KEY filter_br_log br_log = abap_true ] ) AND
                                     iv_br_log_required IS NOT INITIAL THEN abap_true
                                ELSE abap_false ).

  ENDMETHOD.
ENDCLASS.
