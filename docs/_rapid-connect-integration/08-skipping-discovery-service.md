---
title: Skipping Discovery Service
order: 8
duration: 1
last_updated: 24 January, 2025
---

AAF's implementation of Rapid Connect allows service administrators to configure their service to skip discovery service and login directly through a specified IdP.

### Getting started


Find the **entityID** of the IdP that you wish to directly login through. This can be done by looking through the AAF metadata or your own registrations.

<a href="https://md.test.aaf.edu.au/" class="btn btn-outline-primary mb-3">AAF Test Metadata</a>
<br>
For Example, the entityID for AAF Virtual Home is: `https://vho.aaf.edu.au/idp/shibboleth`


### Sending the request

The unique URL for directing a user’s browser to Rapid Connect can be appended with a specific identity provider’s EntityID (if known).

For example:

`https://application.com.au/jwt/authnrequest?entityID=https://vho.aaf.edu.au/idp/shibboleth`