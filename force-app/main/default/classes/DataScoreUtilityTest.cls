/************************************************************************
Test class for DataScoreUtility class
*************************************************************************/
@istest
private class DataScoreUtilityTest {
    //setup test data for test class
    @testSetup static void testSetupData() {
        //create one test user
        list<User> lstTestUser = TestDataFactory.createTestUsers(1);
        insert lstTestUser;
        //run as test user
        System.runAs(lstTestUser[0]) {
            //create test account records
            list<Account> lstTestAccount = TestDataFactory.createTestAccounts(200);
            insert lstTestAccount;
            //assert to check number of accounts created
            system.assertEquals(200, [select count() from Account]);
        }
    }

    /*
    Method name: testAccountDataScoreUtilityPositive
    Description: run positive scenarios test. 
    */
    @istest
    private static void testAccountDataScoreUtilityPositive() {
        //get test user for setting context.
        User objUser = new User();
        objUser = [select Id from User limit 1];

        //get account fields to create SOQL
        Map<String, Schema.SObjectField> mapAccountFields = Schema.getGlobalDescribe().get('Account').getDescribe().fields.getMap();
        list<string> lstFields = new list<string>();
        lstFields.addAll(mapAccountFields.keySet());

        //create SOQL for Account object
        string strQuery = 'SELECT ' + String.join( lstFields, ', ') + ' FROM Account';

        //start test
        test.startTest();

        //set user context
        System.runAs(objUser) {
            //execute method
            DataScoreUtility.calculateDataScore(Database.query(strQuery), 'Account', 'Data_Score__c');

            //check assert to make sure object is valid
            system.assertEquals(true, DataScoreUtility.isValidObj);

            //execute for loop SOQL
            for(Account objAccount : [Select Data_Score__c from Account]) {
                //validate that the data score field is not 0
                system.assertNotEquals(0, objAccount.Data_Score__c);
            }
        }
        //stop test
        test.stopTest();
    }

    /*
    Method name: testAccountDataScoreUtilityNegative
    Description: run negative scenarios test. 
    */
    @istest
    private static void testAccountDataScoreUtilityNegative() {
        //get test user for setting context.
        User objUser = new User();
        objUser = [select Id from User limit 1];

        //get account fields to create SOQL
        Map<String, Schema.SObjectField> mapAccountFields = Schema.getGlobalDescribe().get('Account').getDescribe().fields.getMap();
        list<string> lstFields = new list<string>();
        lstFields.addAll(mapAccountFields.keySet());

        //create SOQL for Account object
        string strQuery = 'SELECT ' + String.join( lstFields, ', ') + ' FROM Account';

        //start test
        test.startTest();

        //set user context
        System.runAs(objUser) {
            //execute method with invalid sobject name and invalid field
            DataScoreUtility.calculateDataScore(Database.query(strQuery), 'Accounts', 'zzzField');

            //assert statement to check if sobject is valid
            system.assertEquals(false, DataScoreUtility.isValidObj);

            //execute method with valid sobject name and invalid field
            DataScoreUtility.calculateDataScore(Database.query(strQuery), 'Account', 'zzzField');
            for(Account objAccount : [Select Data_Score__c from Account]) {
                //validate that the data score field is blank. Assumption is that no default value is set for Data score field. 
                system.assertEquals(null, objAccount.Data_Score__c);
            }
        }
        //stop test
        test.stopTest();
    }
}