class ZCL_SELSCR definition
  public
  final
  create public
  shared memory enabled .

public section.

  methods GET_FIELDS
    returning
      value(R_RANGES) type ACE_FIELD_RANGES_T .
  methods SET_FIELDS
    importing
      !I_RANGES type ACE_FIELD_RANGES_T .
protected section.
private section.

  data RANGES type ACE_FIELD_RANGES_T .
ENDCLASS.



CLASS ZCL_SELSCR IMPLEMENTATION.


  METHOD get_fields.
    r_ranges = ranges.
  ENDMETHOD.


  METHOD set_fields.
    ranges = i_ranges.
  ENDMETHOD.
ENDCLASS.
