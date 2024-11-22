*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: YZ_VIEW_CODE_DEB................................*
TABLES: YZ_VIEW_CODE_DEB, *YZ_VIEW_CODE_DEB. "view work areas
CONTROLS: TCTRL_YZ_VIEW_CODE_DEB
TYPE TABLEVIEW USING SCREEN '0001'.
DATA: BEGIN OF STATUS_YZ_VIEW_CODE_DEB. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_YZ_VIEW_CODE_DEB.
* Table for entries selected to show on screen
DATA: BEGIN OF YZ_VIEW_CODE_DEB_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE YZ_VIEW_CODE_DEB.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_VIEW_CODE_DEB_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF YZ_VIEW_CODE_DEB_TOTAL OCCURS 0010.
INCLUDE STRUCTURE YZ_VIEW_CODE_DEB.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_VIEW_CODE_DEB_TOTAL.

*.........table declarations:.................................*
TABLES: YZTABL_CODE_DEB                .
