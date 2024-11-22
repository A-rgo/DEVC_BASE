class YZ_CLAS_MDG_BP_RULE_PROCESS definition
  public
  final
  create public .

public section.

  interfaces YZ_INTF_MDG_RULE_PROCESS .

  aliases EXECUTE_DYNAMIC_CLASS_METHOD
    for YZ_INTF_MDG_RULE_PROCESS~EXECUTE_DYNAMIC_CLASS_METHOD .

  methods CONSTRUCTOR .
  class-methods GET_RULE_PROCESS
    returning
      value(RO_RULE_PROCESS) type ref to YZ_INTF_MDG_RULE_PROCESS .
  class-methods GET_CURRENT_BP
    importing
      !IO_BP_DATA type ref to YZ_CLAS_MDG_BP_DATA_PROCESS
    returning
      value(RV_BP) type BU_PARTNER .
  class-methods GET_CURRENT_BP_FROM_FPM_PARA
    returning
      value(RV_BP) type BU_PARTNER .
  class-methods GET_MDG_FIELDNAMES .
  PRIVATE SECTION.
    CLASS-DATA my_bp_rule TYPE REF TO yz_clas_mdg_bp_rule_process.
    CLASS-DATA gt_mdg_fieldnames TYPE mdg_bs_bp_fldgrp_t .

ENDCLASS.



CLASS YZ_CLAS_MDG_BP_RULE_PROCESS IMPLEMENTATION.


  METHOD constructor.
    super->constructor( ).
  ENDMETHOD.


  METHOD get_rule_process.
    IF my_bp_rule IS INITIAL.
      CREATE OBJECT my_bp_rule.
    ENDIF.

    IF my_bp_rule IS BOUND.
      ro_rule_process ?= my_bp_rule.
    ELSE.
*      Raise Exception
    ENDIF.
  ENDMETHOD.


  METHOD get_current_bp.
*    DATA:
*      lt_bp_header TYPE yZ_IntF_MDG_BP_DATA_TYPES=>gty_t_bp_header,
*      ls_bp_header TYPE /mdgbp/_s_bp_pp_bp_header.
*
*
*    CALL METHOD get_current_bp_from_fpm_para
*      RECEIVING
*        rv_bp = rv_bp.
*
**    IF rv_bp IS INITIAL.
**      CALL METHOD io_bp_data->get_bp_header
**        IMPORTING
**          et_bp_header = lt_bp_header.
**      READ TABLE lt_bp_header INDEX 1 INTO ls_bp_header.
**      rv_bp = ls_bp_header-bp_header.
**    ENDIF.
*
*    IF rv_bp IS INITIAL.
*      READ TABLE io_bp_data->get_bp_header INDEX 1 INTO ls_bp_header.
*      rv_bp = ls_bp_header-bp_header.
*    ENDIF.
*
*    ASSERT rv_bp IS NOT INITIAL.
  ENDMETHOD.


  METHOD get_current_bp_from_fpm_para.
    DATA:
      lo_fpm TYPE REF TO if_fpm.

*&---Get the handle to the IF_FPM interface.
    lo_fpm = cl_fpm_factory=>get_instance( ).

*&---Get the parameter change request no. from FPM
    lo_fpm->mo_app_parameter->get_value(
      EXPORTING
        iv_key   = 'BP_HEADER'
      IMPORTING
        ev_value = rv_bp
    ).
  ENDMETHOD.


  METHOD get_mdg_fieldnames.
    DATA:
      lo_model_ext   TYPE REF TO if_usmd_model_ext,
      lo_bp_services TYPE REF TO cl_mdg_bs_fnd_bp_services,
      ls_fld_grp     TYPE mdg_bs_bp_fldgrp,
      lt_fld_grp     TYPE mdg_bs_bp_fldgrp_t,
      lt_fldmap_ecc  TYPE usmd_ts_map_struc.

    FIELD-SYMBOLS:
      <ls_entity_prop> TYPE usmd_s_entity_prop_ext,
      <ls_fldmap_ecc>  TYPE usmd_s_map_struc.

    IF gt_mdg_fieldnames IS INITIAL.

      CREATE OBJECT lo_bp_services.

      CALL METHOD cl_usmd_model_ext=>get_instance(
        EXPORTING
          i_usmd_model = if_mdg_bp_constants=>gc_bp_model    " Data model
        IMPORTING
          eo_instance  = lo_model_ext ).   " MDM Data Model for Access from Non-SAP Standard

      LOOP AT lo_model_ext->dt_entity_prop ASSIGNING <ls_entity_prop>
                                               WHERE usage_type EQ if_usmd_dm_const=>usage_type_1 OR
                                                     usage_type EQ if_usmd_dm_const=>usage_type_4. "#EC CI_SORTSEQ
        CLEAR:lt_fld_grp,lt_fldmap_ecc.

        lo_bp_services->get_fieldmapping_for_entity(
          EXPORTING
            io_model             = lo_model_ext     " MDG Data Model for Access from Non-SAP Standard Code
            iv_entity            = <ls_entity_prop>-usmd_entity    " Entity Type
          IMPORTING
            et_bp_fldgrp         =  lt_fld_grp       " MDG BP: table type for MDG_BS_BP_FLDGRP
            et_field_mapping_ecc =  lt_fldmap_ecc ).  " Table for Mapping Long Field Names

        APPEND LINES OF lt_fld_grp TO gt_mdg_fieldnames.

        LOOP AT lt_fldmap_ecc ASSIGNING <ls_fldmap_ecc>.
          ls_fld_grp-model      = if_mdg_bp_constants=>gc_bp_model.
          ls_fld_grp-entity     = <ls_fldmap_ecc>-usmd_entity.
          ls_fld_grp-bapifldnm  = <ls_fldmap_ecc>-fld_source.
          ls_fld_grp-attribute  = <ls_fldmap_ecc>-fieldname.
          APPEND ls_fld_grp TO gt_mdg_fieldnames.
        ENDLOOP.
      ENDLOOP.
    ENDIF.

*    rt_field_names = gt_mdg_fieldnames.

  ENDMETHOD.
ENDCLASS.
