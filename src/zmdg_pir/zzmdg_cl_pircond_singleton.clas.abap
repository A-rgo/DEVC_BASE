class ZZMDG_CL_PIRCOND_SINGLETON definition
  public
  final
  create public .

public section.

  class-methods GET_INSTANCE
    returning
      value(E_INSTANCE) type ref to ZZMDG_CL_PIRCOND_SINGLETON .
protected section.
private section.

  class-data MO_INSTANCE type ref to ZZMDG_CL_PIRCOND_SINGLETON .
ENDCLASS.



CLASS ZZMDG_CL_PIRCOND_SINGLETON IMPLEMENTATION.


  method GET_INSTANCE.

  IF mo_instance IS BOUND.
    CREATE OBJECT mo_instance.
  ENDIF.

  e_instance = mo_instance.
  endmethod.
ENDCLASS.
