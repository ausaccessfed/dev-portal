---
title: Add an identity provider
order: 3
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

* Once you click 'Register Service' you will receive an 'Identifier' (redacted below) and a 'Secret' from Federation 
  Manager (Test). You will be able to regenerate the secret later if required.

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


### Logging in with the new identity provider

* First ensure that the users you wish to authenticate with this identity provider have been added to the selected realm. 
* To do this, click on 'Users' in the left-hand menu bar.

![Users Link](/assets/images/connect-with-keycloak/navigate-to-users.png)

* Click on the user you wish to authenticate with the new identity provider.

![Add Selected User](/assets/images/connect-with-keycloak/add-selected-user.png)

* In the User Profile, click on identity provider links.

![Link User to IdP](/assets/images/connect-with-keycloak/idp-link.png)

* Click 'Link account' next to the new identity provider (in this case, 'oidc').

![Link Account](/assets/images/connect-with-keycloak/link-user-account.png)

* Enter the user ID (from the User Details page) and username for the user account you wish to link.
* Click 'Link'.

![Enter User ID](/assets/images/connect-with-keycloak/enter-user-id.png)

* You will see that the user account and the identity provider have now been linked.

![Linked Account](/assets/images/connect-with-keycloak/linked-user-account.png)

* When next signing in as a user (in this case, http://localhost:8080/realms/myrealm/account), you will see the option to sign in with 'oidc' (or whatever `alias` you chose to identify your identity provider).
* Click on 'oidc'.

![Sign in with oidc](/assets/images/connect-with-keycloak/sign-in-with-oidc.png)

This will take you to the AAF Discovery Service (note that the name and description you provided when registering your service will appear here). 

* Select your organisation from the list provided and click 'Continue to your organisation'.

![Log into Central](/assets/images/connect-with-keycloak/log-in-to-central.png)

* You will be prompted to enter your username and password.
* Click 'Sign in'.

![Log in to organisation](/assets/images/connect-with-keycloak/login-to-organisation.png)

* If authentication is successful, you will be taken back to your Keycloak account console.

![New user account](/assets/images/connect-with-keycloak/new-user-account.png)


### Skipping Discovery Service


AAF's implementation of OpenID Connect allows service administrators to configure their service [to skip the discovery service](/openid-connect-integration/05-skipping-discovery-service) and login directly through a specified IdP. This can also be done through Keycloak.

### Getting started


Find the **entityID** of the IdP that you wish to directly login through. This can be done by looking through the AAF metadata or your own registrations.

<a href="https://md.test.aaf.edu.au/" class="btn btn-outline-primary mb-3">AAF Test Metadata</a>
<br>
For Example, the AAF Virtual Home is: `https://vho.aaf.edu.au/idp/shibboleth`


### Sending the request

To skip the discovery service, you'll need to add `extra authorization params` to the initial request to the authorisation endpoint.

In Keycloak, first turn off the 'Use discovery endpoint' toggle in the 'OpenID Connect settings' section. Metadata fields will appear underneath and include `Authorization URL`, `Token URL`, `Logout URL`, `Userinfo URL`, and `Issuer`, `Validate Signatures` and `Use PKCE`.

![Skip discovery](/assets/images/connect-with-keycloak/skip-discovery.png)

Add the new param `entityID=<idp-entity>` where the entityID has been URL encoded.

**Example:**

```shell
GET /oidc/authorize?
client_id=123456789&
redirect_uri=https://example.com/aaf/callback&
nonce=123456&
state=6789&
entityID=https://vho.aaf.edu.au/idp/shibboleth
```

* Enter the Authorization URL and the Token URL for the IdP you wish to directly login through.
* Click 'Add'.

* On your newly created identity provider details page, scroll down to the 'OpenID Connect settings' section and click on the 'Advanced' toggle.

![Advanced Toggle](/assets/images/connect-with-keycloak/advanced-toggle.png)

Several new fields will appear:

![Advanced Settings](/assets/images/connect-with-keycloak/advanced-settings.png)

* Scroll down to the 'Forwarded query parameters' field and add the `entityID` parameter. Multiple parameters can be entered, each separated by a comma (,).
* Click 'Save'.

You will now be able to login directly through the specified IdP.