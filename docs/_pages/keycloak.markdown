---
layout: page
title: Connect via Keycloak
permalink: /new_service/oidc_register/keycloak
nav_order: 2
parent: OpenID Connect
grand_parent: Connect a New Service
---

# Register an OIDC service with Keycloak

[Keycloak](https://www.keycloak.org/) is an open source software solution that provides single sign on (SSO) access, allowing users to authenticate once to access multiple services. It also allows for single sign out, which means that users only have to sign out once for several services and/or applications that use Keycloak.

Keycloak can also be used to authenticate users with existing OpenID Connect or SAML 2.0 Identity Providers. This can be done by configuring the Identity Provider through the Keycloak admin console.

{: .note}
The instructions below detail the configuration of AAF as an Identity Provider through Keycloak using the OpenID Connect v1.0 protocol. The process includes the registration of a new service in AAF Federation Manager (Test). Please refer to the documentation for [registering a new OpenID Connect service]({% link _pages/oidc_register.markdown %}).

# What you'll learn

- How to connect a new OpenID Connect service in the AAF Test Federation using Keycloak

# What you'll need

- A container platform on which to run Keycloak, e.g. Docker, Podman, OpenJDK, etc.
- Knowledge running a container platform in a local development environment
- AAF login credentials


## 1. Get Started

* If you are using Keycloak for the first time, [please refer to their documentation](https://www.keycloak.org/documentation) to get started. Otherwise, if you are already using Keycloak, log into the Keycloak admin console. In a local development environment, it is located at `http://localhost:8080/admin`.

![Keycloak Sign In Page](/assets/images/keycloak-signin-page.png)

* Once signed in, click on 'master' (at the top of the left hand menu bar). 

![Keycloak Master Page](/assets/images/keycloak-highlight-master.png)

* Create a new realm where you would like to add AAF as an identity provider and in which you will manage your users, applications, roles and groups. To do this, click 'Create Realm'. 

![Master Realm Page](/assets/images/keycloak-master-realm-page.png)

* Select an appropriate `Realm name`. In this example, the new realm is called 'myrealm'.
* Click 'Create'.

![Create Realm Page](/assets/images/keycloak-create-realm.png)

## 2. Add an Identity Provider

* Once in the selected realm (in this example, it is 'myrealm'), click on 'Identity providers' (at the bottom of the left hand menu bar).

![Identity provider Link](/assets/images/keycloak-navigate-to-idp.png)

* Click on 'OpenID Connect v1.0' in the 'User-defined' section. This is the open protocol standard that AAF uses to authenticate users in this instance.

![Identity provider Link](/assets/images/keycloak-idp-selection.png)

* In the 'Add OpenID Connect provider' section, copy the value of the `Redirect URI` field to your clipboard.

![OpenID connect provider](/assets/images/keycloak-add-oidc-provider.png)

* In a separate browser tab, [register a new OIDC service](https://manager.test.aaf.edu.au/oidc/clients/new) in Federation Manager (Test).

{: .note }
Keep the Keycloak admin console page open as you will need to enter the `Client ID` and `Client Secret` field values provided by Federation Manager into Keycloak.

* On the 'Register a New Service' page (for OpenID Connect) in Federation Manager, paste the `Redirect URI` value obtained from Keycloak into the `Redirect URL` field.

![Register new service](/assets/images/register-oidc-service-redirect-url.png)

* Once you click 'Register Service' you will receive an 'Identifier' and a 'Secret' from Federation Manager (Test).

![Keycloak service](/assets/images/keycloak-service.png)

* Copy and paste these items into the `Client ID` and `Client Secret` fields, respectively, within the 'OpenID Connect settings' section of Keycloak.

![Oidc provider secret](/assets/images/keycloak-add-oidc-provider-secret.png)

The other mandatory fields are the `Discovery Endpoint` and `Client Assertion Signature Algorithm`.
* The `Discovery Endpoint` will be: `https://central.test.aaf.edu.au/.well-known/openid-configuration`
* The `Client Assertion Signature Algorithm` will be 'RS256' as it is the currently recommended algorithm when signing JWTs. If no algorithm is specified, Keycloak will default to RS256 in the case of a JWT signed with a private key.
* Click 'Add'.

You will see the new identity provider settings (as shown below).

![New identity provider settings](/assets/images/keycloak-new-idp-settings.png)

If you click on the 'Identity providers' option (in the left-hand menu bar), you will now see the newly created identity provider called 'oidc':

![OpenID connect provider](/assets/images/keycloak-new-identity-provider.png)

* When next signing in, you will see the option to sign in with 'oidc' (or whatever `alias` you chose to identify your identity provider).
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


## Up Next: [Register a Rapid Connect Service](/new_service/rapidconnect_register)
