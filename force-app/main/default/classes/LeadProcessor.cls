global class LeadProcessor implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
        return Database.getQueryLocator('Select Id, LeadSource from Lead');
    }
    global void execute(Database.BatchableContext bc, List<Lead> scope){
        for(Lead l:scope)
            l.LeadSource = 'Dreamforce';
        update scope;
        // process each batch of records
    }    
    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }    
}