---
layout: page
title: Rapid Connect
permalink: /new_service/rapidconnect_register
nav_order: 4
parent: Connect a New Service
---

# Register a Rapid Connect Service
---

# What you'll learn

- How to connect a new Rapid Connect service in the AAF Test Federation

# What you'll need

- AAF login credentials

If you have not done so already, please [log into Federation Manager (Test)](login) to get started.

Once you have clicked on 'Rapid Connect' on the ['Connect a New Service'](https://manager.test.aaf.edu.au/connected_services/new) page in Federation Manager, you will then be taken to the **Register a New Service** page:

![Register new rapid connect service](/assets/images/register-new-rapid-connect-service.png)

**To complete registration please provide the following information:**

1. Name - A descriptive name for your service.
2. URL - The primary URL of your application which users would enter into the browser to visit your application. This value is provided to your application as the **aud** claim.
3. Callback URL - The secure URL within your application that AAF Rapid Connect should POST completed responses to. We described this endpoint as part of the [Integration Steps](/rapidconnect/#3-provide-a-web-accessible-endpoint).
4. Secret - Must be random and securely stored by the service. This value should never be publicly disclosed and is used by the service to verify signed tokens from AAF Rapid Connect. We generated this as part of the [Integration Steps](/rapidconnect/#2-create-a-secret).
5. Organisation - The AAF subscribed organisation which is sponsoring this service.


- Click **Register Service** to complete the registration step.
- Once your service is registered, check that the details you provided are correct and make sure to click 'Activate'. 

![Registered Rapid Connect Test](/assets/images/rapid-connect-registered.png)

{: .next_steps }
Since you have registered your service in the Test Federation, your application will be automatically approved. The completion screen will show the unique URL for your application to initiate login. You can use this immediately with your application to start the authentication process as we discussed in [Standard Flow](/rapidconnect/#standard-flow).

![Approved Rapid Connect](/assets/images/approved-rapid-connect.png)

- To test authentication, add the URL that you have been provided to your app's login page.
- Once you have navigated to the URL, you will be prompted to select your organisation to log into Rapid Connect Test.
- Then click ‘Continue to your organisation’.

![Log in to Org for Rapid Connect Test](/assets/images/rapid-connect-login-to-org.png)

- Use your Organisation credentials to sign in to Rapid Connect (Test). 

![Rapid Connect Test Log in](/assets/images/login-rapid-connect-test.png)

- If successful, you will be provided with a list of your attributes. 
- Choose an option regarding the release of your information and click 'Approve'.

![Rapid Connect Test Attributes](/assets/images/rapid-connect-test-attributes.png)

- You will be taken back to your application where you will be logged in.

---

## Up Next: [Register a SAML Service](saml_register)