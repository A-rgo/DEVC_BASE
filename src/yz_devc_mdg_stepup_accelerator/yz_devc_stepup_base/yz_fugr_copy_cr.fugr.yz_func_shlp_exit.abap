FUNCTION yz_func_shlp_exit.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  TABLES
*"      SHLP_TAB TYPE  SHLP_DESCT
*"      RECORD_TAB STRUCTURE  SEAHLPRES
*"  CHANGING
*"     VALUE(SHLP) TYPE  SHLP_DESCR
*"     VALUE(CALLCONTROL) LIKE  DDSHF4CTRL STRUCTURE  DDSHF4CTRL
*"----------------------------------------------------------------------
  DATA model     TYPE usmd_model.
  DATA otc       TYPE usmd_otc.
  DATA entity    TYPE usmd_entity.
  DATA attribute TYPE usmd_attribute.

* EXIT immediately, if you do not want to handle this step
  IF callcontrol-step <> 'SELONE' AND
     callcontrol-step <> 'SELECT' AND
     " AND SO ON
     callcontrol-step <> 'DISP'.
    EXIT.
  ENDIF.

*"----------------------------------------------------------------------
* STEP SELONE  (Select one of the elementary searchhelps)
*"----------------------------------------------------------------------
* This step is only called for collective searchhelps. It may be used
* to reduce the amount of elementary searchhelps given in SHLP_TAB.
* The compound searchhelp is given in SHLP.
* If you do not change CALLCONTROL-STEP, the next step is the
* dialog, to select one of the elementary searchhelps.
* If you want to skip this dialog, you have to return the selected
* elementary searchhelp in SHLP and to change CALLCONTROL-STEP to
* either to 'PRESEL' or to 'SELECT'.
  IF callcontrol-step = 'SELONE'.
*   PERFORM SELONE .........
    EXIT.
  ENDIF.

*"----------------------------------------------------------------------
* STEP PRESEL  (Enter selection conditions)
*"----------------------------------------------------------------------
* This step allows you, to influence the selection conditions either
* before they are displayed or in order to skip the dialog completely.
* If you want to skip the dialog, you should change CALLCONTROL-STEP
* to 'SELECT'.
* Normaly only SHLP-SELOPT should be changed in this step.
  IF callcontrol-step = 'PRESEL'.
*   PERFORM PRESEL ..........
    GET PARAMETER ID 'YZ_PARAM_MODEL' FIELD model.
    IF model IS NOT INITIAL AND shlp-shlpname <> 'YZ_SHLP_RULE_REF_MOD'.
      shlp-selopt = VALUE #(
      ( shlpname  = shlp-shlpname shlpfield = 'MODEL' sign = 'I' option = 'EQ'  low = model ) ).
    ELSE.
      model = VALUE #( shlp-selopt[ shlpfield = 'MODEL' sign = 'I' ]-low OPTIONAL ).
      SELECT COUNT(*) FROM yztabl_ref_data WHERE model = model.
      IF sy-subrc = 0.
        SET PARAMETER ID 'YZ_PARAM_MODEL' FIELD model.
      ENDIF.
    ENDIF.
    GET PARAMETER ID 'YZ_PARAM_OTC' FIELD otc.
    IF otc IS NOT INITIAL AND shlp-shlpname <> 'YZ_SHLP_RULE_REF_OTC'.
      shlp-selopt = VALUE #(
      ( shlpname   = shlp-shlpname shlpfield  = 'MODEL' sign = 'I' option = 'EQ'  low = model )
      ( shlpname  = shlp-shlpname  shlpfield  = 'OTC'   sign = 'I' option = 'EQ'  low = otc )
      ).
    ELSE.
      otc = VALUE #( shlp-selopt[ shlpfield = 'OTC' sign = 'I' ]-low OPTIONAL ).
      SELECT COUNT(*) FROM yztabl_ref_data WHERE otc = otc.
      IF sy-subrc = 0.
        SET PARAMETER ID 'YZ_PARAM_OTC' FIELD otc.
      ENDIF.
    ENDIF.
    GET PARAMETER ID 'YZ_PARAM_ENTITY' FIELD entity.
    IF otc IS NOT INITIAL AND shlp-shlpname <> 'YZ_SHLP_RULE_REF_ENT'.
      shlp-selopt = VALUE #(
      ( shlpname   = shlp-shlpname shlpfield = 'MODEL'  sign = 'I'  option = 'EQ'  low = model )
      ( shlpname  = shlp-shlpname  shlpfield = 'OTC'    sign = 'I'  option = 'EQ'  low = otc )
      ( shlpname  = shlp-shlpname  shlpfield = 'ENTITY' sign = 'I'  option = 'EQ'  low = entity )
      ).
    ELSE.
      entity = VALUE #( shlp-selopt[ shlpfield = 'ENTITY' sign = 'I' ]-low OPTIONAL ).
      SELECT COUNT(*) FROM yztabl_ref_data WHERE model = model AND otc = otc AND entity = entity.
      IF sy-subrc = 0.
        SET PARAMETER ID 'YZ_PARAM_ENTITY' FIELD entity.
      ENDIF.
    ENDIF.
    EXIT.
  ENDIF.
