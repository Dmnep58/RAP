" Book allotment data --> consumption ( Projection View ) --> CDS View Entity --> Child Entity

@EndUserText.label: 'projection bookalloted data'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity Zc_BOOKALLOTMENT as projection on zi_bookallotment
{
    key Bookallotmentids,
    key Bookids,
    key Studentids,
    AllotmentDate,
    SubmissionDate,
    " Associations 
    _bookdata : redirected to parent zc_bookdata
"   _student
}