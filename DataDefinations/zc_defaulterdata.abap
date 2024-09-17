" Defaulter data --> consumption ( Projection View ) --> CDS View Entity --> Child Entity

@EndUserText.label: 'projection defaulter data'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZC_DEFAULTERDATA as projection on zi_defaulterdata
{
    key Defaulterid,
    key Bookids,
    key Studentids,
    Penalty,
    Currencycode,
    " Associations 
    _book : redirected to parent zc_bookdata,
    _student
}
