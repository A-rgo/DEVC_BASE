*"* use this source file for your ABAP unit test classes

CLASS lcl_Cs_Mbom_Idoc_Drf DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS
.
*?﻿<asx:abap xmlns:asx="http://www.sap.com/abapxml" version="1.0">
*?<asx:values>
*?<TESTCLASS_OPTIONS>
*?<TEST_CLASS>lcl_Cs_Mbom_Idoc_Drf
*?</TEST_CLASS>
*?<TEST_MEMBER>f_Cut
*?</TEST_MEMBER>
*?<OBJECT_UNDER_TEST>CL_CS_MBOM_IDOC_DRF
*?</OBJECT_UNDER_TEST>
*?<OBJECT_IS_LOCAL/>
*?<GENERATE_FIXTURE/>
*?<GENERATE_CLASS_FIXTURE/>
*?<GENERATE_INVOCATION/>
*?<GENERATE_ASSERT_EQUAL/>
*?</TESTCLASS_OPTIONS>
*?</asx:values>
*?</asx:abap>
  PRIVATE SECTION.
    CLASS-DATA: db_environment TYPE REF TO if_osql_test_environment.
    DATA:
      f_Cut TYPE REF TO cl_Cs_Mbom_Idoc_Drf.  "class under test

    CLASS-METHODS: class_setup.
    CLASS-METHODS: class_teardown.

    METHODS: setup.
    METHODS: teardown.
    METHODS: analyze_Changes_By_Chg_Pointer FOR TESTING.
    METHODS: analyze_Changes_By_Mdg_Cp FOR TESTING.
    METHODS: analyze_Changes_By_Others FOR TESTING.
    METHODS: apply_Node_Inst_Filter_Multi FOR TESTING.
    METHODS: apply_Node_Inst_Filter_Single FOR TESTING.
    METHODS: build_Parallel_Package FOR TESTING.
    METHODS: enrich_Filter_Criteria FOR TESTING.
    METHODS: finalize FOR TESTING.
    METHODS: initialize FOR TESTING.
    METHODS: map_Data2message FOR TESTING.
    METHODS: read_Complete_Data FOR TESTING.
    METHODS: send_Message FOR TESTING.
    METHODS: send_Bommat_Idoc FOR TESTING.
    METHODS: update_Replication_Data FOR TESTING.
ENDCLASS.       "lcl_Cs_Mbom_Idoc_Drf


