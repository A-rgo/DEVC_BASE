CLASS zss_consume_rest DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES:
      if_oo_adt_classrun.

    CLASS-DATA : cv_url TYPE string VALUE 'https://dev84748.service-now.com/api/now/table/incident'.
    CLASS-DATA : cv_usr TYPE string VALUE 'admin'.
    CLASS-DATA : cv_pwd TYPE string VALUE 'iVpW9jn6BF-!'.


    TYPES:
      BEGIN OF post_s,
        user_id TYPE i,
        id      TYPE i,
        title   TYPE string,
        body    TYPE string,
      END OF post_s,

      post_tt TYPE TABLE OF post_s WITH EMPTY KEY,

      BEGIN OF post_without_id_s,
        user_id TYPE i,
        title   TYPE string,
        body    TYPE string,
      END OF post_without_id_s,

      BEGIN OF url_param,
        key   TYPE string,
        value TYPE string,
      END OF url_param,

      url_param_tt TYPE TABLE OF url_param WITH EMPTY KEY.


    METHODS:
      create_client
        IMPORTING url           TYPE string
                  resource      TYPE string OPTIONAL
                  url_param     TYPE url_param_tt OPTIONAL
        RETURNING VALUE(result) TYPE REF TO if_http_client
        RAISING   cx_static_check,

      set_authorization
        IMPORTING io_client   TYPE REF TO if_http_client
                  iv_username TYPE string
                  iv_password TYPE string,
*
      set_header_field
        IMPORTING io_client TYPE REF TO if_http_client
                  iv_name   TYPE string
                  iv_value  TYPE string,

      set_cdata
        IMPORTING io_client TYPE REF TO if_http_client
                  iv_data   TYPE string,

      send_request
        IMPORTING  io_client TYPE REF TO if_http_client
        EXCEPTIONS
                   http_communication_failure
                   http_invalid_state
                   http_processing_failed
                   http_invalid_timeout,

      get_response
        IMPORTING  io_client TYPE REF TO if_http_client
        EXCEPTIONS
                   http_communication_failure
                   http_invalid_state
                   http_processing_failed,

      get_response_data
        IMPORTING io_client          TYPE REF TO if_http_client
        RETURNING VALUE(ev_response) TYPE string,

      set_data
        IMPORTING io_client TYPE REF TO if_http_client
                  iv_data   TYPE xstring,

      read_posts
        RETURNING VALUE(result) TYPE post_tt
        RAISING   cx_static_check,

      read_single_post
        IMPORTING id            TYPE i
        RETURNING VALUE(result) TYPE post_s
        RAISING   cx_static_check,

      create_post
        IMPORTING post_without_id TYPE post_without_id_s
        RETURNING VALUE(result)   TYPE string
        RAISING   cx_static_check,

      update_post
        IMPORTING post          TYPE post_s
        RETURNING VALUE(result) TYPE string
        RAISING   cx_static_check,

      delete_post
        IMPORTING id TYPE i
        RAISING   cx_static_check.


  PRIVATE SECTION.
    CONSTANTS:
      base_url     TYPE string VALUE 'https://jsonplaceholder.typicode.com/posts',
      content_type TYPE string VALUE 'Content-type',
      json_content TYPE string VALUE 'application/json; charset=UTF-8'.
ENDCLASS.



CLASS ZSS_CONSUME_REST IMPLEMENTATION.


  METHOD create_client.
    IF resource IS NOT INITIAL.
      DATA(lv_url) = url && resource.
      LOOP AT url_param INTO DATA(lw_param).
        IF sy-tabix = 1.
          lv_url = lv_url && '?'.
        ELSE.
          lv_url = lv_url && '&'.
        ENDIF.
        lv_url = lv_url && lw_param-key && '=' && lw_param-value.
      ENDLOOP.
    ELSE.
      lv_url = url.
    ENDIF.

