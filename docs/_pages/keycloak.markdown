---
layout: page
title: Connect via Keycloak
nav_order: 2
parent: OpenID Connect
grand_parent: How to connect
---

# Documentation
## Overview

[Keycloak](https://www.keycloak.org/) is an open source software solution that provides single sign on (SSO) access, 
allowing users to authenticate once to access multiple services. It also allows for single sign out, which means 
that users only have to sign out once for several services and/or applications that use Keycloak.

Keycloak can also be used to authenticate users with existing OpenID Connect or SAML 2.0 Identity Providers. This 
can be done by configuring the Identity Provider through the Keycloak admin console.

The instructions below detail the configuration of AAF as an Identity Provider through Keycloak using the OpenID 
Connect protocol. The process includes the registration of a new service in AAF Federation Manager (Test or 
Production). Please refer to the documentation for [registering a new service]({% link _pages/oidc_register.markdown %}).

## 1. Get Started

* If you are using Keycloak for the first time, [please refer to their documentation](https://www.keycloak.org/documentation) to get started. Otherwise, if you are already using Keycloak, log into the Keycloak admin 
  console. In a local development environment, it is located at http://localhost:8080/admin.

![Keycloak Sign In Page](/assets/images/keycloak-signin-page.png)

* Once signed in, click on 'master' (at the top of the left hand menu bar). Then click 'Create Realm'.

![Master Realm Page](/assets/images/master-realm-page.png)

* Select an appropriate `Realm name` where you would like to add AAF as an identity provider. In this example, the new 
  realm is called 'myrealm'.

![Create Realm Page](/assets/images/create-realm.png)

## 2. Add an Identity Provider

* Once in the selected realm (in this example, it is 'myrealm'), click on 'Identity providers' (at the bottom of the 
  left hand menu bar).

![Identity provider Link](/assets/images/navigate-to-idp.png)

* Click on 'OpenID Connect v1.0' in the 'User-defined' section.

![Identity provider Link](/assets/images/identity-provider-selection.png)

* Fill in the mandatory fields (as denoted by the asterisk). The following fields in the 'OpenID Connect settings' 
  section will need to be obtained from AAF Federation Manager (Test or Production) by [registering a new service]({% 
  link _pages/oidc_register.markdown %}):

  - `Discovery endpoint`
  - `Client ID`
  - `Client Secret`


![OpenID connect provider](/assets/images/add-open-id-connect-provider.png)

{: .note }
Keep the Keycloak admin console page open as you will need to copy the 'Redirect URI' field provided by Keycloak to 
register a new OIDC service with AAF.

* Once you have received an 'Identifier' and a 'Secret' from Federation Manager (Test or Production), you can paste 
  these items into the `Client ID` and `Client Secret` fields, respectively, within the 'OpenID Connect settings' 
  section.
* The `Discovery Endpoint` will be: `https://central.test.aaf.edu.au/.well-known/openid-configuration`
* Select 'RS256' as the `Client Assertion Signature Algorithm`.
* Click 'Add'.

You will see the new identity provider settings (as shown below).

![New identity provider settings](/assets/images/new-identity-provider-settings.png)

If you click on the 'Identity providers' option (in the left-hand menu bar), you will now see the newly created 
identity provider called 'oidc':

![OpenID connect provider](/assets/images/new-identity-provider.png)

## 3. Add a New User to your Identity Provider

In order to provide the option for users to sign in with oidc, you will need to add users to the realm in which 
the AAF identity provider has just been configured. 

* Click on 'Users' in the left hand menu column. 
* Click on 'Add user'.

![Navigate to User](/assets/images/navigate-to-new-user.png)

* Add a `Username` and click 'Create'.

![Create new user](/assets/images/create-new-user.png)

An ID number will be created for the new user as shown below.

![New user created](/assets/images/new-user-created.png)

* At the top of the same page, click on 'Credentials' and then, 'Set password'.

![Set new password](/assets/images/set-new-password.png)

* Fill in the `Password` and `Password confirmation` fields. In this instance, the `Temporary` field is set to 'Off',
  which does not prompt the new user to set and confirm a new password on the next login.

![Set new user password](/assets/images/set-password-for-new-user.png)

The new user's password is saved as shown below.

![New user password](/assets/images/new-user-password.png)

* Head over to your 'Keycloak Account Console'. In a local development environment, it is located at 
  http://localhost:8080/realms/myrealm/account/#/

![Keycloak account console](/assets/images/keycloak-account-console.png)

* Click 'Sign in'.

* You will now see the option to sign in with 'oidc' (or whatever `alias` you chose to identify your identity provider).
* Click on 'oidc'.

![Sign in with oidc](/assets/images/sign-in-with-oidc.png)

This will take you to the AAF Discovery Service (known as AAF Central).

* Select your organisation from the list provided and click 'Continue to your organisation'.

![Log into Central](/assets/images/log-in-to-central.png)

* You will be prompted to enter the username and password of the new user.
* Click 'Sign in'.

![Log in to organisation](/assets/images/login-to-organisation.png)

* If authentication is successful, you will be taken back to the Keycloak account console for the new user.

![New user account](/assets/images/new-user-account.png)