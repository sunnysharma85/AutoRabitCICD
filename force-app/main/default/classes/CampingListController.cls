public with sharing class CampingListController {
    @AuraEnabled
    public static list<Camping_Item__c> getItems(){
        return [Select Id, Name, Quantity__c, Price__c, Packed__c from Camping_Item__c];
    }

    @AuraEnabled
    public static Camping_Item__c saveItem(Camping_Item__c objCampingItem) {
        insert objCampingItem;
        
        return objCampingItem;
    }
}