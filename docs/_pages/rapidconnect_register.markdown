---
layout: page
title: Register your service
nav_order: 4
parent: Rapid Connect
grand_parent: How to connect
---

# Register your service

Access the AAF Rapid Connect website in the [production federation](https://manager.aaf.edu.au/rapid_connect/services/new) or [test federation](https://manager.test.aaf.edu.au/rapid_connect/services/new) and 
click on the button for "Register a service" which is on the right hand side in a blue colour, under the current version information. At that point you will be asked to select your Identity Provider and authenticate. Once this process is complete you will be returned to the service registration page.

To complete registration please provide:

1. Organisation - The AAF subscribed organisation which is sponsoring this service.
2. Name - A descriptive name for your service.
3. URL - The primary URL of your application which users would enter into the browser to visit your application. This value is provided to your application as the **aud** claim.
4. Callback URL - The secure URL within your application that AAF Rapid Connect should POST completed responses to. We described this endpoint as part of the integration steps above.
5. Secret - Must be random and securely stored by the service. This value should never be publicly disclosed and is used by the service to verify signed tokens from AAF Rapid Connect. We generated this as part of the Integration Steps shown above.

**If you're registering in the production federation**

Once submitted the AAF will review and contact you with any questions. You should expect a response via email within 2 business days which will include a unique URL within AAF Rapid Connect for your application to start the authentication process as we discussed in Standard Flow above.

**If you're registering in the test federation**

Your application will be automatically approved. The completion screen will show the unique URL for your application to initiate login. You can use this immediately with your application to start the authentication process as we discussed in Standard Flow above.

# Help

To get help with AAF Rapid Connect, email [AAF support](mailto:support@aaf.edu.au).