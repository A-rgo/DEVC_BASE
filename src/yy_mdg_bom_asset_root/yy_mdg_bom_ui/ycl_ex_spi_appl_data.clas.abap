class YCL_EX_SPI_APPL_DATA definition
  public
  final
  create public .

public section.

  interfaces /PLMB/IF_EX_SPI_APPL_ACCESS .
  interfaces IF_BADI_INTERFACE .

    types:
    BEGIN OF ty_s_sp_handler,
   node_name    TYPE /plmb/spi_node_name,
   sp           TYPE REF TO cl_mdg_bs_mat_sp.
  TYPES END OF ty_s_sp_handler .
  types:
    ty_ts_sp_handler TYPE SORTED TABLE OF ty_s_sp_handler WITH UNIQUE KEY node_name .
protected section.

  class-data MT_SP_HANDLER type TY_TS_SP_HANDLER .

  methods GET_SP_HANDLER
    importing
      !IV_NODE_NAME type /PLMB/SPI_NODE_NAME
      !IV_TARGET_NODE_NAME type /PLMB/SPI_NODE_NAME optional
      !IO_COLLECTOR type ref to /PLMB/IF_SPI_COLLECTOR optional
      !IO_METADATA type ref to /PLMB/IF_SPI_METADATA optional
    returning
      value(EO_SP) type ref to CL_MDG_BS_MAT_SP .
private section.
ENDCLASS.



CLASS YCL_EX_SPI_APPL_DATA IMPLEMENTATION.


  method /PLMB/IF_EX_SPI_APPL_ACCESS~AFTER_ACTION.
RETURN.
  endmethod.


  method /PLMB/IF_EX_SPI_APPL_ACCESS~AFTER_DELETE.
  endmethod.


  method /PLMB/IF_EX_SPI_APPL_ACCESS~AFTER_INSERT.

  RETURN.

  endmethod.


  method /PLMB/IF_EX_SPI_APPL_ACCESS~AFTER_QUERY.
  endmethod.


  method /PLMB/IF_EX_SPI_APPL_ACCESS~AFTER_RETRIEVE.
  endmethod.


  method /PLMB/IF_EX_SPI_APPL_ACCESS~AFTER_UPDATE.
  endmethod.


  method /PLMB/IF_EX_SPI_APPL_ACCESS~BEFORE_ACTION.
  endmethod.


  method /PLMB/IF_EX_SPI_APPL_ACCESS~BEFORE_DELETE.
  endmethod.


  method /PLMB/IF_EX_SPI_APPL_ACCESS~BEFORE_INSERT.
  endmethod.


  method /PLMB/IF_EX_SPI_APPL_ACCESS~BEFORE_QUERY.
  endmethod.


  method /PLMB/IF_EX_SPI_APPL_ACCESS~BEFORE_RETRIEVE.
  endmethod.


  method /PLMB/IF_EX_SPI_APPL_ACCESS~BEFORE_UPDATE.
  endmethod.


  method /PLMB/IF_EX_SPI_APPL_ACCESS~MODIFY_BEFORE_ACTION.
  endmethod.


  method /PLMB/IF_EX_SPI_APPL_ACCESS~MODIFY_BEFORE_DELETE.
  endmethod.


  METHOD /plmb/if_ex_spi_appl_access~modify_before_insert.

    DATA:  lv_crequest   TYPE usmd_crequest. "change request
    DATA(lo_context) = cl_usmd_app_context=>get_context( ).
    CHECK lo_context IS BOUND.
    CHECK lo_context IS NOT INITIAL.
    lv_crequest = lo_context->mv_crequest_id.

    DATA: lo_model1 TYPE REF TO if_usmd_model_ext.
    CONSTANTS: lc_fieldname TYPE usmd_fieldname VALUE 'MATERIAL'.
    DATA: lt_entity TYPE usmd_ts_data_entity.
    DATA: lt_entity_a TYPE usmd_ts_data_entity.
    FIELD-SYMBOLS: <lt_entity_1> TYPE any.
    FIELD-SYMBOLS: <lfs_ybomhdr_data> TYPE ANY TABLE,
                   <lfs_ybomitm_data> TYPE ANY TABLE,
                   <lfs_entity>       TYPE any,
                   <lfs_node_data>    TYPE any.
    TYPES: BEGIN OF ls_ybomhdr_ex,
             material TYPE matnr,
             werks    TYPE werks_d,
             ystalt   TYPE stalt,
             ystlan   TYPE stlan,
             ystlnr   TYPE stnum,
             ystlty   TYPE stlty,
           END OF ls_ybomhdr_ex.

    DATA: lt_ybomhdr_ex TYPE TABLE OF ls_ybomhdr_ex,
          lw_ybomhdr_ex LIKE LINE OF lt_ybomhdr_ex.

    TYPES: BEGIN OF ls_ybomitm_ex,
             material  TYPE matnr,
             werks     TYPE werks_d,
             ystalt    TYPE stalt,
             ystlan    TYPE stlan,
             ystlnr    TYPE stnum,
             ystlty    TYPE stlty,
             yitemid   TYPE stlkn,
             yybomitnr TYPE sposn,
           END OF ls_ybomitm_ex.

    DATA: lt_ybomitm_ex TYPE TABLE OF ls_ybomitm_ex,
          lw_ybomitm_ex LIKE LINE OF lt_ybomitm_ex.

    DATA: lv_matnr      TYPE matnr,
          lv_werks      TYPE werks_d,
          lv_stalt      TYPE stalt,
          lv_stlan      TYPE stlan,
          lv_ystlan     TYPE stlan,
          lv_itemnumber TYPE n LENGTH 4.

    CONSTANTS: lc_internal TYPE c LENGTH 8 VALUE 'INTERNAL',
               lc_M        TYPE c LENGTH 1 VALUE 'M'.

    DATA: lv_stlal_num TYPE n LENGTH 2,
          lv_meins     TYPE meins.

