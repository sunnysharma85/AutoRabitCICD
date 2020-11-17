@istest
public class AccountProcessorTest {
    @istest
    private static void AccountProcessorTestMethod() {
        Account a = new Account(name = 'test');
        insert a;
        test.startTest();
        AccountProcessor.countContacts(new list<Id>{a.Id});
        test.stopTest();
    }
}