FUNCTION modify_zgen_data.
*"----------------------------------------------------------------------
*"*"Update Function Module:
*"
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IT_DATA) TYPE  ZMDG_ZX_GEN_DATA_TT
*"----------------------------------------------------------------------
  CHECK it_data IS NOT INITIAL.

  MODIFY zmdg_zx_gen_data FROM TABLE it_data.

ENDFUNCTION.
