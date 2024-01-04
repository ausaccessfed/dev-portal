---
layout: page
title: Rapid Connect
permalink: /rapidconnect/
nav_order: 3
parent: How to connect
has_children: true
---

# Documentation
## Overview

The AAF Rapid Connect service allows the AAF to translate SAML assertions which are verified by a standard Shibboleth SP into JSON Web Token (JWT) which is more suitable for use by services with restricted environments or services with no need to access some of the more advanced parts of the AAF offering.

This document describes JWT for developers and the integration code required to use AAF Rapid Connect with their applications.

    Version: 2.0.0

The keywords "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY",
and "OPTIONAL" in this document are to be interpreted as described in [RFC 2119](https://www.ietf.org/rfc/rfc2119.txt).

## JSON Web Token (JWT)

The following is sourced from the [JWT specification](https://self-issued.info/docs/draft-ietf-oauth-json-web-token.html).

JSON Web Token (JWT) is a compact URL-safe means of representing claims to be transferred between two parties. The claims in a JWT are encoded as a JavaScript Object Notation (JSON) object that is used as the payload of a JSON Web Signature (JWS) structure or as the plaintext of a JSON Web Encryption (JWE) structure, enabling the claims to be digitally signed or MACed and/or encrypted.

The suggested pronunciation of JWT is the same as the English word "jot".

## Relationship of JWTs to SAML Assertions

SAML 2.0 provides a standard for creating security tokens with greater expressiveness and more security options than supported by JWTs. However, the cost of this flexibility and expressiveness is both size and complexity. SAML's use of XML and XML DSIG contributes to the size of SAML assertions; its use of XML and especially XML Canonicalization contributes to their complexity.

JWTs are intended to provide a simple security token format that is small enough to fit into HTTP headers and query arguments in URIs. It does this by supporting a much simpler token model than SAML and using the JSON object encoding syntax. It also supports securing tokens using Message Authentication Codes (MACs) and digital signatures using a smaller (and less flexible) format than XML DSIG.

Therefore, while JWTs can do some of the things SAML assertions do, JWTs are not intended as a full replacement for SAML assertions, but rather as a token format to be used when ease of implementation or compactness are considerations.

## Standard flow

1. The user accesses your application and is provided access to any public content you wish them to see.

2. When authentication is required, users need to be directed to a specific URL within AAF Rapid Connect unique to your application which is provided as part of registration. This can be achieved by:
   1. Presenting the unique URL as a link on your authentication page for the user to click on.
   2. Code within your application provides the user's browser with a 302 response directing the browser to the unique URL.

3. The user will authenticate to their institution's Identity Provider via their usual means. If the user's IdP is known in advance, it can be specified by appending its entityID to the unique Rapid Connect URL:

    `https://rapid.example.com/jwt/authnrequest/auresearch/L4FF32123-YXlnb8w?entityID=https://example.org/idp/shibboleth`

    If no entityID is specified, the user will select their Identity Provider from a list of providers at the AAF Discovery Service.

4. AAF Rapid Connect will validate the user's identity information and generate a unique and signed JWT (JWS) for your application using the secret you define when you register your service.
5. The generated JWT (JWS) will be sent via HTTP POST to the callback endpoint for your application which you define when you register your service.

## Provided claims

The following claims are provided by AAF Rapid Connect:

 - **iss**: Identifies the principal that issued the JWT. For AAF Rapid Connect this is always https://rapid.aaf.edu.au in the production environment, and https://rapid.test.aaf.edu.au in the test environment.
 - **iat**: Identifies the time at which the JWT was issued.
 - **jti**: Provides a unique identifier for the JWT that can be used to prevent the JWT from being replayed.
 - **nbf**: Identifies the time before which the JWT MUST NOT be accepted for processing.
 - **exp**: Identifies the expiration time on or after which the JWT MUST NOT be accepted for processing.
 - **typ**: Declare a type for the contents of this JWT Claims Set in an application-specific manner in contexts where this is useful to the application.
 - **aud**: Identifies the audiences that the JWT is intended for. Each principal intended to process the JWT MUST identify itself with a value in audience claim. For Rapid Connect this is the value of your application's primary URL (provided as part of service registration).
 - **sub**: Identifies the principal that is the subject of the JWT. For Rapid Connect this is the same value supplied as edupersontargetedid within https://aaf.edu.au/attributes as documented below.
 - **https://aaf.edu.au/attributes**: Contains a set of personally identifiable information associated with sub as provided by the remote AAF connected identity provider.

Timestamps are defined by the specification as `IntDate` values, which are a JSON numeric value representing the number of seconds from 1970-01-01T0:0:0Z UTC until the specified UTC date/time.

## Integrating with AAF Rapid Connect
### Before you get started

Before you get started with AAF Rapid Connect, you MUST meet all of the following high level requirements:

1. You MUST be using HTTPS on your webserver for all JWT related endpoints. You SHOULD be using HTTPS for your entire application.
2. The organisation which owns the service you're registering must be an existing AAF subscriber.
3. You must have an existing account with AAF connected Identity Provider which you use to access AAF services.

### AAF Examples

The following AAF developed example code may assist your understanding when writing your own integration code:

- [Ruby](https://gist.github.com/bradleybeddoes/6154072)
- [Python](https://gist.github.com/bradleybeddoes/5b64a39e96298b4811d7)
- [PHP](https://gist.github.com/bradleybeddoes/7051824753235cde90b8)

---
### 1. Select a JWT library

To get started with AAF Rapid Connect integration select a suitable JWT library from the following for your 
application. These libraries will assist developers in quickly implementing JWT support. Libraries are not listed in 
any particular order and not endorsed by us. You should evaluate them individually to determine which best suits 
your needs. Found a useful JWT library not listed here? [Please let us know about it](mailto:support@aaf.edu.au?subject=New JWT library).

| Language | Library                                                                                        | Contributor                                                                                                   |
|----------|------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------|
| Ruby     | [Devise and OmniAuth](https://github.com/jbarona/omniauth-jwt/tree/flexible-options)           | James Barona from the South Australian Health and Medical Research Institute                                  |
|          | [Specific integration example in gist](https://gist.github.com/jbarona/7574703)                |                                                                                                               |
|          | [progrium ruby-jwt](https://github.com/progrium/ruby-jwt)                                      |                                                                                                               |
| Java     | [nimbus-jose-jwt](https://bitbucket.org/nimbusds/nimbus-jose-jwt/wiki/Home)                    |                                                                                                               |
|          | [Google Code Archive jsontoken](https://code.google.com/p/jsontoken)                           |                                                                                                               |
|          | [Oracle jwt](http://docs.oracle.com/cd/E23943_01/security.1111/e10037/jwt.htm#CIHFBCBG)        |                                                                                                               |
| Python   | [magical jwt-python](https://github.com/magical/jwt-python)                                    |                                                                                                               | 
|          | [progrium pyjwt](https://github.com/progrium/pyjwt)                                            |                                                                                                               |
|          | [Example authenticator for CKAN](https://pypi.python.org/pypi/ckanext-aaf?)                    | Louis Des Landes at Swinburne University of Technology                                                        |
| PHP      | [cfrett JWT-PHP](https://github.com/cfrett/JWT-PHP)                                            |                                                                                                               |
|          | [luciferous jwt](https://github.com/luciferous/jwt)                                            |                                                                                                               |
| Node     | [hokaccha node-jwt-simple](https://github.com/hokaccha/node-jwt-simple)                        |                                                                                                               |
| .Net     | [johnsheehan jwt](https://github.com/johnsheehan/jwt)                                          |                                                                                                               |
|          | [NuGet JWT](https://nuget.org/packages/JWT)                                                    |                                                                                                               |
| Go       | [mendsley gojwt](https://github.com/mendsley/gojwt)                                            |                                                                                                               |
| Perl     | [Example Perl Code](https://github.com/spikelynch/Osiris/blob/master/Osiris/lib/Osiris/AAF.pm) | Michael Lynch from EResearch Support Group, Information Technology Division, University of Technology, Sydney |
| Haskell  | [Hackage jwt](https://hackage.haskell.org/package/jwt)                                         |                                                                                                               |
|          | [rapid-connect-yesod-demo](https://github.com/carlohamalainen/rapid-connect-yesod-demo)        | Dr Carlo Hamalainen, Centre for Advanced Imaging, University of Queensland                                    |
| Dart     | [aaf_rapid_connect](https://pub.dev/packages/aaf_rapid_connect)                                |               


### 2. Create a secret

The first step in integrating your code is to compute a secret that will be shared between your application and AAF Rapid Connect for signing and verifying JWT.

Recommended secret generation method on *nix hosts, 32 characters long:

`| LC_CTYPE=C tr -dc '[[:alnum:][:punct:]]' < /dev/urandom | head -c32 ;echo`

This value should never be publicly disclosed. Once created be sure to store it securely. This value will be required during service registration.

### 3. Provide a web accessible endpoint

Your application MUST define a https endpoint which accepts a HTTP POST request.

The endpoint must acquire the data provided in the parameter **assertion** for further processing.

### 4. Validate the signed JWT (JWS) your application has received

Should any stage of the below validation fail your application MUST discard the token and present the user with a suitable error message.

1. Verify that the signature for the signed JWT you have received is valid by using your locally stored secret value
2. Ensure that the **iss** claim has the value https://rapid.aaf.edu.au when in the production environment, or 
   https://rapid.test.aaf.edu.au when in the test environment.
3. Ensure that the **aud** claim has the value of your application's primary URL (provided as part of service 
   registration).
4. The current time MUST be after or equal to the time provided in the **nbf** claim.
5. The current time MUST be before the time provided in the **exp** claim.
6. Ensure that the value of the **jti** claim does not exist in a local storage mechanism of **jti** claim values you 
   have accepted. If it doesn't (this MUST be the case) add the **jti** claim value to your local storage mechanism for 
   protection against replay attacks.

All applications connecting to the AAF must adhere to all relevant [AAF rules and policies](https://aaf.edu.au/support/resources/). Prior to approving the connection of your service to the federation, the AAF may request to review your JWT related code and test your running endpoint to verify that an application's JWT handling conforms to the above requirements.

### 5. Make use of the user's personal information

Your application now has a fully verified JWT provided by AAF Rapid Connect.

By looking at the claim **https://aaf.edu.au/attributes** you will be able to access information about the user which most Research and Scholarly applications require. The following core AAF attributes SHOULD be available:

    1. cn
    2. mail
    3. displayname
    4. edupersontargetedid
    5. edupersonscopedaffiliation
    6. organizationname

The following optional AAF attributes MAY be available at the discretion of the user's Identity Provider:

    1. edupersonprincipalname: The "NetID" of the person for the purposes of inter-institutional authentication.
    2. givenname: A person's first name or preferred name
    3. surname: A person's surname
    4. edupersonorcid: A person's ORCID (https://orcid.org/) identifier, if they have provided one.

You may also be provided with the **auedupersonsharedtoken** attribute if your use case requires it. For more information on **auedupersonsharedtoken**, see this [support article](https://support.aaf.edu.au/support/solutions/articles/19000035966-why-is-auedupersonsharedtoken-no-longer-available-).

You can now use this data to create a local account suitable for internal use by your application, for customisation 
and other purposes. It is RECOMMENDED that you use the data provided in either the JWT claim **sub** or the 
https://aaf.edu.au/attributes claim's **edupersontargetedid** field to uniquely identify users.

The JWT claim **sub** and the **https://aaf.edu.au/attributes** claim's **edupersontargetedid** field are always identical for Rapid Connect. The same value SHALL be provided for all subsequent visits to your application by each user. The full value of the field MUST be utilised to ensure your application uniquely identifies the remote user. Applications MUST NOT split this value based on the delimited bang segments.

The value of **sub/edupersontargetedid** is not able to correlate a user between services. For more details see 
http://wiki.aaf.edu.au/tech-info/attributes/edupersontargetedid.