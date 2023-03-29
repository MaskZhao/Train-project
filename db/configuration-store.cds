namespace sap.ui.configurationstore;

using { managed } from '@sap/cds/common';
entity mail : managed {
    key ID : String;
    name   : String;
    receiver : String;
    status : String;
    amount : Integer;
    critification: Integer;
    changelog : Association to  many changeLog on changelog.ID=ID;
}


entity changeLog : managed {
    key ID : String;
    name   : String;
    oldstatus: String;
    newstatus : String;
    changereason : String;
    reason_code : Integer;
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
