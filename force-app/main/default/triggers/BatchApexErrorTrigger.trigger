trigger BatchApexErrorTrigger on BatchApexErrorEvent (after insert) {
    list<BatchLeadConvertErrors__c> lstBatchLeadConvertErrors = new list<BatchLeadConvertErrors__c>();
    for(BatchApexErrorEvent bAEE : Trigger.new) {
        lstBatchLeadConvertErrors.add(new BatchLeadConvertErrors__c(AsyncApexJobId__c = bAEE.AsyncApexJobId,
                                                                   Records__c = bAEE.JobScope,
                                                                   StackTrace__c = bAEE.StackTrace));
    }
    if(!lstBatchLeadConvertErrors.isEmpty()) {
        insert lstBatchLeadConvertErrors;
    }
}