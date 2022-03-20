trigger CaseBeforeInsertTrigger on Case (before insert) {
    CaseBeforeInsertTriggerHandler.checkStatus(Trigger.new);
}