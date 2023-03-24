@EndUserText.label: 'Projection View Entity for ZC_ABOOK_000'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
//@ObjectModel.semanticKey: ['BookingUuid', 'TravelUuid']
@ObjectModel.semanticKey: ['BookingUuid']
define view entity ZC_ABOOK_000
  as projection on ZI_ABOOK_000
{
  key BookingUuid,
  key TravelUuid,
      BookingId,
      BookingDate,
      CarrierId,
      ConnectionId,
      FlightDate,
      FlightPrice,
      CurrencyCode,
      CreatedBy,
      CreatedAt,
      LastChangedAt,
      /* Associations */
      _Travel     : redirected to parent ZC_ATRAV_000,
      _Supplement : redirected to composition child ZC_ASUPPL_000
}
