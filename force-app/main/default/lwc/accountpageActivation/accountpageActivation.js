import { LightningElement, api, wire } from 'lwc';
import { updateRecord, getRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import IS_ACCOUNT_ACTIVATED_FIELD from '@salesforce/schema/Account.Active__c';

const ACCOUNT_FIELDS = [IS_ACCOUNT_ACTIVATED_FIELD];

export default class AccountpageActivation extends LightningElement {
    @api recordId; // Receives the record Id of the Account

    isAccountActivated = false; // Tracks the activation status of the Account

    @wire(getRecord, {
        recordId: '$recordId',
        fields: ACCOUNT_FIELDS
    })
    account; // Fetches the Account record data using the wire service

    // Handles the button click event
    handleActivate() {
        if (this.isAccountActivated) {
            // If Account is already activated, show a warning toast message
            this.showToast('Warning', 'Account is already activated.', 'warning');
        } else {
            // Otherwise, activate the Account
            this.activateAccount();
        }
    }

    // Activates the Account by updating the record
    activateAccount() {
        const fields = {};
        fields.Id = this.recordId;
        fields.Active__c = true; // Set Active__c field to true for activation

        const recordInput = { fields };

        updateRecord(recordInput)
            .then(() => {
                this.isAccountActivated = true; // Update the activation status
                this.showToast('Success', 'Account activated successfully.', 'success');
            })
            .catch(error => {
                console.error('Error:', error);
            });
    }

    // Displays a toast message with the specified title, message, and variant
    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(event);
    }

    // Computed property to determine whether to show the activation button
    get showActivateButton() {
        return true; // Always returns true to show the activation button
    }
}