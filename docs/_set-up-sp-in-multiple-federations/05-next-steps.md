---
title: Next steps
order: 5
duration: 1
last_updated: March 07, 2025
---

Restart the Shibboleth service and wait for your service provider and the discovery services and IdPs from each federation to download the updated metadata.

You should then be able to authenticate to your service provider using the URLs for the respective federations' discovery services. 

For example, if your service provider is `sp.example.org`, the URLs for the discovery services would be:

`https://sp.example.org/Shibboleth.sso/DS-AAF-TEST`

`https://sp.example.org/Shibboleth.sso/DS-Tuakiri-TEST`