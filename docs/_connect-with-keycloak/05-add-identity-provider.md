---
title: Add an identity provider
order: 5
duration: 5
---

* Once in the selected realm (in this example, it is 'myrealm'), click on 'Identity providers' (at the bottom of the left hand menu bar).

![Identity provider Link](/assets/images/connect-with-keycloak/keycloak-navigate-to-idp.png)

* Click on 'OpenID Connect v1.0' in the 'User-defined' section. This is the open protocol standard that AAF uses to authenticate users in this instance.

![Identity provider Link](/assets/images/connect-with-keycloak/keycloak-idp-selection.png)

* In the 'Add OpenID Connect provider' section, copy the value of the `Redirect URI` field to your clipboard.

![OpenID connect provider](/assets/images/connect-with-keycloak/keycloak-add-oidc-provider.png)

* In a separate browser tab, [register a new OIDC service](https://manager.test.aaf.edu.au/oidc/clients/new) in Federation Manager (Test).

Keep the Keycloak admin console page open as you will need to enter the `Client ID` and `Client Secret` field values provided by Federation Manager into Keycloak.
{: .callout-info}

* On the 'Register a New Service' page (for OpenID Connect) in Federation Manager, paste the `Redirect URI` value obtained from Keycloak into the `Redirect URL` field.

![Register new service](/assets/images/connect-with-keycloak/register-oidc-service-redirect-url.png)

* Once you click 'Register Service' you will receive an 'Identifier' and a 'Secret' from Federation Manager (Test).

![Keycloak service](/assets/images/connect-with-keycloak/keycloak-service.png)

* Copy these items to your clipboard and head back over to Keycloak.
* Paste these items into the `Client ID` and `Client Secret` fields, respectively, within the 'OpenID Connect settings' section of the Keycloak console.

![Oidc provider secret](/assets/images/connect-with-keycloak/keycloak-add-oidc-provider-secret.png)

The other mandatory fields in this section are the `Discovery Endpoint` and `Client Assertion Signature Algorithm`.
* The `Discovery Endpoint` will be: `https://central.test.aaf.edu.au/.well-known/openid-configuration`
* The `Client Assertion Signature Algorithm` will be 'RS256' as it is the currently available algorithm when signing JWTs. If no algorithm is specified, Keycloak will default to RS256 in the case of a JWT signed with a private key.
* Click 'Add'.

You will see the new identity provider settings (as shown below).

![New identity provider settings](/assets/images/connect-with-keycloak/keycloak-new-idp-settings.png)

If you click on the 'Identity providers' option (in the left-hand menu bar), you will now see the newly created identity provider called 'oidc':

![OpenID connect provider](/assets/images/connect-with-keycloak/keycloak-new-identity-provider.png)

* When next signing in, you will see the option to sign in with 'oidc' (or whatever `alias` you chose to identify your identity provider).
* Click on 'oidc'.

![Sign in with oidc](/assets/images/connect-with-keycloak/sign-in-with-oidc.png)

This will take you to the AAF Discovery Service (known as AAF Central).

* Select your organisation from the list provided and click 'Continue to your organisation'.

![Log into Central](/assets/images/connect-with-keycloak/log-in-to-central.png)

* You will be prompted to enter your username and password.
* Click 'Sign in'.

![Log in to organisation](/assets/images/connect-with-keycloak/login-to-organisation.png)

* If authentication is successful, you will be taken back to your Keycloak account console.

![New user account](/assets/images/connect-with-keycloak/new-user-account.png)