@isTest
public class TestMaintenanceRequest {
    
    @isTest  static void testMaintenanceRequest(){
        
        List<Case> maintenanceList = new List<Case>();
        List<Case> closedMaintenanceList = new List<Case>();
        
        Vehicle__c vehicle=new Vehicle__c(Name='Vehicle Name', Air_Conditioner__c=true, Model__c ='Model 4565');
        
        Product2 equipment=new Product2(Name='Equipment', Cost__c=100, Current_Inventory__c=10, Replacement_Part__c=true,
                                        Warehouse_SKU__c='test', Lifespan_Months__c=10, Maintenance_Cycle__c=10);
        
        insert vehicle;
        insert equipment;
        
        for(Integer i=1; i<=300; i++){
            
            Case maintenance = new Case(Subject='Maintenance Request'+i, Type='Routine Maintenance'+i, Status='New'+i,
                                      Origin='Phone'+i, Equipment__c=equipment.Id, Vehicle__c=vehicle.Id);
            maintenanceList.add(maintenance);
        }
        
        insert maintenanceList;

        for(Case updateCase : maintenanceList){
            updateCase.Status='Closed';
            updateCase.Type='Routine Maintenance';
            updateCase.Date_Due__c=date.Today().addDays(Integer.valueOf(equipment.Maintenance_Cycle__c));
            closedMaintenanceList.add(updateCase);
        }
        
        Test.startTest();

        //Bulk insert update
        Database.SaveResult[] updateEquipment = Database.update(closedMaintenanceList);
        
        Test.stopTest();
        
        for(Database.SaveResult sa:updateEquipment){
            System.assert(sa.isSuccess());
        }
    }
}