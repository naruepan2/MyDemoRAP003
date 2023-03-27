@EndUserText.label: 'ZA_DMO_ABSTACT_ROOT_000'
@Metadata.allowExtensions: true
define root abstract entity ZA_DMO_ABSTACT_ROOT_000
  //  with parameters parameter_name : parameter_type
{
  key parentId  : abap.char(4);
      field01   : abap.char( 10 );

//      _toStruct : composition [0..1] of ZA_DMO_ABSTACT_STRUCT_000;
      _toTable  : composition [0..*] of ZA_DMO_ABSTACT_ITMTBL_000;

}
