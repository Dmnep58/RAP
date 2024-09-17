" Department data --> interface --> CDS View Entity

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'department entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zi_departmentData as select from zdepartment
{
    key department_id as DepartmentId,
    department_name as DepartmentName,
    school_name as SchoolName,
    department_capacity as DepartmentCapacity
}
