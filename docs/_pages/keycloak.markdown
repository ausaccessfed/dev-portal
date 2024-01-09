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

* If you are using Keycloak for the first time, [please refer to their documentation](https://www.keycloak.org/documentation) to get started. Otherwise, if you are already using Keycloak, log into the Keycloak admin console. In a local development environment, it is located at http://localhost:8080/admin.

![Keycloak Sign In Page](/assets/images/keycloak-signin-page.png)

* Once signed in, click on 'master' (at the top of the left hand menu bar). Then click 'Create Realm'.

![Master Realm Page](/assets/images/master-realm-page.png)

* Select an appropriate `Realm name` where you would like to add AAF as an identity provider. In this example, the new realm is called 'myrealm'.

![Create Realm Page](/assets/images/create-realm.png)

## 2. Add an Identity Provider

* Once in the selected realm (in this example, it is 'myrealm'), click on 'Identity providers' (at the bottom of the left hand menu bar).

![Identity provider Link](/assets/images/navigate-to-idp.png)

* Click on 'OpenID Connect v1.0' in the 'User-defined' section.

![Identity provider Link](/assets/images/identity-provider-selection.png)

* Fill in the mandatory fields (as denoted by the asterisk). The following fields in the 'OpenID Connect settings' section will need to be obtained from AAF Federation Manager (Test or Production) by [registering a new service]({% link _pages/oidc_register.markdown %}):

  - `Discovery endpoint`
  - `Client ID`
  - `Client Secret`


![OpenID connect provider](/assets/images/add-open-id-connect-provider.png)

{: .note }
Keep the Keycloak admin console page open as you will need to copy the 'Redirect URI' field provided by Keycloak to register a new OIDC service with AAF.

* Once you have received an 'Identifier' and a 'Secret' from Federation Manager (Test or Production), you can paste these items into the `Client ID` and `Client Secret` fields, respectively, within the 'OpenID Connect settings' section.
* The `Discovery Endpoint` will be: `https://central.test.aaf.edu.au/.well-known/openid-configuration`
* Select 'RS256' as the `Client Assertion Signature Algorithm`.
* Click 'Add'.

You will see the new identity provider settings (as shown below).

![New identity provider settings](/assets/images/new-identity-provider-settings.png)

If you click on the 'Identity providers' option (in the left-hand menu bar), you will now see the newly created identity provider called 'oidc':

![OpenID connect provider](/assets/images/new-identity-provider.png)

* When next signing in, you will see the option to sign in with 'oidc' (or whatever `alias` you chose to identify 
  your identity provider).
* Click on 'oidc'.

![Sign in with oidc](/assets/images/sign-in-with-oidc.png)

This will take you to the AAF Discovery Service (known as AAF Central).

* Select your organisation from the list provided and click 'Continue to your organisation'.

![Log into Central](/assets/images/log-in-to-central.png)

* You will be prompted to enter your username and password.
* Click 'Sign in'.

![Log in to organisation](/assets/images/login-to-organisation.png)

* If authentication is successful, you will be taken back to your Keycloak account console.

![New user account](/assets/images/new-user-account.png)