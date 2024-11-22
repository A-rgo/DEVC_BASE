*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: YZTABL_RARE_SCR.................................*
DATA:  BEGIN OF STATUS_YZTABL_RARE_SCR               .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_YZTABL_RARE_SCR               .
CONTROLS: TCTRL_YZTABL_RARE_SCR
            TYPE TABLEVIEW USING SCREEN '0100'.
*.........table declarations:.................................*
TABLES: *YZTABL_RARE_SCR               .
TABLES: YZTABL_RARE_SCR                .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
