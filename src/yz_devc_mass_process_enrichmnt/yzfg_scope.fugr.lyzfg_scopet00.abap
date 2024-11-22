*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: YZTABLE_SCOPE...................................*
DATA:  BEGIN OF STATUS_YZTABLE_SCOPE                 .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_YZTABLE_SCOPE                 .
CONTROLS: TCTRL_YZTABLE_SCOPE
            TYPE TABLEVIEW USING SCREEN '0001'.
*...processing: YZ_V_SCOPE......................................*
TABLES: YZ_V_SCOPE, *YZ_V_SCOPE. "view work areas
CONTROLS: TCTRL_YZ_V_SCOPE
TYPE TABLEVIEW USING SCREEN '0002'.
DATA: BEGIN OF STATUS_YZ_V_SCOPE. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_YZ_V_SCOPE.
* Table for entries selected to show on screen
DATA: BEGIN OF YZ_V_SCOPE_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE YZ_V_SCOPE.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_V_SCOPE_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF YZ_V_SCOPE_TOTAL OCCURS 0010.
INCLUDE STRUCTURE YZ_V_SCOPE.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_V_SCOPE_TOTAL.

*.........table declarations:.................................*
TABLES: *YZTABLE_SCOPE                 .
TABLES: YZTABLE_SCOPE                  .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
