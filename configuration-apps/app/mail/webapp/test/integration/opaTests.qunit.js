sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ns/mail/test/integration/FirstJourney',
		'ns/mail/test/integration/pages/mailList',
		'ns/mail/test/integration/pages/mailObjectPage'
    ],
    function(JourneyRunner, opaJourney, mailList, mailObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ns/mail') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThemailList: mailList,
					onThemailObjectPage: mailObjectPage
                }
            },
            opaJourney.run
        );
    }
);