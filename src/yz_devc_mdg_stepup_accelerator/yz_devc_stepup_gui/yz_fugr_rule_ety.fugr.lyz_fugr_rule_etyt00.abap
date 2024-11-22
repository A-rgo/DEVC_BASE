*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: YZ_VIEW_RULE_ETY................................*
TABLES: YZ_VIEW_RULE_ETY, *YZ_VIEW_RULE_ETY. "view work areas
CONTROLS: TCTRL_YZ_VIEW_RULE_ETY
TYPE TABLEVIEW USING SCREEN '0001'.
DATA: BEGIN OF STATUS_YZ_VIEW_RULE_ETY. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_YZ_VIEW_RULE_ETY.
* Table for entries selected to show on screen
DATA: BEGIN OF YZ_VIEW_RULE_ETY_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE YZ_VIEW_RULE_ETY.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_VIEW_RULE_ETY_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF YZ_VIEW_RULE_ETY_TOTAL OCCURS 0010.
INCLUDE STRUCTURE YZ_VIEW_RULE_ETY.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_VIEW_RULE_ETY_TOTAL.

*.........table declarations:.................................*
TABLES: YZTABL_RULE_ETY                .
