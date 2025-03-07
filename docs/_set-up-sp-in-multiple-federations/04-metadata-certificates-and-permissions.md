---
title: Metadata certificates and permissions
order: 4
duration: 1
last_updated:
---

Make sure that you download each federation's metadata certificate to your service provider and set the appropriate permissions so your service provider can read it.

Then you need to edit Federation Manager so that your service provider metadata contains endpoints like below: 

```xml
<EntityDescriptor entityID="https://sp.example.org/shibboleth" xmlns="urn:oasis:names:tc:SAML:2.0:metadata" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:saml="urn:oasis:names:tc:SAML:2.0:assertion" xmlns:shibmd="urn:mace:shibboleth:metadata:1.0" xmlns:ds="http://www.w3.org/2000/09/xmldsig#" xsi:schemaLocation="urn:oasis:names:tc:SAML:2.0:metadata saml-schema-metadata-2.0.xsd urn:mace:shibboleth:metadata:1.0 shibboleth-metadata-1.0.xsd http://www.w3.org/2000/09/xmldsig# xmldsig-core-schema.xsd">
<SPSSODescriptor protocolSupportEnumeration="urn:oasis:names:tc:SAML:2.0:protocol">
<Extensions>
<dsr:DiscoveryResponse xmlns:dsr="urn:oasis:names:tc:SAML:profiles:SSO:idp-discovery-protocol" Binding="urn:oasis:names:tc:SAML:profiles:SSO:idp-discovery-protocol" Location="https://sp.example.org/Shibboleth.sso/Login" index="0" isDefault="true" />
<dsr:DiscoveryResponse xmlns:dsr="urn:oasis:names:tc:SAML:profiles:SSO:idp-discovery-protocol" Binding="urn:oasis:names:tc:SAML:profiles:SSO:idp-discovery-protocol" Location="https://sp.example.org/Shibboleth.sso/DS-AAF-TEST" index="1" isDefault="false" />
<dsr:DiscoveryResponse xmlns:dsr="urn:oasis:names:tc:SAML:profiles:SSO:idp-discovery-protocol" Binding="urn:oasis:names:tc:SAML:profiles:SSO:idp-discovery-protocol" Location="https://sp.example.org/Shibboleth.sso/DS-Tuakiri-TEST" index="2" isDefault="false" />
</Extensions>
```