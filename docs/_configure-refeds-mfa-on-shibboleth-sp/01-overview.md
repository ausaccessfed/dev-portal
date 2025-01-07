---
title: Overview
order: 1
duration: 1
---

Service Providers (SPs) can use a signal defined within a profile called the [REFEDS MFA Profile](https://refeds.org/profile/mfa) to request multi-factor authentication (MFA) from an Identity Provider (IdP).

The IdP responds to the SP's request by ensuring that the user is authenticated using MFA. If the user is not authenticated using MFA, the IdP will return an error message to the SP.

This tutorial will guide you through the process of configuring a Shibboleth Service Provider (SP) to use the [REFEDS MFA Profile](https://refeds.org/profile/mfa) for MFA.

### What you'll learn

- How to request REFEDS MFA
- How to check REFEDS MFA
- Error handling

### What you'll need

- To have [integrated your application](/saml-integration) with the SAML protocol
- To have [connected your service](/connect-a-saml-service) with AAF using SAML

<br>

An overview of the steps involved in signaling the MFA requirement by an SP and the response by an IdP is shown below:
![REFEDS MFS](/assets/images/configure-refeds-mfa-on-shibboleth-sp/refeds-mfa.png)

Figure 1. REFEDS MFA signaling and response
