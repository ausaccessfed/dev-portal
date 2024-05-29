---
title: Authentication Interaction
order: 2
duration: 1
---

The Rapid Connect service manages the Shibboleth Service Provider (SP) component on behalf of the application, 
simplifying the integration process for developers. For information regarding the deployment and operation of 
Shibboleth refer to the [Shibboleth documentation](https://shibboleth.atlassian.net/wiki/spaces). The Rapid Connect 
service provides a SAML 
end-point, translation between SAML and JSON Web Token (JWT), redirection of requests and validation of the JWT. This simplifies the integration work necessary to connect an application and removes the need to test and deploy an SP component. All other logic remains in the application, enabling the use of cloud services which do not support the addition of Shibboleth directly, such as Heroku and Google App Engine. 

The design goal for Rapid Connect was to ensure as few dependencies as possible to simplify deployment. This requires that user access decisions and interactions all occur within the application.

To deliver a service using Rapid Connect, an application **must** be capable of performing redirects and receiving a JWT response.
{: .callout-info}

### User Registration and User Attributes
#### User Registration

With federated authentication, there is no requirement for user registration in the traditional sense. Additionally, there is no need for users to store a password within a web application unless non-web access is necessary, such as a desktop application’s access to a web API.

Once user session management is under control, additional flow controls can be initiated which can include auto-provisioning, or updating profiles with attributes that have changed, or forcing users through a one-time process such as a “Term of Service” agreement. Developers should consider mechanisms for the auto-provisioning of users on first access, with their details kept up-to-date automatically during subsequent logins.

#### Effective Use of Attributes

The AAF offers a set of core attributes each with varying uses. Although it is tempting to request a wide range of attributes to capture as much information as possible about users, only consider what is truly necessary to provide a service.

The following attributes are available to Rapid Connect and the AAF recommends:
- `eduPersonTargetedID` — This should be used as the primary identifier, to match an incoming user against an existing record in an application's data store. This attribute is guaranteed to never change for a user.

- `displayName` — This is the most appropriate name to show in the web interface, to identify the user and show that they are logged in. Do not rely on any specific format for displayName. Attempts to validate names will create problems for those users who do not fit the chosen patterns and this will invariably occur.

- `mail` — Only collect if there is a need to message the user, or use as a secondary identifier. 

- `eduPersonScopedAffiliation` — Only collect if there is a need to identify the user's organisation and their affiliation or position within their organisation.

See the [Support Portal Attributes page](https://support.aaf.edu.au/support/solutions/folders/19000156050) for complete information and definitions of the AAF attributes available.

The AAF strongly recommends that `eduPersonTargetedID` is chosen as the primary identifier rather than `email`. `Email` addresses change on an irregular basis for numerous reasons. When they inevitably do change, users experience service disruption while manual remediation work is undertaken to update primary identifiers. Home institutions will invariably not communicate email addresses updates to external parties.
{: .callout-info}
Though `auEduPersonSharedToken` is a core attribute, it is not recommended for general use or as a primary identifier. `auEduPersonSharedToken` is only useful in grid-computing environments, or to share user data or access rules across security domains or separate Service Providers.
{: .callout-info}


#### Consuming attributes injected by the SP

There are two basic models for implementing a Shibboleth Service Provider (SP)

- Directly protect all the content with the SP

- Protect a "login" endpoint with the SP, and use that endpoint to establish a session with the application

The second of these is more common and much more flexible but requires a little more work.


<h5>Directly protecting content with the SP</h5>

This model best suits static content, or web applications with no need to maintain session state (e.g. displaying a user's name purely for personalisation). In this model, the flow of a request is quite simple:

![Directly protecting content](/assets/images/rapid-connect-integration/protecting-static-content.png)

For each request, Shibboleth will verify the user's session with the SP and pass the attributes through to the application. When the user's session expires, they will be transparently authenticated again and be able to continue. This approach is supported out-of-the-box by the SP by simply requiring a Shibboleth session for the entire website.

<h5>Managing user sessions</h5>

In this model, the request flow is a little more complex but affords greater control:

![Managing user sessions](/assets/images/rapid-connect-integration/managing-user-sessions.png)

These are examples of potential setups with endpoint names and specific details for illustrative purposes. In this scenario, when the user attempts to access the *Protected Content* without an active session, they would be directed to a login selection page (which is *Unprotected Content*), where the user could choose to log in via the AAF or any other mechanisms that are available. From there, the user's browser would be sent to the login mechanism chosen:

- `/auth/aaf` which accepts attributes from Shibboleth SP and creates a session which can be inspected later to verify the user has authenticated. It is intuitive that a Rapid Connect Callback URL could replace `/auth/aaf` if Rapid Connect was in use instead of a Shibboleth SP.
- `/auth/other` that provides an alternate login mechanism for users who are not part of the federation, or for special use cases such as an administrative login. In a real app, there can be as few or as many login mechanisms as necessary with any endpoint naming scheme.

On establishing session management control, the developer can launch other processes or flows such as auto-provisioning of new users, updating attributes of returning users or forcing users through a one-time “Terms of Service” page for the service. The *Application Request Filter* detects any unauthenticated sessions and redirects the user to the login selection page. The establishment of a user session permits access to the *Protected Content* by the *Application Request Filter*.