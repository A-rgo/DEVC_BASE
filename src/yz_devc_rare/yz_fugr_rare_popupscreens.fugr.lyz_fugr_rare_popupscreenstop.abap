FUNCTION-POOL YZ_FUGR_RARE_POPUPSCREENS.    "MESSAGE-ID ..

* INCLUDE LYZ_FUGR_RARE_POPUPSCREENSD...     " Local class definition


* INCLUDE LYZ_FUGR_RARE_POPUPSCREENSD...     " Local class definition

"Screen 100
CONSTANTS: gc_cntl_true  TYPE i VALUE 1.
*           gc_cntl_false TYPE i VALUE 0.

DATA : gt_exceptions TYPE cts_strings.

DATA:      gr_h_picture       TYPE REF TO cl_gui_picture,
           gr_h_pic_container TYPE REF TO cl_gui_custom_container.

DATA:      gv_graphic_url(255),
*           gv_graphic_refresh(1),
           gv_result           LIKE gc_cntl_true,
           gv_graphic_size     TYPE i.

TYPES : BEGIN OF ty_graphic_table,
          line(255) TYPE x,
        END OF ty_graphic_table.

DATA : gt_graphic_table TYPE TABLE OF ty_graphic_table,
       gs_graphic_table TYPE          ty_graphic_table.


"Declaration for text editor
CONSTANTS:       gc_line_length TYPE i VALUE 200.

TYPES: BEGIN OF ty_texttab_line,
         line(gc_line_length) TYPE c,
       END OF ty_texttab_line.

DATA : gs_texttab TYPE ty_texttab_line,
       gt_texttab TYPE TABLE OF ty_texttab_line.

DATA: gv_line_length  TYPE i VALUE 254,
      gv_text         TYPE string,
      gv_text_impact  TYPE string,
      gv_text_urgency TYPE string.
*      gv_texteditor.

DATA :gr_editor_container TYPE REF TO cl_gui_custom_container, "Issue summary
      gr_editor_impact    TYPE REF TO cl_gui_custom_container, "Impact
      gr_editor_urgency   TYPE REF TO cl_gui_custom_container, "Urgency
      gr_text_editor      TYPE REF TO cl_gui_textedit,
      gr_text_impact      TYPE REF TO cl_gui_textedit,
      gr_text_urgency     TYPE REF TO cl_gui_textedit.

"interface
DATA : gs_rare_inci   TYPE      yztabl_rare_inci.

"Screen Fields
DATA : gv_caller            TYPE yz_dtel_rare_caller,
       gv_state             TYPE yz_dtel_rare_state,
       gv_impact            TYPE yz_dtel_rare_impact,
       gv_urgency           TYPE yz_dtel_rare_urgency,
       gv_short_description TYPE string,
       gv_priority          TYPE string,
       gv_file              .

DATA  : gv_subject,
         gv_email type YZTABL_RARE_INCI-EMAIL_ADDRESS.

DATA : fcode  TYPE STANDARD TABLE OF  sy-ucomm.
