const cds=require('@sap/cds');
class MailService extends cds.ApplicationService{
    async init() {
        await super.init();
        //const db = await cds.connect.to('db');
        const Mail= this.entities.mail;
        this.before('UPDATE', Mail, async (req) => this.beforePatchMail(req));
        this.after('READ', Mail, async (mailData) => this.statusIcon(mailData));
        this.on('nextStatus',Mail, async (req) => this.nextStatusIcon(req));  
    }

    async statusIcon(mailData){
    let mails = Array.isArray(mailData) ? mailData : [mailData];
    mails.forEach(async (m) => {
        if (m.status === 'unshipped') {
            m.critification = 1;
        } else if(m.status==='intransit') {
            m.critification = 2;
        }else if(m.status==='received'){
            m.critification = 5;
        }else {
            m.critification = 3;
        }
        await UPDATE(this.entities.mail,m.ID).with({critification: m.critification});
    });
}
    async nextStatusIcon(req){
        let cur = await SELECT("*").from(this.entities.mail).where({ID : req.params[0].ID});
        let status=cur[0].status;
        if (status === 'unshipped') {
            status = 'intransit';
        } else if(status==='intransit') {
            status = 'received';
        }else {
            status = 'Done';
        }
        req.warn("Status changed as : " + String(status));
        await UPDATE(this.entities.mail,req.params[0].ID).with({status: status});//更新数据
    }

    async beforePatchMail(req){
        req.warn("Modified at \n" + String(req.timestamp));
    }
}
module.exports = MailService;