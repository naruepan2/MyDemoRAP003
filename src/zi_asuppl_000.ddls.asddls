@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View Entity for ZI_ASUPPL_000'
define view entity ZI_ASUPPL_000
  as select from zrap_asuppl_000
  association to parent ZI_ABOOK_000 as _Booking on  $projection.TravelUuid  = _Booking.TravelUuid
                                                 and $projection.BookingUuid = _Booking.BookingUuid
  association to ZI_ATRAV_000        as _Travel  on  $projection.TravelUuid = _Travel.TravelUUID

{
  key supple_uuid           as SuppleUuid,
  key travel_uuid           as TravelUuid,
  key booking_uuid          as BookingUuid,
      supple_id             as Suppleid,
      price                 as Price,
      currency_code         as CurrencyCode,
      @Semantics.user.createdBy: true
      created_by            as CreatedBy,
      created_at            as CreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      last_changed_by       as LastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      last_changed_at       as LastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,

      _Travel,
      _Booking

}
