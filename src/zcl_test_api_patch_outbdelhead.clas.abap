CLASS zcl_test_api_patch_outbdelhead DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA lmv_token TYPE string.
    DATA lmv_if_match TYPE string.
    DATA lmv_basic_auth TYPE string VALUE 'Basic WlpfQ1VfU0FQX0NPTV8wMTA2OlBAc3N3b3JkMTIzNDU2Nzg5MDEyMzQ1Njc4OTA='.
    DATA lmv_sample_url TYPE string VALUE 'https://my402410.s4hana.cloud.sap:443/sap/opu/odata/sap/API_OUTBOUND_DELIVERY_SRV;v=0002/A_OutbDeliveryHeader(''80000157'')'.
    DATA lmv_username TYPE string VALUE 'ZZ_CU_SAP_COM_0106'.
    DATA lmv_password TYPE string VALUE 'P@ssword12345678901234567890'.

    METHODS getToken
      IMPORTING out TYPE REF TO if_oo_adt_classrun_out.

    METHODS update_sample_delivery_header
      IMPORTING out TYPE REF TO if_oo_adt_classrun_out.

    METHODS find_etag
      IMPORTING iO_WEB_HTTP_CLIENT TYPE REF TO if_web_http_client
      RETURNING VALUE(rv_etag)     TYPE string
      RAISING
                cx_web_http_client_error.

ENDCLASS.



CLASS zcl_test_api_patch_outbdelhead IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*    gettoken( out ).
    update_sample_delivery_header( out ).

  ENDMETHOD.

  METHOD update_sample_delivery_header.

    TRY.
        "create http destination by url; API endpoint for API sandbox
        DATA(lo_http_destination) =
             cl_http_destination_provider=>create_by_url( lmv_sample_url ).
        "alternatively create HTTP destination via destination service
        "cl_http_destination_provider=>create_by_cloud_destination( i_name = '<...>'
        "                            i_service_instance_name = '<...>' )
        "SAP Help: https://help.sap.com/viewer/65de2977205c403bbc107264b8eccf4b/Cloud/en-US/f871712b816943b0ab5e04b60799e518.html

        "create HTTP client by destination
        DATA(lo_web_http_client) = cl_web_http_client_manager=>create_by_http_destination( lo_http_destination ) .

        "adding headers
        DATA(lo_web_http_request) = lo_web_http_client->get_http_request( ).

        lo_web_http_request->set_authorization_basic(
                  EXPORTING
                    i_username = me->lmv_username
                    i_password = me->lmv_password ).


        lo_web_http_request->set_header_fields( VALUE #(
*        (  name = 'config_authType' value = 'Basic' )
*        (  name = 'config_packageName' value = 'SAPS4HANACloud' )
*        (  name = 'config_actualUrl' value = 'https://my402410.s4hana.cloud.sap:443/sap/opu/odata/sap/API_OUTBOUND_DELIVERY_SRV;v=0002' )
*        (  name = 'config_urlPattern' value = 'https://{host}:{port}/sap/opu/odata/sap/API_OUTBOUND_DELIVERY_SRV;v=0002' )
*        (  name = 'config_apiName' value = 'API_OUTBOUND_DELIVERY_SRV_0002' )
*        (  name = 'Authorization' value = me->lmv_basic_auth )
*        (  name = cl_http_service_utility=>csrf_header value = me->lmv_token )
        (  name = 'If-Match' value = find_etag( lo_web_http_client ) )
        (  name = 'DataServiceVersion' value = '2.0' )
        (  name = 'Accept' value = '*/*' )
*        (  name = 'Content-Type' value = 'application/json' )
         ) ).

        TRY.
            lo_web_http_client->set_csrf_token( ).
          CATCH cx_web_http_client_error.
        ENDTRY.

