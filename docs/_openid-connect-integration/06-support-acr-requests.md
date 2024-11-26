---
title: Supported ACR Requests
order: 7
duration: 1
---

Currently, the only supported ACR value is the [`https://refeds.org/profile/mfa`](https://refeds.org/profile/mfa) value. This value is used to request the REFEDS MFA profile for the user. If the user's IdP supports the REFEDS MFA profile, the AAF OpenID Provider will return the REFEDS MFA profile attributes in the ID Token. If the user's IdP does not support the REFEDS MFA profile, the AAF OpenID Provider will return an error to your service.

## Example OIDC Request

```http
POST /oidc/authorize HTTP/1.1
Host: central.aaf.edu.au
Content-Type: application/x-www-form-urlencoded

response_type=code&
client_id=your-client-id&
redirect_uri=https://your-app.example.com/callback&
scope=openid%20profile&
acr=https://refeds.org/profile/mfa&
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