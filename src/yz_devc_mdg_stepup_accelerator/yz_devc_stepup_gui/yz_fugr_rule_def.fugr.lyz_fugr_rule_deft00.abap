*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: YZ_VIEW_RULE_DEF................................*
TABLES: YZ_VIEW_RULE_DEF, *YZ_VIEW_RULE_DEF. "view work areas
CONTROLS: TCTRL_YZ_VIEW_RULE_DEF
TYPE TABLEVIEW USING SCREEN '0002'.
DATA: BEGIN OF STATUS_YZ_VIEW_RULE_DEF. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_YZ_VIEW_RULE_DEF.
* Table for entries selected to show on screen
DATA: BEGIN OF YZ_VIEW_RULE_DEF_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE YZ_VIEW_RULE_DEF.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_VIEW_RULE_DEF_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF YZ_VIEW_RULE_DEF_TOTAL OCCURS 0010.
INCLUDE STRUCTURE YZ_VIEW_RULE_DEF.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_VIEW_RULE_DEF_TOTAL.

*.........table declarations:.................................*
TABLES: YZTABL_RULE_DEF                .
