using { anubhav.db } from '../db/datamodel';
using { cappo.cds } from '../db/CDSViews';

service CatalogService @(path:'CatalogService') {

    entity BusinessPartnerSet as projection on db.master.businesspartner;
    entity AddressSet as projection on db.master.address;
    entity EmployeeSet as projection on db.master.employees;
    entity POs @(
        odata.draft.enabled: true
    ) as projection on db.transaction.purchaseorder{
        *,
        case OVERALL_STATUS
            WHEN 'A' then 'Approved'
            WHEN 'X' then 'Rejected'
            WHEN 'D' then 'Delivered'
            WHEN 'P' then 'Pending'
            end as OverallStatus: String(10),
        case OVERALL_STATUS
            WHEN 'A' then 3
            WHEN 'X' then 1
            WHEN 'D' then 1
            WHEN 'P' then 2
            end as Spiderman: Integer,
        Items
    }actions{
        @cds.odata.bindingparameter.name: '_anubhav'
        @Common.SideEffects: {
            TargetProperties:['_anubhav/GROSS_AMOUNT']
        }
        action boost();
        function largestOrder() returns POs;
    };

    function getOrderDefaults() returns POs;
    
    entity PurchaseOrderItems as projection on db.transaction.poitems;

    entity ProductView as projection on cds.CDSViews.ProductView;

}

