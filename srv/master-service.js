const cds=require('@sap/cds');
class MasterService extends cds.ApplicationService{
    async init() {
        await super.init();
        const Master= this.entities.master;
        const mailCountry = this.entities.mailCountry;

        this.before('CREATE', Master, async (req) => this.beforeCreateMaster(req));
        this.before('UPDATE', Master, async (req) => this.beforePatchMaster(req));

        this.after('READ', Master, async (masterData) => this.statusIcon(masterData));
        this.on('nextStatus',Master, async (req) => this.nextStatusIcon(req));  
        this.on('newStorage',Master, async (req) => this.newStorageIcon(req));  
        this.on('Amount',mailCountry, async(req) => this.newAmountIcon(req));
    }

    async statusIcon(masterData){
        let masters = Array.isArray(masterData) ? masterData : [masterData];
        masters.forEach(async m => {
            if (m.status === 'unshipped') {
                m.critification = 1;
            } else if(m.status==='intransit') {
                m.critification = 2;
            }else if(m.status==='received'){
                m.critification = 5;
            }else {
                m.critification = 3;
            }
            await UPDATE(this.entities.master,m.ID).with({critification: m.critification});
        }),
        masters.forEach(async m => {
            if (m.storage <= 20) {
                m.criticality = 1;
            } 
            else if (m.storage <= 70 && m.storage >20 ) {
                m.criticality = 2;
            }
            else if(m.storage > 70){
                m.criticality = 3;
            }
            await UPDATE(this.entities.master,m.ID).with({criticality: m.criticality});

        });
}
    async nextStatusIcon(req){
        let cur = await SELECT("*").from(this.entities.master).where({ID : req.params[0].ID});
        let status=cur[0].status;
        if (status === 'unshipped') {
            status = 'intransit';
        } else if(status==='intransit') {
            status = 'received';
        }else {
            status = 'Done';
        }
        req.warn("Status changed as : " + String(status));
        await UPDATE(this.entities.master,req.params[0].ID).with({status: status});//更新数据
    }

    async newStorageIcon(req){
        req.warn("Storage changed as : " + String(req.data.storage));
        await UPDATE(this.entities.master,req.params[0].ID).with({storage: req.data.storage});
    }

    async newAmountIcon(req){
        req.warn("Amount changed as : " + String(req.data.amount));
        await UPDATE(this.entities.mailCountry,req.params[1].ID).with({amount: req.data.amount});
    }

    async beforeCreateMaster(req){
        req.warn("Created at \n" + String(req.timestamp));
    }

    async beforePatchMaster(req){
        req.warn("Modified at \n" + String(req.timestamp));
    }
}
module.exports = MasterService;