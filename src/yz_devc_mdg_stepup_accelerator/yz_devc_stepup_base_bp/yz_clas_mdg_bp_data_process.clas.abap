CLASS yz_clas_mdg_bp_data_process DEFINITION
  PUBLIC
  INHERITING FROM yz_clas_mdg_bp_data_process_ex
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES yz_intf_mdg_data_process .

    ALIASES gc_address
      FOR yz_intf_mdg_bp_const~gc_address .
    ALIASES gc_ad_email
      FOR yz_intf_mdg_bp_const~gc_ad_email .
    ALIASES gc_ad_fax
      FOR yz_intf_mdg_bp_const~gc_ad_fax .
    ALIASES gc_ad_name_o
      FOR yz_intf_mdg_bp_const~gc_ad_name_o .
    ALIASES gc_ad_name_p
      FOR yz_intf_mdg_bp_const~gc_ad_name_p .
    ALIASES gc_ad_postal
      FOR yz_intf_mdg_bp_const~gc_ad_postal .
    ALIASES gc_ad_tel
      FOR yz_intf_mdg_bp_const~gc_ad_tel .
    ALIASES gc_ad_url
      FOR yz_intf_mdg_bp_const~gc_ad_url .
    ALIASES gc_bp_adddep
      FOR yz_intf_mdg_bp_const~gc_bp_adddep .
    ALIASES gc_bp_addr
      FOR yz_intf_mdg_bp_const~gc_bp_addr .
    ALIASES gc_bp_addusg
      FOR yz_intf_mdg_bp_const~gc_bp_addusg .
    ALIASES gc_bp_bkdtl
      FOR yz_intf_mdg_bp_const~gc_bp_bkdtl .
    ALIASES gc_bp_ccdtl
      FOR yz_intf_mdg_bp_const~gc_bp_ccdtl .
    ALIASES gc_bp_centrl
      FOR yz_intf_mdg_bp_const~gc_bp_centrl .
    ALIASES gc_bp_compny
      FOR yz_intf_mdg_bp_const~gc_bp_compny .
    ALIASES gc_bp_cpgen
      FOR yz_intf_mdg_bp_const~gc_bp_cpgen .
    ALIASES gc_bp_cuscla
      FOR yz_intf_mdg_bp_const~gc_bp_cuscla .
    ALIASES gc_bp_cusddb
      FOR yz_intf_mdg_bp_const~gc_bp_cusddb .
    ALIASES gc_bp_cusdun
      FOR yz_intf_mdg_bp_const~gc_bp_cusdun .
    ALIASES gc_bp_cusfcn
      FOR yz_intf_mdg_bp_const~gc_bp_cusfcn .
    ALIASES gc_bp_cusgen
      FOR yz_intf_mdg_bp_const~gc_bp_cusgen .
    ALIASES gc_bp_custax
      FOR yz_intf_mdg_bp_const~gc_bp_custax .
    ALIASES gc_bp_cusulp
      FOR yz_intf_mdg_bp_const~gc_bp_cusulp .
    ALIASES gc_bp_cusval
      FOR yz_intf_mdg_bp_const~gc_bp_cusval .
    ALIASES gc_bp_cuswht
      FOR yz_intf_mdg_bp_const~gc_bp_cuswht .
    ALIASES gc_bp_cus_cc
      FOR yz_intf_mdg_bp_const~gc_bp_cus_cc .
    ALIASES gc_bp_dunn
      FOR yz_intf_mdg_bp_const~gc_bp_dunn .
    ALIASES gc_bp_email
      FOR yz_intf_mdg_bp_const~gc_bp_email .
    ALIASES gc_bp_fax
      FOR yz_intf_mdg_bp_const~gc_bp_fax .
    ALIASES gc_bp_header
      FOR yz_intf_mdg_bp_const~gc_bp_header .
    ALIASES gc_bp_hrchy
      FOR yz_intf_mdg_bp_const~gc_bp_hrchy .
    ALIASES gc_bp_idnum
      FOR yz_intf_mdg_bp_const~gc_bp_idnum .
    ALIASES gc_bp_indstr
      FOR yz_intf_mdg_bp_const~gc_bp_indstr .
    ALIASES gc_bp_mlt_ad
      FOR yz_intf_mdg_bp_const~gc_bp_mlt_ad .
    ALIASES gc_bp_mlt_as
      FOR yz_intf_mdg_bp_const~gc_bp_mlt_as .
    ALIASES gc_bp_porg
      FOR yz_intf_mdg_bp_const~gc_bp_porg .
    ALIASES gc_bp_porg2
      FOR yz_intf_mdg_bp_const~gc_bp_porg2 .
    ALIASES gc_bp_rel
      FOR yz_intf_mdg_bp_const~gc_bp_rel .
    ALIASES gc_bp_role
      FOR yz_intf_mdg_bp_const~gc_bp_role .
    ALIASES gc_bp_sales
      FOR yz_intf_mdg_bp_const~gc_bp_sales .
    ALIASES gc_bp_subhry
      FOR yz_intf_mdg_bp_const~gc_bp_subhry .
    ALIASES gc_bp_taxgrp
      FOR yz_intf_mdg_bp_const~gc_bp_taxgrp .
    ALIASES gc_bp_taxnum
      FOR yz_intf_mdg_bp_const~gc_bp_taxnum .
    ALIASES gc_bp_tax_ad
      FOR yz_intf_mdg_bp_const~gc_bp_tax_ad .
    ALIASES gc_bp_tel
      FOR yz_intf_mdg_bp_const~gc_bp_tel .
    ALIASES gc_bp_url
      FOR yz_intf_mdg_bp_const~gc_bp_url .
    ALIASES gc_bp_vencla
      FOR yz_intf_mdg_bp_const~gc_bp_vencla .
    ALIASES gc_bp_venddb
      FOR yz_intf_mdg_bp_const~gc_bp_venddb .
    ALIASES gc_bp_venfcn
      FOR yz_intf_mdg_bp_const~gc_bp_venfcn .
    ALIASES gc_bp_vengen
      FOR yz_intf_mdg_bp_const~gc_bp_vengen .
    ALIASES gc_bp_vensub
      FOR yz_intf_mdg_bp_const~gc_bp_vensub .
    ALIASES gc_bp_venval
      FOR yz_intf_mdg_bp_const~gc_bp_venval .
    ALIASES gc_bp_whtax
      FOR yz_intf_mdg_bp_const~gc_bp_whtax .
    ALIASES gc_bp_wpad
      FOR yz_intf_mdg_bp_const~gc_bp_wpad .
    ALIASES gc_cuscctxt
      FOR yz_intf_mdg_bp_const~gc_cuscctxt .
    ALIASES gc_cusgentxt
      FOR yz_intf_mdg_bp_const~gc_cusgentxt .
    ALIASES gc_cussaltxt
      FOR yz_intf_mdg_bp_const~gc_cussaltxt .
    ALIASES gc_fkklocks
      FOR yz_intf_mdg_bp_const~gc_fkklocks .
    ALIASES gc_fkktaxex
      FOR yz_intf_mdg_bp_const~gc_fkktaxex .
    ALIASES gc_fkktxt
      FOR yz_intf_mdg_bp_const~gc_fkktxt .
    ALIASES gc_fkkvkcorr
      FOR yz_intf_mdg_bp_const~gc_fkkvkcorr .
    ALIASES gc_fkkvkp
      FOR yz_intf_mdg_bp_const~gc_fkkvkp .
    ALIASES gc_fkkvktd
      FOR yz_intf_mdg_bp_const~gc_fkkvktd .
    ALIASES gc_fs_bkk21
      FOR yz_intf_mdg_bp_const~gc_fs_bkk21 .
    ALIASES gc_fs_bp001
      FOR yz_intf_mdg_bp_const~gc_fs_bp001 .
    ALIASES gc_fs_bp011
      FOR yz_intf_mdg_bp_const~gc_fs_bp011 .
    ALIASES gc_fs_bp021
      FOR yz_intf_mdg_bp_const~gc_fs_bp021 .
    ALIASES gc_fs_bp1010
      FOR yz_intf_mdg_bp_const~gc_fs_bp1010 .
    ALIASES gc_fs_bp1012
      FOR yz_intf_mdg_bp_const~gc_fs_bp1012 .
    ALIASES gc_fs_bp1030
      FOR yz_intf_mdg_bp_const~gc_fs_bp1030 .
    ALIASES gc_fs_bpbank
      FOR yz_intf_mdg_bp_const~gc_fs_bpbank .
    ALIASES gc_fs_bptaxc
      FOR yz_intf_mdg_bp_const~gc_fs_bptaxc .
    ALIASES gc_vencctxt
      FOR yz_intf_mdg_bp_const~gc_vencctxt .
    ALIASES gc_vengentxt
      FOR yz_intf_mdg_bp_const~gc_vengentxt .
    ALIASES gc_venpotxt
      FOR yz_intf_mdg_bp_const~gc_venpotxt .
    ALIASES gc_wp_email
      FOR yz_intf_mdg_bp_const~gc_wp_email .
    ALIASES gc_wp_fax
      FOR yz_intf_mdg_bp_const~gc_wp_fax .
    ALIASES gc_wp_postal
      FOR yz_intf_mdg_bp_const~gc_wp_postal .
    ALIASES gc_wp_tel
      FOR yz_intf_mdg_bp_const~gc_wp_tel .
    ALIASES gc_wp_url
      FOR yz_intf_mdg_bp_const~gc_wp_url .
    ALIASES get_entity_data
      FOR yz_intf_mdg_data_process~get_entity_data .
    ALIASES set_entity_data
      FOR yz_intf_mdg_data_process~set_entity_data .
    ALIASES gty_s_bp_message
      FOR yz_intf_mdg_bp_data_types~gty_s_bp_message .
    ALIASES gty_s_bp_where
      FOR yz_intf_mdg_bp_data_types~gty_s_bp_where .
    ALIASES gty_t_addrno
      FOR yz_intf_mdg_bp_data_types~gty_t_addrno .
    ALIASES gty_t_ad_email
      FOR yz_intf_mdg_bp_data_types~gty_t_ad_email .
    ALIASES gty_t_ad_fax
      FOR yz_intf_mdg_bp_data_types~gty_t_ad_fax .
    ALIASES gty_t_ad_name_o
      FOR yz_intf_mdg_bp_data_types~gty_t_ad_name_o .
    ALIASES gty_t_ad_name_p
      FOR yz_intf_mdg_bp_data_types~gty_t_ad_name_p .
    ALIASES gty_t_ad_postal
      FOR yz_intf_mdg_bp_data_types~gty_t_ad_postal .
    ALIASES gty_t_ad_tel
      FOR yz_intf_mdg_bp_data_types~gty_t_ad_tel .
    ALIASES gty_t_ad_url
      FOR yz_intf_mdg_bp_data_types~gty_t_ad_url .
    ALIASES gty_t_bp_adddep
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_adddep .
    ALIASES gty_t_bp_addr
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_addr .
    ALIASES gty_t_bp_addusg
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_addusg .
    ALIASES gty_t_bp_bkdtl
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_bkdtl .
    ALIASES gty_t_bp_ccdtl
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_ccdtl .
    ALIASES gty_t_bp_centrl
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_centrl .
    ALIASES gty_t_bp_cgenad
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_cgenad .
    ALIASES gty_t_bp_cm_bp
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_cm_bp .
    ALIASES gty_t_bp_compny
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_compny .
    ALIASES gty_t_bp_cpgen
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_cpgen .
    ALIASES gty_t_bp_csalad
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_csalad .
    ALIASES gty_t_bp_ctaxad
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_ctaxad .
    ALIASES gty_t_bp_culpad
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_culpad .
    ALIASES gty_t_bp_cuscla
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_cuscla .
    ALIASES gty_t_bp_cusddb
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_cusddb .
    ALIASES gty_t_bp_cusdun
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_cusdun .
    ALIASES gty_t_bp_cusfcn
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_cusfcn .
    ALIASES gty_t_bp_cusgen
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_cusgen .
    ALIASES gty_t_bp_custax
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_custax .
    ALIASES gty_t_bp_cusulp
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_cusulp .
    ALIASES gty_t_bp_cusval
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_cusval .
    ALIASES gty_t_bp_cuswht
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_cuswht .
    ALIASES gty_t_bp_cus_cc
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_cus_cc .
    ALIASES gty_t_bp_dunn
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_dunn .
    ALIASES gty_t_bp_email
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_email .
    ALIASES gty_t_bp_fax
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_fax .
    ALIASES gty_t_bp_header
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_header .
    ALIASES gty_t_bp_hrchy
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_hrchy .
    ALIASES gty_t_bp_idnum
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_idnum .
    ALIASES gty_t_bp_indstr
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_indstr .
    ALIASES gty_t_bp_message
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_message .
    ALIASES gty_t_bp_mlt_ad
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_mlt_ad .
    ALIASES gty_t_bp_mlt_as
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_mlt_as .
    ALIASES gty_t_bp_porg
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_porg .
    ALIASES gty_t_bp_porg2
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_porg2 .
    ALIASES gty_t_bp_rel
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_rel .
    ALIASES gty_t_bp_role
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_role .
    ALIASES gty_t_bp_sales
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_sales .
    ALIASES gty_t_bp_subhry
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_subhry .
    ALIASES gty_t_bp_taxgrp
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_taxgrp .
    ALIASES gty_t_bp_taxnum
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_taxnum .
    ALIASES gty_t_bp_tax_ad
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_tax_ad .
    ALIASES gty_t_bp_tel
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_tel .
    ALIASES gty_t_bp_url
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_url .
    ALIASES gty_t_bp_vencla
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_vencla .
    ALIASES gty_t_bp_venddb
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_venddb .
    ALIASES gty_t_bp_venfcn
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_venfcn .
    ALIASES gty_t_bp_vengen
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_vengen .
    ALIASES gty_t_bp_vensub
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_vensub .
    ALIASES gty_t_bp_venval
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_venval .
    ALIASES gty_t_bp_where
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_where .
    ALIASES gty_t_bp_whtax
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_whtax .
    ALIASES gty_t_bp_wpad
      FOR yz_intf_mdg_bp_data_types~gty_t_bp_wpad .
    ALIASES gty_t_cuscctxt
      FOR yz_intf_mdg_bp_data_types~gty_t_cuscctxt .
    ALIASES gty_t_cusgentxt
      FOR yz_intf_mdg_bp_data_types~gty_t_cusgentxt .
    ALIASES gty_t_cussaltxt
      FOR yz_intf_mdg_bp_data_types~gty_t_cussaltxt .
    ALIASES gty_t_fkklocks
      FOR yz_intf_mdg_bp_data_types~gty_t_fkklocks .
    ALIASES gty_t_fkktaxex
      FOR yz_intf_mdg_bp_data_types~gty_t_fkktaxex .
    ALIASES gty_t_fkktxt
      FOR yz_intf_mdg_bp_data_types~gty_t_fkktxt .
    ALIASES gty_t_fkkvk
      FOR yz_intf_mdg_bp_data_types~gty_t_fkkvk .
    ALIASES gty_t_fkkvkcorr
      FOR yz_intf_mdg_bp_data_types~gty_t_fkkvkcorr .
    ALIASES gty_t_fkkvkp
      FOR yz_intf_mdg_bp_data_types~gty_t_fkkvkp .
    ALIASES gty_t_fkkvktd
      FOR yz_intf_mdg_bp_data_types~gty_t_fkkvktd .
    ALIASES gty_t_fs_bkk21
      FOR yz_intf_mdg_bp_data_types~gty_t_fs_bkk21 .
    ALIASES gty_t_fs_bp001
      FOR yz_intf_mdg_bp_data_types~gty_t_fs_bp001 .
    ALIASES gty_t_fs_bp011
      FOR yz_intf_mdg_bp_data_types~gty_t_fs_bp011 .
    ALIASES gty_t_fs_bp021
      FOR yz_intf_mdg_bp_data_types~gty_t_fs_bp021 .
    ALIASES gty_t_fs_bp1010
      FOR yz_intf_mdg_bp_data_types~gty_t_fs_bp1010 .
    ALIASES gty_t_fs_bp1012
      FOR yz_intf_mdg_bp_data_types~gty_t_fs_bp1012 .
    ALIASES gty_t_fs_bp1030
      FOR yz_intf_mdg_bp_data_types~gty_t_fs_bp1030 .
    ALIASES gty_t_fs_bpbank
      FOR yz_intf_mdg_bp_data_types~gty_t_fs_bpbank .
    ALIASES gty_t_fs_bptaxc
      FOR yz_intf_mdg_bp_data_types~gty_t_fs_bptaxc .
    ALIASES gty_t_vencctxt
      FOR yz_intf_mdg_bp_data_types~gty_t_vencctxt .
    ALIASES gty_t_vengentxt
      FOR yz_intf_mdg_bp_data_types~gty_t_vengentxt .
    ALIASES gty_t_venpotxt
      FOR yz_intf_mdg_bp_data_types~gty_t_venpotxt .
    ALIASES gty_t_wp_email
      FOR yz_intf_mdg_bp_data_types~gty_t_wp_email .
    ALIASES gty_t_wp_fax
      FOR yz_intf_mdg_bp_data_types~gty_t_wp_fax .
    ALIASES gty_t_wp_postal
      FOR yz_intf_mdg_bp_data_types~gty_t_wp_postal .
    ALIASES gty_t_wp_tel
      FOR yz_intf_mdg_bp_data_types~gty_t_wp_tel .
    ALIASES gty_t_wp_url
      FOR yz_intf_mdg_bp_data_types~gty_t_wp_url .

    CLASS-DATA gt_bp_header TYPE gty_t_bp_header .
    CLASS-DATA gt_bp_hrchy TYPE gty_t_bp_hrchy .
    CLASS-DATA gt_bp_rel TYPE gty_t_bp_rel .
    CLASS-DATA gt_bp_subhry TYPE gty_t_bp_subhry .
    CLASS-DATA gt_address TYPE gty_t_address .
    CLASS-DATA gt_addrno TYPE gty_t_addrno .
    CLASS-DATA gt_ad_email TYPE gty_t_ad_email .
    CLASS-DATA gt_ad_fax TYPE gty_t_ad_fax .
    CLASS-DATA gt_ad_name_o TYPE gty_t_ad_name_o .
    CLASS-DATA gt_ad_name_p TYPE gty_t_ad_name_p .
    CLASS-DATA gt_ad_postal TYPE gty_t_ad_postal .
    CLASS-DATA gt_ad_tel TYPE gty_t_ad_tel .
    CLASS-DATA gt_ad_url TYPE gty_t_ad_url .
    CLASS-DATA gt_bp_adddep TYPE gty_t_bp_adddep .
    CLASS-DATA gt_bp_addr TYPE gty_t_bp_addr .
    CLASS-DATA gt_bp_addusg TYPE gty_t_bp_addusg .
    CLASS-DATA gt_bp_bkdtl TYPE gty_t_bp_bkdtl .
    CLASS-DATA gt_bp_ccdtl TYPE gty_t_bp_ccdtl .
    CLASS-DATA gt_bp_centrl TYPE gty_t_bp_centrl .
    CLASS-DATA gt_bp_compny TYPE gty_t_bp_compny .
    CLASS-DATA gt_bp_cpgen TYPE gty_t_bp_cpgen .
    CLASS-DATA gt_bp_cuscla TYPE gty_t_bp_cuscla .
    CLASS-DATA gt_bp_cusddb TYPE gty_t_bp_cusddb .
    CLASS-DATA gt_bp_cusdun TYPE gty_t_bp_cusdun .
    CLASS-DATA gt_bp_cusfcn TYPE gty_t_bp_cusfcn .
    CLASS-DATA gt_bp_cusgen TYPE gty_t_bp_cusgen .
    CLASS-DATA gt_bp_custax TYPE gty_t_bp_custax .
    CLASS-DATA gt_bp_cusulp TYPE gty_t_bp_cusulp .
    CLASS-DATA gt_bp_cusval TYPE gty_t_bp_cusval .
    CLASS-DATA gt_bp_cuswht TYPE gty_t_bp_cuswht .
    CLASS-DATA gt_bp_cus_cc TYPE gty_t_bp_cus_cc .
    CLASS-DATA gt_bp_dunn TYPE gty_t_bp_dunn .
    CLASS-DATA gt_bp_email TYPE gty_t_bp_email .
    CLASS-DATA gt_bp_fax TYPE gty_t_bp_fax .
    CLASS-DATA gt_bp_idnum TYPE gty_t_bp_idnum .
    CLASS-DATA gt_bp_indstr TYPE gty_t_bp_indstr .
    CLASS-DATA gt_bp_mlt_ad TYPE gty_t_bp_mlt_ad .
    CLASS-DATA gt_bp_mlt_as TYPE gty_t_bp_mlt_as .
    CLASS-DATA gt_bp_porg TYPE gty_t_bp_porg .
    CLASS-DATA gt_bp_porg2 TYPE gty_t_bp_porg2 .
    CLASS-DATA gt_bp_role TYPE gty_t_bp_role .
    CLASS-DATA gt_bp_sales TYPE gty_t_bp_sales .
    CLASS-DATA gt_bp_taxgrp TYPE gty_t_bp_taxgrp .
    CLASS-DATA gt_bp_taxnum TYPE gty_t_bp_taxnum .
    CLASS-DATA gt_bp_tax_ad TYPE gty_t_bp_tax_ad .
    CLASS-DATA gt_bp_tel TYPE gty_t_bp_tel .
    CLASS-DATA gt_bp_url TYPE gty_t_bp_url .
    CLASS-DATA gt_bp_vencla TYPE gty_t_bp_vencla .
    CLASS-DATA gt_bp_venddb TYPE gty_t_bp_venddb .
    CLASS-DATA gt_bp_venfcn TYPE gty_t_bp_venfcn .
    CLASS-DATA gt_bp_vengen TYPE gty_t_bp_vengen .
    CLASS-DATA gt_bp_vensub TYPE gty_t_bp_vensub .
    CLASS-DATA gt_bp_venval TYPE gty_t_bp_venval .
    CLASS-DATA gt_bp_whtax TYPE gty_t_bp_whtax .
    CLASS-DATA gt_bp_wpad TYPE gty_t_bp_wpad .
    CLASS-DATA gt_cuscctxt TYPE gty_t_cuscctxt .
    CLASS-DATA gt_cusgentxt TYPE gty_t_cusgentxt .
    CLASS-DATA gt_cussaltxt TYPE gty_t_cussaltxt .
    CLASS-DATA gt_fkklocks TYPE gty_t_fkklocks .
    CLASS-DATA gt_fkktaxex TYPE gty_t_fkktaxex .
    CLASS-DATA gt_fkktxt TYPE gty_t_fkktxt .
    CLASS-DATA gt_fkkvkcorr TYPE gty_t_fkkvkcorr .
    CLASS-DATA gt_fkkvkp TYPE gty_t_fkkvkp .
    CLASS-DATA gt_fkkvktd TYPE gty_t_fkkvktd .
    CLASS-DATA gt_fs_bkk21 TYPE gty_t_fs_bkk21 .
    CLASS-DATA gt_fs_bp001 TYPE gty_t_fs_bp001 .
    CLASS-DATA gt_fs_bp011 TYPE gty_t_fs_bp011 .
    CLASS-DATA gt_fs_bp021 TYPE gty_t_fs_bp021 .
    CLASS-DATA gt_fs_bp1010 TYPE gty_t_fs_bp1010 .
    CLASS-DATA gt_fs_bp1012 TYPE gty_t_fs_bp1012 .
    CLASS-DATA gt_fs_bp1030 TYPE gty_t_fs_bp1030 .
    CLASS-DATA gt_fs_bpbank TYPE gty_t_fs_bpbank .
    CLASS-DATA gt_fs_bptaxc TYPE gty_t_fs_bptaxc .
    CLASS-DATA gt_vencctxt TYPE gty_t_vencctxt .
    CLASS-DATA gt_vengentxt TYPE gty_t_vengentxt .
    CLASS-DATA gt_venpotxt TYPE gty_t_venpotxt .
    CLASS-DATA gt_wp_email TYPE gty_t_wp_email .
    CLASS-DATA gt_wp_fax TYPE gty_t_wp_fax .
    CLASS-DATA gt_wp_postal TYPE gty_t_wp_postal .
    CLASS-DATA gt_wp_tel TYPE gty_t_wp_tel .
    CLASS-DATA gt_wp_url TYPE gty_t_wp_url .

    METHODS constructor .
    CLASS-METHODS get_data_process
      RETURNING
        VALUE(ro_data_process) TYPE REF TO yz_intf_mdg_data_process .
    CLASS-METHODS set_mdc2stage
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS set_bp_header
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_header
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_bp_header) TYPE gty_t_bp_header .
    CLASS-METHODS del_bp_header
      IMPORTING
        !it_data TYPE gty_t_bp_header .
    CLASS-METHODS set_bp_centrl
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_centrl
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_bp_centrl) TYPE gty_t_bp_centrl .
    CLASS-METHODS del_bp_centrl
      IMPORTING
        !it_data TYPE gty_t_bp_centrl .
    CLASS-METHODS set_bp_hrchy
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_hrchy
      IMPORTING
        !iv_crequest       TYPE usmd_crequest OPTIONAL
        !it_key_value      TYPE gty_t_key_value OPTIONAL
        !iv_readmode       TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data           TYPE REF TO data
      RETURNING
        VALUE(rt_bp_hrchy) TYPE gty_t_bp_hrchy .
    CLASS-METHODS del_bp_hrchy
      IMPORTING
        !it_data TYPE gty_t_bp_hrchy .
    CLASS-METHODS set_bp_rel
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_rel
      IMPORTING
        !iv_crequest     TYPE usmd_crequest OPTIONAL
        !it_key_value    TYPE gty_t_key_value OPTIONAL
        !iv_readmode     TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data         TYPE REF TO data
      RETURNING
        VALUE(rt_bp_rel) TYPE gty_t_bp_rel .
    CLASS-METHODS del_bp_rel
      IMPORTING
        !it_data TYPE gty_t_bp_rel .
    CLASS-METHODS set_bp_subhry
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_subhry
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_bp_subhry) TYPE gty_t_bp_subhry .
    CLASS-METHODS del_bp_subhry
      IMPORTING
        !it_data TYPE gty_t_bp_subhry .
    CLASS-METHODS set_address
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_address
      IMPORTING
        !iv_crequest      TYPE usmd_crequest OPTIONAL
        !it_key_value     TYPE gty_t_key_value OPTIONAL
        !iv_readmode      TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data          TYPE REF TO data
      RETURNING
        VALUE(rt_address) TYPE gty_t_address .
    CLASS-METHODS del_address
      IMPORTING
        !it_data TYPE gty_t_address .
    CLASS-METHODS set_ad_email
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_ad_email
      IMPORTING
        !iv_crequest       TYPE usmd_crequest OPTIONAL
        !it_key_value      TYPE gty_t_key_value OPTIONAL
        !iv_readmode       TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data           TYPE REF TO data
      RETURNING
        VALUE(rt_ad_email) TYPE gty_t_ad_email .
    CLASS-METHODS del_ad_email
      IMPORTING
        !it_data TYPE gty_t_ad_email .
    CLASS-METHODS set_ad_fax
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_ad_fax
      IMPORTING
        !iv_crequest     TYPE usmd_crequest OPTIONAL
        !it_key_value    TYPE gty_t_key_value OPTIONAL
        !iv_readmode     TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data         TYPE REF TO data
      RETURNING
        VALUE(rt_ad_fax) TYPE gty_t_ad_fax .
    CLASS-METHODS del_ad_fax
      IMPORTING
        !it_data TYPE gty_t_ad_fax .
    CLASS-METHODS set_ad_name_o
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_ad_name_o
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_ad_name_o) TYPE gty_t_ad_name_o .
    CLASS-METHODS del_ad_name_o
      IMPORTING
        !it_data TYPE gty_t_ad_name_o .
    CLASS-METHODS set_ad_name_p
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_ad_name_p
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_ad_name_p) TYPE gty_t_ad_name_p .
    CLASS-METHODS del_ad_name_p
      IMPORTING
        !it_data TYPE gty_t_ad_name_p .
    CLASS-METHODS set_ad_postal
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_ad_postal
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_ad_postal) TYPE gty_t_ad_postal .
    CLASS-METHODS del_ad_postal
      IMPORTING
        !it_data TYPE gty_t_ad_postal .
    CLASS-METHODS set_ad_tel
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_ad_tel
      IMPORTING
        !iv_crequest     TYPE usmd_crequest OPTIONAL
        !it_key_value    TYPE gty_t_key_value OPTIONAL
        !iv_readmode     TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data         TYPE REF TO data
      RETURNING
        VALUE(rt_ad_tel) TYPE gty_t_ad_tel .
    CLASS-METHODS del_ad_tel
      IMPORTING
        !it_data TYPE gty_t_ad_tel .
    CLASS-METHODS set_ad_url
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_ad_url
      IMPORTING
        !iv_crequest     TYPE usmd_crequest OPTIONAL
        !it_key_value    TYPE gty_t_key_value OPTIONAL
        !iv_readmode     TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data         TYPE REF TO data
      RETURNING
        VALUE(rt_ad_url) TYPE gty_t_ad_url .
    CLASS-METHODS del_ad_url
      IMPORTING
        !it_data TYPE gty_t_ad_url .
    CLASS-METHODS set_bp_adddep
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_adddep
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_bp_adddep) TYPE gty_t_bp_adddep .
    CLASS-METHODS del_bp_adddep
      IMPORTING
        !it_data TYPE gty_t_bp_adddep .
    CLASS-METHODS set_bp_addr
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_addr
      IMPORTING
        !iv_crequest      TYPE usmd_crequest OPTIONAL
        !it_key_value     TYPE gty_t_key_value OPTIONAL
        !iv_readmode      TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data          TYPE REF TO data
      RETURNING
        VALUE(rt_bp_addr) TYPE gty_t_bp_addr .
    CLASS-METHODS del_bp_addr
      IMPORTING
        !it_data TYPE gty_t_bp_addr .
    CLASS-METHODS set_bp_addusg
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_addusg
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_bp_addusg) TYPE gty_t_bp_addusg .
    CLASS-METHODS del_bp_addusg
      IMPORTING
        !it_data TYPE gty_t_bp_addusg .
    CLASS-METHODS set_bp_bkdtl
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_bkdtl
      IMPORTING
        !iv_crequest       TYPE usmd_crequest OPTIONAL
        !it_key_value      TYPE gty_t_key_value OPTIONAL
        !iv_readmode       TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data           TYPE REF TO data
      RETURNING
        VALUE(rt_bp_bkdtl) TYPE gty_t_bp_bkdtl .
    CLASS-METHODS del_bp_bkdtl
      IMPORTING
        !it_data TYPE gty_t_bp_bkdtl .
    CLASS-METHODS set_bp_ccdtl
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_ccdtl
      IMPORTING
        !iv_crequest       TYPE usmd_crequest OPTIONAL
        !it_key_value      TYPE gty_t_key_value OPTIONAL
        !iv_readmode       TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data           TYPE REF TO data
      RETURNING
        VALUE(rt_bp_ccdtl) TYPE gty_t_bp_ccdtl .
    CLASS-METHODS del_bp_ccdtl
      IMPORTING
        !it_data TYPE gty_t_bp_ccdtl .
    CLASS-METHODS set_bp_compny
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_compny
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_bp_compny) TYPE gty_t_bp_compny .
    CLASS-METHODS del_bp_compny
      IMPORTING
        !it_data TYPE gty_t_bp_compny .
    CLASS-METHODS set_bp_cusdun
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_cusdun
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_bp_cusdun) TYPE gty_t_bp_cusdun .
    CLASS-METHODS del_bp_cusdun
      IMPORTING
        !it_data TYPE gty_t_bp_cusdun .
    CLASS-METHODS set_bp_cusfcn
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_cusfcn
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_bp_cusfcn) TYPE gty_t_bp_cusfcn .
    CLASS-METHODS del_bp_cusfcn
      IMPORTING
        !it_data TYPE gty_t_bp_cusfcn .
    CLASS-METHODS set_bp_custax
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_custax
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_bp_custax) TYPE gty_t_bp_custax .
    CLASS-METHODS del_bp_custax
      IMPORTING
        !it_data TYPE gty_t_bp_custax .
    CLASS-METHODS set_bp_cusddb
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_cusddb
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_bp_cusddb) TYPE gty_t_bp_cusddb .
    CLASS-METHODS del_bp_cusddb
      IMPORTING
        !it_data TYPE gty_t_bp_cusddb .
    CLASS-METHODS set_bp_cuscla
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_cuscla
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_bp_cuscla) TYPE gty_t_bp_cuscla .
    CLASS-METHODS del_bp_cuscla
      IMPORTING
        !it_data TYPE gty_t_bp_cuscla .
    CLASS-METHODS set_bp_cpgen
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_cpgen
      IMPORTING
        !iv_crequest       TYPE usmd_crequest OPTIONAL
        !it_key_value      TYPE gty_t_key_value OPTIONAL
        !iv_readmode       TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data           TYPE REF TO data
      RETURNING
        VALUE(rt_bp_cpgen) TYPE gty_t_bp_cpgen .
    CLASS-METHODS del_bp_cpgen
      IMPORTING
        !it_data TYPE gty_t_bp_cpgen .
    CLASS-METHODS set_bp_cusgen
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_cusgen
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_bp_cusgen) TYPE gty_t_bp_cusgen .
    CLASS-METHODS del_bp_cusgen
      IMPORTING
        !it_data TYPE gty_t_bp_cusgen .
    CLASS-METHODS set_bp_cusulp
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_cusulp
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_bp_cusulp) TYPE gty_t_bp_cusulp .
    CLASS-METHODS del_bp_cusulp
      IMPORTING
        !it_data TYPE gty_t_bp_cusulp .
    CLASS-METHODS set_bp_cusval
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_cusval
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_bp_cusval) TYPE gty_t_bp_cusval .
    CLASS-METHODS del_bp_cusval
      IMPORTING
        !it_data TYPE gty_t_bp_cusval .
    CLASS-METHODS set_bp_cuswht
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_cuswht
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_bp_cuswht) TYPE gty_t_bp_cuswht .
    CLASS-METHODS del_bp_cuswht
      IMPORTING
        !it_data TYPE gty_t_bp_cuswht .
    CLASS-METHODS set_bp_cus_cc
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_cus_cc
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_bp_cus_cc) TYPE gty_t_bp_cus_cc .
    CLASS-METHODS del_bp_cus_cc
      IMPORTING
        !it_data TYPE gty_t_bp_cus_cc .
    CLASS-METHODS set_bp_dunn
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_dunn
      IMPORTING
        !iv_crequest      TYPE usmd_crequest OPTIONAL
        !it_key_value     TYPE gty_t_key_value OPTIONAL
        !iv_readmode      TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data          TYPE REF TO data
      RETURNING
        VALUE(rt_bp_dunn) TYPE gty_t_bp_dunn .
    CLASS-METHODS del_bp_dunn
      IMPORTING
        !it_data TYPE gty_t_bp_dunn .
    CLASS-METHODS set_bp_email
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_email
      IMPORTING
        !iv_crequest       TYPE usmd_crequest OPTIONAL
        !it_key_value      TYPE gty_t_key_value OPTIONAL
        !iv_readmode       TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data           TYPE REF TO data
      RETURNING
        VALUE(rt_bp_email) TYPE gty_t_bp_email .
    CLASS-METHODS set_bp_fax
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_fax
      IMPORTING
        !iv_crequest     TYPE usmd_crequest OPTIONAL
        !it_key_value    TYPE gty_t_key_value OPTIONAL
        !iv_readmode     TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data         TYPE REF TO data
      RETURNING
        VALUE(rt_bp_fax) TYPE gty_t_bp_fax .
    CLASS-METHODS set_bp_idnum
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_idnum
      IMPORTING
        !iv_crequest       TYPE usmd_crequest OPTIONAL
        !it_key_value      TYPE gty_t_key_value OPTIONAL
        !iv_readmode       TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data           TYPE REF TO data
      RETURNING
        VALUE(rt_bp_idnum) TYPE gty_t_bp_idnum .
    CLASS-METHODS set_bp_indstr
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_indstr
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_bp_indstr) TYPE gty_t_bp_indstr .
    CLASS-METHODS set_bp_mlt_ad
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_mlt_ad
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_bp_mlt_ad) TYPE gty_t_bp_mlt_ad .
    CLASS-METHODS set_bp_mlt_as
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_mlt_as
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_bp_mlt_as) TYPE gty_t_bp_mlt_as .
    CLASS-METHODS del_bp_mlt_as
      IMPORTING
        !it_data TYPE gty_t_bp_mlt_as .
    CLASS-METHODS set_bp_porg
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_porg
      IMPORTING
        !iv_crequest      TYPE usmd_crequest OPTIONAL
        !it_key_value     TYPE gty_t_key_value OPTIONAL
        !iv_readmode      TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data          TYPE REF TO data
      RETURNING
        VALUE(rt_bp_porg) TYPE gty_t_bp_porg .
    CLASS-METHODS del_bp_porg
      IMPORTING
        !it_data TYPE gty_t_bp_porg .
    CLASS-METHODS set_bp_porg2
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_porg2
      IMPORTING
        !iv_crequest       TYPE usmd_crequest OPTIONAL
        !it_key_value      TYPE gty_t_key_value OPTIONAL
        !iv_readmode       TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data           TYPE REF TO data
      RETURNING
        VALUE(rt_bp_porg2) TYPE gty_t_bp_porg2 .
    CLASS-METHODS del_bp_porg2
      IMPORTING
        !it_data TYPE gty_t_bp_porg2 .
    CLASS-METHODS set_bp_role
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_role
      IMPORTING
        !iv_crequest      TYPE usmd_crequest OPTIONAL
        !it_key_value     TYPE gty_t_key_value OPTIONAL
        !iv_readmode      TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data          TYPE REF TO data
      RETURNING
        VALUE(rt_bp_role) TYPE gty_t_bp_role .
    CLASS-METHODS del_bp_role
      IMPORTING
        !it_data TYPE gty_t_bp_role .
    CLASS-METHODS set_bp_sales
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_sales
      IMPORTING
        !iv_crequest       TYPE usmd_crequest OPTIONAL
        !it_key_value      TYPE gty_t_key_value OPTIONAL
        !iv_readmode       TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data           TYPE REF TO data
      RETURNING
        VALUE(rt_bp_sales) TYPE gty_t_bp_sales .
    CLASS-METHODS del_bp_sales
      IMPORTING
        !it_data TYPE gty_t_bp_sales .
    CLASS-METHODS set_bp_taxgrp
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_taxgrp
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_bp_taxgrp) TYPE gty_t_bp_taxgrp .
    CLASS-METHODS del_bp_taxgrp
      IMPORTING
        !it_data TYPE gty_t_bp_taxgrp .
    CLASS-METHODS set_bp_taxnum
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_taxnum
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_bp_taxnum) TYPE gty_t_bp_taxnum .
    CLASS-METHODS del_bp_taxnum
      IMPORTING
        !it_data TYPE gty_t_bp_taxnum .
    CLASS-METHODS set_bp_tax_ad
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_tax_ad
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_bp_tax_ad) TYPE gty_t_bp_tax_ad .
    CLASS-METHODS del_bp_tax_ad
      IMPORTING
        !it_data TYPE gty_t_bp_tax_ad .
    CLASS-METHODS set_bp_tel
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_tel
      IMPORTING
        !iv_crequest     TYPE usmd_crequest OPTIONAL
        !it_key_value    TYPE gty_t_key_value OPTIONAL
        !iv_readmode     TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data         TYPE REF TO data
      RETURNING
        VALUE(rt_bp_tel) TYPE gty_t_bp_tel .
    CLASS-METHODS del_bp_tel
      IMPORTING
        !it_data TYPE gty_t_bp_tel .
    CLASS-METHODS set_bp_url
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_url
      IMPORTING
        !iv_crequest     TYPE usmd_crequest OPTIONAL
        !it_key_value    TYPE gty_t_key_value OPTIONAL
        !iv_readmode     TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data         TYPE REF TO data
      RETURNING
        VALUE(rt_bp_url) TYPE gty_t_bp_url .
    CLASS-METHODS del_bp_url
      IMPORTING
        !it_data TYPE gty_t_bp_url .
    CLASS-METHODS set_bp_vencla
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_vencla
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_bp_vencla) TYPE gty_t_bp_vencla .
    CLASS-METHODS del_bp_vencla
      IMPORTING
        !it_data TYPE gty_t_bp_vencla .
    CLASS-METHODS set_bp_venddb
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_venddb
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_bp_venddb) TYPE gty_t_bp_venddb .
    CLASS-METHODS del_bp_venddb
      IMPORTING
        !it_data TYPE gty_t_bp_venddb .
    CLASS-METHODS set_bp_venfcn
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_venfcn
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_bp_venfcn) TYPE gty_t_bp_venfcn .
    CLASS-METHODS set_bp_vengen
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_vengen
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_bp_vengen) TYPE gty_t_bp_vengen .
    CLASS-METHODS del_bp_vengen
      IMPORTING
        !it_data TYPE gty_t_bp_vengen .
    CLASS-METHODS set_bp_vensub
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_vensub
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_bp_vensub) TYPE gty_t_bp_vensub .
    CLASS-METHODS del_bp_vensub
      IMPORTING
        !it_data TYPE gty_t_bp_vensub .
    CLASS-METHODS set_bp_venval
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_venval
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_bp_venval) TYPE gty_t_bp_venval .
    CLASS-METHODS del_bp_venval
      IMPORTING
        !it_data TYPE gty_t_bp_venval .
    CLASS-METHODS set_bp_whtax
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_whtax
      IMPORTING
        !iv_crequest       TYPE usmd_crequest OPTIONAL
        !it_key_value      TYPE gty_t_key_value OPTIONAL
        !iv_readmode       TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data           TYPE REF TO data
      RETURNING
        VALUE(rt_bp_whtax) TYPE gty_t_bp_whtax .
    CLASS-METHODS del_bp_whtax
      IMPORTING
        !it_data TYPE gty_t_bp_whtax .
    CLASS-METHODS set_bp_wpad
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_bp_wpad
      IMPORTING
        !iv_crequest      TYPE usmd_crequest OPTIONAL
        !it_key_value     TYPE gty_t_key_value OPTIONAL
        !iv_readmode      TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data          TYPE REF TO data
      RETURNING
        VALUE(rt_bp_wpad) TYPE gty_t_bp_wpad .
    CLASS-METHODS del_bp_wpad
      IMPORTING
        !it_data TYPE gty_t_bp_wpad .
    CLASS-METHODS set_fkklocks
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_fkklocks
      IMPORTING
        !iv_crequest       TYPE usmd_crequest OPTIONAL
        !it_key_value      TYPE gty_t_key_value OPTIONAL
        !iv_readmode       TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data           TYPE REF TO data
      RETURNING
        VALUE(rt_fkklocks) TYPE gty_t_fkklocks .
    CLASS-METHODS del_fkklocks
      IMPORTING
        !it_data TYPE gty_t_fkklocks .
    CLASS-METHODS set_fkktaxex
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_fkktaxex
      IMPORTING
        !iv_crequest       TYPE usmd_crequest OPTIONAL
        !it_key_value      TYPE gty_t_key_value OPTIONAL
        !iv_readmode       TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data           TYPE REF TO data
      RETURNING
        VALUE(rt_fkktaxex) TYPE gty_t_fkktaxex .
    CLASS-METHODS del_fkktaxex
      IMPORTING
        !it_data TYPE gty_t_fkktaxex .
    CLASS-METHODS set_fkktxt
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_fkktxt
      IMPORTING
        !iv_crequest     TYPE usmd_crequest OPTIONAL
        !it_key_value    TYPE gty_t_key_value OPTIONAL
        !iv_readmode     TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data         TYPE REF TO data
      RETURNING
        VALUE(rt_fkktxt) TYPE gty_t_fkktxt .
    CLASS-METHODS del_fkktxt
      IMPORTING
        !it_data TYPE gty_t_fkktxt .
    CLASS-METHODS set_fkkvkp
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_fkkvkp
      IMPORTING
        !iv_crequest     TYPE usmd_crequest OPTIONAL
        !it_key_value    TYPE gty_t_key_value OPTIONAL
        !iv_readmode     TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data         TYPE REF TO data
      RETURNING
        VALUE(rt_fkkvkp) TYPE gty_t_fkkvkp .
    CLASS-METHODS del_fkkvkp
      IMPORTING
        !it_data TYPE gty_t_fkkvkp .
    CLASS-METHODS set_fkkvktd
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_fkkvktd
      IMPORTING
        !iv_crequest      TYPE usmd_crequest OPTIONAL
        !it_key_value     TYPE gty_t_key_value OPTIONAL
        !iv_readmode      TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data          TYPE REF TO data
      RETURNING
        VALUE(rt_fkkvktd) TYPE gty_t_fkkvktd .
    CLASS-METHODS del_fkkvktd
      IMPORTING
        !it_data TYPE gty_t_fkkvktd .
    CLASS-METHODS set_fs_bkk21
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_fs_bkk21
      IMPORTING
        !iv_crequest       TYPE usmd_crequest OPTIONAL
        !it_key_value      TYPE gty_t_key_value OPTIONAL
        !iv_readmode       TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data           TYPE REF TO data
      RETURNING
        VALUE(rt_fs_bkk21) TYPE gty_t_fs_bkk21 .
    CLASS-METHODS del_fs_bkk21
      IMPORTING
        !it_data TYPE gty_t_fs_bkk21 .
    CLASS-METHODS set_fs_bp001
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_fs_bp001
      IMPORTING
        !iv_crequest       TYPE usmd_crequest OPTIONAL
        !it_key_value      TYPE gty_t_key_value OPTIONAL
        !iv_readmode       TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data           TYPE REF TO data
      RETURNING
        VALUE(rt_fs_bp001) TYPE gty_t_fs_bp001 .
    CLASS-METHODS del_fs_bp001
      IMPORTING
        !it_data TYPE gty_t_fs_bp001 .
    CLASS-METHODS set_fs_bp011
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_fs_bp011
      IMPORTING
        !iv_crequest       TYPE usmd_crequest OPTIONAL
        !it_key_value      TYPE gty_t_key_value OPTIONAL
        !iv_readmode       TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data           TYPE REF TO data
      RETURNING
        VALUE(rt_fs_bp011) TYPE gty_t_fs_bp011 .
    CLASS-METHODS del_fs_bp011
      IMPORTING
        !it_data TYPE gty_t_fs_bp011 .
    CLASS-METHODS set_fs_bp021
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_fs_bp021
      IMPORTING
        !iv_crequest       TYPE usmd_crequest OPTIONAL
        !it_key_value      TYPE gty_t_key_value OPTIONAL
        !iv_readmode       TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data           TYPE REF TO data
      RETURNING
        VALUE(rt_fs_bp021) TYPE gty_t_fs_bp021 .
    CLASS-METHODS del_fs_bp021
      IMPORTING
        !it_data TYPE gty_t_fs_bp021 .
    CLASS-METHODS set_fs_bp1010
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_fs_bp1010
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_fs_bp1010) TYPE gty_t_fs_bp1010 .
    CLASS-METHODS del_fs_bp1010
      IMPORTING
        !it_data TYPE gty_t_fs_bp1010 .
    CLASS-METHODS set_fs_bp1012
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_fs_bp1012
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_fs_bp1012) TYPE gty_t_fs_bp1012 .
    CLASS-METHODS del_fs_bp1012
      IMPORTING
        !it_data TYPE gty_t_fs_bp1012 .
    CLASS-METHODS set_fs_bp1030
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_fs_bp1030
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_fs_bp1030) TYPE gty_t_fs_bp1030 .
    CLASS-METHODS del_fs_bp1030
      IMPORTING
        !it_data TYPE gty_t_fs_bp1030 .
    CLASS-METHODS set_fs_bpbank
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_fs_bpbank
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_fs_bpbank) TYPE gty_t_fs_bpbank .
    CLASS-METHODS del_fs_bpbank
      IMPORTING
        !it_data TYPE gty_t_fs_bpbank .
    CLASS-METHODS set_fs_bptaxc
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_fs_bptaxc
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_fs_bptaxc) TYPE gty_t_fs_bptaxc .
    CLASS-METHODS del_fs_bptaxc
      IMPORTING
        !it_data TYPE gty_t_fs_bptaxc .
    CLASS-METHODS set_wp_email
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_wp_email
      IMPORTING
        !iv_crequest       TYPE usmd_crequest OPTIONAL
        !it_key_value      TYPE gty_t_key_value OPTIONAL
        !iv_readmode       TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data           TYPE REF TO data
      RETURNING
        VALUE(rt_wp_email) TYPE gty_t_wp_email .
    CLASS-METHODS del_wp_email
      IMPORTING
        !it_data TYPE gty_t_wp_email .
    CLASS-METHODS set_wp_fax
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_wp_fax
      IMPORTING
        !iv_crequest     TYPE usmd_crequest OPTIONAL
        !it_key_value    TYPE gty_t_key_value OPTIONAL
        !iv_readmode     TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data         TYPE REF TO data
      RETURNING
        VALUE(rt_wp_fax) TYPE gty_t_wp_fax .
    CLASS-METHODS del_wp_fax
      IMPORTING
        !it_data TYPE gty_t_wp_fax .
    CLASS-METHODS set_wp_postal
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_wp_postal
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_wp_postal) TYPE gty_t_wp_postal .
    CLASS-METHODS del_wp_postal
      IMPORTING
        !it_data TYPE gty_t_wp_postal .
    CLASS-METHODS set_wp_tel
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_wp_tel
      IMPORTING
        !iv_crequest     TYPE usmd_crequest OPTIONAL
        !it_key_value    TYPE gty_t_key_value OPTIONAL
        !iv_readmode     TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data         TYPE REF TO data
      RETURNING
        VALUE(rt_wp_tel) TYPE gty_t_wp_tel .
    CLASS-METHODS del_wp_tel
      IMPORTING
        !it_data TYPE gty_t_wp_tel .
    CLASS-METHODS set_wp_url
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS get_wp_url
      IMPORTING
        !iv_crequest     TYPE usmd_crequest OPTIONAL
        !it_key_value    TYPE gty_t_key_value OPTIONAL
        !iv_readmode     TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data         TYPE REF TO data
      RETURNING
        VALUE(rt_wp_url) TYPE gty_t_wp_url .
    CLASS-METHODS del_wp_url .
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS del_bp_email
      IMPORTING it_data TYPE gty_t_bp_email.

    METHODS del_bp_fax
      IMPORTING it_data TYPE gty_t_bp_fax.

    METHODS del_bp_idnum
      IMPORTING it_data TYPE gty_t_bp_idnum.

    METHODS del_bp_indstr
      IMPORTING it_data TYPE gty_t_bp_indstr.

    METHODS del_bp_mlt_ad
      IMPORTING it_data TYPE gty_t_bp_mlt_ad.

    CLASS-METHODS del_bp_venfcn
      IMPORTING it_data TYPE gty_t_bp_venfcn.

    CLASS-DATA my_bp_data TYPE REF TO yz_clas_mdg_bp_data_process.
