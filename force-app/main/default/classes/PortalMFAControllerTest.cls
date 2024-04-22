@isTest
public class PortalMFAControllerTest {
    @isTest
    static void testSendToken() {
        // Create a test user
        User testUser = new User(
            FirstName = 'Test',
            LastName = 'User',
            Email = 'portaluser@email.xyz',
            Username = 'portaluser@email.xyz',
            Alias = 'tuser',
            CommunityNickname = 'testuser',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            TimeZoneSidKey = 'America/New_York',
            ProfileId = UserInfo.getProfileId()
        );
        insert testUser;

        // Create an instance of the PortalMFAController class
        PortalMFAController controller = new PortalMFAController();

        // Call generateToken before sendToken
        controller.generateToken();

        // Call the sendToken method
        Test.startTest();
        controller.sendToken();
        Test.stopTest();

        // Verify that the token is not null
        System.assertNotEquals(null, controller.token);
    }
    

    @isTest
    static void testValidateToken() {
        // Create a test user
        User testUser = new User(
            FirstName = 'Test',
            LastName = 'User',
            Email = 'portaluser@email.xyz',
            Username = 'portaluser@email.xyz',
            Alias = 'tuser',
            CommunityNickname = 'testuser',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            TimeZoneSidKey = 'America/New_York',
            ProfileId = UserInfo.getProfileId()
        );
        insert testUser;

        // Create an instance of the PortalMFAController class and set the user token
        PortalMFAController controller = new PortalMFAController();
        controller.userToken = '000123';

        // Call the validateToken method and test the invalidToken flag
        Test.startTest();
        PageReference result = controller.validateToken();
        Test.stopTest();

        // Verify that the invalidToken flag is set to false
        System.assertEquals(true, controller.invalidToken);
    }
}
