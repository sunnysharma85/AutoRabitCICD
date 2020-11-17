trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
    list<Task> lstTask = new list<Task>();
    for(Opportunity o:trigger.new) {
        if((Trigger.isInsert && o.StageName == 'Closed Won') || (Trigger.isUpdate && o.StageName == 'Closed Won' && o.StageName != Trigger.oldMap.get(o.Id).StageName)) {
            lstTask.add(new Task(Subject = 'Follow Up Test Task', WhatId = o.Id));
        }
    }
    
    if(!lstTask.isEmpty()) {
        insert lstTask;
    }
}