class ZCL_VALIDATE_PAN definition
  public
  final
  create public .

public section.

  class-methods VALIDATE_PAN
    importing
      !IV_PAN_NUMBER type STRING
    exporting
      !EV_REQUEST_STATUS type CHAR20
      !EV_PAN_STATUS type CHAR20
      !EV_PAN_HOLDER_NAME type CHAR70
      !EV_PAN_TYPE type CHAR50
      !EV_REASON_MESSAGE type CHAR30 .
  class-methods VALIDATE_AADHAAR
    importing
      !IV_AADHAR_NUMBER type STRING
    exporting
      !EV_REQUEST_STATUS type CHAR20
      !EV_AADHAR_STATUS type CHAR20
      !EV_AADHAR_HOLDER_NAME type CHAR70
      !EV_AADHAR_TYPE type CHAR50
      !EV_REASON_MESSAGE type CHAR30 .
protected section.
private section.
ENDCLASS.



CLASS ZCL_VALIDATE_PAN IMPLEMENTATION.


  METHOD VALIDATE_AADHAAR.
    TYPES:
      BEGIN OF gty_json_entry,
        type    TYPE i,
        subtype TYPE i,
        parent  TYPE string,
        name    TYPE string,
        value   TYPE string,
      END OF gty_json_entry .
    TYPES:
      tt_json_entry_map TYPE STANDARD TABLE OF gty_json_entry .
    DATA: lo_cl_json_parser TYPE REF TO /ui5/cl_json_parser.
    DATA: lt_json_entries TYPE tt_json_entry_map,
          ls_json_entries LIKE LINE OF lt_json_entries.
    DATA: lo_http_client TYPE REF TO if_http_client.
    DATA: response TYPE string.
    DATA: status         TYPE  string,
          reason         TYPE  string,
          content_length TYPE  string,
          location       TYPE  string,
          content_type   TYPE  string.
    DATA: lv_body        TYPE        string.
    DATA lr_json_serializer   TYPE REF TO cl_trex_json_serializer.
    "create HTTP client by url
    "API endpoint for API sandbox
    CALL METHOD cl_http_client=>create_by_url
      EXPORTING
        url                = 'https://test.zoop.one/api/v1/in/identity/aadhaar/verification'
      IMPORTING
        client             = lo_http_client
      EXCEPTIONS
        argument_not_found = 1
        plugin_not_active  = 2
        internal_error     = 3
        OTHERS             = 4.

    IF sy-subrc NE 0.
      ev_request_status = 'Fail'.
      EV_REASON_MESSAGE = 'HTTP Client creation by URL failed-internal_error'.
      RETURN.
    ENDIF.

    "setting request method
    lo_http_client->request->set_method('POST').

    "adding headers
    lo_http_client->request->set_header_field( name = 'api-key' value = '2RM8J6Q-DFG4S0J-KV0T2NH-9RVDT5M' ).
    lo_http_client->request->set_header_field( name = 'app-id' value = '632ac2d336b2a0001d474116' ).
    lo_http_client->request->set_header_field( name = 'DataServiceVersion' value = '2.0' ).
    lo_http_client->request->set_header_field( name = 'Accept' value = 'application/json' ).
    lo_http_client->request->set_header_field( name = 'Content-Type' value = 'application/json' ).

    DATA(lv_aadhaar) = iv_aadhar_number.
    CONDENSE lv_aadhaar.

    CONCATENATE '{"data": {"customer_aadhaar_number": "' lv_aadhaar '", "consent": "Y", "consent_text": "I hear by declare my consent agreement for fetching my information via ZOOP API."}}' INTO lv_body.
    CALL METHOD lo_http_client->request->set_cdata
      EXPORTING
        data = lv_body.

    CALL METHOD lo_http_client->send
      EXCEPTIONS
        http_communication_failure = 1
        http_invalid_state         = 2
        http_processing_failed     = 3
        http_invalid_timeout       = 4
        OTHERS                     = 5.

    IF sy-subrc NE 0.
      ev_request_status = 'Fail'.
      EV_REASON_MESSAGE = 'Http_communication_failure : lo_http_client->receive'.
      RETURN.
    ENDIF.
    CALL METHOD lo_http_client->receive
      EXCEPTIONS
        http_communication_failure = 1
        http_invalid_state         = 2
        http_processing_failed     = 3
        OTHERS                     = 5.

    IF sy-subrc NE 0.
      ev_request_status = 'Fail'.
      EV_REASON_MESSAGE = 'Http_communication_failure : lo_http_client->receive'.
      RETURN.
    ENDIF.

    response = lo_http_client->response->get_cdata( ).

    CREATE OBJECT lo_cl_json_parser.
    lo_cl_json_parser->parse( json = response ).
    lt_json_entries = lo_cl_json_parser->m_entries.
