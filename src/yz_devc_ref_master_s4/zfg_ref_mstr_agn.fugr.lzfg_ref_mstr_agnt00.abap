*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZMREF_MSTR_AGENT................................*
TABLES: ZMREF_MSTR_AGENT, *ZMREF_MSTR_AGENT. "view work areas
CONTROLS: TCTRL_ZMREF_MSTR_AGENT
TYPE TABLEVIEW USING SCREEN '0003'.
DATA: BEGIN OF STATUS_ZMREF_MSTR_AGENT. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZMREF_MSTR_AGENT.
* Table for entries selected to show on screen
DATA: BEGIN OF ZMREF_MSTR_AGENT_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZMREF_MSTR_AGENT.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZMREF_MSTR_AGENT_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZMREF_MSTR_AGENT_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZMREF_MSTR_AGENT.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZMREF_MSTR_AGENT_TOTAL.

*...processing: ZREF_MSTER_AGENT................................*
DATA:  BEGIN OF STATUS_ZREF_MSTER_AGENT              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZREF_MSTER_AGENT              .
CONTROLS: TCTRL_ZREF_MSTER_AGENT
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZREF_MSTER_AGENT              .
TABLES: ZREF_MSTER_AGENT               .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
