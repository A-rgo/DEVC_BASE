*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: YZ_VIEW_RULE_TMP................................*
TABLES: YZ_VIEW_RULE_TMP, *YZ_VIEW_RULE_TMP. "view work areas
CONTROLS: TCTRL_YZ_VIEW_RULE_TMP
TYPE TABLEVIEW USING SCREEN '0001'.
DATA: BEGIN OF STATUS_YZ_VIEW_RULE_TMP. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_YZ_VIEW_RULE_TMP.
* Table for entries selected to show on screen
DATA: BEGIN OF YZ_VIEW_RULE_TMP_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE YZ_VIEW_RULE_TMP.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_VIEW_RULE_TMP_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF YZ_VIEW_RULE_TMP_TOTAL OCCURS 0010.
INCLUDE STRUCTURE YZ_VIEW_RULE_TMP.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_VIEW_RULE_TMP_TOTAL.

*.........table declarations:.................................*
TABLES: YZTABL_RULE_TMP                .
