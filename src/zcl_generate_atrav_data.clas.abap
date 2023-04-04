CLASS zcl_generate_atrav_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_GENERATE_ATRAV_DATA IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA lt_atrav TYPE TABLE OF zrap_atrav_000.
    DATA lt_abook TYPE TABLE OF zrap_abook_000.
    DATA lt_asupl TYPE TABLE OF zrap_asuppl_000.
    DATA lv_tmp TYPE c LENGTH 2.
    DATA index TYPE sy-index.

    " delete existing entries in the database table
    DELETE FROM zrap_atrav_000.
    DELETE FROM zrap_abook_000.
    DELETE FROM zrap_asuppl_000.

    out->write( 'Travel and booking demo data deleted.').

    DO 5 TIMES.
      DATA(lv_trav_x16) = cl_system_uuid=>create_uuid_x16_static( ).
*      DATA(lv_book_x16) = cl_system_uuid=>create_uuid_x16_static( ).
*      DATA(lv_supl_x16) = cl_system_uuid=>create_uuid_x16_static( ).
      DATA(r) = cl_abap_random_int=>create( seed = CONV i( sy-uzeit )
                                            min  = 100
                                            max  = 99999 ).
      lv_tmp = SWITCH #( sy-index WHEN 1 THEN 'AA'
      WHEN 2 THEN 'BB'
      WHEN 3 THEN 'CC'
      WHEN 4 THEN 'DD'
      WHEN 5 THEN 'EE'
       ).

      INSERT zrap_atrav_000 FROM @( VALUE #(
                             travel_uuid = lv_trav_x16
                             travel_id   = sy-index
                             begin_date  = cl_abap_context_info=>get_system_date( )
                             end_date    = cl_abap_context_info=>get_system_date( ) + 200
                             booking_fee = r->get_next( )
                             total_price = r->get_next( )
                             currency_code = 'THB'
                             description = |Travel { sy-index }|
                             overall_status = 'O'
                             created_by = sy-uname
                             created_at = cl_abap_context_info=>get_system_date( )
       ) ).

      DO 2 TIMES.
        DATA(lv_book_x16) = cl_system_uuid=>create_uuid_x16_static( ).

        INSERT zrap_abook_000 FROM @( VALUE #(
                               booking_uuid = lv_book_x16
                               travel_uuid = lv_trav_x16
                               booking_id  = sy-index
                               booking_date  = cl_abap_context_info=>get_system_date( )
                               carrier_id = |{ lv_tmp }{ sy-index }|
                               connection_id = sy-index
                               flight_date = cl_abap_context_info=>get_system_date( ) + 1
                               flight_price = r->get_next( )
                               currency_code = 'THB'
                               created_by = sy-uname
         ) ).

        DO 3 TIMES.
          DATA(lv_supl_x16) = cl_system_uuid=>create_uuid_x16_static( ).

          INSERT zrap_asuppl_000 FROM @( VALUE #(
                          supple_uuid = lv_supl_x16
                          booking_uuid = lv_book_x16
                          travel_uuid = lv_trav_x16
                          supple_id = sy-index
                          price = r->get_next( )
                          currency_code = 'THB'
                          created_by = sy-uname )
                   ).
        ENDDO.

      ENDDO.

*      lt_atrav = VALUE #( (  travel_uuid = lv_trav_x16
*                             travel_id   = sy-index
*                             begin_date  = cl_abap_context_info=>get_system_date( )
*                             end_date    = cl_abap_context_info=>get_system_date( ) + 200
*                             booking_fee = r->get_next( )
*                             total_price = r->get_next( )
*                             currency_code = 'THB'
*                             description = |Travel { sy-index }|
*                             overall_status = 'O'
*                             created_by = sy-uname
*                             created_at = cl_abap_context_info=>get_system_date( ) )
*                         ).

