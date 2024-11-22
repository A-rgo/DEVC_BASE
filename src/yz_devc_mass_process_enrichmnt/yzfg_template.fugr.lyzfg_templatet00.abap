*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: YZTABLE_TEMPLATE................................*
DATA:  BEGIN OF STATUS_YZTABLE_TEMPLATE              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_YZTABLE_TEMPLATE              .
CONTROLS: TCTRL_YZTABLE_TEMPLATE
            TYPE TABLEVIEW USING SCREEN '0001'.
*...processing: YZ_V_TEMPLATE...................................*
TABLES: YZ_V_TEMPLATE, *YZ_V_TEMPLATE. "view work areas
CONTROLS: TCTRL_YZ_V_TEMPLATE
TYPE TABLEVIEW USING SCREEN '0002'.
DATA: BEGIN OF STATUS_YZ_V_TEMPLATE. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_YZ_V_TEMPLATE.
* Table for entries selected to show on screen
DATA: BEGIN OF YZ_V_TEMPLATE_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE YZ_V_TEMPLATE.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_V_TEMPLATE_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF YZ_V_TEMPLATE_TOTAL OCCURS 0010.
INCLUDE STRUCTURE YZ_V_TEMPLATE.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_V_TEMPLATE_TOTAL.

*.........table declarations:.................................*
TABLES: *YZTABLE_TEMPLATE              .
TABLES: YZTABLE_TEMPLATE               .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
