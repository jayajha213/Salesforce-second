public class AccountBatchProcessor implements Database.Batchable<SObject> {
    
    // Start method: Defines the query for the batch job
    public Database.QueryLocator start(Database.BatchableContext BC) {
        // Query all accounts that haven't been processed yet
        return Database.getQueryLocator([SELECT Id, Processed__c FROM Account WHERE Processed__c = false]);
    }

    // Execute method: Processes each batch of records
    public void execute(Database.BatchableContext BC, List<Account> scope) {
        // Iterate over the scope (list of Account records)
        for (Account acc : scope) {
            acc.Processed__c = true; // Mark the account as processed
        }
        // Update the records
        update scope;
    }

    // Finish method: Executed after all batches are processed
    public void finish(Database.BatchableContext BC) {
        // Optionally, send a notification, create a log entry, etc.
        System.debug('Batch processing complete.');
    }
}