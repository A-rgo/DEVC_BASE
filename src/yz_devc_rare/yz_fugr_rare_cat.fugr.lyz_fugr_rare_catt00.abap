*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: YZTABL_RARE_CATG................................*
DATA:  BEGIN OF STATUS_YZTABL_RARE_CATG              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_YZTABL_RARE_CATG              .
CONTROLS: TCTRL_YZTABL_RARE_CATG
            TYPE TABLEVIEW USING SCREEN '0100'.
*.........table declarations:.................................*
TABLES: *YZTABL_RARE_CATG              .
TABLES: YZTABL_RARE_CATG               .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
