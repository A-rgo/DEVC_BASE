class YZ_CLAS_MDG_YB_DATA_PROCESS_EX definition
  public
  inheriting from YZ_CLAS_MDG_UTILITY
  create public .

public section.

  types:
    tt_ZZENTITY_sample TYPE SORTED TABLE OF /mdg/_s_0g_pp_ACCCCDET WITH UNIQUE KEY coa account compcode .

  class-data GT_ZZENTITY_SAMPLE type TT_ZZENTITY_SAMPLE .
  constants GC_ZZENTITY_SAMPLE type USMD_ENTITY value 'ZZENTITY' ##NO_TEXT.

  methods CONSTRUCTOR .
  class-methods GET_ZZENTITY_SAMPLE
    exporting
      value(RT_DATA) type ref to DATA .
  class-methods SET_ZZENTITY_SAMPLE
    importing
      !IT_DATA type ANY TABLE .
  class-methods DEL_ZZENTITY_SAMPLE
    importing
      !IT_DATA type TT_ZZENTITY_SAMPLE .
protected section.
private section.
ENDCLASS.



CLASS YZ_CLAS_MDG_YB_DATA_PROCESS_EX IMPLEMENTATION.


  method CONSTRUCTOR.
    super->constructor( ).
  endmethod.


  METHOD DEL_ZZENTITY_SAMPLE.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data) ##INTO_OK.
        DELETE TABLE gt_ZZENTITY_sample FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD GET_ZZENTITY_SAMPLE.
    CREATE DATA rt_data TYPE tt_ZZENTITY_sample.

    ASSIGN rt_data->* TO FIELD-SYMBOL(<ft_data>).

    IF <ft_data> IS ASSIGNED.
      <ft_data> = gt_ZZENTITY_sample.
    ENDIF.
*fall back API
    CHECK rt_data IS INITIAL.
    CALL METHOD read_entity(
      EXPORTING
        iv_crequest = get_cr_number( )  " Change Request
        iv_entity   = gc_ZZENTITY_sample " Entity Type
        iv_readmode = gc_readmode_act_inact               " Read Mode
      IMPORTING
        eo_data_tab = rt_data ).
  ENDMETHOD.


  method SET_ZZENTITY_SAMPLE.
    MOVE-CORRESPONDING it_data TO gt_ZZENTITY_sample.
  endmethod.
ENDCLASS.
