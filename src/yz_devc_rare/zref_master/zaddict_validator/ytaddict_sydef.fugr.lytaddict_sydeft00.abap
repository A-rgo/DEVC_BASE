*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: YTADDICT_SYDEF..................................*
DATA:  BEGIN OF STATUS_YTADDICT_SYDEF                .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_YTADDICT_SYDEF                .
CONTROLS: TCTRL_YTADDICT_SYDEF
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *YTADDICT_SYDEF                .
TABLES: YTADDICT_SYDEF                 .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
