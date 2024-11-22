class YCL_ADDICT_DOMAIN_LINE definition
  public
  final
  create private .

public section.

  data DOMAIN type ref to YCL_ADDICT_DOMAIN .
  data LINE type YCL_ADDICT_DOMAIN=>LINE_DICT read-only .

  class-methods GET_INSTANCE
    importing
      !DOMNAME type DOMNAME
    returning
      value(OBJ) type ref to YCL_ADDICT_DOMAIN_LINE
    raising
      YCX_ADDICT_TABLE_CONTENT .
  methods SET_VALUE
    importing
      !VALUE type CHAR90
    raising
      YCX_ADDICT_DOMAIN .
  PROTECTED SECTION.
  PRIVATE SECTION.
    TYPES: BEGIN OF multiton_dict,
             domname TYPE domname,
             obj     TYPE REF TO ycl_addict_domain_line,
           END OF multiton_dict,

           multiton_set TYPE HASHED TABLE OF multiton_dict
                        WITH UNIQUE KEY primary_key COMPONENTS domname.

    CLASS-DATA multiton TYPE multiton_set.
ENDCLASS.



CLASS YCL_ADDICT_DOMAIN_LINE IMPLEMENTATION.


  METHOD get_instance.
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Factory
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    ASSIGN ycl_addict_domain_line=>multiton[
             KEY primary_key COMPONENTS
             domname = domname
           ] TO FIELD-SYMBOL(<multiton>).

    IF sy-subrc <> 0.
      DATA(sing) = VALUE multiton_dict( domname = domname ).
      sing-obj = NEW #( ).
      sing-obj->domain = ycl_addict_domain=>get_instance( sing-domname ).
      INSERT sing INTO TABLE ycl_addict_domain_line=>multiton ASSIGNING <multiton>.
    ENDIF.

    obj = <multiton>-obj.
  ENDMETHOD.


  METHOD set_value.
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Sets a new value line
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    line = domain->get_value_line( value ).
  ENDMETHOD.
ENDCLASS.