*        DATA(lo_web_http_etag) = lo_web_http_client->execute( if_web_http_client=>head ).


        lo_web_http_request->set_content_type( content_type = 'application/json' ).

        DATA(lv_set_text) = `{"d":{"HeaderGrossWeight":"210.000","HeaderNetWeight":"210.000"}}`.

        lo_web_http_request->set_text( lv_set_text ).

        "set request method and execute request
        DATA(lo_web_http_response) = lo_web_http_client->execute( if_web_http_client=>patch ).

        DATA(lv_response) = lo_web_http_response->get_text( ).

      CATCH cx_http_dest_provider_error cx_web_http_client_error cx_web_message_error.
        "error handling
    ENDTRY.

    "uncomment the following line for console output; prerequisite: code snippet is implementation of if_oo_adt_classrun~main
    out->write( |response:  { lv_response }| ).

  ENDMETHOD.

  METHOD gettoken.
*    DATA lo_test TYPE REF TO CL_HTTP_UTILITY.

    TRY.
        "create http destination by url; API endpoint for API sandbox
        DATA(lo_http_destination) =
             cl_http_destination_provider=>create_by_url( lmv_sample_url ).
        "alternatively create HTTP destination via destination service
        "cl_http_destination_provider=>create_by_cloud_destination( i_name = '<...>'
        "                            i_service_instance_name = '<...>' )
        "SAP Help: https://help.sap.com/viewer/65de2977205c403bbc107264b8eccf4b/Cloud/en-US/f871712b816943b0ab5e04b60799e518.html

        "create HTTP client by destination
        DATA(lo_web_http_client) = cl_web_http_client_manager=>create_by_http_destination( lo_http_destination ) .

        "adding headers
        DATA(lo_web_http_request) = lo_web_http_client->get_http_request( ).

        lo_web_http_request->set_authorization_basic(
                  EXPORTING
                    i_username = me->lmv_username
                    i_password = me->lmv_password ).

        lo_web_http_request->set_header_fields( VALUE #(
*        (  name = 'Authorization' value = me->lmv_basic_auth )
*        (  name = 'config_authType' value = 'Basic' )
*        (  name = 'config_packageName' value = 'SAPS4HANACloud' )
*        (  name = 'config_actualUrl' value = 'https://my402410.s4hana.cloud.sap:443/sap/opu/odata/sap/API_OUTBOUND_DELIVERY_SRV;v=0002' )
*        (  name = 'config_urlPattern' value = 'https://{host}:{port}/sap/opu/odata/sap/API_OUTBOUND_DELIVERY_SRV;v=0002' )
*        (  name = 'config_apiName' value = 'API_OUTBOUND_DELIVERY_SRV_0002' )
        (  name = cl_http_service_utility=>csrf_header value = cl_http_service_utility=>csrf_header_value_fetch )
        (  name = 'Accept' value = 'application/json' )
        (  name = 'DataServiceVersion' value = '2.0' )
         ) ).

        "set request method and execute request
        DATA(lo_web_http_response) = lo_web_http_client->execute( if_web_http_client=>get ).
        DATA(lv_response) = lo_web_http_response->get_text( ).

        DATA(lt_res_header) = lo_web_http_response->get_header_fields(  ).

        TRY.
            lmv_token = lt_res_header[ name = 'x-csrf-token' ]-value.
            lmv_if_match = lt_res_header[ name = 'etag' ]-value.
          CATCH cx_sy_itab_line_not_found.
        ENDTRY.

      CATCH cx_http_dest_provider_error cx_web_http_client_error cx_web_message_error.
        "error handling
    ENDTRY.

    "uncomment the following line for console output; prerequisite: code snippet is implementation of if_oo_adt_classrun~main
    out->write( |response:  { lv_response }| ).
    out->write( |x-csrf-token:  { me->lmv_token }| ).
    out->write( |etag:  { me->lmv_if_match }| ).
  ENDMETHOD.

  METHOD find_etag.
    DATA(lo_web_http_request) = iO_WEB_HTTP_CLIENT->get_http_request( ).

    lo_web_http_request->set_header_field(
      EXPORTING
        i_name  = cl_http_service_utility=>csrf_header
        i_value = cl_http_service_utility=>csrf_header_value_fetch
    ).

    DATA(lo_web_http_response) = iO_WEB_HTTP_CLIENT->execute( if_web_http_client=>get ).
    rv_etag = lo_web_http_response->get_header_field( 'etag' ).

  ENDMETHOD.

ENDCLASS.
