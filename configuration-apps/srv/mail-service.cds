using { sap.ui.configurationstore as my } from '../db/configuration-store';

service mailService {
    entity mail as projection on my.mail actions{
        action nextStatus(id : String);
    };
        annotate mail with @odata.draft.enabled ;

    entity changeLog as projection on my.changeLog;
        annotate changeLog with @odata.draft.enabled ;
}
