CLASS zcl_pd_ariba_ext_api DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES:
      BEGIN OF gtyp_json_entry,
        type    TYPE i,
        subtype TYPE i,
        parent  TYPE string,
        name    TYPE string,
        value   TYPE string,
      END OF gtyp_json_entry .
    TYPES:
      gtyp_t_json_entry_map TYPE STANDARD TABLE OF gtyp_json_entry .   " WITH UNIQUE KEY parent name .
    TYPES:
      BEGIN OF gtyp_attachment_det,
        filename  TYPE string,
        filesize  TYPE string,
        id        TYPE string,
        mimetype  TYPE string,
        rawstring TYPE string,
      END OF gtyp_attachment_det .
    TYPES:
      gtyp_t_attachment_det TYPE STANDARD TABLE OF gtyp_attachment_det .   " WITH UNIQUE KEY parent name .
    TYPES:
      gtyp_t_attachment_id TYPE STANDARD TABLE OF string .
    TYPES:
      BEGIN OF gtyp_doc_det,
        processtype TYPE string,
        docnum      TYPE string,
      END OF gtyp_doc_det .
    TYPES:
      gtyp_t_doc_det TYPE STANDARD TABLE OF gtyp_doc_det .

    CLASS-DATA gv_access_token TYPE string .
    CLASS-DATA gv_request_type TYPE string .

    CLASS-METHODS call_ariiba_ext_api
      IMPORTING
        !iv_smvendor_id   TYPE string
      EXPORTING
        !eif_response     TYPE REF TO if_rest_entity
        !et_attachment_id TYPE gtyp_t_attachment_det .
  PROTECTED SECTION.
  PRIVATE SECTION.

    CLASS-METHODS get_access_token
      IMPORTING
        !iv_auth_key         TYPE string OPTIONAL
        !iv_auth_req_for_api TYPE char1 OPTIONAL ##NEEDED
      EXPORTING
        !ev_access_token     TYPE string .
    CLASS-METHODS get_entity_details
      IMPORTING
        !iv_document_no   TYPE string
        !iv_entity_type   TYPE string
      EXPORTING
        !et_attachment_id TYPE GTyp_T_ATTACHMENT_DET .
    CLASS-METHODS get_attachment
      IMPORTING
        !iv_document_no   TYPE string
        !iv_entity_type   TYPE string
      EXPORTING
        !EiF_RESPONSE     TYPE REF TO if_rest_entity
      CHANGING
        !cT_ATTACHMENT_ID TYPE GTyp_T_ATTACHMENT_DET .
    CLASS-METHODS get_supplier_doc_num
      IMPORTING
        !iv_smvendor_id TYPE string
      EXPORTING
        !ev_document_id TYPE string
        !et_doc_no      TYPE GTyp_T_DOC_DET .
ENDCLASS.



CLASS ZCL_PD_ARIBA_EXT_API IMPLEMENTATION.


  METHOD call_ariiba_ext_api.
************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* NIKHISIN     | 19.05.2022 | 0000012339: PDM-Ariba_SLP_MDG_Integration*
*              |            | DM4K903459                               *
*----------------------------------------------------------------------*
    DATA: lv_access_token_e TYPE string,
          lv_access_token_s TYPE string,
          lv_doc_no         TYPE string,
          lv_entity_type    TYPE string,
          lt_attachment     TYPE gtyp_t_attachment_det,
          lt_attachment_id  TYPE gtyp_t_attachment_det,
          lv_auth_key_supp  TYPE string,
          lv_auth_key_ext   TYPE string,
          lt_doc_no         TYPE gtyp_t_doc_det,
          ls_doc_no         LIKE LINE OF lt_doc_no.

*   Preparation to call supplier data api
    lv_auth_key_supp = 'Basic OWM0NjcwYWQtNzE4Ny00ODZlLWFmZDQtZmM5OWE4MmYwZGE5OmRsdEc0MkV6YlRFMlJ2R2FBVmoxWVVCVENvWU4zQmo2' ##NO_TEXT.
    get_access_token(
      EXPORTING
        iv_auth_key         = lv_auth_key_supp                 " auth key to get access token
        iv_auth_req_for_api = 'S'                              " (E- Externa APIl /S-Supplier data API)
      IMPORTING
        ev_access_token     = lv_access_token_s                 " access token
    ).
    CHECK lv_access_token_s IS NOT INITIAL.
    get_supplier_doc_num(
      EXPORTING
        iv_smvendor_id = iv_smvendor_id                 " Ariba SM Vendor ID
      IMPORTING
        ev_document_id = lv_doc_no
        et_doc_no      = lt_doc_no                " Ariba Questionar Document ID
    ).
