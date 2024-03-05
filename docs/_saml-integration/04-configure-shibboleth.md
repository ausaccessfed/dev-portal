---
title: Configure Shibboleth
order: 4
duration: 1
---

For this demonstration, minor updates to the default installation are sufficient to demonstrate functionality.
However, a deployer should thoroughly review the **Shibboleth SP** documentation and be sufficiently familiar with the
configurable options and advanced functionality to ensure a secure deployment.
<br>

#### 1 `<ApplicationDefaults>` Element

To be a **SAML entity**, an **SP** requires a globally unique **entityID**. This value permits **IdPs** to identify
the **SP** and locate the **SP’s** service end-points in the Federation metadata. Likewise, the SP uses the **IdP’s
entityID** value to identify and locate the IdP’s service end-points in the Federation metadata. Typically,
including a service’s **hostname** in the **entityID** value ensures a globally unique value. **Shibboleth** is very
configurable and can operate in a multi-domain environment. A web server may have several virtual hosts, and an application may span several physical hosts, all protected by one or more instances of Shibboleth.

**Choose wisely!** Once registered and in-use, any change to an **entityID** value disrupts a web service’s
availability and breaks the targeted/persistent ID generation, so any changes are discouraged.
{: .callout-danger}

For Linux, edit the configuration file **/etc/shibboleth/shibboleth2.xml**, and for Windows locate the shibboleth2.xml file within the installation directory. Locate the **ApplicationDefaults** element. Update the default value for**entityID**, updating the placeholder value **“https://sp.example.org/shibboleth”**.

The **REMOTE_USER** setting is an environment variable which enables Shibboleth to pass the **“authenticated username”** to an application. The default values are sufficient for this demonstration, however deployers should
only include those attributes which are the primary identifiers in the web application. **Shibboleth** is, to some
extent, unique among SSO tools because it does not require that **REMOTE_USER** contains a value, even if a user has
authenticated. Details on the configurable options within the **`<ApplicationDefaults>`** element are available here:

