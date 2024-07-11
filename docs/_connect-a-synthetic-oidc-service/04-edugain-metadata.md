---
title: EduGAIN Metadata
order: 4
duration: 1
---

To allow access to eduGAIN, the following attributes are inserted into the metadata of your synthetic service provider:  

```xml
<mdattr:EntityAttributes>
      <saml:Attribute Name="http://macedir.org/entity-category" NameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:uri">
        <saml:AttributeValue>http://refeds.org/category/research-and-scholarship</saml:AttributeValue>
      </saml:Attribute>
      <saml:Attribute Name="urn:oasis:names:tc:SAML:attribute:assurance-certification" NameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:uri">
        <saml:AttributeValue>https://refeds.org/sirtfi</saml:AttributeValue>
      </saml:Attribute>
</mdattr:EntityAttributes>
```

