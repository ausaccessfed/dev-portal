---
title: Add an identity provider
order: 5
duration: 5
last_updated: 10 March, 2025
---

* Once in the selected realm (in this example, it is called 'myrealm'), click on 'Identity providers' (at the bottom of the left hand menu bar).

![Identity provider Link](/assets/images/connect-with-keycloak/keycloak-navigate-to-idp.png)

* Click on 'OpenID Connect v1.0' in the 'User-defined' section. This is the open protocol standard that AAF uses to authenticate users in this instance.

![Identity provider Link](/assets/images/connect-with-keycloak/keycloak-idp-selection.png)

* In the 'Add OpenID Connect provider' section, copy the value of the `Redirect URI` field to your clipboard.

![OpenID connect provider](/assets/images/connect-with-keycloak/keycloak-add-oidc-provider.png)

* In a separate browser tab, [register a new OIDC service](https://manager.test.aaf.edu.au/oidc/clients/new) in Federation Manager (Test).

Keep the Keycloak admin console page open as you will need to enter the `Client ID` and `Client Secret` field values provided by Federation Manager into Keycloak.
{: .callout-info}

* On the 'Register a New Service' page (for OpenID Connect) in Federation Manager, paste the `Redirect URI` value obtained from Keycloak into the `Redirect URL` field.

Note: In the development environment, make sure to use `http` for both the URL and Redirect URL.
{: .callout-info }

![Register new service](/assets/images/connect-with-keycloak/keycloak-register-oidc-service-redirect-url.png)

* Once you click 'Register Service' you will receive an 'Identifier' (redacted below) and a 'Secret' from Federation Manager (Test).

You will be able to regenerate the secret later if required.
{: .callout-info}

![Keycloak service](/assets/images/connect-with-keycloak/keycloak-service.png)

* Copy the 'Identifier' and 'Secret' to your clipboard and head back over to Keycloak.
* Paste these items into the `Client ID` and `Client Secret` fields, respectively, within the 'OpenID Connect settings' section of the Keycloak console.

![Oidc provider secret](/assets/images/connect-with-keycloak/keycloak-add-oidc-provider-secret.png)

The other mandatory fields in this section are the `Discovery Endpoint` and `Client Assertion Signature Algorithm`.

<table class="table">
  <thead>
    <tr>
      <th scope="col">Field</th>
      <th scope="col">Value</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th scope="row">Discovery Endpoint</th>
      <td><ul><li>will be: <code>https://central.test.aaf.edu.au/.well-known/openid-configuration</code></li></ul></td>
    </tr>
    <tr>
      <th scope="row">Client Assertion Signature Algorithm</th>
      <td><ul><li>will be <code>RS256</code> as it is the currently available algorithm when signing JWTs. If no algorithm is specified, Keycloak will default to RS256 in the case of a JWT signed with a private key.</li></ul></td>
    </tr>
  </tbody>
</table>

* Click 'Add'.

<br>

You will see the new identity provider settings (as shown below).

![New identity provider settings](/assets/images/connect-with-keycloak/keycloak-new-idp-settings.png)

If you click on the 'Identity providers' option (in the left-hand menu bar), you will now see the newly created identity provider called 'oidc':

![OpenID connect provider](/assets/images/connect-with-keycloak/keycloak-new-identity-provider.png)

### Logging in with the new identity provider

* First ensure that the users you wish to authenticate with this identity provider have been added to the selected realm.
* To do this, click on 'Users' in the left-hand menu bar.

![Users Link](/assets/images/connect-with-keycloak/keycloak-navigate-to-users.png)

* Click on the user you wish to authenticate with the new identity provider.

![Add Selected User](/assets/images/connect-with-keycloak/keycloak-add-selected-user.png)

* In the User Profile, click on 'identity provider links'.

![Link User to IdP](/assets/images/connect-with-keycloak/keycloak-idp-link.png)

* Click 'Link account' next to the new identity provider (in this case, 'oidc').

![Link Account](/assets/images/connect-with-keycloak/keycloak-link-user-account.png)

* Enter the user ID (from the User Details page) and username for the user account you wish to link.
* Click 'Link'.

![Enter User ID](/assets/images/connect-with-keycloak/keycloak-enter-user-id.png)

* You will see that the user account and the identity provider have now been linked.

![Linked Account](/assets/images/connect-with-keycloak/keycloak-linked-user-account.png)

* When next signing in as a user (in this case, `http://localhost:8080/realms/myrealm/account`), you will see the option to sign in with 'oidc' (or whatever `alias` you chose to identify your identity provider).
* Click on 'oidc'.

![Sign in with oidc](/assets/images/connect-with-keycloak/keycloak-sign-in-with-oidc.png)

This will take you to the AAF Discovery Service (note that the name and description you provided when registering your service will appear here).

* Select your organisation from the list provided and click 'Continue to your organisation'.

![Log into Central](/assets/images/connect-with-keycloak/keycloak-log-in-to-central.png)

* You will be prompted to enter your username and password.
* Click 'Sign in'.

![Log in to organisation](/assets/images/connect-with-keycloak/keycloak-login-to-organisation.png)

Your attributes will be displayed, and you will be asked to confirm that you wish to share these with the service you are logging into. 

* Click one of the options and then click 'Approve'.

![Share attributes](/assets/images/connect-with-keycloak/keycloak-share-attributes.png){:style="display:block; margin-left:auto; margin-right:auto"}

* If authentication is successful, you will be taken back to your Keycloak account console.

![New user account](/assets/images/connect-with-keycloak/keycloak-new-user-account.png)