// const cds=require('@sap/cds');

// module.exports = cds.service.impl(
//     async function() {
//         let masters;
//         this.after('READ', 'master',async (masterData) => {
//             masters = Array.isArray(masterData) ? masterData : [masterData];
//             masters.forEach(async m => {
//                 if (m.mail.status === 'unshipped') {
//                     m.mail.critification = 1;
//                 } else if(m.mail.status==='intransit') {
//                     m.mail.critification = 2;
//                 }else if(m.mail.status==='received'){
//                     m.mail.critification = 5;
//                 }else {
//                     m.mail.critification = 3;
//                 }
//                 await UPDATE(this.entities.mail,m.mail.ID).with({critification: m.mail.critification});
//             });
            
//         })

        // this.on('nextStatus','mail', async (req) => {//异步方法 上传数据库
        //     let tempmail=mails[0];
        //     let cur=tempmail.status;
        //     if(tempmail.ID === req.data.id){
        //         if (tempmail.status === 'unshipped') {
        //             cur = 'intransit';
        //         } else if(tempmail.status==='intransit') {
        //             cur = 'received';
        //         }else {
        //             cur = 'Done';
        //         }
        //     }
            
        //    await UPDATE(this.entities.mail,req.params[0].ID).with({status: cur});//更新数据
        // });
//     }
// );