ENDCLASS.



CLASS YZ_CLAS_MDG_BP_DATA_PROCESS IMPLEMENTATION.


  METHOD del_bp_centrl.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_centrl FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_header.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_header FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_hrchy.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_hrchy FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_rel.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_rel FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD get_address.

    IF gt_address IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_address " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_address = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_address     it_key_value = it_key_value ) ).
      LOOP AT gt_address ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_address."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_address = gt_address.
    ENDIF.

    IF rt_address IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_address.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_address ).
    ENDIF.
  ENDMETHOD.


  METHOD get_ad_email.

    IF gt_ad_email IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_ad_email " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_ad_email = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_ad_email     it_key_value = it_key_value ) ).
      LOOP AT gt_ad_email ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_ad_email."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_ad_email = gt_ad_email.
    ENDIF.

    IF rt_ad_email IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_ad_email.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_ad_email ).
    ENDIF.
  ENDMETHOD.


  METHOD get_ad_fax.

    IF gt_ad_fax IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_ad_fax " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_ad_fax = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_ad_fax     it_key_value = it_key_value ) ).
      LOOP AT gt_ad_fax ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_ad_fax."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_ad_fax = gt_ad_fax.
    ENDIF.

    IF rt_ad_fax IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_ad_fax.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_ad_fax ).
    ENDIF.
  ENDMETHOD.


  METHOD get_ad_name_o.

    IF gt_ad_name_o IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_ad_name_o " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_ad_name_o = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_ad_name_o     it_key_value = it_key_value ) ).
      LOOP AT gt_ad_name_o ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_ad_name_o."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_ad_name_o = gt_ad_name_o.
    ENDIF.

    IF rt_ad_name_o IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_ad_name_o.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_ad_name_o ).
    ENDIF.
  ENDMETHOD.


  METHOD get_ad_name_p.

    IF gt_ad_name_p IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_ad_name_p " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_ad_name_p = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_ad_name_p     it_key_value = it_key_value ) ).
      LOOP AT gt_ad_name_p ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_ad_name_p."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_ad_name_p = gt_ad_name_p.
    ENDIF.

    IF rt_ad_name_p IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_ad_name_p.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_ad_name_p ).
    ENDIF.
  ENDMETHOD.


  METHOD get_ad_postal.

    IF gt_ad_postal IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_ad_postal " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_ad_postal = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_ad_postal     it_key_value = it_key_value ) ).
      LOOP AT gt_ad_postal ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_ad_postal."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_ad_postal = gt_ad_postal.
    ENDIF.

    IF rt_ad_postal IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_ad_postal.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_ad_postal ).
    ENDIF.
  ENDMETHOD.


  METHOD get_ad_tel.

    IF gt_ad_tel IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_ad_tel " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_ad_tel = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_ad_tel     it_key_value = it_key_value ) ).
      LOOP AT gt_ad_tel ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_ad_tel."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_ad_tel = gt_ad_tel.
    ENDIF.

    IF rt_ad_tel IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_ad_tel.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_ad_tel ).
    ENDIF.
  ENDMETHOD.


  METHOD get_ad_url.

    IF gt_ad_url IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_ad_url " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_ad_url = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_ad_url     it_key_value = it_key_value ) ).
      LOOP AT gt_ad_url ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_ad_url."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_ad_url = gt_ad_url.
    ENDIF.

    IF rt_ad_url IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_ad_url.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_ad_url ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_adddep.

    IF gt_bp_adddep IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_adddep " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_adddep = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_adddep     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_adddep ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_adddep."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_adddep = gt_bp_adddep.
    ENDIF.

    IF rt_bp_adddep IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_adddep.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_adddep ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_addr.

    IF gt_bp_addr IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_addr " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_addr = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_addr     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_addr ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_addr."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_addr = gt_bp_addr.
    ENDIF.

    IF rt_bp_addr IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_addr.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_addr ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_addusg.

    IF gt_bp_addusg IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_addusg " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_addusg = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_addusg     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_addusg ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_addusg."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_addusg = gt_bp_addusg.
    ENDIF.

    IF rt_bp_addusg IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_addusg.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_addusg ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_bkdtl.

    IF gt_bp_bkdtl IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_bkdtl " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_bkdtl = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_bkdtl     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_bkdtl ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_bkdtl."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_bkdtl = gt_bp_bkdtl.
    ENDIF.

    IF rt_bp_bkdtl IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_bkdtl.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_bkdtl ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_ccdtl.

    IF gt_bp_ccdtl IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_ccdtl " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_ccdtl = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_ccdtl     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_ccdtl ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_ccdtl."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_ccdtl = gt_bp_ccdtl.
    ENDIF.

    IF rt_bp_ccdtl IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_ccdtl.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_ccdtl ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_centrl.

    IF gt_bp_centrl IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_centrl " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_centrl = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_centrl     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_centrl ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_centrl."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_centrl = gt_bp_centrl.
    ENDIF.

    IF rt_bp_centrl IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_centrl.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_centrl ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_compny.

    IF gt_bp_compny IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_compny " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_compny = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_compny     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_compny ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_compny."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_compny = gt_bp_compny.
    ENDIF.

    IF rt_bp_compny IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_compny.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_compny ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_cpgen.

    IF gt_bp_cpgen IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_cpgen " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_cpgen = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_cpgen     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_cpgen ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_cpgen."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_cpgen = gt_bp_cpgen.
    ENDIF.

    IF rt_bp_cpgen IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_cpgen.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_cpgen ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_cuscla.

    IF gt_bp_cuscla IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_cuscla " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_cuscla = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_cuscla     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_cuscla ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_cuscla."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_cuscla = gt_bp_cuscla.
    ENDIF.

    IF rt_bp_cuscla IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_cuscla.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_cuscla ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_cusddb.

    IF gt_bp_cusddb IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_cusddb " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_cusddb = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_cusddb     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_cusddb ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_cusddb."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_cusddb = gt_bp_cusddb.
    ENDIF.

    IF rt_bp_cusddb IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_cusddb.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_cusddb ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_cusdun.

    IF gt_bp_cusdun IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_cusdun " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_cusdun = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_cusdun     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_cusdun ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_cusdun."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_cusdun = gt_bp_cusdun.
    ENDIF.

    IF rt_bp_cusdun IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_cusdun.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_cusdun ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_cusfcn.

    IF gt_bp_cusfcn IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_cusfcn " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_cusfcn = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_cusfcn     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_cusfcn ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_cusfcn."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_cusfcn = gt_bp_cusfcn.
    ENDIF.

    IF rt_bp_cusfcn IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_cusfcn.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_cusfcn ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_cusgen.

    IF gt_bp_cusgen IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_cusgen " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_cusgen = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_cusgen     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_cusgen ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_cusgen."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_cusgen = gt_bp_cusgen.
    ENDIF.

    IF rt_bp_cusgen IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_cusgen.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_cusgen ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_custax.

    IF gt_bp_custax IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_custax " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_custax = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_custax     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_custax ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_custax."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_custax = gt_bp_custax.
    ENDIF.

    IF rt_bp_custax IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_custax.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_custax ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_cusulp.

    IF gt_bp_cusulp IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_cusulp " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_cusulp = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_cusulp     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_cusulp ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_cusulp."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_cusulp = gt_bp_cusulp.
    ENDIF.

    IF rt_bp_cusulp IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_cusulp.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_cusulp ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_cusval.

    IF gt_bp_cusval IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_cusval " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_cusval = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_cusval     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_cusval ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_cusval."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_cusval = gt_bp_cusval.
    ENDIF.

    IF rt_bp_cusval IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_cusval.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_cusval ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_cuswht.

    IF gt_bp_cuswht IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_cuswht " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_cuswht = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_cuswht     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_cuswht ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_cuswht."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_cuswht = gt_bp_cuswht.
    ENDIF.

    IF rt_bp_cuswht IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_cuswht.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_cuswht ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_cus_cc.

    IF gt_bp_cus_cc IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_cus_cc " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_cus_cc = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_cus_cc     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_cus_cc ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_cus_cc."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_cus_cc = gt_bp_cus_cc.
    ENDIF.

    IF rt_bp_cus_cc IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_cus_cc.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_cus_cc ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_dunn.

    IF gt_bp_dunn IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_dunn " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_dunn = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_dunn     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_dunn ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_dunn."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_dunn = gt_bp_dunn.
    ENDIF.

    IF rt_bp_dunn IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_dunn.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_dunn ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_email.

    IF gt_bp_email IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_email " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_email = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_email     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_email ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_email."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_email = gt_bp_email.
    ENDIF.

    IF rt_bp_email IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_email.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_email ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_fax.

    IF gt_bp_fax IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_fax " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_fax = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_fax     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_fax ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_fax."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_fax = gt_bp_fax.
    ENDIF.

    IF rt_bp_fax IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_fax.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_fax ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_header.

    IF gt_bp_header IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_header " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_header = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_header     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_header ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_header."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_header = gt_bp_header.
    ENDIF.

    IF rt_bp_header IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_header.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_header ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_hrchy.

    IF gt_bp_hrchy IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_hrchy " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_hrchy = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_hrchy     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_hrchy ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_hrchy."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_hrchy = gt_bp_hrchy.
    ENDIF.

    IF rt_bp_hrchy IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_hrchy.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_hrchy ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_idnum.

    IF gt_bp_idnum IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_idnum " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_idnum = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_idnum     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_idnum ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_idnum."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_idnum = gt_bp_idnum.
    ENDIF.

    IF rt_bp_idnum IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_idnum.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_idnum ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_indstr.

    IF gt_bp_indstr IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_indstr " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_indstr = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_indstr     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_indstr ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_indstr."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_indstr = gt_bp_indstr.
    ENDIF.

    IF rt_bp_indstr IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_indstr.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_indstr ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_mlt_ad.

    IF gt_bp_mlt_ad IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_mlt_ad " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_mlt_ad = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_mlt_ad     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_mlt_ad ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_mlt_ad."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_mlt_ad = gt_bp_mlt_ad.
    ENDIF.

    IF rt_bp_mlt_ad IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_mlt_ad.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_mlt_ad ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_mlt_as.

    IF gt_bp_mlt_as IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_mlt_as " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_mlt_as = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_mlt_as     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_mlt_as ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_mlt_as."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_mlt_as = gt_bp_mlt_as.
    ENDIF.

    IF rt_bp_mlt_as IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_mlt_as.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_mlt_as ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_porg.

    IF gt_bp_porg IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_porg " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_porg = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_porg     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_porg ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_porg."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_porg = gt_bp_porg.
    ENDIF.

    IF rt_bp_porg IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_porg.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_porg ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_porg2.

    IF gt_bp_porg2 IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_porg2 " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_porg2 = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_porg2     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_porg2 ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_porg2."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_porg2 = gt_bp_porg2.
    ENDIF.

    IF rt_bp_porg2 IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_porg2.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_porg2 ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_rel.

    IF gt_bp_rel IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_rel " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_rel = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_rel     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_rel ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_rel."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_rel = gt_bp_rel.
    ENDIF.

    IF rt_bp_rel IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_rel.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_rel ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_role.

    IF gt_bp_role IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_role " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_role = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_role     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_role ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_role."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_role = gt_bp_role.
    ENDIF.

    IF rt_bp_role IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_role.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_role ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_sales.

    IF gt_bp_sales IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_sales " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_sales = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_sales     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_sales ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_sales."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_sales = gt_bp_sales.
    ENDIF.

    IF rt_bp_sales IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_sales.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_sales ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_subhry.

    IF gt_bp_subhry IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_subhry " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_subhry = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_subhry     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_subhry ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_subhry."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_subhry = gt_bp_subhry.
    ENDIF.

    IF rt_bp_subhry IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_subhry.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_subhry ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_taxgrp.

    IF gt_bp_taxgrp IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_taxgrp " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_taxgrp = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_taxgrp     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_taxgrp ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_taxgrp."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_taxgrp = gt_bp_taxgrp.
    ENDIF.

    IF rt_bp_taxgrp IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_taxgrp.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_taxgrp ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_taxnum.

    IF gt_bp_taxnum IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_taxnum " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_taxnum = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_taxnum     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_taxnum ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_taxnum."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_taxnum = gt_bp_taxnum.
    ENDIF.

    IF rt_bp_taxnum IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_taxnum.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_taxnum ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_tax_ad.

    IF gt_bp_tax_ad IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_tax_ad " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_tax_ad = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_tax_ad     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_tax_ad ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_tax_ad."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_tax_ad = gt_bp_tax_ad.
    ENDIF.

    IF rt_bp_tax_ad IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_tax_ad.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_tax_ad ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_tel.

    IF gt_bp_tel IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_tel " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_tel = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_tel     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_tel ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_tel."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_tel = gt_bp_tel.
    ENDIF.

    IF rt_bp_tel IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_tel.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_tel ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_url.

    IF gt_bp_url IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_url " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_url = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_url     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_url ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_url."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_url = gt_bp_url.
    ENDIF.

    IF rt_bp_url IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_url.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_url ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_vencla.

    IF gt_bp_vencla IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_vencla " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_vencla = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_vencla     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_vencla ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_vencla."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_vencla = gt_bp_vencla.
    ENDIF.

    IF rt_bp_vencla IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_vencla.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_vencla ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_venddb.

    IF gt_bp_venddb IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_venddb " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_venddb = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_venddb     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_venddb ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_venddb."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_venddb = gt_bp_venddb.
    ENDIF.

    IF rt_bp_venddb IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_venddb.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_venddb ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_venfcn.

    IF gt_bp_venfcn IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_venfcn " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_venfcn = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_venfcn     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_venfcn ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_venfcn."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_venfcn = gt_bp_venfcn.
    ENDIF.

    IF rt_bp_venfcn IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_venfcn.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_venfcn ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_vengen.

    IF gt_bp_vengen IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_vengen " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_vengen = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_vengen     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_vengen ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_vengen."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_vengen = gt_bp_vengen.
    ENDIF.

    IF rt_bp_vengen IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_vengen.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_vengen ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_vensub.

    IF gt_bp_vensub IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_vensub " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_vensub = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_vensub     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_vensub ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_vensub."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_vensub = gt_bp_vensub.
    ENDIF.

    IF rt_bp_vensub IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_vensub.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_vensub ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_venval.

    IF gt_bp_venval IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_venval " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_venval = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_venval     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_venval ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_venval."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_venval = gt_bp_venval.
    ENDIF.

    IF rt_bp_venval IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_venval.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_venval ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_whtax.

    IF gt_bp_whtax IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_whtax " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_whtax = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_whtax     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_whtax ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_whtax."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_whtax = gt_bp_whtax.
    ENDIF.

    IF rt_bp_whtax IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_whtax.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_whtax ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bp_wpad.

    IF gt_bp_wpad IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_bp_wpad " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bp_wpad = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_bp_wpad     it_key_value = it_key_value ) ).
      LOOP AT gt_bp_wpad ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bp_wpad."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bp_wpad = gt_bp_wpad.
    ENDIF.

    IF rt_bp_wpad IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bp_wpad.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bp_wpad ).
    ENDIF.
  ENDMETHOD.


  METHOD get_fkklocks.

    IF gt_fkklocks IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_fkklocks " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_fkklocks = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_fkklocks     it_key_value = it_key_value ) ).
      LOOP AT gt_fkklocks ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_fkklocks."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_fkklocks = gt_fkklocks.
    ENDIF.

    IF rt_fkklocks IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_fkklocks.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_fkklocks ).
    ENDIF.
  ENDMETHOD.


  METHOD get_fkktaxex.

    IF gt_fkktaxex IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_fkktaxex " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_fkktaxex = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_fkktaxex     it_key_value = it_key_value ) ).
      LOOP AT gt_fkktaxex ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_fkktaxex."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_fkktaxex = gt_fkktaxex.
    ENDIF.

    IF rt_fkktaxex IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_fkktaxex.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_fkktaxex ).
    ENDIF.
  ENDMETHOD.


  METHOD get_fkktxt.

    IF gt_fkktxt IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_fkktxt " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_fkktxt = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_fkktxt     it_key_value = it_key_value ) ).
      LOOP AT gt_fkktxt ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_fkktxt."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_fkktxt = gt_fkktxt.
    ENDIF.

    IF rt_fkktxt IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_fkktxt.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_fkktxt ).
    ENDIF.
  ENDMETHOD.


  METHOD get_fkkvkp.

    IF gt_fkkvkp IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_fkkvkp " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_fkkvkp = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_fkkvkp     it_key_value = it_key_value ) ).
      LOOP AT gt_fkkvkp ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_fkkvkp."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_fkkvkp = gt_fkkvkp.
    ENDIF.

    IF rt_fkkvkp IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_fkkvkp.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_fkkvkp ).
    ENDIF.
  ENDMETHOD.


  METHOD get_fkkvktd.

    IF gt_fkkvktd IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_fkkvktd " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_fkkvktd = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_fkkvktd     it_key_value = it_key_value ) ).
      LOOP AT gt_fkkvktd ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_fkkvktd."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_fkkvktd = gt_fkkvktd.
    ENDIF.

    IF rt_fkkvktd IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_fkkvktd.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_fkkvktd ).
    ENDIF.
  ENDMETHOD.


  METHOD get_fs_bkk21.

    IF gt_fs_bkk21 IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_fs_bkk21 " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_fs_bkk21 = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_fs_bkk21     it_key_value = it_key_value ) ).
      LOOP AT gt_fs_bkk21 ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_fs_bkk21."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_fs_bkk21 = gt_fs_bkk21.
    ENDIF.

    IF rt_fs_bkk21 IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_fs_bkk21.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_fs_bkk21 ).
    ENDIF.
  ENDMETHOD.


  METHOD get_fs_bp001.

    IF gt_fs_bp001 IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_fs_bp001 " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_fs_bp001 = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_fs_bp001     it_key_value = it_key_value ) ).
      LOOP AT gt_fs_bp001 ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_fs_bp001."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_fs_bp001 = gt_fs_bp001.
    ENDIF.

    IF rt_fs_bp001 IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_fs_bp001.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_fs_bp001 ).
    ENDIF.
  ENDMETHOD.


  METHOD get_fs_bp011.

    IF gt_fs_bp011 IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_fs_bp011 " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_fs_bp011 = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_fs_bp011     it_key_value = it_key_value ) ).
      LOOP AT gt_fs_bp011 ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_fs_bp011."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_fs_bp011 = gt_fs_bp011.
    ENDIF.

    IF rt_fs_bp011 IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_fs_bp011.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_fs_bp011 ).
    ENDIF.
  ENDMETHOD.


  METHOD get_fs_bp021.

    IF gt_fs_bp021 IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_fs_bp021 " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_fs_bp021 = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_fs_bp021     it_key_value = it_key_value ) ).
      LOOP AT gt_fs_bp021 ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_fs_bp021."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_fs_bp021 = gt_fs_bp021.
    ENDIF.

    IF rt_fs_bp021 IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_fs_bp021.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_fs_bp021 ).
    ENDIF.
  ENDMETHOD.


  METHOD get_fs_bp1010.

    IF gt_fs_bp1010 IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_fs_bp1010 " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_fs_bp1010 = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_fs_bp1010     it_key_value = it_key_value ) ).
      LOOP AT gt_fs_bp1010 ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_fs_bp1010."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_fs_bp1010 = gt_fs_bp1010.
    ENDIF.

    IF rt_fs_bp1010 IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_fs_bp1010.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_fs_bp1010 ).
    ENDIF.
  ENDMETHOD.


  METHOD get_fs_bp1012.

    IF gt_fs_bp1012 IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_fs_bp1012 " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_fs_bp1012 = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_fs_bp1012     it_key_value = it_key_value ) ).
      LOOP AT gt_fs_bp1012 ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_fs_bp1012."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_fs_bp1012 = gt_fs_bp1012.
    ENDIF.

    IF rt_fs_bp1012 IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_fs_bp1012.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_fs_bp1012 ).
    ENDIF.
  ENDMETHOD.


  METHOD get_fs_bp1030.

    IF gt_fs_bp1030 IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_fs_bp1030 " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_fs_bp1030 = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_fs_bp1030     it_key_value = it_key_value ) ).
      LOOP AT gt_fs_bp1030 ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_fs_bp1030."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_fs_bp1030 = gt_fs_bp1030.
    ENDIF.

    IF rt_fs_bp1030 IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_fs_bp1030.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_fs_bp1030 ).
    ENDIF.
  ENDMETHOD.


  METHOD get_fs_bpbank.

    IF gt_fs_bpbank IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_fs_bpbank " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_fs_bpbank = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_fs_bpbank     it_key_value = it_key_value ) ).
      LOOP AT gt_fs_bpbank ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_fs_bpbank."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_fs_bpbank = gt_fs_bpbank.
    ENDIF.

    IF rt_fs_bpbank IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_fs_bpbank.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_fs_bpbank ).
    ENDIF.
  ENDMETHOD.


  METHOD get_fs_bptaxc.

    IF gt_fs_bptaxc IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_fs_bptaxc " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_fs_bptaxc = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_fs_bptaxc     it_key_value = it_key_value ) ).
      LOOP AT gt_fs_bptaxc ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_fs_bptaxc."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_fs_bptaxc = gt_fs_bptaxc.
    ENDIF.

    IF rt_fs_bptaxc IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_fs_bptaxc.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_fs_bptaxc ).
    ENDIF.
  ENDMETHOD.


  METHOD get_wp_email.

    IF gt_wp_email IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_wp_email " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_wp_email = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_wp_email     it_key_value = it_key_value ) ).
      LOOP AT gt_wp_email ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_wp_email."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_wp_email = gt_wp_email.
    ENDIF.

    IF rt_wp_email IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_wp_email.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_wp_email ).
    ENDIF.
  ENDMETHOD.


  METHOD get_wp_fax.

    IF gt_wp_fax IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_wp_fax " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_wp_fax = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_wp_fax     it_key_value = it_key_value ) ).
      LOOP AT gt_wp_fax ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_wp_fax."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_wp_fax = gt_wp_fax.
    ENDIF.

    IF rt_wp_fax IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_wp_fax.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_wp_fax ).
    ENDIF.
  ENDMETHOD.


  METHOD get_wp_postal.

    IF gt_wp_postal IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_wp_postal " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_wp_postal = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_wp_postal     it_key_value = it_key_value ) ).
      LOOP AT gt_wp_postal ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_wp_postal."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_wp_postal = gt_wp_postal.
    ENDIF.

    IF rt_wp_postal IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_wp_postal.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_wp_postal ).
    ENDIF.
  ENDMETHOD.


  METHOD get_wp_tel.

    IF gt_wp_tel IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_wp_tel " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_wp_tel = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_wp_tel     it_key_value = it_key_value ) ).
      LOOP AT gt_wp_tel ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_wp_tel."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_wp_tel = gt_wp_tel.
    ENDIF.

    IF rt_wp_tel IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_wp_tel.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_wp_tel ).
    ENDIF.
  ENDMETHOD.


  METHOD get_wp_url.

    IF gt_wp_url IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_wp_url " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_wp_url = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_wp_url     it_key_value = it_key_value ) ).
      LOOP AT gt_wp_url ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_wp_url."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_wp_url = gt_wp_url.
    ENDIF.

    IF rt_wp_url IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_wp_url.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_wp_url ).
    ENDIF.
  ENDMETHOD.


  METHOD set_address.

    DATA lt_address TYPE gty_t_address.

    MOVE-CORRESPONDING it_data TO lt_address.
    LOOP AT lt_address ASSIGNING FIELD-SYMBOL(<ls_address>).
      READ TABLE gt_address FROM <ls_address> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_address FROM <ls_address>.
      ELSE.
        INSERT <ls_address> INTO TABLE gt_address.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_address
            is_record = <ls_address>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_ad_email.

    DATA lt_ad_email TYPE gty_t_ad_email.

    MOVE-CORRESPONDING it_data TO lt_ad_email.
    LOOP AT lt_ad_email ASSIGNING FIELD-SYMBOL(<ls_ad_email>).
      READ TABLE gt_ad_email FROM <ls_ad_email> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_ad_email FROM <ls_ad_email>.
      ELSE.
        INSERT <ls_ad_email> INTO TABLE gt_ad_email.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_ad_email
            is_record = <ls_ad_email>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_ad_fax.

    DATA lt_ad_fax TYPE gty_t_ad_fax.

    MOVE-CORRESPONDING it_data TO lt_ad_fax.
    LOOP AT lt_ad_fax ASSIGNING FIELD-SYMBOL(<ls_ad_fax>).
      READ TABLE gt_ad_fax FROM <ls_ad_fax> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_ad_fax FROM <ls_ad_fax>.
      ELSE.
        INSERT <ls_ad_fax> INTO TABLE gt_ad_fax.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_ad_fax
            is_record = <ls_ad_fax>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_ad_name_o.

    DATA lt_ad_name_o TYPE gty_t_ad_name_o.

    MOVE-CORRESPONDING it_data TO lt_ad_name_o.
    LOOP AT lt_ad_name_o ASSIGNING FIELD-SYMBOL(<ls_ad_name_o>).
      READ TABLE gt_ad_name_o FROM <ls_ad_name_o> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_ad_name_o FROM <ls_ad_name_o>.
      ELSE.
        INSERT <ls_ad_name_o> INTO TABLE gt_ad_name_o.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_ad_name_o
            is_record = <ls_ad_name_o>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_ad_name_p.

    DATA lt_ad_name_p TYPE gty_t_ad_name_p.

    MOVE-CORRESPONDING it_data TO lt_ad_name_p.
    LOOP AT lt_ad_name_p ASSIGNING FIELD-SYMBOL(<ls_ad_name_p>).
      READ TABLE gt_ad_name_p FROM <ls_ad_name_p> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_ad_name_p FROM <ls_ad_name_p>.
      ELSE.
        INSERT <ls_ad_name_p> INTO TABLE gt_ad_name_p.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_ad_name_p
            is_record = <ls_ad_name_p>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_ad_postal.

    DATA lt_ad_postal TYPE gty_t_ad_postal.

    MOVE-CORRESPONDING it_data TO lt_ad_postal.
    LOOP AT lt_ad_postal ASSIGNING FIELD-SYMBOL(<ls_ad_postal>).
      READ TABLE gt_ad_postal FROM <ls_ad_postal> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_ad_postal FROM <ls_ad_postal>.
      ELSE.
        INSERT <ls_ad_postal> INTO TABLE gt_ad_postal.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_ad_postal
            is_record = <ls_ad_postal>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_ad_tel.

    DATA lt_ad_tel TYPE gty_t_ad_tel.

    MOVE-CORRESPONDING it_data TO lt_ad_tel.
    LOOP AT lt_ad_tel ASSIGNING FIELD-SYMBOL(<ls_ad_tel>).
      READ TABLE gt_ad_tel FROM <ls_ad_tel> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_ad_tel FROM <ls_ad_tel>.
      ELSE.
        INSERT <ls_ad_tel> INTO TABLE gt_ad_tel.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_ad_tel
            is_record = <ls_ad_tel>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_ad_url.

    DATA lt_ad_url TYPE gty_t_ad_url.

    MOVE-CORRESPONDING it_data TO lt_ad_url.
    LOOP AT lt_ad_url ASSIGNING FIELD-SYMBOL(<ls_ad_url>).
      READ TABLE gt_ad_url FROM <ls_ad_url> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_ad_url FROM <ls_ad_url>.
      ELSE.
        INSERT <ls_ad_url> INTO TABLE gt_ad_url.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_ad_url
            is_record = <ls_ad_url>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_adddep.

    DATA lt_bp_adddep TYPE gty_t_bp_adddep.

    MOVE-CORRESPONDING it_data TO lt_bp_adddep.
    LOOP AT lt_bp_adddep ASSIGNING FIELD-SYMBOL(<ls_bp_adddep>).
      READ TABLE gt_bp_adddep FROM <ls_bp_adddep> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_adddep FROM <ls_bp_adddep>.
      ELSE.
        INSERT <ls_bp_adddep> INTO TABLE gt_bp_adddep.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_adddep
            is_record = <ls_bp_adddep>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_addr.

    DATA lt_bp_addr TYPE gty_t_bp_addr.

    MOVE-CORRESPONDING it_data TO lt_bp_addr.
    LOOP AT lt_bp_addr ASSIGNING FIELD-SYMBOL(<ls_bp_addr>).
      READ TABLE gt_bp_addr FROM <ls_bp_addr> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_addr FROM <ls_bp_addr>.
      ELSE.
        INSERT <ls_bp_addr> INTO TABLE gt_bp_addr.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_addr
            is_record = <ls_bp_addr>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_addusg.

    DATA lt_bp_addusg TYPE gty_t_bp_addusg.

    MOVE-CORRESPONDING it_data TO lt_bp_addusg.
    LOOP AT lt_bp_addusg ASSIGNING FIELD-SYMBOL(<ls_bp_addusg>).
      READ TABLE gt_bp_addusg FROM <ls_bp_addusg> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_addusg FROM <ls_bp_addusg>.
      ELSE.
        INSERT <ls_bp_addusg> INTO TABLE gt_bp_addusg.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_addusg
            is_record = <ls_bp_addusg>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_bkdtl.

    DATA lt_bp_bkdtl TYPE gty_t_bp_bkdtl.

    MOVE-CORRESPONDING it_data TO lt_bp_bkdtl.
    LOOP AT lt_bp_bkdtl ASSIGNING FIELD-SYMBOL(<ls_bp_bkdtl>).
      READ TABLE gt_bp_bkdtl FROM <ls_bp_bkdtl> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_bkdtl FROM <ls_bp_bkdtl>.
      ELSE.
        INSERT <ls_bp_bkdtl> INTO TABLE gt_bp_bkdtl.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_bkdtl
            is_record = <ls_bp_bkdtl>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_ccdtl.

    DATA lt_bp_ccdtl TYPE gty_t_bp_ccdtl.

    MOVE-CORRESPONDING it_data TO lt_bp_ccdtl.
    LOOP AT lt_bp_ccdtl ASSIGNING FIELD-SYMBOL(<ls_bp_ccdtl>).
      READ TABLE gt_bp_ccdtl FROM <ls_bp_ccdtl> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_ccdtl FROM <ls_bp_ccdtl>.
      ELSE.
        INSERT <ls_bp_ccdtl> INTO TABLE gt_bp_ccdtl.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_ccdtl
            is_record = <ls_bp_ccdtl>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_centrl.

    DATA lt_bp_centrl TYPE gty_t_bp_centrl.

    MOVE-CORRESPONDING it_data TO lt_bp_centrl.
    LOOP AT lt_bp_centrl ASSIGNING FIELD-SYMBOL(<ls_bp_centrl>).
      READ TABLE gt_bp_centrl FROM <ls_bp_centrl> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_centrl FROM <ls_bp_centrl>.
      ELSE.
        INSERT <ls_bp_centrl> INTO TABLE gt_bp_centrl.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_centrl
            is_record = <ls_bp_centrl>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_compny.

    DATA lt_bp_compny TYPE gty_t_bp_compny.

    MOVE-CORRESPONDING it_data TO lt_bp_compny.
    LOOP AT lt_bp_compny ASSIGNING FIELD-SYMBOL(<ls_bp_compny>).
      READ TABLE gt_bp_compny FROM <ls_bp_compny> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_compny FROM <ls_bp_compny>.
      ELSE.
        INSERT <ls_bp_compny> INTO TABLE gt_bp_compny.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_compny
            is_record = <ls_bp_compny>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_cpgen.

    DATA lt_bp_cpgen TYPE gty_t_bp_cpgen.

    MOVE-CORRESPONDING it_data TO lt_bp_cpgen.
    LOOP AT lt_bp_cpgen ASSIGNING FIELD-SYMBOL(<ls_bp_cpgen>).
      READ TABLE gt_bp_cpgen FROM <ls_bp_cpgen> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_cpgen FROM <ls_bp_cpgen>.
      ELSE.
        INSERT <ls_bp_cpgen> INTO TABLE gt_bp_cpgen.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_cpgen
            is_record = <ls_bp_cpgen>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_cuscla.

    DATA lt_bp_cuscla TYPE gty_t_bp_cuscla.

    MOVE-CORRESPONDING it_data TO lt_bp_cuscla.
    LOOP AT lt_bp_cuscla ASSIGNING FIELD-SYMBOL(<ls_bp_cuscla>).
      READ TABLE gt_bp_cuscla FROM <ls_bp_cuscla> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_cuscla FROM <ls_bp_cuscla>.
      ELSE.
        INSERT <ls_bp_cuscla> INTO TABLE gt_bp_cuscla.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_cuscla
            is_record = <ls_bp_cuscla>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_cusddb.

    DATA lt_bp_cusddb TYPE gty_t_bp_cusddb.

    MOVE-CORRESPONDING it_data TO lt_bp_cusddb.
    LOOP AT lt_bp_cusddb ASSIGNING FIELD-SYMBOL(<ls_bp_cusddb>).
      READ TABLE gt_bp_cusddb FROM <ls_bp_cusddb> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_cusddb FROM <ls_bp_cusddb>.
      ELSE.
        INSERT <ls_bp_cusddb> INTO TABLE gt_bp_cusddb.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_cusddb
            is_record = <ls_bp_cusddb>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_cusdun.

    DATA lt_bp_cusdun TYPE gty_t_bp_cusdun.

    MOVE-CORRESPONDING it_data TO lt_bp_cusdun.
    LOOP AT lt_bp_cusdun ASSIGNING FIELD-SYMBOL(<ls_bp_cusdun>).
      READ TABLE gt_bp_cusdun FROM <ls_bp_cusdun> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_cusdun FROM <ls_bp_cusdun>.
      ELSE.
        INSERT <ls_bp_cusdun> INTO TABLE gt_bp_cusdun.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_cusdun
            is_record = <ls_bp_cusdun>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_cusfcn.

    DATA lt_bp_cusfcn TYPE gty_t_bp_cusfcn.

    MOVE-CORRESPONDING it_data TO lt_bp_cusfcn.
    LOOP AT lt_bp_cusfcn ASSIGNING FIELD-SYMBOL(<ls_bp_cusfcn>).
      READ TABLE gt_bp_cusfcn FROM <ls_bp_cusfcn> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_cusfcn FROM <ls_bp_cusfcn>.
      ELSE.
        INSERT <ls_bp_cusfcn> INTO TABLE gt_bp_cusfcn.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_cusfcn
            is_record = <ls_bp_cusfcn>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_cusgen.

    DATA lt_bp_cusgen TYPE gty_t_bp_cusgen.

    MOVE-CORRESPONDING it_data TO lt_bp_cusgen.
    LOOP AT lt_bp_cusgen ASSIGNING FIELD-SYMBOL(<ls_bp_cusgen>).
      READ TABLE gt_bp_cusgen FROM <ls_bp_cusgen> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_cusgen FROM <ls_bp_cusgen>.
      ELSE.
        INSERT <ls_bp_cusgen> INTO TABLE gt_bp_cusgen.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_cusgen
            is_record = <ls_bp_cusgen>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_custax.

    DATA lt_bp_custax TYPE gty_t_bp_custax.

    MOVE-CORRESPONDING it_data TO lt_bp_custax.
    LOOP AT lt_bp_custax ASSIGNING FIELD-SYMBOL(<ls_bp_custax>).
      READ TABLE gt_bp_custax FROM <ls_bp_custax> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_custax FROM <ls_bp_custax>.
      ELSE.
        INSERT <ls_bp_custax> INTO TABLE gt_bp_custax.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_custax
            is_record = <ls_bp_custax>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_cusulp.

    DATA lt_bp_cusulp TYPE gty_t_bp_cusulp.

    MOVE-CORRESPONDING it_data TO lt_bp_cusulp.
    LOOP AT lt_bp_cusulp ASSIGNING FIELD-SYMBOL(<ls_bp_cusulp>).
      READ TABLE gt_bp_cusulp FROM <ls_bp_cusulp> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_cusulp FROM <ls_bp_cusulp>.
      ELSE.
        INSERT <ls_bp_cusulp> INTO TABLE gt_bp_cusulp.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_cusulp
            is_record = <ls_bp_cusulp>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_cusval.

    DATA lt_bp_cusval TYPE gty_t_bp_cusval.

    MOVE-CORRESPONDING it_data TO lt_bp_cusval.
    LOOP AT lt_bp_cusval ASSIGNING FIELD-SYMBOL(<ls_bp_cusval>).
      READ TABLE gt_bp_cusval FROM <ls_bp_cusval> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_cusval FROM <ls_bp_cusval>.
      ELSE.
        INSERT <ls_bp_cusval> INTO TABLE gt_bp_cusval.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_cusval
            is_record = <ls_bp_cusval>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_cuswht.

    DATA lt_bp_cuswht TYPE gty_t_bp_cuswht.

    MOVE-CORRESPONDING it_data TO lt_bp_cuswht.
    LOOP AT lt_bp_cuswht ASSIGNING FIELD-SYMBOL(<ls_bp_cuswht>).
      READ TABLE gt_bp_cuswht FROM <ls_bp_cuswht> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_cuswht FROM <ls_bp_cuswht>.
      ELSE.
        INSERT <ls_bp_cuswht> INTO TABLE gt_bp_cuswht.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_cuswht
            is_record = <ls_bp_cuswht>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_cus_cc.

    DATA lt_bp_cus_cc TYPE gty_t_bp_cus_cc.

    MOVE-CORRESPONDING it_data TO lt_bp_cus_cc.
    LOOP AT lt_bp_cus_cc ASSIGNING FIELD-SYMBOL(<ls_bp_cus_cc>).
      READ TABLE gt_bp_cus_cc FROM <ls_bp_cus_cc> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_cus_cc FROM <ls_bp_cus_cc>.
      ELSE.
        INSERT <ls_bp_cus_cc> INTO TABLE gt_bp_cus_cc.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_cus_cc
            is_record = <ls_bp_cus_cc>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_dunn.

    DATA lt_bp_dunn TYPE gty_t_bp_dunn.

    MOVE-CORRESPONDING it_data TO lt_bp_dunn.
    LOOP AT lt_bp_dunn ASSIGNING FIELD-SYMBOL(<ls_bp_dunn>).
      READ TABLE gt_bp_dunn FROM <ls_bp_dunn> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_dunn FROM <ls_bp_dunn>.
      ELSE.
        INSERT <ls_bp_dunn> INTO TABLE gt_bp_dunn.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_dunn
            is_record = <ls_bp_dunn>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_email.

    DATA lt_bp_email TYPE gty_t_bp_email.

    MOVE-CORRESPONDING it_data TO lt_bp_email.
    LOOP AT lt_bp_email ASSIGNING FIELD-SYMBOL(<ls_bp_email>).
      READ TABLE gt_bp_email FROM <ls_bp_email> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_email FROM <ls_bp_email>.
      ELSE.
        INSERT <ls_bp_email> INTO TABLE gt_bp_email.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_email
            is_record = <ls_bp_email>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_fax.

    DATA lt_bp_fax TYPE gty_t_bp_fax.

    MOVE-CORRESPONDING it_data TO lt_bp_fax.
    LOOP AT lt_bp_fax ASSIGNING FIELD-SYMBOL(<ls_bp_fax>).
      READ TABLE gt_bp_fax FROM <ls_bp_fax> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_fax FROM <ls_bp_fax>.
      ELSE.
        INSERT <ls_bp_fax> INTO TABLE gt_bp_fax.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_fax
            is_record = <ls_bp_fax>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_header.

    DATA lt_bp_header TYPE gty_t_bp_header.

    MOVE-CORRESPONDING it_data TO lt_bp_header.
    LOOP AT lt_bp_header ASSIGNING FIELD-SYMBOL(<ls_bp_header>).
      READ TABLE gt_bp_header FROM <ls_bp_header> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_header FROM <ls_bp_header>.
      ELSE.
        INSERT <ls_bp_header> INTO TABLE gt_bp_header.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_header
            is_record = <ls_bp_header>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_hrchy.

    DATA lt_bp_hrchy TYPE gty_t_bp_hrchy.

    MOVE-CORRESPONDING it_data TO lt_bp_hrchy.
    LOOP AT lt_bp_hrchy ASSIGNING FIELD-SYMBOL(<ls_bp_hrchy>).
      READ TABLE gt_bp_hrchy FROM <ls_bp_hrchy> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_hrchy FROM <ls_bp_hrchy>.
      ELSE.
        INSERT <ls_bp_hrchy> INTO TABLE gt_bp_hrchy.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_hrchy
            is_record = <ls_bp_hrchy>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_idnum.

    DATA lt_bp_idnum TYPE gty_t_bp_idnum.

    MOVE-CORRESPONDING it_data TO lt_bp_idnum.
    LOOP AT lt_bp_idnum ASSIGNING FIELD-SYMBOL(<ls_bp_idnum>).
      READ TABLE gt_bp_idnum FROM <ls_bp_idnum> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_idnum FROM <ls_bp_idnum>.
      ELSE.
        INSERT <ls_bp_idnum> INTO TABLE gt_bp_idnum.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_idnum
            is_record = <ls_bp_idnum>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_indstr.

    DATA lt_bp_indstr TYPE gty_t_bp_indstr.

    MOVE-CORRESPONDING it_data TO lt_bp_indstr.
    LOOP AT lt_bp_indstr ASSIGNING FIELD-SYMBOL(<ls_bp_indstr>).
      READ TABLE gt_bp_indstr FROM <ls_bp_indstr> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_indstr FROM <ls_bp_indstr>.
      ELSE.
        INSERT <ls_bp_indstr> INTO TABLE gt_bp_indstr.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_indstr
            is_record = <ls_bp_indstr>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_mlt_ad.

    DATA lt_bp_mlt_ad TYPE gty_t_bp_mlt_ad.

    MOVE-CORRESPONDING it_data TO lt_bp_mlt_ad.
    LOOP AT lt_bp_mlt_ad ASSIGNING FIELD-SYMBOL(<ls_bp_mlt_ad>).
      READ TABLE gt_bp_mlt_ad FROM <ls_bp_mlt_ad> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_mlt_ad FROM <ls_bp_mlt_ad>.
      ELSE.
        INSERT <ls_bp_mlt_ad> INTO TABLE gt_bp_mlt_ad.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_mlt_ad
            is_record = <ls_bp_mlt_ad>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_mlt_as.

    DATA lt_bp_mlt_as TYPE gty_t_bp_mlt_as.

    MOVE-CORRESPONDING it_data TO lt_bp_mlt_as.
    LOOP AT lt_bp_mlt_as ASSIGNING FIELD-SYMBOL(<ls_bp_mlt_as>).
      READ TABLE gt_bp_mlt_as FROM <ls_bp_mlt_as> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_mlt_as FROM <ls_bp_mlt_as>.
      ELSE.
        INSERT <ls_bp_mlt_as> INTO TABLE gt_bp_mlt_as.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_mlt_as
            is_record = <ls_bp_mlt_as>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_porg.

    DATA lt_bp_porg TYPE gty_t_bp_porg.

    MOVE-CORRESPONDING it_data TO lt_bp_porg.
    LOOP AT lt_bp_porg ASSIGNING FIELD-SYMBOL(<ls_bp_porg>).
      READ TABLE gt_bp_porg FROM <ls_bp_porg> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_porg FROM <ls_bp_porg>.
      ELSE.
        INSERT <ls_bp_porg> INTO TABLE gt_bp_porg.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_porg
            is_record = <ls_bp_porg>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_porg2.

    DATA lt_bp_porg2 TYPE gty_t_bp_porg2.

    MOVE-CORRESPONDING it_data TO lt_bp_porg2.
    LOOP AT lt_bp_porg2 ASSIGNING FIELD-SYMBOL(<ls_bp_porg2>).
      READ TABLE gt_bp_porg2 FROM <ls_bp_porg2> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_porg2 FROM <ls_bp_porg2>.
      ELSE.
        INSERT <ls_bp_porg2> INTO TABLE gt_bp_porg2.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_porg2
            is_record = <ls_bp_porg2>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_rel.

    DATA lt_bp_rel TYPE gty_t_bp_rel.

    MOVE-CORRESPONDING it_data TO lt_bp_rel.
    LOOP AT lt_bp_rel ASSIGNING FIELD-SYMBOL(<ls_bp_rel>).
      READ TABLE gt_bp_rel FROM <ls_bp_rel> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_rel FROM <ls_bp_rel>.
      ELSE.
        INSERT <ls_bp_rel> INTO TABLE gt_bp_rel.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_rel
            is_record = <ls_bp_rel>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_role.

    DATA lt_bp_role TYPE gty_t_bp_role.

    MOVE-CORRESPONDING it_data TO lt_bp_role.
    LOOP AT lt_bp_role ASSIGNING FIELD-SYMBOL(<ls_bp_role>).
      READ TABLE gt_bp_role FROM <ls_bp_role> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_role FROM <ls_bp_role>.
      ELSE.
        INSERT <ls_bp_role> INTO TABLE gt_bp_role.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_role
            is_record = <ls_bp_role>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_sales.

    DATA lt_bp_sales TYPE gty_t_bp_sales.

    MOVE-CORRESPONDING it_data TO lt_bp_sales.
    LOOP AT lt_bp_sales ASSIGNING FIELD-SYMBOL(<ls_bp_sales>).
      READ TABLE gt_bp_sales FROM <ls_bp_sales> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_sales FROM <ls_bp_sales>.
      ELSE.
        INSERT <ls_bp_sales> INTO TABLE gt_bp_sales.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_sales
            is_record = <ls_bp_sales>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_subhry.

    DATA lt_bp_subhry TYPE gty_t_bp_subhry.

    MOVE-CORRESPONDING it_data TO lt_bp_subhry.
    LOOP AT lt_bp_subhry ASSIGNING FIELD-SYMBOL(<ls_bp_subhry>).
      READ TABLE gt_bp_subhry FROM <ls_bp_subhry> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_subhry FROM <ls_bp_subhry>.
      ELSE.
        INSERT <ls_bp_subhry> INTO TABLE gt_bp_subhry.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_subhry
            is_record = <ls_bp_subhry>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_taxgrp.

    DATA lt_bp_taxgrp TYPE gty_t_bp_taxgrp.

    MOVE-CORRESPONDING it_data TO lt_bp_taxgrp.
    LOOP AT lt_bp_taxgrp ASSIGNING FIELD-SYMBOL(<ls_bp_taxgrp>).
      READ TABLE gt_bp_taxgrp FROM <ls_bp_taxgrp> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_taxgrp FROM <ls_bp_taxgrp>.
      ELSE.
        INSERT <ls_bp_taxgrp> INTO TABLE gt_bp_taxgrp.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_taxgrp
            is_record = <ls_bp_taxgrp>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_taxnum.

    DATA lt_bp_taxnum TYPE gty_t_bp_taxnum.

    MOVE-CORRESPONDING it_data TO lt_bp_taxnum.
    LOOP AT lt_bp_taxnum ASSIGNING FIELD-SYMBOL(<ls_bp_taxnum>).
      READ TABLE gt_bp_taxnum FROM <ls_bp_taxnum> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_taxnum FROM <ls_bp_taxnum>.
      ELSE.
        INSERT <ls_bp_taxnum> INTO TABLE gt_bp_taxnum.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_taxnum
            is_record = <ls_bp_taxnum>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_tax_ad.

    DATA lt_bp_tax_ad TYPE gty_t_bp_tax_ad.

    MOVE-CORRESPONDING it_data TO lt_bp_tax_ad.
    LOOP AT lt_bp_tax_ad ASSIGNING FIELD-SYMBOL(<ls_bp_tax_ad>).
      READ TABLE gt_bp_tax_ad FROM <ls_bp_tax_ad> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_tax_ad FROM <ls_bp_tax_ad>.
      ELSE.
        INSERT <ls_bp_tax_ad> INTO TABLE gt_bp_tax_ad.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_tax_ad
            is_record = <ls_bp_tax_ad>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_tel.

    DATA lt_bp_tel TYPE gty_t_bp_tel.

    MOVE-CORRESPONDING it_data TO lt_bp_tel.
    LOOP AT lt_bp_tel ASSIGNING FIELD-SYMBOL(<ls_bp_tel>).
      READ TABLE gt_bp_tel FROM <ls_bp_tel> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_tel FROM <ls_bp_tel>.
      ELSE.
        INSERT <ls_bp_tel> INTO TABLE gt_bp_tel.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_tel
            is_record = <ls_bp_tel>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_url.

    DATA lt_bp_url TYPE gty_t_bp_url.

    MOVE-CORRESPONDING it_data TO lt_bp_url.
    LOOP AT lt_bp_url ASSIGNING FIELD-SYMBOL(<ls_bp_url>).
      READ TABLE gt_bp_url FROM <ls_bp_url> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_url FROM <ls_bp_url>.
      ELSE.
        INSERT <ls_bp_url> INTO TABLE gt_bp_url.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_url
            is_record = <ls_bp_url>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_vencla.

    DATA lt_bp_vencla TYPE gty_t_bp_vencla.

    MOVE-CORRESPONDING it_data TO lt_bp_vencla.
    LOOP AT lt_bp_vencla ASSIGNING FIELD-SYMBOL(<ls_bp_vencla>).
      READ TABLE gt_bp_vencla FROM <ls_bp_vencla> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_vencla FROM <ls_bp_vencla>.
      ELSE.
        INSERT <ls_bp_vencla> INTO TABLE gt_bp_vencla.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_vencla
            is_record = <ls_bp_vencla>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_venddb.

    DATA lt_bp_venddb TYPE gty_t_bp_venddb.

    MOVE-CORRESPONDING it_data TO lt_bp_venddb.
    LOOP AT lt_bp_venddb ASSIGNING FIELD-SYMBOL(<ls_bp_venddb>).
      READ TABLE gt_bp_venddb FROM <ls_bp_venddb> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_venddb FROM <ls_bp_venddb>.
      ELSE.
        INSERT <ls_bp_venddb> INTO TABLE gt_bp_venddb.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_venddb
            is_record = <ls_bp_venddb>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_venfcn.

    DATA lt_bp_venfcn TYPE gty_t_bp_venfcn.

    MOVE-CORRESPONDING it_data TO lt_bp_venfcn.
    LOOP AT lt_bp_venfcn ASSIGNING FIELD-SYMBOL(<ls_bp_venfcn>).
      READ TABLE gt_bp_venfcn FROM <ls_bp_venfcn> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_venfcn FROM <ls_bp_venfcn>.
      ELSE.
        INSERT <ls_bp_venfcn> INTO TABLE gt_bp_venfcn.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_venfcn
            is_record = <ls_bp_venfcn>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_vengen.

    DATA lt_bp_vengen TYPE gty_t_bp_vengen.

    MOVE-CORRESPONDING it_data TO lt_bp_vengen.
    LOOP AT lt_bp_vengen ASSIGNING FIELD-SYMBOL(<ls_bp_vengen>).
      READ TABLE gt_bp_vengen FROM <ls_bp_vengen> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_vengen FROM <ls_bp_vengen>.
      ELSE.
        INSERT <ls_bp_vengen> INTO TABLE gt_bp_vengen.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_vengen
            is_record = <ls_bp_vengen>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_vensub.

    DATA lt_bp_vensub TYPE gty_t_bp_vensub.

    MOVE-CORRESPONDING it_data TO lt_bp_vensub.
    LOOP AT lt_bp_vensub ASSIGNING FIELD-SYMBOL(<ls_bp_vensub>).
      READ TABLE gt_bp_vensub FROM <ls_bp_vensub> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_vensub FROM <ls_bp_vensub>.
      ELSE.
        INSERT <ls_bp_vensub> INTO TABLE gt_bp_vensub.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_vensub
            is_record = <ls_bp_vensub>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_venval.

    DATA lt_bp_venval TYPE gty_t_bp_venval.

    MOVE-CORRESPONDING it_data TO lt_bp_venval.
    LOOP AT lt_bp_venval ASSIGNING FIELD-SYMBOL(<ls_bp_venval>).
      READ TABLE gt_bp_venval FROM <ls_bp_venval> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_venval FROM <ls_bp_venval>.
      ELSE.
        INSERT <ls_bp_venval> INTO TABLE gt_bp_venval.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_venval
            is_record = <ls_bp_venval>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_whtax.

    DATA lt_bp_whtax TYPE gty_t_bp_whtax.

    MOVE-CORRESPONDING it_data TO lt_bp_whtax.
    LOOP AT lt_bp_whtax ASSIGNING FIELD-SYMBOL(<ls_bp_whtax>).
      READ TABLE gt_bp_whtax FROM <ls_bp_whtax> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_whtax FROM <ls_bp_whtax>.
      ELSE.
        INSERT <ls_bp_whtax> INTO TABLE gt_bp_whtax.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_whtax
            is_record = <ls_bp_whtax>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bp_wpad.

    DATA lt_bp_wpad TYPE gty_t_bp_wpad.

    MOVE-CORRESPONDING it_data TO lt_bp_wpad.
    LOOP AT lt_bp_wpad ASSIGNING FIELD-SYMBOL(<ls_bp_wpad>).
      READ TABLE gt_bp_wpad FROM <ls_bp_wpad> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bp_wpad FROM <ls_bp_wpad>.
      ELSE.
        INSERT <ls_bp_wpad> INTO TABLE gt_bp_wpad.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_bp_wpad
            is_record = <ls_bp_wpad>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_fkklocks.

    DATA lt_fkklocks TYPE gty_t_fkklocks.

    MOVE-CORRESPONDING it_data TO lt_fkklocks.
    LOOP AT lt_fkklocks ASSIGNING FIELD-SYMBOL(<ls_fkklocks>).
      READ TABLE gt_fkklocks FROM <ls_fkklocks> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_fkklocks FROM <ls_fkklocks>.
      ELSE.
        INSERT <ls_fkklocks> INTO TABLE gt_fkklocks.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_fkklocks
            is_record = <ls_fkklocks>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_fkktaxex.

    DATA lt_fkktaxex TYPE gty_t_fkktaxex.

    MOVE-CORRESPONDING it_data TO lt_fkktaxex.
    LOOP AT lt_fkktaxex ASSIGNING FIELD-SYMBOL(<ls_fkktaxex>).
      READ TABLE gt_fkktaxex FROM <ls_fkktaxex> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_fkktaxex FROM <ls_fkktaxex>.
      ELSE.
        INSERT <ls_fkktaxex> INTO TABLE gt_fkktaxex.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_fkktaxex
            is_record = <ls_fkktaxex>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_fkktxt.

    DATA lt_fkktxt TYPE gty_t_fkktxt.

    MOVE-CORRESPONDING it_data TO lt_fkktxt.
    LOOP AT lt_fkktxt ASSIGNING FIELD-SYMBOL(<ls_fkktxt>).
      READ TABLE gt_fkktxt FROM <ls_fkktxt> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_fkktxt FROM <ls_fkktxt>.
      ELSE.
        INSERT <ls_fkktxt> INTO TABLE gt_fkktxt.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_fkktxt
            is_record = <ls_fkktxt>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_fkkvkp.

    DATA lt_fkkvkp TYPE gty_t_fkkvkp.

    MOVE-CORRESPONDING it_data TO lt_fkkvkp.
    LOOP AT lt_fkkvkp ASSIGNING FIELD-SYMBOL(<ls_fkkvkp>).
      READ TABLE gt_fkkvkp FROM <ls_fkkvkp> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_fkkvkp FROM <ls_fkkvkp>.
      ELSE.
        INSERT <ls_fkkvkp> INTO TABLE gt_fkkvkp.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_fkkvkp
            is_record = <ls_fkkvkp>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_fkkvktd.

    DATA lt_fkkvktd TYPE gty_t_fkkvktd.

    MOVE-CORRESPONDING it_data TO lt_fkkvktd.
    LOOP AT lt_fkkvktd ASSIGNING FIELD-SYMBOL(<ls_fkkvktd>).
      READ TABLE gt_fkkvktd FROM <ls_fkkvktd> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_fkkvktd FROM <ls_fkkvktd>.
      ELSE.
        INSERT <ls_fkkvktd> INTO TABLE gt_fkkvktd.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_fkkvktd
            is_record = <ls_fkkvktd>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_fs_bkk21.

    DATA lt_fs_bkk21 TYPE gty_t_fs_bkk21.

    MOVE-CORRESPONDING it_data TO lt_fs_bkk21.
    LOOP AT lt_fs_bkk21 ASSIGNING FIELD-SYMBOL(<ls_fs_bkk21>).
      READ TABLE gt_fs_bkk21 FROM <ls_fs_bkk21> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_fs_bkk21 FROM <ls_fs_bkk21>.
      ELSE.
        INSERT <ls_fs_bkk21> INTO TABLE gt_fs_bkk21.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_fs_bkk21
            is_record = <ls_fs_bkk21>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_fs_bp001.

    DATA lt_fs_bp001 TYPE gty_t_fs_bp001.

    MOVE-CORRESPONDING it_data TO lt_fs_bp001.
    LOOP AT lt_fs_bp001 ASSIGNING FIELD-SYMBOL(<ls_fs_bp001>).
      READ TABLE gt_fs_bp001 FROM <ls_fs_bp001> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_fs_bp001 FROM <ls_fs_bp001>.
      ELSE.
        INSERT <ls_fs_bp001> INTO TABLE gt_fs_bp001.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_fs_bp001
            is_record = <ls_fs_bp001>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_fs_bp011.

    DATA lt_fs_bp011 TYPE gty_t_fs_bp011.

    MOVE-CORRESPONDING it_data TO lt_fs_bp011.
    LOOP AT lt_fs_bp011 ASSIGNING FIELD-SYMBOL(<ls_fs_bp011>).
      READ TABLE gt_fs_bp011 FROM <ls_fs_bp011> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_fs_bp011 FROM <ls_fs_bp011>.
      ELSE.
        INSERT <ls_fs_bp011> INTO TABLE gt_fs_bp011.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_fs_bp011
            is_record = <ls_fs_bp011>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_fs_bp021.

    DATA lt_fs_bp021 TYPE gty_t_fs_bp021.

    MOVE-CORRESPONDING it_data TO lt_fs_bp021.
    LOOP AT lt_fs_bp021 ASSIGNING FIELD-SYMBOL(<ls_fs_bp021>).
      READ TABLE gt_fs_bp021 FROM <ls_fs_bp021> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_fs_bp021 FROM <ls_fs_bp021>.
      ELSE.
        INSERT <ls_fs_bp021> INTO TABLE gt_fs_bp021.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_fs_bp021
            is_record = <ls_fs_bp021>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_fs_bp1010.

    DATA lt_fs_bp1010 TYPE gty_t_fs_bp1010.

    MOVE-CORRESPONDING it_data TO lt_fs_bp1010.
    LOOP AT lt_fs_bp1010 ASSIGNING FIELD-SYMBOL(<ls_fs_bp1010>).
      READ TABLE gt_fs_bp1010 FROM <ls_fs_bp1010> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_fs_bp1010 FROM <ls_fs_bp1010>.
      ELSE.
        INSERT <ls_fs_bp1010> INTO TABLE gt_fs_bp1010.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_fs_bp1010
            is_record = <ls_fs_bp1010>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_fs_bp1012.

    DATA lt_fs_bp1012 TYPE gty_t_fs_bp1012.

    MOVE-CORRESPONDING it_data TO lt_fs_bp1012.
    LOOP AT lt_fs_bp1012 ASSIGNING FIELD-SYMBOL(<ls_fs_bp1012>).
      READ TABLE gt_fs_bp1012 FROM <ls_fs_bp1012> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_fs_bp1012 FROM <ls_fs_bp1012>.
      ELSE.
        INSERT <ls_fs_bp1012> INTO TABLE gt_fs_bp1012.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_fs_bp1012
            is_record = <ls_fs_bp1012>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_fs_bp1030.

    DATA lt_fs_bp1030 TYPE gty_t_fs_bp1030.

    MOVE-CORRESPONDING it_data TO lt_fs_bp1030.
    LOOP AT lt_fs_bp1030 ASSIGNING FIELD-SYMBOL(<ls_fs_bp1030>).
      READ TABLE gt_fs_bp1030 FROM <ls_fs_bp1030> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_fs_bp1030 FROM <ls_fs_bp1030>.
      ELSE.
        INSERT <ls_fs_bp1030> INTO TABLE gt_fs_bp1030.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_fs_bp1030
            is_record = <ls_fs_bp1030>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_fs_bpbank.

    DATA lt_fs_bpbank TYPE gty_t_fs_bpbank.

    MOVE-CORRESPONDING it_data TO lt_fs_bpbank.
    LOOP AT lt_fs_bpbank ASSIGNING FIELD-SYMBOL(<ls_fs_bpbank>).
      READ TABLE gt_fs_bpbank FROM <ls_fs_bpbank> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_fs_bpbank FROM <ls_fs_bpbank>.
      ELSE.
        INSERT <ls_fs_bpbank> INTO TABLE gt_fs_bpbank.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_fs_bpbank
            is_record = <ls_fs_bpbank>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_fs_bptaxc.

    DATA lt_fs_bptaxc TYPE gty_t_fs_bptaxc.

    MOVE-CORRESPONDING it_data TO lt_fs_bptaxc.
    LOOP AT lt_fs_bptaxc ASSIGNING FIELD-SYMBOL(<ls_fs_bptaxc>).
      READ TABLE gt_fs_bptaxc FROM <ls_fs_bptaxc> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_fs_bptaxc FROM <ls_fs_bptaxc>.
      ELSE.
        INSERT <ls_fs_bptaxc> INTO TABLE gt_fs_bptaxc.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_fs_bptaxc
            is_record = <ls_fs_bptaxc>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_wp_email.

    DATA lt_wp_email TYPE gty_t_wp_email.

    MOVE-CORRESPONDING it_data TO lt_wp_email.
    LOOP AT lt_wp_email ASSIGNING FIELD-SYMBOL(<ls_wp_email>).
      READ TABLE gt_wp_email FROM <ls_wp_email> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_wp_email FROM <ls_wp_email>.
      ELSE.
        INSERT <ls_wp_email> INTO TABLE gt_wp_email.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_wp_email
            is_record = <ls_wp_email>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_wp_fax.

    DATA lt_wp_fax TYPE gty_t_wp_fax.

    MOVE-CORRESPONDING it_data TO lt_wp_fax.
    LOOP AT lt_wp_fax ASSIGNING FIELD-SYMBOL(<ls_wp_fax>).
      READ TABLE gt_wp_fax FROM <ls_wp_fax> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_wp_fax FROM <ls_wp_fax>.
      ELSE.
        INSERT <ls_wp_fax> INTO TABLE gt_wp_fax.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_wp_fax
            is_record = <ls_wp_fax>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_wp_postal.

    DATA lt_wp_postal TYPE gty_t_wp_postal.

    MOVE-CORRESPONDING it_data TO lt_wp_postal.
    LOOP AT lt_wp_postal ASSIGNING FIELD-SYMBOL(<ls_wp_postal>).
      READ TABLE gt_wp_postal FROM <ls_wp_postal> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_wp_postal FROM <ls_wp_postal>.
      ELSE.
        INSERT <ls_wp_postal> INTO TABLE gt_wp_postal.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_wp_postal
            is_record = <ls_wp_postal>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_wp_tel.

    DATA lt_wp_tel TYPE gty_t_wp_tel.

    MOVE-CORRESPONDING it_data TO lt_wp_tel.
    LOOP AT lt_wp_tel ASSIGNING FIELD-SYMBOL(<ls_wp_tel>).
      READ TABLE gt_wp_tel FROM <ls_wp_tel> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_wp_tel FROM <ls_wp_tel>.
      ELSE.
        INSERT <ls_wp_tel> INTO TABLE gt_wp_tel.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_wp_tel
            is_record = <ls_wp_tel>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_wp_url.

    DATA lt_wp_url TYPE gty_t_wp_url.

    MOVE-CORRESPONDING it_data TO lt_wp_url.
    LOOP AT lt_wp_url ASSIGNING FIELD-SYMBOL(<ls_wp_url>).
      READ TABLE gt_wp_url FROM <ls_wp_url> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_wp_url FROM <ls_wp_url>.
      ELSE.
        INSERT <ls_wp_url> INTO TABLE gt_wp_url.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_wp_url
            is_record = <ls_wp_url>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD del_address.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_address FROM is_data.
      ENDLOOP.
    ENDIF.

  ENDMETHOD.


  METHOD del_ad_email.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_ad_email FROM is_data.
      ENDLOOP.
    ENDIF.

  ENDMETHOD.


  METHOD del_ad_fax.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_ad_fax FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_ad_name_o.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_ad_name_o FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_ad_name_p.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_ad_name_p FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_ad_postal.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_ad_postal FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_ad_tel.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_ad_tel FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_ad_url.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_ad_url FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_adddep.
  ENDMETHOD.


  METHOD del_bp_addr.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_addr FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_addusg.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_addusg FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_bkdtl.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_bkdtl FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_ccdtl.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_ccdtl FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_compny.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_compny FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_cpgen.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_cpgen FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_cuscla.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_cuscla FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_cusddb.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_cusddb FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_cusdun.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_cusdun FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_cusfcn.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_cusfcn FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_cusgen.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_cusgen FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_custax.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_custax FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_cusulp.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_cusulp FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_cusval.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_cusval FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_cuswht.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_cuswht FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_cus_cc.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_cus_cc FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_dunn.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_dunn FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_email.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_email FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_fax.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_fax FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_idnum.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_idnum FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_indstr.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_indstr FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_mlt_ad.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_mlt_ad FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_mlt_as.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_mlt_as FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_porg.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_porg FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_porg2.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_porg2 FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_role.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_role FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_sales.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_sales FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_subhry.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_subhry FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_taxgrp.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_taxgrp FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_taxnum.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_taxnum FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_tax_ad.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_tax_ad FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_tel.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_tel FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_url.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_url FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_vencla.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_vencla FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_venddb.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_venddb FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_venfcn.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_venfcn FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_vengen.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_vengen FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_vensub.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_vensub FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_venval.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_venval FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_whtax.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_whtax FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bp_wpad.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bp_wpad FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_fkklocks.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_fkklocks FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_fkktaxex.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_fkktaxex FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_fkktxt.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_fkktxt FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_fkkvkp.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_fkkvkp FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_fkkvktd.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_fkkvktd FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_fs_bkk21.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_fs_bkk21 FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_fs_bp001.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_fs_bp001 FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_fs_bp011.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_fs_bp011 FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_fs_bp021.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_fs_bp021 FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_fs_bp1010.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_fs_bp1010 FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_fs_bp1012.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_fs_bp1012 FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_fs_bp1030.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_fs_bp1030 FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_fs_bpbank.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_fs_bpbank FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_fs_bptaxc.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_fs_bptaxc FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_wp_email.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_wp_email FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_wp_fax.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_wp_fax FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_wp_postal.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_wp_postal FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_wp_tel.

    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_wp_tel FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_wp_url.
  ENDMETHOD.


  METHOD constructor.
    super->constructor( ).
  ENDMETHOD.


  METHOD get_data_process.
    IF my_bp_data IS INITIAL.
      CREATE OBJECT my_bp_data.
    ENDIF.

    IF my_bp_data IS BOUND.
      ro_data_process ?= my_bp_data.
    ELSE.
