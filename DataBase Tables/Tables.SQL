-- Book Table 
@EndUserText.label : 'books data table'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zbooks {

    key bookid : zbookids not null;
    bookname   : abap.char(40);
    bookauthor : abap.char(40);
    quantity   : abap.int4;
    status     : zstatus_dp;

}




-- Defaulter Table
@EndUserText.label : 'defaulters data table'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zdefaulters {

    key defaulterid : zdefaulterids not null;
    @AbapCatalog.foreignKey.screenCheck : false
    key bookids     : zbookids not null
    with foreign key zbooks
        where bookid = zdefaulters.bookids;
    @AbapCatalog.foreignKey.screenCheck : false
    key studentids  : zstudentids not null
    with foreign key zstud
        where student = zdefaulters.studentids;
    @Semantics.amount.currencyCode : 'zdefaulters.currencycode'
    penalty         : abap.curr(12,2);
    currencycode    : /dmo/currency_code;

}



-- Book Allotment
@EndUserText.label : 'bookallotment table'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zbookallotment {

key bookallotmentids : zbookallotids not null;
@AbapCatalog.foreignKey.screenCheck : false
key bookids          : zbookids not null
with foreign key zbooks
    where bookid = zbookallotment.bookids;
@AbapCatalog.foreignKey.screenCheck : false
key studentids       : zstudentids not null
    with foreign key zstud
    where student = zbookallotment.studentids;
allotment_date       : abap.dats;
submission_date      : abap.dats;
}


-- Department Table
@EndUserText.label : 'department table'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zdepartment {
    key department_id   : zdepartmentids not null;
    department_name     : abap.char(40);
    school_name         : abap.char(40);
    department_capacity : abap.int4;
}


-- Student Table
@EndUserText.label : 'Students Table'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zstud {

    key student       : zstudentids not null;
    @AbapCatalog.foreignKey.screenCheck : false
    key department_id : zdepartmentids not null
    with foreign key zdepartment
        where department_id = zstud.department_id;
    student_name      : abap.char(30);
    country_from      : land1;
    batch_year        : abap.dats;
}
