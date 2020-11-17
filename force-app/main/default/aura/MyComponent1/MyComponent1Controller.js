({
NavigatetoC2 : function(component, event, helper) {
var evt = $A.get("e.force:navigateToComponent");
evt.setParams({
componentDef : "c:MyComponent2",
componentAttributes: {
 
}
});
    console.log(evt);
evt.fire();
}
})