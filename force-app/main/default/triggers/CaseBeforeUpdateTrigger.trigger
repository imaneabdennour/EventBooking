trigger CaseBeforeUpdateTrigger on Case (before update, after update) {
    CaseBeforeUpdateTriggerHandler.sendEmail(Trigger.newMap.keySet());
}