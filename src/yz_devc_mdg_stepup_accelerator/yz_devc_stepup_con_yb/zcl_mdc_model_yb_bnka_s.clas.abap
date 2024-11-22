class ZCL_MDC_MODEL_YB_BNKA_S definition
  public
  inheriting from CL_MDC_MODEL
  create protected

  global friends IF_MDC_MODEL .

public section.

  methods IF_MDC_MODEL~CHECK
    redefinition .
  methods IF_MDC_MODEL~READ_MATCH_GROUPS
    redefinition .
  methods IF_MDC_MODEL~SAVE
    redefinition .
protected section.

  types:
    BEGIN OF key_mapping,
        best_record_source_key TYPE mdc_source_key,
        best_record            TYPE REF TO data,
        active                 TYPE abap_bool,
        source_keys            TYPE mdc_tt_source_key,
      END OF key_mapping .

  data MDG_ID_MATCHING_API type ref to IF_MDG_ID_MATCHING_API_BS .
  data SOURCE_STATUS_TABLE type ref to DATA .
  data:
    sorted_match_groups TYPE SORTED TABLE OF mdc_match_group WITH UNIQUE KEY process_id source_key .

  methods BRFPLUS_VALIDATION
    raising
      CX_FDT
      CX_MDC_MODEL .
  methods EVALUATE_TARGET
    raising
      CX_MDC_MODEL .
  methods MAP_FOREIGN_SRC_KEY2OBJ_IDENT
    importing
      !FOREIGN_SOURCE_KEY type MDC_SOURCE_KEY
    returning
      value(OBJECT_IDENTIFIER) type MDG_S_IDENTIFIER_BS
    raising
      CX_MDG_KM_EXCEPTION .
  methods MAP_KEY2OBJECT_IDENTIFIER
    importing
      !RECORD type ref to DATA
    returning
      value(OBJECT_IDENTIFIER) type MDG_S_IDENTIFIER_BS
    raising
      CX_MDG_KM_EXCEPTION .
  methods READ_MATCH_GROUPS .
  methods SAVE_ACTIVE_DATA .
  methods SAVE_KEY_MAPPING .
  methods SAVE_SOURCE_STATUS .
  methods SET_ACTIVE_KEY
    importing
      !RECORD type ref to DATA
    raising
      CX_MDG_KM_EXCEPTION .
  methods WRITE_KEY_MAPPING
    importing
      !KEYS type KEY_MAPPING
    raising
      CX_MDG_KM_EXCEPTION .
private section.
ENDCLASS.



