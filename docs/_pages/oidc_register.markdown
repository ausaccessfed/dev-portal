---
layout: page
title: OpenID Connect
nav_order: 3
parent: Connect a New Service
has_children: true
---

# Register an OpenID Connect Service
---

{: .note}
Before registering an **OIDC** service, deployers must have sufficient experience in undertaking **OIDC** integration work to create their own **Relying Party (RP)** components with minimal help from the **AAF technical team**. There are several open-source libraries which implement most of the **RP** requirements in several languages, [GitHub](https://github.com) is an excellent resource, as is the [OpenID Foundation](https://openid.net/developers/libraries/). The **AAF** does not offer support or advice in this area, and the choice depends on the subscriber’s strengths and existing knowledge of **OIDC** integration.

The **AAF OpenID Provider (OP)** satisfies the **OIDC** conformance testing framework and passes the Authorization Code flow. The **AAF** monitors the **OP** during business hours and responds to service interruption issues promptly.

---
If you have not done so already, please [log in to Federation Manager](login) to get started.

Once you have clicked on 'OpenID Connect' on the ['Connect a New Service'](connect_service/#connect-a-new-service) page, you will then be taken to the **Register a New Service** page:

![Register new service](/assets/images/register-new-oidc-service.png)

**To complete registration please provide the following information:**

1. Name - A descriptive name for the service.
2. Description - A meaningful description to help users of this service understand its purpose.
3. URL - The primary URL of your application where users will initiate the authentication.
4. Redirect URL - The endpoint which will receive the OIDC responses from AAF. Additional redirect URIs can be added after registration via the client details page.
5. Organisation - Responsible for the operation of the service, must be an **AAF** subscriber.

Click **Register Service** to complete the registration step.

Next you will be provided with the Identifier and Secret used by your **RP** service that is generated during the registration process.

{: .note }
You only have one opportunity to copy the Secret, it cannot be recovered later. You can however generate a new secret later.

**Your service is now available to use immediately in the Test Federation.**

---

## Up Next: [Register a Rapid Connect Service](rapidconnect_register)