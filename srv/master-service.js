const cds=require('@sap/cds');

module.exports = cds.service.impl(
    async function() {
        let masters;
        this.after('READ', 'master',(masterData) => {
            masters = Array.isArray(masterData) ? masterData : [masterData];
            masters.forEach(async m => {
                if (m.mail.status === 'unshipped') {
                    m.mail.critification = 1;
                } else if(m.mail.status==='intransit') {
                    m.mail.critification = 2;
                }else if(m.mail.status==='received'){
                    m.mail.critification = 5;
                }else {
                    m.mail.critification = 3;
                }

                if (m.store.storage <= 20) {
                    m.store.criticality = 1;
                } 
                else if (m.store.storage <= 70&&m.store.storage >20 ) {
                    m.store.criticality = 2;
                }
                else if(m.store.storage > 70){
                    m.store.criticality = 3;
                }
                await UPDATE(this.entities.mail,m.mail.ID).with({critification: m.mail.critification});
                await UPDATE(this.entities.store,m.store.ID).with({criticality: m.store.criticality});
            });
            
        })

        this.on('nextStatus','master', async (req) => {//异步方法 上传数据库
            let tempmail=masters[0];
            let cur=tempmail.mail.status;
            
            if (tempmail.mail.status === 'unshipped') {
                cur = 'intransit';
            } else if(tempmail.mail.status==='intransit') {
                cur = 'received';
            }else {
                cur = 'Done';
            }
            
           await UPDATE(this.entities.mail,tempmail.mail.ID).with({status: cur});//更新数据
        });
    }
);