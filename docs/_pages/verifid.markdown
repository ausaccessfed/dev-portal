---
layout: page
title: Verifid
permalink: /verifid/
nav_order: 4
parent: How to connect
has_children: true
---

# Documentation

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

1. Via VerifID, the User is directed to perform an interactive authentication via the VerifID operator’s SAML 
   federation 

1. Upon successful authentication, the User returns to VerifID, which issues a Verification response as specified in 
Appendix B of this document 

1. The Client makes an authenticated request to retrieve an access token which can be used to retrieve the 
Verification result 

1. The Client makes an API call to VerifID to retrieve the Verification result 

1. The Verification result is parsed and the Client can use the data within to determine the User’s Affiliation values.

```mermaid
flowchart TD
id1[Client] --->|2a. Verification Request - redirect| id2[User Agent]
id2 --->|2b. Verification Request - redirect| id3[Verifid]
id3 --->|3. Interactive authentication| id4((SAML Federation))
id4 --->|3. Interactive authentication| id3[Verifid]
id3 --->|4a. Verification Response - redirect| id2[User Agent]
id2 --->|4b. Verification Response - redirect| id1[Client]
id3 --->|5. Retrieve access token| id1[Client]
id3 --->|6. Retrieve verification result| id1[Client]
style id1 fill:#f96,stroke:#333
style id2 fill:#f96,stroke:#333
style id3 fill:#f96,stroke:#333
style id4 fill:#CBC3E3,stroke:#333
```

Figure 2. Performing a Verification