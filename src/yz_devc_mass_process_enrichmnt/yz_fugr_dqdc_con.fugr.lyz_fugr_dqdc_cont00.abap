*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: YZTABL_DQDC_CONF................................*
DATA:  BEGIN OF STATUS_YZTABL_DQDC_CONF              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_YZTABL_DQDC_CONF              .
CONTROLS: TCTRL_YZTABL_DQDC_CONF
            TYPE TABLEVIEW USING SCREEN '0002'.
*...processing: YZ_V_DQDC_CONF..................................*
TABLES: YZ_V_DQDC_CONF, *YZ_V_DQDC_CONF. "view work areas
CONTROLS: TCTRL_YZ_V_DQDC_CONF
TYPE TABLEVIEW USING SCREEN '0001'.
DATA: BEGIN OF STATUS_YZ_V_DQDC_CONF. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_YZ_V_DQDC_CONF.
* Table for entries selected to show on screen
DATA: BEGIN OF YZ_V_DQDC_CONF_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE YZ_V_DQDC_CONF.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_V_DQDC_CONF_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF YZ_V_DQDC_CONF_TOTAL OCCURS 0010.
INCLUDE STRUCTURE YZ_V_DQDC_CONF.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YZ_V_DQDC_CONF_TOTAL.

*.........table declarations:.................................*
TABLES: *YZTABL_DQDC_CONF              .
TABLES: YZTABL_DQDC_CONF               .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
