---
title: Register service
order: 2
duration: 1
last_updated: March 07, 2025
---

If you have not done so already, please [log in to Federation Manager](/log-into-federation-manager/01-overview) to get started.
{: .callout-info }

Once you have logged into Federation Manager and are on the ['Connect a New Service'](https://manager.test.aaf.edu.au/connected_services/new) page, click on 'Rapid Connect'. You will then be taken to the **Register a New Service** 
page:

![Register new rapid connect service](/assets/images/connect-a-rapid-connect-service/register-new-rapid-connect-service.
png)

**To complete registration please provide the following information:**

1. Name - A descriptive name for your service.
2. URL - The primary URL of your application which users would enter into the browser to visit your application. This value is provided to your application as the **aud** claim.
3. Callback URL - The secure URL within your application that AAF Rapid Connect should POST completed responses to. We described this endpoint as part of the [Integration Steps](/rapid-connect-integration/07-integration/#3-provide-a-web-accessible-endpoint).
4. Secret - Must be random and securely stored by the service. This value should never be publicly disclosed and is 
   used by the service to verify signed tokens from AAF Rapid Connect. We generated this as part of the [Integration Steps](/rapid-connect-integration/07-integration/#2-create-a-secret).
5. Organisation - The AAF subscribed organisation which is sponsoring this service.

- Click **Register Service** to complete the registration step.