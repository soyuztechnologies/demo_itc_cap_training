using CatalogService as service from '../../srv/CatalogService';

annotate service.POs with @(

    UI: {
        SelectionFields  : [
            PO_ID,
            GROSS_AMOUNT,
            LIFECYCLE_STATUS,
            CURRENCY_code,
            PARTNER_GUID.COMPANY_NAME
        ],
        LineItem  : [
            {
                $Type : 'UI.DataField',
                Value : PO_ID,
            },
            {
                $Type : 'UI.DataField',
                Value : PARTNER_GUID.COMPANY_NAME,
            },
            {
                $Type : 'UI.DataField',
                Value : PARTNER_GUID.ADDRESS_GUID.COUNTRY,
            },
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT,
            },
            {
                $Type : 'UI.DataFieldForAction',
                Label: 'boost',
                Action : 'CatalogService.boost',
                Inline: true
            },
            {
                $Type : 'UI.DataField',
                Value : OverallStatus,
                Criticality: Spiderman
            },

        ],
        HeaderInfo  : {
            $Type : 'UI.HeaderInfoType',
            TypeName : 'Purchase Order',
            TypeNamePlural : 'Purchase Orders',
            Title : {
                $Type : 'UI.DataField',
                Value : PO_ID,
            },
            Description: {
                $Type : 'UI.DataField',
                Value : PARTNER_GUID.COMPANY_NAME,
            },
            ImageUrl : 'https://yt3.googleusercontent.com/zCgSuKDRBWCoEFP52F5WNm-8q6FYKiiIlgpdqjdQaZekQc-PDcyFhi-cO8bkvtvOvH6qPBSg=s900-c-k-c0x00ffffff-no-rj',
        },
        Facets  : [
            {
                $Type : 'UI.CollectionFacet',
                Label : 'More Details',
                Facets : [
                    {
                        $Type : 'UI.ReferenceFacet',
                        Label: 'More Info',
                        Target : '@UI.Identification',
                    },
                    {
                        $Type : 'UI.ReferenceFacet',
                        Label: 'Prices',
                        Target : '@UI.FieldGroup#Spiderman',
                    },
                    {
                        $Type : 'UI.ReferenceFacet',
                        Label: 'Status',
                        Target : '@UI.FieldGroup#Superman',
                    },
                ],
            },
            {
                $Type : 'UI.ReferenceFacet',
                Label : 'PO Items',
                Target : 'Items/@UI.LineItem',
            },
            
        ],
        Identification  : [
            {
                $Type : 'UI.DataField',
                Value : ID,
            },
            {
                $Type : 'UI.DataField',
                Value : PO_ID,
            },
            {
                $Type : 'UI.DataField',
                Value : PARTNER_GUID_NODE_KEY,
            },
        ],
        FieldGroup #Spiderman : {
            $Type : 'UI.FieldGroupType',
            Data : [
                {
                    $Type : 'UI.DataField',
                    Value : GROSS_AMOUNT,
                },
                {
                    $Type : 'UI.DataField',
                    Value : NET_AMOUNT,
                },
                {
                    $Type : 'UI.DataField',
                    Value : TAX_AMOUNT,
                },
            ],
        },
        FieldGroup #Superman : {
            $Type : 'UI.FieldGroupType',
            Data : [
                {
                    $Type : 'UI.DataField',
                    Value : CURRENCY_code,
                },
                {
                    $Type : 'UI.DataField',
                    Value : LIFECYCLE_STATUS,
                },
                {
                    $Type : 'UI.DataField',
                    Value : OVERALL_STATUS,
                },
            ],
        },
    },

    Common.DefaultValuesFunction: 'getOrderDefaults'

);

annotate service.PurchaseOrderItems with @(

    UI: {
        LineItem  : [
            {
                $Type : 'UI.DataField',
                Value : PO_ITEM_POS,
            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.Description,
            },
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : CURRENCY_code,
            },
            
        ],
        HeaderInfo  : {
            $Type : 'UI.HeaderInfoType',
            TypeName : 'PO Item',
            TypeNamePlural : 'PO Items',
            Title : {
                $Type : 'UI.DataField',
                Value : PO_ITEM_POS,
            },
            Description: {
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.Category,
            },
        },
        Facets  : [
            {
                $Type : 'UI.CollectionFacet',
                Label : 'Item Data',
                Facets : [
                    {
                        $Type : 'UI.ReferenceFacet',
                        Label : 'Item Info',
                        Target : '@UI.Identification',
                    },
                ],
            },
        ],
        Identification  : [
            {
                $Type : 'UI.DataField',
                Value : ID,
            },
            {
                $Type : 'UI.DataField',
                Value : PO_ITEM_POS,
            },{
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID_NODE_KEY,
            },{
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT,
            },{
                $Type : 'UI.DataField',
                Value : NET_AMOUNT,
            },{
                $Type : 'UI.DataField',
                Value : TAX_AMOUNT,
            },{
                $Type : 'UI.DataField',
                Value : CURRENCY_code,
            },
        ],
    }

);

annotate service.POs with {
    PARTNER_GUID @(
        Common: {
            Text: PARTNER_GUID.COMPANY_NAME
        },
        //Attach the value help with the field
        ValueList.entity: 'service.BusinessPartnerSet'
    )
};

//first you create F4 help in SE11
@cds.odata.valuelist
annotate service.BusinessPartnerSet with @(
    UI.Identification: [{
        $Type : 'UI.DataField',
        Label : 'Vendor',
        Value : COMPANY_NAME,
    }]

);


annotate service.PurchaseOrderItems with {
    PRODUCT_GUID @(
        Common: {
            Text: PRODUCT_GUID.Description
        },
        //Attach the value help with the field
        ValueList.entity: 'service.ProductView'
    )
};

//first you create F4 help in SE11
@cds.odata.valuelist
annotate service.ProductView with @(
    UI.Identification: [{
        $Type : 'UI.DataField',
        Label : 'Vendor',
        Value : Description,
    }]

);

