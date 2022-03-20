public  class ExternalSystemService {

    private String webServiceURL;

    public ExternalSystemService(){
        this.webServiceURL = 'callout:animalsEndpoint';
    }

    public void registerAttendees(Case r){
            for(Account a : [SELECT id FROM Account where id = :r.AccountId]){
                for(Contact c : [SELECT id,name, email FROM Contact where accountid =: a.id ]){
                    Http http = new Http();
                    HttpRequest request = new HttpRequest();
                    request.setEndpoint(this.webServiceURL);
                    request.setMethod('POST');
                    request.setHeader('Content-Type', 'application/json;charset=UTF-8');
                    // Set the body as a JSON object
                    request.setBody('{"name":"'+ c.name + '-' + c.email  +'}');
                    HttpResponse response = http.send(request);
                    // Parse the JSON response
                    if (response.getStatusCode() != 201) {
                        r.addError('Error in post method');
                        System.debug('The status code returned was not expected: ' +
                            response.getStatusCode() + ' ' + response.getStatus());
                    } else {
                       // Everything went as expected.
                       notifyAttendeeByEmail(c);
                    }
                }
            
        }
    } 

    public void notifyAttendeeByEmail(Contact account){
      
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {c.email}; 
        mail.setToAddresses(toAddresses);
        mail.setReplyTo('support@eventBooking.com');
        mail.setSenderDisplayName('Event Booking support');

        Task tk = new Task();
        tk.Subject = 'Send Email To' + account.name;
        tk.Status = 'Open';
        tk.Priority = 'Normal';
        tk.WhatId = account.ID;
        insert tk;

        mail.setSubject('New Task Created');
        mail.setPlainTextBody('Your Task: ' + tk.Id +' has been created.');

        mail.setHtmlBody('Your task:<b> ' + tk.Id +' </b>has been created.<p>');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

    } 


}
