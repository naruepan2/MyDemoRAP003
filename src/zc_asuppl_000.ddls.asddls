@EndUserText.label: 'Projection View Entity for ZC_ASUPPL_000'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
//@ObjectModel.semanticKey: ['SuppleUuid','TravelUuid', 'BookingUuid']
@ObjectModel.semanticKey: ['SuppleUuid']
define view entity ZC_ASUPPL_000
  as projection on ZI_ASUPPL_000
{
  key SuppleUuid,
  key TravelUuid,
  key BookingUuid,
      Suppleid,
      Price,
      CurrencyCode,
      CreatedBy,
      CreatedAt,
      LastChangedAt,
      /* Associations */
      _Booking : redirected to parent ZC_ABOOK_000,
      _Travel  : redirected to ZC_ATRAV_000
}
