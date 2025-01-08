---
title: MFA-specific error handling
order: 3
duration: 1
---

The next step in the configuration process is error handling. If the IdP does not support the requested `authnContextClassRef` it will respond with a redirect to an error page (at the url configured within shibboleth2.xml), with status code: `opensaml::FatalProfileException`.

Customised 401 error pages are encouraged and can be created to suit the needs of the SP. Additional instructions can include:

- Informing the user that MFA is required to access the resource (this is usually due to MFA being requested by the SP but not being supported by the IdP)
- Providing a link to log in again with MFA
- Redirecting the user to a different page
- Providing a contact email address for the IdP's service desk
- Providing a link to the SP's support page

In the example below, the SP has created a customised 401 error page to inform the user that MFA is required to access the resource. The user is also provided with a link to log in again with MFA.

```apache
<Location /auth/login>
AuthType shibboleth
require authnContextClassRef https://refeds.org/profile/mfa
ShibRequestSetting requireSession true
ShibRequestSetting authnContextClassRef https://refeds.org/profile/mfa
ErrorDocument 401 "<h1>Access denied: MFA required</h1>Multi-Factor Authentication is required to access this resource, but you have logged in without MFA confirmed.<p>You can try <a href=\"/Shibboleth.sso/Login?target=/auth/login&authnContextClassRef=https://refeds.org/profile/mfa\">logging in again with MFA</a>."
</Location>
```