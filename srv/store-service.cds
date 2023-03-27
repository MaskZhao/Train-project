using { sap.ui.configurationstore as my } from '../db/configuration-store';
@path: 'service/lunch'
service StoreService {
  entity Store as projection on my.Store;
    annotate Store with @odata.draft.enabled;
  entity changeLog2 as projection on my.changeLog2;
    annotate changeLog2 with @odata.draft.enabled;

}
