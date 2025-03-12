---
title: Endpoint discovery
order: 5
duration: 1
last_updated: 10 March, 2025
---

VerifID is an OAuth 2.0 authorization server, and provides authorization server metadata per the draft standard(2) at the following URL:

`https://example.edu/.well-known/oauth-authorization-server`

The metadata at this URL shall contain the following:

| `issuer` | This is the scheme/hostname of VerifID. For the example URL above, this would be `https://example.edu` |
| `authorization_endpoint` | This is the URL used for the “Verification request” described below. |
| `token_endpoint` | This is the URL used for “Retrieving the access token” as described below. |

Other values shall be provided within this metadata as needed, and their meaning shall be as defined in the draft standard.

**Reminder:** All URLs described in this document are examples, and the information in the authorization server metadata must be considered authoritative for which URLs should be used. 

