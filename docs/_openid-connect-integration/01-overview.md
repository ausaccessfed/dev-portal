---
title: Overview
order: 1
duration: 1
last_updated: 21 March, 2025
---

The **AAF** supports **OpenID Connect (OIDC)** connectivity and operates an **OpenID Provider (OP)** which authenticates users who have an account at any **AAF** subscriber **Identity Provider (IdP)**. This service is a production choice available to AAF subscribers to connect their OIDC services to the Federation.

### What you'll learn

- Attributes and endpoints used for configuration
- How to configure your service to skip discovery service and login directly through a specified IdP.

### What you'll need

- Sufficient experience in undertaking OIDC integration work to create your own Relying Party (RP) components with minimal help from the AAF technical team.
- There are several open-source libraries which implement most of the RP requirements in several languages, [GitHub](https://github.com) is an excellent resource, as is the [OpenID Foundation](https://openid.net/developers/libraries/).
- Refer to the [OpenID OIDC Overview](https://openid.net/specs/openid-connect-core-1_0.html#Overview) and [OpenID OIDC 
  Terminology](https://openid.net/specs/openid-connect-core-1_0.html#Terminology) for further information.


The AAF *does not* offer support or advice in this area, and the choice depends on the subscriber’s strengths and existing knowledge of OIDC integration.
{: .callout-info}

All links in this tutorial are collated on the [Links Page](/openid-connect-integration/06-links).
{: .info}
