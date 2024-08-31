@isTest
public class AccountBatchProcessorTest {
    
    @testSetup
    static void setup() {
        // Create test data
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 200; i++) {
            accounts.add(new Account(Name = 'Test Account ' + i, Processed__c = false));
        }
        insert accounts;
    }

    @isTest
    static void testBatchProcessing() {
        // Verify that no accounts are processed initially
        Integer unprocessedCount = [SELECT COUNT() FROM Account WHERE Processed__c = false];
        System.assertEquals(200, unprocessedCount);
        
        // Execute the batch job
        AccountBatchProcessor batch = new AccountBatchProcessor();
        Database.executeBatch(batch, 50); // Execute with a batch size of 50

        // Verify that all accounts are now processed
        Integer processedCount = [SELECT COUNT() FROM Account WHERE Processed__c = true];
        System.assertEquals(200, processedCount);
    }
}