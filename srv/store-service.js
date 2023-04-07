const cds=require('@sap/cds');
class storeService extends cds.ApplicationService{
    async init() {
        await super.init();
        const Store= this.entities.store;
        this.before('UPDATE', Store, async (req) => this.beforePatchStore(req));
        this.after('READ', Store, async (risksData) => this.statusIcon(risksData));
        this.on('nextStatus',Store, async (req) => this.nextStatusIcon(req));  
    }

    async statusIcon(risksData){
        let risks = Array.isArray(risksData) ? risksData : [risksData];
        risks.forEach(async (risk) => {
            if (risk.storage <= 20) {
                risk.criticality = 1;
            } 
            if (risk.storage <= 70&&risk.storage >20 ) {
                risk.criticality = 2;
            }
            if(risk.storage > 70){
                risk.criticality = 3;
            }
            await UPDATE(this.entities.store,risk.ID).with({criticality: risk.criticality});//用cur更新storage数据
        });
}
    async nextStatusIcon(req){
       //异步方法 上传数据库 因为update需要一段时间
       let cur = await SELECT("*").from(this.entities.store).where({ID : req.params[0].ID});
       let storage = cur[0].storage;
        if (storage <= 20) {
            storage += 50;
        } 
        if(storage >= 200){
            storage -= 50;
        }
        req.warn("Storage changed as : " + String(storage));
        await UPDATE(this.entities.store,req.params[0].ID).with({storage: storage});//用cur更新storage数据
    }

    async beforePatchStore(req){
        req.warn("Modified at \n" + String(req.timestamp));
    }
}
module.exports = storeService;