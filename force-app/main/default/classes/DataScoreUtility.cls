/************************************************************************
DataScoreUtility class to calculate data quality score for a given record
*************************************************************************/
public with sharing class DataScoreUtility {
    /*  VARIABLE DECLARATION    */
    //variable to make sure code is executed only once.
    public static Boolean isFirstTime = true;

    //map for field api name and corresponding score from custom metadata type
    private static map<string, Decimal> mapFieldScore;

    //Total score for all fields for object
    private static Decimal decTotalScore;

    //to check if object is valid
    @TestVisible
    private static boolean isValidObj;

    //sobject name
    private static string strSObjectName;

    /*  METHODS    */
    /*
    Method name: calculateDataScore
    Parameters:
        1. List of SObject
        2. Object API Name
        3. API Name of field to be updated
    Description: method to calculate data score for record. 
    */
    public static void calculateDataScore(list<SObject> lstSObject, string strObjectName, string strFieldToUpdate) {
        boolean isNoException = true;
        //check if method is executing for the first time
        if(isFirstTime) {
            //set static variable to false to avoid recursion
            isFirstTime = false;

            //initiate map for field and its score
            mapFieldScore = new map<string, Decimal>();

            //temporary variable used for calculating record score.
            Decimal decRecordScore;

            //map of sobject id and its corresponding score based on data populated in fields
            map<Id, Decimal> mapRecordIdScore = new map<Id, Decimal>();

            //check if strObjectName is not blank
            if(strObjectName != null && strObjectName != '') {
                //assign strObjectName to class variable. to be used in all places.
                strSObjectName = strObjectName;

                //check if sObject is valid object.
                isValidObj = isValidSObject();
                if(isValidObj){
                    //call method to get map of fields and corresponding score from custom metadata type
                    fetchFieldByScore();
                    if(!mapFieldScore.isEmpty()) {
                        //loop through the sobject data
                        for(SObject obj : lstSObject) {
                            //initialize score variable with 0 in the beginning 
                            decRecordScore = 0;
                            //loop through map fields from mapFieldScore
                            for(string strField : mapFieldScore.keySet()) {
                                //check if field has data populated. ASSUMPTION: since custom metadata is created by Admins, we are assuming that right fields are populated here
                                if(obj.get(strField) != null) {
                                    //calculate score for the field based on score in custom metadata type for field
                                    decRecordScore += mapFieldScore.get(strField);
                                }
                            }
                            try{
                                //calculate score and put it in sobject field
                                obj.put(strFieldToUpdate, (decRecordScore * 100)/decTotalScore);
                            }catch(Exception e){
                                isNoException = false;
                                //handle exception here
                            }
                        }
                        //update data if no exception thrown
                        if(isNoException) {
                            Database.SaveResult[] dbSaveResult = Database.update(lstSObject, false);
                        }
                    }
                }
            }
        }
    }

    /*
    Method name: isValidSObject
    Return type: Boolean
    Description: method to check if object api name string is a valid SObject. 
    */
    private static boolean isValidSObject() {
        //get map of all SObjects
        Map<String, Schema.SObjectType> mapObjectDescribe = Schema.getGlobalDescribe();

        //return whether object api name is in describe map
        return mapObjectDescribe.containskey(strSObjectName);
    }

    /*
    Method name: fetchFieldByScore
    Description: method to create map of fields and their corresponding score. 
    */
    private static void fetchFieldByScore() {
        //initialize map
        mapFieldScore = new map<string, Decimal>();

        //default total score with 0
        decTotalScore = 0;

        //query data score mapping based on sObject name. Query only active records.
        for(Data_Score_Mapping__mdt dSM : [SELECT Field_API_Name__c, Field_Score__c 
                                                    FROM Data_Score_Mapping__mdt 
                                                    WHERE Is_Active__c = true 
                                                    AND Object_API_Name__c =: strSObjectName]) {
            //add data in map
            mapFieldScore.put(dSM.Field_API_Name__c, dSM.Field_Score__c);
            
            //calculate total score by adding field score
            decTotalScore += dSM.Field_Score__c;
        }
    }
}