*      Raise Exception
    ENDIF.

  ENDMETHOD.


  METHOD yz_intf_mdg_data_process~get_entity_data.

    FIELD-SYMBOLS : <ft_data> TYPE ANY TABLE.

    DATA(lv_method_name) = gc_get && iv_entity.

    TRY.

        CALL METHOD (lv_method_name)
          EXPORTING
            iv_crequest  = iv_crequest                                              " Change Request
            iv_readmode  = iv_readmode
            it_key_value = it_key_value                                               " Key Value Table Type
          IMPORTING
            er_data      = er_data.

        ASSIGN er_data->* TO <ft_data>.
        IF <ft_data> IS ASSIGNED.
          et_data = <ft_data>.
        ENDIF.

      CATCH cx_root INTO DATA(lr_error).
        DATA(lv_error) = lr_error->get_text( ).
    ENDTRY.


  ENDMETHOD.


  METHOD yz_intf_mdg_data_process~set_entity_data.

    IF io_changed_data IS BOUND.
      io_changed_data->get_entity_types( IMPORTING et_entity_del = DATA(lt_entity_del)
      et_entity_mod = DATA(lt_entity_mod) ).                " List of Entity Types Containing New And/Or Changed Data

      IF lt_entity_mod IS NOT INITIAL.

        LOOP AT lt_entity_mod INTO DATA(ls_entity_mod) WHERE struct = gc_kattr.


          io_changed_data->read_data( EXPORTING i_entity        = ls_entity_mod-entity   " Entity Type
            i_struct        = ls_entity_mod-struct  " Type of Data Structure
          IMPORTING er_t_data_mod   = DATA(lr_t_data_mod)  ).    " "Modified" Data Records (INSERT+UPDATE ).


          ASSIGN lr_t_data_mod->* TO FIELD-SYMBOL(<lt_data_mod>).

          IF <lt_data_mod> IS ASSIGNED AND <lt_data_mod> IS NOT INITIAL.

