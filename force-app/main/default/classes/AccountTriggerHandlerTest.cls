@IsTest
public class AccountTriggerHandlerTest {
    @IsTest
    static void testHandleAfterInsertOrUpdate() {       

        user u =[select id,name from user where id='0055i00000AklgE'];
        system.runAs(u){
        //create account with the required fields
        Account ac= new Account();
        ac.Name='test';
        ac.Active__c=TRUE;
        ac.Account_Activation_Summary__c='TESTING';
        ac.Type='Customer';
        Test.startTest();
        insert ac;     
        //create default contact after account creation
        contact ct= new contact();
        ct.AccountId=ac.id;
        ct.FirstName='TEST12';
        ct.LastName='test21';       
        insert ct;
        Test.stopTest();
        
    }
    }
}