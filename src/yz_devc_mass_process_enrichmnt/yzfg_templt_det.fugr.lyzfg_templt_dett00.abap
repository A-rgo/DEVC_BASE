*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: YZTAB_TEMPLT_DET................................*
DATA:  BEGIN OF STATUS_YZTAB_TEMPLT_DET              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_YZTAB_TEMPLT_DET              .
CONTROLS: TCTRL_YZTAB_TEMPLT_DET
            TYPE TABLEVIEW USING SCREEN '0001'.
*...processing: YZ_V_TEMP_DET...................................*
TABLES: YZ_V_TEMP_DET, *YZ_V_TEMP_DET. "view work areas
CONTROLS: TCTRL_YZ_V_TEMP_DET
TYPE TABLEVIEW USING SCREEN '0002'.
DATA: BEGIN OF STATUS_YZ_V_TEMP_DET. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_YZ_V_TEMP_DET.
* Table for entries selected to show on screen
DATA: BEGIN OF YZ_V_TEMP_DET_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE YZ_V_TEMP_DET.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_V_TEMP_DET_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF YZ_V_TEMP_DET_TOTAL OCCURS 0010.
INCLUDE STRUCTURE YZ_V_TEMP_DET.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_V_TEMP_DET_TOTAL.

*.........table declarations:.................................*
TABLES: *YZTAB_TEMPLT_DET              .
TABLES: YZTAB_TEMPLT_DET               .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
