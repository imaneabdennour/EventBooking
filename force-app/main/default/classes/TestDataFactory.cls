public abstract class TestDataFactory {
    public static Account createAccount(Integer nbrContacts){
        Account acc = new Account(Name = 'Salesforce'); 
        insert acc;

        List<Contact> contacts = new List<Contact>();
        for(Integer i=1; i<=nbrContacts; i++){
            Contact c = new Contact(LastName = 'Contact ' + i, AccountId = acc.ID);
            contacts.add(C);
        }   
        insert contacts;
        return acc;
    }
}
