*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: YZ_VIEW_RULE_OPR................................*
TABLES: YZ_VIEW_RULE_OPR, *YZ_VIEW_RULE_OPR. "view work areas
CONTROLS: TCTRL_YZ_VIEW_RULE_OPR
TYPE TABLEVIEW USING SCREEN '0001'.
DATA: BEGIN OF STATUS_YZ_VIEW_RULE_OPR. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_YZ_VIEW_RULE_OPR.
* Table for entries selected to show on screen
DATA: BEGIN OF YZ_VIEW_RULE_OPR_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE YZ_VIEW_RULE_OPR.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_VIEW_RULE_OPR_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF YZ_VIEW_RULE_OPR_TOTAL OCCURS 0010.
INCLUDE STRUCTURE YZ_VIEW_RULE_OPR.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_VIEW_RULE_OPR_TOTAL.

*.........table declarations:.................................*
TABLES: YZTABL_RULE_OPR                .
