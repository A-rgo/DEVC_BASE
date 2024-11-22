interface YZ_INTF_MDG_0G_DATA_TYPES
  public .


  types:
    gty_t_accccdet TYPE SORTED TABLE OF /mdg/_s_0g_pp_accccdet WITH UNIQUE KEY coa account compcode .
  types:
    gty_t_account TYPE SORTED TABLE OF /mdg/_s_0g_pp_account WITH UNIQUE KEY coa account .
  types:
    gty_t_bdc TYPE SORTED TABLE OF /mdg/_s_0g_pp_bdc WITH UNIQUE KEY coa bdc .
  types:
    gty_t_bdcset TYPE SORTED TABLE OF /mdg/_s_0g_pp_bdcset WITH UNIQUE KEY bdcset .
  types:
    gty_t_cctr TYPE SORTED TABLE OF /mdg/_s_0g_pp_cctr WITH UNIQUE KEY coarea cctr .
  types:
    gty_t_cctrg TYPE SORTED TABLE OF /mdg/_s_0g_pp_cctrg WITH UNIQUE KEY cctrg coarea .
  types:
    gty_t_cctrh TYPE SORTED TABLE OF /mdg/_s_0g_pp_cctrh WITH UNIQUE KEY cctrh coarea .
  types:
    gty_t_celem TYPE SORTED TABLE OF /mdg/_s_0g_pp_celem WITH UNIQUE KEY celem coarea .
  types:
    gty_t_celemg TYPE SORTED TABLE OF /mdg/_s_0g_pp_celemg WITH UNIQUE KEY celemg coarea .
  types:
    gty_t_celemh TYPE SORTED TABLE OF /mdg/_s_0g_pp_celemh WITH UNIQUE KEY celemh coarea .
  types:
    gty_t_company TYPE SORTED TABLE OF /mdg/_s_0g_pp_company WITH UNIQUE KEY company .
  types:
    gty_t_conschar TYPE SORTED TABLE OF /mdg/_s_0g_pp_conschar WITH UNIQUE KEY conschar .
  types:
    gty_t_consgrp TYPE SORTED TABLE OF /mdg/_s_0g_pp_consgrp WITH UNIQUE KEY conschar consgrp .
  types:
    gty_t_consgrph TYPE SORTED TABLE OF /mdg/_s_0g_pp_consgrph WITH UNIQUE KEY  conschar consgrph .
  types:
    gty_t_consunit TYPE SORTED TABLE OF /mdg/_s_0g_pp_consunit WITH UNIQUE KEY conschar consunit .
  types:
    gty_t_frs TYPE SORTED TABLE OF /mdg/_s_0g_pp_frs WITH UNIQUE KEY frs coa .
  types:
    gty_t_frsi TYPE SORTED TABLE OF /mdg/_s_0g_pp_frsi WITH UNIQUE KEY coa frs frsi .
  types:
    gty_t_fsi TYPE SORTED TABLE OF /mdg/_s_0g_pp_fsi WITH UNIQUE KEY coa fsi .
  types:
    gty_t_fsih TYPE SORTED TABLE OF /mdg/_s_0g_pp_fsih WITH UNIQUE KEY coa fsih .
  types:
    gty_t_fsit TYPE SORTED TABLE OF /mdg/_s_0g_pp_fsit WITH UNIQUE KEY coa fsih fsit .
  types:
    gty_t_iorder TYPE SORTED TABLE OF /mdg/_s_0g_pp_iorder WITH UNIQUE KEY iorder .
  types:
    gty_t_pctr TYPE SORTED TABLE OF /mdg/_s_0g_pp_pctr WITH UNIQUE KEY coarea pctr .
  types:
    gty_t_pctrg TYPE SORTED TABLE OF /mdg/_s_0g_pp_pctrg WITH UNIQUE KEY coarea pctrg .
  types:
    gty_t_pctrh TYPE SORTED TABLE OF /mdg/_s_0g_pp_pctrh WITH UNIQUE KEY coarea pctrh .
  types:
    gty_t_submpack TYPE SORTED TABLE OF /mdg/_s_0g_pp_submpack WITH UNIQUE KEY submpack .
  types:
    gty_t_transtype TYPE SORTED TABLE OF /mdg/_s_0g_pp_transtype WITH UNIQUE KEY transtype .
  types:
    gty_t_accccaudt TYPE SORTED TABLE OF /mdg/_s_0g_pp_accccaudt WITH UNIQUE KEY coa account compcode bussystem cltkey .
  types:
    gty_t_accntaudt TYPE SORTED TABLE OF /mdg/_s_0g_pp_accntaudt WITH UNIQUE KEY coa account bussystem cltkey .
  types:
    gty_t_bdcsubsel TYPE SORTED TABLE OF /mdg/_s_0g_pp_bdcsubsel WITH UNIQUE KEY bdc coa subassign .
  types:
    gty_t_cctraudit TYPE SORTED TABLE OF /mdg/_s_0g_pp_cctraudit WITH UNIQUE KEY bussystem coarea cctr cltkey .
  types:
    gty_t_celemaudt TYPE SORTED TABLE OF /mdg/_s_0g_pp_celemaudt WITH UNIQUE KEY bussystem coarea celem cltkey .
  types:
    gty_t_cggcurr TYPE SORTED TABLE OF /mdg/_s_0g_pp_cggcurr WITH UNIQUE KEY conschar consgrp grpcurr .
  types:
    gty_t_cuvers TYPE SORTED TABLE OF /mdg/_s_0g_pp_cuvers WITH UNIQUE KEY conschar consunit valvers .
  types:
    gty_t_frsitxt TYPE SORTED TABLE OF /mdg/_s_0g_pp_frsitxt WITH UNIQUE KEY coa frs frsi language .
  types:
    gty_t_fsiaudit TYPE SORTED TABLE OF /mdg/_s_0g_pp_fsiaudit WITH UNIQUE KEY fsi coa bussystem cltkey .
  types:
    gty_t_fsivers TYPE SORTED TABLE OF /mdg/_s_0g_pp_fsivers WITH UNIQUE KEY coa fsi valvers .
  types:
    gty_t_iordaudt TYPE SORTED TABLE OF /mdg/_s_0g_pp_iordaudt WITH UNIQUE KEY bussystem cltkey iorder .
  types:
    gty_t_pcccass TYPE SORTED TABLE OF /mdg/_s_0g_pp_pcccass WITH UNIQUE KEY compcode coarea pctr .
  types:
    gty_t_pctraudit TYPE SORTED TABLE OF /mdg/_s_0g_pp_pctraudit WITH UNIQUE KEY bussystem cltkey coarea pctr .
endinterface.