*      Read the Material number and werks from the node
    IF cs_node_id IS NOT INITIAL.
      ASSIGN COMPONENT 'MATNR' OF STRUCTURE cs_node_id TO FIELD-SYMBOL(<lfs_node_id_matnr>).
      IF <lfs_node_id_matnr> IS ASSIGNED.
        lv_matnr = <lfs_node_id_matnr>.
      ENDIF.
      ASSIGN COMPONENT 'WERKS' OF STRUCTURE cs_node_id TO FIELD-SYMBOL(<lfs_node_id_werks>).
      IF <lfs_node_id_werks> IS ASSIGNED.
        lv_werks = <lfs_node_id_werks>.
      ENDIF.
    ENDIF.

*     Instantiniate Model
    CALL METHOD cl_usmd_model_ext=>get_instance
      EXPORTING
        i_usmd_model = 'MM'              " Data model
      IMPORTING
        eo_instance  = lo_model1            " MDM Data Model for Access from Non-SAP Standard
*       et_message   =                  " Messages
      .
    " Reading the data from the data base
    IF sy-uname = 'ASWARUP' OR sy-uname = 'PGODKAR'.
      DATA: lt_changed_data TYPE usmd_ts_entity_fieldname.
      DATA: lt_sel TYPE usmd_ts_sel,
            lw_sel TYPE usmd_s_sel.
      FIELD-SYMBOLS: <lfs_lt_data> TYPE ANY TABLE.
      DATA: lv_changed_entity TYPE usmd_fieldname.
      IF lo_model1 IS BOUND.

        "   CL_USMD_MDF_CHANGE_DOCUMENT=>get_instance( ).


*         "Reading the changed entity
*         CALL METHOD lo_model1->get_changed_fields
*           IMPORTING
*             et_entity_fieldname =    lt_changed_data              " Field Names of Entity Type
*           .
*         LOOP AT lt_changed_data INTO DATA(ls_changed_data).
*           IF LS_CHANGED_DATA-USMD_ENTITY EQ 'YBOMITM'.
*             lv_changed_entity = ls_changed_data-usmd_entity.
*



*             lv_changed_entity = 'YBOMITM'.
*
*             CALL METHOD lo_model1->create_data_reference
*               EXPORTING
*                 i_fieldname          =    lv_changed_entity               " Field Name
*                  i_struct             = 'KATTR'"gc_struct_key     " Structure
**                 it_attribute         =                   " Field Names
**                  if_incl_active_fld   = space             " MDGAF: General Indicator
**                 if_incl_edition_fld  = space             " MDGAF: General Indicator
**                 if_incl_obsolete_flg = space             " Financial MDM: General Indicator
**                 if_incl_actioncode   = space             " Financial MDM: General Indicator
**                 if_table             = 'X'               " Financial MDM: General Indicator
**                 if_edtn_number       = space
**                 i_tabtype            = gc_tabtype_hashed " Single-Character Indicator
*               IMPORTING
*                 er_data              =  data(lt_ybomitm_data)
**                 et_message           =                   " Messages
*               .
*
*            ASSIGN  lt_ybomitm_data->* TO <lfs_lt_data>.
*
*DATA : lw_readmode TYPE c value '2'.
*
*             Call METHOD lo_model1->read_char_value
*               EXPORTING
*                 i_fieldname       =     lv_changed_entity               " Field Name
**                 it_sel            =                     " Sorted Table: Selection Condition (Range per Field)
**                 if_edition_logic  = 'X'                 " Financial MDM: General Indicator
*                 i_readmode        =  lw_readmode
**                 if_use_edtn_slice = 'X'                 " 'X'=Do Not Read Any Other Data Slices
**                 if_no_flush       = abap_false
*               IMPORTING
*                 et_data           =  <lfs_lt_data>
**                 et_message        =                     " Messages
*               .
*
*           endif.
*         ENDLOOP.

        DATA : lt_entity_f TYPE usmd_t_entity.
