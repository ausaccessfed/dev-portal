---
title: Background
order: 2
duration: 1
---

Unlike regular web applications (with a backend), native and single page applications (SPAs), cannot securely store client secrets. In the past, the only way to authenticate these applications was to use the implicit flow. In this case, 
when a user authenticates with an OIDC Server, the server sends the access token directly to the client on 
redirect, which means that the token is included in the browser's address bar. This is not secure, as the token can 
be leaked through the browser's history, or intercepted by a malicious actor.

![Implicit flow](/assets/images/connect-a-single-page-oidc-service/implicit-flow.png)   

Security requirements have evolved, and the implicit flow is no longer recommended. Instead, the Authorization Code 
flow with PKCE (Proof Key for Code Exchange) is now the recommended method for authenticating SPAs.

![PKCE flow](/assets/images/connect-a-single-page-oidc-service/pkce-flow.png)