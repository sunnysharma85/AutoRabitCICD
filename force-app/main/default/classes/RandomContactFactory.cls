public class RandomContactFactory {
    public static list<Contact> generateRandomContacts(integer counter, string strLastName) {
        list<Contact> lstContact = new list<Contact>();
        for(integer i =1; i<=counter;i++) {
            lstContact.add(new Contact(firstname = 'Test ' + i, LastName = strLastName));
        }
        return lstContact;
    }
}