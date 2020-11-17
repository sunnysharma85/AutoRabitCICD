public with sharing class LWCWizardController {
    public LWCWizardController() {

    }

    @AuraEnabled (cacheable=true) 
    public static list<string> getAccountFields(){
        list<string> lstString = new list<string>();
        lstString.add('Name');
        lstString.add('BillingCountry');
        lstString.add('Industry');
        return lstString;
    }
}