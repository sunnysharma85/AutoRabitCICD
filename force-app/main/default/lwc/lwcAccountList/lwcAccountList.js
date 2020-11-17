import { LightningElement, api, wire, track } from 'lwc';
import getAccountSearchResults from '@salesforce/apex/LWCAccountSearchController.getAccounts';
//variant: 'border-filled',
const columns = [{
        label: 'View',
        type: 'button-icon',
        initialWidth: 75,
        typeAttributes: {
            iconName: 'action:preview',
            title: 'Preview',
            
            alternativeText: 'View'
        }
    },
    { label: 'Name', fieldName: 'Name' },
    { label: 'Industry', fieldName: 'Industry' },
    { label: 'Account Number', fieldName: 'AccountNumber' },
    { label: 'Annual Revenue', fieldName: 'AnnualRevenue' },];

export default class LwcAccountList extends LightningElement {
    @api accountIndustryFromParent;
    @api accountNameFromParent;
    columns = columns;
    @track accdata=[];
    @track error;

    @wire(getAccountSearchResults,{accountName: '$accountNameFromParent', accountIndustry:'$accountIndustryFromParent'})
    wiredAccounts(result){
        //console.log("result data ---> " + result.data);
        this.accdata = result.data;
        this.error = result.error;
    }

    handleAccountRowAction(event) {
        var selectedEvent = new CustomEvent('accountdetailevent', { detail:  {accountId : event.detail.row.Id}});
        // dispatch the event.
        this.dispatchEvent(selectedEvent);
    }
}