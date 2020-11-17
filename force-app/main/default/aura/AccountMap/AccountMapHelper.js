({
    navigateToDetailsView : function(accountId) {
        var event = $A.get("e.force:navigateToSObject");
        console.log(event);
        console.log(accountId);
        event.setParams({
            "recordId": accountId
        });
        event.fire();
    }
})