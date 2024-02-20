namespace mycapapp.reuse;
using { Country } from '@sap/cds/common';

type Guid : String(32);

aspect address {
    city: String(16);
    country: Country;
    landmark: String(16);
    houseNo: Int16;
    isCovidContainment: Boolean;
}