*
**  lt_entity = VALUE #( [ 'YBOMHDR' ] ).
*
*        APPEND 'YBOMHDR' TO lt_entity_f.
        APPEND 'YBOMITM' TO lt_entity_f.
*
*
*       CALL METHOD lo_model1->read_entity_data_all
*         EXPORTING
*           i_fieldname      =      lc_fieldname            " Financial MDM: Field Name
*           if_active        =      abap_true           " Financial MDM: General Indicator
*           i_crequest       =      lv_crequest           " Change Request
**           it_sel           =                  " Sorted Table: Selection Condition (Range per Field)
**           it_entity_filter =   lt_entity_f               " Ent.Types for Which Data Is Expected; Default: All Ent.Types
*         IMPORTING
**           et_message       =                  " Messages
*           et_data_entity   =   lt_entity               " Data for Entity Types
*         .

        INSERT VALUE #( sign = 'I' option = 'EQ' low = lv_matnr fieldname = lc_fieldname ) INTO TABLE lt_sel.

        CALL METHOD lo_model1->read_entity_data_all
          EXPORTING
            i_fieldname      = lc_fieldname            " Financial MDM: Field Name
            if_active        = abap_true           " Financial MDM: General Indicator
*           i_crequest       = lv_crequest           " Change Request
            it_sel           = lt_sel              " Sorted Table: Selection Condition (Range per Field)
            it_entity_filter = lt_entity_f              " Ent.Types for Which Data Is Expected; Default: All Ent.Types
          IMPORTING
*           et_message       =                  " Messages
            et_data_entity   = lt_entity_a.               " Data for Entity Types



      ENDIF.
    ENDIF.

*     Get existing data
    IF lo_model1 IS BOUND.
      CALL METHOD lo_model1->read_entity_data_all
        EXPORTING
          i_fieldname    = lc_fieldname            " Financial MDM: Field Name
          if_active      = abap_false           " Financial MDM: General Indicator
          i_crequest     = lv_crequest           " Change Request
*         it_sel         =                  " Sorted Table: Selection Condition (Range per Field)
*         it_entity_filter =                  " Ent.Types for Which Data Is Expected; Default: All Ent.Types
        IMPORTING
*         et_message     =                  " Messages
          et_data_entity = lt_entity.               " Data for Entity Types
    ENDIF.
* SOC by Balasubramani Kamaraj
    READ TABLE lt_entity ASSIGNING FIELD-SYMBOL(<lfs_entity_material>) WITH KEY usmd_entity = 'MATERIAL' struct = 'KATTR'
                                                                                usmd_entity_cont = ' '.
    IF sy-subrc = 0.
      ASSIGN <lfs_entity_material>-r_t_data TO FIELD-SYMBOL(<lfs_material>).
      IF <lfs_material> IS ASSIGNED.
        ASSIGN <lfs_material>->* TO FIELD-SYMBOL(<lfs_material_data>).
        IF <lfs_material_data> IS ASSIGNED.
          LOOP AT <lfs_material_data> ASSIGNING FIELD-SYMBOL(<lfs_wa_material_data>).
            ASSIGN COMPONENT 'MEINS' OF STRUCTURE <lfs_wa_material_data> TO FIELD-SYMBOL(<lfs_meins>).
            IF <lfs_meins> IS ASSIGNED.
              lv_meins = <lfs_meins>.
            ENDIF.
          ENDLOOP.
        ENDIF.
      ENDIF.
    ENDIF.
* EOC by Balasubramani Kamaraj
    CASE iv_target_node_name.
