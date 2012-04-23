global class PortalHandler implements Auth.RegistrationHandler{
    global User createUser(Id portalId, Auth.UserData data){
        Account a = [SELECT Id FROM account WHERE name='sForce'];
        Contact c = new Contact();
        c.accountId = a.Id;
        c.email = data.email;
        c.firstName = data.firstName;
        c.lastName = data.lastName;
        insert(c);
    
        User u = new User();
        Profile p = [SELECT Id FROM profile WHERE name='High Volume Customer Portal'];
        
        // Use incoming email for username, since we're creating a portal user
        u.username = data.email;
        u.email = data.email;
        u.lastName = data.lastName;
        u.firstName = data.firstName;
        u.alias = (data.username.length() > 8) 
            ? data.username.substring(0, 8) 
            : data.username;
        u.languagelocalekey = UserInfo.getLocale();
        u.localesidkey = UserInfo.getLocale();
        u.emailEncodingKey = 'UTF-8';
        u.timeZoneSidKey = 'America/Los_Angeles';
        u.profileId = p.Id;
        u.contactId = c.Id;
          
        return u;
    }

    global void updateUser(Id userId, Id portalId, Auth.UserData data){
        User u = new User(id=userId);
        
        u.email = data.email;
        u.lastName = data.lastName;
        u.firstName = data.firstName;

        update(u);
    }
}