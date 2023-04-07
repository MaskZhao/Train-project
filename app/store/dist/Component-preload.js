//@ui5-bundle ns/store/Component-preload.js
jQuery.sap.registerPreloadedModules({
"version":"2.0",
"modules":{
	"ns/store/Component.js":function(){sap.ui.define(["sap/fe/core/AppComponent"],function(e){"use strict";return e.extend("ns.store.Component",{metadata:{manifest:"json"}})});
},
	"ns/store/i18n/i18n.properties":'# This is the resource bundle for ns.store\n\n#Texts for manifest.json\n\n#XTIT: Application name\nappTitle=Store\n\n#YDES: Application description\nappDescription=store',
	"ns/store/manifest.json":'{"_version":"1.49.0","sap.app":{"id":"ns.store","type":"application","i18n":"i18n/i18n.properties","applicationVersion":{"version":"0.0.1"},"title":"{{appTitle}}","description":"{{appDescription}}","resources":"resources.json","sourceTemplate":{"id":"@sap/generator-fiori:lrop","version":"1.9.2","toolsId":"55a12a81-1df0-4dbb-92c0-1a89faba16c7"},"dataSources":{"mainService":{"uri":"store/","type":"OData","settings":{"annotations":[],"localUri":"localService/metadata.xml","odataVersion":"4.0"}}},"crossNavigation":{"inbounds":{"store-display":{"signature":{"parameters":{},"additionalParameters":"allowed"},"semanticObject":"store","action":"display"}}}},"sap.ui":{"technology":"UI5","icons":{"icon":"","favIcon":"","phone":"","phone@2":"","tablet":"","tablet@2":""},"deviceTypes":{"desktop":true,"tablet":true,"phone":true}},"sap.ui5":{"flexEnabled":true,"dependencies":{"minUI5Version":"1.112.1","libs":{"sap.m":{},"sap.ui.core":{},"sap.ushell":{},"sap.fe.templates":{}}},"contentDensities":{"compact":true,"cozy":true},"models":{"i18n":{"type":"sap.ui.model.resource.ResourceModel","settings":{"bundleName":"ns.store.i18n.i18n"}},"":{"dataSource":"mainService","preload":true,"settings":{"synchronizationMode":"None","operationMode":"Server","autoExpandSelect":true,"earlyRequests":true}},"@i18n":{"type":"sap.ui.model.resource.ResourceModel","uri":"i18n/i18n.properties"}},"resources":{"css":[]},"routing":{"config":{},"routes":[{"pattern":":?query:","name":"storeList","target":"storeList"},{"pattern":"store({key}):?query:","name":"storeObjectPage","target":"storeObjectPage"}],"targets":{"storeList":{"type":"Component","id":"storeList","name":"sap.fe.templates.ListReport","options":{"settings":{"entitySet":"store","variantManagement":"Page","navigation":{"store":{"detail":{"route":"storeObjectPage"}}}}}},"storeObjectPage":{"type":"Component","id":"storeObjectPage","name":"sap.fe.templates.ObjectPage","options":{"settings":{"editableHeaderContent":false,"entitySet":"store"}}}}}},"sap.fiori":{"registrationIds":[],"archeType":"transactional"},"sap.cloud":{"public":true,"service":"train-project.service"}}'
}});
