---
title: Skipping Discovery Service
order: 5
duration: 1
last_updated:
---

AAF's implementation of OpenID Connect allows service administrators to configure their service to skip discovery service and login directly through a specified IdP.

### Getting started


Find the **entityID** of the IdP that you wish to directly login through. This can be done by looking through the AAF metadata or your own registrations.

<a href="https://md.test.aaf.edu.au/" class="btn btn-outline-primary mb-3">AAF Test Metadata</a>
<br>
For Example, the AAF Virtual Home: `https://vho.aaf.edu.au/idp/shibboleth`


### Sending the request


To enable SkipDS you'll need to be able to add `extra authorization params`  to the initial request to the
authorisation endpoint. If you are unable to do so, currently you cannot enable skipDS for your service. (**Note**: we are working on a solution for this).


Add the new param `entityID=<idp-entityID>` where the entityID has been URL encoded.


**Example:**

Note: Request paramaters should be URL encoded. The following is for demonstration purposes only.
{: .callout-info}

```ruby
GET /oidc/authorize?
    client_id=123456789&
    redirect_uri=https://example.com/aaf/callback&
    nonce=123456&
    state=6789&
    entityID=https://vho.aaf.edu.au/idp/shibboleth
```


This only affects the initial stage of the OIDC flow, it is possible to set up multiple `login` buttons with their own entityID set, allowing you to limit your service to as many or few IdPs as you want.
