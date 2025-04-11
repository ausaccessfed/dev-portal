---
title: Define AAF Configuration File
order: 2
duration: 1
last_updated: 08-04-2025
---

* Follow the instructions in the [XNAT documentation](https://wiki.xnat.org/documentation/configuring-authentication-providers) to configure an authentication provider.
* Once you have created a file named `openid-provider.properties` in the `/data/xnat/home/config/auth` directory of your XNAT installation, copy the contents of the following code block into it.

```shell
#
# xnat-openid-auth-plugin: openid-provider-sample-AAF.properties
#
# Copy to $XNAT_HOME/config/auth as 'openid-provider.properties'
# 
#
# Needs to be 'openid'
auth.method=openid
type=openid
provider.id=aaf
# Open ID Providers are not visible they are accessed via login links
auto.enabled=true
auto.verified=true
# Name displayed in the UI
name=OpenID Authentication Provider
# Site URL - the main domain, needed to build the pre-established URL below.
siteUrl=http://localhost
auth.method=openid
preEstablishedRedirUri=/openid-login
# AAF OpenID
openid.aaf.clientId=
openid.aaf.clientSecret=
openid.aaf.accessTokenUri=https://central.test.aaf.edu.au/providers/op/token
openid.aaf.userAuthUri=https://central.test.aaf.edu.au/providers/op/authorize
openid.aaf.scopes=openid,profile,email
openid.aaf.link=<a style="color: #777; width:100%; margin:0 0 20px 0; font-size: 15px; border-radius: 50px; text-indent: 10px; font-weight: bold; border: none; display: inline-block; text-align: center; vertical-align: middle; -webkit-user-select:none; -moz-user-select: none; -ms-user-select: none; user-select: none; background-color: #fff; padding: 0.375 rem 0.75 rem; font-size: 1rem; line-height: 1.5; border-radius: 0.25 rem; box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.1); transition: color .15s ease-in-out,background-color .15s ease-in-out,border-color .15s ease-in-out,box-shadow .15s ease-in-out;" href="/openid-login?providerId=aaf"> <img src="/images/memos-auth0-logo.png" style="display: inline; cursor: pointer; position: relative; vertical-align:middle; width:30px"/><p style="display:inline;">Sign in with AAF</p></a>
# Flag that sets if we should be checking email domains
openid.aaf.shouldFilterEmailDomains=true
# Domains below are allowed to login, only checked when 'shouldFilterEmailDomains' is true
openid.aaf.allowedEmailDomains=redboxresearchdata.com.au  
# Flag to force the user creation process, normally this should be set to true
openid.aaf.forceUserCreate=true
# Flag to set the enabled property of new users, set to false to allow admins to manually enable users before allowing logins, set to true to allow access right away
openid.aaf.userAutoEnabled=false
# Flag to set the verified property of new users
openid.aaf.userAutoVerified=false
# Property names to use when creating users
openid.aaf.emailProperty=email
openid.aaf.givenNameProperty=name
openid.aaf.familyNameProperty=deliberately_unknown_property
```

<br>

* Head over to [Federation Manager (Test)](https://manager.test.aaf.edu.au/oidc/clients/new) to register a new OIDC service for your XNAT application.
* Ensure that the **Redirect URL** for your OIDC service is set to `/openid-login`.
* Use the **Identifier** and **Secret** values from your registered service in Federation Manager to populate the `openid.aaf.clientId` and `openid.aaf.clientSecret` fields in the above configuration file.