class ZCLBRF_65CA9DF1232B1EDDAE_0007 definition
  public
  inheriting from CL_SWF_BRF_FUNCTION_BASE
  create public .

public section.

  methods CONSTRUCTOR .
  methods EXECUTE
    raising
      CX_SWF_BRF_EXCEPTION .
protected section.
private section.
ENDCLASS.



CLASS ZCLBRF_65CA9DF1232B1EDDAE_0007 IMPLEMENTATION.


  method CONSTRUCTOR.
 super->constructor( ).
 m_class_name = 'ZCLBRF_65CA9DF1232B1EDDAE_0007' .               "#EC NOTEXT
 IF_SWF_BRF_FUNCTION~m_function_id = '65CA9DF1232B1EDDAE9B191EE804CF62' .
 IF_SWF_BRF_FUNCTION~m_ruleset_id = '' .
 m_version = '001' .               "#EC NOTEXT
  endmethod.


  method EXECUTE.

 call method _PROCESS_FUNCTION(  ).


  endmethod.
ENDCLASS.
