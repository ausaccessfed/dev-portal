---
title: AAF OIDC Demo App - Synthetic SP
order: 4
duration: 1
---

The [AAF OIDC Demo App](https://oidc-demo.test.aaf.edu.au/) is a simple web application that demonstrates the OpenID Connect Authorization Code flow. The application is pre-configured to use the AAF Test Federation as the OpenID Provider (OP).

Click "Sign in via AAF (Synthetic SP)" to begin the authentication process.

![OIDC Demo App](/assets/images/connect-a-synthetic-oidc-service/oidc-demo-app.png)

Select your organisation from the list of available Identity Providers (IdPs) and click "Continue to your organisation".

![Select IdP](/assets/images/connect-a-synthetic-oidc-service/login-synthetic-oidc.png)

In comparison to signing in via the AAF (Central), which releases the full suite of attributes:

![Central Attributes](/assets/images/connect-a-synthetic-oidc-service/central-attributes.png)

Signing in via the AAF (Synthetic SP) only releases those attributes that you have specifically selected for your service:

![Synthetic Attributes](/assets/images/connect-a-synthetic-oidc-service/synthetic-attribute-release.png)