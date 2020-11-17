@RestResource(urlMapping = '/Accounts/*/contacts')
global with sharing class AccountManager {
    @HttpGet
    global static Account getAccount() {
        RestRequest request = RestContext.request;
        string strRequestURL = request.requestURI;
        strRequestURL = strRequestURL.subString(0,strRequestURL.lastIndexOf('/'));
        String accoundId = strRequestURL.substring(
        strRequestURL.lastIndexOf('/') + 1);
        system.debug(strRequestURL);
        system.debug(accoundId);
        Account objAccount = [SELECT Id, Name, 
            (SELECT Id, Name FROM Contacts) 
        FROM Account
        WHERE Id = :accoundId];
        return objAccount;
    }
}