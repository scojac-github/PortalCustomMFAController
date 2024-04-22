# Two-Factor Authentication for Experience Cloud Users

This project provides a workaround for setting up Two-Factor Authentication (2FA) for Salesforce Community users with Partner Community or Customer Community licenses.

## Overview

This project uses Apex and a Visualforce page to generate a token, send an email containing the token, and validate the token after the user enters before logging in to an Experience Cloud site.

## Setup Instructions

1. Create/deploy the Apex Class and Visualforce Page
2. Navigate to Setup > Flows > Login Flows, create a new flow, and provide the inputs (Visualforce Page, Community User License, and Community User Profile).
    a. You'll need to create a Login Flow for each applicable Profile.
3. Login to the community, and the Token screen will appear. Upon successful validation of the token, the user will be navigated to the home page. The Generate button can be used to resend the token if needed.

## Other items to check

1. Ensure the Profile(s) have access to the Apex class, Visualforce page, and organization-wide email address.
2. 

## Important Note

Requires an Org Wide Email Address.

Update the `orgWide` variable in `PortalMFAController.cls` to the email address of the org-wide email you want to use to send the token emails.

## High-level Diagram

![diagram](https://github.com/scojac-github/PortalCustomMFAController/blob/main/diagram.png)

## License

This project is licensed under the [MIT License](LICENSE).

---

**Author**: Scott Jacobson

**Date**: 2024-04-19