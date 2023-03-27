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
