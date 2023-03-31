using { sap.ui.configurationstore as my } from '../db/configuration-store';

service storeService {
  entity store as projection on my.store;
    annotate store with @odata.draft.enabled;
  entity changeLog2 as projection on my.changeLog2;
    annotate changeLog2 with @odata.draft.enabled;

}
