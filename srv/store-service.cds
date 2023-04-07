using { sap.ui.configurationstore as my } from '../db/configuration-store';

service storeService {
    entity store @(restrict : [
            {
                grant : [ 'READ' ],
                to : [ 'RiskViewer' ]
            },
            {
                grant : [ '*' ],
                to : [ 'RiskManager' ]
            }
        ])as projection on my.store actions{
        action nextStatus();
    };
    annotate store with @odata.draft.enabled;
    entity changeLog2 @(restrict : [
            {
                grant : [ 'READ' ],
                to : [ 'RiskViewer' ]
            },
            {
                grant : [ '*' ],
                to : [ 'RiskManager' ]
            }
        ])as projection on my.changeLog2;
}
