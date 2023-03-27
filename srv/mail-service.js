const cds=require('@sap/cds');

module.exports = cds.service.impl(
    async function() {
        let mails;
        this.after('READ', 'mail', mailData => {
            mails = Array.isArray(mailData) ? mailData : [mailData];
            mails.forEach(m => {
                if (m.status === 'unshipped') {
                    m.critification = 1;
                } else if(m.status==='intransit') {
                    m.critification = 2;
                }else if(m.status==='received'){
                    m.critification = 5;
                }else {
                    m.critification = 3;
                }
            });
        })

        this.on('nextStatus','mail', async (req) => {//异步方法 上传数据库
            let tempmail=mails[0];
            let cur=tempmail.status;
            if(tempmail.ID === req.data.id){
                if (tempmail.status === 'unshipped') {
                    cur = 'intransit';
                } else if(tempmail.status==='intransit') {
                    cur = 'received';
                }else {
                    cur = 'Done';
                }
            }
            
           await UPDATE(this.entities.mail,req.params[0].ID).with({status: cur});//更新数据
        });
    }
);