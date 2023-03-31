namespace sap.ui.configurationstore;

using { managed } from '@sap/cds/common';
using { sap.ui.masterstore.master as master } from './master-store';
entity mail : managed {
    key ID : String;
    name   : String;
    receiver : String;
    status : String;
    amount : Integer;
    critification: Integer;
    changelog : Association to  many changeLog on changelog.mail_ID= ID ;
}


entity changeLog : managed {
    key ID : String;
    name   : String;
    oldstatus: String;
    newstatus : String;
    changereason : String;
    reason_code : Integer;
    mail : Association to  one mail on mail.ID= mail_ID ;
    master : Association to  one master on master.ID= master_ID ;
    mail_ID     : String;
    master_ID  :  String;
  }

entity store : managed {
    key ID      : String;
    category    : String;
    name        : String;
    storage      : Integer;
    criticality : Integer;
    changeLog2 : Association to  many changeLog2 on changeLog2.attribute=category;
  }

entity changeLog2 : managed {
    key ID      : String;
    attribute    : String;
    action        : String;
    oldvalue      : Integer;
    newvalue      : Integer;
    datatime      : Integer; 
  }
