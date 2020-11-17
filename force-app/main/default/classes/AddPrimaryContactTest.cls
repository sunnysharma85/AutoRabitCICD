@isTest
public class AddPrimaryContactTest 
{
	@isTest 
    private static void TestList()
     {
         List<Account> lstAccount = new List <Account>();
         for(Integer i=0;i<50;i++)
         {
             lstAccount.add(new Account(BillingState = 'CA', name = 'Test'+i));
         }
         for(Integer j=0;j<50;j++)
         {
             lstAccount.add(new Account(BillingState = 'NY', name = 'Test'+j));
         }
         insert lstAccount;

         Contact objContact = new Contact();
         objContact.FirstName='demo';
         objContact.LastName ='demo';
         insert objContact;
         String state = 'CA';
      
          AddPrimaryContact objAPC = new AddPrimaryContact(objContact, state);
          Test.startTest();
          System.enqueueJob(objAPC);
          Test.stopTest();
      }
 }