*   Derivation for Node YBOMHDR
      WHEN 'YMDGM_YBOMHDR'.
        READ TABLE lt_entity ASSIGNING FIELD-SYMBOL(<lfs_entity_ybomhdr>) WITH KEY usmd_entity_cont = 'YBOMHDR'.
        IF sy-subrc = 0.
          ASSIGN <lfs_entity_ybomhdr>-r_t_data TO FIELD-SYMBOL(<lfs_ybomhdr>).
          IF <lfs_ybomhdr> IS ASSIGNED.
            ASSIGN <lfs_ybomhdr>->* TO <lfs_ybomhdr_data>.
            IF <lfs_ybomhdr_data> IS ASSIGNED.
              LOOP AT <lfs_ybomhdr_data> ASSIGNING FIELD-SYMBOL(<lfs_wa_ybomhdr_data>).
                ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <lfs_wa_ybomhdr_data> TO FIELD-SYMBOL(<lfs_material_ex>).
                IF <lfs_material_ex> IS ASSIGNED.
                  lw_ybomhdr_ex-material = <lfs_material_ex>.
                ENDIF.

                ASSIGN COMPONENT 'WERKS' OF STRUCTURE <lfs_wa_ybomhdr_data> TO FIELD-SYMBOL(<lfs_werks_ex>).
                IF <lfs_werks_ex> IS ASSIGNED.
                  lw_ybomhdr_ex-werks = <lfs_werks_ex>.
                ENDIF.

                ASSIGN COMPONENT 'YSTALT' OF STRUCTURE <lfs_wa_ybomhdr_data> TO FIELD-SYMBOL(<lfs_ystalt_ex>).
                IF <lfs_ystalt_ex> IS ASSIGNED.
                  lw_ybomhdr_ex-ystalt = <lfs_ystalt_ex>.
                ENDIF.

                ASSIGN COMPONENT 'YSTLAN' OF STRUCTURE <lfs_wa_ybomhdr_data> TO FIELD-SYMBOL(<lfs_ystlan_ex>).
                IF <lfs_ystlan_ex> IS ASSIGNED.
                  lw_ybomhdr_ex-ystlan = <lfs_ystlan_ex>.
                ENDIF.

                ASSIGN COMPONENT 'YSTLNR' OF STRUCTURE <lfs_wa_ybomhdr_data> TO FIELD-SYMBOL(<lfs_ystlnr_ex>).
                IF <lfs_ystlnr_ex> IS ASSIGNED.
                  lw_ybomhdr_ex-ystlnr = <lfs_ystlnr_ex>.
                ENDIF.

                ASSIGN COMPONENT 'YSTLTY' OF STRUCTURE <lfs_wa_ybomhdr_data> TO FIELD-SYMBOL(<lfs_ystlty_ex>).
                IF <lfs_ystlty_ex> IS ASSIGNED.
                  lw_ybomhdr_ex-ystlty = <lfs_ystlty_ex>.
                ENDIF.

                APPEND lw_ybomhdr_ex TO lt_ybomhdr_ex.

              ENDLOOP.
            ENDIF.
          ENDIF.
        ENDIF.

        "Sort the lt_ybomhdr in desc order to fetch the latest Alt. BOM Number
        SORT: lt_ybomhdr_ex BY ystalt DESCENDING.

***     Read the Material number and werks from the node
**     IF cs_node_id IS NOT INITIAL.
**     ASSIGN COMPONENT 'MATNR' OF STRUCTURE cs_node_id TO FIELD-SYMBOL(<lfs_node_id_matnr>).
**     IF <lfs_node_id_matnr> IS ASSIGNED.
**       lv_matnr = <lfs_node_id_matnr>.
**     ENDIF.
**     ASSIGN COMPONENT 'WERKS' OF STRUCTURE cs_node_id TO FIELD-SYMBOL(<lfs_node_id_werks>).
**     IF <lfs_node_id_werks> IS ASSIGNED.
**       lv_werks = <lfs_node_id_werks>.
**     ENDIF.
**     ENDIF.
        "Removing the werks which are not contained in the node
        DELETE lt_ybomhdr_ex WHERE werks NE lv_werks.

        "Assigning the values to the current data
        LOOP AT ct_node_data ASSIGNING <lfs_node_data>.
          ASSIGN COMPONENT 'STLAN' OF STRUCTURE <lfs_node_data> TO FIELD-SYMBOL(<lfs_ystlan>).
          IF <lfs_ystlan> IS ASSIGNED.
            lv_ystlan = <lfs_ystlan>.
          ENDIF.
          "Delete the ystlan which is not currently accessed
          DELETE lt_ybomhdr_ex WHERE ystlan NE lv_ystlan.
          "Assign the Bill Of Material Number
          ASSIGN COMPONENT 'STLNR' OF STRUCTURE <lfs_node_data> TO FIELD-SYMBOL(<lfs_stlnr>).
          IF <lfs_stlnr> IS ASSIGNED.
            <lfs_stlnr> = lc_internal.
          ENDIF.
