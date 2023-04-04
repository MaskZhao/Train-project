sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ns/country/test/integration/FirstJourney',
		'ns/country/test/integration/pages/mailCountryList',
		'ns/country/test/integration/pages/mailCountryObjectPage'
    ],
    function(JourneyRunner, opaJourney, mailCountryList, mailCountryObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ns/country') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThemailCountryList: mailCountryList,
					onThemailCountryObjectPage: mailCountryObjectPage
                }
            },
            opaJourney.run
        );
    }
);