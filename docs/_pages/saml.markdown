---
layout: page
title: SAML
permalink: /saml/
nav_order: 3
parent: Connection Types
---

# Documentation

## Overview

This guide will assist with standing up a simple application protected by **Shibboleth** and add the application to the 
**AAF’s TEST Federation** to evaluate basic functionality. The prerequisites for this guide require elevated privileges 
to one of the supported platforms and the installation and/or configuration of the following components:

    - a supported web server, 
    - SSL libraries suitable for the web server,
    - open firewall port HTTPS/443 that permits inbound and outbound traffic,
    - NTP service and active time synchronisation - SAML transactions are time-sensitive,
    - allocation of a DNS name for the service,
    - where available, SELinux is disabled, as it may interfere with communication between the Apache web server and 
the Shibboleth process.


This guide is derived from the **Shibboleth Wiki** and assumes knowledge of the following aspects of the target OS and 
architecture:

    - working knowledge of the web server platform,
    - standard OS-level knowledge, sufficient for software installation, configuration file editing andstarting/stopping of processes/services,
    - working knowledge of XML,
    - basic knowledge of public key cryptography,
    - basic understanding of web cookies and redirects,
    - basic understanding of web authentication.


The **Shibboleth Wiki** provides installation and configuration information for **Shibboleth Service Provider (SP)** on 
the following platforms:

> - RedHat/CentOS versions 6, 7 or 8 with Apache 2.2, 2.4 or FastCGI; and 
> - Windows 2008 and later with Apache 2.2, 2.4 or IIS; 
> - additional information on building packages from source for other RPM-supporting Linux versions.


The **Shibboleth Consortium** has considerably streamlined the **SP** installation process for Linux and Apache, and 
this guide reflects that approach. Other combinations of platform and web server require additional steps to install 
the **SP**, configure the web server and protect content. For these, links in this guide will refer deployers to 
additional **Shibboleth documentation**. 

{: .note}
All links in this guide are collated on the [Links Page]({% link _pages/saml_links.markdown %}).

The **AAF** provides two Federations to subscribing organisations: 
- **TEST** 
- **PRODUCTION** 

