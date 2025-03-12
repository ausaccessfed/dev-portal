---
title: Error response
order: 7
duration: 1
last_updated: 10 March, 2025
---

If an error occurs when validating and processing the authorization request, or when generating the authorization response, an error response will be returned to the callback URL. The error response is an authorization “Error Response” as described in the OAuth 2.0 specification(5), and is returned by redirecting the User’s browser to the Client’s <code>redirect_uri</code>, with query parameters:

```
[redirect_uri]?error=ERROR_CODE&
error_description=DESCRIPTION&state=STATE
```

The parameters shall be completed as follows:

| <code>error</code> | An identifier for the error which occurred, as defined by the OAuth 2.0 specification. |
| <code>error description</code> | A human-readable description of the error which occurred, suitable for troubleshooting purposes.   |
| <code>state</code> | The state value supplied in the authorization request, if any. |

In the event where insufficient accurate information about the client is contained in the authorization request, the user agent may receive an error response. 
