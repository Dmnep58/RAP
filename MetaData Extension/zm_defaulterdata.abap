" meta data extension --> defaulter

@Metadata.layer: #CORE
@UI: {
headerInfo: {   typeName: 'Defaulter',
typeNamePlural: 'Defaulters Information',
            title: {
                        type:#STANDARD,
                        label: 'Defaulters Details',
                        value : 'Defaulterid'}
}
}
@Search.searchable: true
annotate view ZC_DEFAULTERDATA with
{
@UI.facet: [ { id : 'Defaulter',
                purpose : #STANDARD,
                type: #IDENTIFICATION_REFERENCE,
                label : 'Defaulters Details',
                position : 10 }]

    @UI : { lineItem: [{ position : 10 , label :'Defaulterid' }],
    identification: [{  position : 10 , label :'Defaulterid' }] }
    @Search.defaultSearchElement: true
    Defaulterid;

    @UI.hidden
    @UI : { lineItem: [{ position : 20 , label :'Bookids' }],
    identification: [{  position : 20 , label :'Bookids' }] }
    @Search.defaultSearchElement: true
    Bookids;
    @UI : { lineItem: [{ position : 30 , label :'Studentids' }],
    identification: [{  position : 30 , label :'Studentids' }] }
    @Search.defaultSearchElement: true
    Studentids;
    @UI : { lineItem: [{ position : 40 , label :'Penalty' }],
    identification: [{  position : 40 , label :'Penalty' }] }
    Penalty;
@UI.hidden
    Currencycode;

}