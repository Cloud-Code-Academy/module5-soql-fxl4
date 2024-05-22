List<Lead> leadList = [SELECT Id, Email FROM Lead];
// Create a set of email domains from the Leads
List<String> emailDomains = new List<String>();
String currentEmail;

// Loop through each Lead
for (Lead lead : leadList) {

        // Get the email from the Lead
        currentEmail = lead.email;

                // Check if the email is not null
                if (currentEmail != '' && currentEmail != null){
                        // Add the email domain to the set
                        emailDomains.add(currentEmail);
                }
        }

for (String domain : emailDomains) {
        domain = domain.substringAfter('@');
        System.debug(domain);
}

List<Account> nonNullWebsites = [SELECT Id, Name, Website FROM Account WHERE Website != null];

for (Account nonNull : nonNullWebsites) {
        for (Integer i = 0; i < emailDomains.size(); i++) {

        }
}
System.debug(franksTest);