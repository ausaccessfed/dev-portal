---
title: Requesting REFEDS MFA
order: 2
duration: 1
---

To signal the MFA requirement, the SP must include an `<AuthnContextClassRef>` element in the AuthnRequest message. This element must contain the URI of the REFEDS MFA Profile:

```
https://refeds.org/profile/mfa
```

Requesting REFEDS MFA can be done in explicitly or implicitly initiated sessions.

## Explicitly initiated sessions

If redirecting to the SessionInitiator, the SP must include the `<AuthnContextClassRef>` element in the AuthnRequest message. This element must contain the URI of the REFEDS MFA Profile.

For example, include the query string parameter `authnContextClassRef` in the URL of the Session Initiator (e.g. `/Shibboleth/Login`):

```
https://validator.aaf.edu.au/Shibboleth.sso/Login?target=/auth/login&authnContextClassRef=https://refeds.org/profile/mfa
```
<br>


## Implicitly initiated sessions

If the session is initiated implicitly, that is by accessing a page requiring a Shibboleth session, the [content setting](https://shibboleth.atlassian.net/wiki/spaces/SP3/pages/2065334723/ContentSettings) `authnContextClassRef` should be added to the Apache config file requesting a Shibboleth session. 

For example, add the following:

```
<Location /auth/login>
    AuthType shibboleth
    require shibboleth
    ShibRequestSetting requireSession true
    ShibRequestSetting authnContextClassRef https://refeds.org/profile/mfa
</Location>
```

If there are other `require` rules in the Apache configuration file, the `require authnContextClassRef https://refeds.org/profile/mfa` rule should be added to the list of rules which should then all be wrapped
in a `<RequireAll>` block and joined with a logical <strong>AND</strong>. If this is not done, Apache will apply default <strong>OR</strong> logic.