*       SOC by Balasubramani Kamaraj
*         "Assign the BOM Category
*         ASSIGN COMPONENT 'STLTY' OF STRUCTURE <lfs_node_data> TO FIELD-SYMBOL(<lfs_stlty>).
*         IF <lfs_stlty> IS ASSIGNED.
*           <lfs_stlty> = lc_m.
*         ENDIF.
*
*         "Assign the Alternative BOM
*         ASSIGN COMPONENT 'STLAL' OF STRUCTURE <lfs_node_data> TO FIELD-SYMBOL(<lfs_stlal>).
*         IF <lfs_stlal> IS ASSIGNED.
*          IF line_exists( lt_ybomhdr_ex[ material = lv_matnr werks = lv_werks ystlan = lv_ystlan ] )."If Combination of Material, Plant and BOM exists
*           READ TABLE lt_ybomhdr_ex INTO DATA(ls_ybomhdr_ex) INDEX 1. "Read the highest item number from sorted table
*           IF sy-subrc = 0.
*             DATA(lv_stlal) = ls_ybomhdr_ex-ystalt.
*             ADD 1 TO lv_stlal.
*             lv_stlal_num = lv_stlal.
*             <lfs_stlal> = lv_stlal_num.
*           ENDIF.
*          ELSE. "If Combination of Material, Plant and BOM Usage doesn't exits
*            <lfs_stlal> = '01'. "Set Alt BOM as 01
*          ENDIF.
*         ENDIF.
*
          "Assign the Valid From
          ASSIGN COMPONENT 'DATUV' OF STRUCTURE <lfs_node_data> TO FIELD-SYMBOL(<lfs_datuv>).
          IF <lfs_datuv> IS ASSIGNED.
            <lfs_datuv> = sy-datum.
          ENDIF.
*
*         "Assign Base Quantity
          ASSIGN COMPONENT 'BMENG' OF STRUCTURE <lfs_node_data> TO FIELD-SYMBOL(<lfs_bmeng>).
          IF <lfs_bmeng> IS ASSIGNED.
            <lfs_bmeng> = '1'.
          ENDIF.
*         EOC by Balasubramani Kamaraj..

          "Assign Base UOM
          ASSIGN COMPONENT 'BMEIN' OF STRUCTURE <lfs_node_data> TO FIELD-SYMBOL(<lfs_bmein>).
          IF <lfs_bmein> IS ASSIGNED.
            <lfs_bmein> = lv_meins.
          ENDIF.
*       SOC by Balasubramani Kamaraj
*         "Assign BOM Status
*         ASSIGN COMPONENT 'STLST' OF STRUCTURE <lfs_node_data> TO FIELD-SYMBOL(<lfs_stlst>).
*         IF <lfs_stlst> IS ASSIGNED.
*           <lfs_stlst> = '1'.
*         ENDIF.
**        EOC by Balasubramani Kamaraj
        ENDLOOP.



