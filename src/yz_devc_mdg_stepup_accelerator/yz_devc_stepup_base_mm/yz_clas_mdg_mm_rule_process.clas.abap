class YZ_CLAS_MDG_MM_RULE_PROCESS definition
  public
  inheriting from YZ_CLAS_MDG_MM_RULE_PROCESS_EX
  final
  create protected .

public section.

  interfaces YZ_INTF_MDG_RULE_PROCESS .

  aliases EXECUTE_DYNAMIC_CLASS_METHOD
    for YZ_INTF_MDG_RULE_PROCESS~EXECUTE_DYNAMIC_CLASS_METHOD .

  methods CONSTRUCTOR .
  class-methods GET_RULE_PROCESS
    returning
      value(RO_RULE_PROCESS) type ref to YZ_INTF_MDG_RULE_PROCESS .
protected section.
private section.

  class-data MY_MM_RULE type ref to YZ_CLAS_MDG_MM_RULE_PROCESS .

  methods EXECUTE_RULE_VALIDATION1
    importing
      !IS_RULE_EXE type YZTABL_RULE_EXE
    exporting
      !ET_MESSAGE type USMD_T_MESSAGE
    returning
      value(RV_BOOLEAN) type BOOLEAN .
ENDCLASS.



CLASS YZ_CLAS_MDG_MM_RULE_PROCESS IMPLEMENTATION.


  METHOD constructor.
    super->constructor( ).
  ENDMETHOD.


  METHOD get_rule_process.

    IF my_mm_rule IS INITIAL.
      CREATE OBJECT my_mm_rule.
    ENDIF.

    IF my_mm_rule IS BOUND.
      ro_rule_process ?= my_mm_rule.
    ELSE.
*      Raise Exception
    ENDIF.

  ENDMETHOD.


  method EXECUTE_RULE_VALIDATION1.
    rv_boolean  = abap_true.
  endmethod.


  METHOD yz_intf_mdg_rule_process~execute_dynamic_class_method.

    TRY.

        CALL METHOD (is_rule_exe-method)
          EXPORTING
            is_rule_exe = is_rule_exe
          IMPORTING
            et_message  = et_message
          RECEIVING
            rv_boolean  = rv_boolean.

      CATCH cx_sy_dyn_call_error INTO DATA(exc_ref).
*        MESSAGE exc_ref->get_text( ) TYPE 'I'.
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
