*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZMREF_REQ_METDTA................................*
TABLES: ZMREF_REQ_METDTA, *ZMREF_REQ_METDTA. "view work areas
CONTROLS: TCTRL_ZMREF_REQ_METDTA
TYPE TABLEVIEW USING SCREEN '0002'.
DATA: BEGIN OF STATUS_ZMREF_REQ_METDTA. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZMREF_REQ_METDTA.
* Table for entries selected to show on screen
DATA: BEGIN OF ZMREF_REQ_METDTA_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZMREF_REQ_METDTA.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZMREF_REQ_METDTA_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZMREF_REQ_METDTA_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZMREF_REQ_METDTA.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZMREF_REQ_METDTA_TOTAL.

*.........table declarations:.................................*
TABLES: ZREF_REQ_METDATA               .