*    Derivation for Node YBOMITM
      WHEN 'YMDGM_YBOMITM'.
        READ TABLE lt_entity ASSIGNING FIELD-SYMBOL(<lfs_entity_ybomitm>) WITH KEY usmd_entity_cont = 'YBOMITM'.
        IF sy-subrc = 0.
          ASSIGN <lfs_entity_ybomitm>-r_t_data TO FIELD-SYMBOL(<lfs_ybomitm>).
          IF <lfs_ybomitm> IS ASSIGNED.
            ASSIGN <lfs_ybomitm>->* TO <lfs_ybomitm_data>.
          ENDIF.
          IF <lfs_ybomitm_data> IS ASSIGNED.
            LOOP AT <lfs_ybomitm_data> ASSIGNING FIELD-SYMBOL(<lfs_wa_ybomitm_data>).
              ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <lfs_wa_ybomitm_data> TO <lfs_material_ex>.
              IF <lfs_material_ex> IS ASSIGNED.
                lw_ybomitm_ex-material = <lfs_material_ex>.
              ENDIF.
              ASSIGN COMPONENT 'WERKS' OF STRUCTURE <lfs_wa_ybomitm_data> TO <lfs_werks_ex>.
              IF <lfs_werks_ex> IS ASSIGNED.
                lw_ybomitm_ex-werks = <lfs_werks_ex>.
              ENDIF.
              ASSIGN COMPONENT 'YSTALT' OF STRUCTURE <lfs_wa_ybomitm_data> TO <lfs_ystalt_ex>.
              IF <lfs_ystalt_ex> IS ASSIGNED.
                lw_ybomitm_ex-ystalt = <lfs_ystalt_ex>.
              ENDIF.
              ASSIGN COMPONENT 'YSTLAN' OF STRUCTURE <lfs_wa_ybomitm_data> TO <lfs_ystlan_ex>.
              IF <lfs_ystlan_ex> IS ASSIGNED.
                lw_ybomitm_ex-ystlan = <lfs_ystlan_ex>.
              ENDIF.
              ASSIGN COMPONENT 'YSTLNR' OF STRUCTURE <lfs_wa_ybomitm_data> TO <lfs_ystlnr_ex>.
              IF <lfs_ystlnr_ex> IS ASSIGNED.
                lw_ybomitm_ex-ystlnr = <lfs_ystlnr_ex>.
              ENDIF.
              ASSIGN COMPONENT 'YSTLTY' OF STRUCTURE <lfs_wa_ybomitm_data> TO <lfs_ystlty_ex>.
              IF <lfs_ystlty_ex> IS ASSIGNED.
                lw_ybomitm_ex-ystlty = <lfs_ystlty_ex>.
              ENDIF.
              ASSIGN COMPONENT 'YITEMID' OF STRUCTURE <lfs_wa_ybomitm_data> TO FIELD-SYMBOL(<lfs_yitemid_ex>).
              IF <lfs_yitemid_ex> IS ASSIGNED.
                lw_ybomitm_ex-yitemid = <lfs_yitemid_ex>.
              ENDIF.
              ASSIGN COMPONENT 'YYBOMITNR' OF STRUCTURE <lfs_wa_ybomitm_data> TO FIELD-SYMBOL(<lfs_yybomitnr_ex>).
              IF <lfs_yybomitnr_ex> IS ASSIGNED.
                lw_ybomitm_ex-yybomitnr = <lfs_yybomitnr_ex>.
              ENDIF.

              APPEND lw_ybomitm_ex TO lt_ybomitm_ex.
            ENDLOOP.
          ENDIF.
        ENDIF.

        UNASSIGN : <lfs_entity_ybomitm>,<lfs_wa_ybomitm_data>.

        READ TABLE lt_entity_a ASSIGNING <lfs_entity_ybomitm> WITH KEY usmd_entity_cont = 'YBOMITM'.
        IF sy-subrc = 0.
          ASSIGN <lfs_entity_ybomitm>-r_t_data TO <lfs_ybomitm>.
          IF <lfs_ybomitm> IS ASSIGNED.
            ASSIGN <lfs_ybomitm>->* TO <lfs_ybomitm_data>.
          ENDIF.
          IF <lfs_ybomitm_data> IS ASSIGNED.
            LOOP AT <lfs_ybomitm_data> ASSIGNING <lfs_wa_ybomitm_data>.
              ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <lfs_wa_ybomitm_data> TO <lfs_material_ex>.
              IF <lfs_material_ex> IS ASSIGNED.
                lw_ybomitm_ex-material = <lfs_material_ex>.
              ENDIF.
              ASSIGN COMPONENT 'WERKS' OF STRUCTURE <lfs_wa_ybomitm_data> TO <lfs_werks_ex>.
              IF <lfs_werks_ex> IS ASSIGNED.
                lw_ybomitm_ex-werks = <lfs_werks_ex>.
              ENDIF.
              ASSIGN COMPONENT 'YSTALT' OF STRUCTURE <lfs_wa_ybomitm_data> TO <lfs_ystalt_ex>.
              IF <lfs_ystalt_ex> IS ASSIGNED.
                lw_ybomitm_ex-ystalt = <lfs_ystalt_ex>.
              ENDIF.
              ASSIGN COMPONENT 'YSTLAN' OF STRUCTURE <lfs_wa_ybomitm_data> TO <lfs_ystlan_ex>.
              IF <lfs_ystlan_ex> IS ASSIGNED.
                lw_ybomitm_ex-ystlan = <lfs_ystlan_ex>.
              ENDIF.
              ASSIGN COMPONENT 'YSTLNR' OF STRUCTURE <lfs_wa_ybomitm_data> TO <lfs_ystlnr_ex>.
              IF <lfs_ystlnr_ex> IS ASSIGNED.
                lw_ybomitm_ex-ystlnr = <lfs_ystlnr_ex>.
              ENDIF.
              ASSIGN COMPONENT 'YSTLTY' OF STRUCTURE <lfs_wa_ybomitm_data> TO <lfs_ystlty_ex>.
              IF <lfs_ystlty_ex> IS ASSIGNED.
                lw_ybomitm_ex-ystlty = <lfs_ystlty_ex>.
              ENDIF.
              ASSIGN COMPONENT 'YITEMID' OF STRUCTURE <lfs_wa_ybomitm_data> TO <lfs_yitemid_ex>.
              IF <lfs_yitemid_ex> IS ASSIGNED.
                lw_ybomitm_ex-yitemid = <lfs_yitemid_ex>.
              ENDIF.
              ASSIGN COMPONENT 'YYBOMITNR' OF STRUCTURE <lfs_wa_ybomitm_data> TO <lfs_yybomitnr_ex>.
              IF <lfs_yybomitnr_ex> IS ASSIGNED.
                lw_ybomitm_ex-yybomitnr = <lfs_yybomitnr_ex>.
              ENDIF.

              APPEND lw_ybomitm_ex TO lt_ybomitm_ex.
            ENDLOOP.
          ENDIF.
        ENDIF.



        IF cs_node_id IS NOT INITIAL.
          ASSIGN COMPONENT 'STLAL' OF STRUCTURE cs_node_id TO FIELD-SYMBOL(<lfs_node_id_stalt>).
          IF <lfs_node_id_stalt> IS ASSIGNED.
            lv_stalt = <lfs_node_id_stalt>.
          ENDIF.
          ASSIGN COMPONENT 'STLAN' OF STRUCTURE cs_node_id TO FIELD-SYMBOL(<lfs_node_id_stlan>).
          IF <lfs_node_id_stlan> IS ASSIGNED.
            lv_stlan = <lfs_node_id_stlan>.
          ENDIF.
        ENDIF.
        SORT: lt_ybomitm_ex BY yitemid DESCENDING.
        DELETE lt_ybomitm_ex WHERE werks NE lv_werks OR ystalt NE lv_stalt OR ystlan NE lv_stlan.
