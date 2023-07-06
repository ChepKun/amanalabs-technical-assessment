public with sharing class OpportunityTriggerHandler {

    private static final Map<String, SObjectField> WOOD_TYPE_TO_AMOUNT = new Map<String, SObjectField> {
        'Standard' => Account.Total_Sales_Standard__c,
        'Recycled' => Account.Total_Sales_Recycled__c
    };

    /**
     * Using the same calculator instance for all trigger chunks
     */
    private static final AmountCalculator AMOUNT_CALCULATOR = new AmountCalculator();

    public static void execute() {
        if (Trigger.isAfter) {
            if (Trigger.isInsert || Trigger.isUpdate) {
                AMOUNT_CALCULATOR.execute(Trigger.new, (Map<Id, Opportunity>)Trigger.oldMap);
            }
        }
    }

    /**
     * Note: Using `without sharing` keyword to get access to all records in a database.
     */
    private without sharing class AmountCalculator {

        public void execute(List<Opportunity> records, Map<Id, Opportunity> oldRecords) {
            Set<Id> accountIds = new Set<Id>();
            for (Opportunity record : records) {
                Opportunity oldRecord = oldRecords?.get(record.Id);
                if (oldRecord?.Wood_Type__c == record.Wood_Type__c &&
                        oldRecord?.AccountId == record.AccountId &&
                            oldRecord?.Amount == record.Amount) {
                    continue;
                }
                if (!WOOD_TYPE_TO_AMOUNT.containsKey(record.Wood_Type__c) &&
                        !WOOD_TYPE_TO_AMOUNT.containsKey(oldRecord?.Wood_Type__c)) {
                    continue;
                }
                Id accountId = String.isBlank(record.AccountId) ? oldRecord?.AccountId : record.AccountId;
                if (String.isBlank(accountId) || accountIds.contains(accountId)) {
                    continue;
                }
                accountIds.add(accountId);
            }
            this.calculate(accountIds);
        }

        private void calculate(Set<Id> accountIds) {
            if (accountIds.isEmpty()) {
                return;
            }
            Map<Id, Account> accountsToUpdate = new Map<Id, Account>();
            for (AggregateResult result : [
                SELECT AccountId, Wood_Type__c, SUM(Amount) TotalAmount
                FROM Opportunity
                WHERE AccountId IN :accountIds AND Wood_Type__c IN :WOOD_TYPE_TO_AMOUNT.keySet()
                WITH SECURITY_ENFORCED
                GROUP BY AccountId, Wood_Type__c
            ]) {
                Id accountId = (Id)result.get(String.valueOf(Opportunity.AccountId));
                String woodType = (String)result.get(String.valueOf(Opportunity.Wood_Type__c));
                Decimal totalAmount = (Decimal)result.get('TotalAmount');
                Account accountToUpdate = null;
                if (accountsToUpdate.containsKey(accountId)) {
                    accountToUpdate = accountsToUpdate.get(accountId);
                } else {
                    accountToUpdate = new Account(Id = accountId);
                    accountsToUpdate.put(accountId, accountToUpdate);
                }
                accountToUpdate.put(WOOD_TYPE_TO_AMOUNT.get(woodType), totalAmount);
            }
            Database.update(accountsToUpdate.values());
        }

    }

}
