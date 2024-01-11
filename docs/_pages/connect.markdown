---
layout: page
title: Connection Methods
permalink: /connect/
nav_order: 2
has_children: true
---
# Connection Methods

Choose which protocol your service will use to connect.

<span class="fs-5">
[SAML >]({% link _pages/saml.markdown %}){: .btn .btn-blue .mb-4 .mt-8 .d-block .text-center}
</span>

- [x] Feature-rich
- [x] Many open-source libraries
- [x] Allows participation in eduGAIN
- [x] Use the SAML protocols which are implemented using [Shibboleth](https://www.shibboleth.net/) or [SimpleSAMLphp](https://simplesamlphp.org/) 
  as open source options

*Drawbacks*
- Complex

<span class="fs-5">
[OpenID Connect >]({% link _pages/oidc.markdown %}){: .btn .btn-blue .mb-4 .mt-8 .d-block .text-center}
</span>

**An OpenID Connect implementation (officially the service is called "AAF Central")**
- [x] Recommended for most connections
- [x] Feature-rich
- [x] Many open-source libraries


<span class="fs-5">
[Rapid Connect >]({% link _pages/rapidconnect.markdown %}){: .btn .btn-blue .mb-4 .mt-8 .d-block .text-center}
</span>

**A JSON Web Token authentication option**
- [x] Simple
- [x] Easy to test and deploy
    - Connect your service to our test environment, straight away, for free. There's no need to wait for an approval 
  process.
    - With Rapid Connect, you can deploy your services anywhere. Connect on-premise services, or use cloud providers 
      like AWS, Azure, Google, or Heroku.
- [x] Wide language support
    - Rapid Connect integrates natively into commonly used development languages like Python, PHP, Java, and Ruby.
- [x] Low code
    - With Rapid Connect, you can set up authentication in as few as 20 lines of Ruby. Implementations in other 
  languages are similarly slim.

*Drawbacks*
- Narrow feature set
- Few open-source libraries


