# Two-Factor Authentication for Experience Cloud Users

This project provides a workaround for setting up Two-Factor Authentication (2FA) for Salesforce Community users with Partner Community or Customer Community licenses.

## Overview

This project uses a Visualforce page to generate a token, send an email containing the token, and validate the token after the user enters it.

## Setup Instructions

1. Create/deploy the Apex Class and Visualforce Page
2. Navigate to Setup > Flows > Login Flows, create a new flow, and provide the inputs (Visualforce Page, Community User License, and Community User Profile).
3. Login to the community, and the Token screen will appear. Upon successful validation of the token, the user will be navigated to the home page. The Generate button can be used to resend the token if needed.

## Important Note

Requires an Org Wide Email Address.

Replace `<EmailAddress>` with a valid OrgWideEmailAddress that is allowed for Community Profiles in both the Visualforce Page and the Apex Controller.

## License

This project is licensed under the [MIT License](LICENSE).

---

**Author**: Scott Jacobson

**Date**: 2024-04-19