---
layout: page
title: OpenID Connect
permalink: /oidc/
nav_order: 1
parent: Connection Types
has_children: true
---

# Documentation
## Overview

The **AAF** supports **OpenID Connect (OIDC)** connectivity and operates an **OpenID Provider (OP)** which authenticates 
users who have an account at any **AAF** subscriber **Identity Provider (IdP)**. This service is a production choice 
available to AAF subscribers to connect their OIDC services to the Federation. This is a maturing service and at 
this stage only supports a subset of attributes/claims. For attribute requirements outside this range, [please contact us to discuss](mailto:support@aaf.edu.au).

## Attributes / Claims

These are the attributes/claims Central can provide to an RP currently:

| Supported Scopes             | Claims                                                                                                                                                                                                                                                              |
|------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| openid                       | Returns the sub claim, which uniquely identifies the user. In an ID Token, iss, aud, exp, iat, and at_hash claims will also be present.                                                                                                                             |
| profile                      | Returns claims that represent basic profile information, including name, [family_name](https://validator.aaf.edu.au/documentation/attributes/oid:2.5.4.4), [given_name](https://validator.aaf.edu.au/documentation/attributes/oid:2.5.4.42) and preferred_username. |
| email                        | Returns the email claim, which contains the user's [email address](https://validator.aaf.edu.au/documentation/attributes/oid:0.9.2342.19200300.100.1.3).                                                                                                            |
| phone                        | Returns the [phone_number](https://validator.aaf.edu.au/documentation/attributes/oid:2.5.4.20) of the user. Not many AAF IdPs will return this value.                                                                                                               |
| aueduperson                  | Returns the users [au_edu_person_shared_token](https://validator.aaf.edu.au/documentation/attributes/oid:1.3.6.1.4.1.27856.1.2.5) value                                                                                                                             |
| eduperson_affiliation        | Returns the users [eduperson_affiliation](https://validator.aaf.edu.au/documentation/attributes/oid:1.3.6.1.4.1.5923.1.1.1.1) value                                                                                                                                 |
| eduperson_assurance          | Returns the users [eduperson_assurance](https://validator.aaf.edu.au/documentation/attributes/oid:1.3.6.1.4.1.5923.1.1.1.11) value                                                                                                                                  |
| eduperson_orcid              | Returns the users [eduperson_orcid](https://validator.aaf.edu.au/documentation/attributes/oid:1.3.6.1.4.1.5923.1.1.1.16) value                                                                                                                                      |
| eduperson_principal_name     | Returns the users [eduperson_principal_name](https://validator.aaf.edu.au/documentation/attributes/oid:1.3.6.1.4.1.5923.1.1.1.6) value                                                                                                                              |
| eduperson_scoped_affiliation | Returns the users [eduperson_scoped_affiliation](https://validator.aaf.edu.au/documentation/attributes/oid:1.3.6.1.4.1.5923.1.1.1.9) value                                                                                                                          |
| schac_home_organization      | Returns the users [schac_home_organization](https://validator.aaf.edu.au/documentation/attributes/oid:1.3.6.1.4.1.25178.1.2.9) value                                                                                                                                |

{: .note}
A claim for a user will only be provided if their home organisation provides the specific attribute. For example most universities will NOT provide phone numbers for their users.

## [Register your OpenID Connect Service]({% link _pages/oidc_register.markdown %})

## Skipping AAF Discovery Service

AAF's implementation of OpenID Connect allows service admins to configure their service to skip discovery service and login directly through a specified IdP.


### Getting started


Find the entityID of the IdP that you wish to directly login through. This can be done by looking through the AAF metadata or your own registrations.

[Test Metadata](https://md.aaf.edu.au/){: .btn }

[Production Metadata](https://md.test.aaf.edu.au/){: .btn }


For Example, the AAF Virtual Home: https://vho.aaf.edu.au/idp/shibboleth


### Sending the request


To enable SkipDS you'll need to be able to add `extra authorization params`  to the initial request to the 
authorisation endpoint. If you are unable to do so, currently you cannot enable skipDS for your service. (**Note**: we are working on a solution for this).


Add the new param `entityID=<idp-entityID>` where the entityID has been URL encoded.


Example:

```
GET /oidc/authorize?
client_id=123456789&
redirect_uri=https://example.com/aaf/callback&
nonce=123456&
state=6789&
entityID=https://vho.aaf.edu.au/idp/shibboleth
```

This only affects the initial stage of the OIDC flow, it is possible to setup multiple `login` buttons with their own entityID set, allowing you to limit your service to as many or few IdPs as you want.


## Openid Configuration

The **AAF OIDC** service supports querying the **OP** Configuration Information endpoint to retrieve the features and 
capabilities of the **OIDC** service. The **AAF OP** provides two endpoints, one for **Production Federation** and one 
for **Test Federation**, respectively:

- [Production Federation](https://central.aaf.edu.au/.well-known/openid-configuration)

- [Test Federation](https://central.test.aaf.edu.au/.well-known/openid-configuration)


Details for the **Production Federation** are here:

```
curl https://central.aaf.edu.au/.well-known/openid-configuration | jq
{
  "issuer": "https://central.aaf.edu.au",
  "authorization_endpoint": "https://central.aaf.edu.au/oidc/authorize",
  "token_endpoint": "https://central.aaf.edu.au/oidc/token",
  "jwks_uri": "https://central.aaf.edu.au/oidc/jwks",
  "id_token_signing_alg_values_supported": [
    "RS256"
  ],
  "subject_types_supported": [
    "public"
  ],
  "response_types_supported": [
    "code"
  ],
  "scopes_supported": [
    "profile",
    "email",
    "phone",
    "eduperson_affiliation",
    "eduperson_scoped_affiliation",
    "eduperson_entitlement",
    "eduperson_principal_name",
    "eduperson_assurance",
    "eduperson_orcid",
    "schac_home_organization",
    "aueduperson",
    "openid"
  ],
  "userinfo_endpoint": "https://central.aaf.edu.au/oidc/userinfo",
  "claim_types_supported": [
    "normal"
  ],
  "claims_supported": [],
  "claims_locales_supported": [
    "en"
  ],
  "claims_parameter_supported": false,
  "display_values_supported": [
    "page"
  ],
  "grant_types_supported": [
    "authorization_code"
  ],
  "op_policy_uri": "https://central.aaf.edu.au/central/documentation/policy",
  "op_tos_uri": "https://central.aaf.edu.au/central/documentation/tos",
  "request_parameter_supported": false,
  "request_uri_parameter_supported": false,
  "require_request_uri_registration": true,
  "response_modes_supported": [
    "query"
  ],
  "service_documentation": "https://central.aaf.edu.au/oidc/documentation",
  "token_endpoint_auth_methods_supported": [
    "client_secret_basic",
    "client_secret_post"
  ],
  "ui_locales_supported": [
    "en"
  ],
  "userinfo_signing_alg_values_supported": [
    "RS256"
  ]
}
```

## Links

[AAF Production OIDC Provider](https://central.aaf.edu.au/.well-known/openid-configuration)

[AAF Test OIDC Provider](https://central.test.aaf.edu.au/.well-known/openid-configuration)

[OpenID OIDC Developer Libraries](https://openid.net/developers/libraries/)

[OpenID OIDC Overview](https://openid.net/specs/openid-connect-core-1_0.html#Overview)

[OpenID OIDC Terminology](https://openid.net/specs/openid-connect-core-1_0.html#Terminology)