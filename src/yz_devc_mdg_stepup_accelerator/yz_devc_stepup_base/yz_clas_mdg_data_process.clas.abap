class YZ_CLAS_MDG_DATA_PROCESS definition
  public
  inheriting from YZ_CLAS_MDG_UTILITY
  create public .

public section.

  class-data DATA type ref to YZ_INTF_MDG_DATA_PROCESS .

  class-methods CLASS_CONSTRUCTOR .
  methods CONSTRUCTOR
    importing
      !IV_MODEL type USMD_MODEL .
  class-methods GET_DATA_SERVICE
    importing
      !IV_MODEL type USMD_MODEL
    returning
      value(RO_DATA_PROCESS) type ref to YZ_INTF_MDG_DATA_PROCESS .
protected section.
  PRIVATE SECTION.
    CLASS-DATA gt_data_subclass TYPE seo_relkeys.
ENDCLASS.



CLASS YZ_CLAS_MDG_DATA_PROCESS IMPLEMENTATION.


  METHOD class_constructor.

    gt_data_subclass =  yz_clas_mdg_utility=>get_class_by_impl_interface( iv_interface_name = CONV #('YZ_INTF_MDG_DATA_PROCESS') ).

  ENDMETHOD.


  METHOD constructor.
    super->constructor( ).
    get_data_service( iv_model ).
  ENDMETHOD.


  METHOD get_data_service.

    DATA(lv_dyn_class) = 'YZ_CLAS_MDG_' && iv_model && '_DATA_PROCESS'.

    IF line_exists( gt_data_subclass[ clsname = lv_dyn_class ] ) AND iv_model IS NOT INITIAL.

      CALL METHOD (lv_dyn_class)=>('GET_DATA_PROCESS')
        RECEIVING
          ro_data_process = ro_data_process.

      IF ro_data_process IS BOUND.
        data ?= ro_data_process.
      ELSE.
*       Raise EXCEPTION.
      ENDIF.

    ENDIF.

  ENDMETHOD.
ENDCLASS.
