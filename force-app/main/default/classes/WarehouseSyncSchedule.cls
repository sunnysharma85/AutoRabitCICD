public with sharing class WarehouseSyncSchedule implements Schedulable{
    public void execute(SchedulableContext SC)
    {
        WarehouseCalloutService.runWarehouseEquipmentSync();
    }
}