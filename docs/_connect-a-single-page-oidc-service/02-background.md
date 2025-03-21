---
title: Background
order: 2
duration: 1
last_updated: 20 March, 2025
---

Unlike regular web applications (with a backend), native and single page applications (SPAs), *cannot* securely store client secrets.

## Implicit flow with OIDC

In the past, the only way to authenticate these applications was to use the implicit flow. In this case, when a user authenticates with an OIDC Server, the server sends the access token directly to the client on redirect, which means that the token is included in the browser's address bar. This is not secure, as the token can be leaked through the browser's history, or intercepted by a malicious actor.

Due to this lack of security, the AAF has made the decision **not to** support the implicit flow for SPAs.

![Implicit flow](/assets/images/connect-a-single-page-oidc-service/implicit-flow.png)   

## Authorization Code flow with PKCE

Security requirements have evolved, and the implicit flow is no longer recommended for SPAs. In its place, the Authorization Code flow with PKCE (Proof Key for Code Exchange) has become the preferable method as it does not expose the token to the browser. Instead, a CORs request is made to the token endpoints and a client secret is not required.

![PKCE flow](/assets/images/connect-a-single-page-oidc-service/pkce-flow.png)

For more information or support regarding any CORs issues that you may experience with using this new feature, please reach out to the <a href="mailto:support@aaf.edu.au">AAF Support</a> Team.
{: .callout-info }