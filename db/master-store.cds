namespace sap.ui.masterstore;

using {managed} from '@sap/cds/common';

using { 
    sap.ui.configurationstore.mail,
    sap.ui.configurationstore.store,
    sap.ui.configurationstore.changeLog,
    sap.ui.configurationstore.changeLog2,
} from './configuration-store.cds';

entity master : managed {
    key ID : String;
    name   : String;
    mail   : Association to one mail ;
    changeLog : Association to many changeLog on changeLog.master_ID = ID;
    store     : Association to one store;
    country   : Association to one mailCountry;
};

entity mailCountry : managed {
    key ID : String;
    country : String;
};
