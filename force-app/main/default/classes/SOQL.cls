/**
* The SOQL class serves as a primer into the Salesforce Object Query Language in Apex.
* It covers fundamental aspects such as SELECT statements, WHERE clauses, Relationship queries, and LIMIT keyword.
*
* This class introduces developers to the concept of retrieving data from Salesforce using SOQL. It provides
* a step-by-step guide on how to construct SOQL queries, filter results using WHERE clause, retrieve related
* records, and manage data volume using the LIMIT keyword.
* 
* Topics covered in this class include:
* - Understanding the structure of a SOQL query.
* - Crafting basic SELECT statements in SOQL.
* - Applying filters using the WHERE clause in SOQL.
* - Fetching related records using Relationship queries.
* - Controlling the amount of data retrieved using the LIMIT keyword.
* 
* Users of this class can expect to gain a solid understanding of SOQL in Apex and
* be prepared to handle data retrieval tasks in Salesforce development.
* 
* @author Frank Larkin
*/

public with sharing class SOQL {
    
    /**
     * Question 1
     * Update/Uncomment the template code to create a method
     * Returns all leads from Salesforce Org
     * @return List of all leads with Id, LastName, Company, Phone, Email
     * Update the corresponding test class and testGetAllLeads method to cover this method
     */
    
    public static List<Lead> getAllLeads () {
        List <Lead> leads = [SELECT Id, LastName, Company, Phone, Email FROM Lead];
        return leads;
    }

    /**
     * Question 2
     * Update/Uncomment the template code to create a method
     * Returns all contacts with first name of John.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByFirstName method to cover this method
     */
    //[public | private ] [static] data_type method_name (input parameters) {
    //  The body of the method
    //}

    public static List<Contact> getContactsNamedJohn () {
        List <Contact> contactsNamedJohnList = [SELECT Id, Name FROM Contact WHERE FirstName = 'John'];
        return contactsNamedJohnList;
    }

    /**
     * Question 3
     * Update/Uncomment the template code to create a method
     * Returns the Contact Id for all contacts with last name of Smith or Jones
     * @return A list of Contact Ids.
     * Update the corresponding test class and testGetContactIdsByLastName method to cover this method
     */
    
    public static List<Id> getLastNameIsSmithOrJones () {
        List<Contact> lastNameIsSmithOrJonesList = [SELECT Id FROM Contact WHERE LastName = 'Jones' or LastName = 'Smith'];
        List<Id> lastNameIds = new List<Id>();
        for (Integer i = 0; i < lastNameIsSmithOrJonesList.size(); i++) {
            lastNameIds.add(lastNameIsSmithOrJonesList[i].Id);
        }
        return lastNameIds;
    }

    /**
     * Question 4
     * Update/Uncomment the template code to create a method
     * Returns List of closed won opportunities for a specific Account.
     * Example: yourMethodName('001XXXXXXXXXXXX') should return the list of closed won opportunities for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Opportunities with important opportunities fields
     * Update the corresponding test class and testGetClosedWonOpportunityCountByAccount method to cover this method
     */

    public static List<Opportunity> accountsClosedWonOpps (String accountId) {
        List<Opportunity> closedOppList = [SELECT Name, AccountID, StageName, CloseDate, Amount FROM Opportunity WHERE AccountID = :accountId AND StageName = 'Closed Won'];
        return closedOppList;
    }

    /**
     * Question 5
     * Update/Uncomment the template code to create a method
     * Returns the total count of Account records.
     * @return The Integer count of Account records.
     * Update the corresponding test class and testGetAccountCount method to cover this method
     */

    public static Integer howManyAccountRecords() {
        List<Account> accountList = [SELECT Id, Name FROM Account];
        return accountList.size();
    }

    /**
     * Question 6
     * Update/Uncomment the template code to create a method
     * Return Key Value pair of Task Id and Task records for any tasks due date within the next 7 days.
     * @return A map of Task Ids to Task records.
     * Update the corresponding test class and testGetTasksDueNextWeek method to cover this method
     */

    public static Map<Id,Task> returnTasks() {
        //  The body of the method
        List<Task> taskList = [SELECT Id, ActivityDate FROM Task WHERE ActivityDate = Next_N_Days:7];
        Map<Id,Task> franksMap = new Map<Id,Task>();
        for (Task task : taskList) {
            franksMap.put(task.id,task);
        }
        return franksMap;
    }

    /**
     * Question 7
     * Update/Uncomment the template code to create a method
     * Retrieves all Contacts that have a example.com domain in their Email.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByEmailDomain method to cover this method
     */

    public static List<Contact> returnExampleContacts() { 
        List<Contact> franksList = [SELECT Id, Name, Email FROM Contact WHERE Email Like '%example.com'];
        return franksList;
    }

    /**
     * Question 8
     * Retrieves all Opportunities that have a specific keyword in their Name.
     * Example: getOpportunitiesByNameKeyword('keyword') should return all Opportunities that have 'keyword' in their Name.
     * @param keyword The keyword to search for in the Opportunity Name.
     * @return A list of Opportunity records.
     */

    public static List<Opportunity> getOpportunitiesByNameKeyword(String keyword) {
        keyword = '%' + keyword + '%';
        List<Opportunity> franksOppList = [SELECT Id, Name FROM Opportunity WHERE Name LIKE :keyword];
        return franksOppList;
    }

    /**
     * Question 9
     * Retrieves all Cases that Case Origin is not Web or Email or Blank
     * @return A list of Case records.
     */

    public static List<Case> getFilterCaseOrigins() {
        List<Case> franksCaseList = [SELECT Id, Subject, Origin FROM Case WHERE Origin != 'Web' AND Origin != 'Email' AND Origin != ''];
        return franksCaseList;
    }

    /**
     * Question 10
     * Update/Uncomment the template code to create a method
     * Retrieves all Leads that have a specific Lead Source or contain a specific keyword in their Title.
     * Example: yourMethodName('Web', 'Engineer') should return all Leads that have 'Web' in their Lead Source or 'Engineer' in their Title.
     * @param leadSource The Lead Source to search for.
     * @param keyword The keyword to search for in the Lead Title.
     * @return A list of Lead records.
     * Update the corresponding test class and testGetLeadsBySourceOrTitle method to cover this method
     */

    public static List<Lead> getWebAndEngineerLeads(String source, String title) {
        source = '%' + source + '%';
        title = '%' + title + '%';
        List<Lead> franksLeadList = [SELECT Id, LastName, Company, Phone, Email, LeadSource, Title FROM Lead WHERE LeadSource LIKE :source OR Title LIKE :title];
        return franksLeadList;
    } 

    /**
     * Question 11
     * Returns the names of all Contacts associated with an Account.
     * Example: getContactNamesByAccount('001XXXXXXXXXXXX') should return the list of Contact LastNames for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Contact LastName.
     */
    public static List<String> getContactNamesByAccount(Id accountId) {
        // Create a list to hold the Contact LastNames
        List<String> lastNameList = new List<String>();
        String lastName;

        // Query the Contacts
        List<Contact> contactList = [SELECT Id, AccountId, LastName FROM Contact WHERE AccountID = :accountId];

        // Loop through each Contact and add the LastName to the list
        for (Contact contact : contactList){
            //lastName = contact.LastName.toString();
            if (lastNameList.contains(contact.LastName.toString())) {
                System.debug('List contains ' + contact.LastName.toString());
            } else {
                lastNameList.add(contact.LastName.toString());
            }
        }

        // Return the list of Contact LastNames
        return lastNameList;
    }

    /**
     * Question 12
     * Returns the total revenue for all Opportunities in a specific Stage or if the amount is greater than 10000.
     * Example: getTotalRevenueByStage('Closed Won') should return the total revenue for all Opportunities in the 'Closed Won' Stage.
     * @param stage The Stage value to filter Opportunities.
     * @return The total revenue.
     */
    public static Decimal getTotalRevenueByStage(String stage) {
        // Use AggregateQuery to get the total revenue
        List<AggregateResult> agg = [SELECT SUM(Amount) FROM Opportunity WHERE StageName = :stage OR Amount > 10000];
        Decimal d = (Decimal)agg[0].get('expr0');

        // Return the total revenue
        return d;
    }

    /**
     * Question 13
     * Retrieves the first 10 Accounts ordered by Name.
     * @return A list of the first 10 Accounts ordered by Name.
     */

    public static List<Account> getFirstTenAccounts() {
        List<Account> firstTenAccounts = [SELECT Name FROM Account ORDER BY Name ASC LIMIT 10];
        return firstTenAccounts;
    }
    
    /**
     * Question 14
     * Retrieves the Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     * @return A list of Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     */

    public static List<Opportunity> getHighValueOpportunities() {
        List<Opportunity> over100kOpps = [SELECT Name, CloseDate, Amount FROM Opportunity WHERE Amount > 100000 ORDER BY CloseDate ASC LIMIT 5];
        return over100kOpps;
    }
    
    /**
     * Question 15
     * Retrieves the Contacts with the most recent Birthdate, ordered by Birthdate, and limited to 3 records.
     * @return A list of Contacts
     */

    public static List<Contact> getBirthdateContacts() {
        List<Contact> recentBirthdays = [SELECT Name, Birthdate FROM Contact WHERE Birthdate != null ORDER BY Birthdate DESC LIMIT 3];
        return recentBirthdays;
    }
    
    /**
     * Question 16
     * Retrieves the Cases in the Open Status, ordered by CreatedDate, and limited to 10 records with an offset of 5.
     * @return A list of Cases
     */

    public static List<Case> getCasesWithStatus() {
        List<Case> tenCases = [SELECT Subject, Status, CreatedDate FROM Case WHERE IsClosed = false ORDER BY CreatedDate LIMIT 10 OFFSET 5];
        return tenCases;
    }

    /**
     * Question 17
     * Returns Set of Case Ids for a specific Account.
     * Example: getCaseIdsByAccount('001XXXXXXXXXXXX') should return the set of Case Ids for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A set of Case Ids.
     */
    public static Set<Id> getCaseIdsByAccount(Id accountId) {
        Set<Id> idSet = new Set<Id>();
        List<Case> casesList = [SELECT Id, AccountId FROM Case WHERE AccountId = :accountId];
        for (Integer i = 0; i < casesList.size(); i++) {
            idSet.add(casesList[i].Id);
        }

        return idSet;
    }

    /**
     * Question 18
     * Return Map of Account Ids to Account Names Not in a specific Country.
     * Example: getAccountIdsToNamesNotInCountry('United States') should return the map of Account Ids to Account Names for Accounts that are not in the United States.
     * @param country The country to filter Accounts.
     * @return A map of Account Ids to Account Names.
     */
    public static Map<Id, String> getAccountIdsToNamesNotInCountry(String country) {
        // Create a map to hold the Account Ids to Account Names
        Map<Id, String> accountIdsToNames = new Map<Id, String>();

        // Query the Accounts
        List<Account> matchingAccounts = [SELECT Id, Name, BillingCountry FROM Account WHERE BillingCountry != :country];
        // Loop through each Account and add the Id and Name to the map
        for (Account account : matchingAccounts) {
            accountIdsToNames.put(account.Id, account.Name);
        }

        return accountIdsToNames; // Replace null with the variable you used to store the result
    }

    /**
     * Question 19
     * Retrieves the Account Name for a given Contact.
     * Example: getAccountNameForContact('003XXXXXXXXXXXX') should return the Account Name for the Contact with the Id
     * @param contactId The Id of the Contact.
     * @return The Account Name of the Contact.
     */
    public static String getAccountNameForContact(String contactId) {
        Contact contact = [SELECT Account.Name FROM Contact WHERE Id = :contactId];
        return contact.Account.Name; // Replace null with the variable you used to store the result
    }    

    /**
     * Question 20
     * Returns single Account that has related opportunities in the same query
     * Example: getOpportunityAndAccountNamesForLineItem('001XXXXXXXXXXXX') should return the Account Name for the Account with the Id and all related Opportunities
     * @param accountId The ID of the Account.
     * @return An Account record with related Opportunities.
     */
    
    
    public static Account getOpportunityAndAccountNamesForLineItem(Id accountId) {
        /**List<Account> accountAndOppsList = [SELECT Name,
                                        (SELECT Id, Name FROM Opportunities) 
                                    FROM Account 
                                    WHERE Id = :accountId]; */

        Account accountAndOppsList = [SELECT Name,
                                                (SELECT Id, Name FROM Opportunities) 
                                            FROM Account 
                                            WHERE Id = :accountId];

        return accountAndOppsList; // Replace null with the variable you used to store the result
    }
     

    /**
     * Question 21
     * Retrieves all contacts that have the Mailing State similar to the Account Billing State.
     * Example: getAccountsWithContactsByState('001XXXXXXXXXXXX') should return a list of Contacts that have the same Mailing State as the Account with the Id
     * @param Account Id
     * @return List of contacts with the same Mailing State as the Account Billing State
     */
    public static List<Contact> getAccountsWithContactsByState(Id accountId) {
        // Query the Account
        List<Account> queryAccount = [SELECT Id, BillingState FROM Account WHERE Id = :accountId];
        Account acc = queryAccount[0];

        // Store the Account's BillingState
        String accState = acc.BillingState;

        // Query the Contacts
        List<Contact> queryContacts = [SELECT Id, MailingState FROM Contact WHERE MailingState = :accState];
        return queryContacts; 
    }

    /**
     * Question 22
     * Extracts email domains from leads, then finds Accounts with matching website domains
     * If Lead Email = test@test.com return account with website = www.test.com
     * Example: findContactsByLeadEmailDomains([set of lead ids]) should return a list of Accounts with matching email domains
     * @param A set of Lead Ids.
     * @return A list of Accounts with matching email domains.
     */

    public static List<Account> findContactsByLeadEmailDomains(Set<Id> leadIds) {
        // Query the Leads
        List<Lead> leadList = [SELECT Id, Email FROM Lead WHERE Id IN :leadIds];

        // Create a set of email domains from the Leads
        List<String> emailDomains = new List<String>();
        Set<String> webDomains = new Set<String>();

        // Loop through each Lead
        for (Lead l : leadList) {
            // Check if the email is not null
            if (l.email != null && l.email != ''){
                    // Get the email from the Lead 
                    emailDomains.add(l.email);
                    // Assign the web domain and add it to the set 
                    webDomains.add('www.' + l.email.substringAfter('@'));
            }
        }
                    
        // Query the Accounts
        List<Account> accountList = [SELECT Id, Name, Website FROM Account WHERE Website IN :webDomains];
        return accountList;

    }

    /**
     * Question 23
     * Clones and Inserts Opportunity Line Items from an original Opportunity to a list of cloned Opportunities.
     * Adds a randomized number between 1 to 3 to the quantity of each line item.
     * Example: cloneLineItems('001XXXXXXXXXXXX', [list of opportunity ids]) should clone the line items from the Opportunity with the Id to each Opportunity in the list
     * @param Original Opportunity Id
     * @param List of cloned Opportunity Ids
     */
    public static void cloneLineItems(Id origOppId, List<Id> cloneOppIds) {
        Opportunity origOpp = [SELECT Id, Name, Pricebook2Id FROM Opportunity WHERE Id = :origOppId LIMIT 1];
        List<Opportunity> cloneOpps = [SELECT Id, Name, Pricebook2Id FROM Opportunity WHERE Id = :cloneOppIds];
        for (Opportunity opp : cloneOpps) {
            opp.Pricebook2Id = origOpp.Pricebook2Id;
        }
        update cloneOpps;  

        // Query the original Opportunity Line Items.
        List<OpportunityLineItem> origOppLineItems = [SELECT OpportunityId, Id, Name, Product2Id, Quantity, TotalPrice, UnitPrice FROM OpportunityLineItem WHERE OpportunityId = :origOppId];
        System.debug(origOppLineItems);

        // Create a list to hold the new line items
        List<OpportunityLineItem> newOppLineItems = new List<OpportunityLineItem>();

        // Generate a random number between 1 and 3
        Double randomDouble = 0.0;
        Integer randomNumber = 0;

        // Loop through each cloned Opportunity Id
        for (Id opp : cloneOppIds) {     
            System.debug(opp);
            // Loop through each original line item
            for (OpportunityLineItem line : origOppLineItems) {
                // Clone the original line item and add the random number to the quantity
                randomDouble = Math.ceil(Math.random() * 10 / 3);
                randomNumber = (Integer)Math.round(randomDouble);
                OpportunityLineItem newLine = new OpportunityLineItem(
                    OpportunityId = opp,
                    Product2Id = line.Product2Id,
                    Quantity = randomNumber,
                    UnitPrice = line.UnitPrice
                );
                System.debug(newLine);
                newOppLineItems.add(newLine);
            }
        }
        insert newOppLineItems;
    }
    
    
    /**
     * Question 24
     * Retrieves the Opportunity Name, Account Name, and Owner Name for Opportunities that have a Stage of 'Closed Won'.
     * Example: getOpportunityDetailsForClosedWon()
     * @return A list of filtered Opportunity
     */
    public static List<Opportunity> getOpportunityDetailsForClosedWon() {
        List<Opportunity> closedWonOpportunities = [SELECT Id, Name, Account.Name, Owner.Name FROM Opportunity WHERE StageName = 'Closed Won'];
        return closedWonOpportunities; // Replace null with the variable you used to store the result
    }

    /**
     * Question 25
     * Sets the 'Primary_Contact__c' field for all Closed Won Opportunities to first Contact on the Account.
     * Example: setPrimaryContact() should set the 'Primary_Contact__c' field for every Opportunity in the org
     */
    public static void setPrimaryContact() {
        // Use the getOpportunityDetailsForClosedWon() method to get the Opportunities
        List<Opportunity> closedWonOpportunities = SOQL.getOpportunityDetailsForClosedWon();

        // Create a set of Account Ids from the Opportunities
        Set<Id> accountIds = new Set<Id>();
        for (Opportunity opp : closedWonOpportunities) {
            accountIds.add(opp.AccountId);
        }
        System.debug(accountIds.size());

        // Query the Contacts
        List<Contact> listOfContacts = [SELECT Id, Name, AccountId FROM Contact WHERE AccountId = :accountIds];
        Map<Id,Contact> accountToContactMap = new Map<Id,Contact>();

        // Loop through each Contact and add the Account Id and Contact to the map
        for (Contact c : listOfContacts) {
            System.debug(c.AccountId + ', ' + c.Name);
            accountToContactMap.put(c.AccountId, c);
        }
        Contact primaryContact;

        // Loop through each Opportunity
        for (Opportunity opp : closedWonOpportunities) {
            // Update the Opportunity primary contact from accountToContactMap
            if (accountToContactMap.containsKey(opp.AccountId)) {
                primaryContact = accountToContactMap.get(opp.AccountId);
                System.debug('Opportunitys Account Id: ' + opp.AccountId);
                opp.Primary_Contact__c = primaryContact.Id;
                System.debug('Opportunitys Primary Contact: ' + opp.Primary_Contact__c);
            }
        }           
        // Update the Opportunities
        update closedWonOpportunities;
        }
}