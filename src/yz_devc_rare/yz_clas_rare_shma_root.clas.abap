class YZ_CLAS_RARE_SHMA_ROOT definition
  public
  final
  create public
  shared memory enabled .

public section.

  interfaces IF_SHM_BUILD_INSTANCE .

  data GO_MDG_APP_CONTEXT type ref to IF_USMD_APP_CONTEXT .
  data GV_DATA_MODEL type USMD_MODEL .
  data GV_CREQUEST type USMD_CREQUEST .
protected section.
private section.
ENDCLASS.



CLASS YZ_CLAS_RARE_SHMA_ROOT IMPLEMENTATION.


  METHOD if_shm_build_instance~build.
    BREAK kmadheswaran.
  ENDMETHOD.
ENDCLASS.
