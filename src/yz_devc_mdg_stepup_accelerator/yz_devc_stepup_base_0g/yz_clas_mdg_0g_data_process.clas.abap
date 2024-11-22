CLASS yz_clas_mdg_0g_data_process DEFINITION
  PUBLIC
  INHERITING FROM yz_clas_mdg_0g_data_process_ex
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES yz_intf_mdg_data_process .
    INTERFACES if_usmda_constants .
    INTERFACES yz_intf_mdg_0g_const .
    INTERFACES yz_intf_mdg_0g_data_types .

    ALIASES gc_accccaudt
      FOR yz_intf_mdg_0g_const~gc_accccaudt .
    ALIASES gc_accccdet
      FOR yz_intf_mdg_0g_const~gc_accccdet .
    ALIASES gc_accgrpacc_sh_t077s
      FOR if_usmda_constants~gc_accgrpacc_sh_t077s .
    ALIASES gc_accntaudt
      FOR yz_intf_mdg_0g_const~gc_accntaudt .
    ALIASES gc_account
      FOR yz_intf_mdg_0g_const~gc_account .
    ALIASES gc_acctyp_b
      FOR if_usmda_constants~gc_acctyp_b .
    ALIASES gc_acctyp_p
      FOR if_usmda_constants~gc_acctyp_p .
    ALIASES gc_asstyp_account
      FOR if_usmda_constants~gc_asstyp_account .
    ALIASES gc_asstyp_funcarea
      FOR if_usmda_constants~gc_asstyp_funcarea .
    ALIASES gc_asstyp_not_relevant
      FOR if_usmda_constants~gc_asstyp_not_relevant .
    ALIASES gc_attr_accaltacc
      FOR if_usmda_constants~gc_attr_accaltacc .
    ALIASES gc_attr_accauthgp
      FOR if_usmda_constants~gc_attr_accauthgp .
    ALIASES gc_attr_accautpos
      FOR if_usmda_constants~gc_attr_accautpos .
    ALIASES gc_attr_accballc
      FOR if_usmda_constants~gc_attr_accballc .
    ALIASES gc_attr_acccurr
      FOR if_usmda_constants~gc_attr_acccurr .
    ALIASES gc_attr_accfrsiaf
      FOR if_usmda_constants~gc_attr_accfrsiaf .
    ALIASES gc_attr_accfrsiat
      FOR if_usmda_constants~gc_attr_accfrsiat .
    ALIASES gc_attr_accgrpacc
      FOR if_usmda_constants~gc_attr_accgrpacc .
    ALIASES gc_attr_accgrpfsi
      FOR if_usmda_constants~gc_attr_accgrpfsi .
    ALIASES gc_attr_acclidisp
      FOR if_usmda_constants~gc_attr_acclidisp .
    ALIASES gc_attr_accopnitm
      FOR if_usmda_constants~gc_attr_accopnitm .
    ALIASES gc_attr_accrecind
      FOR if_usmda_constants~gc_attr_accrecind .
    ALIASES gc_attr_acctyp
      FOR if_usmda_constants~gc_attr_acctyp .
    ALIASES gc_attr_accvalgrp
      FOR if_usmda_constants~gc_attr_accvalgrp .
    ALIASES gc_attr_all
      FOR if_usmda_constants~gc_attr_all .
    ALIASES gc_attr_bdcfsi
      FOR if_usmda_constants~gc_attr_bdcfsi .
    ALIASES gc_attr_bdcset
      FOR if_usmda_constants~gc_attr_bdcset .
    ALIASES gc_attr_ccoaacc
      FOR if_usmda_constants~gc_attr_ccoaacc .
    ALIASES gc_attr_ccoacoa
      FOR if_usmda_constants~gc_attr_ccoacoa .
    ALIASES gc_attr_compcode
      FOR if_usmda_constants~gc_attr_compcode .
    ALIASES gc_attr_edition
      FOR if_usmda_constants~gc_attr_edition .
    ALIASES gc_attr_exchraccc
      FOR if_usmda_constants~gc_attr_exchraccc .
    ALIASES gc_attr_faacc
      FOR if_usmda_constants~gc_attr_faacc .
    ALIASES gc_attr_fafrsiff
      FOR if_usmda_constants~gc_attr_fafrsiff .
    ALIASES gc_attr_fafrsift
      FOR if_usmda_constants~gc_attr_fafrsift .
    ALIASES gc_attr_ficoaacc
      FOR if_usmda_constants~gc_attr_ficoaacc .
    ALIASES gc_attr_ficoaaccc
      FOR if_usmda_constants~gc_attr_ficoaaccc .
    ALIASES gc_attr_ficoafsi
      FOR if_usmda_constants~gc_attr_ficoafsi .
    ALIASES gc_attr_frsfaperm
      FOR if_usmda_constants~gc_attr_frsfaperm .
    ALIASES gc_attr_frsiaccre
      FOR if_usmda_constants~gc_attr_frsiaccre .
    ALIASES gc_attr_frsiacdeb
      FOR if_usmda_constants~gc_attr_frsiacdeb .
    ALIASES gc_attr_frsiasset
      FOR if_usmda_constants~gc_attr_frsiasset .
    ALIASES gc_attr_frsiassty
      FOR if_usmda_constants~gc_attr_frsiassty .
    ALIASES gc_attr_frsicontr
      FOR if_usmda_constants~gc_attr_frsicontr .
    ALIASES gc_attr_frsiliab
      FOR if_usmda_constants~gc_attr_frsiliab .
    ALIASES gc_attr_frsiloss
      FOR if_usmda_constants~gc_attr_frsiloss .
    ALIASES gc_attr_frsinoass
      FOR if_usmda_constants~gc_attr_frsinoass .
    ALIASES gc_attr_frsinotes
      FOR if_usmda_constants~gc_attr_frsinotes .
    ALIASES gc_attr_frsipli
      FOR if_usmda_constants~gc_attr_frsipli .
    ALIASES gc_attr_frsiprof
      FOR if_usmda_constants~gc_attr_frsiprof .
    ALIASES gc_attr_frsusefsi
      FOR if_usmda_constants~gc_attr_frsusefsi .
    ALIASES gc_attr_fsiacc
      FOR if_usmda_constants~gc_attr_fsiacc .
    ALIASES gc_attr_fsiaccsta
      FOR if_usmda_constants~gc_attr_fsiaccsta .
    ALIASES gc_attr_fsibsign
      FOR if_usmda_constants~gc_attr_fsibsign .
    ALIASES gc_attr_fsiebstyp
      FOR if_usmda_constants~gc_attr_fsiebstyp .
    ALIASES gc_attr_fsiecontr
      FOR if_usmda_constants~gc_attr_fsiecontr .
    ALIASES gc_attr_fsiftyp
      FOR if_usmda_constants~gc_attr_fsiftyp .
    ALIASES gc_attr_fsistat
      FOR if_usmda_constants~gc_attr_fsistat .
    ALIASES gc_attr_fstgaccc
      FOR if_usmda_constants~gc_attr_fstgaccc .
    ALIASES gc_attr_fstva
      FOR if_usmda_constants~gc_attr_fstva .
    ALIASES gc_attr_fstvaccc
      FOR if_usmda_constants~gc_attr_fstvaccc .
    ALIASES gc_attr_langu
      FOR if_usmda_constants~gc_attr_langu .
    ALIASES gc_attr_parent_value
      FOR if_usmda_constants~gc_attr_parent_value .
    ALIASES gc_attr_pltypacc
      FOR if_usmda_constants~gc_attr_pltypacc .
    ALIASES gc_attr_seqnum
      FOR if_usmda_constants~gc_attr_seqnum .
    ALIASES gc_attr_subbdtype
      FOR if_usmda_constants~gc_attr_subbdtype .
    ALIASES gc_attr_subfixval
      FOR if_usmda_constants~gc_attr_subfixval .
    ALIASES gc_attr_submpfsi
      FOR if_usmda_constants~gc_attr_submpfsi .
    ALIASES gc_attr_txtlg
      FOR if_usmda_constants~gc_attr_txtlg .
    ALIASES gc_attr_txtmi
      FOR if_usmda_constants~gc_attr_txtmi .
    ALIASES gc_attr_txtsh
      FOR if_usmda_constants~gc_attr_txtsh .
    ALIASES gc_attr_txt_all
      FOR if_usmda_constants~gc_attr_txt_all .
    ALIASES gc_attr_usmd_o_frsiass
      FOR if_usmda_constants~gc_attr_usmd_o_frsiass .
    ALIASES gc_attr_wmsg
      FOR if_usmda_constants~gc_attr_wmsg .
    ALIASES gc_attr_wmsg1
      FOR if_usmda_constants~gc_attr_wmsg1 .
    ALIASES gc_attr_wmsg2
      FOR if_usmda_constants~gc_attr_wmsg2 .
    ALIASES gc_bdc
      FOR yz_intf_mdg_0g_const~gc_bdc .
    ALIASES gc_bdcset
      FOR yz_intf_mdg_0g_const~gc_bdcset .
    ALIASES gc_bdcsubsel
      FOR yz_intf_mdg_0g_const~gc_bdcsubsel .
    ALIASES gc_cctr
      FOR yz_intf_mdg_0g_const~gc_cctr .
    ALIASES gc_cctraudit
      FOR yz_intf_mdg_0g_const~gc_cctraudit .
    ALIASES gc_cctrg
      FOR yz_intf_mdg_0g_const~gc_cctrg .
    ALIASES gc_cctrh
      FOR yz_intf_mdg_0g_const~gc_cctrh .
    ALIASES gc_celem
      FOR yz_intf_mdg_0g_const~gc_celem .
    ALIASES gc_celemaudt
      FOR yz_intf_mdg_0g_const~gc_celemaudt .
    ALIASES gc_celemg
      FOR yz_intf_mdg_0g_const~gc_celemg .
    ALIASES gc_celemh
      FOR yz_intf_mdg_0g_const~gc_celemh .
    ALIASES gc_cggcurr
      FOR yz_intf_mdg_0g_const~gc_cggcurr .
    ALIASES gc_check_type_cr
      FOR if_usmda_constants~gc_check_type_cr .
    ALIASES gc_check_type_ed
      FOR if_usmda_constants~gc_check_type_ed .
    ALIASES gc_check_type_en
      FOR if_usmda_constants~gc_check_type_en .
    ALIASES gc_company
      FOR yz_intf_mdg_0g_const~gc_company .
    ALIASES gc_conschar
      FOR yz_intf_mdg_0g_const~gc_conschar .
    ALIASES gc_consgrp
      FOR yz_intf_mdg_0g_const~gc_consgrp .
    ALIASES gc_consgrph
      FOR yz_intf_mdg_0g_const~gc_consgrph .
    ALIASES gc_consunit
      FOR yz_intf_mdg_0g_const~gc_consunit .
    ALIASES gc_cuvers
      FOR yz_intf_mdg_0g_const~gc_cuvers .
    ALIASES gc_dbtab_t001
      FOR if_usmda_constants~gc_dbtab_t001 .
    ALIASES gc_entity_accccdet
      FOR if_usmda_constants~gc_entity_accccdet .
    ALIASES gc_entity_accgrp
      FOR if_usmda_constants~gc_entity_accgrp .
    ALIASES gc_entity_account
      FOR if_usmda_constants~gc_entity_account .
    ALIASES gc_entity_acqperiod
      FOR if_usmda_constants~gc_entity_acqperiod .
    ALIASES gc_entity_acqyear
      FOR if_usmda_constants~gc_entity_acqyear .
    ALIASES gc_entity_bdc
      FOR if_usmda_constants~gc_entity_bdc .
    ALIASES gc_entity_bdcset
      FOR if_usmda_constants~gc_entity_bdcset .
    ALIASES gc_entity_bdcsetdef
      FOR if_usmda_constants~gc_entity_bdcsetdef .
    ALIASES gc_entity_bdcsetmax
      FOR if_usmda_constants~gc_entity_bdcsetmax .
    ALIASES gc_entity_bdcsubsel
      FOR if_usmda_constants~gc_entity_bdcsubsel .
    ALIASES gc_entity_bupaunit
      FOR if_usmda_constants~gc_entity_bupaunit .
    ALIASES gc_entity_ccoa
      FOR if_usmda_constants~gc_entity_ccoa .
    ALIASES gc_entity_coa
      FOR if_usmda_constants~gc_entity_coa .
    ALIASES gc_entity_compcode
      FOR if_usmda_constants~gc_entity_compcode .
    ALIASES gc_entity_consarea
      FOR if_usmda_constants~gc_entity_consarea .
    ALIASES gc_entity_dimension
      FOR if_usmda_constants~gc_entity_dimension .
    ALIASES gc_entity_fcrs
      FOR if_usmda_constants~gc_entity_fcrs .
    ALIASES gc_entity_fcrsname
      FOR if_usmda_constants~gc_entity_fcrsname .
    ALIASES gc_entity_ficoa
      FOR if_usmda_constants~gc_entity_ficoa .
    ALIASES gc_entity_frs
      FOR if_usmda_constants~gc_entity_frs .
    ALIASES gc_entity_frsi
      FOR if_usmda_constants~gc_entity_frsi .
    ALIASES gc_entity_frsiass
      FOR if_usmda_constants~gc_entity_frsiass .
    ALIASES gc_entity_frsitxt
      FOR if_usmda_constants~gc_entity_frsitxt .
    ALIASES gc_entity_frsname
      FOR if_usmda_constants~gc_entity_frsname .
    ALIASES gc_entity_fsi
      FOR if_usmda_constants~gc_entity_fsi .
    ALIASES gc_entity_fsiversel
      FOR if_usmda_constants~gc_entity_fsiversel .
    ALIASES gc_entity_fstatgrp
      FOR if_usmda_constants~gc_entity_fstatgrp .
    ALIASES gc_entity_funcarea
      FOR if_usmda_constants~gc_entity_funcarea .
    ALIASES gc_entity_icalcind
      FOR if_usmda_constants~gc_entity_icalcind .
    ALIASES gc_entity_plangrp
      FOR if_usmda_constants~gc_entity_plangrp .
    ALIASES gc_entity_planlevel
      FOR if_usmda_constants~gc_entity_planlevel .
    ALIASES gc_entity_seqnum
      FOR if_usmda_constants~gc_entity_seqnum .
    ALIASES gc_entity_subassign
      FOR if_usmda_constants~gc_entity_subassign .
    ALIASES gc_entity_subitm
      FOR if_usmda_constants~gc_entity_subitm .
    ALIASES gc_entity_subitmcat
      FOR if_usmda_constants~gc_entity_subitmcat .
    ALIASES gc_entity_submpack
      FOR if_usmda_constants~gc_entity_submpack .
    ALIASES gc_entity_textitem
      FOR if_usmda_constants~gc_entity_textitem .
    ALIASES gc_entity_version
      FOR if_usmda_constants~gc_entity_version .
    ALIASES gc_f4_help
      FOR if_usmda_constants~gc_f4_help .
    ALIASES gc_fixvalues
      FOR if_usmda_constants~gc_fixvalues .
    ALIASES gc_fname_bukrs
      FOR if_usmda_constants~gc_fname_bukrs .
    ALIASES gc_fname_edition
      FOR if_usmda_constants~gc_fname_edition .
    ALIASES gc_fname_fstva
      FOR if_usmda_constants~gc_fname_fstva .
    ALIASES gc_fname_usmd_o_
      FOR if_usmda_constants~gc_fname_usmd_o_ .
    ALIASES gc_frs
      FOR yz_intf_mdg_0g_const~gc_frs .
    ALIASES gc_frsi
      FOR yz_intf_mdg_0g_const~gc_frsi .
    ALIASES gc_frsitext_separator
      FOR if_usmda_constants~gc_frsitext_separator .
    ALIASES gc_frsitxt
      FOR yz_intf_mdg_0g_const~gc_frsitxt .
    ALIASES gc_fsi
      FOR yz_intf_mdg_0g_const~gc_fsi .
    ALIASES gc_fsiaudit
      FOR yz_intf_mdg_0g_const~gc_fsiaudit .
    ALIASES gc_fsih
      FOR yz_intf_mdg_0g_const~gc_fsih .
    ALIASES gc_fsit
      FOR yz_intf_mdg_0g_const~gc_fsit .
    ALIASES gc_fsivers
      FOR yz_intf_mdg_0g_const~gc_fsivers .
    ALIASES gc_func_areas_perm
      FOR if_usmda_constants~gc_func_areas_perm .
    ALIASES gc_iordaudt
      FOR yz_intf_mdg_0g_const~gc_iordaudt .
    ALIASES gc_iorder
      FOR yz_intf_mdg_0g_const~gc_iorder .
    ALIASES gc_language_de
      FOR if_usmda_constants~gc_language_de .
    ALIASES gc_language_en
      FOR if_usmda_constants~gc_language_en .
    ALIASES gc_main_langu_de
      FOR if_usmda_constants~gc_main_langu_de .
    ALIASES gc_main_langu_en
      FOR if_usmda_constants~gc_main_langu_en .
    ALIASES gc_msgid_usmdz3
      FOR if_usmda_constants~gc_msgid_usmdz3 .
    ALIASES gc_msgty_error
      FOR if_usmda_constants~gc_msgty_error .
    ALIASES gc_msgty_information
      FOR if_usmda_constants~gc_msgty_information .
    ALIASES gc_msgty_service
      FOR if_usmda_constants~gc_msgty_service .
    ALIASES gc_msgty_warning
      FOR if_usmda_constants~gc_msgty_warning .
    ALIASES gc_no
      FOR if_usmda_constants~gc_no .
    ALIASES gc_pcccass
      FOR yz_intf_mdg_0g_const~gc_pcccass .
    ALIASES gc_pctr
      FOR yz_intf_mdg_0g_const~gc_pctr .
    ALIASES gc_pctraudit
      FOR yz_intf_mdg_0g_const~gc_pctraudit .
    ALIASES gc_pctrg
      FOR yz_intf_mdg_0g_const~gc_pctrg .
    ALIASES gc_pctrh
      FOR yz_intf_mdg_0g_const~gc_pctrh .
    ALIASES gc_separator_ukm
      FOR if_usmda_constants~gc_separator_ukm .
    ALIASES gc_sets
      FOR if_usmda_constants~gc_sets .
    ALIASES gc_so_sets
      FOR if_usmda_constants~gc_so_sets .
    ALIASES gc_struct_key_set
      FOR if_usmda_constants~gc_struct_key_set .
    ALIASES gc_struct_key_set_so
      FOR if_usmda_constants~gc_struct_key_set_so .
    ALIASES gc_submpack
      FOR yz_intf_mdg_0g_const~gc_submpack .
    ALIASES gc_transtype
      FOR yz_intf_mdg_0g_const~gc_transtype .
    ALIASES gc_ui
      FOR if_usmda_constants~gc_ui .
    ALIASES gc_uinode_bdcsetdef
      FOR if_usmda_constants~gc_uinode_bdcsetdef .
    ALIASES gc_uinode_bdcsetmax
      FOR if_usmda_constants~gc_uinode_bdcsetmax .
    ALIASES gc_uinode_faacc
      FOR if_usmda_constants~gc_uinode_faacc .
    ALIASES gc_uinode_frsicontr
      FOR if_usmda_constants~gc_uinode_frsicontr .
    ALIASES gc_uinode_fsiacc
      FOR if_usmda_constants~gc_uinode_fsiacc .
    ALIASES gc_uinode_fsiaccsta
      FOR if_usmda_constants~gc_uinode_fsiaccsta .
    ALIASES gc_uinode_pltypacc
      FOR if_usmda_constants~gc_uinode_pltypacc .
    ALIASES gc_uinode_subfixval
      FOR if_usmda_constants~gc_uinode_subfixval .
    ALIASES gc_usmd_entity
      FOR if_usmda_constants~gc_usmd_entity .
    ALIASES gc_usmd_entity_so
      FOR if_usmda_constants~gc_usmd_entity_so .
    ALIASES gc_usmd_fieldname
      FOR if_usmda_constants~gc_usmd_fieldname .
    ALIASES gc_usmd_value
      FOR if_usmda_constants~gc_usmd_value .
    ALIASES gc_validation
      FOR if_usmda_constants~gc_validation .
    ALIASES gc_value_fsiftyp
      FOR if_usmda_constants~gc_value_fsiftyp .
    ALIASES gc_yes
      FOR if_usmda_constants~gc_yes .
    ALIASES get_entity_data
      FOR yz_intf_mdg_data_process~get_entity_data .
    ALIASES set_entity_data
      FOR yz_intf_mdg_data_process~set_entity_data .
    ALIASES gty_t_accccaudt
      FOR yz_intf_mdg_0g_data_types~gty_t_accccaudt .
    ALIASES gty_t_accccdet
      FOR yz_intf_mdg_0g_data_types~gty_t_accccdet .
    ALIASES gty_t_accntaudt
      FOR yz_intf_mdg_0g_data_types~gty_t_accntaudt .
    ALIASES gty_t_account
      FOR yz_intf_mdg_0g_data_types~gty_t_account .
    ALIASES gty_t_bdc
      FOR yz_intf_mdg_0g_data_types~gty_t_bdc .
    ALIASES gty_t_bdcset
      FOR yz_intf_mdg_0g_data_types~gty_t_bdcset .
    ALIASES gty_t_bdcsubsel
      FOR yz_intf_mdg_0g_data_types~gty_t_bdcsubsel .
    ALIASES gty_t_cctr
      FOR yz_intf_mdg_0g_data_types~gty_t_cctr .
    ALIASES gty_t_cctraudit
      FOR yz_intf_mdg_0g_data_types~gty_t_cctraudit .
    ALIASES gty_t_cctrg
      FOR yz_intf_mdg_0g_data_types~gty_t_cctrg .
    ALIASES gty_t_cctrh
      FOR yz_intf_mdg_0g_data_types~gty_t_cctrh .
    ALIASES gty_t_celem
      FOR yz_intf_mdg_0g_data_types~gty_t_celem .
    ALIASES gty_t_celemaudt
      FOR yz_intf_mdg_0g_data_types~gty_t_celemaudt .
    ALIASES gty_t_celemg
      FOR yz_intf_mdg_0g_data_types~gty_t_celemg .
    ALIASES gty_t_celemh
      FOR yz_intf_mdg_0g_data_types~gty_t_celemh .
    ALIASES gty_t_cggcurr
      FOR yz_intf_mdg_0g_data_types~gty_t_cggcurr .
    ALIASES gty_t_company
      FOR yz_intf_mdg_0g_data_types~gty_t_company .
    ALIASES gty_t_conschar
      FOR yz_intf_mdg_0g_data_types~gty_t_conschar .
    ALIASES gty_t_consgrp
      FOR yz_intf_mdg_0g_data_types~gty_t_consgrp .
    ALIASES gty_t_consgrph
      FOR yz_intf_mdg_0g_data_types~gty_t_consgrph .
    ALIASES gty_t_consunit
      FOR yz_intf_mdg_0g_data_types~gty_t_consunit .
    ALIASES gty_t_cuvers
      FOR yz_intf_mdg_0g_data_types~gty_t_cuvers .
    ALIASES gty_t_frs
      FOR yz_intf_mdg_0g_data_types~gty_t_frs .
    ALIASES gty_t_frsi
      FOR yz_intf_mdg_0g_data_types~gty_t_frsi .
    ALIASES gty_t_frsitxt
      FOR yz_intf_mdg_0g_data_types~gty_t_frsitxt .
    ALIASES gty_t_fsi
      FOR yz_intf_mdg_0g_data_types~gty_t_fsi .
    ALIASES gty_t_fsiaudit
      FOR yz_intf_mdg_0g_data_types~gty_t_fsiaudit .
    ALIASES gty_t_fsih
      FOR yz_intf_mdg_0g_data_types~gty_t_fsih .
    ALIASES gty_t_fsit
      FOR yz_intf_mdg_0g_data_types~gty_t_fsit .
    ALIASES gty_t_fsivers
      FOR yz_intf_mdg_0g_data_types~gty_t_fsivers .
    ALIASES gty_t_iordaudt
      FOR yz_intf_mdg_0g_data_types~gty_t_iordaudt .
    ALIASES gty_t_iorder
      FOR yz_intf_mdg_0g_data_types~gty_t_iorder .
    ALIASES gty_t_pcccass
      FOR yz_intf_mdg_0g_data_types~gty_t_pcccass .
    ALIASES gty_t_pctr
      FOR yz_intf_mdg_0g_data_types~gty_t_pctr .
    ALIASES gty_t_pctraudit
      FOR yz_intf_mdg_0g_data_types~gty_t_pctraudit .
    ALIASES gty_t_pctrg
      FOR yz_intf_mdg_0g_data_types~gty_t_pctrg .
    ALIASES gty_t_pctrh
      FOR yz_intf_mdg_0g_data_types~gty_t_pctrh .
    ALIASES gty_t_submpack
      FOR yz_intf_mdg_0g_data_types~gty_t_submpack .
    ALIASES gty_t_transtype
      FOR yz_intf_mdg_0g_data_types~gty_t_transtype .

    CLASS-DATA gt_accccdet TYPE gty_t_accccdet .
    CLASS-DATA gt_account TYPE gty_t_account .
    CLASS-DATA gt_bdc TYPE gty_t_bdc .
    CLASS-DATA gt_bdcset TYPE gty_t_bdcset .
    CLASS-DATA gt_cctr TYPE gty_t_cctr .
    CLASS-DATA gt_cctrg TYPE gty_t_cctrg .
    CLASS-DATA gt_cctrh TYPE gty_t_cctrh .
    CLASS-DATA gt_celem TYPE gty_t_celem .
    CLASS-DATA gt_celemg TYPE gty_t_celemg .
    CLASS-DATA gt_celemh TYPE gty_t_celemh .
    CLASS-DATA gt_company TYPE gty_t_company .
    CLASS-DATA gt_conschar TYPE gty_t_conschar .
    CLASS-DATA gt_consgrp TYPE gty_t_consgrp .
    CLASS-DATA gt_consgrph TYPE gty_t_consgrph .
    CLASS-DATA gt_consunit TYPE gty_t_consunit .
    CLASS-DATA gt_frs TYPE gty_t_frs .
    CLASS-DATA gt_frsi TYPE gty_t_frsi .
    CLASS-DATA gt_fsi TYPE gty_t_fsi .
    CLASS-DATA gt_fsih TYPE gty_t_fsih .
    CLASS-DATA gt_fsit TYPE gty_t_fsit .
    CLASS-DATA gt_iorder TYPE gty_t_iorder .
    CLASS-DATA gt_pctr TYPE gty_t_pctr .
    CLASS-DATA gt_pctrg TYPE gty_t_pctrg .
    CLASS-DATA gt_pctrh TYPE gty_t_pctrh .
    CLASS-DATA gt_submpack TYPE gty_t_submpack .
    CLASS-DATA gt_transtype TYPE gty_t_transtype .
    CLASS-DATA gt_accccaudt TYPE gty_t_accccaudt .
    CLASS-DATA gt_accntaudt TYPE gty_t_accntaudt .
    CLASS-DATA gt_bdcsubsel TYPE gty_t_bdcsubsel .
    CLASS-DATA gt_cctraudit TYPE gty_t_cctraudit .
    CLASS-DATA gt_celemaudt TYPE gty_t_celemaudt .
    CLASS-DATA gt_cggcurr TYPE gty_t_cggcurr .
    CLASS-DATA gt_cuvers TYPE gty_t_cuvers .
    CLASS-DATA gt_frsitxt TYPE gty_t_frsitxt .
    CLASS-DATA gt_fsiaudit TYPE gty_t_fsiaudit .
    CLASS-DATA gt_fsivers TYPE gty_t_fsivers .
    CLASS-DATA gt_iordaudt TYPE gty_t_iordaudt .
    CLASS-DATA gt_pcccass TYPE gty_t_pcccass .
    CLASS-DATA gt_pctraudit TYPE gty_t_pctraudit .

    METHODS constructor .
    CLASS-METHODS get_data_process
      RETURNING
        VALUE(ro_data_process) TYPE REF TO yz_intf_mdg_data_process .
    CLASS-METHODS get_accccdet
      IMPORTING
        !iv_crequest       TYPE usmd_crequest OPTIONAL
        !it_key_value      TYPE gty_t_key_value OPTIONAL
        !iv_readmode       TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data           TYPE REF TO data
      RETURNING
        VALUE(rt_accccdet) TYPE gty_t_accccdet .
    CLASS-METHODS set_accccdet
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS del_accccdet
      IMPORTING
        !it_data TYPE gty_t_accccdet .
    CLASS-METHODS get_account
      IMPORTING
        !iv_crequest      TYPE usmd_crequest OPTIONAL
        !it_key_value     TYPE gty_t_key_value OPTIONAL
        !iv_readmode      TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data          TYPE REF TO data
      RETURNING
        VALUE(rt_account) TYPE gty_t_account .
    CLASS-METHODS set_account
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS del_account
      IMPORTING
        !it_data TYPE gty_t_account .
    CLASS-METHODS get_bdc
      IMPORTING
        !iv_crequest  TYPE usmd_crequest OPTIONAL
        !it_key_value TYPE gty_t_key_value OPTIONAL
        !iv_readmode  TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data      TYPE REF TO data
      RETURNING
        VALUE(rt_bdc) TYPE gty_t_bdc .
    CLASS-METHODS set_bdc
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS del_bdc
      IMPORTING
        !it_data TYPE gty_t_bdc .
    CLASS-METHODS get_bdcset
      IMPORTING
        !iv_crequest     TYPE usmd_crequest OPTIONAL
        !it_key_value    TYPE gty_t_key_value OPTIONAL
        !iv_readmode     TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data         TYPE REF TO data
      RETURNING
        VALUE(rt_bdcset) TYPE gty_t_bdcset .
    CLASS-METHODS set_bdcset
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS del_bdcset
      IMPORTING
        !it_data TYPE gty_t_bdcset .
    CLASS-METHODS get_cctr
      IMPORTING
        !iv_crequest   TYPE usmd_crequest OPTIONAL
        !it_key_value  TYPE gty_t_key_value OPTIONAL
        !iv_readmode   TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data       TYPE REF TO data
      RETURNING
        VALUE(rt_cctr) TYPE gty_t_cctr .
    CLASS-METHODS set_cctr
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS del_cctr
      IMPORTING
        !it_data TYPE gty_t_cctr .
    CLASS-METHODS get_cctrg
      IMPORTING
        !iv_crequest    TYPE usmd_crequest OPTIONAL
        !it_key_value   TYPE gty_t_key_value OPTIONAL
        !iv_readmode    TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data        TYPE REF TO data
      RETURNING
        VALUE(rt_cctrg) TYPE gty_t_cctrg .
    CLASS-METHODS set_cctrg
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS del_cctrg
      IMPORTING
        !it_data TYPE gty_t_cctrg .
    CLASS-METHODS get_cctrh
      IMPORTING
        !iv_crequest    TYPE usmd_crequest OPTIONAL
        !it_key_value   TYPE gty_t_key_value OPTIONAL
        !iv_readmode    TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data        TYPE REF TO data
      RETURNING
        VALUE(rt_cctrh) TYPE gty_t_cctrh .
    CLASS-METHODS set_cctrh
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS del_cctrh
      IMPORTING
        !it_data TYPE gty_t_cctrh .
    CLASS-METHODS get_celem
      IMPORTING
        !iv_crequest    TYPE usmd_crequest OPTIONAL
        !it_key_value   TYPE gty_t_key_value OPTIONAL
        !iv_readmode    TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data        TYPE REF TO data
      RETURNING
        VALUE(rt_celem) TYPE gty_t_celem .
    CLASS-METHODS set_celem
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS del_celem
      IMPORTING
        !it_data TYPE gty_t_celem .
    CLASS-METHODS get_celemg
      IMPORTING
        !iv_crequest     TYPE usmd_crequest OPTIONAL
        !it_key_value    TYPE gty_t_key_value OPTIONAL
        !iv_readmode     TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data         TYPE REF TO data
      RETURNING
        VALUE(rt_celemg) TYPE gty_t_celemg .
    CLASS-METHODS set_celemg
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS del_celemg
      IMPORTING
        !it_data TYPE gty_t_celemg .
    CLASS-METHODS get_celemh
      IMPORTING
        !iv_crequest     TYPE usmd_crequest OPTIONAL
        !it_key_value    TYPE gty_t_key_value OPTIONAL
        !iv_readmode     TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data         TYPE REF TO data
      RETURNING
        VALUE(rt_celemh) TYPE gty_t_celemh .
    CLASS-METHODS set_celemh
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS del_celemh
      IMPORTING
        !it_data TYPE gty_t_celemh .
    CLASS-METHODS get_company
      IMPORTING
        !iv_crequest      TYPE usmd_crequest OPTIONAL
        !it_key_value     TYPE gty_t_key_value OPTIONAL
        !iv_readmode      TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data          TYPE REF TO data
      RETURNING
        VALUE(rt_company) TYPE gty_t_company .
    CLASS-METHODS set_company
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS del_company
      IMPORTING
        !it_data TYPE gty_t_company .
    CLASS-METHODS get_conschar
      IMPORTING
        !iv_crequest       TYPE usmd_crequest OPTIONAL
        !it_key_value      TYPE gty_t_key_value OPTIONAL
        !iv_readmode       TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data           TYPE REF TO data
      RETURNING
        VALUE(rt_conschar) TYPE gty_t_conschar .
    CLASS-METHODS set_conschar
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS del_conschar
      IMPORTING
        !it_data TYPE gty_t_conschar .
    CLASS-METHODS get_consgrp
      IMPORTING
        !iv_crequest      TYPE usmd_crequest OPTIONAL
        !it_key_value     TYPE gty_t_key_value OPTIONAL
        !iv_readmode      TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data          TYPE REF TO data
      RETURNING
        VALUE(rt_consgrp) TYPE gty_t_consgrp .
    CLASS-METHODS set_consgrp
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS del_consgrp
      IMPORTING
        !it_data TYPE gty_t_consgrp .
    CLASS-METHODS get_consgrph
      IMPORTING
        !iv_crequest       TYPE usmd_crequest OPTIONAL
        !it_key_value      TYPE gty_t_key_value OPTIONAL
        !iv_readmode       TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data           TYPE REF TO data
      RETURNING
        VALUE(rt_consgrph) TYPE gty_t_consgrph .
    CLASS-METHODS set_consgrph
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS del_consgrph
      IMPORTING
        !it_data TYPE gty_t_consgrph .
    CLASS-METHODS get_consunit
      IMPORTING
        !iv_crequest       TYPE usmd_crequest OPTIONAL
        !it_key_value      TYPE gty_t_key_value OPTIONAL
        !iv_readmode       TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data           TYPE REF TO data
      RETURNING
        VALUE(rt_consunit) TYPE gty_t_consunit .
    CLASS-METHODS set_consunit
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS del_consunit
      IMPORTING
        !it_data TYPE gty_t_consunit .
    CLASS-METHODS get_frs
      IMPORTING
        !iv_crequest  TYPE usmd_crequest OPTIONAL
        !it_key_value TYPE gty_t_key_value OPTIONAL
        !iv_readmode  TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data      TYPE REF TO data
      RETURNING
        VALUE(rt_frs) TYPE gty_t_frs .
    CLASS-METHODS set_frs
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS del_frs
      IMPORTING
        !it_data TYPE gty_t_frs .
    CLASS-METHODS get_frsi
      IMPORTING
        !iv_crequest   TYPE usmd_crequest OPTIONAL
        !it_key_value  TYPE gty_t_key_value OPTIONAL
        !iv_readmode   TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data       TYPE REF TO data
      RETURNING
        VALUE(rt_frsi) TYPE gty_t_frsi .
    CLASS-METHODS set_frsi
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS del_frsi
      IMPORTING
        !it_data TYPE gty_t_frsi .
    CLASS-METHODS get_fsi
      IMPORTING
        !iv_crequest  TYPE usmd_crequest OPTIONAL
        !it_key_value TYPE gty_t_key_value OPTIONAL
        !iv_readmode  TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data      TYPE REF TO data
      RETURNING
        VALUE(rt_fsi) TYPE gty_t_fsi .
    CLASS-METHODS set_fsi
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS del_fsi
      IMPORTING
        !it_data TYPE gty_t_fsi .
    CLASS-METHODS get_fsih
      IMPORTING
        !iv_crequest   TYPE usmd_crequest OPTIONAL
        !it_key_value  TYPE gty_t_key_value OPTIONAL
        !iv_readmode   TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data       TYPE REF TO data
      RETURNING
        VALUE(rt_fsih) TYPE gty_t_fsih .
    CLASS-METHODS set_fsih
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS del_fsih
      IMPORTING
        !it_data TYPE gty_t_fsih .
    CLASS-METHODS get_fsit
      IMPORTING
        !iv_crequest   TYPE usmd_crequest OPTIONAL
        !it_key_value  TYPE gty_t_key_value OPTIONAL
        !iv_readmode   TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data       TYPE REF TO data
      RETURNING
        VALUE(rt_fsit) TYPE gty_t_fsit .
    CLASS-METHODS set_fsit
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS del_fsit
      IMPORTING
        !it_data TYPE gty_t_fsit .
    CLASS-METHODS get_iorder
      IMPORTING
        !iv_crequest     TYPE usmd_crequest OPTIONAL
        !it_key_value    TYPE gty_t_key_value OPTIONAL
        !iv_readmode     TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data         TYPE REF TO data
      RETURNING
        VALUE(rt_iorder) TYPE gty_t_iorder .
    CLASS-METHODS set_iorder
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS del_iorder
      IMPORTING
        !it_data TYPE gty_t_iorder .
    CLASS-METHODS get_pctr
      IMPORTING
        !iv_crequest   TYPE usmd_crequest OPTIONAL
        !it_key_value  TYPE gty_t_key_value OPTIONAL
        !iv_readmode   TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data       TYPE REF TO data
      RETURNING
        VALUE(rt_pctr) TYPE gty_t_pctr .
    CLASS-METHODS set_pctr
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS del_pctr
      IMPORTING
        !it_data TYPE gty_t_pctr .
    CLASS-METHODS get_pctrg
      IMPORTING
        !iv_crequest    TYPE usmd_crequest OPTIONAL
        !it_key_value   TYPE gty_t_key_value OPTIONAL
        !iv_readmode    TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data        TYPE REF TO data
      RETURNING
        VALUE(rt_pctrg) TYPE gty_t_pctrg .
    CLASS-METHODS set_pctrg
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS del_pctrg
      IMPORTING
        !it_data TYPE gty_t_pctrg .
    CLASS-METHODS get_pctrh
      IMPORTING
        !iv_crequest    TYPE usmd_crequest OPTIONAL
        !it_key_value   TYPE gty_t_key_value OPTIONAL
        !iv_readmode    TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data        TYPE REF TO data
      RETURNING
        VALUE(rt_pctrh) TYPE gty_t_pctrh .
    CLASS-METHODS set_pctrh
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS del_pctrh
      IMPORTING
        !it_data TYPE gty_t_pctrh .
    CLASS-METHODS get_submpack
      IMPORTING
        !iv_crequest       TYPE usmd_crequest OPTIONAL
        !it_key_value      TYPE gty_t_key_value OPTIONAL
        !iv_readmode       TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data           TYPE REF TO data
      RETURNING
        VALUE(rt_submpack) TYPE gty_t_submpack .
    CLASS-METHODS set_submpack
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS del_submpack
      IMPORTING
        !it_data TYPE gty_t_submpack .
    CLASS-METHODS get_transtype
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_transtype) TYPE gty_t_transtype .
    CLASS-METHODS set_transtype
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS del_transtype
      IMPORTING
        !it_data TYPE gty_t_transtype .
    CLASS-METHODS get_accccaudt
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_accccaudt) TYPE gty_t_accccaudt .
    CLASS-METHODS set_accccaudt
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS del_accccaudt
      IMPORTING
        !it_data TYPE gty_t_accccaudt .
    CLASS-METHODS get_accntaudt
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_accntaudt) TYPE gty_t_accntaudt .
    CLASS-METHODS set_accntaudt
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS del_accntaudt
      IMPORTING
        !it_data TYPE gty_t_accntaudt .
    CLASS-METHODS get_bdcsubsel
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_bdcsubsel) TYPE gty_t_bdcsubsel .
    CLASS-METHODS set_bdcsubsel
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS del_bdcsubsel
      IMPORTING
        !it_data TYPE gty_t_bdcsubsel .
    CLASS-METHODS get_cctraudit
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_cctraudit) TYPE gty_t_cctraudit .
    CLASS-METHODS set_cctraudit
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS del_cctraudit
      IMPORTING
        !it_data TYPE gty_t_cctraudit .
    CLASS-METHODS get_celemaudt
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_celemaudt) TYPE gty_t_celemaudt .
    CLASS-METHODS set_celemaudt
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS del_celemaudt
      IMPORTING
        !it_data TYPE gty_t_celemaudt .
    CLASS-METHODS get_cggcurr
      IMPORTING
        !iv_crequest      TYPE usmd_crequest OPTIONAL
        !it_key_value     TYPE gty_t_key_value OPTIONAL
        !iv_readmode      TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data          TYPE REF TO data
      RETURNING
        VALUE(rt_cggcurr) TYPE gty_t_cggcurr .
    CLASS-METHODS set_cggcurr
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS del_cggcurr
      IMPORTING
        !it_data TYPE gty_t_cggcurr .
    CLASS-METHODS get_cuvers
      IMPORTING
        !iv_crequest     TYPE usmd_crequest OPTIONAL
        !it_key_value    TYPE gty_t_key_value OPTIONAL
        !iv_readmode     TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data         TYPE REF TO data
      RETURNING
        VALUE(rt_cuvers) TYPE gty_t_cuvers .
    CLASS-METHODS set_cuvers
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS del_cuvers
      IMPORTING
        !it_data TYPE gty_t_cuvers .
    CLASS-METHODS get_frsitxt
      IMPORTING
        !iv_crequest      TYPE usmd_crequest OPTIONAL
        !it_key_value     TYPE gty_t_key_value OPTIONAL
        !iv_readmode      TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data          TYPE REF TO data
      RETURNING
        VALUE(rt_frsitxt) TYPE gty_t_frsitxt .
    CLASS-METHODS set_frsitxt
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS del_frsitxt
      IMPORTING
        !it_data TYPE gty_t_frsitxt .
    CLASS-METHODS get_fsiaudit
      IMPORTING
        !iv_crequest       TYPE usmd_crequest OPTIONAL
        !it_key_value      TYPE gty_t_key_value OPTIONAL
        !iv_readmode       TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data           TYPE REF TO data
      RETURNING
        VALUE(rt_fsiaudit) TYPE gty_t_fsiaudit .
    CLASS-METHODS set_fsiaudit
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS del_fsiaudit
      IMPORTING
        !it_data TYPE gty_t_fsiaudit .
    CLASS-METHODS get_fsivers
      IMPORTING
        !iv_crequest      TYPE usmd_crequest OPTIONAL
        !it_key_value     TYPE gty_t_key_value OPTIONAL
        !iv_readmode      TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data          TYPE REF TO data
      RETURNING
        VALUE(rt_fsivers) TYPE gty_t_fsivers .
    CLASS-METHODS set_fsivers
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS del_fsivers
      IMPORTING
        !it_data TYPE gty_t_fsivers .
    CLASS-METHODS get_iordaudt
      IMPORTING
        !iv_crequest       TYPE usmd_crequest OPTIONAL
        !it_key_value      TYPE gty_t_key_value OPTIONAL
        !iv_readmode       TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data           TYPE REF TO data
      RETURNING
        VALUE(rt_iordaudt) TYPE gty_t_iordaudt .
    CLASS-METHODS set_iordaudt
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS del_iordaudt
      IMPORTING
        !it_data TYPE gty_t_iordaudt .
    CLASS-METHODS get_pcccass
      IMPORTING
        !iv_crequest      TYPE usmd_crequest OPTIONAL
        !it_key_value     TYPE gty_t_key_value OPTIONAL
        !iv_readmode      TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data          TYPE REF TO data
      RETURNING
        VALUE(rt_pcccass) TYPE gty_t_pcccass .
    CLASS-METHODS set_pcccass
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS del_pcccass
      IMPORTING
        !it_data TYPE gty_t_pcccass .
    CLASS-METHODS get_pctraudit
      IMPORTING
        !iv_crequest        TYPE usmd_crequest OPTIONAL
        !it_key_value       TYPE gty_t_key_value OPTIONAL
        !iv_readmode        TYPE usmd_readmode_ext DEFAULT gc_readmode_act_inact
      EXPORTING
        !er_data            TYPE REF TO data
      RETURNING
        VALUE(rt_pctraudit) TYPE gty_t_pctraudit .
    CLASS-METHODS set_pctraudit
      IMPORTING
        !it_data TYPE ANY TABLE .
    CLASS-METHODS del_pctraudit
      IMPORTING
        !it_data TYPE gty_t_pctraudit .
  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-DATA my_0g_data TYPE REF TO yz_clas_mdg_bp_data_process.
