---
title: MFA-specific error handling
order: 3
duration: 1
---

The next step in the configuration process is error handling (refer to the [SAML Integration Tutorial for Shibboleth error handling](/saml-integration/05-configure-shibboleth/#6-errors-element)).

If the IdP does not support the requested `authnContextClassRef` it will respond with a redirect to an error page (at the url configured within shibboleth2.xml), with status code: `opensaml::FatalProfileException`.

The following query paramaters are sent to the configured errorURL when an MFA related error occurs:

```shell
now: Thu Oct  3 04:39:30 2024
requestURL: https://validator.test.aaf.edu.au/Shibboleth.sso/SAML2/POST
errorType: opensaml::FatalProfileException
errorText: SAML response reported an IdP error.
RelayState: https://validator.test.aaf.edu.au/mfa/auth/login
contactEmail: mailto:support@aaf.edu.au
contactName: AAF Support
entityID: https://vho.test.aaf.edu.au/idp/shibboleth
eventType: Login
statusCode: urn:oasis:names:tc:SAML:2.0:status:Requester
statusCode2: urn:oasis:names:tc:SAML:2.0:status:NoAuthnContext
statusMessage: An error occurred.
```

<br>

For more information on requiring MFA and error handling, refer to the links below:

- [Requiring Multi-Factor Authentication](https://shibboleth.atlassian.net/wiki/spaces/SP3/pages/2114781453/Requiring+Multi-Factor+Authentication)
- [Error Handling](https://shibboleth.atlassian.net/wiki/spaces/SP3/pages/2065334361/Errors)