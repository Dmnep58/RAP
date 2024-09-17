" Defaulter data --> interface --> CDS View Entity --> Child Entity

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'defaulter entity view'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zi_defaulterdata as select from zdefaulters
association to parent zi_bookData as _book on $projection.Bookids = _book.Bookid
association [1..*] to zi_studentData as _student on $projection.Studentids = _student.Student
{
    key defaulterid as Defaulterid,
    key bookids as Bookids,
    key studentids as Studentids,
    @Semantics.amount.currencyCode: 'Currencycode'
    penalty as Penalty,
    currencycode as Currencycode,
    " association
    _student,
    _book
}
