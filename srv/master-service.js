const cds=require('@sap/cds');
let Master;
let masters;
let mailCountry;
class MasterService extends cds.ApplicationService{
    async init() {
        await super.init();
        Master= this.entities.master;
        mailCountry = this.entities.mailCountry;
        this.after('READ', Master, async (masterData) => this.statusIcon(masterData));
        this.on('nextStatus',Master, async (req) => this.nextStatusIcon(req));  
        this.on('newStorage',Master, async (req) => this.newStorageIcon(req));  
        this.on('Amount',mailCountry, async(req) => this.newAmountIcon(req));
    }

    async statusIcon(masterData){
        masters = Array.isArray(masterData) ? masterData : [masterData];
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
            await UPDATE(Master,m.ID).with({critification: m.critification});
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
            await UPDATE(Master,m.ID).with({criticality: m.criticality});

        });
}
    async nextStatusIcon(req){
        let tempmail=masters[0];
        let cur=tempmail.status;
        
        if (tempmail.status === 'unshipped') {
            cur = 'intransit';
        } else if(tempmail.status==='intransit') {
            cur = 'received';
        }else {
            cur = 'Done';
        }
        
        await UPDATE(Master,req.params[0].ID).with({status: cur});//更新数据
    }

    async newStorageIcon(req){
        await UPDATE(Master,req.params[0].ID).with({storage: req.data.storage});
    }

    async newAmountIcon(req){
        await UPDATE(mailCountry,req.params[1].ID).with({amount: req.data.amount});
    }
}
module.exports = MasterService;