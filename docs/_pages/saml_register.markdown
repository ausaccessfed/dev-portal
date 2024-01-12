---
layout: page
title: SAML
nav_order: 3
parent: Connect a New Service
---

# Register a SAML Service
---

A deployed Shibboleth **SP** only becomes useful after registering the **SP** in a Federation. The following steps show how to register an **SP**

Once you have clicked on 'SAML' on the ['Connect a New Service'](connect_service/#connect-a-new-service) page, you will then be taken to the **Register a SAML Service Provider** page:

![Register new saml service](/assets/images/register-new-saml-service.png)

There are two methods for providing the **SAML** details for the new service: automatic or manual.

### Automatic Method (top section of form)
> Available to **SPs** operating with [Shibboleth](https://www.shibboleth.net/) or [SimpleSAMLPHP](https://simplesamlphp.org/) and relies on these products responding on their default metadata endpoints.

1. Select the Organisation under which the **SP** will be registered.
2. Enter your service's metadata.
3. Click 'Register'.

### Manual Method (bottom section of form)
> Manually requires the deployer to complete the following fields with the necessary information and assumes that the deployer is familiar with the **SAML** end-points for their service.

1. Name - a service name
2. Description - a description of the service
3. Entity ID - the service's entity ID
4. URL - the service's landing page URL
5. Assertion consumer service URL -
6. Discovery response URL -
   > For Test:
   >
   > https://ds.test.aaf.edu.au/discovery/aaf
   >
   > For Production:
   >
   > https://ds.aaf.edu.au/discovery/aaf

7. Signing certificate - Provide the contents of the public key certificate created by the Shibboleth installation, this is not the web server SSL public certificate.
8. Select those attributes that the application requires. The selection of attributes should match those attributes enabled in the **attribute-map.xml** file. If following the instructions for the [Simple PHP Server installed on Linux example](/saml/#example-simple-php-server-installed-on-linux), the default Shibboleth installation enables the attributes **eppn** and **affiliation**.

9. Click 'Register'.

## Review by AAF
- Await review by the **AAF** support team, who will be in touch with the deployer, whose details were supplied at the top of the form.
- On approval, the service is registered in the **Federation** and metadata generated for inclusion in the **AAF Metadata** file, which is refreshed every few hours.