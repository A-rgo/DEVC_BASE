interface YZ_INTF_MDG_BP_CONST
  public .


  interfaces IF_FSBP_CONST_PARTNER_TYPE .
  interfaces IF_FSBP_GENERIC_CONSTANTS .
  interfaces IF_MDG_BP_CONSTANTS .
  interfaces IF_MDG_BS_ECC_BP_CONSTANTS .
  interfaces IF_MDG_BS_ECC_BP_DEFS .

  constants GC_BP_HEADER type USMD_ENTITY value 'BP_HEADER' ##NO_TEXT.
  constants GC_ADDRESS type USMD_ENTITY value 'ADDRESS' ##NO_TEXT.
  constants GC_AD_EMAIL type USMD_ENTITY value 'AD_EMAIL' ##NO_TEXT.
  constants GC_AD_FAX type USMD_ENTITY value 'AD_FAX' ##NO_TEXT.
  constants GC_AD_NAME_O type USMD_ENTITY value 'AD_NAME_O' ##NO_TEXT.
  constants GC_AD_NAME_P type USMD_ENTITY value 'AD_NAME_P' ##NO_TEXT.
  constants GC_AD_POSTAL type USMD_ENTITY value 'AD_POSTAL' ##NO_TEXT.
  constants GC_AD_TEL type USMD_ENTITY value 'AD_TEL' ##NO_TEXT.
  constants GC_AD_URL type USMD_ENTITY value 'AD_URL' ##NO_TEXT.
  constants GC_BP_ADDDEP type USMD_ENTITY value 'BP_ADDDEP' ##NO_TEXT.
  constants GC_BP_ADDR type USMD_ENTITY value 'BP_ADDR' ##NO_TEXT.
  constants GC_BP_ADDUSG type USMD_ENTITY value 'BP_ADDUSG' ##NO_TEXT.
  constants GC_BP_BKDTL type USMD_ENTITY value 'BP_BKDTL' ##NO_TEXT.
  constants GC_BP_CCDTL type USMD_ENTITY value 'BP_CCDTL' ##NO_TEXT.
  constants GC_BP_CENTRL type USMD_ENTITY value 'BP_CENTRL' ##NO_TEXT.
  constants GC_BP_COMPNY type USMD_ENTITY value 'BP_COMPNY' ##NO_TEXT.
  constants GC_BP_CPGEN type USMD_ENTITY value 'BP_CPGEN' ##NO_TEXT.
  constants GC_BP_CUSCLA type USMD_ENTITY value 'BP_CUSCLA' ##NO_TEXT.
  constants GC_BP_CUSDDB type USMD_ENTITY value 'BP_CUSDDB' ##NO_TEXT.
  constants GC_BP_CUSDUN type USMD_ENTITY value 'BP_CUSDUN' ##NO_TEXT.
  constants GC_BP_CUSFCN type USMD_ENTITY value 'BP_CUSFCN' ##NO_TEXT.
  constants GC_BP_CUSGEN type USMD_ENTITY value 'BP_CUSGEN' ##NO_TEXT.
  constants GC_BP_CUSTAX type USMD_ENTITY value 'BP_CUSTAX' ##NO_TEXT.
  constants GC_BP_CUSULP type USMD_ENTITY value 'BP_CUSULP' ##NO_TEXT.
  constants GC_BP_CUSVAL type USMD_ENTITY value 'BP_CUSVAL' ##NO_TEXT.
  constants GC_BP_CUSWHT type USMD_ENTITY value 'BP_CUSWHT' ##NO_TEXT.
  constants GC_BP_CUS_CC type USMD_ENTITY value 'BP_CUS_CC' ##NO_TEXT.
  constants GC_BP_DUNN type USMD_ENTITY value 'BP_DUNN' ##NO_TEXT.
  constants GC_BP_EMAIL type USMD_ENTITY value 'BP_EMAIL' ##NO_TEXT.
  constants GC_BP_FAX type USMD_ENTITY value 'BP_FAX' ##NO_TEXT.
  constants GC_BP_IDNUM type USMD_ENTITY value 'BP_IDNUM' ##NO_TEXT.
  constants GC_BP_INDSTR type USMD_ENTITY value 'BP_INDSTR' ##NO_TEXT.
  constants GC_BP_MLT_AD type USMD_ENTITY value 'BP_MLT_AD' ##NO_TEXT.
  constants GC_BP_MLT_AS type USMD_ENTITY value 'BP_MLT_AS' ##NO_TEXT.
  constants GC_BP_PORG type USMD_ENTITY value 'BP_PORG' ##NO_TEXT.
  constants GC_BP_PORG2 type USMD_ENTITY value 'BP_PORG2' ##NO_TEXT.
  constants GC_BP_ROLE type USMD_ENTITY value 'BP_ROLE' ##NO_TEXT.
  constants GC_BP_SALES type USMD_ENTITY value 'BP_SALES' ##NO_TEXT.
  constants GC_BP_TAXGRP type USMD_ENTITY value 'BP_TAXGRP' ##NO_TEXT.
  constants GC_BP_TAXNUM type USMD_ENTITY value 'BP_TAXNUM' ##NO_TEXT.
  constants GC_BP_TAX_AD type USMD_ENTITY value 'BP_TAX_AD' ##NO_TEXT.
  constants GC_BP_TEL type USMD_ENTITY value 'BP_TEL' ##NO_TEXT.
  constants GC_BP_URL type USMD_ENTITY value 'BP_URL' ##NO_TEXT.
  constants GC_BP_VENCLA type USMD_ENTITY value 'BP_VENCLA' ##NO_TEXT.
  constants GC_BP_VENDDB type USMD_ENTITY value 'BP_VENDDB' ##NO_TEXT.
  constants GC_BP_VENFCN type USMD_ENTITY value 'BP_VENFCN' ##NO_TEXT.
  constants GC_BP_VENGEN type USMD_ENTITY value 'BP_VENGEN' ##NO_TEXT.
  constants GC_BP_VENSUB type USMD_ENTITY value 'BP_VENSUB' ##NO_TEXT.
  constants GC_BP_VENVAL type USMD_ENTITY value 'BP_VENVAL' ##NO_TEXT.
  constants GC_BP_WHTAX type USMD_ENTITY value 'BP_WHTAX' ##NO_TEXT.
  constants GC_BP_WPAD type USMD_ENTITY value 'BP_WPAD' ##NO_TEXT.
  constants GC_CUSCCTXT type USMD_ENTITY value 'CUSCCTXT' ##NO_TEXT.
  constants GC_CUSGENTXT type USMD_ENTITY value 'CUSGENTXT' ##NO_TEXT.
  constants GC_CUSSALTXT type USMD_ENTITY value 'CUSSALTXT' ##NO_TEXT.
  constants GC_FKKLOCKS type USMD_ENTITY value 'FKKLOCKS' ##NO_TEXT.
  constants GC_FKKTAXEX type USMD_ENTITY value 'FKKTAXEX' ##NO_TEXT.
  constants GC_FKKTXT type USMD_ENTITY value 'FKKTXT' ##NO_TEXT.
  constants GC_FKKVKCORR type USMD_ENTITY value 'FKKVKCORR' ##NO_TEXT.
  constants GC_FKKVKP type USMD_ENTITY value 'FKKVKP' ##NO_TEXT.
  constants GC_FKKVKTD type USMD_ENTITY value 'FKKVKTD' ##NO_TEXT.
  constants GC_FS_BKK21 type USMD_ENTITY value 'FS_BKK21' ##NO_TEXT.
  constants GC_FS_BP001 type USMD_ENTITY value 'FS_BP001' ##NO_TEXT.
  constants GC_FS_BP011 type USMD_ENTITY value 'FS_BP011' ##NO_TEXT.
  constants GC_FS_BP021 type USMD_ENTITY value 'FS_BP021' ##NO_TEXT.
  constants GC_FS_BP1010 type USMD_ENTITY value 'FS_BP1010' ##NO_TEXT.
  constants GC_FS_BP1012 type USMD_ENTITY value 'FS_BP1012' ##NO_TEXT.
  constants GC_FS_BP1030 type USMD_ENTITY value 'FS_BP1030' ##NO_TEXT.
  constants GC_FS_BPBANK type USMD_ENTITY value 'FS_BPBANK' ##NO_TEXT.
  constants GC_FS_BPTAXC type USMD_ENTITY value 'FS_BPTAXC' ##NO_TEXT.
  constants GC_VENCCTXT type USMD_ENTITY value 'VENCCTXT' ##NO_TEXT.
  constants GC_VENGENTXT type USMD_ENTITY value 'VENGENTXT' ##NO_TEXT.
  constants GC_VENPOTXT type USMD_ENTITY value 'VENPOTXT' ##NO_TEXT.
  constants GC_WP_EMAIL type USMD_ENTITY value 'WP_EMAIL' ##NO_TEXT.
  constants GC_WP_FAX type USMD_ENTITY value 'WP_FAX' ##NO_TEXT.
  constants GC_WP_POSTAL type USMD_ENTITY value 'WP_POSTAL' ##NO_TEXT.
  constants GC_WP_TEL type USMD_ENTITY value 'WP_TEL' ##NO_TEXT.
  constants GC_WP_URL type USMD_ENTITY value 'WP_URL' ##NO_TEXT.
  constants GC_BP_REL type USMD_ENTITY value 'BP_REL' ##NO_TEXT.
  constants GC_BP_HRCHY type USMD_ENTITY value 'BP_HRCHY' ##NO_TEXT.
  constants GC_BP_SUBHRY type USMD_ENTITY value 'BP_SUBHRY' ##NO_TEXT.
endinterface.
