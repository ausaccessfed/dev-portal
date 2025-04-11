---
title: Enable AAF as Authentication Provider
order: 4
duration: 1
last_updated: 08-04-2025
---

* Once you are signed in as the admin user in your XNAT application, click on the **Administer** tab in the top menu bar followed by **Site Administration** -> **Security** (located in **Site Settings**).

![Administer Tab](/assets/images/register-an-xnat-oidc-service/administer-tab.png)

Once on the **Security** page, scroll down to the **User Authentication Settings** section and add `aaf` to the 
**Enabled Authentication Providers** list. This will enable the AAF authentication provider.

Note: the authentication providers need to be separated by commas if there are more than one.
{: .callout-info}

![Enable Authentication Provider](/assets/images/register-an-xnat-oidc-service/enable-authentication-provider.png)

* Click on the **Save** button to save the changes.

* Log out of the XNAT instance. You will now see the **Sign in with AAF** button on the login page.

![Sign in with AAF](/assets/images/register-an-xnat-oidc-service/sign-in-with-aaf.png)

* Click on the **Sign in with AAF** button. This will redirect you to the AAF login page where you can authenticate with your organisation credentials.

![Sign in with AAF](/assets/images/register-an-xnat-oidc-service/log-into-aaf.png)