import { LightningElement,wire,track } from 'lwc';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
export default class LwcAccountSearch extends LightningElement {
    //@wire(getPicklistValues, { fieldApiName: INDUSTRY_FIELD })
    @track industryValue;
    @track accName;
    @wire(getObjectInfo, { objectApiName: ACCOUNT_OBJECT })
    objectInfo;
    @wire(getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: INDUSTRY_FIELD})
    IndustryPicklistValues;

    handleIndustryChange(event) {
        this.industryValue = event.detail.value;
    }

    handleAccountNameChange(event) {
        this.accName = event.detail.value;
    }

    handleSearch(event) {
        //console.log(this.industryValue);
        //console.log(this.accName);
        var selectedEvent = new CustomEvent('accountsearchevent', { detail:  {accountIndustry : this.industryValue, accountNameSearch : this.accName}});
        // dispatch the event.
        this.dispatchEvent(selectedEvent);
    }
}