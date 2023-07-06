@IsTest
private class OpportunityTriggerTest {

    private static final Integer DEFAULT_AMOUNT = 10000;
    private static final Integer STANDARD_COUNT = 10;
    private static final Integer RECYCLED_COUNT = 15;

    @TestSetup
    static void setup() {
        Database.insert(new List<Account> {
            new Account(Name = 'Test Account 1'),
            new Account(Name = 'Test Account 2')
        });
    }

    @IsTest
    static void calculateAmountTest() {
        List<Opportunity> opportunitiesForTest = new List<Opportunity>();
        for (Account parent : [SELECT Id FROM Account]) {
            for (Integer i = 0; i < STANDARD_COUNT; ++i) {
                opportunitiesForTest.add(new Opportunity(
                    Name = 'Test Standard Opportunity ' + parent.Id + i,
                    AccountId = parent.Id,
                    Amount = DEFAULT_AMOUNT,
                    StageName = 'Prospecting',
                    CloseDate = Date.today().addDays(30),
                    Wood_Type__c = 'Standard'
                ));
            }
            for (Integer i = 0; i < RECYCLED_COUNT; ++i) {
                opportunitiesForTest.add(new Opportunity(
                    Name = 'Test Recycled Opportunity ' + parent.Id + i,
                    AccountId = parent.Id,
                    Amount = DEFAULT_AMOUNT,
                    StageName = 'Prospecting',
                    CloseDate = Date.today().addDays(30),
                    Wood_Type__c = 'Recycled'
                ));
            }
        }

        Test.startTest();
        Database.insert(opportunitiesForTest);
        Database.update(opportunitiesForTest);
        Test.stopTest();

        for (Account testAccount : [
            SELECT Total_Sales_Standard__c, Total_Sales_Recycled__c
            FROM Account
        ]) {
            System.assertEquals(STANDARD_COUNT * DEFAULT_AMOUNT, testAccount.Total_Sales_Standard__c, 'Standard amount does not match.');
            System.assertEquals(RECYCLED_COUNT * DEFAULT_AMOUNT, testAccount.Total_Sales_Recycled__c, 'Recycled amount does not match.');
        }
    }

}
