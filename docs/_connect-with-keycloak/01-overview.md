---
title: Overview
order: 1
duration: 1
last_updated: 10 March, 2025
---

### Register an OIDC service with Keycloak

[Keycloak](https://www.keycloak.org/) is an open source software solution that provides single sign on (SSO) access, allowing users to authenticate once to access multiple services. It also allows for single sign out, which means that users only have to sign out once for several services and/or applications that use Keycloak.

Keycloak can also be used to authenticate users with existing OpenID Connect or SAML 2.0 Identity Providers. This can be done by configuring the Identity Provider through the Keycloak admin console.

The instructions below detail the configuration of AAF as an Identity Provider through Keycloak using the OpenID Connect protocol. The process includes the registration of a new service in AAF Federation Manager (Test).
{: .callout-info}

### What you'll learn

- How to connect a new OpenID Connect service in the AAF Test Federation using Keycloak

### What you'll need

- A container platform on which to run Keycloak, e.g. Docker, Podman, OpenJDK, etc.
- Knowledge running a container platform in a local development environment
- AAF login credentials
