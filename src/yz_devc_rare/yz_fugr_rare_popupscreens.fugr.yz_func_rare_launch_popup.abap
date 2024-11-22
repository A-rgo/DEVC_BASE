FUNCTION yz_func_rare_launch_popup .
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_CLIENT) TYPE  STRING OPTIONAL
*"     REFERENCE(IV_PROGRAM) TYPE  STRING OPTIONAL
*"  EXPORTING
*"     REFERENCE(SCREEN_FIELDS_UPDATED) TYPE  FLAG
*"  CHANGING
*"     REFERENCE(CS_RARE_INCI) TYPE  YZTABL_RARE_INCI OPTIONAL
*"----------------------------------------------------------------------
  DATA:  mo_oref_root TYPE REF TO cx_root,
         mv_text      TYPE string.


  TRY.

*Pass it to UI
      gs_rare_inci = cs_rare_inci .
*Call Screen
      CALL SCREEN 100 STARTING AT 20 2.
*Get Updated Value
      IF cs_rare_inci <> gs_rare_inci.
        screen_fields_updated = abap_true.
        cs_rare_inci  = gs_rare_inci.
      ELSE.
        cs_rare_inci  = gs_rare_inci.
        screen_fields_updated = abap_false.
      ENDIF.


    CATCH cx_root INTO  mo_oref_root .
      mv_text =  mo_oref_root->get_text( ).
      APPEND mv_text TO yz_clas_rare_base=>cs_rare_interface-exceptions.
      yz_clas_rare_base=>collect_mesg( mv_text ).
      CLEAR mv_text.
  ENDTRY.



ENDFUNCTION.