*          IF gs_application_context-br_type EQ gc_execute_derivation.
            append_entity_keys_derivation( iv_entity = ls_entity_mod-entity it_data = <lt_data_mod> ).

            DATA(lv_method_name) = gc_set && ls_entity_mod-entity.

            TRY.
                CALL METHOD (lv_method_name) EXPORTING it_data = <lt_data_mod>.
              CATCH cx_root INTO DATA(lr_error).
                DATA(lv_error) = lr_error->get_text( ).

            ENDTRY.
*          ENDIF.
          ENDIF.
        ENDLOOP.
      ENDIF.

      IF lt_entity_del IS NOT INITIAL.

        LOOP AT lt_entity_del INTO DATA(ls_entity_del) WHERE struct = gc_kattr.

          CALL METHOD io_changed_data->read_data
            EXPORTING
              i_entity               = ls_entity_del-entity
              i_struct               = ls_entity_del-struct
            IMPORTING
              er_t_data_del          = DATA(ir_t_data_del)
              ef_t_data_upd_complete = DATA(ir_t_data_upd_comp).

          ASSIGN ir_t_data_del->* TO FIELD-SYMBOL(<lt_data_del>).
          DATA(iv_method_name) = gc_del && ls_entity_del-entity.

          IF <lt_data_del> IS ASSIGNED AND <lt_data_del> IS NOT INITIAL.
            TRY.
                CALL METHOD (iv_method_name) EXPORTING it_data = <lt_data_del>.
              CATCH cx_root INTO DATA(ir_error).
                DATA(iv_error) = ir_error->get_text( ).

