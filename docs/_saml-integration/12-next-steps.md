---
title: Next Steps
order: 12
duration: 1
last_updated: 02 July, 2024
---

To test access to protected content, an active account at an existing subscriber with an **IdP** is necessary. The
**IdP** must exist within the same Federation (**TEST** or **PRODUCTION**) as the deployed service. Access the **PHP**
script within the protected directory **/secure** with a web browser. The **PHP** script will report values for those
attributes which the **attribute-map.xml** configuration enables and the **Apache** session environment.

Head over to [Log into Federation Manager](/log-into-federation-manager) and follow the steps to authenticate to Federation Manager (Test) after which you can [register your new SAML service](/connect-a-saml-service/01-overview).
{: .callout-success}
