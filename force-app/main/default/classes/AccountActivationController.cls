public with sharing class AccountActivationController {
    @AuraEnabled(cacheable=true)
    public static Account getAccountById(String recordId) {
        return [SELECT Active__c FROM Account WHERE Id = :recordId];
    }
}