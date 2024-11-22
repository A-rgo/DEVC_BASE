class ZCL_MDC_DATA_YZ_BO definition
  public
  inheriting from CL_MDC_DATA
  create protected

  global friends CL_MDC_DATA
                 IF_MDC_MODEL
                 IF_MDC_SQL_BRIDGE .

public section.

  methods CONSTRUCTOR
    importing
      !IO_MODEL type ref to IF_MDC_MODEL
      !IV_TABLE_NAME type TABNAME
      !IV_PROCESS_ID type MDC_PROCESS_ID optional
      !IV_STEP_NUMBER type MDC_PROCESS_STEP_NO optional
      !IV_STEP_TYPE type MDC_PROCESS_STEP_TYPE optional
      !IV_PACKAGE_SIZE type I default GC_DEFAULT_PACKAGE_SIZE
      !IV_PROCESS_RELEVANT type ABAP_BOOL
      !IV_OMIT_RULES type ABAP_BOOL
      !IV_BRFPLUS_ALLOWED type MDC_BRFPLUS_ALLOWED default ABAP_FALSE
      !IV_SKIP_OWN_SYSTEM type ABAP_BOOL default ABAP_FALSE
    raising
      CX_MDC_MODEL .

  methods IF_MDC_DATA~APPEND_ACTIVE_RECORDS
    redefinition .
  methods IF_MDC_DATA~TABLE_NAME_BY_TYPE
    redefinition .
protected section.

  types:
    BEGIN OF source_key,
        source_system TYPE mdg_business_system,
        source_id     TYPE YZTABL_RULE__ACT-MODEL,
      END OF source_key .
  types:
    source_key_list TYPE STANDARD TABLE OF source_key WITH EMPTY KEY .
private section.
ENDCLASS.



CLASS ZCL_MDC_DATA_YZ_BO IMPLEMENTATION.


  method CONSTRUCTOR.
    super->constructor(
      io_model = io_model
      iv_table_name = iv_table_name
      iv_process_id = iv_process_id
      iv_step_number = iv_step_number
      iv_step_type = iv_step_type
      iv_package_size = iv_package_size
      iv_process_relevant = iv_process_relevant
      iv_omit_rules = iv_omit_rules
      iv_brfplus_allowed = iv_brfplus_allowed
      iv_skip_own_system = iv_skip_own_system
    ).
    me->source_id_field = 'MODEL'.
    me->active_client_field = 'MANDT'.
  endmethod.


  method IF_MDC_DATA~APPEND_ACTIVE_RECORDS.
    DATA(source_keys) = CONV source_key_list( it_source_keys ).
    super->if_mdc_data~append_active_records( source_keys ).
  endmethod.


  method IF_MDC_DATA~TABLE_NAME_BY_TYPE.
    CHECK me->process_relevant = abap_true OR iv_type = gc_type-active OR iv_type = gc_type-proxy.
    CHECK me->table_name = me->model->root_table OR iv_type <> gc_type-status.
    IF iv_type = gc_type-active OR iv_type = gc_type-proxy.
      rv_table_name = me->table_name. RETURN.
    ENDIF.
    rv_table_name = me->model->bo_type && SWITCH #( iv_type
                                                    WHEN gc_type-source THEN gc_suffix-source
                                                    WHEN gc_type-status THEN gc_suffix-status
                                                    WHEN gc_type-process THEN gc_suffix-process
                                                  ).
    rv_table_name = rv_table_name+0(16).
    CHECK rv_table_name+1(2) CS '_'.
    rv_table_name+1(2) = replace( val = rv_table_name+1(2)  sub = '_'  with = 'Z' ).
  endmethod.
ENDCLASS.
