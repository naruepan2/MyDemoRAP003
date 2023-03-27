CLASS lhc_Travel DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Travel RESULT result.
    METHODS TestParamAction1 FOR MODIFY
      IMPORTING keys FOR ACTION Travel~TestParamAction1 RESULT result.



ENDCLASS.

CLASS lhc_Travel IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD TestParamAction1.

    READ ENTITIES OF zi_atrav_000 IN LOCAL MODE
        ENTITY Travel
        ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(travel)
        FAILED failed
        REPORTED reported.

    LOOP AT travel ASSIGNING FIELD-SYMBOL(<travel>).

    ENDLOOP.

    result = VALUE #( FOR <travel_out> IN travel
                      ( %tky = <travel_out>-%tky
                        %param = CORRESPONDING #( <travel_out> ) ) ).

  ENDMETHOD.

ENDCLASS.
