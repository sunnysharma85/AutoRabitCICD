@isTest
private class AccountManagerTest {
    @isTest static void testAccountManager() {
        Account objAccount = new Account(Name = 'test account');
        insert objAccount;
        
        Contact objContact = new Contact(lastname='test', AccountId = objAccount.Id);
        insert objContact;
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://skuidss-dev-ed.salesforce.com/services/apexrest/Accounts/'
            + objAccount.Id +'/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        AccountManager.getAccount();
        
    }
}