*   Preparation to call external approval API
    lv_auth_key_ext = 'Basic MThhMDFhYjktMmUxOC00NDA0LWE5NDYtYTg3NGI1YjdkMmY3OkJtbWo5WU5MYXhkdHZTM1UxMlBkRk1WVjczRXBtZHNk' ##NO_TEXT.
    get_access_token(
      EXPORTING
        iv_auth_key         = lv_auth_key_ext                 " auth key to get access token
        iv_auth_req_for_api = 'S'                              " (E- Externa APIl /S-Supplier data API)
      IMPORTING
        ev_access_token = lv_access_token_e                 " access token
    ).

    CHECK lv_access_token_e IS NOT INITIAL.
    lv_entity_type = 'RFXDocument'.

    LOOP AT lt_doc_no INTO ls_doc_no.
      lv_doc_no = ls_doc_no-docnum.
      get_entity_details(
        EXPORTING
          iv_document_no   = lv_doc_no
          iv_entity_type   = lv_entity_type
        IMPORTING
          et_attachment_id = lt_attachment
      ).
      APPEND LINES OF lt_attachment TO lt_attachment_id.
      CLEAR: lv_doc_no.
    ENDLOOP.
    CHECK lt_attachment_id IS NOT INITIAL.

    get_attachment(
       EXPORTING
        iv_document_no          = lv_doc_no
        iv_entity_type          = lv_entity_type
      IMPORTING eif_response    = eif_response
      CHANGING ct_attachment_id = lt_attachment_id ).

    et_attachment_id = lt_attachment_id.
  ENDMETHOD.


  METHOD get_access_token.
************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* NIKHISIN     | 19.05.2022 | 0000012339: PDM-Ariba_SLP_MDG_Integration*
*              |            | DM4K903459                               *
*----------------------------------------------------------------------*
    TYPES: BEGIN OF ltyp_json_resp,
             access_token  TYPE string,
             refresh_token TYPE string,
             token_type    TYPE string,
             scope         TYPE string,
             expires_in    TYPE string,
           END OF ltyp_json_resp.
    TYPES: BEGIN OF ltyp_json_req,
             grant_type TYPE string,
           END OF ltyp_json_req.
    DATA: ls_json_req TYPE ltyp_json_req.
    DATA lo_json_serializer   TYPE REF TO cl_trex_json_serializer.
    DATA: lif_http_client   TYPE REF TO if_http_client,
          lif_request       TYPE REF TO if_rest_entity,
          lo_rest_client    TYPE REF TO cl_rest_http_client,
          lv_url            TYPE        string,
          lv_body           TYPE        string ##NEEDED,
          lv_token          TYPE        string,
*          lv_agreements     TYPE        string,
          lv_auth_token     TYPE string,
          lif_response      TYPE REF TO     if_rest_entity,
*          lo_json           TYPE REF TO cl_clb_parse_json,
*          lo_sql            TYPE REF TO cx_sy_open_sql_db,
*          lv_status         TYPE  string,
          lv_reason         TYPE  string ##NEEDED,
          lv_response       TYPE  string ##NEEDED,
          lv_content_length TYPE  string ##NEEDED,
          lv_location       TYPE  string ##NEEDED,
          lv_content_type   TYPE  string ##NEEDED.

    DATA: ls_json_resp TYPE ltyp_json_resp.
* Create HTTP intance using RFC restination created
    cl_http_client=>create_by_destination(
      EXPORTING
        destination              = 'ARIBAEXTTOKEN'    " Logical destination (specified in function call)
      IMPORTING
        client                   = lif_http_client    " HTTP Client Abstraction
      EXCEPTIONS
        argument_not_found       = 1
        destination_not_found    = 2
        destination_no_authority = 3
        plugin_not_active        = 4
        internal_error           = 5
        OTHERS                   = 6
     ).
    IF sy-subrc IS NOT INITIAL.
      RETURN.
    ENDIF.

    lo_rest_client = NEW #( io_http_client = lif_http_client ).
