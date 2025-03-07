---
title: Access federation metadata
order: 3
duration: 1
last_updated:
---

Ensure your service provider has access to the metadata from each federation by editing the shibboleth.xml file. 

```xml
<MetadataProvider type="XML" uri="http://manager.test.aaf.edu.au/metadata/metadata.aaf.signed.complete.xml"
 backingFilePath="metadata.aaf.xml" reloadInterval="3600">
 <MetadataFilter type="RequireValidUntil" maxValidityInterval="2419200"/>
 <MetadataFilter type="Signature" certificate="aaf-metadata-cert.pem"/>
</MetadataProvider>

<MetadataProvider type="XML" uri="https://directory.test.tuakiri.ac.nz/metadata/tuakiri-test-metadata-signed.xml"
 backingFilePath="metadata.tuakiri-test.xml" reloadInterval="3600">
 <MetadataFilter type="RequireValidUntil" maxValidityInterval="2419200"/>
 <MetadataFilter type="Signature" certificate="tuakiri-test-metadata-cert.pem"/>
</MetadataProvider>
```