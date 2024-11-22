*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZMREF_OBJ_CLASS.................................*
TABLES: ZMREF_OBJ_CLASS, *ZMREF_OBJ_CLASS. "view work areas
CONTROLS: TCTRL_ZMREF_OBJ_CLASS
TYPE TABLEVIEW USING SCREEN '0001'.
DATA: BEGIN OF STATUS_ZMREF_OBJ_CLASS. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZMREF_OBJ_CLASS.
* Table for entries selected to show on screen
DATA: BEGIN OF ZMREF_OBJ_CLASS_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZMREF_OBJ_CLASS.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZMREF_OBJ_CLASS_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZMREF_OBJ_CLASS_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZMREF_OBJ_CLASS.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZMREF_OBJ_CLASS_TOTAL.

*.........table declarations:.................................*
TABLES: ZREF_OBJ_CLASS                 .
