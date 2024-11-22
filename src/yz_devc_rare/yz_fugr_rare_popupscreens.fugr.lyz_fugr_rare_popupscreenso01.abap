*----------------------------------------------------------------------*
***INCLUDE LYZ_FUGR_RARE_POPUPSCREENSO01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.

  IF  yz_clas_rare_base=>cs_help_info-menufunct = 'YZFC_INPEP'.
    APPEND 'ENTER '  TO fcode.
    SET PF-STATUS 'POPUP' EXCLUDING fcode.
  ELSE.
    SET PF-STATUS 'POPUP'.
  ENDIF.

  SET TITLEBAR 'POPUP'.

  "Logic for LOGO CGNY
  DATA: lv_graphic_xstr TYPE xstring,
        lv_graphic_conv TYPE i,
        lv_graphic_offs TYPE i,
        lv_msg          TYPE string.

  CONSTANTS cv_255      TYPE i VALUE 255.

  CALL METHOD cl_ssf_xsf_utilities=>get_bds_graphic_as_bmp
    EXPORTING
      p_object  = 'GRAPHICS'
      p_name    = 'DELOITTE_UL_LOGO' "IMAGE NAME - Image name from SE78
      p_id      = 'BMAP'
      p_btype   = 'BCOL'  "(BMON = black&white, BCOL = colour)
    RECEIVING
      p_bmp     = lv_graphic_xstr
    EXCEPTIONS
      not_found = 1
      OTHERS    = 2.

  IF sy-subrc <> 0.
    CASE sy-subrc.
      WHEN 1.
        lv_msg  =   'Exception not_found caught while running report YZ_PROG_RARE_POPUP'(032) .
        APPEND lv_msg  TO yz_clas_rare_base=>cs_rare_interface-exceptions.
        CLEAR lv_msg .

      WHEN 2.
        lv_msg  =   'Exception  others caught while running report YZ_PROG_RARE_POPUP'(030) .
        APPEND lv_msg  TO  yz_clas_rare_base=>cs_rare_interface-exceptions.
        CLEAR lv_msg .
    ENDCASE.
  ENDIF.

  gv_graphic_size = xstrlen( lv_graphic_xstr ).
  IF gv_graphic_size > 0.

    lv_graphic_conv = gv_graphic_size.
    lv_graphic_offs = 0.

    WHILE lv_graphic_conv > cv_255.
      gs_graphic_table-line = lv_graphic_xstr+lv_graphic_offs(cv_255).
      APPEND gs_graphic_table TO gt_graphic_table.
      lv_graphic_offs = lv_graphic_offs + cv_255.
      lv_graphic_conv = lv_graphic_conv - cv_255.
    ENDWHILE.

    gs_graphic_table-line = lv_graphic_xstr+lv_graphic_offs(lv_graphic_conv).
    APPEND gs_graphic_table TO gt_graphic_table.

    CALL FUNCTION 'DP_CREATE_URL'
      EXPORTING
        type                 = 'image'(033)                        "#EC NOTEXT
        subtype              = cndp_sap_tab_unknown           " 'X-UNKNOWN'
        size                 = gv_graphic_size
        lifetime             = cndp_lifetime_transaction  "'T'
      TABLES
        data                 = gt_graphic_table
      CHANGING
        url                  = gv_graphic_url
      EXCEPTIONS
        dp_invalid_parameter = 1
        dp_error_put_table   = 2
        dp_error_general     = 3
        OTHERS               = 4.

    IF sy-subrc <> 0.
      CASE sy-subrc.
        WHEN 1.
          lv_msg  =   'Exception dp_invalid_parameter caught while running FM DP_CREATE_URL in report YZ_PROG_RARE_POPUP'(017) .
          APPEND lv_msg  TO  yz_clas_rare_base=>cs_rare_interface-exceptions.
          CLEAR lv_msg .

        WHEN 2.
          lv_msg  =   'Exception  dp_error_put_table caught while running FM DP_CREATE_URL in report YZ_PROG_RARE_POPUP'(018) .
          APPEND lv_msg  TO yz_clas_rare_base=>cs_rare_interface-exceptions.
          CLEAR lv_msg .

        WHEN 3.
          lv_msg  =   'Exception  dp_error_general caught while running FM DP_CREATE_URL in report YZ_PROG_RARE_POPUP'(019) .
          APPEND lv_msg  TO yz_clas_rare_base=>cs_rare_interface-exceptions.
          CLEAR lv_msg .

        WHEN 4.
          lv_msg  =   'Exception  others caught while running report FM DP_CREATE_URL in YZ_PROG_RARE_POPUP'(020) .
          APPEND lv_msg  TO yz_clas_rare_base=>cs_rare_interface-exceptions.
          CLEAR lv_msg .
      ENDCASE.
    ENDIF.
  ELSE.
    lv_msg  =   ' Error while creating graphics in report YZ_PROG_RARE_POPUP'(021) .
    APPEND lv_msg  TO  yz_clas_rare_base=>cs_rare_interface-exceptions.
    CLEAR lv_msg .
  ENDIF.

  CREATE OBJECT gr_h_pic_container
    EXPORTING
      container_name = 'CUST_CONTROL'.

  CREATE OBJECT gr_h_picture
    EXPORTING
      parent = gr_h_pic_container.

  CALL METHOD gr_h_picture->load_picture_from_url
    EXPORTING
      url    = gv_graphic_url
    IMPORTING
      result = gv_result
    EXCEPTIONS
      error  = 1.

  IF sy-subrc <> 0 OR gv_result IS INITIAL.

    CASE sy-subrc.

      WHEN 1.
        lv_msg  =   'Exception  error caught while running method load_picture_from_url in report YZ_PROG_RARE_POPUP'(022) .
        APPEND lv_msg  TO yz_clas_rare_base=>cs_rare_interface-exceptions.
        CLEAR lv_msg .

    ENDCASE.

  ENDIF.

  "Logic for Text editor (Issue Summary)
  CREATE OBJECT gr_editor_container
    EXPORTING
      container_name              = 'TEXT_EDITOR'
    EXCEPTIONS
      cntl_error                  = 1
      cntl_system_error           = 2
      create_error                = 3
      lifetime_error              = 4
      lifetime_dynpro_dynpro_link = 5.

  IF sy-subrc <> 0.

    CASE sy-subrc.

      WHEN 1.
        lv_msg  =   'Exception  cntl_error caught while  creating object gr_editor_container in report YZ_PROG_RARE_POPUP'(023) .
        APPEND lv_msg  TO yz_clas_rare_base=>cs_rare_interface-exceptions.
        CLEAR lv_msg .

      WHEN 2.
        lv_msg  =   'Exception  cntl_system_error caught while  creating object gr_editor_container in report YZ_PROG_RARE_POPUP'(024) .
        APPEND lv_msg  TO yz_clas_rare_base=>cs_rare_interface-exceptions.
        CLEAR lv_msg .

      WHEN 3.
        lv_msg  =   'Exception  create_error caught while  creating object gr_editor_container in report YZ_PROG_RARE_POPUP'(025) .
        APPEND lv_msg  TO  yz_clas_rare_base=>cs_rare_interface-exceptions.
        CLEAR lv_msg .

      WHEN 4.
        lv_msg  =   'Exception  lifetime_error caught while  creating object gr_editor_container in report YZ_PROG_RARE_POPUP'(026) .
        APPEND lv_msg  TO yz_clas_rare_base=>cs_rare_interface-exceptions.
        CLEAR lv_msg .

      WHEN 5.
        lv_msg  =   'Exception  lifetime_dynpro_dynpro_link caught while  creating object gr_editor_container in report YZ_PROG_RARE_POPUP'(027) .
        APPEND lv_msg  TO  yz_clas_rare_base=>cs_rare_interface-exceptions.
        CLEAR lv_msg .
    ENDCASE.

  ENDIF.

  CREATE OBJECT gr_text_editor
    EXPORTING
      parent                     = gr_editor_container
      wordwrap_mode              = cl_gui_textedit=>wordwrap_at_fixed_position "WORDWRAP_AT_WINDOWBORDER"
      wordwrap_position          = gv_line_length
      wordwrap_to_linebreak_mode = cl_gui_textedit=>true.

  "hide the toolbar and as well as status bar for the text editor control.

  CALL METHOD gr_text_editor->set_toolbar_mode
    EXPORTING
      toolbar_mode           = cl_gui_textedit=>false
    EXCEPTIONS
      error_cntl_call_method = 1
      invalid_parameter      = 2.

  IF sy-subrc <> 0.
    CASE sy-subrc.
      WHEN 1.
        lv_msg  =   'Exception error_cntl_call_method caught while running report YZ_PROG_RARE_POPUP'(028) .
        APPEND lv_msg  TO  yz_clas_rare_base=>cs_rare_interface-exceptions.
        CLEAR lv_msg .

      WHEN 2.
        lv_msg  =   'Exception invalid_parameter caught while running report YZ_PROG_RARE_POPUP'(029) .
        APPEND lv_msg  TO yz_clas_rare_base=>cs_rare_interface-exceptions.
        CLEAR lv_msg .
    ENDCASE.
  ENDIF.

  CALL METHOD gr_text_editor->set_statusbar_mode
    EXPORTING
      statusbar_mode         = cl_gui_textedit=>true
    EXCEPTIONS
      error_cntl_call_method = 1
      invalid_parameter      = 2.

  IF sy-subrc <> 0.
    CASE sy-subrc.
      WHEN 1.
        lv_msg  =   'Exception error_cntl_call_method caught while running report YZ_PROG_RARE_POPUP'(028) .
        APPEND lv_msg  TO yz_clas_rare_base=>cs_rare_interface-exceptions.
        CLEAR lv_msg .

      WHEN 2.
        lv_msg  =   'Exception invalid_parameter caught while running report YZ_PROG_RARE_POPUP'(029) .
        APPEND lv_msg  TO  yz_clas_rare_base=>cs_rare_interface-exceptions.
        CLEAR lv_msg .
    ENDCASE.
  ENDIF.

  "Logic for Text editor (Impact)
  CREATE OBJECT gr_editor_impact
    EXPORTING
      container_name              = 'TEXT_IMPACT'
    EXCEPTIONS
      cntl_error                  = 1
      cntl_system_error           = 2
      create_error                = 3
      lifetime_error              = 4
      lifetime_dynpro_dynpro_link = 5.

  IF sy-subrc <> 0.

    CASE sy-subrc.

      WHEN 1.
        lv_msg  =   'Exception  cntl_error caught while  creating object gr_editor_container in report YZ_PROG_RARE_POPUP'(023) .
        APPEND lv_msg  TO yz_clas_rare_base=>cs_rare_interface-exceptions.
        CLEAR lv_msg .

      WHEN 2.
        lv_msg  =   'Exception  cntl_system_error caught while  creating object gr_editor_container in report YZ_PROG_RARE_POPUP'(024) .
        APPEND lv_msg  TO yz_clas_rare_base=>cs_rare_interface-exceptions.
        CLEAR lv_msg .

      WHEN 3.
        lv_msg  =   'Exception  create_error caught while  creating object gr_editor_container in report YZ_PROG_RARE_POPUP'(025) .
        APPEND lv_msg  TO yz_clas_rare_base=>cs_rare_interface-exceptions.
        CLEAR lv_msg .

      WHEN 4.
        lv_msg  =   'Exception  lifetime_error caught while  creating object gr_editor_container in report YZ_PROG_RARE_POPUP'(026) .
        APPEND lv_msg  TO yz_clas_rare_base=>cs_rare_interface-exceptions.
        CLEAR lv_msg .

      WHEN 5.
        lv_msg  =   'Exception  lifetime_dynpro_dynpro_link caught while  creating object gr_editor_container in report YZ_PROG_RARE_POPUP'(027) .
        APPEND lv_msg  TO yz_clas_rare_base=>cs_rare_interface-exceptions.
        CLEAR lv_msg .
    ENDCASE.

  ENDIF.

  CREATE OBJECT gr_text_impact
    EXPORTING
      parent                     = gr_editor_impact
      wordwrap_mode              = cl_gui_textedit=>wordwrap_at_windowborder
      wordwrap_position          = gv_line_length
      wordwrap_to_linebreak_mode = cl_gui_textedit=>true.

  "hide the toolbar and as well as status bar for the text editor control.

  CALL METHOD gr_text_impact->set_toolbar_mode
    EXPORTING
      toolbar_mode           = cl_gui_textedit=>false
    EXCEPTIONS
      error_cntl_call_method = 1
      invalid_parameter      = 2.

  IF sy-subrc <> 0.
    CASE sy-subrc.
      WHEN 1.
        lv_msg  =   'Exception error_cntl_call_method caught while running report YZ_PROG_RARE_POPUP'(028) .
        APPEND lv_msg  TO  gt_exceptions.
        CLEAR lv_msg .

      WHEN 2.
        lv_msg  =   'Exception invalid_parameter caught while running report YZ_PROG_RARE_POPUP'(029) .
        APPEND lv_msg  TO yz_clas_rare_base=>cs_rare_interface-exceptions.
    ENDCASE.
  ENDIF.

  CALL METHOD gr_text_impact->set_statusbar_mode
    EXPORTING
      statusbar_mode         = cl_gui_textedit=>false
    EXCEPTIONS
      error_cntl_call_method = 1
      invalid_parameter      = 2.

  IF sy-subrc <> 0.
    CASE sy-subrc.
      WHEN 1.
        lv_msg  =   'Exception error_cntl_call_method caught while running report YZ_PROG_RARE_POPUP'(028) .
        APPEND lv_msg  TO yz_clas_rare_base=>cs_rare_interface-exceptions.
        CLEAR lv_msg .

      WHEN 2.
        lv_msg  =   'Exception invalid_parameter caught while running report YZ_PROG_RARE_POPUP'(029) .
        APPEND lv_msg  TO  yz_clas_rare_base=>cs_rare_interface-exceptions.
        CLEAR lv_msg .
    ENDCASE.
  ENDIF.

  CALL METHOD gr_text_impact->set_readonly_mode
    EXPORTING
      readonly_mode          = 1
    EXCEPTIONS
      error_cntl_call_method = 1
      invalid_parameter      = 2.

  IF sy-subrc <> 0.
    CASE sy-subrc.
      WHEN 1.
        lv_msg  =   'Exception error_cntl_call_method caught while running report YZ_PROG_RARE_POPUP'(028) .
        APPEND lv_msg  TO  yz_clas_rare_base=>cs_rare_interface-exceptions.
        CLEAR lv_msg .

      WHEN 2.
        lv_msg  =   'Exception invalid_parameter caught while running report YZ_PROG_RARE_POPUP'(029) .
        APPEND lv_msg  TO yz_clas_rare_base=>cs_rare_interface-exceptions.
        CLEAR lv_msg .
    ENDCASE.
  ENDIF.

  gv_text_impact = 'A measure of the effect that the Incident is having on the business.'(001) && cl_abap_char_utilities=>newline
  &&'Often equal to the extent to which agreed or expected levels of service may be distorted.'(002) && cl_abap_char_utilities=>newline
  &&'Together with urgency, it is the major means of assigning priority for dealing with Incidents.'(003) && cl_abap_char_utilities=>newline
  &&'3 - Low: Few users affected or low impact on finances or reputation'(004) && cl_abap_char_utilities=>newline
  &&'2 - Medium: Less than 100 users or moderate impact on finances or reputation'(005) && cl_abap_char_utilities=>newline
  &&'1 - High: More than 100 users or high financial impact or high damage in reputation'(006).

  CALL METHOD gr_text_impact->set_textstream
    EXPORTING
      text   = gv_text_impact
    EXCEPTIONS
      OTHERS = 1.

  IF sy-subrc <> 0.
    CASE sy-subrc.
      WHEN 1.
        lv_msg  =   'Exception  others caught while running report YZ_PROG_RARE_POPUP'(030) .
        APPEND lv_msg  TO  yz_clas_rare_base=>cs_rare_interface-exceptions.
        CLEAR lv_msg .

    ENDCASE.
  ENDIF.

  "Logic for Text editor (Urgency)
  CREATE OBJECT gr_editor_urgency
    EXPORTING
      container_name              = 'TEXT_URGENCY'
    EXCEPTIONS
      cntl_error                  = 1
      cntl_system_error           = 2
      create_error                = 3
      lifetime_error              = 4
      lifetime_dynpro_dynpro_link = 5.

  IF sy-subrc <> 0.

    CASE sy-subrc.

      WHEN 1.
        lv_msg  =   'Exception  cntl_error caught while  creating object gr_editor_container in report YZ_PROG_RARE_POPUP'(023) .
        APPEND lv_msg  TO  yz_clas_rare_base=>cs_rare_interface-exceptions.
        CLEAR lv_msg .

      WHEN 2.
        lv_msg  =   'Exception  cntl_system_error caught while  creating object gr_editor_container in report YZ_PROG_RARE_POPUP'(024) .
        APPEND lv_msg  TO  yz_clas_rare_base=>cs_rare_interface-exceptions.
        CLEAR lv_msg .

      WHEN 3.
        lv_msg  =   'Exception  create_error caught while  creating object gr_editor_container in report YZ_PROG_RARE_POPUP'(025) .
        APPEND lv_msg  TO  yz_clas_rare_base=>cs_rare_interface-exceptions.
        CLEAR lv_msg .

      WHEN 4.
        lv_msg  =   'Exception  lifetime_error caught while  creating object gr_editor_container in report YZ_PROG_RARE_POPUP'(026) .
        APPEND lv_msg  TO  yz_clas_rare_base=>cs_rare_interface-exceptions.
        CLEAR lv_msg .

      WHEN 5.
        lv_msg  =   'Exception  lifetime_dynpro_dynpro_link caught while  creating object gr_editor_container in report YZ_PROG_RARE_POPUP'(027) .
        APPEND lv_msg  TO yz_clas_rare_base=>cs_rare_interface-exceptions.
        CLEAR lv_msg .
    ENDCASE.

  ENDIF.

  CREATE OBJECT gr_text_urgency
    EXPORTING
      parent                     = gr_editor_urgency
      wordwrap_mode              = cl_gui_textedit=>wordwrap_at_windowborder "
      wordwrap_position          = gv_line_length
      wordwrap_to_linebreak_mode = cl_gui_textedit=>true.

  "hide the toolbar and as well as status bar for the text editor control.

  CALL METHOD gr_text_urgency->set_toolbar_mode
    EXPORTING
      toolbar_mode           = cl_gui_textedit=>false
    EXCEPTIONS
      error_cntl_call_method = 1
      invalid_parameter      = 2.

  IF sy-subrc <> 0.
    CASE sy-subrc.
      WHEN 1.
        lv_msg  =   'Exception error_cntl_call_method caught while running report YZ_PROG_RARE_POPUP'(028) .
        APPEND lv_msg  TO yz_clas_rare_base=>cs_rare_interface-exceptions.
        CLEAR lv_msg .

      WHEN 2.
        lv_msg  =   'Exception invalid_parameter caught while running report YZ_PROG_RARE_POPUP'(029) .
        APPEND lv_msg  TO  yz_clas_rare_base=>cs_rare_interface-exceptions.
        CLEAR lv_msg .
    ENDCASE.
  ENDIF.

  CALL METHOD gr_text_urgency->set_statusbar_mode
    EXPORTING
      statusbar_mode         = cl_gui_textedit=>false
    EXCEPTIONS
      error_cntl_call_method = 1
      invalid_parameter      = 2.

  IF sy-subrc <> 0.
    CASE sy-subrc.
      WHEN 1.
        lv_msg  =   'Exception error_cntl_call_method caught while running report YZ_PROG_RARE_POPUP'(028) .
        APPEND lv_msg  TO yz_clas_rare_base=>cs_rare_interface-exceptions.
        CLEAR lv_msg .

      WHEN 2.
        lv_msg  =   'Exception invalid_parameter caught while running report YZ_PROG_RARE_POPUP'(029) .
        APPEND lv_msg  TO yz_clas_rare_base=>cs_rare_interface-exceptions.
        CLEAR lv_msg .
    ENDCASE.
  ENDIF.


  CALL METHOD gr_text_urgency->set_readonly_mode
    EXPORTING
      readonly_mode          = 1
    EXCEPTIONS
      error_cntl_call_method = 1
      invalid_parameter      = 2.

  IF sy-subrc <> 0.
    CASE sy-subrc.
      WHEN 1.
        lv_msg  =   'Exception error_cntl_call_method caught while running report YZ_PROG_RARE_POPUP'(028) .
        APPEND lv_msg  TO  yz_clas_rare_base=>cs_rare_interface-exceptions.
        CLEAR lv_msg .

      WHEN 2.
        lv_msg  =   'Exception invalid_parameter caught while running report YZ_PROG_RARE_POPUP'(029) .
        APPEND lv_msg  TO  yz_clas_rare_base=>cs_rare_interface-exceptions.
        CLEAR lv_msg .
    ENDCASE.
  ENDIF.

  gv_text_urgency = 'Urgency is a measure how quickly a resolution of the Incident is required.'(007) && cl_abap_char_utilities=>newline
  && 'Together with Impact, it is the major means of assigning priority for dealing with Incidents.'(008) && cl_abap_char_utilities=>newline
  && '3 - Low: Damage increases marginally over time, not time sensitive.'(009) && cl_abap_char_utilities=>newline
  && '2 – Medium: Damage increases considerably over time, moderately time sensitive.'(010) && cl_abap_char_utilities=>newline
  && '1 – High: Damage increases rapidly, impacted task(s) highly time sensitive'(011) .

  CALL METHOD gr_text_urgency->set_textstream
    EXPORTING
      text   = gv_text_urgency
    EXCEPTIONS
      OTHERS = 1.

  IF sy-subrc <> 0.
    CASE sy-subrc.
      WHEN 1.
        lv_msg  =   'Exception  others caught while running report YZ_PROG_RARE_POPUP'(030) .
        APPEND lv_msg  TO yz_clas_rare_base=>cs_rare_interface-exceptions.
        CLEAR lv_msg .
    ENDCASE.
  ENDIF.

  "Assign valies of params to screen if they are not initial
  "Caller
  gv_caller = sy-uname.

  "state
  gv_state = 'New'.

  "impact
  IF   gs_rare_inci-impact IS NOT INITIAL .
    gv_impact =  gs_rare_inci-impact.
  ELSE.
