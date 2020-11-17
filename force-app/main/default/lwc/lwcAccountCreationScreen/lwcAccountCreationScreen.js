import { LightningElement, wire, api, track } from 'lwc';
import getAccountFields from '@salesforce/apex/LWCWizardController.getAccountFields';
export default class LwcAccountCreationScreen extends LightningElement {
    @track accountFields;
    @api accountId;
    @api jsonAccountString;
    @wire(getAccountFields)
    accountFields;

    handleSuccess(event) {}

    handleSubmit(event) {}

    handleError(event) {}
}