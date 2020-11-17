public with sharing class LWCAccountSearchController {
    public LWCAccountSearchController() {

    }

    @AuraEnabled (cacheable=true) 
    public static list<Contact> getAccountsContacts(string idAccount){
        List<Contact> lstContact = new list<Contact>();
        if(idAccount != null && idAccount != '')
        lstContact = [Select Id, FirstName, LastName, email from Contact where AccountId =: idAccount];
        return lstContact;
    }

    @AuraEnabled (cacheable=true) 
    public static list<Account> getAccounts(string accountName, string accountIndustry) {
        system.debug('accountName ----> ' + accountName);
        system.debug('accountIndustry ----> ' + accountIndustry);
        list<Account> lstAccount = new list<Account>();
        string searchString = '%%';
        if(accountName != null && accountName != '')
            searchString = '%' + accountName + '%';
        string strQuery = 'Select id, Name, Industry, AccountNumber, AnnualRevenue FROM Account WHERE name like: searchString ';
        if(accountIndustry != null) 
            strQuery += ' AND Industry =: accountIndustry';
        system.debug('strQuery ' + strQuery);
        return Database.query(strQuery);
    }

    @AuraEnabled(cacheable=true)
    public static integer getContactCountForAccount(string idAccount){
        integer contactCount = 0;
        if(idAccount != null && idAccount != '')
            contactCount = [Select count() from Contact where AccountId =: idAccount];
        return contactCount;
    }
}