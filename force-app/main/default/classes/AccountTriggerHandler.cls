public class AccountTriggerHandler {
    public static void handleAfterInsertUpdate(List<Account> accounts, Map<Id, Account> oldMap) {
        // Create a list to store new Contact records
       List<Contact> newContacts = new List<Contact>();
        
        for (Account acc : accounts) {
            if (acc.Active__c && acc.Type == 'Customer') {
                // Check if a default contact already exists
                Boolean defaultContactExists = [SELECT COUNT() FROM Contact WHERE AccountId = :acc.Id LIMIT 1] > 0;

                // Create a default customer contact if one does not exist
                if (!defaultContactExists) {
                    Contact newContact = new Contact();
                    newContact.FirstName = acc.Name;
                    newContact.DefaultContact__c = true;
                    newContact.LastName = 'Customer Representative';
                    newContact.Email = acc.Company_Email__c;
                    newContact.Phone = acc.Phone;
                    newContact.AccountId = acc.Id;

                    newContacts.add(newContact);
                }
            }
        }

        // Insert new contacts
        if (!newContacts.isEmpty()) {
            insert newContacts;
        }
    }
}