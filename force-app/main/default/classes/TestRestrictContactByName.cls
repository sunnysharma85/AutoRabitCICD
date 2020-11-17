@isTest
public class TestRestrictContactByName {
	@isTest
    private static void TestRestrictContactByNameMethod() {
        Contact c = new Contact(LastName='INVALIDNAME');
        try {
            insert c;
        }catch(Exception e) {}
    }
}