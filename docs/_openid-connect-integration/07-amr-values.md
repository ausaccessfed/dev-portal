---
title: Authentication Method References (AMR)
order: 8
duration: 2
last_updated: 27 November, 2026
---

The `amr` (Authentication Methods References) claim reports the authentication method or methods used to authenticate a user. The AAF OpenID Provider includes this claim in the UserInfo response.

AMR is different from ACR: an ACR value can request an authentication context, while AMR reports the methods used. For details about ACR requests, see [Supported ACR Requests](/openid-connect-integration/06-support-acr-requests).

The values are case-sensitive:

- `pwd` indicates password-based authentication.
- `mfa` indicates multiple-factor authentication.

## Request UserInfo

Send the access token from the OIDC flow to the UserInfo endpoint:

```http
GET /oidc/userinfo HTTP/1.1
Host: central.dev.aaf.edu.au
Authorization: Bearer <access-token>
```

## Example response

The `amr` array contains the methods reported for the authentication. For example, password-based authentication may be reported as:

```json
{
  "sub": "<user-subject>",
  "amr": [
    "pwd"
  ]
}
```

If multiple factors were used, the claim can include `mfa` as well as a method such as `pwd`:

```json
{
  "sub": "<user-subject>",
  "amr": [
    "pwd",
    "mfa"
  ]
}
```

These examples show only the relevant claims. The UserInfo response may include other claims depending on the scopes requested and the attributes available from the user's home organisation.

For the registered AMR values and their definitions, see [RFC 8176](https://www.rfc-editor.org/rfc/rfc8176.html).
