import { LightningElement, api, wire } from 'lwc';

export default class LwcAccountDetail extends LightningElement {
    @api accountIdFromParent;
    @api contactCountFromParent;
}