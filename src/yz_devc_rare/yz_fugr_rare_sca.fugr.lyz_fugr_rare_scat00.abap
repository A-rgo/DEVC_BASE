*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: YZTABL_RARE_SCAT................................*
DATA:  BEGIN OF STATUS_YZTABL_RARE_SCAT              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_YZTABL_RARE_SCAT              .
CONTROLS: TCTRL_YZTABL_RARE_SCAT
            TYPE TABLEVIEW USING SCREEN '0103'.
*.........table declarations:.................................*
TABLES: *YZTABL_RARE_SCAT              .
TABLES: YZTABL_RARE_SCAT               .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
