*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: YZ_VIEW_REF_DATA................................*
TABLES: YZ_VIEW_REF_DATA, *YZ_VIEW_REF_DATA. "view work areas
CONTROLS: TCTRL_YZ_VIEW_REF_DATA
TYPE TABLEVIEW USING SCREEN '0005'.
DATA: BEGIN OF STATUS_YZ_VIEW_REF_DATA. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_YZ_VIEW_REF_DATA.
* Table for entries selected to show on screen
DATA: BEGIN OF YZ_VIEW_REF_DATA_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE YZ_VIEW_REF_DATA.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_VIEW_REF_DATA_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF YZ_VIEW_REF_DATA_TOTAL OCCURS 0010.
INCLUDE STRUCTURE YZ_VIEW_REF_DATA.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_VIEW_REF_DATA_TOTAL.

*.........table declarations:.................................*
TABLES: YZTABL_REF_DATA                .
