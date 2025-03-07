---
title: Add discovery services
order: 2
duration: 1
last_updated: 2025-03-07 12:26:16 +1000
---

Add the discovery services to your shibboleth2.xml file. This allows users to select their home institution from a list of federations. 

```xml
<SSO
     discoveryProtocol="SAMLDS" discoveryURL="https://ds.test.aaf.edu.au/discovery/DS">
     SAML2 SAML1
  </SSO>

<!-- SAML and local-only logout. --> 
<Logout>SAML2 Local</Logout>

<!-- manually defined additional DS initiators - without isDefault and with custom IDs and Locations --> 
<SessionInitiator type="Chaining" Location="/DS-AAF-TEST" id="DS-AAF-TEST" relayState="cookie">
    <SessionInitiator type="SAML2" acsIndex="1" template="bindingTemplate.html"/>
    <SessionInitiator type="Shib1" acsIndex="5"/>
    <SessionInitiator type="SAMLDS" URL="https://ds.test.aaf.edu.au/discovery/DS"/>
</SessionInitiator>

<SessionInitiator type="Chaining" Location="/DS-Tuakiri-TEST" id="DS-Tuakiri-TEST" relayState="cookie">
    <SessionInitiator type="SAML2" acsIndex="1" template="bindingTemplate.html"/>
    <SessionInitiator type="Shib1" acsIndex="5"/>
    <SessionInitiator type="SAMLDS" URL="https://directory.test.tuakiri.ac.nz/ds/DS"/>
</SessionInitiator>
```