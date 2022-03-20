public class CaseBeforeInsertTriggerHandler {
    public static void checkStatus(List<Case> triggerNew){

        for(Case c : triggerNew){
            if(c != null && c.AccountId != null){
                Account account =  [SELECT ID, (select id from contacts) FROM Account where id = :c.AccountId LIMIT 1];
                Integer s = account.Contacts.size();

                if(s == 0){
                    c.addError('You cannot create a request for accounts without contacts');
                }   
                else {
                    switch on c.Origin {
                        when 'Web' {
                            if(s >= 2 ){
                                c.addError('Web request are only allowed to have one attendee');
                            }
                        }
                        when 'Phone'{
                            if(s >= 4 ){
                                c.addError('Phone request are only allowed to have three attendee');
                            }
                        }
                    }                                   
                }
            }
            else {
                c.addError('You cannot create a request without attaching an account');
            }
        }
    }
}