*  response
    READ TABLE lt_json_entries WITH KEY name = 'success' INTO ls_json_entries.
    IF sy-subrc IS INITIAL.
      TRANSLATE ls_json_entries-value TO UPPER CASE.
      ev_request_status = ls_json_entries-value.
    ENDIF.
    READ TABLE lt_json_entries WITH KEY name = 'reason_message' INTO ls_json_entries.
    IF sy-subrc IS INITIAL.
      ev_reason_message = ls_json_entries-value.
    ENDIF.
    READ TABLE lt_json_entries WITH KEY name = 'pan_status' INTO ls_json_entries.
    IF sy-subrc IS INITIAL.
      TRANSLATE ls_json_entries-value TO UPPER CASE.
      ev_aadhar_status = ls_json_entries-value.
    ENDIF.
    READ TABLE lt_json_entries WITH KEY name = 'user_full_name' INTO ls_json_entries.
    IF sy-subrc IS INITIAL.
      TRANSLATE ls_json_entries-value TO UPPER CASE.
      ev_aadhar_holder_name = ls_json_entries-value.
    ENDIF.
    READ TABLE lt_json_entries WITH KEY name = 'pan_type' INTO ls_json_entries.
    IF sy-subrc IS INITIAL.
      TRANSLATE ls_json_entries-value TO UPPER CASE.
      ev_aadhar_type = ls_json_entries-value.
    ENDIF.
  ENDMETHOD.


  METHOD validate_pan.
    TYPES:
      BEGIN OF gty_json_entry,
        type    TYPE i,
        subtype TYPE i,
        parent  TYPE string,
        name    TYPE string,
        value   TYPE string,
      END OF gty_json_entry .
    TYPES:
      tt_json_entry_map TYPE STANDARD TABLE OF gty_json_entry .
    DATA: lo_cl_json_parser TYPE REF TO /ui5/cl_json_parser.
    DATA: lt_json_entries TYPE tt_json_entry_map,
          ls_json_entries LIKE LINE OF lt_json_entries.
    DATA: lo_http_client TYPE REF TO if_http_client.
    DATA: response TYPE string.
    DATA: status         TYPE  string,
          reason         TYPE  string,
          content_length TYPE  string,
          location       TYPE  string,
          content_type   TYPE  string.
    DATA: lv_body        TYPE        string.
    DATA lr_json_serializer   TYPE REF TO cl_trex_json_serializer.
    "create HTTP client by url
    "API endpoint for API sandbox
    CALL METHOD cl_http_client=>create_by_url
      EXPORTING
        url                = 'https://test.zoop.one/api/v1/in/identity/pan/lite'
      IMPORTING
        client             = lo_http_client
      EXCEPTIONS
        argument_not_found = 1
        plugin_not_active  = 2
        internal_error     = 3
        OTHERS             = 4.

    IF sy-subrc NE 0.
      ev_request_status = 'Fail'.
      EV_REASON_MESSAGE = 'HTTP Client creation by URL failed-internal_error'.
      RETURN.
    ENDIF.

    "setting request method
    lo_http_client->request->set_method('POST').

    "adding headers
    lo_http_client->request->set_header_field( name = 'api-key' value = '2RM8J6Q-DFG4S0J-KV0T2NH-9RVDT5M' ).
    lo_http_client->request->set_header_field( name = 'app-id' value = '632ac2d336b2a0001d474116' ).
    lo_http_client->request->set_header_field( name = 'DataServiceVersion' value = '2.0' ).
    lo_http_client->request->set_header_field( name = 'Accept' value = 'application/json' ).
    lo_http_client->request->set_header_field( name = 'Content-Type' value = 'application/json' ).

    DATA(lv_pannno) = iv_pan_number.
    CONDENSE lv_pannno.

    CONCATENATE '{"data": {"customer_pan_number": "' lv_pannno '", "consent": "Y", "consent_text": "I hear by declare my consent agreement for fetching my information via ZOOP API."}}' INTO lv_body.
    CALL METHOD lo_http_client->request->set_cdata
      EXPORTING
        data = lv_body.

    CALL METHOD lo_http_client->send
      EXCEPTIONS
        http_communication_failure = 1
        http_invalid_state         = 2
        http_processing_failed     = 3
        http_invalid_timeout       = 4
        OTHERS                     = 5.

    IF sy-subrc NE 0.
      ev_request_status = 'Fail'.
      EV_REASON_MESSAGE = 'Http_communication_failure : lo_http_client->receive'.
      RETURN.
    ENDIF.
    CALL METHOD lo_http_client->receive
      EXCEPTIONS
        http_communication_failure = 1
        http_invalid_state         = 2
        http_processing_failed     = 3
        OTHERS                     = 5.

    IF sy-subrc NE 0.
      ev_request_status = 'Fail'.
      EV_REASON_MESSAGE = 'Http_communication_failure : lo_http_client->receive'.
      RETURN.
    ENDIF.

    response = lo_http_client->response->get_cdata( ).

    CREATE OBJECT lo_cl_json_parser.
    lo_cl_json_parser->parse( json = response ).
    lt_json_entries = lo_cl_json_parser->m_entries.
*  response
    READ TABLE lt_json_entries WITH KEY name = 'success' INTO ls_json_entries.
    IF sy-subrc IS INITIAL.
      TRANSLATE ls_json_entries-value TO UPPER CASE.
      ev_request_status = ls_json_entries-value.
    ENDIF.
    READ TABLE lt_json_entries WITH KEY name = 'reason_message' INTO ls_json_entries.
    IF sy-subrc IS INITIAL.
      ev_reason_message = ls_json_entries-value.
    ENDIF.
    READ TABLE lt_json_entries WITH KEY name = 'pan_status' INTO ls_json_entries.
    IF sy-subrc IS INITIAL.
      TRANSLATE ls_json_entries-value TO UPPER CASE.
      ev_pan_status = ls_json_entries-value.
    ENDIF.
    READ TABLE lt_json_entries WITH KEY name = 'user_full_name' INTO ls_json_entries.
    IF sy-subrc IS INITIAL.
      TRANSLATE ls_json_entries-value TO UPPER CASE.
      ev_pan_holder_name = ls_json_entries-value.
    ENDIF.
    READ TABLE lt_json_entries WITH KEY name = 'pan_type' INTO ls_json_entries.
    IF sy-subrc IS INITIAL.
      TRANSLATE ls_json_entries-value TO UPPER CASE.
      ev_pan_type = ls_json_entries-value.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
