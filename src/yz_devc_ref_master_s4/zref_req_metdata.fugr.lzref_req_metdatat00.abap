*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZREF_REQ_METDATA................................*
DATA:  BEGIN OF STATUS_ZREF_REQ_METDATA              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZREF_REQ_METDATA              .
CONTROLS: TCTRL_ZREF_REQ_METDATA
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZREF_REQ_METDATA              .
TABLES: ZREF_REQ_METDATA               .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
