*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: YZTABL_RARE_EXE.................................*
DATA:  BEGIN OF STATUS_YZTABL_RARE_EXE               .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_YZTABL_RARE_EXE               .
CONTROLS: TCTRL_YZTABL_RARE_EXE
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *YZTABL_RARE_EXE               .
TABLES: YZTABL_RARE_EXE                .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