ENDCLASS.



CLASS YZ_CLAS_MDG_0G_DATA_PROCESS IMPLEMENTATION.


  METHOD constructor.
    super->constructor( ).
  ENDMETHOD.


  METHOD del_accccaudt.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_accccaudt FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_accccdet.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_accccdet FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_accntaudt.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_accntaudt FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_account.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_account FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bdc.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bdc FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bdcset.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bdcset FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_bdcsubsel.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_bdcsubsel FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_cctr.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_cctr FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_cctraudit.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_cctraudit FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_cctrg.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_cctrg FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_cctrh.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_cctrh FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_celem.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_celem FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_celemaudt.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_celemaudt FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_celemg.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_celemg FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_celemh.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_celemh FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_cggcurr.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_cggcurr FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_company.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_company FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_conschar.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_conschar FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_consgrp.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_consgrp FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_consgrph.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_consgrph FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_consunit.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_consunit FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_cuvers.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_cuvers FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_frs.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_frs FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_frsi.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_frsi FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_frsitxt.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_frsitxt FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_fsi.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_fsi FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_fsiaudit.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_fsiaudit FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_fsih.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_fsih FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_fsit.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_fsit FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_fsivers.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_fsivers FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_iordaudt.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_iordaudt FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_iorder.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_iorder FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_pcccass.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_pcccass FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_pctr.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_pctr FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_pctraudit.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_pctraudit FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_pctrg.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_pctrg FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_pctrh.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_pctrh FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_submpack.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_submpack FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD del_transtype.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_transtype FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD get_accccaudt.

    IF gt_accccaudt IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_accccaudt " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_accccaudt = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_accccaudt                                                           it_key_value = it_key_value ) ).
      LOOP AT gt_accccaudt ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_accccaudt."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_accccaudt = gt_accccaudt.
    ENDIF.

    IF rt_accccaudt IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_accccaudt.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_accccaudt ).
    ENDIF.
  ENDMETHOD.


  METHOD get_accccdet.

    IF gt_accccdet IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_entity_accccdet " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_accccdet = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_entity_accccdet                                                           it_key_value = it_key_value ) ).
      LOOP AT gt_accccdet ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_accccdet."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_accccdet = gt_accccdet.
    ENDIF.

    IF rt_accccdet IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_accccdet.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_accccdet ).
    ENDIF.
  ENDMETHOD.


  METHOD get_accntaudt.

    IF gt_accntaudt IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_accntaudt " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_accntaudt = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_accntaudt                                                           it_key_value = it_key_value ) ).
      LOOP AT gt_accntaudt ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_accntaudt."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_accntaudt = gt_accntaudt.
    ENDIF.

    IF rt_accntaudt IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_accntaudt.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_accntaudt ).
    ENDIF.
  ENDMETHOD.


  METHOD get_account.

    IF gt_account IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_entity_account " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_account = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_entity_account                                                           it_key_value = it_key_value ) ).
      LOOP AT gt_account ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_account."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_account = gt_account.
    ENDIF.

    IF rt_account IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_account.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_account ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bdc.

    IF gt_bdc IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_entity_bdc " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bdc = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_entity_bdc                                                           it_key_value = it_key_value ) ).
      LOOP AT gt_bdc ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bdc."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bdc = gt_bdc.
    ENDIF.

    IF rt_bdc IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bdc.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bdc ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bdcset.

    IF gt_bdcset IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_entity_bdcset " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bdcset = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_entity_bdcset                                                           it_key_value = it_key_value ) ).
      LOOP AT gt_bdcset ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bdcset."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bdcset = gt_bdcset.
    ENDIF.

    IF rt_bdcset IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bdcset.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bdcset ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bdcsubsel.

    IF gt_bdcsubsel IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_entity_bdcsubsel " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_bdcsubsel = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_entity_bdcsubsel                                                           it_key_value = it_key_value ) ).
      LOOP AT gt_bdcsubsel ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_bdcsubsel."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_bdcsubsel = gt_bdcsubsel.
    ENDIF.

    IF rt_bdcsubsel IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_bdcsubsel.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_bdcsubsel ).
    ENDIF.
  ENDMETHOD.


  METHOD get_cctr.

    IF gt_cctr IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_cctr " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_cctr = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_cctr                                                           it_key_value = it_key_value ) ).
      LOOP AT gt_cctr ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_cctr."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_cctr = gt_cctr.
    ENDIF.

    IF rt_cctr IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_cctr.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_cctr ).
    ENDIF.
  ENDMETHOD.


  METHOD get_cctraudit.

    IF gt_cctraudit IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_cctraudit " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_cctraudit = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_cctraudit                                                           it_key_value = it_key_value ) ).
      LOOP AT gt_cctraudit ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_cctraudit."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_cctraudit = gt_cctraudit.
    ENDIF.

    IF rt_cctraudit IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_cctraudit.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_cctraudit ).
    ENDIF.
  ENDMETHOD.


  METHOD get_cctrg.

    IF gt_cctrg IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_cctrg " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_cctrg = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_cctrg                                                           it_key_value = it_key_value ) ).
      LOOP AT gt_cctrg ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_cctrg."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_cctrg = gt_cctrg.
    ENDIF.

    IF rt_cctrg IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_cctrg.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_cctrg ).
    ENDIF.
  ENDMETHOD.


  METHOD get_cctrh.

    IF gt_cctrh IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_cctrh " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_cctrh = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_cctrh                                                           it_key_value = it_key_value ) ).
      LOOP AT gt_cctrh ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_cctrh."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_cctrh = gt_cctrh.
    ENDIF.

    IF rt_cctrh IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_cctrh.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_cctrh ).
    ENDIF.
  ENDMETHOD.


  METHOD get_celem.

    IF gt_celem IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_celem " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_celem = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_celem                                                           it_key_value = it_key_value ) ).
      LOOP AT gt_celem ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_celem."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_celem = gt_celem.
    ENDIF.

    IF rt_celem IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_celem.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_celem ).
    ENDIF.
  ENDMETHOD.


  METHOD get_celemaudt.

    IF gt_celemaudt IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_celemaudt " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_celemaudt = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_celemaudt                                                           it_key_value = it_key_value ) ).
      LOOP AT gt_celemaudt ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_celemaudt."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_celemaudt = gt_celemaudt.
    ENDIF.

    IF rt_celemaudt IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_celemaudt.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_celemaudt ).
    ENDIF.
  ENDMETHOD.


  METHOD get_celemg.

    IF gt_celemg IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_celemg " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_celemg = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_celemg                                                           it_key_value = it_key_value ) ).
      LOOP AT gt_celemg ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_celemg."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_celemg = gt_celemg.
    ENDIF.

    IF rt_celemg IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_celemg.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_celemg ).
    ENDIF.
  ENDMETHOD.


  METHOD get_celemh.

    IF gt_celemh IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_celemh " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_celemh = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_celemh                                                           it_key_value = it_key_value ) ).
      LOOP AT gt_celemh ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_celemh."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_celemh = gt_celemh.
    ENDIF.

    IF rt_celemh IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_celemh.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_celemh ).
    ENDIF.
  ENDMETHOD.


  METHOD get_cggcurr.

    IF gt_cggcurr IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_cggcurr " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_cggcurr = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_cggcurr                                                           it_key_value = it_key_value ) ).
      LOOP AT gt_cggcurr ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_cggcurr."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_cggcurr = gt_cggcurr.
    ENDIF.

    IF rt_cggcurr IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_cggcurr.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_cggcurr ).
    ENDIF.
  ENDMETHOD.


  METHOD get_company.

    IF gt_company IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_company " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_company = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_company                                                           it_key_value = it_key_value ) ).
      LOOP AT gt_company ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_company."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_company = gt_company.
    ENDIF.

    IF rt_company IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_company.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_company ).
    ENDIF.
  ENDMETHOD.


  METHOD get_conschar.

    IF gt_conschar IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_conschar " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_conschar = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_conschar                                                           it_key_value = it_key_value ) ).
      LOOP AT gt_conschar ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_conschar."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_conschar = gt_conschar.
    ENDIF.

    IF rt_conschar IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_conschar.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_conschar ).
    ENDIF.
  ENDMETHOD.


  METHOD get_consgrp.

    IF gt_consgrp IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_consgrp " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_consgrp = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_consgrp                                                           it_key_value = it_key_value ) ).
      LOOP AT gt_consgrp ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_consgrp."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_consgrp = gt_consgrp.
    ENDIF.

    IF rt_consgrp IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_consgrp.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_consgrp ).
    ENDIF.
  ENDMETHOD.


  METHOD get_consgrph.

    IF gt_consgrph IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_consgrph " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_consgrph = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_consgrph                                                           it_key_value = it_key_value ) ).
      LOOP AT gt_consgrph ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_consgrph."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_consgrph = gt_consgrph.
    ENDIF.

    IF rt_consgrph IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_consgrph.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_consgrph ).
    ENDIF.
  ENDMETHOD.


  METHOD get_consunit.

    IF gt_consunit IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_consunit " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_consunit = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_consunit                                                           it_key_value = it_key_value ) ).
      LOOP AT gt_consunit ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_consunit."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_consunit = gt_consunit.
    ENDIF.

    IF rt_consunit IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_consunit.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_consunit ).
    ENDIF.
  ENDMETHOD.


  METHOD get_cuvers.

    IF gt_cuvers IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_cuvers " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_cuvers = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_cuvers                                                           it_key_value = it_key_value ) ).
      LOOP AT gt_cuvers ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_cuvers."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_cuvers = gt_cuvers.
    ENDIF.

    IF rt_cuvers IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_cuvers.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_cuvers ).
    ENDIF.
  ENDMETHOD.


  METHOD get_data_process.

    IF my_0g_data IS INITIAL.
      CREATE OBJECT my_0g_data.
    ENDIF.

    IF my_0g_data IS BOUND.
      ro_data_process ?= my_0g_data.
    ELSE.
