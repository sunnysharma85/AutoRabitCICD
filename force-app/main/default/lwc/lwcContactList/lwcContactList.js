import { LightningElement, api, wire } from 'lwc';
import getAccountsContacts from '@salesforce/apex/LWCAccountSearchController.getAccountsContacts';
const columns = [
    { label: 'First Name', fieldName: 'FirstName', editable: true },
    { label: 'Last Name', fieldName: 'LastName', editable: true },
    { label: 'Email', fieldName: 'Email', editable: true },
];
export default class LwcContactList extends LightningElement {
    @api accountIdFromParent;
    contactData = [];
    columns = columns;
    rowOffset = 0;
    @wire(getAccountsContacts,{idAccount: '$accountIdFromParent'})
    wiredContacts(result){
        console.log("result data ---> " + result.data);
        this.contactData = result.data;
        this.error = result.error;
    }
}