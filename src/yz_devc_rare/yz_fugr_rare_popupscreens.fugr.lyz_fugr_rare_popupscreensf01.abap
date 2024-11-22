*----------------------------------------------------------------------*
***INCLUDE LYZ_FUGR_RARE_POPUPSCREENSF01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  GET_TEXT_FROM_EDITOR
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM get_text_from_editor CHANGING lv_text TYPE string.

  CALL METHOD gr_text_editor->get_text_as_r3table
    IMPORTING
      table  = gt_texttab
    EXCEPTIONS
      OTHERS = 1.

  IF sy-subrc <> 0.
    CASE sy-subrc.
      WHEN 1.
        lv_text  =   'Exception  others caught while running report YZ_PROG_RARE_POPUP'(030) .
        APPEND lv_text  TO  yz_clas_rare_base=>cs_rare_interface-exceptions.
        CLEAR lv_text .

    ENDCASE.
  ENDIF.

*
  LOOP AT gt_texttab INTO gs_texttab.
    CONCATENATE lv_text gs_texttab-line INTO lv_text SEPARATED BY space.
  ENDLOOP.
  SHIFT lv_text LEFT  CIRCULAR BY  1 PLACES.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  MODIFY_INCI_TABLE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM modify_inci_table .
  DATA : lv_text      TYPE string.

  IF gs_rare_inci-guid IS NOT INITIAL.
    SELECT COUNT(*) FROM yztabl_rare_inci WHERE guid = gs_rare_inci-guid.
    IF sy-subrc = 0.
      MODIFY yztabl_rare_inci FROM gs_rare_inci.
      IF sy-subrc = 0.
        CALL FUNCTION 'DB_COMMIT'.
      ENDIF.
    ELSE.
      INSERT yztabl_rare_inci FROM  gs_rare_inci.
    ENDIF.
  ELSE.
    lv_text = 'p_inci-guid initial, error while insert/modify yztabl_rare_inci in report YZ_PROG_RARE_POPUP'(031).
    APPEND lv_text TO yz_clas_rare_base=>cs_rare_interface-exceptions.
    CLEAR lv_text.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  MAP_SCREEN_FIELDS_TO_INCI
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_LV_COMMAND  text
*----------------------------------------------------------------------*
FORM map_screen_fields_to_inci  USING    p_lv_command TYPE char03
                                         p_lv_text    TYPE string.

  gs_rare_inci-command                  = p_lv_command.
  gs_rare_inci-user_name                = gv_caller.
  IF p_lv_text IS NOT INITIAL.
    gs_rare_inci-long_description         = p_lv_text.
  ENDIF.
  gs_rare_inci-short_description        = gv_short_description.
  gs_rare_inci-impact                   = gv_impact.
  gs_rare_inci-urgency                  = gv_urgency.
  gs_rare_inci-state                    = gv_state.

ENDFORM.