*    cl_http_client=>create_by_url( EXPORTING url = url IMPORTING client =  result  ).
    cl_http_client=>create_by_url( EXPORTING url = lv_url IMPORTING client =  result  ).
  ENDMETHOD.


  METHOD create_post.
    " Convert input post to JSON
    DATA(json_post) = xco_cp_json=>data->from_abap( post_without_id )->apply(
      VALUE #( ( xco_cp_json=>transformation->underscore_to_camel_case ) ) )->to_string(  ).

    " Send JSON of post to server and return the response
    DATA(url) = |{ base_url }|.
    DATA(client) = create_client( url ).
*    DATA(req) = client->get_http_request(  ).
*    req->set_text( json_post ).
*    req->set_header_field( i_name = content_type i_value = json_content ).
*
*    result = client->execute( if_web_http_client=>post )->get_text(  ).
*    client->close(  ).
  ENDMETHOD.


  METHOD delete_post.
    DATA(url) = |{ base_url }/{ id }|.
    DATA(client) = create_client( url ).
*    DATA(response) = client->execute( if_web_http_client=>delete ).

*    IF response->get_status(  )-code NE 200.
*      RAISE EXCEPTION TYPE cx_web_http_client_error.
*    ENDIF.
  ENDMETHOD.


  METHOD get_response.
    io_client->receive( EXCEPTIONS
        http_communication_failure = 1
        http_invalid_state         = 2
        http_processing_failed     = 3
        OTHERS                     = 4 ).
    CASE sy-subrc.
      WHEN 1.
        RAISE http_communication_failure.
      WHEN 2.
        RAISE http_invalid_state.
      WHEN 3.
        RAISE http_processing_failed.
      WHEN OTHERS.
    ENDCASE.
  ENDMETHOD.


  METHOD get_response_data.
    ev_response = io_client->response->get_cdata( ).
  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.
    TRY.
        " Read
        DATA(all_posts) = read_posts(  ).
        DATA(first_post) = read_single_post( 1 ).

        " Create
        DATA(create_response) = create_post( VALUE #( user_id = 7
          title = 'Hello, World!' body = ':)' ) ).

        " Update
        first_post-user_id = 777.
        DATA(update_response) = update_post( first_post ).

        " Delete
        delete_post( 9 ).

        " Print results
        out->write( all_posts ).
        out->write( first_post ).
        out->write( create_response ).
        out->write( update_response ).

      CATCH cx_root INTO DATA(exc).
        out->write( exc->get_text(  ) ).
    ENDTRY.
  ENDMETHOD.


  METHOD read_posts.
    " Get JSON of all posts
    DATA(url) = |{ base_url }|.
    DATA(client) = create_client( url ).
*    DATA(response) = client->execute( if_web_http_client=>get )->get_text(  ).
*    client->close(  ).
*
*    " Convert JSON to post table
*    xco_cp_json=>data->from_string( response )->apply(
*      VALUE #( ( xco_cp_json=>transformation->camel_case_to_underscore ) )
*      )->write_to( REF #( result ) ).
  ENDMETHOD.


  METHOD read_single_post.
    " Get JSON for input post ID
    DATA(url) = |{ base_url }/{ id }|.
    DATA(client) = create_client( url ).
*    DATA(response) = client->execute( if_web_http_client=>get )->get_text(  ).
*    client->close(  ).
*
*    " Convert JSON to post structure
*    xco_cp_json=>data->from_string( response )->apply(
*      VALUE #( ( xco_cp_json=>transformation->camel_case_to_underscore ) )
*      )->write_to( REF #( result ) ).
  ENDMETHOD.


  METHOD send_request.
    io_client->send( EXCEPTIONS http_communication_failure = 1
                                http_invalid_state         = 2
                                http_processing_failed     = 3
                                OTHERS                     = 4 ).
    CASE sy-subrc.
      WHEN 1.
        RAISE http_communication_failure.
      WHEN 2.
        RAISE http_invalid_state.
      WHEN 3.
        RAISE http_processing_failed.
      WHEN OTHERS.
    ENDCASE.
  ENDMETHOD.


  METHOD set_authorization.
    """Set authorization data.
    io_client->request->set_authorization( username = iv_username password = iv_password ).
  ENDMETHOD.


  METHOD set_cdata.
    """Set JSON/XML/Character Data to request body.
    io_client->request->set_cdata( data = iv_data  ). " Character/Json/XML data

  ENDMETHOD.


  METHOD set_data.
    io_client->request->set_data(
      EXPORTING
        data               = iv_data                                         " Binary data
    ).
  ENDMETHOD.


  METHOD set_header_field.
    """Set header fields for request
    io_client->request->set_header_field(
        name  = iv_name                 " Name of the header field
        value = iv_value                 " HTTP header field value
    ).
  ENDMETHOD.


  METHOD update_post.
    " Convert input post to JSON
    DATA(json_post) = xco_cp_json=>data->from_abap( post )->apply(
      VALUE #( ( xco_cp_json=>transformation->underscore_to_camel_case ) ) )->to_string(  ).

    " Send JSON of post to server and return the response
    DATA(url) = |{ base_url }/{ post-id }|.
    DATA(client) = create_client( url ).
*    DATA(req) = client->get_http_request(  ).
*    req->set_text( json_post ).
*    req->set_header_field( i_name = content_type i_value = json_content ).
*
*    result = client->execute( if_web_http_client=>put )->get_text(  ).
*    client->close(  ).
  ENDMETHOD.
ENDCLASS.
