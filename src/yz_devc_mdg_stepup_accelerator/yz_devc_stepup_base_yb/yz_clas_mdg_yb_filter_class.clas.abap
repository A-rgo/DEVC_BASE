class YZ_CLAS_MDG_YB_FILTER_CLASS definition
  public
  final
  create public .

public section.

  interfaces IF_DRF_FILTER .
protected section.
private section.
ENDCLASS.



CLASS YZ_CLAS_MDG_YB_FILTER_CLASS IMPLEMENTATION.


  METHOD if_drf_filter~apply_filter.
*    et_filtered_objects[] = it_unfiltered_objects[].
    DATA: lt_drfout  TYPE TABLE OF ybnka_drf_s_key_structure,
          ls_drfout LIKE LINE OF lt_drfout.
    LOOP AT it_external_criteria ASSIGNING FIELD-SYMBOL(<fs_trange>).
      LOOP AT <fs_trange>-frange_t ASSIGNING FIELD-SYMBOL(<fs_frange>).
        LOOP AT <fs_frange>-selopt_t ASSIGNING FIELD-SYMBOL(<fs_selopt>).
          CASE <fs_frange>-fieldname.
            WHEN 'Y_BANKS'.
              ls_drfout-y_banks = <fs_selopt>-low.
*              lt_drfout = VALUE #( ( y_banks = <fs_selopt>-low ) ).
            WHEN 'Y_BANKL'.
              ls_drfout-y_bankl = <fs_selopt>-low.
*              lt_drfout = VALUE #( ( y_bankl = <fs_selopt>-low ) ).
            WHEN OTHERS.
          ENDCASE.
        ENDLOOP.
      ENDLOOP.
    ENDLOOP.
    IF ls_drfout is NOT INITIAL.
          APPEND ls_drfout to lt_drfout.
    ENDIF.

    IF lt_drfout IS INITIAL.
      et_filtered_objects[] = it_unfiltered_objects[].
    ELSE.
      et_filtered_objects[] = lt_drfout[].
    ENDIF.
  ENDMETHOD.
ENDCLASS.
