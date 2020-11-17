public class AddPrimaryContact implements Queueable
{
    private Contact objContact;
    private String strState;
    public  AddPrimaryContact(Contact objContact, String strState)
    {
        this.objContact = objContact;
        this.strState = strState;
    }
    public void execute(QueueableContext context) 
    {
         List<Account> lstAccount = [SELECT ID, Name ,(Select id,FirstName,LastName from contacts ) FROM ACCOUNT WHERE BillingState = :strState LIMIT 200];
         List<Contact> lstContact = new List<Contact>();
         for (Account acc:lstAccount)
         {
                 Contact objC = objContact.clone(false,false,false,false);
                 objC.AccountId =  acc.id;
                 lstContact.add(objC);
         }
         
         if(lstContact.size() > 0)
         {
             insert lstContact;
         }
             
    }

}