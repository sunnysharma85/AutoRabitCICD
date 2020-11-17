/***************************************************************************
Trigger helper class Contact object
***************************************************************************/
public with sharing class ContactTriggerHandler {
    //set of Account Ids to be used for adding Contact.AccountId
    private static set<Id> setAccountId;

    //list of Contact data to be used for processing data from different methods
    private static list<Contact> lstContactData;

    //account list to update account data
    private static list<Account> lstAccount;

    private static Database.SaveResult[] dbSaveResult;

    //before insert method handler
    public static void beforeInsertHandler(List<Contact> lstContact) {

    }

    //after insert method handler
    public static void afterInsertHandler(List<Contact> lstContact, map<Id,Contact> mapDataContact) {
        //check if list of contacts is blank or has data
        if(lstContact != null && !lstContact.isEmpty()) {
            lstContactData = new list<Contact>();
            lstContactData.addAll(lstContact);
            processContactData();
        }
    }

    //before update method handler
    public static void beforeUpdateHandler(List<Contact> lstContact, map<Id,Contact> mapDataContact, map<Id,Contact> mapOldDataContact) {
    
    }

    //after update method handler
    public static void afterUpdateHandler(List<Contact> lstContact, map<Id,Contact> mapDataContact, map<Id,Contact> mapOldDataContact) {
        //check if list of contacts and map of old contact data are blank or have data
        if(lstContact != null && !lstContact.isEmpty() && mapOldDataContact != null && !mapOldDataContact.isEmpty()) {
            for(Contact objContact : lstContact) {
                if(mapOldDataContact.containsKey(objContact.Id)) {
                    Contact objOldContact = mapOldDataContact.get(objContact.Id);
                    if(objOldContact.AccountId != objContact.AccountId) {
                        if(objContact.AccountId != null) {
                            setAccountId.add(objContact.AccountId);
                        }
                        if(objOldContact.AccountId != null) {
                            setAccountId.add(objOldContact.AccountId);
                        }
                    }
                }
            }
            if(!setAccountId.isEmpty()) {
                processAccountWithContactCount();
            }
        }
    }

    //before delete method handler
    public static void beforeDeleteHandler(List<Contact> lstContact, map<Id,Contact> mapDataContact) {
    
    }

    //after delete method handler
    public static void afterDeleteHandler(List<Contact> lstContact, map<Id,Contact> mapDataContact) {
        //check if list of contacts is blank or has data
        if(lstContact != null && !lstContact.isEmpty()) {
            lstContactData = new list<Contact>();
            lstContactData.addAll(lstContact);
            processContactData();
        }
    }

    //after undelete method handler
    public static void afterUnDeleteHandler(List<Contact> lstContact, map<Id,Contact> mapDataContact) {
        //check if list of contacts is blank or has data
        if(lstContact != null && !lstContact.isEmpty()) {
            lstContactData = new list<Contact>();
            lstContactData.addAll(lstContact);
            processContactData();
        }
    }

    //process contact from different helper methods 
    private static void processContactData() {
        //initialize set of account id
        setAccountId = new set<Id>();
        //loop through list of contacts. blank check not required as the method and list are private and are processed through parent public methods
        for(Contact objContact : lstContactData) {
            //check if contact record has account populated
            if(objContact.AccountId != null) {
                //add account id in set
                setAccountId.add(objContact.AccountId);
            }
        }
        //check if set of account ids is not blank
        if(!setAccountId.isEmpty()) {
            //call method to update accounts
            processAccountWithContactCount();
        }
    }

    //process set of account id and calculate contact count. update account records with contact count
    private static void processAccountWithContactCount() {
        //initialize account list
        lstAccount = new list<Account>();

        //map of account id and contact count. to be created from aggregate soql
        map<Id, Integer> mapAccountIdContactCount = new map<Id, Integer>();

        //Get Account Id and Count in AggregateResult list group by Account Id and Account id in setAccountId.
        for(AggregateResult aR:[select AccountId, count(id)ContactCount from contact 
                                where accountId in : setAccountId group by AccountId]) {
            //add data to map
            mapAccountIdContactCount.put((Id)(aR.get('AccountId')), Integer.valueOf(aR.get('ContactCount')));
        }
        //loop through set of account id
        for(Id i : setAccountId) {
            //if account id is in mapAccountIdContactCount map
            if(mapAccountIdContactCount.containsKey(i)) {
                //add data to list of account with contact count
                lstAccount.add(new Account(Id = i, Number_of_Contacts__c = mapAccountIdContactCount.get(i)));
            }
            //if account id is not in mapAccountIdContactCount map, means no contact data exists for account
            else {
                //add data to list of account with 0 count
                lstAccount.add(new Account(Id = i, Number_of_Contacts__c = 0));
            }
        }

        //check if account list is not blank
        if(!lstAccount.isEmpty()) {
            updateAccountWithContactCount();
        }
    }

    //update account data method
    private static void updateAccountWithContactCount() {
        //update account data
        dbSaveResult = Database.update(lstAccount, false);
    }

    //process errors for account updates. can be a common utility method so that same method can be used throughout the org
    private static void processSaveResults() {
        map<Id, string> mapAccountIdError = new map<Id, string>();
        //string to process error messages for account update failures
        string strErrorMessage = '';
        //loop through database save results
        for (Database.SaveResult dbSR: dbSaveResult) {
            if (!dbSR.isSuccess()) {
                // Operation failed, so get all errors                
                for(Database.Error err : dbSR.getErrors()) {
                    strErrorMessage += err.getMessage() + ',';
                    System.debug('The following error has occurred.');                    
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Account fields that affected this error: ' + err.getFields());
                }
                if(strErrorMessage != '') {
                    strErrorMessage = strErrorMessage.substring(0, strErrorMessage.length()-1);
                }
                mapAccountIdError.put(dbSR.getId(), strErrorMessage);
            }
        }

        if(mapAccountIdError != null) {
            for(Contact c : lstContactData) {
                //if()
            }
        }
    }
}