---
title: Standard Flow
order: 4
duration: 1
last_updated: 07 March, 2025
---

1. The user accesses your application and is provided access to any public content you wish them to see.

2. When authentication is required, users need to be directed to a specific URL within AAF Rapid Connect unique to your application which is provided as part of registration. This can be achieved by:
    1. Presenting the unique URL as a link on your authentication page for the user to click on.
    2. Code within your application provides the user's browser with a 302 response directing the browser to the unique URL.

3. The user will authenticate to their institution's Identity Provider via their usual means. If the user's IdP is known in advance, it can be specified by appending its entityID to the unique Rapid Connect URL:

   `https://rapid.example.com/jwt/authnrequest/auresearch/L4FF32123-YXlnb8w?entityID=https://example.org/idp/shibboleth`

   If no entityID is specified, the user will select their Identity Provider from a list of providers at the AAF Discovery Service.

4. AAF Rapid Connect will validate the user's identity information and generate a unique and signed JWT (JWS) for your application using the secret you define when you register your service.
5. The generated JWT (JWS) will be sent via HTTP POST to the callback endpoint for your application which you define when you register your service.

![JWT authentication](/assets/images/rapid-connect-integration/jwt-authentication.png)

**Figure 1.** Rapid Connect JWT Authentication