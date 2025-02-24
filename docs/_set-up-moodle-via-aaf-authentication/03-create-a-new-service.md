---
title: Create a new service
order: 3
duration: 1
---

To create a new custom service, you will need to enter the mandatory fields `Name`, `Client ID` and `Client Secret`.

* To do this, in a separate browser tab, head over to Federation Manager (Test) to [register a new OIDC service](https://manager.test.aaf.edu.au/oidc/clients/new).

![Custom Service Page](/assets/images/set-up-moodle-via-aaf-authn/custom-service-page.png)

Keep the Moodle admin console page open as you will need to enter the `Client ID` and `Client Secret` field values provided by Federation Manager into the Moodle console.
{: .callout-info}

* Once you click 'Register Service' you will receive an 'Identifier' (redacted below) and a 'Secret' from Federation Manager (Test).

You will be able to regenerate the secret later if required.
{: .callout-info}

![Client ID and Secret](/assets/images/set-up-moodle-via-aaf-authn/register-moodle-service.png)

* Copy the 'Identifier' and 'Secret' to your clipboard and head back over to the Moodle admin console.
* Paste these items into the `Client ID` and `Client Secret` fields, respectively, within the 'OpenID Connect settings' section of the Moodle console.
* Click 'Save changes' to complete the process.

You will see your new service listed under 'OAuth 2 services' in the Moodle console.

![New Moodle Service](/assets/images/set-up-moodle-via-aaf-authn/new-moodle-oauth-service.png)
