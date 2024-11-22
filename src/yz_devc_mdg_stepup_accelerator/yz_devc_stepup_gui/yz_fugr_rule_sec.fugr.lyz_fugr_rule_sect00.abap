*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: YZ_VIEW_RULE_SEC................................*
TABLES: YZ_VIEW_RULE_SEC, *YZ_VIEW_RULE_SEC. "view work areas
CONTROLS: TCTRL_YZ_VIEW_RULE_SEC
TYPE TABLEVIEW USING SCREEN '0001'.
DATA: BEGIN OF STATUS_YZ_VIEW_RULE_SEC. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_YZ_VIEW_RULE_SEC.
* Table for entries selected to show on screen
DATA: BEGIN OF YZ_VIEW_RULE_SEC_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE YZ_VIEW_RULE_SEC.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_VIEW_RULE_SEC_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF YZ_VIEW_RULE_SEC_TOTAL OCCURS 0010.
INCLUDE STRUCTURE YZ_VIEW_RULE_SEC.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_VIEW_RULE_SEC_TOTAL.

*.........table declarations:.................................*
TABLES: YZTABL_RULE_SEC                .
