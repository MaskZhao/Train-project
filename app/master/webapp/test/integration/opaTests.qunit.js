sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ns/master/test/integration/FirstJourney',
		'ns/master/test/integration/pages/masterList',
		'ns/master/test/integration/pages/masterObjectPage'
    ],
    function(JourneyRunner, opaJourney, masterList, masterObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ns/master') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThemasterList: masterList,
					onThemasterObjectPage: masterObjectPage
                }
            },
            opaJourney.run
        );
    }
);