* Set HTTP version
    lif_http_client->request->set_version( if_http_request=>co_protocol_version_1_0 ).
    IF lif_http_client IS BOUND AND lo_rest_client IS BOUND.

* Set the URI if any
      cl_http_utility=>set_request_uri(
*        EXPORTING
          request = lif_http_client->request    " HTTP Framework (iHTTP) HTTP Request
          uri     = lv_url                     " URI String (in the Form of /path?query-string)
      ).
* Set Payload or body ( JSON or XML)
* ABAP to JSON
      ls_json_req-grant_type = 'client_credentials'.
*      CREATE OBJECT lr_json_serializer EXPORTING data = lv_json_req.
      lo_json_serializer = NEW #( data = ls_json_req ).
      lo_json_serializer->serialize( ).
      lv_body = lo_json_serializer->get_data( ).
      lif_request = lo_rest_client->if_rest_client~create_request_entity( ).
      lif_request->set_content_type( iv_media_type = if_rest_media_type=>gc_appl_www_form_url_encoded ).
      lif_http_client->request->set_cdata(
*        EXPORTING
          data   =  'grant_type=client_credentials'                  " Character data
      ).
* Set request header if any
      lv_token = iv_auth_key.
      lo_rest_client->if_rest_client~set_request_header(
*        EXPORTING
          iv_name  = 'Authorization'
          iv_value = lv_token ) ##NO_TEXT.

* HTTP GET
      lo_rest_client->if_rest_client~post( io_entity = lif_request ).

* HTTP response
      lif_response = lo_rest_client->if_rest_client~get_response_entity( ).

* HTTP return status
      DATA(lv_http_status)   = lif_response->get_header_field( '~status_code' ) ##NEEDED.

* Collect response
      lv_reason = lif_response->get_header_field( '~status_reason' ).
      lv_content_length = lif_response->get_header_field( 'content-length' ).
      lv_location = lif_response->get_header_field( 'location' ).
      lv_content_type = lif_response->get_header_field( 'content-type' ).
      lv_response = lif_response->get_string_data( ).
* HTTP JSON return string
      DATA(lv_json_response) = lif_response->get_string_data( ).
* Class to convert the JSON to an ABAP sttructure
      /ui2/cl_json=>deserialize(
        EXPORTING
          json             =  lv_json_response                " JSON string
        CHANGING
          data             =  ls_json_resp                " Data to serialize
      ).
* Prepare bearer token for next call
*      CONCATENATE ls_json_resp-token_type ls_json_resp-access_token INTO lv_auth_token SEPARATED BY space.
      lv_auth_token =  |{ ls_json_resp-token_type }| && space && | { ls_json_resp-access_token  } |.
      ev_access_token = lv_auth_token.
      gv_access_token = lv_auth_token.
    ENDIF.
  ENDMETHOD.


  METHOD get_attachment.
************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* NIKHISIN     | 19.05.2022 | 0000012339: PDM-Ariba_SLP_MDG_Integration*
*              |            | DM4K903459                               *
*----------------------------------------------------------------------*
    DATA: lif_http_client   TYPE REF TO if_http_client,
          lo_rest_client    TYPE REF TO cl_rest_http_client,
          lv_url            TYPE        string,
          lv_token          TYPE        string,
          lif_response      TYPE REF TO     if_rest_entity,
          lv_reason         TYPE  string ##NEEDED,
          lv_response       TYPE  string ##NEEDED,
          lv_content_length TYPE  string ##NEEDED,
          lv_location       TYPE  string ##NEEDED,
          lv_content_type   TYPE  string ##NEEDED.
    FIELD-SYMBOLS: <ls_attachment_id> TYPE gtyp_attachment_det.
    LOOP AT ct_attachment_id ASSIGNING <ls_attachment_id>.
      CHECK sy-subrc IS INITIAL AND <ls_attachment_id> IS ASSIGNED AND <ls_attachment_id>-id IS NOT INITIAL.
      CLEAR: lv_url.
