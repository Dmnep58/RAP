" Book data --> interface --> CDS View Entity --> root Entity

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'book root entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity zi_bookData as select from zbooks
composition[1..*] of zi_bookallotment as _bookallot
composition[1..*] of zi_defaulterdata as _defaulters
{
    key bookid as Bookid,
    bookname as Bookname,
    bookauthor as Bookauthor,
    quantity as Quantity,
    status as Status,
    " parrent child relation
    _bookallot,
    _defaulters
}