*          DELETE lt_ybomitm_ex WHERE werks NE lv_werks OR ystlan NE lv_stlan.
        "Assigning the values to the current data
        LOOP AT ct_node_data ASSIGNING <lfs_node_data>.
          ASSIGN COMPONENT 'STLAN' OF STRUCTURE <lfs_node_data> TO <lfs_ystlan>.
          IF <lfs_ystlan> IS ASSIGNED.
            lv_ystlan = <lfs_ystlan>.
          ENDIF.
          "Assign the item id
          ASSIGN COMPONENT 'STLKN' OF STRUCTURE <lfs_node_data> TO FIELD-SYMBOL(<lfs_stlkn>).
          IF <lfs_stlkn> IS ASSIGNED.
            READ TABLE lt_ybomitm_ex INTO DATA(ls_ybomitm_ex) INDEX 1. "Read the highest item number from sorted table
            IF sy-subrc = 0.
              DATA(lv_stlkn) = ls_ybomitm_ex-yitemid.
              ADD 1 TO lv_stlkn.
              <lfs_stlkn> = lv_stlkn.
            ELSE." First Enrty
              <lfs_stlkn> = '00000001'.
            ENDIF.
          ENDIF.
*
          "Assign Item Number
          ASSIGN COMPONENT 'POSNR' OF STRUCTURE <lfs_node_data> TO FIELD-SYMBOL(<lfs_posnr>).
          IF <lfs_posnr> IS ASSIGNED.
            READ TABLE lt_ybomitm_ex INTO ls_ybomitm_ex INDEX 1.
            IF sy-subrc = 0.
              DATA(lv_posnr) = ls_ybomitm_ex-yybomitnr.
              ADD 10 TO lv_posnr.
              lv_itemnumber = lv_posnr.
              <lfs_posnr> = lv_itemnumber.
            ELSE.
              <lfs_posnr> = '0010'.
            ENDIF.
          ENDIF.

          "Assign Valid from
          ASSIGN COMPONENT 'DATUV' OF STRUCTURE <lfs_node_data> TO FIELD-SYMBOL(<LFS_item_datuv>).
          IF <LFS_item_datuv> IS ASSIGNED.
            <LFS_item_datuv> = sy-datum.
          ENDIF.
          "assign valid to
          ASSIGN COMPONENT 'DATUB' OF STRUCTURE <lfs_node_data> TO FIELD-SYMBOL(<LFS_validto>).
          IF <LFS_validto> IS ASSIGNED.
            <LFS_validto> = '99991231'.
          ENDIF.

          ASSIGN COMPONENT 'IDNRK' OF STRUCTURE <lfs_node_data> TO FIELD-SYMBOL(<lfs_idnrk>).
          IF <lfs_idnrk> IS ASSIGNED.
            SELECT SINGLE maktx FROM makt INTO @DATA(lv_maktx) WHERE matnr = @<lfs_idnrk>.
            IF sy-subrc = 0.
              ASSIGN COMPONENT 'MAKTX' OF STRUCTURE <lfs_node_data> TO FIELD-SYMBOL(<lfs_makt>).
              IF <lfs_makt> IS ASSIGNED.
                <lfs_makt> = lv_maktx.
              ENDIF.
            ENDIF.

            SELECT SINGLE meins FROM mara INTO lv_meins WHERE matnr = <lfs_idnrk>.
            IF sy-subrc = 0.
              ASSIGN COMPONENT 'MEINS' OF STRUCTURE <lfs_node_data> TO FIELD-SYMBOL(<lfs_MEINS_ITEM>).
              IF <lfs_meins_ITEM> IS ASSIGNED.
                <lfs_meins_ITEM> = lv_meins.
              ENDIF.
            ENDIF.
          ENDIF.

        ENDLOOP.
    ENDCASE.

  ENDMETHOD.


  method /PLMB/IF_EX_SPI_APPL_ACCESS~MODIFY_BEFORE_QUERY.
  endmethod.


  method /PLMB/IF_EX_SPI_APPL_ACCESS~MODIFY_BEFORE_RETRIEVE.
  endmethod.


  method /PLMB/IF_EX_SPI_APPL_ACCESS~MODIFY_BEFORE_UPDATE.
  endmethod.


  method GET_SP_HANDLER.
