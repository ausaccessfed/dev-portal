---
title: Review SP attribute-filter.xml file
order: 5
duration: 1
---

For this demonstration, the uncommented default attributes are sufficient. A deployer selects those attributes a web
application receives and configures the SP accordingly by updating the attribute-map.xml file. The attribute-map.xml
configuration file maps incoming attribute names or formats into local or header variable names and determines the
data the **SP** consumes from the **IdPs**.

The deployer will also need to register those attributes in FM. Details on the **attribute filter** configurable
options are available here: [XMLAttributeExtractor](https://wiki.shibboleth.net/confluence/display/SP3/XMLAttributeExtractor).