Membership of the **AAF** is an essential condition for adding services to the **PRODUCTION** Federation. [Details on joining the **AAF** are found here](https://support.aaf.edu.au/support/solutions/folders/19000155992). 

## Shibboleth Guides

The key to deploying federated services is understanding **Shibboleth** and **SAML**, how the required components 
interact, and details on session cookies and the terminology in use. The following articles serve as an introduction to these topics:

> - [Describes the interaction between **Identity Provider (IdP)** and **SP**](https://wiki.shibboleth.net/confluence/display/CONCEPT/FlowsAndConfig)
> - [Describes the Application Model](https://wiki.shibboleth.net/confluence/display/SP3/ApplicationModel)
> - [Describes Application Integration](https://wiki.shibboleth.net/confluence/display/SP3/ApplicationIntegration)

> - Starting point for installation on Linux, Windows and Mac:
>     - [System Requirements](https://wiki.shibboleth.net/confluence/display/SP3/SystemRequirements)
>     - [Installation](https://wiki.shibboleth.net/confluence/display/SP3/Installation)

> - [SP Configuration elements and components](https://wiki.shibboleth.net/confluence/display/SP3/SPConfig)

## Example: Simple PHP Server installed on Linux

The following is a sequence of steps to protect a service (in this instance, a simple PHP script) by deploying a 
**Shibboleth SP** with Apache running on Linux.

For supported Linux distributions, the **Shibboleth Consortium** provides a web service which generates the 
appropriate package management configuration file. [Read about this service](https://shibboleth.net/downloads/service-provider/RPMS/).


Copy the configuration into a file in the repository directory, on CentOS/RedHat for example, the file can be labelled `/etc/yum.repos.d/shibboleth.repo`

### 1. Install Shibboleth

Install **Shibboleth**, Apache and the SSL libraries for the architecture of the OS: x86_64 or i386, to ensure the installation of the appropriate versions of mod_shib.so and other pluggable modules. This demonstration will use Shibboleth SP 3.1.x, Apache 2.4 and the current SSL libraries, and PHP to demonstrate the protection of a simple application and passing user attributes to the application.

`$> yum install httpd.x86_64 mod_ssl.x86_64 shibboleth.x86_64 PHP.x86_64 -y`

An outline for installing the **Shibboleth SP** on other web platforms is available in the [**Shibboleth Wiki.**](https://wiki.shibboleth.net/confluence/display/SP3/GettingStarted https://wiki.shibboleth.net/confluence/display/SP3/WebServers)

{: .note }
At this point in the deployment process, determine which federation the application will join: **TEST** or 
**PRODUCTION**. This choice influences which metadata distribution service to connect and which **Federation Manager 
(FM)** will process the **SP Registration**. 

### 2. Configure Shibboleth

For this demonstration, minor updates to the default installation are sufficient to demonstrate functionality. 
However, a deployer should thoroughly review the **Shibboleth SP** documentation and be sufficiently familiar with the 
configurable options and advanced functionality to ensure a secure deployment.

#### 2.1 `<ApplicationDefaults>` Element

To be a **SAML entity**, an **SP** requires a globally unique **entityID**. This value permits **IdPs** to identify 
the **SP** and locate the **SP’s** service end-points in the Federation metadata. Likewise, the SP uses the **IdP’s 
entityID** value to identify and locate the IdP’s service end-points in the Federation metadata. Typically, 
including a service’s **hostname** in the **entityID** value ensures a globally unique value. **Shibboleth** is very 
configurable and can operate in a multi-domain environment. A web server may have several virtual hosts, and an application may span several physical hosts, all protected by one or more instances of Shibboleth.

{: .note }
**Choose wisely!** Once registered and in-use, any change to an **entityID** value disrupts a web service’s 
availability and breaks the targeted/persistent ID generation, so any changes are discouraged.

For Linux, edit the configuration file **/etc/shibboleth/shibboleth2.xml**, and for Windows locate the shibboleth2.xml 
file within the installation directory. Locate the **ApplicationDefaults** element. Update the default value for 
**entityID**, updating the placeholder value **“https://sp.example.org/shibboleth”**.

The **REMOTE_USER** setting is an environment variable which enables Shibboleth to pass the **“authenticated username”** to an application. The default values are sufficient for this demonstration, however deployers should 
only include those attributes which are the primary identifiers in the web application. **Shibboleth** is, to some 
extent, unique among SSO tools because it does not require that **REMOTE_USER** contains a value, even if a user has 
authenticated. Details on the configurable options within the **`<ApplicationDefaults>`** element are available here:

> - [ApplicationDefaults](https://wiki.shibboleth.net/confluence/display/SP3/ApplicationDefaults)
>
> - [AttributeAccess](https://wiki.shibboleth.net/confluence/display/SP3/AttributeAccess)

#### 2.2 `<Sessions>` Element

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

#### 2.3 `<StorageService>` Element

The `<StorageService>` element configures the component used for persistent storage of information by the shibd 
daemon across requests, and in some cases, restart of the software. Update the `<StorageService>` with the following 
values.

```xml
    <StorageService type="Memory" id="memory" />
    <ReplayCache StorageService="memory" />
    <ArtifactMap StorageService="memory" />
```

[Read the details on the **`<StorageService>`** element configurable options](https://shibboleth.atlassian.net/wiki/spaces/SP3/pages/2065334626/StorageService).

#### 2.4 `<SSO>` Element

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

#### 2.5 `<MetadataProvider>` Element

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

{: .note }
Keep the private keys secure!

Details on the **`<MetadataProvider>`** elements configurable options are available here:

- [MetadataProvider](https://wiki.shibboleth.net/confluence/display/SP3/MetadataProvider)

- [XMLMetadataProvider](https://wiki.shibboleth.net/confluence/display/SP3/XMLMetadataProvider)


#### 2.6 Review the SP attribute-filter.xml file

For this demonstration, the uncommented default attributes are sufficient. A deployer selects those attributes a web 
application receives and configures the SP accordingly by updating the attribute-map.xml file. The attribute-map.xml 
configuration file maps incoming attribute names or formats into local or header variable names and determines the 
data the **SP** consumes from the **IdPs**.

The deployer will also need to register those attributes in FM. Details on the **attribute filter** configurable 
options are available here: [XMLAttributeExtractor](https://wiki.shibboleth.net/confluence/display/SP3/XMLAttributeExtractor).

### 3 Configure Apache

The default Apache installation creates a self-signed certificate which is sufficient for this demonstration. A 
production-ready deployment requires a CA-issued SSL certificate and a review of the Apache configuration files for 
suitability. This review should include enabling **UseCanonicalName** and setting a value for **ServerName**.

For this demonstration these can be set in Apache’s **conf.d/ssl.conf** file within the **`<VirtualHost _default_:443>`** 
directive.

To ensure that users are always accessing the server via **HTTPS**, either disable port 80 or configure a redirect from 
port 80/HTTP to 443/HTTPS. Adding the following virtual host element to Apache’s **conf.d/shib.conf** file is a simple 
means of achieving the redirect, replacing the string **sp-example.uni.edu.au** with the DNS name of the host. The 
**shib.conf** file also contains the default **`<Location>`** directive which protects the secure directory with 
Shibboleth.

    <VirtualHost *:80>
        ServerName sp-example.uni.edu.au:80
        RedirectMatch 301 (.*) https://sp-example.uni.edu.au$1
    </VirtualHost>

> Details on the configuration options for Apache are available here:
>
>  - [https://httpd.apache.org/docs/2.4/](https://httpd.apache.org/docs/2.4/)
>  
>  - [https://httpd.apache.org/docs/current/sections.html](https://httpd.apache.org/docs/current/sections.html)
>  
>  - [https://wiki.shibboleth.net/confluence/display/SP3/Apache](https://wiki.shibboleth.net/confluence/display/SP3/Apache)
>  
>  - [https://wiki.shibboleth.net/confluence/display/SP3/WebServers](https://wiki.shibboleth.net/confluence/display/SP3/WebServers)
>  
>  - [https://wiki.shibboleth.net/confluence/display/SP3/Clustering](https://wiki.shibboleth.net/confluence/display/SP3/Clustering)
>  
>  - [https://wiki.shibboleth.net/confluence/display/SP3/OneOrMany](https://wiki.shibboleth.net/confluence/display/SP3/OneOrMany)


> Details on the configuration options for IIS are available here:
>
> - [https://wiki.shibboleth.net/confluence/display/SP3/IIS](https://wiki.shibboleth.net/confluence/display/SP3/IIS)

### 4 Configure the application

The Shibboleth installation will create the **secure** directory in Apache’s **DocumentRoot** directory and protect 
that directory with a **`<Location>`** directive in the **conf.d/shib.conf** file. Create a PHP file in the **secure** directory 
and add the following PHP script to the file. This script is the Shibboleth protected application for this demonstration. The PHP script is not accessible without authentication and reports the Apache’s environment, including the attributes received by Shibboleth from the user agent.


    <?php echo date("h:i A, l jS \of F, Y.") ?> <br/>
    <?php echo $_SERVER['eppn']; ?> <br/>
    <?php echo $_SERVER['affiliation']; ?> <br/>
    <?php echo $_SERVER['persistent-id']; ?> <hr/>
    <?php foreach ($_SERVER as $key => $value) {
       print $key."=>".$value."<br>";} ?> <br/>

### 5 Start services and check logs

Using the system tools, start or restart the Apache and Shibboleth services. For Linux these are: httpd and shibd.

The shibd service creates its own logs in **/var/log/shibboleth**. These are the most important logs for debugging 
anything regarding the **SP** and most problems manifest here rather than in the web server logs. 

> [Read details on the available configurable options](https://wiki.shibboleth.net/confluence/display/SP3/Logging).

To check the services are active, use the following command to retrieve the Shibboleth service status from the host’s console.

    `$> curl https://localhost/Shibboleth.sso/Status --insecure`

If the Shibboleth and Apache services start correctly, the web server will respond with a Status Handler report 
containing the current time (GMT) and the operational status of the **SP** instance. The `<Status Handler>` is only 
accessible from a remote client by updating the **shibboleth2.xml** file and adding the client IP address to the 
**ACL** parameter within the **`<Handler type=”Status”>`** located within the <Sessions> element. The ACL is 
restrictive by default since the SP can reveal sensitive information about the host and software 
versions in use. 

> [Read details on the available configurable options](https://shibboleth.atlassian.net/wiki/spaces/SP3/pages/2065334870/Status+Handler)

### 6. [Register your service]({% link _pages/saml_register.markdown %})

### 7. Test access to protected content 

To test access to protected content, an active account at an existing subscriber with an **IdP** is necessary. The 
**IdP** must exist within the same Federation (**TEST** or **PRODUCTION**) as the deployed service. Access the **PHP** 
script within the protected directory **/secure** with a web browser. The **PHP** script will report values for those 
attributes which the **attribute-map.xml** configuration enables and the **Apache** session environment.




