module.exports = cds.service.impl(async function(){
     
    const {EmployeeSet, POs} = this.entities;

    //generic handler
    this.before('UPDATE', EmployeeSet, (req, res) => {
        //the code will trigger whenever there is update request on employee
        if(parseFloat(req.data.salaryAmount) >= 1000000){
            req.error(500, "Salary must be less than a million, please fix and restest!")
        }
    });

    this.on('boost', async (req, res) => {
        try {
            const ID = req.params[0];
            const tx = cds.tx(req);
            await tx.update(POs).with({
                GROSS_AMOUNT: {'+=' : 20000},
            }).where(ID);
        } catch (error) {
            return "Error : " + error.toString();
        }
    });

    this.on('getOrderDefaults', async (req, res) => {
        return { OVERALL_STATUS : 'P'}
    });

    this.on('largestOrder', async (req, res) =>{
        try {
            const ID = req.params[0];
            const tx = cds.tx(req);

            //SELECT  * UP TO 1 ROWS FROM db WHERE AMT = (SELECT MAX(AMT) FROM dbtab)
            const reply = await tx.read(POs).orderBy({
                GROSS_AMOUNT: 'desc'
            }).limit(1);

            return reply;
        } catch (error) {
            
        }
    });
    

});