---
title: Supported ACR Requests
order: 7
duration: 1
---


The Authentication Context Class Reference (ACR) is a string that specifies the authentication context used during the authentication process. For more information, refer to the [OpenID Connect Core 1.0 specification](https://openid.net/specs/openid-connect-core-1_0.html#acrSemantics).

By specifying the required authentication context, you can ensure that users are authenticated using stronger methods, such as multi-factor authentication (MFA).

Currently, the only supported authentication context is [`https://refeds.org/profile/mfa`](https://refeds.org/profile/mfa), the REFEDS MFA profile. The AAF OpenID Provider uses the AAF-specific `acr` authorization request parameter to request this context; standard OpenID Connect uses `acr_values` instead. When the requested context is satisfied, the ID Token includes an `acr` claim with its value. If the user's IdP cannot satisfy the requested context, the AAF OpenID Provider redirects to your service with an authorization error.

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

If the user's IdP cannot satisfy the requested REFEDS MFA authentication context, the AAF OpenID Provider redirects to the client's redirect URI with the error details as query parameters:

```http
HTTP/1.1 302 Found
Location: https://your-app.example.com/callback?error=insufficient_authentication_level&error_description=A%20different%20level%20of%20authentication%20is%20required&acr=https%3A%2F%2Frefeds.org%2Fprofile%2Fmfa
```

The error redirect omits `state` because the current Federation Manager behavior does not return it for this error. The request's `state` will round-trip only after the companion Federation Manager fix has landed.