*"----------------------------------------------------------------------
* STEP SELECT    (Select values)
*"----------------------------------------------------------------------
* This step may be used to overtake the data selection completely.
* To skip the standard seletion, you should return 'DISP' as following
* step in CALLCONTROL-STEP.
* Normally RECORD_TAB should be filled after this step.
* Standard function module F4UT_RESULTS_MAP may be very helpfull in this
* step.
  IF callcontrol-step = 'SELECT'.
*   PERFORM STEP_SELECT TABLES RECORD_TAB SHLP_TAB
*                       CHANGING SHLP CALLCONTROL RC.
*   IF RC = 0.
*     CALLCONTROL-STEP = 'DISP'.
*   ELSE.
*     CALLCONTROL-STEP = 'EXIT'.
*   ENDIF.
    GET PARAMETER ID 'YZ_PARAM_MODEL' FIELD model.
    IF model IS NOT INITIAL AND shlp-shlpname <> 'YZ_SHLP_RULE_REF_MOD'.
      shlp-selopt = VALUE #(
      ( shlpname  = shlp-shlpname shlpfield = 'MODEL' sign = 'I' option = 'EQ'  low = model ) ).
    ELSE.
      model = VALUE #( shlp-selopt[ shlpfield = 'MODEL' sign = 'I' ]-low OPTIONAL ).
      SELECT COUNT(*) FROM yztabl_ref_data WHERE model = model.
      IF sy-subrc = 0.
        SET PARAMETER ID 'YZ_PARAM_MODEL' FIELD model.
      ENDIF.
    ENDIF.
    GET PARAMETER ID 'YZ_PARAM_OTC' FIELD otc.
    IF otc IS NOT INITIAL AND shlp-shlpname <> 'YZ_SHLP_RULE_REF_OTC'.
      shlp-selopt = VALUE #(
      ( shlpname   = shlp-shlpname shlpfield  = 'MODEL' sign = 'I' option = 'EQ'  low = model )
      ( shlpname  = shlp-shlpname  shlpfield  = 'OTC'   sign = 'I' option = 'EQ'  low = otc )
      ).
    ELSE.
      otc = VALUE #( shlp-selopt[ shlpfield = 'OTC' sign = 'I' ]-low OPTIONAL ).
      SELECT COUNT(*) FROM yztabl_ref_data WHERE otc = otc.
      IF sy-subrc = 0.
        SET PARAMETER ID 'YZ_PARAM_OTC' FIELD otc.
      ENDIF.
    ENDIF.
    GET PARAMETER ID 'YZ_PARAM_ENTITY' FIELD entity.
    IF otc IS NOT INITIAL AND shlp-shlpname <> 'YZ_SHLP_RULE_REF_ENT'.
      shlp-selopt = VALUE #(
      ( shlpname   = shlp-shlpname shlpfield = 'MODEL'  sign = 'I'  option = 'EQ'  low = model )
      ( shlpname  = shlp-shlpname  shlpfield = 'OTC'    sign = 'I'  option = 'EQ'  low = otc )
      ( shlpname  = shlp-shlpname  shlpfield = 'ENTITY' sign = 'I'  option = 'EQ'  low = entity )
      ).
    ELSE.
      entity = VALUE #( shlp-selopt[ shlpfield = 'ENTITY' sign = 'I' ]-low OPTIONAL ).
      SELECT COUNT(*) FROM yztabl_ref_data WHERE model = model AND otc = otc AND entity = entity.
      IF sy-subrc = 0.
        SET PARAMETER ID 'YZ_PARAM_ENTITY' FIELD entity.
      ENDIF.
    ENDIF.
    EXIT. "Don't process STEP DISP additionally in this call.
  ENDIF.
*"----------------------------------------------------------------------
* STEP DISP     (Display values)
*"----------------------------------------------------------------------
* This step is called, before the selected data is displayed.
* You can e.g. modify or reduce the data in RECORD_TAB
* according to the users authority.
* If you want to get the standard display dialog afterwards, you
* should not change CALLCONTROL-STEP.
* If you want to overtake the dialog on you own, you must return
* the following values in CALLCONTROL-STEP:
* - "RETURN" if one line was selected. The selected line must be
*   the only record left in RECORD_TAB. The corresponding fields of
*   this line are entered into the screen.
* - "EXIT" if the values request should be aborted
* - "PRESEL" if you want to return to the selection dialog
* Standard function modules F4UT_PARAMETER_VALUE_GET and
* F4UT_PARAMETER_RESULTS_PUT may be very helpfull in this step.
  IF callcontrol-step = 'DISP'.
*   PERFORM AUTHORITY_CHECK TABLES RECORD_TAB SHLP_TAB
*                           CHANGING SHLP CALLCONTROL.
    EXIT.
  ENDIF.
ENDFUNCTION.
