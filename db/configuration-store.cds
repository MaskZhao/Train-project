namespace sap.ui.configurationstore;

using { managed,cuid } from '@sap/cds/common';
entity mail : managed {
    key ID : String;
    name   : String;
    receiver : String;
    status : String;
    amount : Integer;
    critification: Integer;
    changelog : Association to  many changeLog on changelog.mail= $self ;
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
    criticality : Integer;
    changeLog2 : Association to  many changeLog2 on changeLog2.attribute=category;
  }

entity changeLog2 : managed ,cuid{
    attribute    : String;
    action        : String;
    oldvalue      : Integer;
    newvalue      : Integer;
    datatime      : Integer; 
    store         :Association to one store on store.category=attribute;
  }
