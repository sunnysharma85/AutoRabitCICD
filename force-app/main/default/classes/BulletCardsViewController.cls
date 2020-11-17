public with sharing class BulletCardsViewController {
    public list<ContentVersion> lstContentVersion {get;set;}
    public BulletCardsViewController() {
        fetchContentVersion();
    }
    
    public void fetchContentVersion() {
        lstContentVersion = new list<ContentVersion>();
        ID workspaceId = [SELECT Id FROM ContentWorkspace WHERE Name = 'Battle Cards'][0].Id;
        lstContentVersion = [Select Id, Description, Title, FileType, Industry__c, Practice__c, Segment__c 
        	from ContentVersion 
        	where RecordType.DeveloperName ='Battle_Cards' 
        	and ContentDocument.ParentId = :workspaceId 
        	order by Practice__c,Title];
    }
}