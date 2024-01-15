---
layout: page
title: Verifid
permalink: /verifid/
nav_order: 4
parent: How to connect
---

# Documentation

The keywords "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in RFC 2119.

## Change log

| Date       | Description                                                                    |
|:-----------|:-------------------------------------------------------------------------------|
| 2018-05-16 | Initial version                                                                |
| 2018-11-15 | Added staff verification <br> Added client-side discovery support              |
| 2018-12-10 | Expanded verification to full set of affiliation values                        |
 | 2019-11-01 | Modified to new VerifID branding                                               |
 | 2020-11-10 | Add User-Agent header requirement                                              |
 | 2020-11-11 | Explicitly detail need to percent encode any request value that contains a URL |


## Overview

VerifID is used to verify that a User belonging to an Organisation has a certain desired Affiliation with the institution. The VerifID service will:


> - Provide an API for a Subscriber’s Client to interact with. The API will enable the verification workflow to occur. 
> 
> - Provide no data about a User other than their Affiliation to the institution. The status will be provided by the User’s Organisation at the point of verification and the accuracy of this information is outside VerifID Service Operators' responsibilities. 
> 
> - Retain sufficient log information regarding each verification request. 


## Interaction

The primary interaction of this service requires a User who is accessing a web-based service via a standard web browser.

1. A Client identifies a need to verify the User’s Affiliation values 

1. Client issues a Verification request as specified in Appendix B of this document 

1. Via VerifID, the User is directed to perform an interactive authentication via the VerifID operator’s SAML federation 

1. Upon successful authentication, the User returns to VerifID, which issues a Verification response as specified in Appendix B of this document 

1. The Client makes an authenticated request to retrieve an access token which can be used to retrieve the Verification result 

1. The Client makes an API call to VerifID to retrieve the Verification result 

1. The Verification result is parsed and the Client can use the data within to determine the User’s Affiliation values.

```mermaid
flowchart TD
id1[Client] --->|2a. Verification Request - redirect| id2[User Agent - Web Browser]
id2 --->|2b. Verification Request - redirect| id3[Verifid]
id3 --->|3. Interactive authentication <br> via VerifID Service <br> Operator's federation| id4((SAML Federation))
id4 --->|3. Interactive authentication <br> via VerifID Service <br> Operator's federation| id3[Verifid]
id3 --->|4a. Verification Response - redirect| id2[User Agent - Web Browser]
id2 --->|4b. Verification Response - redirect| id1[Client]
id3 --->|5. Retrieve access token| id1[Client]
id3 --->|6. Retrieve verification result| id1[Client]
style id1 fill:#f96,stroke:#333
style id2 fill:#f96,stroke:#333
style id3 fill:#f96,stroke:#333
style id4 fill:#CBC3E3,stroke:#333
linkStyle 0 stroke-width:4px,stroke:green
linkStyle 1 stroke-width:4px,stroke:green
linkStyle 2 stroke-width:4px,stroke:green
linkStyle 3 stroke-width:4px,stroke:blue
linkStyle 4 stroke-width:4px,stroke:blue
linkStyle 5 stroke-width:4px,stroke:blue
linkStyle 6 stroke-width:4px,stroke:blue
linkStyle 7 stroke-width:4px,stroke:blue
```

**Figure 1.** Performing a Verification


## Appendix A: Glossary

**Affiliation** means a value of the “eduPersonAffiliation” attribute asserted by the Organisation for the User.

**Client** means a service operated by a VerifID customer, that wishes to verify the User’s Affiliation values.

**Organisation** means the SAML Identity Provider which is responsible for authenticating a User, and the source of truth for their identity data.

**VerifID Service Operator** means the legal entity offering the VerifID service to a Subscriber through a commercial contract defined outside of this document.

**Subscriber** means an organisation that subscribes to the VerifID service and is in good standing with the VerifID Service Operator.

**User** means a third party who is consuming a public-facing component of the Client via a web browser.

**VerifID** means the service and API defined by this document.

