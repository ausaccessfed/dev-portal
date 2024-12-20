---
title: Checking REFEDS MFA
order: 3
duration: 1
---

The Identity Provider (IdP) must then check the AuthnContextClassRef element in the AuthnRequest message. If the URI
of the REFEDS MFA Profile is present, the IdP must ensure that the user is authenticated using MFA. 

The identity provider must then include the AuthnContextClassRef element in the Response message. This is most 
easily done by replacing the `require shibboleth` stub with `require authnContextClassRef https://refeds.org/profile/mfa` in the Apache configuration 
file as shown below.

An HTTP 401 Authorization Required error page is also included in the configuration file to block further access 
and inform the user that MFA is required to access the resource. The user is also provided with a link to 
reauthenticate with MFA.

```apache
<Location /auth/login>
    AuthType shibboleth 
    require authnContextClassRef https://refeds.org/profile/mfa
    ShibRequestSetting requireSession true
    ShibRequestSetting authnContextClassRef https://refeds.org/profile/mfa
    ErrorDocument 401 "<h1>Access denied: MFA required</h1>Multi-Factor Authentication is required to access this resource, but you have logged in without MFA confirmed.<p>You can try <a href=\"/Shibboleth.sso/Login?target=/auth/login&authnContextClassRef=https://refeds.org/profile/mfa\">logging in again with MFA</a>."
</Location>
```

The SP must check the AuthnContextClassRef element in the Response message.