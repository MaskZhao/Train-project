sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ns/master/test/integration/FirstJourney',
		'ns/master/test/integration/pages/masterList',
		'ns/master/test/integration/pages/masterObjectPage',
		'ns/master/test/integration/pages/mailCountryObjectPage'
    ],
    function(JourneyRunner, opaJourney, masterList, masterObjectPage, mailCountryObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ns/master') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThemasterList: masterList,
					onThemasterObjectPage: masterObjectPage,
					onThemailCountryObjectPage: mailCountryObjectPage
                }
            },
            opaJourney.run
        );
    }
);