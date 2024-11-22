*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: YZ_VIEW_DEBUG_AC................................*
TABLES: YZ_VIEW_DEBUG_AC, *YZ_VIEW_DEBUG_AC. "view work areas
CONTROLS: TCTRL_YZ_VIEW_DEBUG_AC
TYPE TABLEVIEW USING SCREEN '0001'.
DATA: BEGIN OF STATUS_YZ_VIEW_DEBUG_AC. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_YZ_VIEW_DEBUG_AC.
* Table for entries selected to show on screen
DATA: BEGIN OF YZ_VIEW_DEBUG_AC_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE YZ_VIEW_DEBUG_AC.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_VIEW_DEBUG_AC_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF YZ_VIEW_DEBUG_AC_TOTAL OCCURS 0010.
INCLUDE STRUCTURE YZ_VIEW_DEBUG_AC.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_VIEW_DEBUG_AC_TOTAL.

*.........table declarations:.................................*
TABLES: YZTABL_DEBUG_ACC               .
