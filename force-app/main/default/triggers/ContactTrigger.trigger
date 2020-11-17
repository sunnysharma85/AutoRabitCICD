/***************************************************************************
Contact Trigger executed when a DML operation is performed on Contact object
***************************************************************************/
trigger ContactTrigger on Contact(before insert, after insert, before update, after update, before delete, after delete, after undelete) {
    //check if trigger executing in before event
    if(trigger.isBefore) {
        //check if trigger executed for insert event
        if(trigger.isInsert) {
            //call trigger handler method for before insert
            ContactTriggerHandler.beforeInsertHandler(Trigger.new);
        }

        //check if trigger executed for update event
        if(trigger.isUpdate) {
            //call trigger handler method for before update
            ContactTriggerHandler.beforeUpdateHandler(Trigger.new, Trigger.newMap, Trigger.oldMap);
        }

        //check if trigger executed for delete event
        if(trigger.isDelete) {
            //call trigger handler method for before delete
            ContactTriggerHandler.beforeDeleteHandler(Trigger.old, trigger.oldMap);
        }
    }
    //check if trigger executed for after event
    if(trigger.isAfter){
        //check if trigger executed for insert event
        if(trigger.isInsert) {
            //call trigger handler method for after insert
            ContactTriggerHandler.afterInsertHandler(Trigger.new, Trigger.newMap);
        }

        //check if trigger executed for update event
        if(trigger.isUpdate) {
            //call trigger handler method for after update
            ContactTriggerHandler.afterUpdateHandler(Trigger.new, Trigger.newMap, Trigger.oldMap);
        }

        //check if trigger executed for delete event
        if(trigger.isDelete) {
            //call trigger handler method for after delete
            ContactTriggerHandler.afterDeleteHandler(Trigger.old, Trigger.oldMap);
        }

        //check if trigger executed for undelete event
        if(trigger.isUndelete) {
            //call trigger handler method for after undelete
            ContactTriggerHandler.afterUndeleteHandler(Trigger.new, Trigger.newMap);
        }
    }
}