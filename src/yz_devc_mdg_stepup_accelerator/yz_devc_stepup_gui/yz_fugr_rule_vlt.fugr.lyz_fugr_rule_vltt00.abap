*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: YZ_VIEW_RULE_VLT................................*
TABLES: YZ_VIEW_RULE_VLT, *YZ_VIEW_RULE_VLT. "view work areas
CONTROLS: TCTRL_YZ_VIEW_RULE_VLT
TYPE TABLEVIEW USING SCREEN '0001'.
DATA: BEGIN OF STATUS_YZ_VIEW_RULE_VLT. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_YZ_VIEW_RULE_VLT.
* Table for entries selected to show on screen
DATA: BEGIN OF YZ_VIEW_RULE_VLT_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE YZ_VIEW_RULE_VLT.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_VIEW_RULE_VLT_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF YZ_VIEW_RULE_VLT_TOTAL OCCURS 0010.
INCLUDE STRUCTURE YZ_VIEW_RULE_VLT.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_VIEW_RULE_VLT_TOTAL.

*.........table declarations:.................................*
TABLES: YZTABL_RULE_VLT                .