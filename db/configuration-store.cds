namespace sap.ui.configurationstore;

using { managed,cuid } from '@sap/cds/common';

using { 
    sap.ui.masterstore.master
} from './master-store.cds';

entity mail : managed {
    key ID : UUID;
    label : String;
    name   : String;
    receiver : String;
    status : String;
    amount : Integer;
    critification: Integer;
    master       :  Association to master;
    changelog : Composition of many changeLog on changelog.mail= $self ;
}

entity changeLog : managed ,cuid {
    name   : String;
    oldstatus: String;
    newstatus : String;
    changereason : String;
    reason_code : Integer;
    mail     : Association to mail;
  }

entity store : managed {
    key ID      : String;
    category    : String;
    name        : String;
    storage      : Integer;
    criticality  : Integer;
    changeLog2   : Composition of many changeLog2 on changeLog2.store = $self;
  }

entity changeLog2 : managed ,cuid{
    store         : Association to  store;
    attribute    : String;
    name          : String;
    oldvalue      : Integer;
    newvalue      : Integer;
    datatime      : Integer; 
  }
