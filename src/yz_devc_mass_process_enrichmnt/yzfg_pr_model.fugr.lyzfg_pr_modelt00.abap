*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: YZTABLE_PR_MODEL................................*
DATA:  BEGIN OF STATUS_YZTABLE_PR_MODEL              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_YZTABLE_PR_MODEL              .
CONTROLS: TCTRL_YZTABLE_PR_MODEL
            TYPE TABLEVIEW USING SCREEN '0001'.
*...processing: YZ_V_MODEL......................................*
TABLES: YZ_V_MODEL, *YZ_V_MODEL. "view work areas
CONTROLS: TCTRL_YZ_V_MODEL
TYPE TABLEVIEW USING SCREEN '0002'.
DATA: BEGIN OF STATUS_YZ_V_MODEL. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_YZ_V_MODEL.
* Table for entries selected to show on screen
DATA: BEGIN OF YZ_V_MODEL_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE YZ_V_MODEL.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_V_MODEL_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF YZ_V_MODEL_TOTAL OCCURS 0010.
INCLUDE STRUCTURE YZ_V_MODEL.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_V_MODEL_TOTAL.

*...processing: YZ_V_RULE_MOD...................................*
TABLES: YZ_V_RULE_MOD, *YZ_V_RULE_MOD. "view work areas
CONTROLS: TCTRL_YZ_V_RULE_MOD
TYPE TABLEVIEW USING SCREEN '0004'.
DATA: BEGIN OF STATUS_YZ_V_RULE_MOD. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_YZ_V_RULE_MOD.
* Table for entries selected to show on screen
DATA: BEGIN OF YZ_V_RULE_MOD_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE YZ_V_RULE_MOD.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_V_RULE_MOD_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF YZ_V_RULE_MOD_TOTAL OCCURS 0010.
INCLUDE STRUCTURE YZ_V_RULE_MOD.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_V_RULE_MOD_TOTAL.

*.........table declarations:.................................*
TABLES: *YZTABLE_PR_MODEL              .
TABLES: YZTABLE_PR_MODEL               .
TABLES: YZTABL_RULE_MOD                .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
