interface YZ_INTF_MDG_BP_DATA_TYPES
  public .


  types:
    gty_t_address   TYPE SORTED TABLE OF  /mdgbp/_s_bp_pp_address WITH UNIQUE KEY bp_header addrno .
  types:
    gty_t_ad_email  TYPE SORTED TABLE OF  /mdgbp/_s_bp_pp_ad_email  WITH UNIQUE KEY bp_header addrno ad_consno .
  types:
    gty_t_ad_fax    TYPE SORTED TABLE OF  /mdgbp/_s_bp_pp_ad_fax  WITH UNIQUE KEY bp_header addrno ad_consno .
  types:
    gty_t_ad_name_o TYPE SORTED TABLE OF  /mdgbp/_s_bp_pp_ad_name_o WITH UNIQUE KEY bp_header addrno ad_nation .
  types:
    gty_t_ad_name_p TYPE SORTED TABLE OF  /mdgbp/_s_bp_pp_ad_name_p WITH UNIQUE KEY bp_header addrno ad_nation .
  types:
    gty_t_ad_postal TYPE SORTED TABLE OF  /mdgbp/_s_bp_pp_ad_postal WITH UNIQUE KEY bp_header addrno ad_nation .
  types:
    gty_t_ad_tel    TYPE SORTED TABLE OF  /mdgbp/_s_bp_pp_ad_tel  WITH UNIQUE KEY bp_header addrno ad_consno .
  types:
    gty_t_ad_url    TYPE SORTED TABLE OF  /mdgbp/_s_bp_pp_ad_url  WITH UNIQUE KEY bp_header addrno ad_consno .
  types:
    gty_t_bp_addr   TYPE SORTED TABLE OF  /mdgbp/_s_bp_pp_bp_addr WITH UNIQUE KEY bp_header addrno .
  types:
    gty_t_bp_addusg TYPE SORTED TABLE OF  /mdgbp/_s_bp_pp_bp_addusg WITH UNIQUE KEY addrno bp_header bp_adrknd .
  types:
    gty_t_bp_bkdtl  TYPE SORTED TABLE OF  /mdgbp/_s_bp_pp_bp_bkdtl  WITH UNIQUE KEY bp_header bank_id .
  types:
    gty_t_bp_ccdtl  TYPE SORTED TABLE OF  /mdgbp/_s_bp_pp_bp_ccdtl  WITH UNIQUE KEY bp_header card_id .
  types:
    gty_t_bp_centrl TYPE SORTED TABLE OF  /mdgbp/_s_bp_pp_bp_centrl WITH UNIQUE KEY bp_header .
  types:
    gty_t_bp_compny TYPE SORTED TABLE OF  /mdgbpx/_s_bp_pp_bp_compny WITH UNIQUE KEY assgnm_id bp_header company .
  types:
    gty_t_bp_cuscla TYPE SORTED TABLE OF  /mdgbpx/_s_bp_pp_bp_cuscla WITH UNIQUE KEY assgnm_id bp_header class classtype ecocntr .
  types:
    gty_t_bp_cusddb TYPE SORTED TABLE OF  /mdgbpx/_s_bp_pp_bp_cusddb WITH UNIQUE KEY assgnm_id bp_header cus_dokar cus_doknr cus_doktl cus_dokvr .
  types:
    gty_t_bp_cusdun TYPE SORTED TABLE OF  /mdgbpx/_s_bp_pp_bp_cusdun WITH UNIQUE KEY assgnm_id bp_header company maber .
  types:
    gty_t_bp_cusfcn TYPE SORTED TABLE OF  /mdgbpx/_s_bp_pp_bp_cusfcn WITH UNIQUE KEY assgnm_id bp_header spart vkorg vtweg parvw parza .
  types:
    gty_t_bp_cusgen TYPE SORTED TABLE OF  /mdgbpx/_s_bp_pp_bp_cusgen WITH UNIQUE KEY assgnm_id bp_header .
  types:
    gty_t_bp_custax TYPE SORTED TABLE OF  /mdgbpx/_s_bp_pp_bp_custax WITH UNIQUE KEY assgnm_id bp_header aland tatyp .
  types:
    gty_t_bp_cusulp TYPE SORTED TABLE OF  /mdgbpx/_s_bp_pp_bp_cusulp WITH UNIQUE KEY assgnm_id bp_header ablad .
  types:
    gty_t_bp_cusval TYPE SORTED TABLE OF  /mdgbpx/_s_bp_pp_bp_cusval WITH UNIQUE KEY assgnm_id bp_header charid classtype ecocntr valcnt .
  types:
    gty_t_bp_cuswht TYPE SORTED TABLE OF  /mdgbpx/_s_bp_pp_bp_cuswht WITH UNIQUE KEY assgnm_id bp_header company witht .
  types:
    gty_t_bp_cus_cc TYPE SORTED TABLE OF  /mdgbpx/_s_bp_pp_bp_cus_cc WITH UNIQUE KEY assgnm_id bp_header company .
  types:
    gty_t_bp_dunn   TYPE SORTED TABLE OF  /mdgbpx/_s_bp_pp_bp_dunn WITH UNIQUE KEY assgnm_id bp_header company maber .
  types:
    gty_t_bp_header TYPE SORTED TABLE OF  /mdgbp/_s_bp_pp_bp_header WITH UNIQUE KEY bp_header .
  types:
    gty_t_bp_idnum  TYPE SORTED TABLE OF  /mdgbp/_s_bp_pp_bp_idnum  WITH UNIQUE KEY bp_header bp_idtype bp_id_num .
  types:
    gty_t_bp_indstr TYPE SORTED TABLE OF  /mdgbp/_s_bp_pp_bp_indstr WITH UNIQUE KEY bp_header bp_indsct bp_indsys .
  types:
    gty_t_bp_mlt_ad TYPE SORTED TABLE OF  /mdgbpx/_s_bp_pp_bp_mlt_ad WITH UNIQUE KEY assgnm_id bp_header addrno .
  types:
    gty_t_bp_mlt_as TYPE SORTED TABLE OF  /mdgbpx/_s_bp_pp_bp_mlt_as WITH UNIQUE KEY bp_header assgnm_id .
  types:
    gty_t_bp_porg   TYPE SORTED TABLE OF  /mdgbpx/_s_bp_pp_bp_porg WITH UNIQUE KEY assgnm_id bp_header prch_org .
  types:
    gty_t_bp_porg2  TYPE SORTED TABLE OF  /mdgbpx/_s_bp_pp_bp_porg2  WITH UNIQUE KEY assgnm_id bp_header prch_org ltsnr werks_d .
  types:
    gty_t_bp_role   TYPE SORTED TABLE OF  /mdgbp/_s_bp_pp_bp_role WITH UNIQUE KEY bp_header bp_rol_id .
  types:
    gty_t_bp_sales  TYPE SORTED TABLE OF  /mdgbpx/_s_bp_pp_bp_sales  WITH UNIQUE KEY assgnm_id bp_header spart vkorg vtweg .
  types:
    gty_t_bp_taxgrp TYPE SORTED TABLE OF  /mdgbpx/_s_bp_pp_bp_taxgrp WITH UNIQUE KEY assgnm_id bp_header koart taxgr .
  types:
    gty_t_bp_taxnum TYPE SORTED TABLE OF  /mdgbp/_s_bp_pp_bp_taxnum WITH UNIQUE KEY bp_header bp_tx_typ .
  types:
    gty_t_bp_vencla TYPE SORTED TABLE OF  /mdgbpx/_s_bp_pp_bp_vencla WITH UNIQUE KEY assgnm_id bp_header class classtype ecocntr .
  types:
    gty_t_bp_venddb TYPE SORTED TABLE OF  /mdgbpx/_s_bp_pp_bp_venddb WITH UNIQUE KEY assgnm_id bp_header ven_dokar ven_doknr ven_doktl ven_dokvr .
  types:
    gty_t_bp_venfcn TYPE SORTED TABLE OF  /mdgbpx/_s_bp_pp_bp_venfcn WITH UNIQUE KEY assgnm_id bp_header prch_org ltsnr parvw parza werks_d .
  types:
    gty_t_bp_vengen TYPE SORTED TABLE OF  /mdgbpx/_s_bp_pp_bp_vengen WITH UNIQUE KEY assgnm_id bp_header .
  types:
    gty_t_bp_vensub TYPE SORTED TABLE OF  /mdgbpx/_s_bp_pp_bp_vensub WITH UNIQUE KEY assgnm_id bp_header ltsnr ven_langu .
  types:
    gty_t_bp_venval TYPE SORTED TABLE OF  /mdgbpx/_s_bp_pp_bp_venval WITH UNIQUE KEY assgnm_id bp_header charid classtype ecocntr valcnt .
  types:
    gty_t_bp_whtax  TYPE SORTED TABLE OF  /mdgbpx/_s_bp_pp_bp_whtax  WITH UNIQUE KEY assgnm_id bp_header company land_1 witht .
  types:
    gty_t_cuscctxt  TYPE SORTED TABLE OF  mdg_bs_cust_cuscctxt  WITH UNIQUE KEY assgnm_id bp_header company cuslangu cus_tdid .
  types:
    gty_t_cusgentxt TYPE SORTED TABLE OF  mdg_bs_cust_cusgentxt WITH UNIQUE KEY assgnm_id bp_header cuslangu cus_tdid .
  types:
    gty_t_cussaltxt TYPE SORTED TABLE OF  mdg_bs_cust_cussaltxt  WITH UNIQUE KEY assgnm_id bp_header spart vkorg vtweg cuslangu cus_tdid .
  types:
    gty_t_vencctxt  TYPE SORTED TABLE OF  mdg_bs_suppl_vencctxt  WITH UNIQUE KEY assgnm_id bp_header company venlangu ven_tdid .
  types:
    gty_t_vengentxt TYPE SORTED TABLE OF  mdg_bs_suppl_vengentxt WITH UNIQUE KEY assgnm_id bp_header venlangu ven_tdid .
  types:
    gty_t_venpotxt  TYPE SORTED TABLE OF  mdg_bs_suppl_venpotxt  WITH UNIQUE KEY assgnm_id bp_header prch_org venlangu ven_tdid .
  types:
    gty_t_addrno    TYPE SORTED TABLE OF mdg_bs_addrno WITH UNIQUE KEY addrno .
  types:
    gty_t_bp_hrchy  TYPE SORTED TABLE OF /mdgbp/_s_bp_pp_bp_hrchy WITH UNIQUE KEY bp_hrchy .
  types:
    gty_t_bp_rel    TYPE SORTED TABLE OF /mdgbp/_s_bp_pp_bp_rel WITH UNIQUE KEY bp_rel partner1 partner2 .
  types:
    gty_t_bp_cpgen  TYPE SORTED TABLE OF /mdgbp/_s_bp_pp_bp_cpgen WITH UNIQUE KEY bp_rel partner1 partner2 .
  types:
    gty_t_bp_wpad   TYPE SORTED TABLE OF /mdgbp/_s_bp_pp_bp_wpad WITH UNIQUE KEY bp_rel addrno partner1 partner2 .
  types:
    gty_t_wp_url    TYPE SORTED TABLE OF /mdgbp/_s_bp_pp_wp_url WITH UNIQUE KEY addrno bp_rel ad_consno partner1 partner2 .
  types:
    gty_t_wp_tel    TYPE SORTED TABLE OF /mdgbp/_s_bp_pp_wp_tel WITH UNIQUE KEY addrno bp_rel ad_consno partner1 partner2 .
  types:
    gty_t_wp_postal TYPE SORTED TABLE OF /mdgbp/_s_bp_pp_wp_postal WITH UNIQUE KEY addrno bp_rel ad_nation partner1 partner2 .
  types:
    gty_t_wp_fax    TYPE SORTED TABLE OF /mdgbp/_s_bp_pp_wp_fax WITH UNIQUE KEY addrno bp_rel ad_consno partner1 partner2 .
  types:
    gty_t_wp_email  TYPE SORTED TABLE OF /mdgbp/_s_bp_pp_wp_email WITH UNIQUE KEY addrno bp_rel ad_consno partner1 partner2 .
  types:
    gty_t_bp_subhry TYPE SORTED TABLE OF /mdgbp/_s_bp_pp_bp_subhry WITH UNIQUE KEY bp_subhry .
  types:
    gty_t_fkkvk     TYPE SORTED TABLE OF /mdgbpx/_s_bp_pp_fkkvk WITH UNIQUE KEY fkkvk .
  types:
    gty_t_fkkvktd   TYPE SORTED TABLE OF /mdgbpx/_s_bp_pp_fkkvktd WITH UNIQUE KEY fkkvk fkk_valdt .
  types:
    gty_t_fkkvkp    TYPE SORTED TABLE OF /mdgbpx/_s_bp_pp_fkkvkp WITH UNIQUE KEY fkkvk fkk_valdt bp_header .
  types:
    gty_t_fkkvkcorr TYPE SORTED TABLE OF /mdgbpx/_s_bp_pp_fkkvkcorr WITH UNIQUE KEY bp_header fkkvk fkk_valdt fkk_ident .
  types:
    gty_t_fkktxt    TYPE SORTED TABLE OF /mdgbpx/_s_bp_pp_fkktxt WITH UNIQUE KEY bp_header fkkvk fkk_valdt fkk_langu fkk_tdid .
  types:
    gty_t_fkklocks  TYPE SORTED TABLE OF /mdgbpx/_s_bp_pp_fkklocks WITH UNIQUE KEY bp_header fkkvk fkk_valdt fkk_fdate fkk_lockr fkk_proid fkk_tdate .
  types:
    gty_t_fkktaxex  TYPE SORTED TABLE OF /mdgbpx/_s_bp_pp_fkktaxex WITH UNIQUE KEY fkkvk fkk_exdfr fkk_kschl fkk_mwskz .
  types:
  """Start of change DDMK902946 ""
    gty_t_bp_adddep TYPE SORTED TABLE OF  /mdgbp/_s_bp_pp_bp_adddep WITH UNIQUE KEY addrno bp_header .
  types:
    gty_t_bp_cgenad TYPE SORTED TABLE OF  /mdgbpx/_s_bp_pp_bp_cgenad WITH UNIQUE KEY assgnm_id bp_header addrno .
  types:
    gty_t_bp_cm_bp TYPE SORTED TABLE OF  /mdgbpx/_s_bp_pp_bp_cm_bp WITH UNIQUE KEY bp_header .
  types:
    gty_t_bp_csalad TYPE SORTED TABLE OF  /mdgbpx/_s_bp_pp_bp_csalad WITH UNIQUE KEY assgnm_id bp_header vtweg vkorg spart addrno .
  types:
    gty_t_bp_ctaxad TYPE SORTED TABLE OF  /mdgbpx/_s_bp_pp_bp_ctaxad WITH UNIQUE KEY assgnm_id bp_header tatyp aland addrno .
  types:
    gty_t_bp_culpad TYPE SORTED TABLE OF  /mdgbpx/_s_bp_pp_bp_culpad WITH UNIQUE KEY assgnm_id bp_header ablad addrno .
  types:
    gty_t_bp_email TYPE SORTED TABLE OF  /mdgbp/_s_bp_pp_bp_email WITH UNIQUE KEY bp_header ad_consno .
  types:
    gty_t_bp_fax TYPE SORTED TABLE OF  /mdgbp/_s_bp_pp_bp_fax WITH UNIQUE KEY bp_header ad_consno .
  types:
    gty_t_bp_tax_ad TYPE SORTED TABLE OF  /mdgbp/_s_bp_pp_bp_tax_ad WITH UNIQUE KEY bp_header bp_tx_typ addrno .
  types:
    gty_t_bp_tel TYPE SORTED TABLE OF  /mdgbp/_s_bp_pp_bp_tel WITH UNIQUE KEY bp_header ad_consno .
  types:
    gty_t_bp_url TYPE SORTED TABLE OF  /mdgbp/_s_bp_pp_bp_url WITH UNIQUE KEY bp_header ad_consno .
  types:
    gty_t_fs_bkk21 TYPE SORTED TABLE OF  /mdgbp/_s_bp_pp_fs_bkk21 WITH UNIQUE KEY bp_header fs_alpsnr .
  types:
    gty_t_fs_bp001 TYPE SORTED TABLE OF  /mdgbp/_s_bp_pp_fs_bp001 WITH UNIQUE KEY bp_header .
  types:
    gty_t_fs_bp011 TYPE SORTED TABLE OF  /mdgbp/_s_bp_pp_fs_bp011 WITH UNIQUE KEY bp_header fs_empl_s .
  types:
    gty_t_fs_bp021 TYPE SORTED TABLE OF  /mdgbp/_s_bp_pp_fs_bp021 WITH UNIQUE KEY bp_header fs_busn_y .
  types:
    gty_t_fs_bp1010 TYPE SORTED TABLE OF  /mdgbp/_s_bp_pp_fs_bp1010 WITH UNIQUE KEY bp_header .
  types:
    gty_t_fs_bp1012 TYPE SORTED TABLE OF  /mdgbp/_s_bp_pp_fs_bp1012 WITH UNIQUE KEY bp_header fs_dateto fs_grdmth .
  types:
    gty_t_fs_bp1030 TYPE SORTED TABLE OF  /mdgbp/_s_bp_pp_fs_bp1030 WITH UNIQUE KEY bp_header .
  types:
    gty_t_fs_bpbank TYPE SORTED TABLE OF  /mdgbp/_s_bp_pp_fs_bpbank WITH UNIQUE KEY bp_header .
  types:
    gty_t_fs_bptaxc TYPE SORTED TABLE OF  /mdgbp/_s_bp_pp_fs_bptaxc WITH UNIQUE KEY bp_header fs_tax_id .
  types:
  """END of change DDMK902946 ""
    BEGIN OF gty_s_bp_where,
      bp    TYPE bu_partner,
      where TYPE comt_clear_string,
    END OF gty_s_bp_where .
  types:
    gty_t_bp_where TYPE SORTED TABLE OF gty_s_bp_where WITH NON-UNIQUE KEY bp .
  types:
    BEGIN OF gty_s_bp_message.
  TYPES         partner TYPE bu_partner.
  INCLUDE TYPE usmd_s_message.
  TYPES         END OF gty_s_bp_message .
  types:
    gty_t_bp_message TYPE STANDARD TABLE OF gty_s_bp_message .
endinterface.
