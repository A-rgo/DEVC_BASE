*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: YZTABL_RARE_SEC.................................*
DATA:  BEGIN OF STATUS_YZTABL_RARE_SEC               .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_YZTABL_RARE_SEC               .
CONTROLS: TCTRL_YZTABL_RARE_SEC
            TYPE TABLEVIEW USING SCREEN '0100'.
*.........table declarations:.................................*
TABLES: *YZTABL_RARE_SEC               .
TABLES: YZTABL_RARE_SEC                .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
