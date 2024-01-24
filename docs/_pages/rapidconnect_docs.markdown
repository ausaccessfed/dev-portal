---
layout: page
title: Documentation
permalink: /rapidconnect/documentation/
nav_order: 1
parent: Rapid Connect
grand_parent: Connection Types
---

# Documentation

## Overview

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

{: .note }
While JWTs can do some of the things SAML assertions do, JWTs are not intended as a full replacement for SAML 
assertions, but rather as a token format to be used when ease of implementation or compactness are considerations.

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

```mermaid
sequenceDiagram
    participant web as Web Browser
    participant app_pub as Application - Public content
    participant auth as Authentication Page with <br/> unique Rapid Connect URL
    participant app_priv as Application - Private content

    Note over web,app_priv: The user must be logged in to access private content
    web->>+auth: Logs in to Identity Provider using credentials

    auth->>-web: JWT sent via HTTP Post. Successfully logged in

    Note over web,app_priv: When the user is authenticated, they can now access private content
    
    %%{init:{'theme':'default'}}%%
    %%{init:{'themeCSS':'.messageLine0:nth-of-type(1) { stroke: red; }; .messageLine0:nth-of-type(2) { stroke: green; };'}}%%
 ```

Figure 1. Performing authentication

## Provided claims

The following claims are provided by AAF Rapid Connect:

| Claim                         | Definition                                                                                                                                                                                                                                                               |
|:------------------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| iss                           | Identifies the principal that issued the JWT. For AAF Rapid Connect this is always https://rapid.aaf.edu.au in the production environment, and https://rapid.test.aaf.edu.au in the test environment.                                                                    |
| iat                           | Identifies the time at which the JWT was issued.                                                                                                                                                                                                                         |
| jti                           | Provides a unique identifier for the JWT that can be used to prevent the JWT from being replayed.                                                                                                                                                                        |
| nbf                           | Identifies the time before which the JWT MUST NOT be accepted for processing.                                                                                                                                                                                            |
| exp                           | Identifies the expiration time on or after which the JWT MUST NOT be accepted for processing.                                                                                                                                                                            |
| typ                           | Declare a type for the contents of this JWT Claims Set in an application-specific manner in contexts where this is useful to the application.                                                                                                                            |
| aud                           | Identifies the audiences that the JWT is intended for. Each principal intended to process the JWT MUST identify itself with a value in audience claim. For Rapid Connect this is the value of your application's primary URL (provided as part of service registration). |
| sub                           | Identifies the principal that is the subject of the JWT. For Rapid Connect this is the same value supplied as edupersontargetedid within https://aaf.edu.au/attributes as documented below.                                                                              |
| https://aaf.edu.au/attributes | Contains a set of personally identifiable information associated with sub as provided by the remote AAF connected identity provider.                                                                                                                                     |

Timestamps are defined by the specification as `IntDate` values, which are a JSON numeric value representing the number of seconds from 1970-01-01T0:0:0Z UTC until the specified UTC date/time.