**Verification** refers to the interactive process of authenticating a User against their Organisation and returning to the Client a result relating to the User’s Affiliation values. 


## Appendix B: Technical Specification

The interaction used between the Subscriber and VerifID is the Authorization Code Grant(1) as defined by the OAuth 2.
0 specification (RFC 6749).

Unless explicitly described as optional, **all** parameters are required (i.e. no parameters are optional) in all request and response payloads. This includes parameters which are described by the OAuth 2.0 specification as optional.

Example URLs are based off the `https://example.edu` hostname. Your VerifID Service Operator will ***advise you of the production hostname*** during Client registration.

The information under “Endpoint discovery” must be considered authoritative when determining which URL will be used for each request. 


### User Agent

The `User-Agent` request header is a characteristic string that lets servers and network peers identify the application, operating system, vendor, and/or version of the requesting user agent.

For **all** requests to VerifID endpoints a `User-Agent` header **must** be supplied. Requests without a `User-Agent` header may be denied. Developers should note that this is, sadly, often not a header set by HTTP 
client libraries, though all libraries should be easily configurable to add this.

Valid formatting for the User-Agent header is described [here](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/User-Agent). To assist in debugging of requests please ensure version information of the VerifID client code you have in production is communicated within the value you provide. 


### Client registration

When a Client registers with VerifID, the Client shall be registered with the following details: 

| `client_id`    | The unique Client identifier, which shall be assigned by VerifID. The value shall not be longer than 128 characters.|
| `secret` | The secure Client secret, which shall be assigned by VerifID. The value shall not be longer than 128 characters. <br><br>The Client must protect this secret to ensure it is not disclosed. |
| `redirect_uris` | A list of all values permitted for the redirect_uri parameter in the Verification request. Each value must not be longer than 255 characters. Each `redirect_uri` value must be a https:// endpoint, with plaintext http:// endpoints explicitly disallowed in all environments. |

Please contact your VerifID Service Operator for details on how to securely undertake Client registration.

### Endpoint discovery

VerifID is an OAuth 2.0 authorization server, and provides authorization server metadata per the draft standard(2) at the following URL:

`https://example.edu/.well-known/oauth-authorization-server`

The metadata at this URL shall contain the following:

| `issuer` | This is the scheme/hostname of VerifID. For the example URL above, this would be `https://example.edu` |
| `authorization_endpoint` | This is the URL used for the “Verification request” described below. |
| `token_endpoint` | This is the URL used for “Retrieving the access token” as described below. |

Other values shall be provided within this metadata as needed, and their meaning shall be as defined in the draft standard.

**Reminder:** All URLs described in this document are examples, and the information in the authorization server metadata must be considered authoritative for which URLs should be used. 


### Verification request

To initiate Verification, the Client shall issue a request which is an Authorization Request(3) per the OAuth 2.0 specification. This request takes the form of redirecting the User’s browser to VerifID’s “authorization_endpoint” with a query string of the following format:

```
https://example.edu/oauth
/authorize?response_type=code&client_id=CLIENT_ID&
redirect_uri=REDIRECT_URL&scope=verify:student&
state=STATE
```


**Required parameters:**

