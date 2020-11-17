public class MaintenanceRequestHelper {
    public static void updateWorkOrders() {
        List < Case > newMaintenanceRequestList = new List < Case > ();
        Case newMaintenanceRequest;
        for (Case cas: [select id, Case.Vehicle__c, Equipment__c, Equipment__r.Maintenance_Cycle__c, Type, Status
        from Case where id in :Trigger.New and isClosed = true and type in ('Routine Maintenance', 'Repair') limit 200]) {
                newMaintenanceRequest = new Case();
                newMaintenanceRequest.Subject = 'New Maintenance Request';
                newMaintenanceRequest.Type = 'Routine Maintenance';
                newMaintenanceRequest.Vehicle__c = cas.Vehicle__c;
                newMaintenanceRequest.Equipment__c = cas.Equipment__c;
                newMaintenanceRequest.Date_Reported__c = date.Today();
                newMaintenanceRequest.Date_Due__c = Date.today().addDays(Integer.valueOf(cas.Equipment__r.Maintenance_Cycle__c));
                newMaintenanceRequest.Status = 'New';
                newMaintenanceRequest.Origin = 'Phone';
                newMaintenanceRequestList.add(newMaintenanceRequest);
        }
        if (!newMaintenanceRequestList.isEmpty()) insert newMaintenanceRequestList;
    }
}