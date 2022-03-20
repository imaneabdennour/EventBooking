public class CaseBeforeUpdateTriggerHandler {
    @future (callout=true)  
    public static void sendEmail(Set<Id> caseIds){
        //Boolean requestSentToExternalSystem = false;
        //Integer i=0;

        for(Case r : [SELECT AccountId, Status FROM Case where id = :caseIds]){
            if(r.Status == 'Closed'){
                ExternalSystemService service = new ExternalSystemService();
                service.registerAttendees(r);
            }
        }           
    }
}
