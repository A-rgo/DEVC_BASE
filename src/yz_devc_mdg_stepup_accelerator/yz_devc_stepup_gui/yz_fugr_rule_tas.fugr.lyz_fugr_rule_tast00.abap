*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: YZ_VIEW_RULE_TAS................................*
TABLES: YZ_VIEW_RULE_TAS, *YZ_VIEW_RULE_TAS. "view work areas
CONTROLS: TCTRL_YZ_VIEW_RULE_TAS
TYPE TABLEVIEW USING SCREEN '0001'.
DATA: BEGIN OF STATUS_YZ_VIEW_RULE_TAS. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_YZ_VIEW_RULE_TAS.
* Table for entries selected to show on screen
DATA: BEGIN OF YZ_VIEW_RULE_TAS_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE YZ_VIEW_RULE_TAS.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_VIEW_RULE_TAS_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF YZ_VIEW_RULE_TAS_TOTAL OCCURS 0010.
INCLUDE STRUCTURE YZ_VIEW_RULE_TAS.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_VIEW_RULE_TAS_TOTAL.

*.........table declarations:.................................*
TABLES: YZTABL_RULE_TAS                .