*
**      types:
**    BEGIN OF ty_s_sp_handler,
**   node_name    TYPE /plmb/spi_node_name,
**   sp           TYPE REF TO cl_mdg_bs_mat_sp.
**  TYPES END OF ty_s_sp_handler .
**  types:
**    ty_ts_sp_handler TYPE SORTED TABLE OF ty_s_sp_handler WITH UNIQUE KEY node_name .
*
*  DATA ls_sp_handler TYPE ty_s_sp_handler.
*  DATA ls_options    TYPE /plmb/s_spi_sp_options.
*  DATA lv_node_name  TYPE /plmb/spi_node_name.
*
** Name of the node for which the SP instance is requested
*  IF iv_target_node_name IS NOT INITIAL.
*    lv_node_name = iv_target_node_name.
*  ELSE.
*    lv_node_name = iv_node_name.
*  ENDIF.
*
** Relevant nodes:
*  IF cl_mdg_bs_mat_mp=>is_custom_node( iv_node_name = iv_node_name ) EQ abap_false.
*    IF iv_target_node_name IS NOT INITIAL.
*      IF cl_mdg_bs_mat_mp=>is_custom_node( iv_node_name = iv_target_node_name ) EQ abap_false.
*        RETURN.
*      ENDIF.
*    ELSE.
*      RETURN.
*    ENDIF.
*  ENDIF.
*
** get handler from last call (will be set during retrieve data)
*  READ TABLE mt_sp_handler INTO ls_sp_handler WITH TABLE KEY node_name = lv_node_name.
*
** New handler
*  IF sy-subrc IS NOT INITIAL. "Handler not yet created => Instanciate new handler
*
*    IF io_collector IS NOT BOUND AND io_metadata IS NOT BOUND.
*      RETURN. "instanciation not needed at this point of call
*    ENDIF.
*
*    ls_sp_handler-node_name = lv_node_name.
*    CREATE OBJECT ls_sp_handler-sp.
*    IF sy-subrc IS NOT INITIAL OR ls_sp_handler-sp IS NOT BOUND.
*      ASSERT 0 = 1. "unecpected situation
*    ENDIF.
*    INSERT ls_sp_handler INTO TABLE mt_sp_handler.
*
*    ls_options-collector = io_collector.
*    ls_options-metadata  = io_metadata.
*    CALL METHOD ls_sp_handler-sp->/plmb/if_spi_appl_access_init~initialize
*      EXPORTING
*        is_options = ls_options.
*
*  ENDIF.
*
** return result
*  eo_sp = ls_sp_handler-sp.


  endmethod.
ENDCLASS.
