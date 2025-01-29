---
title: Requesting Attributes - Federation Manager
order: 5
duration: 1
---
<br>

#### Follow the steps below to request attributes from Federation Manager:

1. Login to <a href="https://manager.aaf.edu.au/welcome">Federation Manager</a> as the Administrator of the Service (contact <a href="mailto:support@aaf.edu.au">AAF Support</a> if you need to assign an administrator to your service).

2. Follow the steps to <a href="/log-into-federation-manager/02-authentication">authenticate to Federation Manager</a>.

3. Once you have been successfully authenticated, click on “My services” on the Federation Manager dashboard.

    ![My services](/assets/images/edugain-integration/FM-dashboard-services.png)

4. Select "SAML" as the protocol from the dropdown list on the right-hand side of the dashboard. Then select your 
service from the “Services” list.

    ![SAML Protocol](/assets/images/edugain-integration/saml-protocol.png)

5. Select the SAML tab.

    ![SAML Tab](/assets/images/edugain-integration/saml-tab.png)

6. Then click on the "Requested Attributes" tab.

    ![Requested attributes](/assets/images/edugain-integration/requested-attributes.png)

You are now on the Service Provider’s Attributes page, which includes required, optional and other attributes. From here you can add, modify and remove attributes that your service requires.

![Select attributes](/assets/images/edugain-integration/select-attributes.png)

Please note that adding a new attribute will require approval at both the organisation and federation level. Please ensure that a reason is clearly provided which defines a purpose with respect to your service.
<br><br>
Once the approval has occurred the change will flow out into the metadata which is then consumed by eduGAIN Identity Providers. This process may take up to 48 hours to propagate across internet, multi-federations and their respective metadata files.
{: .callout-info}