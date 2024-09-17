" Book data --> consumption ( Projection View ) --> CDS View Entity --> root Entity

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'consumption (projection) bookdata'
@Metadata.allowExtensions: true

define root view entity zc_bookdata 
provider contract transactional_query
as projection on zi_bookData
{
    key Bookid,
    Bookname,
    Bookauthor,
    Quantity,
    Status,
    " Associations 
    _bookallot : redirected to composition child Zc_BOOKALLOTMENT,
    _defaulters : redirected to composition child ZC_DEFAULTERDATA
}
