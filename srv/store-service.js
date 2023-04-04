const cds=require('@sap/cds');
let Store;
let risks;
class StoreService extends cds.ApplicationService{
    async init() {
        await super.init();
        Store= this.entities.store;
        this.after('READ', Store, async (risksData) => this.statusIcon(risksData));
        this.on('nextStatus',Store, async (req) => this.nextStatusIcon(req));  
    }

    async statusIcon(risksData){
        risks = Array.isArray(risksData) ? risksData : [risksData];
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
}
    async nextStatusIcon(req){
       //异步方法 上传数据库 因为update需要一段时间
       let tempmail=risks[0];
       let cur=tempmail.storage;
       if(tempmail.ID === req.data.id){
           if (tempmail.storage <= 20) {
               cur += 50;
           } 
           if(tempmail.storage >= 200){
               cur -= 50;
           }
       }
      await UPDATE(this.entities.Store,req.params[0].ID).with({storage: cur});//用cur更新storage数据
      await UPDATE(this.entities.changeLog2,req.params[0].ID).with({newvalue: cur});//用cur更新storage数据
    }

}
module.exports = StoreService;