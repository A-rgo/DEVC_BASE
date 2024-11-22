interface YZ_INTF_MDG_DATA_PROCESS
  public .


  interfaces IF_DRF_CONST .
  interfaces IF_EHFND_UI_CONSTANTS_C .
  interfaces IF_FPM_CONSTANTS .
  interfaces IF_MDG_CONSTANTS .
  interfaces IF_MDG_IDSC_CONST .
  interfaces IF_MDG_OTC_CONST .
  interfaces IF_USMD_CR_CONSTANTS .
  interfaces IF_USMD_CR_MASTER .
  interfaces IF_USMD_SEARCH_CONSTANTS .
  interfaces IF_XO_CONST_MESSAGE .
  interfaces YZ_INTF_MDG_CONST .
  interfaces YZ_INTF_MDG_CONST_EXT .
  interfaces YZ_INTF_MDG_UTILITY_CONST .

  methods SET_ENTITY_DATA
    importing
      !IO_CHANGED_DATA type ref to IF_USMD_DELTA_BUFFER_READ optional
      !IV_ENTITY type USMD_ENTITY optional
      !IT_DATA type ANY TABLE optional .
  methods GET_ENTITY_DATA
    importing
      !IV_CREQUEST type USMD_CREQUEST optional
      !IV_ENTITY type USMD_ENTITY
      !IV_READMODE type USMD_READMODE_EXT default YZ_INTF_MDG_UTILITY_CONST~GC_READMODE_ACT_INACT
      !IT_KEY_VALUE type YZTABL_T_KEY_VALUE optional
    exporting
      !ER_DATA type ref to DATA
      !ET_DATA type ANY TABLE .
endinterface.
