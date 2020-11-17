public with sharing class PicklistValuesChangesController {
    public string strObjectAPI {get;set;}
    public string strFieldAPI {get;set;} 
    
    public PicklistValuesChangesController() {
    	
    }
    
    public list<SelectOption> getOperationType() {
    	list<SelectOption> lstSelectOption = new list<SelectOption>();
    	lstSelectOption.add(new SelectOption('Add','Add'));
    	lstSelectOption.add(new SelectOption('Delete','Delete'));
    	lstSelectOption.add(new SelectOption('Update','Update'));
    	return lstSelectOption;
    }
    
    public void fetchPicklistFieldsForObject() {
    	
    }
}