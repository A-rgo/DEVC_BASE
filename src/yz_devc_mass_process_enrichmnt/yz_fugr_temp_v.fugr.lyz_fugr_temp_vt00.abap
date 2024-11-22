*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: YZ_V_TEMPL_VIEW.................................*
TABLES: YZ_V_TEMPL_VIEW, *YZ_V_TEMPL_VIEW. "view work areas
CONTROLS: TCTRL_YZ_V_TEMPL_VIEW
TYPE TABLEVIEW USING SCREEN '0001'.
DATA: BEGIN OF STATUS_YZ_V_TEMPL_VIEW. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_YZ_V_TEMPL_VIEW.
* Table for entries selected to show on screen
DATA: BEGIN OF YZ_V_TEMPL_VIEW_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE YZ_V_TEMPL_VIEW.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_V_TEMPL_VIEW_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF YZ_V_TEMPL_VIEW_TOTAL OCCURS 0010.
INCLUDE STRUCTURE YZ_V_TEMPL_VIEW.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_V_TEMPL_VIEW_TOTAL.

*.........table declarations:.................................*
TABLES: YZTABL_TEMP_VIEW               .
