---
title: Create a new service
order: 3
duration: 1
last_updated: March 07, 2025
---

* On the 'Site administration' page, navigate to 'Server' &rarr; 'OAuth 2 services' &rarr; 'Custom'.

![OAuth 2 Services Page](/assets/images/set-up-moodle-via-aaf-authn/oauth2-services-page.png)

To create a new custom service, you will need to enter the mandatory fields `Name`, `Client ID` and `Client Secret` (as shown below).

You can obtain these values by [connecting an OIDC service](/connect-an-oidc-service/01-overview) in Federation Manager (Test).
{: .callout-info}

* When you've created the OIDC service in Federation Manager (Test), copy the `Identifier` and `Secret` to your clipboard and head back over to the Moodle admin console.
* Paste these items into the `Client ID` and `Client Secret` fields, respectively.
* The `service base URL` field will be [https://central.test.aaf.edu.au](https://central.test.aaf.edu.au).
* Click 'Save changes' to complete the process.

![Custom Service Page](/assets/images/set-up-moodle-via-aaf-authn/custom-service-page.png)

You will see your new service listed under 'OAuth 2 services' in the Moodle console.

![New Moodle Service](/assets/images/set-up-moodle-via-aaf-authn/new-moodle-oauth-service.png)
