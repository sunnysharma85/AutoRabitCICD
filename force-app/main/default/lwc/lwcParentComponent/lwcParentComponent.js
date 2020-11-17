import { LightningElement,api,wire,track } from 'lwc';

export default class LwcParentComponent extends LightningElement {
    @api accountId;
    @api accountIndustry;
    @api accountNameSearch;
    @api contactCount;
    @track renderSearch = true;
    @track renderAccountList = false;
    @track renderAccountDetail = false;
    @track renderContactList = false;

    handleAccountSearchEvent(event) {
        this.renderSearch = true;
        this.renderAccountList = true;
        this.accountIndustry = event.detail.accountIndustry;
        this.accountNameSearch = event.detail.accountNameSearch;
    }

    handleAccountDetailEvent(event) {
        this.renderSearch = false;
        this.renderAccountList = false;
        this.renderAccountDetail = true;
        this.renderContactList = true;
        this.accountId = event.detail.accountId;
    }
}