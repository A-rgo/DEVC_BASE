*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: YZ_VIEW_RULE_AUT................................*
TABLES: YZ_VIEW_RULE_AUT, *YZ_VIEW_RULE_AUT. "view work areas
CONTROLS: TCTRL_YZ_VIEW_RULE_AUT
TYPE TABLEVIEW USING SCREEN '0001'.
DATA: BEGIN OF STATUS_YZ_VIEW_RULE_AUT. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_YZ_VIEW_RULE_AUT.
* Table for entries selected to show on screen
DATA: BEGIN OF YZ_VIEW_RULE_AUT_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE YZ_VIEW_RULE_AUT.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_VIEW_RULE_AUT_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF YZ_VIEW_RULE_AUT_TOTAL OCCURS 0010.
INCLUDE STRUCTURE YZ_VIEW_RULE_AUT.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_VIEW_RULE_AUT_TOTAL.

*.........table declarations:.................................*
TABLES: YZTABL_RULE_AUT                .
