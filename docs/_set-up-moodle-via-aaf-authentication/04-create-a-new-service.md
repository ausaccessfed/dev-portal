---
title: Create a new service
order: 4
duration: 1
---

* On the 'Site administration' page, click on 'Server'.

![Site Admin Page](/assets/images/set-up-moodle-via-aaf-authn/site-admin-page.png)

* On the 'Server' page, click on 'OAuth 2 services'.

![Server Page](/assets/images/set-up-moodle-via-aaf-authn/server-page.png)

* On the 'OAuth 2 services' page, click on 'Custom'.

![OAuth 2 Services Page](/assets/images/set-up-moodle-via-aaf-authn/oauth2-services-page.png)

To create a new custom service, you will need to enter the mandatory fields `Name`, `Client ID` and `Client Secret`.

* To do this, in a separate browser tab, head over to Federation Manager (Test) to [register a new OIDC service](https://manager.test.aaf.edu.au/oidc/clients/new).

![Custom Service Page](/assets/images/set-up-moodle-via-aaf-authn/custom-service-page.png)

Keep the Moodle admin console page open as you will need to enter the `Client ID` and `Client Secret` field values provided by Federation Manager into the Moodle console.
{: .callout-info}

* Once you click 'Register Service' you will receive an `Identifier` (redacted below) and a `Secret` from Federation Manager (Test).

You will be able to regenerate the secret later if required.
{: .callout-info}

![Client ID and Secret](/assets/images/set-up-moodle-via-aaf-authn/register-moodle-service.png)

* Copy the `Identifier` and `Secret` to your clipboard and head back over to the Moodle admin console.
* Paste these items into the `Client ID` and `Client Secret` fields, respectively, within the 'OpenID Connect settings' section of the Moodle console.
* In the development environment, you can use `localhost:8000` as the `service base URL`.
* For the field titled `This service will be used`, select `Login page only` from the dropdown menu.
* Click 'Save changes' to complete the process.

You will see your new service listed under 'OAuth 2 services' in the Moodle console.

![New Moodle Service](/assets/images/set-up-moodle-via-aaf-authn/new-moodle-oauth-service.png)
