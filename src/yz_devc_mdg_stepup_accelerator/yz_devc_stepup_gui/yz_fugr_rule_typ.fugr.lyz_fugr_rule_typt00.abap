*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: YZ_VIEW_RULE_TYP................................*
TABLES: YZ_VIEW_RULE_TYP, *YZ_VIEW_RULE_TYP. "view work areas
CONTROLS: TCTRL_YZ_VIEW_RULE_TYP
TYPE TABLEVIEW USING SCREEN '0001'.
DATA: BEGIN OF STATUS_YZ_VIEW_RULE_TYP. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_YZ_VIEW_RULE_TYP.
* Table for entries selected to show on screen
DATA: BEGIN OF YZ_VIEW_RULE_TYP_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE YZ_VIEW_RULE_TYP.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_VIEW_RULE_TYP_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF YZ_VIEW_RULE_TYP_TOTAL OCCURS 0010.
INCLUDE STRUCTURE YZ_VIEW_RULE_TYP.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_VIEW_RULE_TYP_TOTAL.

*.........table declarations:.................................*
TABLES: YZTABL_RULE_TYP                .
