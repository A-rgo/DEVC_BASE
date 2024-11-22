*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZREF_OBJ_CLASS..................................*
DATA:  BEGIN OF STATUS_ZREF_OBJ_CLASS                .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZREF_OBJ_CLASS                .
CONTROLS: TCTRL_ZREF_OBJ_CLASS
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZREF_OBJ_CLASS                .
TABLES: ZREF_OBJ_CLASS                 .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
