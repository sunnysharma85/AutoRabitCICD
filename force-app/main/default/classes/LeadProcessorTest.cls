@isTest
private class LeadProcessorTest {
    @testSetup
    static void setup() {
        List<Lead> lstLead = new List<Lead>();
        for (Integer i=0;i<200;i++) {
            lstLead.add(new Lead(lastname='Lead '+i, Company ='Company '+i));
        }
        insert lstLead;
        // find the account just inserted. add contact for each
        
    }
    static testmethod void test() {        
        Test.startTest();
        LeadProcessor lp = new LeadProcessor();
        Id batchId = Database.executeBatch(lp);
        Test.stopTest();
    }
}