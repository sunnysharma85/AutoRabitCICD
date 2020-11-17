public with sharing class BulletCardsPracticeViewController {
	public string strSelectedPractice {get;set;}
	public list<string> lstPracticeValues {get;set;}
	public list<ContentVersion> lstContentVersion {get;set;}
	public boolean isShowSection {get;set;}
    public BulletCardsPracticeViewController() {
    	Schema.DescribeFieldResult filesPracticeFieldDescribe = ContentVersion.Practice__c.getDescribe();
    	lstPracticeValues = new list<string>();
    	for(Schema.PicklistEntry sPE : filesPracticeFieldDescribe.getPicklistValues()) {
    		lstPracticeValues.add(sPE.getLabel());
    	}
    }
    
    public void fetchPracticeData() {
    	lstContentVersion = new list<ContentVersion>();
    	system.debug('strSelectedPractice ----> ' + strSelectedPractice);
    	isShowSection = false;
    	if(strSelectedPractice != null && strSelectedPractice != '') {
    		isShowSection = true;
	    	for(ContentVersion cV : [Select Id, Description, Title, FileType, Industry__c, Practice__c 
		    		from ContentVersion 
		    		where RecordType.DeveloperName = 'Bullet_Cards' 
		    		AND Practice__c =: strSelectedPractice 
		    		order by Title]) {
	    		lstContentVersion.add(cV);
	    	}
    	}
    }
    
}