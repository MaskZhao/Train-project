using { sap.ui.configurationstore as configuration } from '../db/configuration-store';
using { sap.ui.masterstore as masters } from '../db/master-store';

service masterService {
    entity master as projection on masters.master{
        ID,
        name,
        createdAt,
        createdBy,
        modifiedAt,
        modifiedBy,
        mail : redirected to mail,
        changelog : redirected to changeLog,
        store : redirected to store,
        country : redirected to mailCountry,
    };
    annotate master with @odata.draft.enabled  @Common.SemanticKey : [ID];

    entity mailCountry as projection on masters.mailCountry order by ID asc;
    annotate mailCountry with @odata.draft.enabled ;

    entity mail as projection on configuration.mail order by ID asc actions{
        action nextStatus(id : String);
    };
    annotate mail with @odata.draft.enabled ;

    entity changeLog as projection on configuration.changeLog order by ID asc;
    annotate changeLog with @odata.draft.enabled ;

    entity store as projection on configuration.store order by ID asc;
    annotate store with @odata.draft.enabled;

    entity changeLog2 as projection on configuration.changeLog2 order by ID asc;
    annotate changeLog2 with @odata.draft.enabled;
}