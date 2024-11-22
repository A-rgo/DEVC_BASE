*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZMDG_ZX_API_SWCH................................*
DATA:  BEGIN OF STATUS_ZMDG_ZX_API_SWCH              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZMDG_ZX_API_SWCH              .
CONTROLS: TCTRL_ZMDG_ZX_API_SWCH
            TYPE TABLEVIEW USING SCREEN '0003'.
*...processing: ZMDG_ZX_GEN_DATA................................*
DATA:  BEGIN OF STATUS_ZMDG_ZX_GEN_DATA              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZMDG_ZX_GEN_DATA              .
CONTROLS: TCTRL_ZMDG_ZX_GEN_DATA
            TYPE TABLEVIEW USING SCREEN '0002'.
*...processing: ZMDG_ZX_IDENTITY................................*
DATA:  BEGIN OF STATUS_ZMDG_ZX_IDENTITY              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZMDG_ZX_IDENTITY              .
CONTROLS: TCTRL_ZMDG_ZX_IDENTITY
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZMDG_ZX_API_SWCH              .
TABLES: *ZMDG_ZX_GEN_DATA              .
TABLES: *ZMDG_ZX_IDENTITY              .
TABLES: ZMDG_ZX_API_SWCH               .
TABLES: ZMDG_ZX_GEN_DATA               .
TABLES: ZMDG_ZX_IDENTITY               .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
