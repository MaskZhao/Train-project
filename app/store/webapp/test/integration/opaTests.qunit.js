sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ns/store/test/integration/FirstJourney',
		'ns/store/test/integration/pages/StoreList',
		'ns/store/test/integration/pages/StoreObjectPage'
    ],
    function(JourneyRunner, opaJourney, StoreList, StoreObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ns/store') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheStoreList: StoreList,
					onTheStoreObjectPage: StoreObjectPage
                }
            },
            opaJourney.run
        );
    }
);