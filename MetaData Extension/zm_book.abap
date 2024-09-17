" meta data extension --> book 

@Metadata.layer: #CORE
@UI: {
headerInfo: {   typeName: 'Book',
typeNamePlural: 'Travel Information',
            title: {
                        type:#STANDARD,
                        label: 'Book Details',
                        value : 'Bookname'}
}
}
@Search.searchable: true
annotate view zc_bookdata
    with 
{
@UI.facet: [ { id : 'Book',
                purpose : #STANDARD,
                type: #IDENTIFICATION_REFERENCE,
                label : 'Book Information',
                position : 10 },
                { id : 'Booking',
                type: #LINEITEM_REFERENCE,
                label : 'Alloted Information',
                targetElement: '_bookallot',
                position : 20 },
                { id : 'Defaulter',
                type: #LINEITEM_REFERENCE,
                label : 'Defaulters Information',
                targetElement: '_defaulters',
                position : 30 }]
@UI : { lineItem: [{ position : 10 , label :'Book ID' }],
identification: [{  position : 10 , label :'Book ID' }] }
@Search.defaultSearchElement: true
@Consumption.valueHelpDefinition: [{ entity: { name : 'zi_bookdata', element : 'Bookid' } }]
    Bookid;
    @UI : { lineItem: [{ position : 20 , label :'Book Name' }],
identification: [{  position : 20 , label :'Book Name' }] }
@Search.defaultSearchElement: true
    @Consumption.valueHelpDefinition: [{ entity: { name : 'zi_bookdata', element : 'Bookname' } }]
    Bookname;
    @UI : { lineItem: [{ position : 30 , label :'Book Author' }],
identification: [{  position : 30 , label :'Book Author' }] }
@Search.defaultSearchElement: true
    @Consumption.valueHelpDefinition: [{ entity: { name : 'zi_bookdata', element : 'Bookauthor' } }]
    Bookauthor;
    @UI : { lineItem: [{ position : 40 , label :'Quantity' }],
    identification: [{  position : 40 , label :'Quantity' }] }
    Quantity;
    @UI : { lineItem: [{ position : 50 , label :'Status' }],
    identification: [{  position : 50 , label :'Status' }] }
    @Consumption.valueHelpDefinition: [{ entity: { name : 'zi_bookdata', element : 'status' } }]
    Status;
    
}