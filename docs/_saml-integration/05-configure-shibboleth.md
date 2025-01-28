---
title: Configure Shibboleth
order: 5
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

The aggregated metadata differs to the information available from the **discovery service URL**. For an **SP**, having an **IdP’s** metadata will provide access to users of the **IdP** as long as the **IdP** has a copy of the **SP's** metadata, even if the **IdP** is not listed by the discovery service. The reverse is not possible.

Locate the **`<MetadataProvider>`** elements and identify, via the comments and type of equal to **“XML”**, the element which controls the remote supply of **"signed metadata"**. To enable this element, remove the enclosing comment delimiters `<!--` and `-->`.

The AAF provides an MDQ (Metadata Query) metadata provider to obtain metadata. Replace the type="XML" attribute value with the value "MDQ".

Since this demonstration service will be available to the **TEST Federation**, replace the URL value with the **TEST Federation** MDQ endpoint:

`https://md.test.aaf.edu.au/mdq/aaf/`

If a service is production-ready, use the **PRODUCTION Federation** MDQ endpoint:

`https://md.aaf.edu.au/mdq/aaf/`

Replace the certificate setting value with the following string aaf-metadata-certificate.pem, and download the AAF signing certificate with the following command:

    $> curl https://md.aaf.edu.au/aaf-metadata-certificate.pem --output /etc/shibboleth/aaf-metadata-certificate.pem

**PRODUCTION** and **TEST** Metadata are signed by the same certificate.

The **`<MetadataProvider>`** element (to be used in the test Federation) should now have the same content as the following fragment:

```xml
<MetadataProvider
        type="MDQ" id="mdq" ignoreTransport="true" cacheDirectory="metadata" baseUrl="https://md.test.aaf.edu.au/mdq/aaf/"
        reloadInterval="1800">
    <MetadataFilter type="RequireValidUntil" maxValidityInterval="8640000" />
    <MetadataFilter type="Signature" certificate="aaf-metadata-certificate.pem" />
</MetadataProvider>
```

Though a standard Shibboleth **SP** install creates two certificate pairs, one for signing and one for encryption, the **AAF Service Provider Registration Form** only requests one public key certificate.

For a deployer, the choices available are to:

1. add the other public key certificate to the FM once access is granted, or
2. use the same key pairs for both functions within the SP configuration.


Pick an option and copy the public certificate for later use during the registration process.

Keep the private keys secure!
{: .callout-warning}

Details on the **`<MetadataProvider>`** elements configurable options are available here:

- [MetadataProvider](https://shibboleth.atlassian.net/wiki/spaces/SP3/pages/2060616124/MetadataProvider)

- [MDQMetadataProvider](https://shibboleth.atlassian.net/wiki/spaces/SP3/pages/2060616133/MDQMetadataProvider)

<br>

#### 6 `<Errors>` Element

The **`<Errors>`** element controls the error handling of the **SP** in response to problems occurring during authentication and authorization processes. If an **SP** encounters an error during the SAML exchange, the **`<Errors>`** element will determine the response to the user. There are two types of error handling available in Shibboleth:

- Template-based error handling
- Redirection-based error handling

##### Template-based error handling

Template-based error handling is the default error handling method in Shibboleth. In this case, an error page is returned to the browser with a message that the **SP** has encountered an error. The error page is created using an HTML template that is populated dynamically with specific error information.

Templates can make use of tags such as `requestURL`, `errorType`, `errorText`, and `entityID`. For further tags refer to the [Shibboleth documentation](https://shibboleth.atlassian.net/wiki/spaces/SP3/pages/2065334361/Errors).

Customised error pages improve the user's experience and can be created to suit the needs of the **SP**. Additional instructions on the error page can include:

- Providing a link to the user to log in again
- Redirecting the user to a different page
- Providing a contact email address for the IdP's service desk
- Providing a link to the **SP's** support page

An example of a customised error page is shown below:

![Shibboleth Error Page](/assets/images/saml-integration/custom-error-page.png)

##### Redirection-based error handling

Redirection-based error handling is an alternative error handling method in Shibboleth. In this case, the browser is redirected to a designated location when an error occurs. The redirection URL contains a query string with information about the error. The query string can include the parameters referenced in the [Shibboleth documentation](https://shibboleth.atlassian.net/wiki/spaces/SP3/pages/2065334361/Errors).

For example, if an **SP** encounters an error, the browser is redirected to the URL specified in the `redirectErrors` of the `<Errors>` element:

```xml
<Errors supportContact="support@example.org"
        redirectErrors="http://example.org/shibboleth/error" />
```

The example URL below contains query parameters with information about the error:

```shell
https://example.org/shibboleth/error?now=Mon+Jul+8+03%3A32%3A20+2024
  &requestURL=https://example.org/Shibboleth.sso/SAML2/POST
  &errorType=opensaml::FatalProfileException
  &errorText=SAML response contained an error.
```




