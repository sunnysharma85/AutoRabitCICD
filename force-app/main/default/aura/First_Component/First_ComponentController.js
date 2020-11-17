({
	gotoURL : function(component, event, helper) {
		var destination ="markup://c:Second_Component";
        $A.componentService.newComponentAsync(this,
			function(view) {
			  var content = component.find("content");
			  content.set("v.body", view);
			  }, 
			  {
			     componentDef: destination,
                          }, component);
	}
})