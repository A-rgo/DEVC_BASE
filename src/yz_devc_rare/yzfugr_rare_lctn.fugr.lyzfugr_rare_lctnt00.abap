*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: YZTABL_RARE_LCTN................................*
DATA:  BEGIN OF STATUS_YZTABL_RARE_LCTN              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_YZTABL_RARE_LCTN              .
CONTROLS: TCTRL_YZTABL_RARE_LCTN
            TYPE TABLEVIEW USING SCREEN '0100'.
*.........table declarations:.................................*
TABLES: *YZTABL_RARE_LCTN              .
TABLES: YZTABL_RARE_LCTN               .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
