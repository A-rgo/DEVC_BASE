*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: YZ_VIEW_TEMP_ITM................................*
TABLES: YZ_VIEW_TEMP_ITM, *YZ_VIEW_TEMP_ITM. "view work areas
CONTROLS: TCTRL_YZ_VIEW_TEMP_ITM
TYPE TABLEVIEW USING SCREEN '0001'.
DATA: BEGIN OF STATUS_YZ_VIEW_TEMP_ITM. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_YZ_VIEW_TEMP_ITM.
* Table for entries selected to show on screen
DATA: BEGIN OF YZ_VIEW_TEMP_ITM_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE YZ_VIEW_TEMP_ITM.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_VIEW_TEMP_ITM_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF YZ_VIEW_TEMP_ITM_TOTAL OCCURS 0010.
INCLUDE STRUCTURE YZ_VIEW_TEMP_ITM.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_VIEW_TEMP_ITM_TOTAL.

*.........table declarations:.................................*
TABLES: YZTABL_RULE_SEC                .
TABLES: YZTABL_RULE_TMP                .
TABLES: YZTABL_RULE_TYP                .
TABLES: YZTABL_TEMP_ITM                .
