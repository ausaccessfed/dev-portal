---
title: Openid Configuration
order: 4
duration: 1
---

The **AAF OIDC** service supports querying the **OP** Configuration Information endpoint to retrieve the features and
capabilities of the **OIDC** service. The **AAF OP** provides two endpoints, one for **Production Federation** and one
for **Test Federation**, respectively:

<a href="https://central.test.aaf.edu.au/.well-known/openid-configuration" class="btn btn-outline-primary mb-3">Test Federation</a>
<br>
<a href="https://central.aaf.edu.au/.well-known/openid-configuration" class="btn btn-outline-primary">Production Federation</a>


<br>
Details for the **Production Federation** are here:

```
curl https://central.aaf.edu.au/.well-known/openid-configuration | jq
{
  "issuer": "https://central.aaf.edu.au",
  "authorization_endpoint": "https://central.aaf.edu.au/oidc/authorize",
  "token_endpoint": "https://central.aaf.edu.au/oidc/token",
  "jwks_uri": "https://central.aaf.edu.au/oidc/jwks",
  "id_token_signing_alg_values_supported": [
    "RS256"
  ],
  "subject_types_supported": [
    "public"
  ],
  "response_types_supported": [
    "code"
  ],
  "scopes_supported": [
    "profile",
    "email",
    "phone",
    "eduperson_affiliation",
    "eduperson_scoped_affiliation",
    "eduperson_entitlement",
    "eduperson_principal_name",
    "eduperson_assurance",
    "eduperson_orcid",
    "schac_home_organization",
    "aueduperson",
    "openid"
  ],
  "userinfo_endpoint": "https://central.aaf.edu.au/oidc/userinfo",
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
  "op_policy_uri": "https://central.aaf.edu.au/central/documentation/policy",
  "op_tos_uri": "https://central.aaf.edu.au/central/documentation/tos",
  "request_parameter_supported": false,
  "request_uri_parameter_supported": false,
  "require_request_uri_registration": true,
  "response_modes_supported": [
    "query"
  ],
  "service_documentation": "https://central.aaf.edu.au/oidc/documentation",
  "token_endpoint_auth_methods_supported": [
    "client_secret_basic",
    "client_secret_post"
  ],
  "ui_locales_supported": [
    "en"
  ],
  "userinfo_signing_alg_values_supported": [
    "RS256"
  ]
}
```