*      Raise Exception
    ENDIF.

  ENDMETHOD.


  METHOD get_frs.

    IF gt_frs IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_entity_frs " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_frs = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_entity_frs                                                           it_key_value = it_key_value ) ).
      LOOP AT gt_frs ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_frs."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_frs = gt_frs.
    ENDIF.

    IF rt_frs IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_frs.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_frs ).
    ENDIF.
  ENDMETHOD.


  METHOD get_frsi.

    IF gt_frsi IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_entity_frsi " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_frsi = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_entity_frsi                                                           it_key_value = it_key_value ) ).
      LOOP AT gt_frsi ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_frsi."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_frsi = gt_frsi.
    ENDIF.

    IF rt_frsi IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_frsi.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_frsi ).
    ENDIF.
  ENDMETHOD.


  METHOD get_frsitxt.

    IF gt_frsitxt IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_entity_frsitxt " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_frsitxt = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_entity_frsitxt                                                           it_key_value = it_key_value ) ).
      LOOP AT gt_frsitxt ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_frsitxt."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_frsitxt = gt_frsitxt.
    ENDIF.

    IF rt_frsitxt IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_frsitxt.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_frsitxt ).
    ENDIF.
  ENDMETHOD.


  METHOD get_fsi.

    IF gt_fsi IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_entity_fsi " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_fsi = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_entity_fsi                                                           it_key_value = it_key_value ) ).
      LOOP AT gt_fsi ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_fsi."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_fsi = gt_fsi.
    ENDIF.

    IF rt_fsi IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_fsi.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_fsi ).
    ENDIF.
  ENDMETHOD.


  METHOD get_fsiaudit.

    IF gt_fsiaudit IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_fsiaudit " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_fsiaudit = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_fsiaudit                                                           it_key_value = it_key_value ) ).
      LOOP AT gt_fsiaudit ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_fsiaudit."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_fsiaudit = gt_fsiaudit.
    ENDIF.

    IF rt_fsiaudit IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_fsiaudit.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_fsiaudit ).
    ENDIF.
  ENDMETHOD.


  METHOD get_fsih.

    IF gt_fsih IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_fsih " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_fsih = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_fsih                                                           it_key_value = it_key_value ) ).
      LOOP AT gt_fsih ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_fsih."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_fsih = gt_fsih.
    ENDIF.

    IF rt_fsih IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_fsih.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_fsih ).
    ENDIF.
  ENDMETHOD.


  METHOD get_fsit.

    IF gt_fsit IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_fsit " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_fsit = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_fsit                                                           it_key_value = it_key_value ) ).
      LOOP AT gt_fsit ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_fsit."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_fsit = gt_fsit.
    ENDIF.

    IF rt_fsit IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_fsit.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_fsit ).
    ENDIF.
  ENDMETHOD.


  METHOD get_fsivers.

    IF gt_fsivers IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_fsivers " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_fsivers = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_fsivers                                                           it_key_value = it_key_value ) ).
      LOOP AT gt_fsivers ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_fsivers."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_fsivers = gt_fsivers.
    ENDIF.

    IF rt_fsivers IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_fsivers.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_fsivers ).
    ENDIF.
  ENDMETHOD.


  METHOD get_iordaudt.

    IF gt_iordaudt IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_iordaudt " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_iordaudt = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_iordaudt                                                           it_key_value = it_key_value ) ).
      LOOP AT gt_iordaudt ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_iordaudt."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_iordaudt = gt_iordaudt.
    ENDIF.

    IF rt_iordaudt IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_iordaudt.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_iordaudt ).
    ENDIF.
  ENDMETHOD.


  METHOD get_iorder.

    IF gt_iorder IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_iorder " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_iorder = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_iorder                                                           it_key_value = it_key_value ) ).
      LOOP AT gt_iorder ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_iorder."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_iorder = gt_iorder.
    ENDIF.

    IF rt_iorder IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_iorder.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_iorder ).
    ENDIF.
  ENDMETHOD.


  METHOD get_pcccass.

    IF gt_pcccass IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_pcccass " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_pcccass = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_pcccass                                                           it_key_value = it_key_value ) ).
      LOOP AT gt_pcccass ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_pcccass."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_pcccass = gt_pcccass.
    ENDIF.

    IF rt_pcccass IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_pcccass.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_pcccass ).
    ENDIF.
  ENDMETHOD.


  METHOD get_pctr.

    IF gt_pctr IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_pctr " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_pctr = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_pctr                                                           it_key_value = it_key_value ) ).
      LOOP AT gt_pctr ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_pctr."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_pctr = gt_pctr.
    ENDIF.

    IF rt_pctr IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_pctr.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_pctr ).
    ENDIF.
  ENDMETHOD.


  METHOD get_pctraudit.

    IF gt_pctraudit IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_pctraudit " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_pctraudit = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_pctraudit                                                           it_key_value = it_key_value ) ).
      LOOP AT gt_pctraudit ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_pctraudit."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_pctraudit = gt_pctraudit.
    ENDIF.

    IF rt_pctraudit IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_pctraudit.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_pctraudit ).
    ENDIF.
  ENDMETHOD.


  METHOD get_pctrg.

    IF gt_pctrg IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_pctrg " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_pctrg = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_pctrg                                                           it_key_value = it_key_value ) ).
      LOOP AT gt_pctrg ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_pctrg."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_pctrg = gt_pctrg.
    ENDIF.

    IF rt_pctrg IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_pctrg.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_pctrg ).
    ENDIF.
  ENDMETHOD.


  METHOD get_pctrh.

    IF gt_pctrh IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_pctrh " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_pctrh = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_pctrh                                                           it_key_value = it_key_value ) ).
      LOOP AT gt_pctrh ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_pctrh."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_pctrh = gt_pctrh.
    ENDIF.

    IF rt_pctrh IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_pctrh.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_pctrh ).
    ENDIF.
  ENDMETHOD.


  METHOD get_submpack.

    IF gt_submpack IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_entity_submpack " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_submpack = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_entity_submpack                                                           it_key_value = it_key_value ) ).
      LOOP AT gt_submpack ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_submpack."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_submpack = gt_submpack.
    ENDIF.

    IF rt_submpack IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_submpack.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_submpack ).
    ENDIF.
  ENDMETHOD.


  METHOD get_transtype.

    IF gt_transtype IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = gc_transtype " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_transtype = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity    = gc_transtype                                                           it_key_value = it_key_value ) ).
      LOOP AT gt_transtype ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_transtype."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_transtype = gt_transtype.
    ENDIF.

    IF rt_transtype IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_transtype.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_transtype ).
    ENDIF.
  ENDMETHOD.


  METHOD set_accccaudt.

    DATA lt_accccaudt TYPE gty_t_accccaudt.

    MOVE-CORRESPONDING it_data TO lt_accccaudt.
    LOOP AT lt_accccaudt ASSIGNING FIELD-SYMBOL(<ls_accccaudt>).
      READ TABLE gt_accccaudt FROM <ls_accccaudt> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_accccaudt FROM <ls_accccaudt>.
      ELSE.
        INSERT <ls_accccaudt> INTO TABLE gt_accccaudt.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_accccaudt
            is_record = <ls_accccaudt>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_accccdet.

    DATA lt_accccdet TYPE gty_t_accccdet.

    MOVE-CORRESPONDING it_data TO lt_accccdet.
    LOOP AT lt_accccdet ASSIGNING FIELD-SYMBOL(<ls_accccdet>).
      READ TABLE gt_accccdet FROM <ls_accccdet> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_accccdet FROM <ls_accccdet>.
      ELSE.
        INSERT <ls_accccdet> INTO TABLE gt_accccdet.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_entity_accccdet
            is_record = <ls_accccdet>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_accntaudt.

    DATA lt_accntaudt TYPE gty_t_accntaudt.

    MOVE-CORRESPONDING it_data TO lt_accntaudt.
    LOOP AT lt_accntaudt ASSIGNING FIELD-SYMBOL(<ls_accntaudt>).
      READ TABLE gt_accntaudt FROM <ls_accntaudt> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_accntaudt FROM <ls_accntaudt>.
      ELSE.
        INSERT <ls_accntaudt> INTO TABLE gt_accntaudt.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_accntaudt
            is_record = <ls_accntaudt>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_account.

    DATA lt_account TYPE gty_t_account.

    MOVE-CORRESPONDING it_data TO lt_account.
    LOOP AT lt_account ASSIGNING FIELD-SYMBOL(<ls_account>).
      READ TABLE gt_account FROM <ls_account> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_account FROM <ls_account>.
      ELSE.
        INSERT <ls_account> INTO TABLE gt_account.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_entity_account
            is_record = <ls_account>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bdc.

    DATA lt_bdc TYPE gty_t_bdc.

    MOVE-CORRESPONDING it_data TO lt_bdc.
    LOOP AT lt_bdc ASSIGNING FIELD-SYMBOL(<ls_bdc>).
      READ TABLE gt_bdc FROM <ls_bdc> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bdc FROM <ls_bdc>.
      ELSE.
        INSERT <ls_bdc> INTO TABLE gt_bdc.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_entity_bdc
            is_record = <ls_bdc>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bdcset.

    DATA lt_bdcset TYPE gty_t_bdcset.

    MOVE-CORRESPONDING it_data TO lt_bdcset.
    LOOP AT lt_bdcset ASSIGNING FIELD-SYMBOL(<ls_bdcset>).
      READ TABLE gt_bdcset FROM <ls_bdcset> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bdcset FROM <ls_bdcset>.
      ELSE.
        INSERT <ls_bdcset> INTO TABLE gt_bdcset.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_entity_bdcset
            is_record = <ls_bdcset>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_bdcsubsel.

    DATA lt_bdcsubsel TYPE gty_t_bdcsubsel.

    MOVE-CORRESPONDING it_data TO lt_bdcsubsel.
    LOOP AT lt_bdcsubsel ASSIGNING FIELD-SYMBOL(<ls_bdcsubsel>).
      READ TABLE gt_bdcsubsel FROM <ls_bdcsubsel> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_bdcsubsel FROM <ls_bdcsubsel>.
      ELSE.
        INSERT <ls_bdcsubsel> INTO TABLE gt_bdcsubsel.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_entity_bdcsubsel
            is_record = <ls_bdcsubsel>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_cctr.

    DATA lt_cctr TYPE gty_t_cctr.

    MOVE-CORRESPONDING it_data TO lt_cctr.
    LOOP AT lt_cctr ASSIGNING FIELD-SYMBOL(<ls_cctr>).
      READ TABLE gt_cctr FROM <ls_cctr> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_cctr FROM <ls_cctr>.
      ELSE.
        INSERT <ls_cctr> INTO TABLE gt_cctr.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_cctr
            is_record = <ls_cctr>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_cctraudit.

    DATA lt_cctraudit TYPE gty_t_cctraudit.

    MOVE-CORRESPONDING it_data TO lt_cctraudit.
    LOOP AT lt_cctraudit ASSIGNING FIELD-SYMBOL(<ls_cctraudit>).
      READ TABLE gt_cctraudit FROM <ls_cctraudit> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_cctraudit FROM <ls_cctraudit>.
      ELSE.
        INSERT <ls_cctraudit> INTO TABLE gt_cctraudit.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_cctraudit
            is_record = <ls_cctraudit>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_cctrg.

    DATA lt_cctrg TYPE gty_t_cctrg.

    MOVE-CORRESPONDING it_data TO lt_cctrg.
    LOOP AT lt_cctrg ASSIGNING FIELD-SYMBOL(<ls_cctrg>).
      READ TABLE gt_cctrg FROM <ls_cctrg> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_cctrg FROM <ls_cctrg>.
      ELSE.
        INSERT <ls_cctrg> INTO TABLE gt_cctrg.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_cctrg
            is_record = <ls_cctrg>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_cctrh.

    DATA lt_cctrh TYPE gty_t_cctrh.

    MOVE-CORRESPONDING it_data TO lt_cctrh.
    LOOP AT lt_cctrh ASSIGNING FIELD-SYMBOL(<ls_cctrh>).
      READ TABLE gt_cctrh FROM <ls_cctrh> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_cctrh FROM <ls_cctrh>.
      ELSE.
        INSERT <ls_cctrh> INTO TABLE gt_cctrh.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_cctrh
            is_record = <ls_cctrh>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_celem.

    DATA lt_celem TYPE gty_t_celem.

    MOVE-CORRESPONDING it_data TO lt_celem.
    LOOP AT lt_celem ASSIGNING FIELD-SYMBOL(<ls_celem>).
      READ TABLE gt_celem FROM <ls_celem> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_celem FROM <ls_celem>.
      ELSE.
        INSERT <ls_celem> INTO TABLE gt_celem.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_celem
            is_record = <ls_celem>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_celemaudt.

    DATA lt_celemaudt TYPE gty_t_celemaudt.

    MOVE-CORRESPONDING it_data TO lt_celemaudt.
    LOOP AT lt_celemaudt ASSIGNING FIELD-SYMBOL(<ls_celemaudt>).
      READ TABLE gt_celemaudt FROM <ls_celemaudt> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_celemaudt FROM <ls_celemaudt>.
      ELSE.
        INSERT <ls_celemaudt> INTO TABLE gt_celemaudt.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_celemaudt
            is_record = <ls_celemaudt>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_celemg.

    DATA lt_celemg TYPE gty_t_celemg.

    MOVE-CORRESPONDING it_data TO lt_celemg.
    LOOP AT lt_celemg ASSIGNING FIELD-SYMBOL(<ls_celemg>).
      READ TABLE gt_celemg FROM <ls_celemg> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_celemg FROM <ls_celemg>.
      ELSE.
        INSERT <ls_celemg> INTO TABLE gt_celemg.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_celemg
            is_record = <ls_celemg>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_celemh.

    DATA lt_celemh TYPE gty_t_celemh.

    MOVE-CORRESPONDING it_data TO lt_celemh.
    LOOP AT lt_celemh ASSIGNING FIELD-SYMBOL(<ls_celemh>).
      READ TABLE gt_celemh FROM <ls_celemh> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_celemh FROM <ls_celemh>.
      ELSE.
        INSERT <ls_celemh> INTO TABLE gt_celemh.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_celemh
            is_record = <ls_celemh>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_cggcurr.

    DATA lt_cggcurr TYPE gty_t_cggcurr.

    MOVE-CORRESPONDING it_data TO lt_cggcurr.
    LOOP AT lt_cggcurr ASSIGNING FIELD-SYMBOL(<ls_cggcurr>).
      READ TABLE gt_cggcurr FROM <ls_cggcurr> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_cggcurr FROM <ls_cggcurr>.
      ELSE.
        INSERT <ls_cggcurr> INTO TABLE gt_cggcurr.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_cggcurr
            is_record = <ls_cggcurr>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_company.

    DATA lt_company TYPE gty_t_company.

    MOVE-CORRESPONDING it_data TO lt_company.
    LOOP AT lt_company ASSIGNING FIELD-SYMBOL(<ls_company>).
      READ TABLE gt_company FROM <ls_company> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_company FROM <ls_company>.
      ELSE.
        INSERT <ls_company> INTO TABLE gt_company.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_company
            is_record = <ls_company>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_conschar.

    DATA lt_conschar TYPE gty_t_conschar.

    MOVE-CORRESPONDING it_data TO lt_conschar.
    LOOP AT lt_conschar ASSIGNING FIELD-SYMBOL(<ls_conschar>).
      READ TABLE gt_conschar FROM <ls_conschar> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_conschar FROM <ls_conschar>.
      ELSE.
        INSERT <ls_conschar> INTO TABLE gt_conschar.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_conschar
            is_record = <ls_conschar>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_consgrp.

    DATA lt_consgrp TYPE gty_t_consgrp.

    MOVE-CORRESPONDING it_data TO lt_consgrp.
    LOOP AT lt_consgrp ASSIGNING FIELD-SYMBOL(<ls_consgrp>).
      READ TABLE gt_consgrp FROM <ls_consgrp> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_consgrp FROM <ls_consgrp>.
      ELSE.
        INSERT <ls_consgrp> INTO TABLE gt_consgrp.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_consgrp
            is_record = <ls_consgrp>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_consgrph.

    DATA lt_consgrph TYPE gty_t_consgrph.

    MOVE-CORRESPONDING it_data TO lt_consgrph.
    LOOP AT lt_consgrph ASSIGNING FIELD-SYMBOL(<ls_consgrph>).
      READ TABLE gt_consgrph FROM <ls_consgrph> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_consgrph FROM <ls_consgrph>.
      ELSE.
        INSERT <ls_consgrph> INTO TABLE gt_consgrph.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_consgrph
            is_record = <ls_consgrph>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_consunit.

    DATA lt_consunit TYPE gty_t_consunit.

    MOVE-CORRESPONDING it_data TO lt_consunit.
    LOOP AT lt_consunit ASSIGNING FIELD-SYMBOL(<ls_consunit>).
      READ TABLE gt_consunit FROM <ls_consunit> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_consunit FROM <ls_consunit>.
      ELSE.
        INSERT <ls_consunit> INTO TABLE gt_consunit.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_consunit
            is_record = <ls_consunit>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_cuvers.

    DATA lt_cuvers TYPE gty_t_cuvers.

    MOVE-CORRESPONDING it_data TO lt_cuvers.
    LOOP AT lt_cuvers ASSIGNING FIELD-SYMBOL(<ls_cuvers>).
      READ TABLE gt_cuvers FROM <ls_cuvers> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_cuvers FROM <ls_cuvers>.
      ELSE.
        INSERT <ls_cuvers> INTO TABLE gt_cuvers.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_cuvers
            is_record = <ls_cuvers>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_frs.

    DATA lt_frs TYPE gty_t_frs.

    MOVE-CORRESPONDING it_data TO lt_frs.
    LOOP AT lt_frs ASSIGNING FIELD-SYMBOL(<ls_frs>).
      READ TABLE gt_frs FROM <ls_frs> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_frs FROM <ls_frs>.
      ELSE.
        INSERT <ls_frs> INTO TABLE gt_frs.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_entity_frs
            is_record = <ls_frs>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_frsi.

    DATA lt_frsi TYPE gty_t_frsi.

    MOVE-CORRESPONDING it_data TO lt_frsi.
    LOOP AT lt_frsi ASSIGNING FIELD-SYMBOL(<ls_frsi>).
      READ TABLE gt_frsi FROM <ls_frsi> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_frsi FROM <ls_frsi>.
      ELSE.
        INSERT <ls_frsi> INTO TABLE gt_frsi.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_entity_frsi
            is_record = <ls_frsi>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_frsitxt.

    DATA lt_frsitxt TYPE gty_t_frsitxt.

    MOVE-CORRESPONDING it_data TO lt_frsitxt.
    LOOP AT lt_frsitxt ASSIGNING FIELD-SYMBOL(<ls_frsitxt>).
      READ TABLE gt_frsitxt FROM <ls_frsitxt> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_frsitxt FROM <ls_frsitxt>.
      ELSE.
        INSERT <ls_frsitxt> INTO TABLE gt_frsitxt.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_entity_frsitxt
            is_record = <ls_frsitxt>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_fsi.

    DATA lt_fsi TYPE gty_t_fsi.

    MOVE-CORRESPONDING it_data TO lt_fsi.
    LOOP AT lt_fsi ASSIGNING FIELD-SYMBOL(<ls_fsi>).
      READ TABLE gt_fsi FROM <ls_fsi> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_fsi FROM <ls_fsi>.
      ELSE.
        INSERT <ls_fsi> INTO TABLE gt_fsi.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_entity_fsi
            is_record = <ls_fsi>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_fsiaudit.

    DATA lt_fsiaudit TYPE gty_t_fsiaudit.

    MOVE-CORRESPONDING it_data TO lt_fsiaudit.
    LOOP AT lt_fsiaudit ASSIGNING FIELD-SYMBOL(<ls_fsiaudit>).
      READ TABLE gt_fsiaudit FROM <ls_fsiaudit> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_fsiaudit FROM <ls_fsiaudit>.
      ELSE.
        INSERT <ls_fsiaudit> INTO TABLE gt_fsiaudit.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_fsiaudit
            is_record = <ls_fsiaudit>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_fsih.

    DATA lt_fsih TYPE gty_t_fsih.

    MOVE-CORRESPONDING it_data TO lt_fsih.
    LOOP AT lt_fsih ASSIGNING FIELD-SYMBOL(<ls_fsih>).
      READ TABLE gt_fsih FROM <ls_fsih> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_fsih FROM <ls_fsih>.
      ELSE.
        INSERT <ls_fsih> INTO TABLE gt_fsih.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_fsih
            is_record = <ls_fsih>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_fsit.

    DATA lt_fsit TYPE gty_t_fsit.

    MOVE-CORRESPONDING it_data TO lt_fsit.
    LOOP AT lt_fsit ASSIGNING FIELD-SYMBOL(<ls_fsit>).
      READ TABLE gt_fsit FROM <ls_fsit> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_fsit FROM <ls_fsit>.
      ELSE.
        INSERT <ls_fsit> INTO TABLE gt_fsit.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_fsit
            is_record = <ls_fsit>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_fsivers.

    DATA lt_fsivers TYPE gty_t_fsivers.

    MOVE-CORRESPONDING it_data TO lt_fsivers.
    LOOP AT lt_fsivers ASSIGNING FIELD-SYMBOL(<ls_fsivers>).
      READ TABLE gt_fsivers FROM <ls_fsivers> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_fsivers FROM <ls_fsivers>.
      ELSE.
        INSERT <ls_fsivers> INTO TABLE gt_fsivers.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_fsivers
            is_record = <ls_fsivers>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_iordaudt.

    DATA lt_iordaudt TYPE gty_t_iordaudt.

    MOVE-CORRESPONDING it_data TO lt_iordaudt.
    LOOP AT lt_iordaudt ASSIGNING FIELD-SYMBOL(<ls_iordaudt>).
      READ TABLE gt_iordaudt FROM <ls_iordaudt> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_iordaudt FROM <ls_iordaudt>.
      ELSE.
        INSERT <ls_iordaudt> INTO TABLE gt_iordaudt.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_iordaudt
            is_record = <ls_iordaudt>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_iorder.

    DATA lt_iorder TYPE gty_t_iorder.

    MOVE-CORRESPONDING it_data TO lt_iorder.
    LOOP AT lt_iorder ASSIGNING FIELD-SYMBOL(<ls_iorder>).
      READ TABLE gt_iorder FROM <ls_iorder> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_iorder FROM <ls_iorder>.
      ELSE.
        INSERT <ls_iorder> INTO TABLE gt_iorder.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_iorder
            is_record = <ls_iorder>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_pcccass.

    DATA lt_pcccass TYPE gty_t_pcccass.

    MOVE-CORRESPONDING it_data TO lt_pcccass.
    LOOP AT lt_pcccass ASSIGNING FIELD-SYMBOL(<ls_pcccass>).
      READ TABLE gt_pcccass FROM <ls_pcccass> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_pcccass FROM <ls_pcccass>.
      ELSE.
        INSERT <ls_pcccass> INTO TABLE gt_pcccass.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_pcccass
            is_record = <ls_pcccass>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_pctr.

    DATA lt_pctr TYPE gty_t_pctr.

    MOVE-CORRESPONDING it_data TO lt_pctr.
    LOOP AT lt_pctr ASSIGNING FIELD-SYMBOL(<ls_pctr>).
      READ TABLE gt_pctr FROM <ls_pctr> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_pctr FROM <ls_pctr>.
      ELSE.
        INSERT <ls_pctr> INTO TABLE gt_pctr.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_pctr
            is_record = <ls_pctr>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_pctraudit.

    DATA lt_pctraudit TYPE gty_t_pctraudit.

    MOVE-CORRESPONDING it_data TO lt_pctraudit.
    LOOP AT lt_pctraudit ASSIGNING FIELD-SYMBOL(<ls_pctraudit>).
      READ TABLE gt_pctraudit FROM <ls_pctraudit> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_pctraudit FROM <ls_pctraudit>.
      ELSE.
        INSERT <ls_pctraudit> INTO TABLE gt_pctraudit.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_pctraudit
            is_record = <ls_pctraudit>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_pctrg.

    DATA lt_pctrg TYPE gty_t_pctrg.

    MOVE-CORRESPONDING it_data TO lt_pctrg.
    LOOP AT lt_pctrg ASSIGNING FIELD-SYMBOL(<ls_pctrg>).
      READ TABLE gt_pctrg FROM <ls_pctrg> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_pctrg FROM <ls_pctrg>.
      ELSE.
        INSERT <ls_pctrg> INTO TABLE gt_pctrg.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_pctrg
            is_record = <ls_pctrg>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_pctrh.

    DATA lt_pctrh TYPE gty_t_pctrh.

    MOVE-CORRESPONDING it_data TO lt_pctrh.
    LOOP AT lt_pctrh ASSIGNING FIELD-SYMBOL(<ls_pctrh>).
      READ TABLE gt_pctrh FROM <ls_pctrh> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_pctrh FROM <ls_pctrh>.
      ELSE.
        INSERT <ls_pctrh> INTO TABLE gt_pctrh.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_pctrh
            is_record = <ls_pctrh>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_submpack.

    DATA lt_submpack TYPE gty_t_submpack.

    MOVE-CORRESPONDING it_data TO lt_submpack.
    LOOP AT lt_submpack ASSIGNING FIELD-SYMBOL(<ls_submpack>).
      READ TABLE gt_submpack FROM <ls_submpack> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_submpack FROM <ls_submpack>.
      ELSE.
        INSERT <ls_submpack> INTO TABLE gt_submpack.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_entity_submpack
            is_record = <ls_submpack>.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_transtype.

    DATA lt_transtype TYPE gty_t_transtype.

    MOVE-CORRESPONDING it_data TO lt_transtype.
    LOOP AT lt_transtype ASSIGNING FIELD-SYMBOL(<ls_transtype>).
      READ TABLE gt_transtype FROM <ls_transtype> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_transtype FROM <ls_transtype>.
      ELSE.
        INSERT <ls_transtype> INTO TABLE gt_transtype.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = gc_transtype
            is_record = <ls_transtype>.

      ENDIF.
    ENDLOOP.

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

        LOOP AT lt_entity_mod INTO DATA(ls_entity_mod).
          IF ls_entity_mod-struct EQ gc_kattr.



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
ENDCLASS.
