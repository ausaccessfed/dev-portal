---
title: Register service
order: 2
duration: 1
---

The **AAF OpenID Provider (OP)** satisfies the **OIDC** conformance testing framework and passes the Authorization Code flow. The **AAF** monitors the **OP** during business hours and responds to service interruption issues promptly.

---
If you have not done so already, please [log into Federation Manager](/log-into-federation-manager/01-overview) to get started.

Once you have clicked on 'OpenID Connect' on the ['Connect a New Service'](https://manager.test.aaf.edu.au/connected_services/new) page in Federation Manager, you will then be taken to the **Register a New Service** page:

![Register new service](/assets/images/connect-an-oidc-service/register-oidc-service.png)

**To complete registration please provide the following information:**

1. Name - A descriptive name for the service.
2. Description - A meaningful description to help users of this service understand its purpose.
3. URL - The primary URL of your application where users will initiate the authentication.
4. Redirect URL - The endpoint which will receive the OIDC responses from AAF. Additional redirect URIs can be added after registration via the client details page.
5. Organisation - Responsible for the operation of the service, must be an **AAF** subscriber.


- Click **Register Service** to complete the registration step.

You will be provided with the Identifier and Secret used by your **RP** service that is generated during the 
registration process.

You only have one opportunity to copy the Secret, it cannot be recovered later. You can however generate a new secret later.
{: .callout-warning }

Your service is now available to use immediately in the Test Federation!
{: .callout-success }