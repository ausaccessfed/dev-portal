---
title: Technical Connection Requirements
order: 4
duration: 1
last_updated: March 07, 2025
---
<br>

### 1. eduGAIN Metadata Consumption

The AAF supplies a new metadata source for eduGAIN that provides the technical trust for the international connection. Whether you run an IdP or an SP, you must consume this new metadata to connect to eduGAIN. This will require some minor configuration changes to your SP.

### 2. Attribute consumption

Service Providers must ensure their attribute requirements are recorded in the AAF Federation Manager. These requirements will be made available to IdPs in eduGAIN via metadata.

### 3. Discovery mechanism

The AAF and international federations rely on the Discovery Service (also referred to as the ‘Where Are You From’ service) to help end-users identify which IdP to login to. The AAF Discovery Service has been extended to include all eduGAIN IdPs. A simple change to the discovery URL in your Shibboleth SP configuration will enable the eduGAIN IdPs.

Your service can provide its own discovery mechanism rather than using the AAF’s Discovery Service. The eduGAIN metadata that your service consumes will include all of the Metadata Extensions for Login and Discovery User Interface (MDUI) information that your service’s discovery mechanism will require.

