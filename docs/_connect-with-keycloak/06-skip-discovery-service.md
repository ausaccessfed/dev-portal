---
title: Skip Discovery Service
order: 6
duration: 1
---

AAF's implementation of OpenID Connect allows service administrators to configure their service [to skip the discovery service](/openid-connect-integration/05-skipping-discovery-service) and login directly through a specified IdP. This can also be done through Keycloak.

### Getting started


Find the **entityID** of the IdP that you wish to directly login through. This can be done by looking through the AAF metadata or your own registrations.

<a href="https://md.test.aaf.edu.au/" class="btn btn-outline-primary mb-3">AAF Test Metadata</a>
<br>
For Example, the AAF Virtual Home is: `https://vho.aaf.edu.au/idp/shibboleth`

You can also view the metadata of all the IdPs in the AAF Federation by visiting [AAF Federation Manager](https://manager.aaf.edu.au/identity_providers).

### Sending the request

* On the details page of your newly created identity provider (in this example called 'oidc'), scroll down to the 'OpenID Connect settings' section and click on the 'Advanced' toggle.

![Advanced Toggle](/assets/images/connect-with-keycloak/keycloak-advanced-toggle.png)

Several new fields will appear:

![Advanced Settings](/assets/images/connect-with-keycloak/keycloak-advanced-settings.png)

* Scroll down to the 'Forwarded query parameters' field and add the `entityID=<idp-entity>` parameter. Multiple parameters can be entered, each separated by a comma (,).
* Click 'Save'.

You will now be able to login directly through the specified IdP.