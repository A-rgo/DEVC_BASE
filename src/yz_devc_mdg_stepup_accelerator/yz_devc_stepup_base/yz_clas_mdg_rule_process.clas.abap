class YZ_CLAS_MDG_RULE_PROCESS definition
  public
  inheriting from YZ_CLAS_MDG_DATA_PROCESS
  create public .

public section.

  class-methods CLASS_CONSTRUCTOR .
  methods CONSTRUCTOR
    importing
      !IV_MODEL type USMD_MODEL .
  class-methods GET_RULE_SERVICE
    importing
      !IV_MODEL type USMD_MODEL
    returning
      value(RO_RULE_PROCESS) type ref to YZ_INTF_MDG_RULE_PROCESS .
protected section.

  class-data RULE type ref to YZ_INTF_MDG_RULE_PROCESS .
  PRIVATE SECTION.

    CLASS-DATA gt_rule_subclass TYPE seo_relkeys .
    CONSTANTS gc_rule_process_intf_name TYPE seoclskey VALUE 'YZ_INTF_MDG_RULE_PROCESS' ##NO_TEXT.
ENDCLASS.



CLASS YZ_CLAS_MDG_RULE_PROCESS IMPLEMENTATION.


  METHOD class_constructor.
    gt_rule_subclass = yz_clas_mdg_utility=>get_class_by_impl_interface(
                           iv_interface_name = gc_rule_process_intf_name ).
  ENDMETHOD.


  METHOD constructor.
    super->constructor( iv_model ).
    get_rule_service( iv_model ).
  ENDMETHOD.


  METHOD get_rule_service.
    DATA(lv_dyn_class) = 'YZ_CLAS_MDG_' && iv_model && '_RULE_PROCESS'.

    IF NOT line_exists( gt_rule_subclass[ clsname = lv_dyn_class ] ).
      RETURN.
    ENDIF.

    CALL METHOD (lv_dyn_class)=>('GET_RULE_PROCESS')
      RECEIVING ro_rule_process = ro_rule_process.

    IF ro_rule_process IS BOUND.
      rule ?= ro_rule_process.
    ELSE.
      " Raise EXCEPTION.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
