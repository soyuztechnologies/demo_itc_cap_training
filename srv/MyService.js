//service implementation
const cds = require("@sap/cds");
const { employees } = cds.entities("anubhav.db.master");

const myservice = function(srv){

    

    srv.on('hello', (req, res) => {
        return "hey! " + req.data.name;
    });

    srv.on("READ", "ReadEmployeeSrv", async (req, res) => {
        var results = [];
        //Example 1: Pass complete hardcoded data
        results.push({
            "nameFirst": "Rebbeca",
            "nameMiddle": null,
            "nameLast": "Williams",
            "nameInitials": null,
            "sex": "F",
            "language": "E"
        });

        //Example 2: get top 10 records from
        results = await cds.tx(req).run(SELECT.from(employees).limit(10).where({"nameFirst": "Susan"}));

        ///Example 3: if we receive ID, we get data by ID
        var whereCondition = req.data;
        if(whereCondition.hasOwnProperty("ID")){
                results = await cds.tx(req).run(SELECT.from(employees).where(whereCondition));
        }

        return results;
    });

}

module.exports = myservice;