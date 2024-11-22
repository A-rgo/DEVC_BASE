class YZ_CLAS_MDG_BADI_CONTROL definition
  public
  final
  create public .

public section.

  interfaces IF_BADI_INTERFACE .
  interfaces IF_EX_USMD_RULE_SERVICE .
  interfaces IF_EX_USMD_RULE_SERVICE2 .
  interfaces YZIF_MDG_BADI_INTERFACE .

  aliases CHECK_CREQUEST
    for IF_EX_USMD_RULE_SERVICE~CHECK_CREQUEST .
  aliases CHECK_CREQUEST_FINAL
    for IF_EX_USMD_RULE_SERVICE~CHECK_CREQUEST_FINAL .
  aliases CHECK_CREQUEST_HIERARCHY
    for IF_EX_USMD_RULE_SERVICE~CHECK_CREQUEST_HIERARCHY .
  aliases CHECK_CREQUEST_START
    for IF_EX_USMD_RULE_SERVICE~CHECK_CREQUEST_START .
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
  aliases DERIVE
    for IF_EX_USMD_RULE_SERVICE2~DERIVE .
  aliases DERIVE_ENTITY
    for IF_EX_USMD_RULE_SERVICE~DERIVE_ENTITY .
protected section.
private section.
ENDCLASS.



CLASS YZ_CLAS_MDG_BADI_CONTROL IMPLEMENTATION.


  METHOD if_ex_usmd_rule_service2~derive.
  ENDMETHOD.


  METHOD if_ex_usmd_rule_service~check_crequest.
  ENDMETHOD.


  METHOD if_ex_usmd_rule_service~check_crequest_final.
  ENDMETHOD.


  METHOD if_ex_usmd_rule_service~check_crequest_hierarchy.
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
  ENDMETHOD.


  METHOD if_ex_usmd_rule_service~check_entity_hierarchy.
  ENDMETHOD.


  METHOD if_ex_usmd_rule_service~derive_entity.
  ENDMETHOD.
ENDCLASS.
