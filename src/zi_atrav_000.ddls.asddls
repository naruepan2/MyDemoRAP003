@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '##GENERATED ZRAP_ATRAV_000'
define root view entity ZI_ATRAV_000
  as select from zrap_atrav_000 as Travel
  composition [0..*] of ZI_ABOOK_000 as _Booking
{
  key travel_uuid           as TravelUUID,
      travel_id             as TravelID,
      begin_date            as BeginDate,
      end_date              as EndDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      booking_fee           as BookingFee,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      total_price           as TotalPrice,
      currency_code         as CurrencyCode,
      description           as Description,
      overall_status        as OverallStatus,
      @Semantics.largeObject: { mimeType: 'Mimetype',
                                fileName: 'Filename',
                                contentDispositionPreference: #INLINE }
      attachment            as Attachment,
      @Semantics.mimeType: true
      mimetype              as Mimetype,
      filename              as Filename,
      @Semantics.user.createdBy: true
      created_by            as CreatedBy,
      created_at            as CreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      last_changed_by       as LastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      last_changed_at       as LastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,

      _Booking

}
