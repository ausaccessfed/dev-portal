---
title: Enable PKCE
order: 7
duration: 1
last_updated: 05 February, 2025
---

<br>

### What is PKCE?

Proof Key for Code Exchange (PKCE) is an extension to the OAuth 2.0 authorization code flow. It is designed to prevent interception of the authorization code by malicious applications. For this reason, PKCE is an OpenID Connect flow that is best suited for mobile and native applications as well as Single Page Applications (SPAs) which cannot securely store a Client Secret.

### How does PKCE work?

A unique code verifier is generated for each authorization request. The code verifier is used to generate a code challenge. The code challenge is sent to the authorization server along with the authorization request. The authorization server uses the code challenge to verify the code verifier when the authorization code is exchanged for an access token.

![PKCE Flow](/assets/images/connect-with-keycloak/keycloak-pkce-flow.png)

Figure 1. Authorization Code Flow with PKCE

<br>

### How to enable PKCE in Keycloak?

1. In the OpenID Connect settings for the identity provider, ensure that `Use discovery endpoint` is set to `Off`. This will allow you to manually configure the OpenID Connect settings.
2. Switch the `Use PKCE` toggle to `On`. This will enable the `PKCE Method` field.
3. Set the `PKCE Method` to `S256`. ***Note that this setting is recommended (instead of `plain`) for security reasons.***

![PKCE Flow](/assets/images/connect-with-keycloak/enable-pkce.png)