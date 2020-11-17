/************************************************************************
Class to create test data. 
*************************************************************************/
@istest
public with sharing class TestDataFactory {
    /*  VARIABLE DECLARATION    */
    //list for creating test account records
    private static list<Account> lstAccount;

    //list for creating test user records
    private static list<User> lstUser;

    /*  METHODS    */
    /*
    Method name: createTestUsers
    Parameters:
        1. Integer to define how many records to be created
    Return Type: List of user object
    Description: method to create test user data. 
    */
    public static list<User> createTestUsers(integer intNumberOfRecords) {
        //check if user list is blank. in case users were already created.
        if(lstUser == null) {
            //check if method parameters is not null
            if(intNumberOfRecords != null) {
                //initialize user list
                lstUser = new list<User>();

                //get profile and roles. for testing, get standard admin profile and ceo role.
                Profile objProfile = [SELECT Id FROM Profile WHERE Name='System Administrator' limit 1]; 
                UserRole objUserRole = [Select Id from UserRole where Name = 'CEO' limit 1];

                //for loop to add data to user list
                for(integer i=0; i<intNumberOfRecords; i++) {
                    lstUser.add(new User(lastname = 'test lastname ' + i, username='zzztestuser@datascoreutility.com' + i, email='zzztestuser@datascoreutility.com' + i,
                    UserRoleId = objUserRole.Id, profileid=objProfile.Id, Alias='test', CommunityNickname='testNew', TimeZoneSidKey='America/New_York', LocaleSidKey='en_US', EmailEncodingKey='ISO-8859-1', LanguageLocaleKey='en_US', IsActive=true));
                }
            }
        }
        //return user list. DML will be executed in actual method so that developer can make more changes if needed.
        return lstUser;
    }

    /*
    Method name: createTestAccounts
    Parameters:
        1. Integer to define how many records to be created
    Return Type: List of account object
    Description: method to create test account data. 
    */
    public static list<Account> createTestAccounts(integer intNumberOfRecords) {
        //check if account list is blank. in case accounts were already created.
        if(lstAccount == null) {
            //check if method parameters is not null
            if(intNumberOfRecords != null) {
                //initialize account list
                lstAccount = new list<Account>();

                //for loop to add data to account list
                for(integer i=0; i<intNumberOfRecords; i++) {
                    lstAccount.add(new Account(Name = 'test Account ' + i, AnnualRevenue = i));
                } 
            }
        }
        //return account list. DML will be executed in actual method so that developer can make more changes if needed.
        return lstAccount;
    }
}