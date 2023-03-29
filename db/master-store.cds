namespace sap.ui.masterstore;

using {
    managed,
    Country
} from '@sap/cds/common';

using { 
    sap.ui.configurationstore.mail,
    sap.ui.configurationstore.store,
    sap.ui.configurationstore.changeLog,
    sap.ui.configurationstore.changeLog2,
} from './configuration-store.cds';

entity master : managed {
    key ID : String;
    name   : String;
    mail   : Association to one mail;
    changelog : Association to many changeLog on changelog.ID = ID;
    store     : Association to one store;
    country   : Association to one mailCountry;
};

entity mailCountry : managed {
    key ID : String;
    country : String;
};
