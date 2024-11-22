*&---------------------------------------------------------------------*
*& Report YZ_PROG_RARE_WEBGUI_HELP_MENU
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT yz_prog_webgui_help_menu.

* Report includes
INCLUDE yz_prog_webgui_help_menu_top.

* Intialize RaRe NWBC
  CALL METHOD yz_clas_rare_nwbc=>init_cr
    IMPORTING
      ev_usmd_model = gv_data_model
      ev_crequest   = gv_crequest.

* Prepare calling tcode
    gv_tcode = 'NWBC-' && gv_data_model.

* Call RaRe Execute
    CALL METHOD yz_clas_rare_base=>execute_rare
      EXPORTING
        iv_calling_tcode = gv_tcode.