*          yz_clas_mdg_utility=>update_application_log( is_rule_status  = VALUE #( usmd_model = iv_data_model
*                                                               context = yz_intf_mdg_utility_const=>gc_rule_context_cr
*                                                               context_key = CONV  #( get_cr_number( ) )
*                                                               process = yz_clas_mdg_utility=>gc_process_type_derive
*                                                               rule_id = it_derivation-rule_id
*                                                               root_key = CONV #( ls_main_key-key_value )
*                                                               status  = lv_status
*                                                               usmd_entity =  ls_entity_mod-entity
*                                                               ersda = sy-datum
*                                                               time  = sy-uzeit
*                                                               usname = ls_cr_detail-usmd_created_by ) ).

            ENDTRY.
          ENDIF.

        ENDLOOP.
      ENDIF.

    ENDIF.

    IF it_data IS NOT INITIAL.
      lv_method_name = gc_set && iv_entity.

      TRY.
          CALL METHOD (lv_method_name) EXPORTING it_data = it_data.
        CATCH cx_root INTO lr_error.
          lv_error = lr_error->get_text( ).

      ENDTRY.

    ENDIF.

  ENDMETHOD.


  METHOD set_mdc2stage.

    DATA: lv_bpartner               TYPE  bu_partner.
    FIELD-SYMBOLS: <ls_entity_data> TYPE ANY TABLE.

    DATA(lt_key_value) = CONV gty_t_key_value( it_data ).

    lv_bpartner =  VALUE #( lt_key_value[ 1 ]-value OPTIONAL ).

    CHECK lv_bpartner IS NOT INITIAL.

    READ TABLE zcl_mdc_model_bp=>gt_mdc_bp_staging_map WITH TABLE KEY bpartner = lv_bpartner
                                                            INTO DATA(ls_bp_data).

    IF sy-subrc IS INITIAL.

      LOOP AT ls_bp_data-lt_bp_staging INTO DATA(ls_bp_staging).

        DATA(lv_method_name) = |{ 'SET_' }| & |{ ls_bp_staging-entity }| .
        DATA(lv_param_name)  = |{ 'IT_' }|  & |{ ls_bp_staging-entity }| .
        DATA(lv_tab_name)    = |{ 'GT_' }|  & |{ ls_bp_staging-entity }| .

        ASSIGN ls_bp_staging-tabl->* TO <ls_entity_data>.
        CHECK sy-subrc IS INITIAL AND <ls_entity_data> IS ASSIGNED.

        DATA(lt_ptab) = VALUE abap_parmbind_tab(
                              ( name  = CONV #( condense( lv_param_name ) )
                                kind  = cl_abap_objectdescr=>exporting
                                value = REF #( <ls_entity_data> ) ) ).

        IF ls_bp_staging-entity CP 'BP_MTL_*'.


        ELSE.
          CLEAR: my_bp_data->(lv_tab_name).
        ENDIF.
****Commented by Akshita
*        TRY.

*            CALL METHOD (lv_method_name)
*              PARAMETER-TABLE lt_ptab.                 " Tabletype for DRADBASIC data

*          CATCH cx_root INTO DATA(lo_exception).
            MOVE-CORRESPONDING <ls_entity_data> TO my_bp_data->(lv_tab_name).
*            DATA(lv_text) = lo_exception->get_text( ).
*            DATA(lv_text_long) = lo_exception->get_longtext( ).
****Commented by Akshita
*        ENDTRY.

      ENDLOOP.

    ENDIF.

  ENDMETHOD.
ENDCLASS.
