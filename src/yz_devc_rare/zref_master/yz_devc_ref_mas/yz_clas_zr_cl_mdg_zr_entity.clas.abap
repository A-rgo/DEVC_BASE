class YZ_CLAS_ZR_CL_MDG_ZR_ENTITY definition
  public
  final
  create public .

public section.

  interfaces IF_BADI_INTERFACE .
  interfaces IF_EX_USMD_RULE_SERVICE .
protected section.
private section.
ENDCLASS.



CLASS YZ_CLAS_ZR_CL_MDG_ZR_ENTITY IMPLEMENTATION.


  method IF_EX_USMD_RULE_SERVICE~CHECK_ENTITY.
*    BREAK-POINT.
    FIELD-SYMBOLS : <lt_data> TYPE STANDARD TABLE,
                    <ls_data> TYPE any.
    LOOP AT it_data ASSIGNING <ls_data>.

    ENDLOOP.
  endmethod.


  method IF_EX_USMD_RULE_SERVICE~DERIVE_ENTITY.

  endmethod.


  method IF_EX_USMD_RULE_SERVICE~CHECK_CREQUEST.
  endmethod.


  method IF_EX_USMD_RULE_SERVICE~CHECK_CREQUEST_FINAL.
  endmethod.


  method IF_EX_USMD_RULE_SERVICE~CHECK_CREQUEST_HIERARCHY.
  endmethod.


  method IF_EX_USMD_RULE_SERVICE~CHECK_CREQUEST_START.
  endmethod.


  method IF_EX_USMD_RULE_SERVICE~CHECK_EDITION.
  endmethod.


  method IF_EX_USMD_RULE_SERVICE~CHECK_EDITION_FINAL.
  endmethod.


  method IF_EX_USMD_RULE_SERVICE~CHECK_EDITION_HIERARCHY.
  endmethod.


  method IF_EX_USMD_RULE_SERVICE~CHECK_EDITION_START.
  endmethod.


  method IF_EX_USMD_RULE_SERVICE~CHECK_ENTITY_HIERARCHY.
  endmethod.
ENDCLASS.
