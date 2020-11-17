trigger MaintenanceRequest on Case (after update) {
    // call MaintenanceRequestHelper.updateWorkOrders 
    MaintenanceRequestHelper.updateWorkOrders(); 
}