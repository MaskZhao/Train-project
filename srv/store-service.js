
const cds = require('@sap/cds')

/**
 * Implementation for Risk Management service defined in ./risk-service.cds
 */
module.exports = cds.service.impl(async function() {
    this.after('READ', 'store', risksData => {
        const risks = Array.isArray(risksData) ? risksData : [risksData];
        risks.forEach(risk => {
            if (risk.storage <= 20) {
                risk.criticality = 1;
            } 
            if (risk.storage <= 70&&risk.storage >20 ) {
                risk.criticality = 2;
            }
            if(risk.storage > 70){
                risk.criticality = 3;
            }
        });
    });
});