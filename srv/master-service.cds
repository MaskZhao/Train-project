using { sap.ui.configurationstore as configuration } from '../db/configuration-store';
using { sap.ui.masterstore as masters } from '../db/master-store';

service masterService {

    entity master as projection on masters.master actions{
        action nextStatus();
        action newStorage(storage : Integer);
    };
    annotate master with @odata.draft.enabled;

    entity mailCountry as projection on masters.mailCountry;
    annotate mailCountry with @odata.draft.enabled ;

    entity mail as projection on configuration.mail{
        *
    };
    annotate mail with @odata.draft.enabled ;

    entity changeLog as projection on configuration.changeLog;
    annotate changeLog with @odata.draft.enabled ;

    entity store as projection on configuration.store{
        *
    };
    annotate store with @odata.draft.enabled;

    entity changeLog2 as projection on configuration.changeLog2;
    annotate changeLog2 with @odata.draft.enabled;
}