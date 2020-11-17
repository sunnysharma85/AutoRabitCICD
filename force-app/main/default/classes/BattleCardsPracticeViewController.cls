public with sharing class BattleCardsPracticeViewController {
    public string strSelectedPractice {get;set;}
    public list<string> lstPracticeValues {get;set;}
    public list<ContentVersion> lstContentVersion {get;set;}
    public boolean isShowSection {get;set;}
    public Set<String> offerings = new Set<String>();
    public string selectedOffering {get;set;}
    public ContentVersion objContentVersion {get;set;}
    map<string, list<ContentVersion>> mapPracticeContentVersion;
    public boolean showFilters {get;set;}
    public boolean isSearchComplete {get;set;}
	public string strSearchCriteria {get;set;}
	
    public BattleCardsPracticeViewController() {
        objContentVersion = new ContentVersion();
        system.debug('--constructor called---');
        showFilters = false;
		isSearchComplete = false;
        fetchBattleCards();
    }
    public List<SelectOption> getOfferingList(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('None','--- None ---'));
        
        for(String offer : offerings){
            options.add(new SelectOption(offer,offer));
        }
       
        return options;
        
    }
    
    private void fetchBattleCards(){
        offerings = new Set<String>();
        mapPracticeContentVersion = new map<string, list<ContentVersion>>();
        list<ContentVersion> lstContentVersionTemp;
        Schema.DescribeFieldResult filesPracticeFieldDescribe = ContentVersion.Practice__c.getDescribe();
        lstPracticeValues = new list<string>();
        for(Schema.PicklistEntry sPE : filesPracticeFieldDescribe.getPicklistValues()) {
            lstPracticeValues.add(sPE.getLabel());
        }
        lstPracticeValues = new list<string>();
        ID workspaceId = [SELECT Id FROM ContentWorkspace WHERE Name = 'Battle Cards'][0].Id;
        
        for(ContentVersion cV : [Select Id, Description, Title, FileType, Offering_Leve_1__c,Offering_Leve_2__c,
                                 Offering_Leve_3__c, Offering_Leve_4__c,Offering_Level_Tagged_Value__c, FirstPublishLocationId  
                    from ContentVersion 
                    where RecordType.DeveloperName = 'Battle_Cards' 
                    and Offering_Leve_1__c != null 
                    and ContentDocument.ParentId = :workspaceId
                    order by Offering_Leve_1__c,Title]) {
            lstContentVersionTemp = new list<ContentVersion>();
            lstContentVersionTemp.add(cV);
            offerings.add(cV.Offering_Level_Tagged_Value__c);
            if(mapPracticeContentVersion.containskey(cV.Offering_Leve_1__c)) {
                lstContentVersionTemp.addAll(mapPracticeContentVersion.get(cV.Offering_Leve_1__c));
            }
            else {
                lstPracticeValues.add(cV.Offering_Leve_1__c);
            }
            mapPracticeContentVersion.put(cV.Offering_Leve_1__c, lstContentVersionTemp);
            
            
        }

        
    }
    
    public void fetchSelectedOfferingBattleCards(){
		strSearchCriteria = 'You have searched for: ';
        if(objContentVersion.Offering_Leve_1__c=='' && objContentVersion.Offering_Leve_2__c =='' && objContentVersion.Offering_Leve_3__c==''){
            fetchBattleCards();
        }else{
            fetchBattleCardsForSpecificOffering(objContentVersion.Offering_Leve_1__c, objContentVersion.Offering_Leve_2__c, objContentVersion.Offering_Leve_3__c);
        }
		isSearchComplete = true;
    }
    
    private void fetchBattleCardsForSpecificOffering(String offeringLevel1, String offeringLevel2, String offeringLevel3){
		
        //offerings = new Set<String>();
        mapPracticeContentVersion = new map<string, list<ContentVersion>>();
        list<ContentVersion> lstContentVersionTemp;
        Schema.DescribeFieldResult filesPracticeFieldDescribe = ContentVersion.Practice__c.getDescribe();
        lstPracticeValues = new list<string>();
        for(Schema.PicklistEntry sPE : filesPracticeFieldDescribe.getPicklistValues()) {
            lstPracticeValues.add(sPE.getLabel());
        }
        lstPracticeValues = new list<string>();
        ID workspaceId = [SELECT Id FROM ContentWorkspace WHERE Name = 'Battle Cards'][0].Id;
        String query = 'Select Id, Description, Title, FileType, Offering_Leve_1__c,Offering_Leve_2__c, ';
        query = query +  'Offering_Leve_3__c, Offering_Leve_4__c,Offering_Level_Tagged_Value__c, FirstPublishLocationId ';
        query = query +  'from ContentVersion where RecordType.DeveloperName = \'Battle_Cards\' and Offering_Leve_1__c != null ';
        query = query +  'and ContentDocument.ParentId = :workspaceId ';
        if(offeringLevel1 !=null && offeringLevel1 !='' ){
			strSearchCriteria += offeringLevel1;
            query = query +  'and Offering_Leve_1__c =:offeringLevel1';
        }
        if(offeringLevel2 !=null && offeringLevel2 !='' ){
			strSearchCriteria += ', ' + offeringLevel2;
            query = query +  ' and Offering_Leve_2__c =:offeringLevel2';
        }
        if(offeringLevel3 !=null && offeringLevel3 !='' ){
			strSearchCriteria += ', ' + offeringLevel3;
            query = query +  ' and Offering_Leve_3__c =:offeringLevel3';
        }
		strSearchCriteria += '.';
        List<ContentVersion> conv = Database.query(query);

        for(ContentVersion cV : conv) {
            lstContentVersionTemp = new list<ContentVersion>();
            lstContentVersionTemp.add(cV);
            //offerings.add(cV.Offering_Level_Tagged_Value__c);
            if(mapPracticeContentVersion.containskey(cV.Offering_Leve_1__c)) {
                lstContentVersionTemp.addAll(mapPracticeContentVersion.get(cV.Offering_Leve_1__c));
            }
            else {
                lstPracticeValues.add(cV.Offering_Leve_1__c);
            }
            mapPracticeContentVersion.put(cV.Offering_Leve_1__c, lstContentVersionTemp);
            
            
        }

        
    }    
    
    
    
    /*
    public void fetchPracticeData() {
        lstContentVersion = new list<ContentVersion>();
        system.debug('strSelectedPractice ----> ' + strSelectedPractice);
        isShowSection = false;
        if(strSelectedPractice != null && strSelectedPractice != '') {
            isShowSection = true;
            for(ContentVersion cV : [Select Id, Description, Title, FileType, Industry__c, Practice__c 
                    from ContentVersion 
                    where RecordType.DeveloperName = 'Battle_Cards' 
                    AND Practice__c =: strSelectedPractice 
                    order by Title]) {
                lstContentVersion.add(cV);
            }
        }
    }
    */
    
    public void fetchPracticeData() {
        lstContentVersion = new list<ContentVersion>();
        system.debug('strSelectedPractice ----> ' + strSelectedPractice);
        isShowSection = false;
        if(strSelectedPractice != null && strSelectedPractice != '' && mapPracticeContentVersion.containskey(strSelectedPractice)) {
            isShowSection = true;
            lstContentVersion.addAll(mapPracticeContentVersion.get(strSelectedPractice));
        }
    }
    public void closePracticeData() {
        lstContentVersion = new list<ContentVersion>();
        isShowSection = false;
        strSelectedPractice = null;
    }
    
    public void displayFilters() {
        showFilters = true;
		strSelectedPractice = null;
		isSearchComplete = false;
        lstPracticeValues = new list<string>();
    }
	
	public void clearFilters() {
		objContentVersion = new ContentVersion();
        showFilters = false;
		isSearchComplete = false;
		strSelectedPractice = null;
        fetchBattleCards();
    }
}