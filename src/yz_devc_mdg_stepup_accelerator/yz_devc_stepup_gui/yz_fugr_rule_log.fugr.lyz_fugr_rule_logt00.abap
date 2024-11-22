*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: YZ_VIEW_RULE_LOG................................*
TABLES: YZ_VIEW_RULE_LOG, *YZ_VIEW_RULE_LOG. "view work areas
CONTROLS: TCTRL_YZ_VIEW_RULE_LOG
TYPE TABLEVIEW USING SCREEN '0001'.
DATA: BEGIN OF STATUS_YZ_VIEW_RULE_LOG. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_YZ_VIEW_RULE_LOG.
* Table for entries selected to show on screen
DATA: BEGIN OF YZ_VIEW_RULE_LOG_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE YZ_VIEW_RULE_LOG.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_VIEW_RULE_LOG_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF YZ_VIEW_RULE_LOG_TOTAL OCCURS 0010.
INCLUDE STRUCTURE YZ_VIEW_RULE_LOG.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_VIEW_RULE_LOG_TOTAL.

*.........table declarations:.................................*
TABLES: YZTABL_RULE_LOG                .
