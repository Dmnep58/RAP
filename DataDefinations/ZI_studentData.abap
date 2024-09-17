" Cds view --> interface --> CDS View Entity

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'student  entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zi_studentData
as select from zstud
association [1..1] to zi_departmentData       as _department on $projection.DepartmentId = _department.DepartmentId
{
key student       as Student,
key department_id as DepartmentId,
    student_name  as StudentName,
    country_from  as CountryFrom,
    batch_year    as BatchYear,
    " association
    _department
}
