namespace sap.ui.masterstore;

using {managed,cuid} from '@sap/cds/common';

using { 
    sap.ui.configurationstore.mail,
    sap.ui.configurationstore.store,
} from './configuration-store.cds';

entity master : managed {
    key ID : String;
    name   : String;
    mail   : Composition of many mail on mail.master = $self;
    store     : Association to one store;
    country   : Composition of many  mailCountry on country.parent = $self;
    status     :  String;
    critification : Integer;
    storage     : Integer;
    criticality : Integer;
};

entity mailCountry : managed ,cuid{
    parent : Association to master;
    country : String;
    amount  : Integer;
    descr   : Association to one description ;
};

entity description : managed{
    key ID : String;
    descr  : String;
};
