*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: YZ_VIEW_RULE_VAL................................*
TABLES: YZ_VIEW_RULE_VAL, *YZ_VIEW_RULE_VAL. "view work areas
CONTROLS: TCTRL_YZ_VIEW_RULE_VAL
TYPE TABLEVIEW USING SCREEN '0004'.
DATA: BEGIN OF STATUS_YZ_VIEW_RULE_VAL. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_YZ_VIEW_RULE_VAL.
* Table for entries selected to show on screen
DATA: BEGIN OF YZ_VIEW_RULE_VAL_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE YZ_VIEW_RULE_VAL.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_VIEW_RULE_VAL_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF YZ_VIEW_RULE_VAL_TOTAL OCCURS 0010.
INCLUDE STRUCTURE YZ_VIEW_RULE_VAL.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_VIEW_RULE_VAL_TOTAL.

*.........table declarations:.................................*
TABLES: YZTABL_RULE_DEF                .
TABLES: YZTABL_RULE_EXE                .
TABLES: YZTABL_RULE_SEC                .
TABLES: YZTABL_RULE_TYP                .
TABLES: YZTABL_RULE_VAL                .