* Create http intance using rfc restination created You can directly use the REST service URL as well
      cl_http_client=>create_by_destination(
        EXPORTING
          destination              = 'ARIBAEXTAPI'    " Logical destination (specified in function call)
        IMPORTING
          client                   = lif_http_client    " HTTP Client Abstraction
        EXCEPTIONS
          argument_not_found       = 1
          destination_not_found    = 2
          destination_no_authority = 3
          plugin_not_active        = 4
          internal_error           = 5
          OTHERS                   = 6
       ).
      IF sy-subrc IS NOT INITIAL.
        RETURN.
      ENDIF.

      lo_rest_client = NEW #( io_http_client = lif_http_client ).
* Set HTTP version
      lif_http_client->request->set_version( if_http_request=>co_protocol_version_1_0 ).
      IF lif_http_client IS BOUND AND lo_rest_client IS BOUND.

* Set the URI if any
        lv_url = |{ '/' }| & |{ iv_entity_type }| & |{ '/' }| & |{ iv_document_no }| & |{ '/attachments/' }| & |{ <ls_attachment_id>-id }|.
        cl_http_utility=>set_request_uri(
            request = lif_http_client->request    " HTTP Framework (iHTTP) HTTP Request
            uri     = lv_url                     " URI String (in the Form of /path?query-string)
        ).

        cl_http_utility=>set_query(
            request    = lif_http_client->request
            query      = 'realm=adidas-S-T'                 " Query String (in Form of form_field1=1&form_field2=2)
        ) ##NO_TEXT.

* Set request header if any
        lo_rest_client->if_rest_client~set_request_header(
            iv_name  = 'Authorization'
            iv_value = gv_access_token ) ##NO_TEXT.
        lv_token = 'cSXsRRg39zpnwH5GhAMRdGAJc8vPA9qb' ##NO_TEXT.
        lo_rest_client->if_rest_client~set_request_header(
            iv_name  = 'apiKey'
            iv_value = lv_token ).

* HTTP GET
        lo_rest_client->if_rest_client~get( ).

* HTTP response
        eif_response = lo_rest_client->if_rest_client~get_response_entity( ).
        lif_response = lo_rest_client->if_rest_client~get_response_entity( ).

* HTTP return status
        DATA(lv_http_status)   = lif_response->get_header_field( '~status_code' ) ##NEEDED.

* Collect response
        lv_reason = lif_response->get_header_field( '~status_reason' ).
        lv_content_length = lif_response->get_header_field( 'content-length' ).
        lv_location = lif_response->get_header_field( 'location' ).
        lv_content_type = lif_response->get_header_field( 'content-type' ).
        DATA(lv_content_disposition) = lif_response->get_header_field( 'content-disposition' ) ##NEEDED.
        lv_response = lif_response->get_binary_data( ).
* HTTP JSON return string
        DATA(lv_json_response) = lif_response->get_string_data( ) ##NEEDED.
        <ls_attachment_id>-rawstring = lif_response->get_binary_data( ).
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD get_entity_details.
************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* NIKHISIN     | 19.05.2022 | 0000012339: PDM-Ariba_SLP_MDG_Integration*
*              |            | DM4K903459                               *
*----------------------------------------------------------------------*
    DATA: lif_http_client   TYPE REF TO if_http_client,
          lo_rest_client    TYPE REF TO cl_rest_http_client,
          lv_url            TYPE        string,
          lv_token          TYPE        string,
          lif_response      TYPE REF TO     if_rest_entity,
          lv_reason         TYPE  string ##NEEDED,
          lv_response       TYPE  string ##NEEDED,
          lv_content_length TYPE  string ##NEEDED,
          lv_location       TYPE  string ##NEEDED,
          lv_content_type   TYPE  string ##NEEDED.
    DATA: lt_json_entries TYPE gtyp_t_json_entry_map.
    DATA: ls_json_entries LIKE LINE OF lt_json_entries.
*    DATA: ls_json_entries2 LIKE LINE OF lt_json_entries.
    DATA: lo_cl_json_parser TYPE REF TO /ui5/cl_json_parser.
    DATA: ls_attachment_det TYPE gtyp_attachment_det.
