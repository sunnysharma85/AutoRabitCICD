import { LightningElement, track, api } from 'lwc';

export default class LwcParentWizardComponent extends LightningElement {
    @track renderAccountScreen = true;
    @track renderContactScreen = false;
    @track renderOpportunityScreen = false;
    @track jsonAccountData;
    @track jsonContactData;
    @track jsonOpportunityData;
    @track currentStepName = "Account Information";
    handleAccountCreateEvent(event) {}
    handleContactCreateEvent(event) {}
    handleOpportunityCreateEvent(event) {}
}