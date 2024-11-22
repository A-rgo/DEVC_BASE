*"* use this source file for your ABAP unit test classes

CLASS lcl_Cs_Mbom_Idoc_Drf_Filter DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS
.
*?﻿<asx:abap xmlns:asx="http://www.sap.com/abapxml" version="1.0">
*?<asx:values>
*?<TESTCLASS_OPTIONS>
*?<TEST_CLASS>lcl_Cs_Mbom_Idoc_Drf_Filter
*?</TEST_CLASS>
*?<TEST_MEMBER>f_Cut
*?</TEST_MEMBER>
*?<OBJECT_UNDER_TEST>CL_CS_MBOM_IDOC_DRF_FILTER
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
    CLASS-DATA: go_environment TYPE REF TO if_osql_test_environment.
    DATA:
      f_Cut TYPE REF TO cl_Cs_Mbom_Idoc_Drf_Filter.  "class under test
    CLASS-METHODS: class_setup.
    CLASS-METHODS: class_teardown.
    METHODS: setup.
    METHODS: teardown.
    METHODS: apply_Filter FOR TESTING.
    METHODS: get_Selected_Bom FOR TESTING.
    METHODS: get_Where_Condition FOR TESTING.
ENDCLASS.       "lcl_Cs_Mbom_Idoc_Drf_Filter


CLASS lcl_Cs_Mbom_Idoc_Drf_Filter IMPLEMENTATION.

  METHOD class_setup.
    go_environment = cl_osql_test_environment=>create( VALUE #( ( 'MARA' )
                                                            ( 'MAST' )
                                                            ( 'STZU' )
                                                            ( 'MARD' )
                                                            ( 'C_BILLOFMATERIALTP' )
                                                            ( 'MDC_DUPLICATES' ) ) ).
  ENDMETHOD.

  METHOD class_teardown.
    go_environment->destroy( ).
  ENDMETHOD.

  METHOD setup.
    go_environment->get_access_control_double( )->disable_access_control( ).
    go_environment->clear_doubles( ).
    CREATE OBJECT f_cut.
  ENDMETHOD.

  METHOD teardown.
  ENDMETHOD.

  METHOD apply_Filter.

    TYPES: BEGIN OF ty_mast,
             matnr TYPE matnr,
             werks TYPE werks_d,
             stlan TYPE stlan,
             stlnr TYPE stnum,
             stlal TYPE stlal,
           END OF ty_mast.
    DATA: lt_mast               TYPE STANDARD TABLE OF mast,
          lt_stzu               TYPE STANDARD TABLE OF stzu,
          lt_filter_criteria    TYPE rsds_trange,
          lt_unfiltered_objects TYPE SORTED TABLE OF ty_mast WITH UNIQUE KEY matnr werks stlan stlnr stlal,
          lt_filtered_objects   TYPE SORTED TABLE OF ty_mast WITH UNIQUE KEY matnr werks stlan stlnr stlal,
          lo_bal_log            TYPE REF TO cl_drf_bal.


    lt_mast = VALUE #( ( matnr = 'PROD_01' werks = '0001' stlan = '1' stlnr = '11111111' stlal = '01' )
                   ( matnr = 'PROD_02' werks = '0001' stlan = '1' stlnr = '22222222' stlal = '01' ) ).
    go_environment->insert_test_data( lt_mast ).

*    lt_mast = VALUE #( ( matnr = 'PROD_01' werks = '0001' stlan = '1' stlnr = '11111111' stlal = '01' )
*               ( matnr = 'PROD_01' werks = '0001' stlan = '1' stlnr = '22222222' stlal = '01' ) ).
*    go_environment->insert_test_data( lt_mast ).

    lt_unfiltered_objects = VALUE #( ( matnr = 'PROD_01' werks = '0001' stlan = '1' stlnr = '11111111' stlal = '01' )
                                 ( matnr = 'PROD_02' werks = '0001' stlan = '1' stlnr = '22222222' stlal = '01' ) ).

    lt_filter_criteria = VALUE #( ( tablename = 'MDM_PRD_DRF_S_MAIN_FLT'
                                    frange_t = VALUE #( ( fieldname = 'MATNR'
                                                          selopt_t = VALUE #( ( sign = 'I'
                                                                                option = 'EQ'
                                                                                low = 'PROD_01' ) ) ) ) ) ).

    TRY .
        f_cut->if_drf_filter~apply_filter(
          EXPORTING
            iv_appl = 'PROD_SERV'
            iv_business_system = ''
            is_c_fobj = VALUE #( )
            iv_outb_impl = 'DRF_0077'
            iv_dlmod = 'M'
            iv_runmod = ''
            is_filt = VALUE #( )
            io_bal = lo_bal_log
            it_external_criteria = lt_filter_criteria
            it_unfiltered_objects = lt_unfiltered_objects
         IMPORTING
           et_filtered_objects = lt_filtered_objects
        ).
      CATCH cx_drf_filter_object.
    ENDTRY.

*    cl_abap_unit_assert=>assert_equals(
*        act   = lt_filtered_objects[ 1 ]-stlnr
*        exp   = '11111111'
*    ).


  ENDMETHOD.


  METHOD get_Selected_Bom.



  ENDMETHOD.


  METHOD get_Where_Condition.



  ENDMETHOD.




ENDCLASS.
