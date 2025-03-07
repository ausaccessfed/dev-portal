---
title: Standard Flow
order: 2
duration: 1
last_updated:
---

The OpenID Connect protocol, in abstract, follows the following steps.

- The RP (Client) sends a request to the OpenID Provider (OP).
- The OP authenticates the End-User and obtains authorization.
- The OP responds with an ID Token and usually an Access Token.
- The RP can send a request with the Access Token to the UserInfo Endpoint.
- The UserInfo Endpoint returns Claims about the End-User.


![OIDC Flow](/assets/images/openid-connect-integration/oidc-flow.png)

**Figure 1.** OpenID Connect Protocol