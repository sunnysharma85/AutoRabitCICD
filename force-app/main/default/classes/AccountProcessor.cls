public class AccountProcessor {
    @future
    public static void countContacts(list<Id> lstAccountId) {
        /*list<Account> lstAccountToUpdateCount = new list<Account>();
        for(Account a:[Select Id, Number_of_Contacts__c, (Select Id from Contacts) from Account where id in : lstAccountId]) {
            lstAccountToUpdateCount.add(new Account(Id = a.Id, Number_of_Contacts__c = a.Contacts.size()));
        }
        
        update lstAccountToUpdateCount;*/
    }
}