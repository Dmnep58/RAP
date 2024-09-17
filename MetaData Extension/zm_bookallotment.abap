" meta data extension --> book allotment

@Metadata.layer: #CORE
@UI: {
headerInfo: {   typeName: 'BookAllotment',
typeNamePlural: 'Book Allotment Information',
            title: {
                        type:#STANDARD,
                        label: 'BookAllotmentDetails',
                        value : 'Bookallotmentids'}
}
}
@Search.searchable: true
annotate view Zc_BOOKALLOTMENT
    with 
{
  @UI.facet: [ { id : 'BookAllotment',
                 purpose : #STANDARD,
                type: #IDENTIFICATION_REFERENCE,
                label : 'Book Allotment Information',
                position : 10 }]
                
  @UI : { lineItem: [{ position : 10 , label :'Book allotment ids' }],
  identification: [{  position : 10 , label :'Book allotment ids' }] }
  @Search.defaultSearchElement: true
   Bookallotmentids;
     @UI : { lineItem: [{ position : 20 , label :'Book ID' }],
  identification: [{  position : 20 , label :'Book ID' }] }
  @Search.defaultSearchElement: true
    @Consumption.valueHelpDefinition: [{ entity: { name : 'zi_bookdata', element : 'Bookid' } }]
   Bookids;
    @UI : { lineItem: [{ position : 30 , label :'Student ids' }],
  identification: [{  position : 30 , label :'Student ids' }] }
  @Search.defaultSearchElement: true
   Studentids;
    @UI : { lineItem: [{ position : 40 , label :'Allotment Date' }],
  identification: [{  position : 40 , label :'Allotment Date' }] }
   AllotmentDate;
    @UI : { lineItem: [{ position : 50 , label :'Submission Date' }],
  identification: [{  position : 50 , label :'Submission Date' }] }
   SubmissionDate;

}