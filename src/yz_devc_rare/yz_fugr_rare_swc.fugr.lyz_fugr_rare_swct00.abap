*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: YZTABL_RARE_SWCH................................*
DATA:  BEGIN OF STATUS_YZTABL_RARE_SWCH              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_YZTABL_RARE_SWCH              .
CONTROLS: TCTRL_YZTABL_RARE_SWCH
            TYPE TABLEVIEW USING SCREEN '0100'.
*.........table declarations:.................................*
TABLES: *YZTABL_RARE_SWCH              .
TABLES: YZTABL_RARE_SWCH               .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
