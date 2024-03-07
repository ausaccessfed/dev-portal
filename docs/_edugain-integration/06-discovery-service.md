---
title: Discovery Service
order: 6
duration: 1
---

Discovery Service Mechanism for Service Providers

When a service can be accessed by users from multiple organisations from multiple federations, it must ensure that the user during the login process can find and select their organisation he/she to authenticate. This process is called Identity Provider Discovery. There are multiple open-source implementations (Shibboleth Discovery Service) that allow to operate an own Discovery Service. Alternatively, the AAF provides a central discovery service.



There are 2 Discovery Service options, use a local discovery mechanism or use the central AAF discovery service.

Use a local Discovery Service

When using a local discovery service your SAML service provider software will generally provide you with the required data. It will extract the data from the Metadata which will include the MDUI extensions for enhanced discovery.

A local discovery service mechanism is the responsibility of the service provider.

Use the AAF Discovery Service

The AAF provides a central discovery service that can be utilized by any AAF service provider. It provides a discovery mechanism for both AAF IdPs and all of eduGAIN IdPs.


The URL for the all of eduGAIN IdPs is: https://ds.aaf.edu.au/discovery/edugain


To update your Shibboleth Service Provider to use the all of eduGAIN discovery you need to modify the discoveryURL defined in the /etc/shibboleth/shibboleth2.xml file.

```shell
<SSO discoveryProtocol="SAMLDS"
       discoveryURL="https://ds.aaf.edu.au/discovery/edugain">
                    SAML2 SAML1
  </SSO>
```

After a restart of the Service provider users will be taken to the all of eduGAIN discovery section of the AAF central discovery service.