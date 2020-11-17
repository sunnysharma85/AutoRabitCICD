public with sharing class WarehouseCalloutService {

    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';
    @future(callout = true)
    public static void runWarehouseEquipmentSync() {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(WAREHOUSE_URL);
        req.setMethod('GET');

        Http http = new Http();
        HTTPResponse res = http.send(req);
        System.debug(res.getBody());
        if (res.getStatusCode() == 200) {
            // Deserialize the JSON string into collections of primitive data types.
            List < Object > equipments = (List < Object > ) JSON.deserializeUntyped(res.getBody());
            List < Product2 > products = new List < Product2 > ();
            for (Object o: equipments) {
                Map < String,
                Object > mapProduct = (Map < String, Object > ) o;
                Product2 product = new Product2();
                product.Name = (String) mapProduct.get('name');
                product.Cost__c = (Integer) mapProduct.get('cost');
                product.Current_Inventory__c = (Integer) mapProduct.get('quantity');
                product.Maintenance_Cycle__c = (Integer) mapProduct.get('maintenanceperiod');
                product.Replacement_Part__c = (Boolean) mapProduct.get('replacement');
                product.Lifespan_Months__c = (Integer) mapProduct.get('lifespan');
                product.Warehouse_SKU__c = (String) mapProduct.get('sku');
                product.ProductCode = (String) mapProduct.get('_id');
                products.add(product);
            }
            if (products.size() > 0) {
                System.debug(products);
                upsert products Warehouse_SKU__c;
            }
        }
    }
}