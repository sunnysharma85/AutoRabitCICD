({
    clickCreateItem : function(component, event, helper) {
        helper.validateFields (component,component.find("name"));
        helper.validateFields (component,component.find("Price"));
        helper.validateFields (component,component.find("Quantity"));
        if(component.get("v.er") === false)
        {     
            var Item = component.get("v.newItem");            
            helper.createItem (component,Item);             
                       
        }
    },
    doInit : function(component, event, helper) {
        var action = component.get("c.getItems");
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.items", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
    }
})