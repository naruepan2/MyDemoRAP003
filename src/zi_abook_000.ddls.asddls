@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View Entity for ZI_ABOOK_000'
define view entity ZI_ABOOK_000
  as select from ZRAP_ABOOK_000
  association to parent ZI_ATRAV_000  as _Travel on $projection.TravelUuid = _Travel.TravelUUID
  composition [0..*] of ZI_ASUPPL_000 as _Supplement
{
  key booking_uuid          as BookingUuid,
  key travel_uuid           as TravelUuid,
      booking_id            as BookingId,
      booking_date          as BookingDate,
      carrier_id            as CarrierId,
      connection_id         as ConnectionId,
      flight_date           as FlightDate,
      flight_price          as FlightPrice,
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
      _Supplement
}
