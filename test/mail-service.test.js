const cds = require("@sap/cds/lib");
const path = require("path");


describe('MailService Test', () => {
  const { GET, POST, expect,SELECT,UPDATE } = cds.test(path.join(__dirname, "../"));
  const data1={
    "ID": "d001",
    "name": "test",
    "receiver": "test",
    "status": "unshipped",
    "amount": 50,
    "critification": 0,
    }
  const data2={
    "ID": "d002",
    "name": "test",
    "receiver": "test",
    "status": "received",
    "amount": 50,
    "critification": 0,
    }
    const data3={
    "ID": "d003",
    "name": "test",
    "receiver": "test",
    "status": "intransit",
    "amount": 50,
    "critification": 0,
    }
    const data4={
    "ID": "d004",
    "name": "test",
    "receiver": "test",
    "status": "",
    "amount": 50,
    "critification": 0,
    }
  beforeAll(async ()=>{
    //let INSERT = cds.ql.INSERT;
    //let DEL = cds.ql.DELETE;
    //await DEL.from`sap.ui.configurationstore.mail`.where`ID=${data1.ID}`;
    //await INSERT.into(`sap.ui.configurationstore.mail`).entries(data1);
  })

  it('init', async () => {
    const mailService = await cds.connect.to("mailService");
        let flag = 0;
        try {
            await mailService.init();
        }catch(err) {
            flag = 1;
        }
        expect(flag).eq(0);

  });

  test('statusIcon', async () => {
    const srv = await cds.connect.to("mailService");

    await srv.statusIcon(data1);
    expect(data1.critification).eq(1);

    await srv.statusIcon(data2);
    expect(data2.critification).eq(5);

    await srv.statusIcon(data3);
    expect(data3.critification).eq(2);

    await srv.statusIcon(data4);
    expect(data4.critification).eq(3);
});

  it('nextStatusIcon', async () => {
    const srv = await cds.connect.to("mailService");
    const req = {
      params: [{ ID: "2e452daf-db97-44b1-afaf-d7f75faa97d1" }],
      warn(str){
        return str;
      }
    };
    const req1 = {
      params: [{ ID: "2e452daf-db97-44b1-afaf-d7f75faa97d2" }],
      warn(str){
        return str;
      }
    };
    const req2 = {
      params: [{ ID: "2e452daf-db97-44b1-afaf-d7f75faa97d3" }],
      warn(str){
        return str;
      }
    };
    srv.statusUpdate = jest.fn();
    expect(await srv.nextStatusIcon(req)).eq("Status changed as : intransit");
    expect(await srv.nextStatusIcon(req1)).eq("Status changed as : received");
    expect(await srv.nextStatusIcon(req2)).eq("Status changed as : Done");
  });

it('beforePatchMail', async () => {
  const srv = await cds.connect.to("mailService");
  const req = {
    timestamp : "time",
    warn(str){
      return str;
    }
  };
  expect(await srv.beforePatchMail(req)).eq("Modified at \n" + "time");
});

//mock方式进行覆盖重写
//   test("nextStatusIcon",async() =>{
//     srv.nextStatusIcon=jest.fn().mockImplementationOnce(async (req) =>{        
//         let status=req.status;
//         if (status === 'unshipped') {
//             status = 'intransit';
//         } else if(status==='intransit') {
//             status = 'received';
//         }else {
//             status = 'Done';
//         }
//         return status;
//     });
//     let status1=srv.nextStatusIcon(data1);
//     status1.then( data => expect(data).eq('intransit'));

//     let status2=srv.nextStatusIcon(data2);
//     status2.then( data => expect(data).eq('Done'));

//     let status3=srv.nextStatusIcon(data3);
//     status3.then( data => expect(data).eq('received'));

//     let status4=srv.nextStatusIcon(data4);
//     status4.then( data => expect(data).eq('Done'));
//   })

// it('changeStatus',async() => {
//   const srv = await cds.connect.to("mailService");
//   expect(srv.changeStatus(data1.status)).eq('intransit');
//   expect(srv.changeStatus(data2.status)).eq('Done');
//   expect(srv.changeStatus(data3.status)).eq('received');
// });
});