---
last_updated: 27 November, 2026
title: Supported ACR Requests
order: 7
duration: 1
---


The Authentication Context Class Reference (ACR) is a string that specifies the authentication context used during the authentication process. For more information, refer to the [OpenID Connect Core 1.0 specification](https://openid.net/specs/openid-connect-core-1_0.html#acrSemantics).

By specifying the required authentication context, you can ensure that users are authenticated using stronger methods, such as multi-factor authentication (MFA).

The [development federation's OpenID Configuration](https://central.dev.aaf.edu.au/.well-known/openid-configuration) advertises these supported ACR values:

- [`https://refeds.org/profile/mfa`](https://refeds.org/profile/mfa) requests the REFEDS MFA profile for the user. If the user's IdP supports the REFEDS MFA profile, the AAF OpenID Provider will return the REFEDS MFA profile attributes in the ID Token. If the user's IdP does not support the REFEDS MFA profile, the AAF OpenID Provider will return an error to your service.
- `urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport` is the SAML 2.0 `PasswordProtectedTransport` authentication context class.

## Example OIDC Request

```http
POST /oidc/authorize HTTP/1.1
Host: central.aaf.edu.au
Content-Type: application/x-www-form-urlencoded

response_type=code&
client_id=your-client-id&
redirect_uri=https://your-app.example.com/callback&
scope=openid%20profile&
acr_values=https://refeds.org/profile/mfa&
state=af0ifjsldkj&
nonce=n-0S6_WzA2Mj
```

## Example Successful Response

<p class="callout-info">Note: This is the decoded ID Token and is for demonstration purposes only. The actual ID Token will be a JWT. </p>

```json
{
  "iss": "https://central.aaf.edu.au",
  "sub": "1234567890",
  "aud": "your-client-id",
  "acr": "https://refeds.org/profile/mfa",
  "auth_time": 1609446400,
  "iat": 1609446400,
  "exp": 1609450000
}
```

## Example Error Response

If the users' IdP does not support the REFEDS MFA profile, the following error response will be returned:

```json
{
  "error": "insufficient_authentication_level",
  "error_description": "A different level of authentication is required",
  "acr": "https://refeds.org/profile/mfa"
}
```
