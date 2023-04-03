using { sap.ui.configurationstore as my } from '../db/configuration-store';

service mailService {
    entity mail @(restrict : [
            {
                grant : [ 'READ' ],
                to : [ 'RiskViewer' ]
            },
            {
                grant : [ '*' ],
                to : [ 'RiskManager' ]
            }
        ])as projection on my.mail actions{
        action nextStatus(id : String);
    };
        annotate mail with @odata.draft.enabled ;

    entity changeLog @(restrict : [
            {
                grant : [ 'READ' ],
                to : [ 'RiskViewer' ]
            },
            {
                grant : [ '*' ],
                to : [ 'RiskManager' ]
            }
        ])as projection on my.changeLog;
        annotate changeLog with @odata.draft.enabled ;
}
