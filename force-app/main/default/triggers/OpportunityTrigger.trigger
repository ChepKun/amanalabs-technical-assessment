trigger OpportunityTrigger on Opportunity (after insert, after update) {
    OpportunityTriggerHandler.execute();
}
