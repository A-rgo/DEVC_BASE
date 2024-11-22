*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
*interface lif_access_class_provider.
*
*  types ty_t_mdg_bs_bp_access type standard table of mdg_bs_bp_access with DEFAULT KEY.
*
*  methods:
*    deliver_customizing
*      RETURNING VALUE(rt_entries) type ty_t_mdg_bs_bp_access.
*
*ENDINTERFACE.

*class lcl_access_class_provider DEFINITION final create private.
*
*  PUBLIC SECTION.
**    interfaces: lif_access_class_provider.
*
*    CLASS-METHODS:
*      create
*        RETURNING VALUE(r_instance) type ref to lcl_access_class_provider.
*
*endclass.
