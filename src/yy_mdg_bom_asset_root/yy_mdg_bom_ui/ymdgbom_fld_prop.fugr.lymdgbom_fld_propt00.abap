*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: YMDGBOM_FLD_PROP................................*
DATA:  BEGIN OF STATUS_YMDGBOM_FLD_PROP              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_YMDGBOM_FLD_PROP              .
CONTROLS: TCTRL_YMDGBOM_FLD_PROP
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *YMDGBOM_FLD_PROP              .
TABLES: YMDGBOM_FLD_PROP               .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
