---
title: API Call
order: 8
duration: 1
last_updated: 2025-03-07 12:26:16 +1000
---

#### Retrieving the access token

Before gaining access to the Verification result, the Client uses the Authorization Code returned in the Verification response, and makes an authenticated request to the “token_endpoint”, for example:

`https://example.edu/oauth/token`

The parameters passed to this endpoint must be passed using a POST request with an application/x-www-form-urlencoded body. This HTTP request is authenticated(6) using HTTP basic authentication in the manner described by the OAuth 2.0 specification, with the client ID as username and client secret as password.

```
POST /oauth/token
Host: example.edu
Authorization: Basic
Q0xJRU5UX0lEOkNMSUVOVF9TRUNSRVRfSEVSRQ==
Content-Type: application/x-www-form-urlencoded
Content-Length: 79

grant_type=authorization_code&
code=AUTHORIZATION_CODE&redirect_uri=REDIRECT_URI
```

The request fields must be populated as follows:

| **grant type** | The fixed string “`authorization_code`” (without quotes).|
| **redirect_uri** | The exact `redirect_uri` provided for the Verification request. <br> We require `redirect_uri` values to be encoded according to [RFC 3986, Section 2.1](https://datatracker.ietf.org/doc/html/rfc3986#section-2.1). This is commonly known as percent or URL encoding. Not using this encoding method may result in HTTP 403, resource forbidden, errors. |
| **code**  | The authorization code returned in the Verification response. |

The response will be in JSON format, for example:
```
{
"access_token": "2YotnFZFEjr1zCsicMWpAA",
"token_type": "bearer",
"expires_in": 600
}
```

The response fields shall be populated as follows:

| **access_token** | The access token which can be used to access the Verification result. This value shall not be longer than 128 characters.  |
| **token_type** | The fixed string “bearer”, which describes how the access token can be used.  |
| **expires_in** | The number of seconds after which the access token will expire.  |


#### Retrieving the Verification result

As indicated by the token_type value, the access token retrieved above is used as a “bearer” token(7) as described by the OAuth 2.0 specification. To access the Verification result, the Client makes a request to the protected resource endpoint:

`https://example.edu/verify/verificationinfo`

The HTTP request is authenticated using this bearer token, for example:

```
GET /verify/verificationinfo
Host: example.edu
Authorization: Bearer 2YotnFZFEjr1zCsicMWpAA 
```

The URL for this request is **not** included in the authorization server metadata (as described in the “Endpoint discovery” section), but instead is computed by taking the “issuer” and the fixed host-relative “`/verify/verificationinfo`” path.
