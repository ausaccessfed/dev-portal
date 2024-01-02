---
layout: page
title: Connect via Keycloak
nav_order: 2
parent: OpenID Connect
grand_parent: How to connect
---

# Documentation
## Overview

[Keycloak](https://www.keycloak.org/) is an open source software solution that provides single sign on access, 
allowing users to authenticate once to access multiple services. It also allows for single sign out, which means that users only have to sign out once for several services and/or applications that use keycloak.

Keycloak can also be used to authenticate users with existing OpenID Connect or SAML 2.0 Identity Providers. This can be done by configuring the Identity Provider through the keycloak admin console.

## 1. Get Started

* If you are using Keycloak for the first time, [please refer to their documentation](https://www.keycloak.org/documentation) to get started. Otherwise, if you are already using Keycloak, log into the Keycloak Admin 
  Console. In development mode, it is located at http://localhost:8080/admin.

![Keycloak Sign In Page](/assets/images/keycloak-signin-page.png)

* Once you are signed in, click on 'master' (at the top of the left hand menu bar).

![Master Realm Page](/assets/images/master-realm-page.png)

* Select the appropriate realm where you would like to add AAF as an identity provider. In this example, a new realm 
called 'myrealm' is being created.

![Create Realm Page](/assets/images/create-realm.png)

## 2. Add an Identity Provider

* Once in the selected realm (in this example, it is 'myrealm'), click on `identity providers` (at the bottom of the 
  left hand menu bar).

![Identity provider Link](/assets/images/navigate-to-idp.png)

* Click on 'OpenID Connect v1.0' in the 'User-defined' section.

![Identity provider Link](/assets/images/identity-provider-selection.png)

* To complete the set-up of an OpenID Connect provider, ensure that the following fields in the 'OpenID Connect 
  settings' section have been obtained from AAF Federation Manager by [registering a new service]({% link 
  _pages/oidc_register.markdown %}):

      1. Discovery endpoint
      2. Client ID
      3. Client Secret

![OpenID connect provider](/assets/images/add-open-id-connect-provider.png)

{: .note }
Keep the Keycloak admin console page open as you will need to copy the 'Redirect URI' field provided by Keycloak to 
register a new OIDC service with AAF.

* Once you have received an 'Identifier' and a 'Secret' from Federation Manager, you can paste these items into the 
  `Client ID` and `Client Secret` fields, respectively, within the 'OpenID Connect settings' section.
* The `Discovery Endpoint` will be: `https://central.test.aaf.edu.au/.well-known/openid-configuration`
* Select 'RS256' as the `Client Assertion Signature Algorithm`.
* Click 'Add'.

You will now see the new identity provider called 'oidc' in the 'Identity Providers' section:

![OpenID connect provider](/assets/images/new-identity-provider.png)

## 3. Add a New User to your Identity Provider

* Click on 'Users' in the left hand menu column. 
* Click on 'Add user'.

![Navigate to User](/assets/images/navigate-to-new-user.png)

* Add a 'Username' and click 'Create'.

![Create new user](/assets/images/create-new-user.png)

An ID number will be created for the new user as shown below.

![New user created](/assets/images/new-user-created.png)

* At the top of the same page, click on 'Credentials' and then, 'Set password'.

![Set new password](/assets/images/set-new-password.png)

* Fill in the `Password` and `Password confirmation` fields. In this instance, the `Temporary` field is set to 'Off',
  which does not prompt the new user to set and confirm a new password when first logging on.

![Set new user password](/assets/images/set-password-for-new-user.png)

* Head over to your 'Keycloak Account Console'. In this instance, it is located at 
  http://localhost:8080/realms/myrealm/account/#/

![Keycloak account console](/assets/images/keycloak-account-console.png)

* Click 'Sign in'.

* You will now see the option to sign in with 'oidc' (or whatever `alias` you chose to identify your identity provider).
* Click on 'oidc'.

![Sign in with oidc](/assets/images/sign-in-with-oidc.png)

This will take you to the AAF Discovery Service (known as AAF Central).

![Log into Central](/assets/images/log-in-to-central.png)

* Select your organisation from the list provided and click 'Continue to your organisation'.
* You will be prompted to enter the username and password of the new user.
* Click 'Sign in'.

![Log in to organisation](/assets/images/login-to-organisation.png)

* If authentication is successful, you will be taken back to the Keycloak account console for the new user.

![New user account](/assets/images/new-user-account.png)