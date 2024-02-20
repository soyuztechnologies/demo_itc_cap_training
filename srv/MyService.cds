using { anubhav.db.master } from '../db/datamodel';

service MyService@(path: 'MyService') {
    //this is a test change
    function hello(name: String) returns String;

    @readonly
    @Capabilities.Deletable: false
    entity ReadEmployeeSrv as projection on master.employees;

}