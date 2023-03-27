sap.ui.define(['sap/fe/test/ListReport'], function(ListReport) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ListReport(
        {
            appId: 'ns.changelog',
            componentId: 'changeLogList',
            entitySet: 'changeLog'
        },
        CustomPageDefinitions
    );
});