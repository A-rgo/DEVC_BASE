*----------------------------------------------------------------------*
***INCLUDE LYZ_FUGR_RARE_POPUPSCREENSI01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
DATA :     lo_oref_root TYPE REF TO cx_root,
             lv_text      TYPE string,
             lv_command   TYPE char03.

  TRY.

      CASE sy-ucomm.
        WHEN 'ENTER'.

          lv_command = 'ENT'.

          TRY .
              IF  gv_short_description IS  INITIAL.
                MESSAGE i010(yz_msag_rare).
                LEAVE SCREEN.
              ENDIF.

              "Get the description from text editor
              PERFORM get_text_from_editor CHANGING lv_text.

              PERFORM map_screen_fields_to_inci USING lv_command
                                                      lv_text  .

              PERFORM modify_inci_table.

              LEAVE TO SCREEN 0.
            CATCH cx_root INTO lo_oref_root.
              lv_text =  lo_oref_root->get_text( ).
              APPEND lv_text TO yz_clas_rare_base=>cs_rare_interface-exceptions.

              "Send Exceptions
              IF yz_clas_rare_base=>cs_rare_interface-exceptions IS NOT INITIAL.
                yz_clas_rare_base=>send_exceptions( ).
              ENDIF.

          ENDTRY.

        WHEN 'DOWNLOAD'.

          lv_command = 'DOW'.
          TRY .

              IF  gv_short_description IS  INITIAL.
                MESSAGE i010(yz_msag_rare).
                LEAVE SCREEN.
              ENDIF.
              "Get the description from text editor
              PERFORM get_text_from_editor CHANGING lv_text.

              PERFORM map_screen_fields_to_inci USING lv_command
                                                      lv_text.
*
              PERFORM modify_inci_table.

              LEAVE TO SCREEN 0.

            CATCH cx_root INTO lo_oref_root.
              lv_text =  lo_oref_root->get_text( ).
              APPEND lv_text TO yz_clas_rare_base=>cs_rare_interface-exceptions.

              "Send Exceptions
              IF yz_clas_rare_base=>cs_rare_interface-exceptions IS NOT INITIAL.
                yz_clas_rare_base=>send_exceptions( ).

              ENDIF.
          ENDTRY.

        WHEN 'LEAVE' OR 'EXIT'.

          lv_command = 'EXI'.

          TRY.

              PERFORM get_text_from_editor CHANGING lv_text.

              PERFORM map_screen_fields_to_inci USING lv_command
                                                       lv_text.
*
              PERFORM modify_inci_table.

              LEAVE TO SCREEN 0.

            CATCH cx_root INTO lo_oref_root.
              lv_text =  lo_oref_root->get_text( ).
              APPEND lv_text TO yz_clas_rare_base=>cs_rare_interface-exceptions.

              "Send Exceptions
              IF yz_clas_rare_base=>cs_rare_interface-exceptions IS NOT INITIAL.
                yz_clas_rare_base=>send_exceptions( ).

              ENDIF.
          ENDTRY.

        WHEN 'DISPLAY'.

          lv_command = 'DIS'.

          TRY.

              PERFORM get_text_from_editor CHANGING lv_text.

              PERFORM map_screen_fields_to_inci USING lv_command
                                                      lv_text.

              PERFORM modify_inci_table.

              LEAVE TO SCREEN 0.

            CATCH cx_root INTO lo_oref_root.
              lv_text =  lo_oref_root->get_text( ).
              APPEND lv_text TO yz_clas_rare_base=>cs_rare_interface-exceptions.

              "Send Exceptions
              IF yz_clas_rare_base=>cs_rare_interface-exceptions IS NOT INITIAL.
                yz_clas_rare_base=>send_exceptions( ).
              ENDIF.


          ENDTRY.

        WHEN 'EMAIL'.

          lv_command = 'EMA'.

          TRY.

              PERFORM get_text_from_editor CHANGING lv_text.

              PERFORM map_screen_fields_to_inci USING lv_command
                                                      lv_text.
              PERFORM modify_inci_table.

              LEAVE TO SCREEN 0.

            CATCH cx_root INTO lo_oref_root.
              lv_text =  lo_oref_root->get_text( ).
              APPEND lv_text TO yz_clas_rare_base=>cs_rare_interface-exceptions.

              "Send Exceptions
              IF yz_clas_rare_base=>cs_rare_interface-exceptions IS NOT INITIAL.
                yz_clas_rare_base=>send_exceptions( ).

              ENDIF.

          ENDTRY.

          "Logic for Priority
        WHEN 'IMP' OR 'URG'.

          CLEAR : gs_rare_inci-impact,
                  gs_rare_inci-urgency.

          CASE gv_impact.
            WHEN 1.
              IF gv_urgency = 1.
                gv_priority = 'CRITICAL'.
              ELSEIF gv_urgency = 2.
                gv_priority = 'HIGH'.
              ELSEIF gv_urgency = 3.
                gv_priority = 'MODERATE'.
              ENDIF.

            WHEN 2.
              IF gv_urgency = 1.
                gv_priority = 'HIGH'.
              ELSEIF gv_urgency = 2.
                gv_priority = 'MODERATE'.
              ELSEIF gv_urgency = 3.
                gv_priority = 'LOW'.
              ENDIF.

            WHEN 3.
              IF gv_urgency = 1.
                gv_priority = 'MODERATE'.
              ELSEIF gv_urgency = 2.
                gv_priority = 'LOW'.
              ELSEIF gv_urgency = 3.
                gv_priority = 'PLANNING'.
              ENDIF.
              WHEN OTHERS.
          ENDCASE.

          WHEN 'FILE'.
            gs_rare_inci-data_file = gv_file.

        WHEN OTHERS.
          "DO nothing
      ENDCASE.

    CATCH cx_root INTO lo_oref_root.
      lv_text =  lo_oref_root->get_text( ).
      APPEND lv_text TO yz_clas_rare_base=>cs_rare_interface-exceptions.
  ENDTRY.

ENDMODULE.
