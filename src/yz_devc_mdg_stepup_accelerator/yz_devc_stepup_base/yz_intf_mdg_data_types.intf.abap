interface YZ_INTF_MDG_DATA_TYPES
  public .


  types:
    BEGIN OF gty_s_key_value,
      key_field TYPE usmd_attribute,
      value     TYPE smt_fixed_value,
    END OF gty_s_key_value .
    types:
    BEGIN OF gty_s_range_table,
      SIGN TYPE TVARV_SIGN,
      OPTI     TYPE TVARV_OPTI,
      HIGH     TYPE RVARI_VAL_255,
      LOW     TYPE RVARI_VAL_255,
    END OF gty_s_range_table .
  types:
    BEGIN OF gty_s_entity_attributes_rel,
      entity     TYPE usmd_entity,
      attributes TYPE usmd_t_attribute,
    END OF gty_s_entity_attributes_rel .
  types:
    BEGIN OF gty_s_attribute_entity_rel,
      attribute TYPE usmd_attribute,
      entity    TYPE usmd_entity,
    END OF gty_s_attribute_entity_rel .
  types:
    BEGIN OF gty_s_entity_info,
      entity           TYPE usmd_entity,
      get_meth         TYPE seocpdname,
      set_meth         TYPE seocpdname,
      del_meth         TYPE seocpdname,
      structure        TYPE strukname,
      tab_type         TYPE string,
      get_meth_exp_tab TYPE seosconame,
      set_meth_imp_tab TYPE seosconame,
      del_meth_imp_tab TYPE seosconame,
    END OF gty_s_entity_info .
  types:
    BEGIN OF gty_s_entity_attribute,
      entity    TYPE usmd_entity,
      attribute TYPE usmd_attribute,
    END OF gty_s_entity_attribute .
  types:
    gty_t_entity_attribute TYPE SORTED TABLE OF gty_s_entity_attribute WITH UNIQUE KEY entity attribute .
  types:
    BEGIN OF gty_s_entity_data,
      entity             TYPE usmd_entity,
      struct             TYPE usmd_struct,
      entity_data        TYPE REF TO data,
      changed_attributes TYPE gty_t_entity_attribute,
    END OF gty_s_entity_data .
  types:
    BEGIN OF gty_s_dependent_entities,
      entity             TYPE usmd_entity,
      dependent_entities TYPE usmd_t_entity,
    END OF gty_s_dependent_entities .
  types:
    BEGIN OF gty_s_fld_prop,
      entity         TYPE usmd_entity,
      fieldname      TYPE usmd_attribute,
      fld_prop_value TYPE YZ_DTEL_FLD_PROP_VALUE,
    END OF gty_s_fld_prop .
  types:
    BEGIN OF gty_s_ent_prop,
      entity      TYPE usmd_entity,
      uibb_status TYPE YZ_DTEL_UIBB_STATUS,
      ent_prop    TYPE YZ_DTEL_ENTITY_PROPERTY,
    END OF gty_s_ent_prop .
  types:
    BEGIN OF gty_s_change_document,
      change_request  TYPE usmd_crequest,
      edition         TYPE usmd_edition,
      changed_by      TYPE xubname,
      changed_at      TYPE sycdate,
      changed_on      TYPE sytime,
      document_number TYPE cdchangenr,
      wdy_application TYPE sytcode,
      changed_value   TYPE usmd_ts_change_document_value,
      changed_details TYPE usmd_th_change_document_change,
      compound_value  TYPE usmd_ts_change_document_value,
      message         TYPE usmd_t_message,
    END OF gty_s_change_document .
  types:
    BEGIN OF gty_s_entity_uibb_mapping,
      entity TYPE usmd_entity,
      uibb   TYPE wdy_config_id,
    END OF gty_s_entity_uibb_mapping .
  types:
    gty_t_change_document       TYPE TABLE OF gty_s_change_document .
    types:
    gty_t_range_table       TYPE STANDARD TABLE OF gty_s_range_table .
  types:
    gty_t_address               TYPE SORTED TABLE OF /mdgbp/_s_bp_pp_address WITH UNIQUE KEY bp_header addrno .
  types:
    gty_t_key_value             TYPE SORTED TABLE OF yztabl_s_key_value WITH UNIQUE KEY key_field .
  types:
    gty_t_attribute_entity_rel  TYPE SORTED TABLE OF gty_s_attribute_entity_rel WITH UNIQUE KEY attribute .
  types:
    gty_t_entity_info           TYPE SORTED TABLE OF gty_s_entity_info WITH UNIQUE KEY entity .
  types:
    gty_t_entity_data           TYPE SORTED TABLE OF gty_s_entity_data WITH UNIQUE KEY entity struct .
  types:
    gty_t_entity_attributes_rel TYPE SORTED TABLE OF gty_s_entity_attributes_rel WITH UNIQUE KEY entity .
  types:
    gty_t_dependent_entities    TYPE SORTED TABLE OF gty_s_dependent_entities WITH UNIQUE KEY entity .
  types:
    gty_t_fld_prop              TYPE SORTED TABLE OF gty_s_fld_prop WITH NON-UNIQUE KEY entity fieldname .
  types:
*    gty_t_ent_prop              TYPE SORTED TABLE OF gty_s_ent_prop WITH UNIQUE KEY entity,
    gty_t_entity_uibb_mapping   TYPE SORTED TABLE OF gty_s_entity_uibb_mapping WITH UNIQUE KEY entity uibb .
endinterface.
