class YCX_ADDICT_DOMAIN definition
  public
  inheriting from CX_STATIC_CHECK
  create public .

public section.

  interfaces IF_T100_MESSAGE .
  interfaces IF_T100_DYN_MSG .

  constants:
    begin of INVALID_VALUE,
      msgid type symsgid value 'YADDICT',
      msgno type symsgno value '090',
      attr1 type scx_attrname value 'DOMNAME',
      attr2 type scx_attrname value 'DOMVALUE_L',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of INVALID_VALUE,
    begin of INCORRECT_LENGTH,
      msgid type symsgid value 'YADDICT',
      msgno type symsgno value '091',
      attr1 type scx_attrname value 'DOMNAME',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of INCORRECT_LENGTH . .
  data DOMNAME type DOMNAME .
  data DOMVALUE_L type CHAR90 .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !DOMNAME type DOMNAME optional
      !DOMVALUE_L type CHAR90 optional .
protected section.
private section.
ENDCLASS.



CLASS YCX_ADDICT_DOMAIN IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
me->DOMNAME = DOMNAME .
me->DOMVALUE_L = DOMVALUE_L .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = IF_T100_MESSAGE=>DEFAULT_TEXTID.
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.
ENDCLASS.
