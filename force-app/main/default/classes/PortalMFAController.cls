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
        // Check if the token entered by the user matches the generated token
        if (token != userToken) {
            // If the tokens don't match, set the invalidToken flag to true and return null
            invalidToken = true;
            return null;
        } else {
            // If the tokens match, finish the login flow and return the PageReference
            return Auth.SessionManagement.finishLoginFlow();
        }
    }

    // This method generates a random token and sends it to the user's email
    public void generateToken() {
        // Generate a random token
        token = integer.valueOf(Math.random() * 100000).toString();

        // Retrieve the org-wide email address
        OrgWideEmailAddress[] orgEmail = [SELECT Id FROM OrgWideEmailAddress LIMIT 1];

        // Create a new email message
        Messaging.SingleEmailMessage email = new Messaaging.SingleEmailMessage();

        // Set the org-wide email address as the sender
        email.setOrgWideEmailAddressId(orgEmail.get(0).Id);

        // Set the email subject
        email.setSubject('Your Secure 2FA Token');

        // Set the recipient email address to the current user's email
        email.setToAddresses(new String[] {UserInfo.getUserEmail()});

        // Set the email body
        email.setPlainTextBody('Dear ' + UserInfo.getFirstNmae() + ',\n\n' +
                                'Please find your authentication token below: \n\n' +
                                'Authentication Token: ' + token + '\n\n' +
                                'If you have any questions please contact support@support.com');

        // Send the email
        Messaging.sendEmail(new Messaging.Email[] {email});
    }
}