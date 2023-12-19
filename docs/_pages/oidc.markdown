---
layout: page
title: OpenID Connect
permalink: /oidc/
nav_order: 2
parent: How to connect
callouts:
  highlight:
    title: Highlight
    color: yellow

---

<h1>Benefits</h1>
<div class="bg-grey-lt-000">
<h2>Easy to Deploy</h2>


<h2>Wide Language Support</h2>


<h2>Low Code</h2>


<h2>Easy to Test</h2>

</div>

<hr>

# Documentation
## Overview

The **AAF** supports **OpenID Connect (OIDC)** connectivity and operates an OpenID Provider (OP) which authenticates 
users who have an account at any **AAF** subscriber **Identity Provider (IdP)**. This service is a production choice 
available to AAF subscribers to connect their OIDC services to the Federation. This is an maturing service and at 
this stage only supports a subset of attributes/claims (**for attribute requirements outside this range, please 
contact us to discuss**).

To get started, visit

-  [Our test federation](https://manager.test.aaf.edu.au/oidc)

-  [Our production federation](https://manager.aaf.edu.au/oidc)

## Attributes / Claims


These are the attributes/claims Central can provide to an RP currently:

| Supported Scopes             | Claims                                                                                                                                  |
|------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------|
| openid                       | Returns the sub claim, which uniquely identifies the user. In an ID Token, iss, aud, exp, iat, and at_hash claims will also be present. |
| profile                      | Returns claims that represent basic profile information, including name, family_name, given_name and preferred_username.                |
| email                        | Returns the email claim, which contains the user's email address.                                                                       |
| phone                        | Returns the phone_number of the user. Not many AAF IdPs will return this value.                                                         |
| aueduperson                  | Returns the users au_edu_person_shared_token value                                                                                      |
| eduperson_affiliation        | Returns the users eduperson_affiliation value                                                                                           |
| eduperson_assurance          | Returns the users eduperson_assurance  value                                                                                            |
| eduperson_orcid              | Returns the users eduperson_orcid  value                                                                                                |
| eduperson_principal_name     | Returns the users eduperson_principal_name  value                                                                                       |
| eduperson_scoped_affiliation | Returns the users eduperson_scoped_affiliation  value                                                                                   |
| schac_home_organization      | Returns the users schac_home_organization value                                                                                         |

> {: .highlight }
   Note: A claim for a user will only be provided if their home organisation provides the specific attribute. For 
> example most universities will NOT provide phone numbers for their users.


## Details

Before registering an **OIDC** service, deployers must have sufficient experience in undertaking *OIDC* integration 
work 
to create their own **Relying Party (RP)** components with minimal help from the AAF technical team. There are several 
open-source libraries which implement most of the RP requirements in several languages, [GitHub](https://github.com) 
is an excellent 
resource, as is the [OpenID Foundation](https://openid.net/developers/libraries/). The AAF does not offer support or 
advice in this area, and the choice depends on the subscriber’s strengths and existing knowledge of OIDC integration.


The **AAF OP** satisfies the **OIDC** conformance testing framework and passes the Authorization Code flow. The **AAF** 
monitors the **OP** during business hours and responds to service interruption issues promptly.

To register a new **OIDC RP** please visit:

[AAF Production environment](https://manager.aaf.edu.au/oidc/clients/new){: .btn .btn-blue .text-center }

[AAF Test environment](https://manager.test.aaf.edu.au/oidc/clients/new){: .btn .btn-blue .text-center }

and select the **Register a New Service**. The following information is required:

1. Client Name - a descriptive name for the service.
2. Description -a meaningful description to help users of this service understand its purpose 
3. Organisation - responsible for the operation of the service, must be an AAF subscriber.
4. Redirect URL - The endpoint which will receive the OIDC responses from AAF. Additional redirect URIs can be added after registration via the client details page.


Click the **Resister Service** to complete the registration step.


Next you will be provided the Client ID and Secret used by your **RP** service that is generated during the registration process.

> {: .highlight }
Note: You only have one opportunity to copy the Secret, it cannot be recovered later. You can however generate a new secret later.

Verify the details are correct, then hit the Active button.

    In the test federation your service will be available to use immediately
    In production, the service MUST be approved by your organisation and the AAF before it will be available for use.










	
	
	
	



	
	
	
	
	