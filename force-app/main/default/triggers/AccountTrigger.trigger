trigger AccountTrigger on Account (after insert) {
    DataScoreUtility.calculateDataScore([Select 
AccountNumber,
AnnualRevenue,
BillingCity,
BillingCountry,
BillingPostalCode,
BillingState,
BillingStreet,
DunsNumber,
Fax,
Industry,
Name,
NumberOfEmployees,
ParentId,
Phone,
Rating,
ShippingCity,
ShippingCountry,
ShippingPostalCode,
ShippingState,
ShippingStreet,Type,
Website,Id from account where id in: trigger.newmap.keyset()], 'Account', 'Data_Score__c');
}