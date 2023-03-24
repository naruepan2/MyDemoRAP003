@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for ZI_ATRAV_000'
@ObjectModel.semanticKey: ['TravelUUID']
define root view entity ZC_ATRAV_000
  provider contract transactional_query
  as projection on ZI_ATRAV_000
{
  key TravelUUID,
      TravelID,
      BeginDate,
      EndDate,
      BookingFee,
      TotalPrice,
      CurrencyCode,
      Description,
      OverallStatus,
      Attachment,
      Mimetype,
      Filename,
      CreatedBy,
      CreatedAt,
      LastChangedAt,
      
      _Booking : redirected to composition child ZC_ABOOK_000

}
