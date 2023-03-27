@EndUserText.label: 'ZA_DMO_ABSTACT_ROOT_000'
@Metadata.allowExtensions: true
define abstract entity ZA_DMO_ABSTACT_ITMTBL_000
  //  with parameters parameter_name : parameter_type
{
  key childId    : abap.char(4);
  key parentId   : abap.char(4);
      field01    : abap.char( 10 );

      _to_parent : association to parent ZA_DMO_ABSTACT_ROOT_000 on _to_parent.parentId = $projection.parentId;
}
