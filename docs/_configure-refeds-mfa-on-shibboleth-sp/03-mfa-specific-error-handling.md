---
last_updated: 02 September, 2026
title: MFA-specific error handling
order: 3
duration: 1
---

The next step in the configuration process is error handling (refer to the [SAML Integration Tutorial for Shibboleth error handling](/saml-integration/05-configure-shibboleth/#6-errors-element)).

If the IdP does not support the requested `authnContextClassRef`, it will respond with a redirect to an error page (at the URL configured within `shibboleth2.xml`) with the status code `opensaml::FatalProfileException`.

## Example error request parameters

The following example shows the request parameters sent to the configured `errorURL` when an MFA-related error occurs:

<table class="table table-striped" style="--bs-table-color: #000;">
  <thead class="thead-light">
    <tr>
      <th scope="col">Parameter</th>
      <th scope="col">Example value</th>
    </tr>
  </thead>
  <tbody>
    <tr><th scope="row">now</th><td>Thu Oct 3 04:39:30 2024</td></tr>
    <tr><th scope="row">requestURL</th><td>https://validator.test.aaf.edu.au/Shibboleth.sso/SAML2/POST</td></tr>
    <tr><th scope="row">errorType</th><td>opensaml::FatalProfileException</td></tr>
    <tr><th scope="row">errorText</th><td>SAML response reported an IdP error.</td></tr>
    <tr><th scope="row">RelayState</th><td>https://validator.test.aaf.edu.au/mfa/auth/login</td></tr>
    <tr><th scope="row">contactEmail</th><td>mailto:support@aaf.edu.au</td></tr>
    <tr><th scope="row">contactName</th><td>AAF Support</td></tr>
    <tr><th scope="row">entityID</th><td>https://vho.test.aaf.edu.au/idp/shibboleth</td></tr>
    <tr><th scope="row">eventType</th><td>Login</td></tr>
    <tr><th scope="row">statusCode</th><td>urn:oasis:names:tc:SAML:2.0:status:Requester</td></tr>
    <tr><th scope="row">statusCode2</th><td>urn:oasis:names:tc:SAML:2.0:status:NoAuthnContext</td></tr>
    <tr><th scope="row">statusMessage</th><td>An error occurred.</td></tr>
  </tbody>
</table>
<br>

For more information on requiring MFA and error handling, refer to the links below:

- [Requiring Multi-Factor Authentication](https://shibboleth.atlassian.net/wiki/spaces/SP3/pages/2114781453/Requiring+Multi-Factor+Authentication)
- [Error Handling](https://shibboleth.atlassian.net/wiki/spaces/SP3/pages/2065334361/Errors)
