---
title: Register service
order: 3
duration: 1
last_updated: 21 March, 2025
---

* Follow the steps for [registering a new OIDC service](/connect-an-oidc-service/02-connect-oidc-service) in Federation Manager (Test).

* However, for the 'Authentication methods' field, make sure to select the option `Proof Key for Code Exchange (PKCE)` (as shown below).

![Register new service](/assets/images/connect-a-single-page-oidc-service/register-spa-oidc-service.png)

Please note that this authentication method is only available for Single Page Applications (SPAs) and Native Applications and *does not* include a client secret as a result of an insecure client.
{: .callout-info }