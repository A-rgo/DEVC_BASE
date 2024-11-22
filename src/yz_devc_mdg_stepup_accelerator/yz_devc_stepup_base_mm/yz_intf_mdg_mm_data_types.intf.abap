interface YZ_INTF_MDG_MM_DATA_TYPES
  public .


  types:
    BEGIN OF gty_s_mm_where,
      mm    TYPE matnr,
      where TYPE comt_clear_string,
    END OF gty_s_mm_where .
  types:
    gty_t_mm_where TYPE SORTED TABLE OF gty_s_mm_where WITH NON-UNIQUE KEY mm .
  types:
    BEGIN OF gty_s_mm_message.
  TYPES         material TYPE matnr.
  INCLUDE TYPE usmd_s_message.
  TYPES         END OF gty_s_mm_message .
  types:
    gty_t_mm_message TYPE STANDARD TABLE OF gty_s_mm_message .
  types:
    BEGIN OF gs_mmtxt,
      material TYPE matnr,
      langu    TYPE sprast,
      txtmi    TYPE string,
    END OF gs_mmtxt .
  types:
    gty_t_mmtxt TYPE SORTED TABLE OF gs_mmtxt WITH UNIQUE KEY material langu .
  types:
    gty_t_material TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_material WITH UNIQUE KEY material .
  types:
    gty_t_classasgn TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_classasgn WITH UNIQUE KEY material changeno class classtype ecocntr guid .
  types:
    gty_t_dradtxt TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_dradtxt WITH UNIQUE KEY dokar doknr doktl dokvr material langucode .
  types:
    gty_t_bscdattxt TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_bscdattxt WITH UNIQUE KEY material langucode .
  types:
    gty_t_intcmnt TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_intcmnt WITH UNIQUE KEY material langucode .
  types:
    gty_t_marapurch TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_marapurch WITH UNIQUE KEY material .
  types:
    gty_t_maraqtmng TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_maraqtmng WITH UNIQUE KEY material .
  types:
    gty_t_marasales TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_marasales WITH UNIQUE KEY material .
  types:
    gty_t_maraspm TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_maraspm WITH UNIQUE KEY material .
  types:
    gty_t_marastor TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_marastor WITH UNIQUE KEY material .
  types:
    gty_t_marcatp TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_marcatp WITH UNIQUE KEY material werks .
  types:
    gty_t_marcbasic TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_marcbasic WITH UNIQUE KEY material werks .
  types:
    gty_t_marccstng TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_marccstng WITH UNIQUE KEY material werks .
  types:
    gty_t_marcfrcst TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_marcfrcst WITH UNIQUE KEY material werks .
  types:
    gty_t_marcfrgtr TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_marcfrgtr WITH UNIQUE KEY material werks .
  types:
    gty_t_marcfrpar TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_marcfrpar WITH UNIQUE KEY material werks .
  types:
    gty_t_marcmrpfc TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_marcmrpfc WITH UNIQUE KEY material werks .
  types:
    gty_t_marcmrpls TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_marcmrpls WITH UNIQUE KEY material werks .
  types:
    gty_t_marcmrpmi TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_marcmrpmi WITH UNIQUE KEY material werks .
  types:
    gty_t_marcmrppp TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_marcmrppp WITH UNIQUE KEY material werks .
  types:
    gty_t_marcmrpsp TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_marcmrpsp WITH UNIQUE KEY material werks .
  types:
    gty_t_marcprt TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_marcprt WITH UNIQUE KEY material werks .
  types:
    gty_t_marcpurch TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_marcpurch WITH UNIQUE KEY material werks .
  types:
    gty_t_marcqtmng TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_marcqtmng WITH UNIQUE KEY material werks .
  types:
    gty_t_marcsales TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_marcsales WITH UNIQUE KEY material werks .
  types:
    gty_t_marcstore TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_marcstore WITH UNIQUE KEY material werks .
  types:
    gty_t_marcwrksd TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_marcwrksd WITH UNIQUE KEY material werks .
  types:
    gty_t_mardmrp TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_mardmrp WITH UNIQUE KEY material werks lgort .
  types:
    gty_t_mardstor TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_mardstor WITH UNIQUE KEY material werks lgort .
  types:
    gty_t_mbewactng TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_mbewactng WITH UNIQUE KEY material bwkey bwtar .
  types:
    gty_t_mbewcstng TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_mbewcstng WITH UNIQUE KEY material bwkey .
  types:
    gty_t_mbewmlac TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_mbewmlac WITH UNIQUE KEY material bwkey bwtar curtp .
  types:
    gty_t_mbewmlval TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_mbewmlval WITH UNIQUE KEY material bwkey bwtar curtp .
  types:
    gty_t_mbewvalua TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_mbewvalua WITH UNIQUE KEY material bwkey bwtar .
  types:
    gty_t_mdmabasic TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_mdmabasic WITH UNIQUE KEY material werks berid .
  types:
    gty_t_mean_gtin TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_mean_gtin WITH UNIQUE KEY material ean qteunit .
  types:
    gty_t_mlanpurch TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_mlanpurch WITH UNIQUE KEY material aland .
  types:
    gty_t_mlansales TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_mlansales WITH UNIQUE KEY material aland tatyp .
  types:
    gty_t_mlgnstor TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_mlgnstor WITH UNIQUE KEY material lgnum .
  types:
    gty_t_mlgtstor TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_mlgtstor WITH UNIQUE KEY material lgnum lgtyp .
  types:
    gty_t_mpgdprodg TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_mpgdprodg WITH UNIQUE KEY material werks .
  types:
    gty_t_mrptxt TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_mrptxt WITH UNIQUE KEY material werks .
  types:
    gty_t_mvkegrpng TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_mvkegrpng WITH UNIQUE KEY material vkorg vtweg .
  types:
    gty_t_mvkesales TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_mvkesales WITH UNIQUE KEY material vkorg vtweg .
  types:
    gty_t_purchtxt TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_purchtxt WITH UNIQUE KEY material langucode .
  types:
    gty_t_qinsptxt TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_qinsptxt WITH UNIQUE KEY material langucode .
  types:
    gty_t_qmatbasic TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_qmatbasic WITH UNIQUE KEY material werks art .
  types:
    gty_t_salestxt TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_salestxt WITH UNIQUE KEY material langucode vkorg vtweg .
  types:
    gty_t_unitofmsr TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_unitofmsr WITH UNIQUE KEY material qteunit .
  types:
    gty_t_valuation TYPE SORTED TABLE OF /mdgmm/_s_mm_pp_valuation WITH UNIQUE KEY material changeno charid classtype ecocntr guid valcnt .
endinterface.
