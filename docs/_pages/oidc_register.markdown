---
layout: page
title: Register your service
nav_order: 1
parent: OpenID Connect
grand_parent: How to connect
---

# Register your service

Before registering an **OIDC** service, deployers must have sufficient experience in undertaking **OIDC** integration
work to create their own **Relying Party (RP)** components with minimal help from the AAF technical team. There are several
open-source libraries which implement most of the RP requirements in several languages, [GitHub](https://github.com)
is an excellent resource, as is the [OpenID Foundation](https://openid.net/developers/libraries/). The AAF does not offer support or
advice in this area, and the choice depends on the subscriber’s strengths and existing knowledge of **OIDC**
integration.

The **AAF OP** satisfies the **OIDC** conformance testing framework and passes the Authorization Code flow. The **AAF**
monitors the **OP** during business hours and responds to service interruption issues promptly.

To register a new **OIDC RP** please visit:

- [AAF Production environment](https://manager.aaf.edu.au/oidc/clients/new){: .btn }

- [AAF Test environment](https://manager.test.aaf.edu.au/oidc/clients/new){: .btn }

and select the **Register a New Service**. The following information is required:

1. Client Name - a descriptive name for the service.
2. Description -a meaningful description to help users of this service understand its purpose
3. Organisation - responsible for the operation of the service, must be an AAF subscriber.
4. Redirect URL - The endpoint which will receive the OIDC responses from AAF. Additional redirect URIs can be added after registration via the client details page.


Click the **Register Service** to complete the registration step.


Next you will be provided the Client ID and Secret used by your **RP** service that is generated during the registration process.

{: .note }
You only have one opportunity to copy the Secret, it cannot be recovered later. You can however generate a new secret later.

Verify the details are correct, then hit the **Active** button.

1. In the test federation your service will be available to use immediately.
2. In production, the service MUST be approved by your organisation and the AAF before it will be available for use.