> - [ApplicationDefaults](https://wiki.shibboleth.net/confluence/display/SP3/ApplicationDefaults)
>
> - [AttributeAccess](https://wiki.shibboleth.net/confluence/display/SP3/AttributeAccess)

#### 2 `<Sessions>` Element

The **`<Sessions>`** and its child **`<Handler>`** elements control SSO and provide core SAML functionality. Update the
**`<Sessions>`** element settings with the following values.

```xml
<Sessions lifetime="28800" timeout="3600" relayState="cookie" 
     checkAddress="true" handlerSSL="true" cookieProps="https" 
     redirectLimit="none">
```

Enabling these items contributes to the overall security of the web application, though the **checkAddress** setting
will be a source of errors in a NAT or proxy environment. Replacing checkAddress with **consistentAddress** may reduce
those issues, however, the best approach is to avoid combining a NAT or a proxy service with a web application
protected by a Shibboleth **SP**. [Read details on the **`<Sessions>`** element configurable options](https://wiki.shibboleth.net/confluence/display/SP3/Sessions).

#### 3 `<StorageService>` Element

The `<StorageService>` element configures the component used for persistent storage of information by the shibd
daemon across requests, and in some cases, restart of the software. Update the `<StorageService>` with the following
values.

```xml
    <StorageService type="Memory" id="memory" />
    <ReplayCache StorageService="memory" />
    <ArtifactMap StorageService="memory" />
```

[Read the details on the **`<StorageService>`** element configurable options](https://shibboleth.atlassian.net/wiki/spaces/SP3/pages/2065334626/StorageService).

#### 4 `<SSO>` Element

The **`<SSO>`** element enables and configures single sign-on and sets the choice of authentication protocols. The
**entityID** configuration item sets the default **IdP** for user authentication. In a Federation, the use of the
settings **discoveryProtocol** and **discoveryURL** provide access to a discovery service which offers a list of all
the participating **IdPs**.

To configure the service to use the Federation, remove the entityID setting and value pair:
>   `entityID="https://idp.example.org/idp/shibboleth"`

Update the **discoveryURL** configuration value so the **`<SSO>`** element has the following contents:

```xml
<SSO
  discoveryProtocol="SAMLDS"
  discoveryURL="https://ds.test.aaf.edu.au/discovery/DS">
    SAML2
</SSO>
```

When connecting the service to the **PRODUCTION** Federation, use the following value instead:
>   `discoveryURL="https://ds.aaf.edu.au/discovery/DS"`

[Read the details on the **`<SSO>`** element configurable options](https://wiki.shibboleth.net/confluence/display/SP3/SSO).

#### 5 `<MetadataProvider>` Element

The **`<MetadataProvider>`** element provides the core functionality which establishes the trust relationships with
subscriber **IdPs**. Without metadata, **SPs** and **IdPs** will not be able to participate in the Federation, nor interact
via the user browser agent.

The **AAF** collects the subscriber **IdP** and **SP** metadata and publishes aggregate metadata for **IdPs** and
**SPs** to consume. The **AAF** signs both metadata documents with a common certificate and the metadata is
periodically refreshed with a validity window. Without the aggregated metadata, each **SP** would need to independently obtain **IdP** metadata from each organisation with an IdP service to enable that organisation’s users
access to the web application protected by the **SP**.

The aggregated metadata differs to the information available from the **discovery service URL**. For an **SP**,
having an **IdP’s** metadata will provide access to users of the **IdP** as long as the **IdP** has a copy of the
**SP's** metadata, even if the **IdP** is not listed by the discovery service. The reverse is not possible.

Locate the **`<MetadataProvider>`** elements and identify, via the comments and type of equal to **“XML”**, the
element which controls the “remote supply of **"signed metadata"** which also caches a copy locally. To enable this
element, remove the enclosing comment delimiters `<!--` and `-->`.

Since this demonstration service will be available to the **TEST Federation**, replace the URL value with the **TEST
Federation** metadata source URL:

[https://md.test.aaf.edu.au/aaf-test-metadata.xml](https://md.test.aaf.edu.au/aaf-test-metadata.xml).

If a service is production-ready, use the **PRODUCTION Federation** metadata source URL:

[https://md.aaf.edu.au/aaf-test-metadata.xml](https://md.aaf.edu.au/aaf-test-metadata.xml).

Replace the certificate setting value with the following string aaf-metadata-certificate.pem, and download the AAF signing certificate with the following command:

    $> curl https://md.aaf.edu.au/aaf-metadata-certificate.pem --output /etc/shibboleth/aaf-metadata-certificate.pem

**PRODUCTION** and **TEST** Metadata are signed by the same certificate.

The **`<MetadataProvider>`** element should now have the same content as the following fragment:

```xml
<MetadataProvider type="XML" validate="true" 
  url="https://md.test.aaf.edu.au/aaf-test-metadata.xml"
  backingFilePath="federation-metadata.xml" maxRefreshDelay="7200">
    <MetadataFilter type="RequireValidUntil" maxValidityInterval="2419200"/>
    <MetadataFilter type="Signature" certificate="aaf-metadata-certificate.pem" verifyBackup="false"/>
    <DiscoveryFilter type="Blacklist" matcher="EntityAttributes" trimTags="true"
  attributeName="http://macedir.org/entity-category"
  attributeNameFormat="urn:oasis:names:tc:SAML:3.0:attrname-format:uri"
  attributeValue="http://refeds.org/category/hide-from-discovery" />
</MetadataProvider>
```

Though a standard Shibboleth **SP** install creates two certificate pairs, one for signing and one for encryption,
the **AAF Service Provider Registration Form** only requests one public key certificate.

For a deployer, the choices available are to:

1. add the other public key certificate to the FM once access is granted, or
2. use the same key pairs for both functions within the SP configuration.


Pick an option and copy the public certificate for later use during the registration process.

Keep the private keys secure!
{: .callout-warning}

Details on the **`<MetadataProvider>`** elements configurable options are available here:

- [MetadataProvider](https://wiki.shibboleth.net/confluence/display/SP3/MetadataProvider)

- [XMLMetadataProvider](https://wiki.shibboleth.net/confluence/display/SP3/XMLMetadataProvider)
