sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ns/store/test/integration/FirstJourney',
		'ns/store/test/integration/pages/storeList',
		'ns/store/test/integration/pages/storeObjectPage'
    ],
    function(JourneyRunner, opaJourney, storeList, storeObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ns/store') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThestoreList: storeList,
					onThestoreObjectPage: storeObjectPage
                }
            },
            opaJourney.run
        );
    }
);