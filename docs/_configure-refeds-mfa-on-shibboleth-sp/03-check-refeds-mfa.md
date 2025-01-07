---
title: Checking REFEDS MFA
order: 3
duration: 1
---

After the SP sends the MFA requirement to the IdP, the IdP must then check the `<AuthnContextClassRef>` element in the AuthnRequest message.

If the URI of the REFEDS MFA Profile is present, the IdP must include the REFEDS MFA in its response to ensure that the user is authenticated using MFA. 

This is accomplished by including the `<AuthnContextClassRef>` element in the IdP's Response message and is most easily done by replacing the `require shibboleth` stub on the third line of the Apache configuration file as shown 
below:

```apache
<Location /auth/login>
    AuthType shibboleth 
    require shibboleth
    ShibRequestSetting requireSession true
    ShibRequestSetting authnContextClassRef https://refeds.org/profile/mfa
</Location>
```

with the following: `require authnContextClassRef https://refeds.org/profile/mfa`

```apache
<Location /auth/login>
    AuthType shibboleth 
    require authnContextClassRef https://refeds.org/profile/mfa
    ShibRequestSetting requireSession true
    ShibRequestSetting authnContextClassRef https://refeds.org/profile/mfa
</Location>
```

If there are other `require` rules in the Apache configuration file, the `require authnContextClassRef https://refeds.org/profile/mfa` rule should be added to the list of rules which should then all be wrapped 
in a `<RequireAll>` block and joined with a logical <strong>AND</strong>. If this is not done, Apache will apply default <strong>OR</strong> logic.