CLASS lcl_Cs_Mbom_Idoc_Drf IMPLEMENTATION.

  METHOD setup.
    db_environment->get_access_control_double( )->disable_access_control( ).
    db_environment->clear_doubles( ).
    DATA: lt_mast TYPE STANDARD TABLE OF mast.

    CREATE OBJECT f_Cut.

    lt_mast = VALUE #(
                      ( matnr = 'UT' werks = '0001' stlan = '1' stlnr = '11111111'  )
                      ).
    db_environment->insert_test_data( lt_mast ).
  ENDMETHOD.

  METHOD teardown.

  ENDMETHOD.

  METHOD class_setup.
    db_environment = cl_osql_test_environment=>create( i_dependency_list =  VALUE #( ( 'MAST' ) ( 'C_BILLOFMATERIALTP' ) ) ).
  ENDMETHOD.

  METHOD class_teardown.
    db_environment->destroy( ).
  ENDMETHOD.

  METHOD analyze_Changes_By_Chg_Pointer.



  ENDMETHOD.


  METHOD analyze_Changes_By_Mdg_Cp.
    TYPES:
      BEGIN OF ty_bom,
        stlnr TYPE stzu-stlnr,
        stlty TYPE stzu-stlty,
      END OF ty_bom.

    DATA : lt_change_pointer  TYPE  mdg_cp_t_cp,
           ls_stat_info       TYPE  drf_s_stat_info,
           lt_changed_objects TYPE SORTED TABLE OF ty_bom
               WITH NON-UNIQUE KEY stlnr.


    f_cut->if_drf_outbound~analyze_changes_by_mdg_cp(
      EXPORTING
        it_change_pointer      =     lt_change_pointer" Change Pointer
      IMPORTING
        es_stat_info           =     ls_stat_info" Statistical Information
      CHANGING
        ct_changed_objects     =    lt_changed_objects
    ).


  ENDMETHOD.


  METHOD analyze_Changes_By_Others.

*    TYPES:
*      BEGIN OF ty_bom,
*        stlnr TYPE stzu-stlnr,
*        stlty TYPE stzu-stlty,
*      END OF ty_bom.
*
*    DATA : ls_stat_info       TYPE  drf_s_stat_info,
*           lt_changed_objects TYPE SORTED TABLE OF ty_bom
*               WITH NON-UNIQUE KEY stlnr.
*
*    f_cut->if_drf_outbound~analyze_changes_by_others(
*      IMPORTING
*        es_stat_info           =     ls_stat_info" Statistical Information
*      CHANGING
*        ct_changed_objects     =     lt_changed_objects" Objectsto be distributed
*    ).

  ENDMETHOD.


  METHOD apply_Node_Inst_Filter_Multi.



  ENDMETHOD.


  METHOD apply_Node_Inst_Filter_Single.
*    DATA : lt_external_criteria TYPE  rsds_trange,
*           lt_fobj              TYPE  drf_t_fobj_impl,
*           lv_ignore_filter     TYPE  abap_bool,
*           lv_skip_object       TYPE  abap_bool,
*           lr_relevant_object   TYPE REF TO data.
*
*
*    f_cut->if_drf_outbound~apply_node_inst_filter_single(
*         EXPORTING
*           it_external_criteria    =     lt_external_criteria" External Additional Filter Criteria
*           it_fobj                 =     lt_fobj" Used Filter Objects in Outbound Implementations
*           iv_ignore_filter        =     ' '    " Should Configured Filter Be Ignored  (X=true)?
*         IMPORTING
*            ev_skip_object          =    lv_skip_object " Skip relevant Object for further processing (X=true)?
*         CHANGING
*            cr_relevant_object      =    lr_relevant_object
*            ).


  ENDMETHOD.


  METHOD build_Parallel_Package.
*    DATA : ir_prepare_data   TYPE  REF TO data,
*           er_package_data   TYPE  REF TO data,
*           es_task_param     TYPE  drf_s_parallel_task_param,
*           ev_all_tasks_done TYPE  abap_bool.
*
*    f_cut->if_drf_outbound~build_parallel_package(
*      EXPORTING
*        ir_prepare_data   =     ir_prepare_data" Additional Data from Redefined Classes
*      IMPORTING
*        er_package_data   =     er_package_data" Reference to Data to Be Processed
*        es_task_param     =     es_task_param" Parameter of a Parallel Task
*        ev_all_tasks_done =     ev_all_tasks_done" All Parallel Tasks/Packages Processed
*    ).


  ENDMETHOD.


  METHOD enrich_Filter_Criteria.
*    DATA : it_external_criteria     TYPE  rsds_trange,
*           et_add_external_criteria TYPE  rsds_trange,
*           es_stat_info             TYPE  drf_s_stat_info.
*
*    f_cut->if_drf_outbound~enrich_filter_criteria(
*      EXPORTING
*        it_external_criteria           =     it_external_criteria" External Additional Filter Criteria
*      IMPORTING
*        et_add_external_criteria       =     et_add_external_criteria" Additional External Filter Criteria defined by the Outb.Impl
*        es_stat_info                   =     es_stat_info" Statistical Information
*    ).


  ENDMETHOD.


  METHOD finalize.
    TYPES:
      BEGIN OF ty_bom,
        stlnr TYPE stzu-stlnr,
        stlty TYPE stzu-stlty,
      END OF ty_bom.

    DATA : it_relevant_objects      TYPE SORTED TABLE OF ty_bom
               WITH NON-UNIQUE KEY stlnr,
           it_erroneous_objects     TYPE SORTED TABLE OF ty_bom
               WITH NON-UNIQUE KEY stlnr,
           iv_repeated_initial_run  TYPE  boole_d,
           ev_delete_change_pointer TYPE  boole_d.

    f_cut->if_drf_outbound~finalize(
      EXPORTING
        it_relevant_objects      =     it_relevant_objects" Relevant objects of the message processing
        it_erroneous_objects     =     it_erroneous_objects" Objects which run into an exception during msg. proc.
        iv_repeated_initial_run  =     iv_repeated_initial_run" 'X' Repeated Initial run
      IMPORTING
        ev_delete_change_pointer =     ev_delete_change_pointer" 'X' DRFdelete all change pointers within initial replication
    ).

  ENDMETHOD.


  METHOD initialize.
    DATA: ls_runtime_param          TYPE  drf_s_runtime_parameter_ext,
          lo_if_drf_outbound        TYPE REF TO  if_drf_outbound,
          ls_runtime_param_out_impl TYPE  drf_s_runtime_param_out_impl.

    ls_runtime_param-outb_impl = 'DRF_0077'.
    ls_runtime_param-bo = 'DRF_0077'.
    ls_runtime_param-fobj = 'MBOM_DRF'.
    ls_runtime_param-appl = 'BOMMAT_RM'.
    "ls_runtime_param-bal =


    f_cut->if_drf_outbound~initialize(
      EXPORTING
        is_runtime_param          =     ls_runtime_param" DRF external runtime parameter
      IMPORTING
        eo_if_drf_outbound        =     lo_if_drf_outbound" Interface for Data Replication Framework
        es_runtime_param_out_impl =     ls_runtime_param_out_impl" Runtime Parameter of the outbound implementation
    ).


  ENDMETHOD.


  METHOD map_Data2message.

    DATA : ir_relevant_object	TYPE REF TO	mast,
           is_bus_sys_tech    TYPE  mdg_s_bus_sys_tech.

    CREATE DATA ir_relevant_object.

    ir_relevant_object->stlnr = '11111111'.
    ir_relevant_object->matnr = 'PROD_01'.
    ir_relevant_object->werks = '0001'.
    ir_relevant_object->stlan = '1'.
    ir_relevant_object->stlal = '01'.

    f_cut->if_drf_outbound~map_data2message(
      EXPORTING
        ir_relevant_object      =   ir_relevant_object
        is_bus_sys_tech         =   is_bus_sys_tech   " Technical Information of an Business Object
    ).

  ENDMETHOD.


  METHOD read_Complete_Data.

    TYPES:
      BEGIN OF ty_bom,
        stlnr TYPE stzu-stlnr,
        stlty TYPE stzu-stlty,
      END OF ty_bom.

    DATA : ct_relevant_objects TYPE SORTED TABLE OF ty_bom WITH NON-UNIQUE KEY stlnr.

    f_cut->if_drf_outbound~read_complete_data(
         CHANGING
         ct_relevant_objects     =  ct_relevant_objects  " Object to Be Sent
                                                        ).

  ENDMETHOD.


  METHOD send_Message.
    DATA : ls_file_info    TYPE  drf_s_file_info,
           lv_object_count TYPE  drf_package_size,
           lt_file_data    TYPE  drf_t_file_oi_content,
           ls_bus_sys_tech TYPE  mdg_s_bus_sys_tech,
           lt_message      TYPE  drf_t_message,
           lt_obj_rep_sta  TYPE  drf_t_obj_rep_sta_full,
           lr_bal          TYPE REF TO cl_drf_bal.

    CREATE OBJECT lr_bal.

*    f_cut->ms_runtime_param-bal = lr_bal.

    lv_object_count = '1'.

*    TEST-INJECTION add_msg.
*
*    END-TEST-INJECTION.

    f_cut->if_drf_outbound~send_message(
      EXPORTING
        is_file_info            =     ls_file_info" Data of Outbound Implementations  to be saved as files
        iv_object_count         =     lv_object_count" Package Size of an Outgoing Message
        is_bus_sys_tech         =     ls_bus_sys_tech" Technical Information of an Business Object
      IMPORTING
        et_file_data            =     lt_file_data" File Data
        et_message              =     lt_message" Table type for direct data transfer
      CHANGING
        ct_obj_rep_sta          =     lt_obj_rep_sta" Object Replication Status
    ).


  ENDMETHOD.


  METHOD send_Bommat_Idoc.



  ENDMETHOD.


  METHOD update_Replication_Data.



  ENDMETHOD.




ENDCLASS.
