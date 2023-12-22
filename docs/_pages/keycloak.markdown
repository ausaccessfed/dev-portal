---
layout: page
title: Connect via Keycloak
nav_order: 1
parent: OpenID Connect
grand_parent: How to connect
---

# Documentation
## Overview

[Keycloak](https://www.keycloak.org/) is an open source software solution that provides single sign on access, 
allowing users to authenticate once to access multiple services. It also allows for single sign out, which means that users only have to sign out once for several services and/or applications that use keycloak.

Keycloak can also be used to authenticate users with existing OpenID Connect or SAML 2.0 Identity Providers. This can be done by configuring the Identity Provider through the keycloak admin console.

If you are using Keycloak for the first time, [please refer to their documentation](https://www.keycloak.org/documentation) to get started.

1. Otherwise, if you are already using Keycloak log into the Keycloak Admin Console:

![Keycloak Sign In Page](/assets/images/keycloak-signin-page.png)

2. Once you are signed in, click on 'master' (at the top of the left hand menu bar), then select the appropriate realm 
where you would like to add AAF as an identity provider. In this example, a new realm has been added called 'myrealm'.

![Master Realm Page](/assets/images/master-realm-page.png)

## Add an Identity Provider

3. Once in the selected realm, click on 'identity providers' (at the bottom of the left hand menu bar).

![Identity provider Link](/assets/images/identity-provider-selection.png)

4. Select 'OpenID Connect v1.0' from the 'User-defined' section of the drop-down menu.

![OpenID connect select](/assets/images/open-id-connect-select.png)

5. To set up an OpenID Connect provider, the following fields will need to be obtained from AAF Federation Manager:
>   - Discovery endpoint
>   - Client ID
>   - Client Secret

6. To do this, [connect your OIDC service to the Federation]({% link _pages/oidc_register.markdown %})
