/**
 * @ Author: Scott Jacobson
 * @ Create Time: 2024-04-19 21:34:20
 * @ Modified by: Your name
 * @ Modified time: 2024-04-22 14:41:13
 * @ Description: Apex Class to generate a token for external (Experience site) users. Used in conjunction with Visualforce Page and Login Flow
 */

public class PortalMFAController {
    
    public String token {get; set;}
    public String userToken {get; set;}
    public Boolean invalidToken {get; set;}
    public String orgEmail = 's.jacobson267+owed@gmail.com';
    
    public void sendToken() {
        generateToken();
    }

    public PageReference validateToken() {
        if(token != userToken) {
            invalidToken = true;
            return null;
        } else {
            return Auth.SessionManagement.finishLoginFlow();
        }
    }
    
    public void generateToken() {
        token = Integer.valueof(Math.random() * 100000).toString();
        OrgWideEmailAddress[] owea = [SELECT Id from OrgWideEmailAddress WHERE Address = :orgEmail LIMIT 1];
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage(); 
        email.setOrgWideEmailAddressId(owea.get(0).Id);
        email.setSubject('Your Secure 2FA Token');
        email.setToAddresses(new String[]{UserInfo.getUserEmail()});
        email.setPlainTextBody('Dear ' + UserInfo.getFirstName() + ',\n\n' +
                               'Please find your authentication token below:\n\n' +
                               'Authentication Token: ' +token+ '\n\n' +
                               'If you have any concerns regarding the security of your account or did not request this token, \n\n' +
                               'please reach out to our support team immediately.');
    
       Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
    }
}