---
layout: page
title: Register your service
nav_order: 1
parent: SAML
grand_parent: How to connect
---

# Register your service

A deployed Shibboleth **SP** only becomes useful after registering the **SP** in a Federation. The following steps show how to register an **SP**

1. To register a new **SAML SP** please visit:
   > <span class="fs-5">
   > [AAF Test Federation](https://manager.test.aaf.edu.au/saml/service_providers/new){: .btn }
   > </span>
   >
   > or
   >
   > <span class="fs-5">
   > [AAF Production Federation](https://manager.aaf.edu.au/saml/service_providers/new){: .btn }
   > </span>
   
2. Use your Organisation credentials to sign in to Federation Manager (Test or Production).

2. Select the Organisation under which the **SP** will be registered and provide the following details:
    1. a service name,
    2. a description of the service, and
    3. the service landing page URL

3. There are two methods for providing the **SAML** details for the new service: automatically or manually.
    1. Automatically requires the URL of the service. This method is available to **SPs** operating with [Shibboleth](https://www.shibboleth.net/) or [SimpleSAMLPHP](https://simplesamlphp.org/) and relies on these products responding on their default metadata endpoints. 
    2. Manually requires the deployer to complete the **Advanced SAML 2 Registration Form** with the necessary information and assumes that the deployer is familiar with the **SAML2** end-points for their service.

4. Provide the contents of the public key certificate created by the Shibboleth installation, this is not the web server SSL public certificate.
 
5. Select those attributes that the application requires, provide a reason for the request and whether the attribute is **mandatory/required**. The selection of attributes should match those attributes enabled in the **attribute-map.xml** file. For this demonstration the default Shibboleth installation enables the attributes eppn and affiliation.

6. Submit the registration and await review by the **AAF** support team, who will be in touch with the deployer, whose details were supplied at the top of the form.

7. On approval, the service is registered in the **Federation** and metadata generated for inclusion in the **AAF Metadata** file, which is refreshed every few hours.