CLASS ZCL_MDC_MODEL_YB_BNKA_S IMPLEMENTATION.


  method BRFPLUS_VALIDATION.
    " Execute BRFplus checks for VAL and ACT
    FIELD-SYMBOLS <records> TYPE STANDARD TABLE.

    DATA(records) = me->root_object->read( ).
    DATA(fdt) = cl_mdc_fdt_facade=>get( me ).
    IF fdt IS NOT BOUND.
      RAISE EXCEPTION TYPE cx_mdc_model EXPORTING textid = cx_mdc_model=>brfplus_application_inactive.
    ENDIF.
    ASSIGN records->* TO <records>.
    LOOP AT <records> ASSIGNING FIELD-SYMBOL(<record>).
      DATA(validation_status) = fdt->val( object = me->root_object  record_ref = REF #( <record> ) ).
      CHECK validation_status <> if_mdc_data=>gc_validation_status-success.
      ASSIGN COMPONENT 'VALIDATION_STATUS' OF STRUCTURE <record> TO FIELD-SYMBOL(<validation_status>).
      CHECK <validation_status> IS ASSIGNED AND <validation_status> <> if_mdc_data=>gc_validation_status-error.
      <validation_status> = SWITCH #( validation_status
        WHEN if_mdc_data=>gc_validation_status-error OR if_mdc_data=>gc_validation_status-warning THEN validation_status
        ELSE COND #(
          WHEN <validation_status> = if_mdc_data=>gc_validation_status-warning THEN if_mdc_data=>gc_validation_status-warning
          ELSE if_mdc_data=>gc_validation_status-success
        )
      ).
    ENDLOOP.
  endmethod.


  method EVALUATE_TARGET.
    me->source_status_table = CAST cl_mdc_data( me->root_object )->records_ref( if_mdc_data=>gc_type-status ).
    FIELD-SYMBOLS <source_status_table> TYPE STANDARD TABLE.
    ASSIGN me->source_status_table->* TO <source_status_table>.

    FIELD-SYMBOLS <records> TYPE STANDARD TABLE.
    DATA(records) = me->root_object->read( ).
    ASSIGN records->* TO <records>.
    LOOP AT <records> ASSIGNING FIELD-SYMBOL(<record>).
      FIELD-SYMBOLS <source_key> TYPE mdc_source_key.
      ASSIGN COMPONENT 'SOURCE_KEY' OF STRUCTURE <record> TO <source_key>.
      CHECK sy-subrc = 0.

      me->set_active_key( REF #( <record> ) ).
      DATA(group_id) = VALUE #( me->sorted_match_groups[ process_id = me->process_id  source_key = <source_key> ]-match_group_id DEFAULT VALUE #( ) ).
      DATA(keys) = VALUE key_mapping(
        LET active = xsdbool( <source_key>-source_system = me->own_system )
            source_keys = COND mdc_tt_source_key( WHEN active = abap_false THEN VALUE #( ( <source_key> ) ) ) IN
        best_record_source_key = <source_key>
        best_record = REF #( <record> )
        active = active
        source_keys = COND #( WHEN group_id IS INITIAL THEN source_keys ELSE VALUE #( BASE source_keys
          FOR <group> IN me->sorted_match_groups WHERE ( match_group_id = group_id AND best_record = abap_false ) ( <group>-source_key )
        ) )
      ).
      CHECK keys-source_keys IS NOT INITIAL.
      DATA(source_stat_name) = me->root_object->table_name_by_type( if_mdc_data=>gc_type-status ).
      "update SRC_STAT-record for current (best) record with its best record ID
      DATA source_status_record TYPE REF TO data.
      CREATE DATA source_status_record LIKE LINE OF <source_status_table>.
      ASSIGN source_status_record->* TO FIELD-SYMBOL(<source_status_record>).

      SELECT SINGLE * FROM (source_stat_name) INTO @<source_status_record>
                                             WHERE source_system = @keys-best_record_source_key-source_system
                                             AND   source_id     = @keys-best_record_source_key-source_id.
      IF sy-subrc = 0.
        LOOP AT me->if_mdc_model~source_id_fields( ) ASSIGNING FIELD-SYMBOL(<source_field>).
        ASSIGN COMPONENT <source_field> OF STRUCTURE <source_status_record> TO FIELD-SYMBOL(<src_stat_best_record_id>).
        ASSIGN COMPONENT <source_field> OF STRUCTURE <record> TO FIELD-SYMBOL(<best_record_id>).
        IF <src_stat_best_record_id> IS NOT ASSIGNED
         OR <best_record_id> IS NOT ASSIGNED.
          RAISE EXCEPTION TYPE cx_mdc_model.
        ENDIF.
        <src_stat_best_record_id> = <best_record_id>.
        ENDLOOP.
        APPEND <source_status_record> TO <source_status_table>.
      ENDIF.

      "update SRC_STAT-records with best record ID for matching records
      LOOP AT me->sorted_match_groups ASSIGNING FIELD-SYMBOL(<match_group>) WHERE match_group_id = group_id
                                                                       AND best_record = abap_false.
        SELECT SINGLE * FROM (source_stat_name) INTO @<source_status_record>
           WHERE source_system = @<match_group>-source_system
           AND   source_id     = @<match_group>-source_id.
        IF sy-subrc <> 0.
          RAISE EXCEPTION TYPE cx_mdc_model.
        ELSE.
          ASSIGN COMPONENT me->root_object->source_id_field OF STRUCTURE <source_status_record> TO <src_stat_best_record_id>.
          ASSIGN COMPONENT me->root_object->source_id_field OF STRUCTURE <record> TO <best_record_id>.
          IF <src_stat_best_record_id> IS NOT ASSIGNED
           OR <best_record_id> IS NOT ASSIGNED.
            RAISE EXCEPTION TYPE cx_mdc_model.
          ENDIF.

          <src_stat_best_record_id> = <best_record_id>.
          APPEND <source_status_record> TO <source_status_table>.
        ENDIF.
      ENDLOOP.

      me->write_key_mapping( keys ).
    ENDLOOP.
  endmethod.


  method IF_MDC_MODEL~CHECK.
    me->brfplus_validation( ).
  endmethod.


  method IF_MDC_MODEL~READ_MATCH_GROUPS.
    CHECK me->sorted_match_groups IS INITIAL.
    super->if_mdc_model~read_match_groups( ).
    me->sorted_match_groups = me->match_groups.
  endmethod.


  method IF_MDC_MODEL~SAVE.
    status = if_mdc_adapter=>package_status-success.
    IF me->step_type = if_mdc_adapter=>step_type-activation.
      me->if_mdc_model~check( ).
      me->read_match_groups( ).
      me->evaluate_target( ).
      me->save_active_data( ).

      "if not all records could be activated - reflected by dropped_source_keys - set partial success status
      IF lines( me->dropped_source_keys ) <  me->root_object->size( ).
        status = if_mdc_adapter=>package_status-partial_success.
      ENDIF.

      me->save_key_mapping( ).
      me->save_source_status( ).

      IF me->dropped_source_keys IS NOT INITIAL.
        me->delete( me->dropped_source_keys ).
        CLEAR me->dropped_source_keys.
      ENDIF.

      LOOP AT me->data_objects ASSIGNING FIELD-SYMBOL(<data_object>).
        <data_object>-access->save( ).
      ENDLOOP.
    ENDIF.
    DATA(super_status) = super->if_mdc_model~save( ).
    CHECK super_status <> status AND status = if_mdc_adapter=>package_status-success AND super_status IS NOT INITIAL.
    status = super_status.
  endmethod.


  method MAP_FOREIGN_SRC_KEY2OBJ_IDENT.
    DATA(source_record) = CAST cl_mdc_data( me->root_object )->record_ref( if_mdc_data=>gc_type-process ).
    ASSIGN source_record->* TO FIELD-SYMBOL(<source_record>).
    ASSIGN COMPONENT 'SOURCE_SYSTEM' OF STRUCTURE <source_record> TO FIELD-SYMBOL(<foreign_source_system>).
    ASSIGN COMPONENT 'SOURCE_ID' OF STRUCTURE <source_record> TO FIELD-SYMBOL(<foreign_source_id>).
    ASSIGN COMPONENT me->root_object->source_id_field OF STRUCTURE <source_record> TO FIELD-SYMBOL(<foreign_key_field>).

    IF <foreign_source_system> IS NOT ASSIGNED
    OR <foreign_source_id> IS NOT ASSIGNED
    OR <foreign_key_field> IS NOT ASSIGNED.
      RAISE EXCEPTION TYPE cx_mdg_km_exception.
    ENDIF.

    <foreign_source_system> = foreign_source_key-source_system.
    <foreign_source_id> = <foreign_key_field> = foreign_source_key-source_id.

    object_identifier = me->map_key2object_identifier( record = source_record ).
    object_identifier-business_system_id = foreign_source_key-source_system.
  endmethod.


  method MAP_KEY2OBJECT_IDENTIFIER.
    "this method gets for the given BO the corresponding OITC and its key structure
    "the given source structure is moved to the key structure and the key structure is mapped to Key Mapping ID (CHAR120)
    TRY.
        cl_drf_service_tools=>describe_bo_key( EXPORTING iv_bo            = me->bo_type
                                               IMPORTING ev_oitc_for_repl = object_identifier-ident_defining_scheme_code
                                                         er_bo_key_descr  = DATA(bo_key_descriptor) ).
      CATCH cx_drf_exception INTO DATA(drf_exception).
        RAISE EXCEPTION TYPE cx_mdg_km_exception EXPORTING previous = drf_exception.
    ENDTRY.

    DATA bo_key TYPE REF TO data.
    CREATE DATA bo_key TYPE HANDLE bo_key_descriptor.
    ASSIGN bo_key->* TO FIELD-SYMBOL(<bo_key>).
    ASSIGN record->* TO FIELD-SYMBOL(<record>).
    MOVE-CORRESPONDING <record> TO <bo_key>.

    TRY.
        cl_mdg_id_matching_tools_ext=>convert_id_value_int2ext( EXPORTING iv_oitc              = object_identifier-ident_defining_scheme_code
                                                                          iv_id_value_internal = <bo_key>
                                                                IMPORTING ev_id_value_external = object_identifier-id_value ).
      CATCH cx_mdg_km_tools_invalid_format INTO DATA(mdg_km_tools_invalid_format).
        RAISE EXCEPTION TYPE cx_mdg_km_exception EXPORTING previous = mdg_km_tools_invalid_format.
    ENDTRY.
  endmethod.


  method READ_MATCH_GROUPS.
    TRY.
        me->if_mdc_model~read_match_groups( ).
      CATCH cx_mdc_model ##no_handler.
    ENDTRY.
  endmethod.


  method SAVE_ACTIVE_DATA.
    FIELD-SYMBOLS <records> TYPE STANDARD TABLE.

    TRY.
        DATA(records) = me->root_object->read( ).
        ASSIGN records->* TO <records>.
        CHECK <records> IS NOT INITIAL.
        DATA(table_name) = me->root_object->table_name_by_type( if_mdc_data=>gc_type-active ).
        DATA(active_record) = CAST cl_mdc_data( me->root_object )->record_ref( if_mdc_data=>gc_type-active ).
        ASSIGN active_record->* TO FIELD-SYMBOL(<active_record>).
        LOOP AT <records> ASSIGNING FIELD-SYMBOL(<record>).
          ASSIGN COMPONENT 'VALIDATION_STATUS' OF STRUCTURE <record> TO FIELD-SYMBOL(<validation_status>).
          CHECK <validation_status> IS ASSIGNED AND <validation_status> <> if_mdc_data=>gc_validation_status-error.
          MOVE-CORRESPONDING <record> TO <active_record>.
          TRY.
              MODIFY (table_name) FROM @<active_record>.
              "in order to process erroneous records after activation, only store those and drop successfully activated records here
              ASSIGN COMPONENT 'SOURCE_KEY' OF STRUCTURE <record> TO FIELD-SYMBOL(<source_key>).
              IF <source_key> IS ASSIGNED.
                APPEND <source_key> TO me->dropped_source_keys.
              ENDIF.
            CATCH cx_root INTO DATA(exception_root).
              me->log->add_exception( exception_root ).
              CONTINUE.
          ENDTRY.
        ENDLOOP.
      CATCH cx_mdc_model INTO DATA(exception_model).
        me->log->add_exception( exception_model ).
    ENDTRY.
  endmethod.


  method SAVE_KEY_MAPPING.
    CHECK me->mdg_id_matching_api IS BOUND.
    TRY.
        me->mdg_id_matching_api->save( iv_save_in_update_task = abap_true ).
      CATCH cx_mdg_id_matching_bs ##NO_HANDLER.
    ENDTRY.
  endmethod.


  method SAVE_SOURCE_STATUS.
    DATA(source_stat_name) = me->root_object->table_name_by_type( if_mdc_data=>gc_type-status ).
    FIELD-SYMBOLS <source_status_table> TYPE STANDARD TABLE.
    ASSIGN me->source_status_table->* TO <source_status_table>.
    UPDATE (source_stat_name) FROM TABLE <source_status_table>.
  endmethod.


  method SET_ACTIVE_KEY.
    " This method should be redefined for concrete custom object in order to get correct key for new active record.
    ASSIGN record->* TO FIELD-SYMBOL(<best_record>).
    FIELD-SYMBOLS <source_key> TYPE mdc_source_key.
    ASSIGN COMPONENT 'SOURCE_KEY' OF STRUCTURE <best_record> TO <source_key>.
    ASSIGN COMPONENT me->root_object->source_id_field OF STRUCTURE <best_record> TO FIELD-SYMBOL(<best_record_key_field>).

    IF <source_key> IS NOT ASSIGNED OR <best_record_key_field> IS NOT ASSIGNED.
      RAISE EXCEPTION TYPE cx_mdg_km_exception.
    ENDIF.

    CHECK <source_key>-source_system <> me->own_system.
    <best_record_key_field> = <source_key>-source_id.
  endmethod.


  method WRITE_KEY_MAPPING.
    CHECK keys-best_record_source_key-source_system <> if_mdc_data=>gc_mass_creation_system.
    " Get API instance for key mapping.
    IF me->mdg_id_matching_api IS INITIAL.
      TRY.
          cl_mdg_id_matching_api_bs=>get_instance( EXPORTING iv_direct_db_insert       = abap_false
                                                             iv_set_lcl_system_by_api  = abap_false
                                                   IMPORTING er_if_mdg_id_matching_api = me->mdg_id_matching_api ).
        CATCH cx_mdg_id_matching_bs
              cx_mdg_no_api_instance
              cx_mdg_lcl_bus_sys_not_found INTO DATA(km_exception).
          RAISE EXCEPTION TYPE cx_mdg_km_exception EXPORTING previous = km_exception.
      ENDTRY.
    ENDIF.

    " Map own ID in format for UKM.
    DATA(object_identifier) = me->map_key2object_identifier( record = keys-best_record ).
    object_identifier-business_system_id = me->own_system.
    DATA(matching_objects) = VALUE mdg_s_matching_obj_data_inp_bs(
      object_type_code = me->bo_type
      object_identifier = VALUE #( ( object_identifier ) )
      group_reference = abap_true
      system_reference = abap_true
    ).
    DATA(matching_group) = VALUE mdg_s_matching_grp_data_bs( matching_objects = VALUE #( ( matching_objects  ) ) ).

    " Map and add source IDs.
    DATA(source_keys) = keys-source_keys.
    SORT source_keys BY source_system.

    LOOP AT source_keys ASSIGNING FIELD-SYMBOL(<source_key>) WHERE source_system IS NOT INITIAL
      AND source_system <> if_mdc_data=>gc_mass_creation_system ##LOOP_AT_OK.
      object_identifier = me->map_foreign_src_key2obj_ident( foreign_source_key = <source_key> ).
      matching_objects = VALUE #(
        object_type_code = me->bo_type
        object_identifier = VALUE #( ( object_identifier ) )
      ).
      AT NEW source_system ##LOOP_AT_OK.
        matching_objects-group_reference = abap_true.
        matching_objects-system_reference = abap_true.
      ENDAT.
      APPEND matching_objects TO matching_group-matching_objects.
    ENDLOOP.

    DATA(matching_groups) = VALUE mdg_t_matching_grp_data_bs( ( matching_group ) ).
    TRY.
        " Add matching objects to key mapping.
        me->mdg_id_matching_api->add_matching( it_matching_complex = matching_groups ).
      CATCH cx_mdg_missing_input_parameter
        cx_mdg_missing_id_data
        cx_mdg_otc_idm_error
        cx_mdg_idsc_invalid
        cx_mdg_km_same_identifier
        cx_mdg_id_matching_bs INTO km_exception.
        RAISE EXCEPTION TYPE cx_mdg_km_exception EXPORTING previous = km_exception.
    ENDTRY.
  endmethod.
ENDCLASS.
