sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ns/changelog/test/integration/FirstJourney',
		'ns/changelog/test/integration/pages/changeLogList',
		'ns/changelog/test/integration/pages/changeLogObjectPage'
    ],
    function(JourneyRunner, opaJourney, changeLogList, changeLogObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ns/changelog') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThechangeLogList: changeLogList,
					onThechangeLogObjectPage: changeLogObjectPage
                }
            },
            opaJourney.run
        );
    }
);