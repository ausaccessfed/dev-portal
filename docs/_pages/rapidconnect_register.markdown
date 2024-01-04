---
layout: page
title: Register your service
nav_order: 4
parent: Rapid Connect
grand_parent: How to connect
---

# Register your service
---

To register a **new service** please visit the AAF Rapid Connect website in the: 

> [AAF Test Federation](https://manager.test.aaf.edu.au/rapid_connect/services/new){: .btn }
> 
> or
> 
> [AAF Production Federation](https://manager.aaf.edu.au/rapid_connect/services/new){: .btn } 

You will be prompted to select your Organisation as shown below. Then click 'Continue to your organisation'.

![Select Organisation](/assets/images/sign-in-to-org-FM.png)

Use your Organisation credentials to sign in to Federation Manager (Test or Production).

![Sign in to FM](/assets/images/sign-in-to-FM.png)

If authentication is successful, you will be returned to the **Register a New Service** page:

![Register new rapid connect service](/assets/images/register-new-rapid-connect-service.png)

**To complete registration please provide the following information:**

1. Name - A descriptive name for your service.
2. URL - The primary URL of your application which users would enter into the browser to visit your application. This value is provided to your application as the **aud** claim.
3. Callback URL - The secure URL within your application that AAF Rapid Connect should POST completed responses to. We described this endpoint as part of the [Integration Steps](/rapidconnect/#3-provide-a-web-accessible-endpoint).
4. Secret - Must be random and securely stored by the service. This value should never be publicly disclosed and is used by the service to verify signed tokens from AAF Rapid Connect. We generated this as part of the [Integration Steps](/rapidconnect/#2-create-a-secret).
5. Organisation - The AAF subscribed organisation which is sponsoring this service.

**If you're registering in the production federation**

Once submitted the AAF will review and contact you with any questions. You should expect a response via email within 2 business days which will include a unique URL within AAF Rapid Connect for your application to start the authentication process as we discussed in [Standard Flow](/rapidconnect/#standard-flow).

**If you're registering in the test federation**

Your application will be automatically approved. The completion screen will show the unique URL for your application to initiate login. You can use this immediately with your application to start the authentication process as we discussed in [Standard Flow](/rapidconnect/#standard-flow).

# Help

To get help with AAF Rapid Connect, email [AAF support](mailto:support@aaf.edu.au).