---
title: OpenID Configuration
order: 3
duration: 1
---

The **AAF OIDC** service supports querying the **OP** Configuration Information endpoint to retrieve the features and capabilities of the **OIDC** service. The **AAF OP** provides two endpoints, one for **Production Federation** and one for **Test Federation**.

<br>
Details for the **Test Federation** are here:

<a href="https://central.test.aaf.edu.au/.well-known/openid-configuration" class="btn btn-outline-primary mb-3">Test Federation</a>

```shell
curl https://central.test.aaf.edu.au/.well-known/openid-configuration | jq

{
  "issuer":"https://central.test.aaf.edu.au",
  "authorization_endpoint":"https://central.test.aaf.edu.au/oidc/authorize",
  "token_endpoint":"https://central.test.aaf.edu.au/oidc/token",
  "jwks_uri":"https://central.test.aaf.edu.au/oidc/jwks",
  "id_token_signing_alg_values_supported": [
    "RS256"
  ],
  "response_types_supported": [
    "code"
  ],
  "scopes_supported": [
    "aueduperson",
    "eduperson_affiliation",
    "eduperson_assurance",
    "eduperson_entitlement",
    "eduperson_orcid",
    "eduperson_principal_name",
    "eduperson_scoped_affiliation",
    "email",
    "phone",
    "profile",
    "schac_home_organization",
    "openid"
  ],
  "userinfo_endpoint": "https://central.test.aaf.edu.au/oidc/userinfo",
  "claim_types_supported": [
    "normal"
  ],
  "claims_supported": [],
  "claims_locales_supported": [
    "en"
  ],
  "claims_parameter_supported": false,
  "display_values_supported": [
    "page"
  ],
  "grant_types_supported": [
    "authorization_code"
  ],
  "op_policy_uri": "https://central.test.aaf.edu.au/central/documentation/policy",
  "op_tos_uri": "https://central.test.aaf.edu.au/central/documentation/tos",
  "request_parameter_supported": false,
  "request_uri_parameter_supported": false,
  "require_request_uri_registration": true,
  "response_modes_supported": [
    "query"
  ],
  "service_documentation": "https://central.test.aaf.edu.au/oidc/documentation",
  "token_endpoint_auth_methods_supported": [
  "client_secret_basic","client_secret_post"
  ],
  "ui_locales_supported": [
    "en"
  ],
  "userinfo_signing_alg_values_supported": [
    "RS256"
  ]
}
```