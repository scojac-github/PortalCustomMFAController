public without sharing class PortalMFAController {
    // Declare variables to store the token, user token, and a flag to indicate if the token is invalid
    public String token {get; set;}
    public String userToken {get; set;}
    public Boolean invalidToken {get; set;}

    // This method is called to send the token to the user
    public void sendToken() {
        // Generate the token
        generateToken();
    }

    // This method is called to validate the token entered by the user
    public PageReference validateToken() {
        if (token != userToken) {
            invalidToken = true;
            return null;
        } else {
            invalidToken = false; // Set invalidToken to false if the tokens match
            return Auth.SessionManagement.finishLoginFlow();
        }
    }

    // This method generates a random token and sends it to the user's email
    public void generateToken() {
        List<OrgWideEmailAddress> orgEmails = [SELECT Id FROM OrgWideEmailAddress LIMIT 1];
        if (!orgEmails.isEmpty()) {
            token = String.valueOf(Math.round(Math.random() * 100000));
            OrgWideEmailAddress orgEmail = orgEmails[0];
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setOrgWideEmailAddressId(orgEmail.Id);
            email.setSubject('Your Secure 2FA Token');
            email.setToAddresses(new String[] {UserInfo.getUserEmail()});
            email.setPlainTextBody('Dear ' + UserInfo.getFirstName() + ',\n\n' +
                                    'Please find your authentication token below: \n\n' +
                                    'Authentication Token: ' + token + '\n\n' +
                                    'If you have any questions please contact support@support.com');
            Messaging.sendEmail(new Messaging.Email[] {email});
        }
    }    
}