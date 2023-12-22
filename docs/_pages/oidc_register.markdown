---
layout: page
title: Register your service
nav_order: 2
parent: OpenID Connect
grand_parent: How to connect
---

# Register your service
---

Before registering an **OIDC** service, deployers must have sufficient experience in undertaking **OIDC** integration work to create their own **Relying Party (RP)** components with minimal help from the **AAF technical team**. There are several open-source libraries which implement most of the **RP** requirements in several languages, [GitHub](https://github.com) is an excellent resource, as is the [OpenID Foundation](https://openid.net/developers/libraries/). The **AAF** does not offer support or advice in this area, and the choice depends on the subscriber’s strengths and existing knowledge of **OIDC** integration.

The **AAF OpenID Provider (OP)** satisfies the **OIDC** conformance testing framework and passes the Authorization Code flow. The **AAF** monitors the **OP** during business hours and responds to service interruption issues promptly.

To register a new **OIDC RP** please visit:

> [AAF Test Federation](https://manager.test.aaf.edu.au/oidc/clients/new){: .btn }
> 
> or
> 
> [AAF Production Federation](https://manager.aaf.edu.au/oidc/clients/new){: .btn }

You will be prompted to select your Organisation as shown below. Then click 'Continue to your organisation'.

![Select Organisation](/assets/images/sign-in-to-org-FM.png)

Use your Organisation credentials to sign in to Federation Manager (Test or Production).

![Sign in to FM](/assets/images/sign-in-to-FM.png)

If authentication is successful, you will be returned to the **Register a New Service** page:

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

Verify the details are correct, then hit the **Active** button.

1. In the test federation your service will be available to use immediately.
2. In production, the service MUST be approved by your organisation and the AAF before it will be available for use.
