class YZ_CLAS_MDG_0G_RULE_PROCESS definition
  public
  final
  create public .

public section.

  interfaces YZ_INTF_MDG_RULE_PROCESS .

  aliases EXECUTE_DYNAMIC_CLASS_METHOD
    for YZ_INTF_MDG_RULE_PROCESS~EXECUTE_DYNAMIC_CLASS_METHOD .

  methods CONSTRUCTOR .
  class-methods GET_RULE_PROCESS
    returning
      value(RO_RULE_PROCESS) type ref to YZ_INTF_MDG_RULE_PROCESS .
  PRIVATE SECTION.
    CLASS-DATA my_0g_rule TYPE REF TO yz_clas_mdg_0g_rule_process.
ENDCLASS.



CLASS YZ_CLAS_MDG_0G_RULE_PROCESS IMPLEMENTATION.


  METHOD constructor.
    super->constructor( ).
  ENDMETHOD.


  METHOD get_rule_process.
    IF my_0g_rule IS INITIAL.
      CREATE OBJECT my_0g_rule.
    ENDIF.

    IF my_0g_rule IS BOUND.
      ro_rule_process ?= my_0g_rule.
    ELSE.
*      Raise Exception
    ENDIF.
  ENDMETHOD.


  METHOD YZ_INTF_MDG_RULE_PROCESS~EXECUTE_DYNAMIC_CLASS_METHOD.

  ENDMETHOD.


  METHOD yz_intf_mdg_rule_process~execute_standard_derivations.

*  EXECUTING STANDARD DERIVATION OF 0G DATA MODEL
    TRY.
        DATA(lo_obj) = NEW cl_usmdz7_rs_cross_entity( ).

        lo_obj->if_ex_usmd_rule_service2~derive(
        EXPORTING
          io_model        =  io_model                " MDG Data Model for Access from Non-SAP Standard Code
          io_changed_data =  io_changed_data                " Data Modified in Current Round Trip
          io_write_data   =  io_write_data               " Derived Data
        IMPORTING
          et_message_info =  et_message_info               " Errors are changed to warnings!
          ).

      CATCH cx_root INTO DATA(lr_error).
        DATA(lv_error) = lr_error->get_text( ).
    ENDTRY.

  ENDMETHOD.


  METHOD yz_intf_mdg_rule_process~execute_standard_validations.

*  EXECUTING STANDARD VALIDATION OF 0G DATA MODEL
    TRY.
        DATA(lo_obj) = cl_usmdz_object_factory=>get_instance_rule_services( iv_entity = id_entitytype ).

        lo_obj->if_ex_usmd_rule_service~check_entity(
        EXPORTING
          io_model          = io_model               " MDM Data Model for Access from Non-SAP Standard
          id_edition        = id_edition               " Edition
          id_crequest       = id_crequest                " Change Request
          id_entitytype     = id_entitytype                 " Entity Type
*         if_online_check   = abap_true        " ' ' = Validation, 'X' = Online Check
          it_data           = it_data                " Master Data
        IMPORTING
          et_message        = et_message ).                 " Messages

      CATCH cx_usmdz_exception INTO DATA(lr_error). " Exception Class for USMDZ
        DATA(lv_error) = lr_error->get_text( ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