* Create http intance using rfc restination created
* You can directly use the REST service URL as well
    cl_http_client=>create_by_destination(
      EXPORTING
        destination              = 'ARIBAEXTAPI'    " Logical destination (specified in function call)
      IMPORTING
        client                   = lif_http_client    " HTTP Client Abstraction
      EXCEPTIONS
        argument_not_found       = 1
        destination_not_found    = 2
        destination_no_authority = 3
        plugin_not_active        = 4
        internal_error           = 5
        OTHERS                   = 6
     ).
    IF sy-subrc IS NOT INITIAL.
      RETURN.
    ENDIF.


    lo_rest_client = NEW #( io_http_client = lif_http_client ).
* Set HTTP version
    lif_http_client->request->set_version( if_http_request=>co_protocol_version_1_0 ).
    IF lif_http_client IS BOUND AND lo_rest_client IS BOUND.

* Set the URI if any
      lv_url = |{ '/' }| & |{ iv_entity_type }| & |{ '/' }| & |{ iv_document_no }|.
      cl_http_utility=>set_request_uri(
          request = lif_http_client->request    " HTTP Framework (iHTTP) HTTP Request
          uri     = lv_url                     " URI String (in the Form of /path?query-string)
      ).

      cl_http_utility=>set_query(
          request    = lif_http_client->request
          query      = 'realm=adidas-S-T'                 " Query String (in Form of form_field1=1&form_field2=2)
      ) ##NO_TEXT.

* Set request header if any
      lo_rest_client->if_rest_client~set_request_header(
          iv_name  = 'Authorization'
          iv_value = gv_access_token ) ##NO_TEXT.
      lv_token = 'cSXsRRg39zpnwH5GhAMRdGAJc8vPA9qb' ##NO_TEXT.
      lo_rest_client->if_rest_client~set_request_header(
          iv_name  = 'apiKey'
          iv_value = lv_token ).

* HTTP GET
      lo_rest_client->if_rest_client~get( ).

* HTTP response
      lif_response = lo_rest_client->if_rest_client~get_response_entity( ).

* HTTP return status
      DATA(lv_http_status)   = lif_response->get_header_field( '~status_code' ) ##NEEDED.

* Collect response
      lv_reason = lif_response->get_header_field( '~status_reason' ).
      lv_content_length = lif_response->get_header_field( 'content-length' ).
      lv_location = lif_response->get_header_field( 'location' ).
      lv_content_type = lif_response->get_header_field( 'content-type' ).

* HTTP JSON return string
      lv_response = lif_response->get_string_data( ).
* Class to convert the JSON to an ABAP sttructure
*      CREATE OBJECT lo_cl_json_parser.
      lo_cl_json_parser = NEW #( ).
      lo_cl_json_parser->parse( json = lv_response ).
      lt_json_entries = lo_cl_json_parser->m_entries.

      SORT lt_json_entries BY parent.

      LOOP AT lt_json_entries INTO ls_json_entries WHERE parent CP '/answers/*/attachmentAnswer'.
        CASE ls_json_entries-name.
          WHEN 'fileName'.
            ls_attachment_det-filename = ls_json_entries-value.
          WHEN 'fileSize'.
            ls_attachment_det-filesize = ls_json_entries-value.
          WHEN 'id'.
            ls_attachment_det-id = ls_json_entries-value.
          WHEN 'mimeType'.
            ls_attachment_det-mimetype = ls_json_entries-value.
            APPEND ls_attachment_det TO et_attachment_id.
        ENDCASE.

      ENDLOOP.
    ENDIF.

  ENDMETHOD.


  METHOD get_supplier_doc_num.
************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* NIKHISIN     | 19.05.2022 | 0000012339: PDM-Ariba_SLP_MDG_Integration*
*              |            | DM4K903459                               *
*----------------------------------------------------------------------*
    DATA: lif_http_client   TYPE REF TO if_http_client,
          lo_rest_client    TYPE REF TO cl_rest_http_client,
          lv_url            TYPE        string,
          lv_token          TYPE        string,
          lif_response      TYPE REF TO     if_rest_entity,
          lv_response       TYPE  string,
          lv_location       TYPE  string,
          lo_cl_json_parser TYPE REF TO /ui5/cl_json_parser,
          lt_doc_no         TYPE gtyp_t_doc_det,
          ls_doc_no         LIKE LINE OF lt_doc_no.
    DATA: lt_json_entries TYPE gtyp_t_json_entry_map.
    DATA: ls_json_entries LIKE LINE OF lt_json_entries.
