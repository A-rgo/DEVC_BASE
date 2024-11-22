*&---------------------------------------------------------------------*
*& Report  YZ_PROG_RARE_INCI
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT YZ_PROG_RARE_INCI.


INCLUDE yz_prog_rare_inci_top.
INCLUDE yz_prog_rare_inci_ui.
INCLUDE yz_prog_rare_inci_cl.

INITIALIZATION.
  lcl_handler_factory=>init( ).


START-OF-SELECTION.
  lcl_main_app=>run( ).


END-OF-SELECTION.
  IF gt_exceptions IS NOT INITIAL.
    CALL METHOD yz_clas_rare_base=>send_exceptions
      EXPORTING
        it_exceptions = gt_exceptions.
  ENDIF.
