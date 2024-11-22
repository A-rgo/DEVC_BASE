FUNCTION MODIFY_ZIDENTITY.
*"----------------------------------------------------------------------
*"*"Update Function Module:
*"
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IT_DATA) TYPE  ZMDG_ZX_IDENTITY_DATA_TT
*"----------------------------------------------------------------------
  CHECK it_data IS NOT INITIAL.

  MODIFY zmdg_zx_identity FROM TABLE it_data.

ENDFUNCTION.
