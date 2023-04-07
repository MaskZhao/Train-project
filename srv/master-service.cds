using { sap.ui.configurationstore as configuration } from '../db/configuration-store';
using { sap.ui.masterstore as masters } from '../db/master-store';

service masterService {

    entity master @(restrict : [
            {
                grant : [ 'READ' ],
                to : [ 'RiskViewer' ]
            },
            {
                grant : [ '*' ],
                to : [ 'RiskManager' ]
            }
        ])as projection on masters.master actions{
        action nextStatus();
        action newStorage(storage : Integer);
    };
    annotate master with @odata.draft.enabled;

    entity mailCountry @(restrict : [
            {
                grant : [ 'READ' ],
                to : [ 'RiskViewer' ]
            },
            {
                grant : [ '*' ],
                to : [ 'RiskManager' ]
            }
        ])as projection on masters.mailCountry actions{
            action Amount(amount : Integer);
        };

    entity mail @(restrict : [
            {
                grant : [ 'READ' ],
                to : [ 'RiskViewer' ]
            },
            {
                grant : [ '*' ],
                to : [ 'RiskManager' ]
            }
        ])as projection on configuration.mail;

    entity store @(restrict : [
            {
                grant : [ 'READ' ],
                to : [ 'RiskViewer' ]
            },
            {
                grant : [ '*' ],
                to : [ 'RiskManager' ]
            }
        ])as projection on configuration.store ;
    annotate store with @odata.draft.enabled;

    entity description @(restrict : [
            {
                grant : [ 'READ' ],
                to : [ 'RiskViewer' ]
            },
            {
                grant : [ '*' ],
                to : [ 'RiskManager' ]
            }
        ])as projection on masters.description;
    annotate description with @odata.draft.enabled ;
}