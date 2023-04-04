const cds=require('@sap/cds');
let Mail;
let mails;
class MailService extends cds.ApplicationService{
    async init() {
        await super.init();
        //const db = await cds.connect.to('db');
        Mail= this.entities.mail;
        this.after('READ', Mail, async (mailData) => this.statusIcon(mailData));
        this.on('nextStatus',Mail, async (req) => this.nextStatusIcon(req));  
    }

    async statusIcon(mailData){
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
}
    async nextStatusIcon(req){
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
    }

}
module.exports = MailService;