*      lt_abook = VALUE #( (      booking_uuid = lv_book_x16
*                                 travel_uuid = lv_trav_x16
*                                 booking_uuno = '1'
*                                 booking_id  = '1'
*                                 booking_date  = cl_abap_context_info=>get_system_date( )
*                                 carrier_id = |{ lv_tmp }1|
*                                 connection_id = '10'
*                                 flight_date = cl_abap_context_info=>get_system_date( ) + 1
*                                 flight_price = r->get_next( )
*                                 currency_code = 'THB'
*                                 created_by = sy-uname )
*                           (     booking_uuid = lv_book_x16
*                                 travel_uuid = lv_trav_x16
*                                 booking_uuno = '2'
*                                 booking_id  = '2'
*                                 booking_date  = cl_abap_context_info=>get_system_date( )
*                                 carrier_id  = |{ lv_tmp }2|
*                                 connection_id = '20'
*                                 flight_date = cl_abap_context_info=>get_system_date( ) + 1
*                                 flight_price = r->get_next( )
*                                 currency_code = 'THB'
*                                 created_by = sy-uname )
*                           ).
*      lt_asupl = VALUE #( (      supple_uuid = lv_supl_x16
*                                 booking_uuid = lv_book_x16
*                                 travel_uuid = lv_trav_x16
*                                 supple_uuno = '1'
*                                 price = r->get_next( )
*                                 currency_code = 'THB'
*                                 created_by = sy-uname )
*                            (    supple_uuid = lv_supl_x16
*                                 booking_uuid = lv_book_x16
*                                 travel_uuid = lv_trav_x16
*                                 supple_uuno = '2'
*                                 price = r->get_next( )
*                                 currency_code = 'THB'
*                                 created_by = sy-uname )
*                            (    supple_uuid = lv_supl_x16
*                                 booking_uuid = lv_book_x16
*                                 travel_uuid = lv_trav_x16
*                                 supple_uuno = '3'
*                                 price = r->get_next( )
*                                 currency_code = 'THB'
*                                 created_by = sy-uname )
*                        ).

*      INSERT zrap_atrav_000 FROM TABLE @lt_atrav ACCEPTING DUPLICATE KEYS.
*      INSERT zrap_abook_000 FROM TABLE @lt_abook ACCEPTING DUPLICATE KEYS.
*      INSERT zrap_asuppl_000 FROM TABLE @lt_asupl ACCEPTING DUPLICATE KEYS.

*      INSERT zrap_atrav_000 FROM TABLE @( VALUE #(
*      (   travel_uuid = lv_trav_x16
*          travel_id   = sy-index
*          begin_date  = cl_abap_context_info=>get_system_date( )
*          end_date    = cl_abap_context_info=>get_system_date( ) + 200
*          booking_fee = r->get_next( )
*          total_price = r->get_next( )
*          currency_code = 'THB'
*          description = |Travel { sy-index }|
*          overall_status = 'O'
*          created_by = sy-uname
*          created_at = cl_abap_context_info=>get_system_date( )
*      ) ) ).
*
*      INSERT zrap_abook_000 FROM TABLE @(
*        VALUE #( (    booking_uuid = lv_book_x16
*                      travel_uuid = lv_trav_x16
*                      booking_id  = 1
*                      booking_date  = cl_abap_context_info=>get_system_date( )
*                      carrier_id = |{ lv_tmp }1|
*                      connection_id = 10
*                      flight_date = cl_abap_context_info=>get_system_date( ) + 1
*                      flight_price = r->get_next( )
*                      currency_code = 'THB'
*                      created_by = sy-uname )
*                 ( booking_uuid = lv_book_x16
*                  travel_uuid = lv_trav_x16
*                  booking_id  = 2
*                  booking_date  = cl_abap_context_info=>get_system_date( )
*                  carrier_id  = |{ lv_tmp }2|
*                  connection_id = 20
*                  flight_date = cl_abap_context_info=>get_system_date( ) + 1
*                  flight_price = r->get_next( )
*                  currency_code = 'THB'
*                  created_by = sy-uname )
*       ) ).
*
*      INSERT zrap_asuppl_000 FROM TABLE @(
*        VALUE #( (    supple_uuid = lv_supl_x16
*                      booking_uuid = lv_book_x16
*                      travel_uuid = lv_trav_x16
*                      price = r->get_next( )
*                      currency_code = 'THB'
*                      created_by = sy-uname )
*                 (    supple_uuid = lv_supl_x16
*                      booking_uuid = lv_book_x16
*                      travel_uuid = lv_trav_x16
*                      price = r->get_next( )
*                      currency_code = 'THB'
*                      created_by = sy-uname )
*                 (    supple_uuid = lv_supl_x16
*                      booking_uuid = lv_book_x16
*                      travel_uuid = lv_trav_x16
*                      price = r->get_next( )
*                      currency_code = 'THB'
*                      created_by = sy-uname )
*       ) ).
    ENDDO.

    COMMIT WORK.

    out->write( 'Travel and booking demo data inserted.').
  ENDMETHOD.
ENDCLASS.
