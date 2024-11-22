*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: YZ_VIEW_RULE_EXE................................*
TABLES: YZ_VIEW_RULE_EXE, *YZ_VIEW_RULE_EXE. "view work areas
CONTROLS: TCTRL_YZ_VIEW_RULE_EXE
TYPE TABLEVIEW USING SCREEN '0003'.
DATA: BEGIN OF STATUS_YZ_VIEW_RULE_EXE. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_YZ_VIEW_RULE_EXE.
* Table for entries selected to show on screen
DATA: BEGIN OF YZ_VIEW_RULE_EXE_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE YZ_VIEW_RULE_EXE.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_VIEW_RULE_EXE_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF YZ_VIEW_RULE_EXE_TOTAL OCCURS 0010.
INCLUDE STRUCTURE YZ_VIEW_RULE_EXE.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_VIEW_RULE_EXE_TOTAL.

*.........table declarations:.................................*
TABLES: YZTABL_RULE_DEF                .
TABLES: YZTABL_RULE_EXE                .
TABLES: YZTABL_RULE_SEC                .
TABLES: YZTABL_RULE_TYP                .