| `response_type`| The fixed string “code” (without quotes). |
| `client_id` | The unique Client identifier assigned during registration. |
| `redirect_uri`| A callback URL for the Verification response to be delivered. This must be one of the URLs stored with the Client registration. <br><br>We require `redirect_uri` values to be encoded according to [RFC 3986, Section 2.1](https://datatracker.ietf.org/doc/html/rfc3986#section-2.1). This is commonly known as percent or URL encoding. Not using this encoding method may result in HTTP 403, resource forbidden, errors.   |
| `scope` | A space-separated list of scopes requested for Verification. The supported values for VerifID are:{::nomarkdown}<ul><li><code>verify:faculty</li><li>verify:student</li><li>verify:staff</li><li>verify:employee</li><li>verify:member</li><li>verify:affiliate</li><li>verify:alum</li><li>verify:library-walk-in</li><li>verify:*</code></li></ul>{:/} <br>The scope `verify:*` is interpreted specially by VerifID, and is expanded to all verification types granted to the client. When requesting this scope, the verification response will indicate the true set of scopes that are granted.<br><br>Other scopes may be listed among the supported scopes in the authorization server metadata. These are not described in this document and not required for VerifID integration. |
| `state` | An identifier which the Client provides to uniquely identify the Verification request they have initiated. It is recommended that the Client use this to relate request to response and prevent cross-site request forgery. The value must be unique and securely random, and shall be stored by VerifID for auditing purposes. Non-unique values shall be rejected by VerifID and will result in failed Verification requests. The value must be at least 16 characters, and must not exceed 128 characters in length. It must consist of only letters, numbers, hyphens (-) and underscores (_). <br><br>A suggested method of generating a suitable `state` value is:{::nomarkdown}<ol><li>Generate 60 random bytes using a cryptographically secure PRNG;</li> and then <li>Encode those bytes using the URL-safe Base64 encoding scheme.</li></ol>{:/} |

Optional parameters:

| `entity_id` | A preselected SAML Identity Provider provided by the Client which will be used to authenticate the User. If this value is provided, it is the responsibility of the Client to ensure the value represents a valid IdP which is known to VerifID. <br><br>The presence of this value will skip the SAML Discovery Service when performing federated authentication. <br><br>We require `entity_id` values to be encoded according to [RFC 3986, Section 2.1](https://datatracker.ietf.org/doc/html/rfc3986#section-2.1). This is commonly known as percent or URL encoding. Not using this encoding method may result in HTTP 403, resource forbidden, errors.   |


### Verification response

After authenticating to their Organisation via the VerifID Service Operator federation, the result of Verification will be a “protected resource”4 as described in the OAuth 2.0 specification. An authorization response shall be returned by redirecting the User’s browser to the Client’s redirect_uri, with query parameters: 

```
[redirect_uri]?code=AUTHORIZATION_CODE&
scope=verify:student&state=STATE
```

The parameters shall be completed as follows: 

| code           | The authorization code which shall be used to gain an access token for access to the Verification result. The value shall not exceed 128 characters in length. |
| scope | The list of scopes which have been granted for Verification. Clients must allow for a space-separated list of values to be returned here per the OAuth 2.0 specification, even if they only anticipate receiving a single scope.<br><br> The `verify:*` scope will not appear in this list. If it was requested, it will instead be expanded to the true set of scopes that are granted.  |
| state           | The “`state`” value which the Client provided in the Verification request.       |

### Error response

If an error occurs when validating and processing the authorization request, or when generating the authorization response, an error response will be returned to the callback URL. The error response is an authorization “Error Response” as described in the OAuth 2.0 specification5, and is returned by redirecting the User’s browser to the Client’s redirect_uri, with query parameters: 

```
[redirect_uri]?error=ERROR_CODE&
error_description=DESCRIPTION&state=STATE
```

The parameters shall be completed as follows:

| error           | An identifier for the error which occurred, as defined by the OAuth 2.0 specification. |
| error description | A human-readable description of the error which occurred, suitable for troubleshooting purposes.   |
| state           | The state value supplied in the authorization request, if any.      |

In the event where insufficient accurate information about the client is contained in the authorization request, the user agent may receive an error response. 

### API call

#### Retrieving the access token

Before gaining access to the Verification result, the Client uses the Authorization Code returned in the Verification response, and makes an authenticated request to the “token_endpoint”, for example:

`https://example.edu/oauth/token`

The parameters passed to this endpoint must be passed using a POST request with a application/x-www-form-urlencoded body. This HTTP request is authenticated(6) using HTTP basic authentication in the manner described by the OAuth 2.0 specification, with the client ID as username and client secret as password.

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

| grant type | The fixed string “`authorization_code`” (without quotes).|
| redirect_uri | The exact `redirect_uri` provided for the Verification request. <br><br> We require `redirect_uri` values to be encoded according to [RFC 3986, Section 2.1](https://datatracker.ietf.org/doc/html/rfc3986#section-2.1). This is commonly known as percent or URL encoding. Not using this encoding method may result in HTTP 403, resource forbidden, errors. |
| code           | The authorization code returned in the Verification response. |

The response will be in JSON format, for example:
```
{
"access_token": "2YotnFZFEjr1zCsicMWpAA",
"token_type": "bearer",
"expires_in": 600
}
```

The response fields shall be populated as follows:

| access_token | The access token which can be used to access the Verification result. This value shall not be longer than 128 characters.  |
| token_type | The fixed string “bearer”, which describes how the access token can be used.  |
| expires_in | The number of seconds after which the access token will expire.  |


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

### Verification result

This payload describes the result of Verification, and takes the following format:

```
{
  "user": {
    "identifier": "1CeCQp231k7...", 
    "student": true
  },
  "entity_id": "https://idp.example.com
/idp/shibboleth",
  "verification_id":
"kpClHkefsS1hK_wuU3ksdnE341Gh3SwxSRo_tD5L",
  "verification_timestamp": "2018-01-01T00:00:00Z"
} 
```

The fields in the Verification result shall be populated as follows: 

| `user.identifier` | An opaque identifier for this User, which shall be unique to the Client (i.e. the same user will have different identifiers at different Clients). It is recommended that the Client store this identifier if they wish to correlate this Verification with past or future Verifications by the same User. This value shall not be longer than 128 characters.  |
| `user.<affiliation> ` | A boolean value indicating whether the User has the given Affiliation. Only present if the “`verify:<affiliation>`” scope was granted. <br><br> The Affiliation value is substituted for “`<affiliation>`”, from the following list defined by the eduPerson schema(8): {::nomarkdown}<ul><li><code>faculty</li><li>student</li><li>staff</li><li>employee</li><li>member</li><li>affiliate</li><li>alum</li><li>library-walk-in</code></li></ul>{:/} <br> e.g. When the `verify:staff` and `verify:student` scopes are granted, the Verification result will contain “`user.staff`” and “`user.student`” fields.   |
| `entity_id`          | The unique identifier of the originating IdP used for the verification. Note that this will only be present in the response if this functionality has been enabled for the Client. An additional surcharge may apply for this data. |
| `verification_id`    | A unique identifier for this verification. It is recommended that the Client store this for auditing purposes, alongside the original “`state`” provided in the Verification request. This value shall not be longer than 128 characters. |
| `verification_timestamp ` | A timestamp at which this verification was undertaken. This shall be formatted according to the W3 Consortium profile of ISO 8601, in the `YYYY-MM-DDThh:mm:ssTZD` format(9). | 


### How to interpret the Affiliation 

The eduPerson schema(10) defines the attribute “`eduPersonAffiliation`” as follows:

*Specifies the person's relationship(s) to the institution in broad categories such as student, faculty, staff, alum, etc. (See controlled vocabulary).*

On the topic of what criteria define each type of user, the eduPerson schema also notes:

*It is not feasible to attempt to reach broad-scale, precise and binding inter-institutional definitions of affiliations such as faculty and students. Organizations have a variety of business practices and institutional specific uses of common terms. Therefore, each institution will decide the criteria for membership in each affiliation classification. What is desirable is that a reasonable person should find an institution's definition of the affiliation plausible.*

VerifID supplies a boolean value (i.e. true/false) for each Affiliation that forms part of a Verification. Any value which is “true” corresponds to an Affiliation which was present in the User’s set of attributes, and any value which is “false” corresponds to an Affiliation which was not present. VerifID does not augment or derive Affiliations, and instead presents them exactly as they were received from the Organisation.

It should be noted that Affiliation information may change depending on an institution's policies and procedures. The status and accuracy of this information is outside of the VerifID Service Operator’s control. 