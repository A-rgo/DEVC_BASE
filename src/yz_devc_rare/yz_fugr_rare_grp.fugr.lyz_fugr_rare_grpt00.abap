*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: YZTABL_RARE_GRP.................................*
DATA:  BEGIN OF STATUS_YZTABL_RARE_GRP               .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_YZTABL_RARE_GRP               .
CONTROLS: TCTRL_YZTABL_RARE_GRP
            TYPE TABLEVIEW USING SCREEN '0100'.
*.........table declarations:.................................*
TABLES: *YZTABL_RARE_GRP               .
TABLES: YZTABL_RARE_GRP                .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
