" Book Allotment data --> interface --> CDS View Entity --> Child Entity

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'book allotment entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zi_bookallotment
    as select from zbookallotment
    association        to parent zi_bookData as _bookdata on $projection.Bookids = _bookdata.Bookid
"  association [1..*] to zi_studentData     as _student  on $projection.Studentids = _student.Student
{
    key bookallotmentids as Bookallotmentids,
    key bookids          as Bookids,
    key studentids       as Studentids,
        allotment_date   as AllotmentDate,
        submission_date  as SubmissionDate,
        "association
"     _student,
        " parrent child relation
        _bookdata

}