* Create http intance using rfc restination created
* You can directly use the REST service URL as well
    cl_http_client=>create_by_destination(
      EXPORTING
        destination              = 'ARIBASUPAPI'    " Logical destination (specified in function call)
      IMPORTING
        client                   = lif_http_client    " HTTP Client Abstraction
      EXCEPTIONS
        argument_not_found       = 1
        destination_not_found    = 2
        destination_no_authority = 3
        plugin_not_active        = 4
        internal_error           = 5
        OTHERS                   = 6
     ).
    IF sy-subrc IS NOT INITIAL.
      RETURN.
    ENDIF.

    lo_rest_client = NEW #( io_http_client = lif_http_client ).
* Set HTTP version
    lif_http_client->request->set_version( if_http_request=>co_protocol_version_1_0 ).
    IF lif_http_client IS BOUND AND lo_rest_client IS BOUND.

* Set the URI if any
      lv_url =  |{ '/vendors/' }| & | { iv_smvendor_id  } | & | { '/workspaces/questionnaires/qna'  } |.
      cl_http_utility=>set_request_uri(
          request = lif_http_client->request
          uri     = lv_url                     " URI String (in the Form of /path?query-string)
      ).

      cl_http_utility=>set_query(
          request    = lif_http_client->request
          query      = 'realm=adidas-S-T'                 " Query String (in Form of form_field1=1&form_field2=2)
      ) ##NO_TEXT.

* Set request header if any
      lo_rest_client->if_rest_client~set_request_header(
          iv_name  = 'Authorization'
          iv_value = gv_access_token ) ##NO_TEXT.
      lv_token = 'nrXQKkHPUrGmPKiZ9X5MdJquFT0GFRfi' ##NO_TEXT.
      lo_rest_client->if_rest_client~set_request_header(
          iv_name  = 'apiKey'
          iv_value = lv_token ).

* HTTP GET
      lo_rest_client->if_rest_client~get( ).

* HTTP response
      lif_response = lo_rest_client->if_rest_client~get_response_entity( ).

* HTTP return status
      DATA(lv_http_status)   = lif_response->get_header_field( '~status_code' ) ##NEEDED.

* HTTP JSON return string
      lv_response = lif_response->get_string_data( ).
* Class to convert the JSON to an ABAP sttructure
      lo_cl_json_parser = NEW #( ).
      lo_cl_json_parser->parse( json = lv_response ).
      lt_json_entries = lo_cl_json_parser->m_entries.

      READ TABLE lt_json_entries WITH KEY name = 'questionnaireId' INTO ls_json_entries ##NO_TEXT.
      IF sy-subrc IS INITIAL.
        ev_document_id = ls_json_entries-value.
      ENDIF.

      LOOP AT lt_json_entries INTO ls_json_entries WHERE name = 'questionnaireId'.
        CHECK ls_json_entries-value IS NOT INITIAL AND ls_json_entries-value NE lv_location.
        ls_doc_no-docnum = ls_json_entries-value.
        READ TABLE lt_json_entries WITH KEY parent = ls_json_entries-parent name = 'workspaceType' INTO DATA(ls_wrkspc_typ).
        IF sy-subrc IS INITIAL.
          ls_doc_no-processtype = ls_wrkspc_typ-value.
        ENDIF.
        APPEND ls_doc_no TO lt_doc_no.
        lv_location = ls_json_entries-value.
      ENDLOOP.
      IF lt_doc_no IS NOT INITIAL.
        SORT lt_doc_no DESCENDING BY docnum.
        IF zcl_pd_ariba_ext_api=>gv_request_type IS NOT INITIAL.
          DELETE lt_doc_no WHERE processtype NE zcl_pd_ariba_ext_api=>gv_request_type.
        ENDIF.
        DELETE ADJACENT DUPLICATES FROM lt_doc_no COMPARING docnum.
        IF lt_doc_no IS NOT INITIAL.
          READ TABLE lt_doc_no INTO ls_doc_no INDEX 1.
          IF sy-subrc IS INITIAL.
            ev_document_id = ls_doc_no-docnum.
          ENDIF.
          et_doc_no = lt_doc_no.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
