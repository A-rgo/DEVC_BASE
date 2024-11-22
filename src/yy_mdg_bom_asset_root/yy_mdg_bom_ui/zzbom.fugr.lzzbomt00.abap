*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZBOM_USER.......................................*
DATA:  BEGIN OF STATUS_ZBOM_USER                     .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZBOM_USER                     .
*...processing: ZBOM_USERS......................................*
DATA:  BEGIN OF STATUS_ZBOM_USERS                    .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZBOM_USERS                    .
*.........table declarations:.................................*
TABLES: *ZBOM_USER                     .
TABLES: *ZBOM_USERS                    .
TABLES: ZBOM_USER                      .
TABLES: ZBOM_USERS                     .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
