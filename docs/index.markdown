---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: home
title: Home
nav_order: 1
---
# Connect your services to the AAF

## Overview
 
There are a number of ways to connect your service to the federation technically. This site provides the 
documentation on how to connect your service to the AAF.

The AAF provides two Federations, a Test Federation and a Production Federation.

### Test Federation

The test federation is open to anyone and there is no cost involved. Anyone can use the test environment for developing and testing their integrations.

### Production Federation

To participate in the production federation you must subscribe to the federation. Details on how to do this are available here:https://aaf.edu.au/subscribe/who.html

### Connection Methods

There are three ways to connect to the federation
*     SAML
*     OIDC
*     Rapid Connect

```mermaid
flowchart RL
    id1[SAML] --> B(Shibboleth)
    id1[SAML] --> C(SimplSAML php)
    D[Keycloak] ---> id2(OIDC)
    E[Cognito] ---> id2(OIDC)
    F[Apache OIDC Plugin] ---> id2(OIDC)
    G[Open Source OIDC Plugin] ---> id2(OIDC)
    H[Other Third Party Vendors] ---> id2(OIDC)
    id2[OIDC] ---> K(AAF)
    B[Shibboleth] --> K(AAF)
    C[SimpleSAML php] --> K(AAF)
    id3[Rapid Connect] ---> K(AAF)
    style id1 fill:#f96,stroke:#333
    style id2 fill:#f96,stroke:#333
    style id3 fill:#f96,stroke:#333
```