*    gv_impact =  '3'.
  ENDIF.

  " urgncy
  IF   gs_rare_inci-urgency IS NOT INITIAL .
    gv_urgency = gs_rare_inci-urgency.
  ELSE.
*    gv_urgency = '2'.
  ENDIF.

  "short_description
  IF  gs_rare_inci-short_description IS NOT INITIAL AND gv_short_description is INITIAL.
    gv_short_description = gs_rare_inci-short_description.
  ENDIF.

  "short_description
  IF gs_rare_inci-tcode IS INITIAL.
    gv_short_description = gs_rare_inci-short_description = 'T-Code :'(013).
    gs_rare_inci-long_description = 'kindly provide T-Code Details as we are unable to Identify T code :'(014).
  ELSE.
    gv_short_description = gs_rare_inci-short_description = 'T-Code :'(013) && gs_rare_inci-tcode.
    gs_rare_inci-long_description = 'Issue while processing Tcode : '(015) && gs_rare_inci-tcode && ' by user : '(016) && gs_rare_inci-user_name.
  ENDIF.


  "Issue summary
  IF gs_rare_inci-long_description IS NOT INITIAL and gv_text is INITIAL.
    gv_text = gs_rare_inci-long_description.
    CALL METHOD gr_text_editor->set_textstream
      EXPORTING
        text   = gv_text
      EXCEPTIONS
        OTHERS = 1.

    "Priority
    IF  gv_priority IS INITIAL.
*      gv_priority = 'LOW'.
    ENDIF.

    IF sy-subrc <> 0.
      CASE sy-subrc.
        WHEN 1.
          lv_msg  =   'Exception  others caught while running report YZ_PROG_RARE_POPUP'(030) .
          APPEND lv_msg  TO  yz_clas_rare_base=>cs_rare_interface-exceptions.
          CLEAR lv_msg .
      ENDCASE.
    ENDIF.
  ENDIF.
ENDMODULE.
