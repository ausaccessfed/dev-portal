---
title: Software Implementation
order: 3
duration: 1
---

All AAF Subscribers are required to observe good practice in relation to the configuration, operation and security of their connections to the Federation. In order to achieve this you will need to make sure that the Service Provider software connecting to eduGAIN is running the latest version.
<br>

## Latest version of software for eduGAIN services

<h3 class="text-warning">Which software are you running?</h3>

There are a number of software implementations of the SAML service provider. Each will have its own website, development activities and update notification processes. You should be following the notifications for the software you are using to implement your SAML service providers to help ensure you are running the latest secure stable version at all times. The following table provides a short list of common software that has been used within the AAF.

<table class="table">
  <thead>
    <tr>
      <th scope="col">Software</th>
      <th scope="col">Source</th>
      <th scope="col">Download site</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Shibboleth</td>
      <td>https://shibboleth.atlassian.net/wiki/spaces/SP3/overview</td>
      <td>https://shibboleth.net/downloads/service-provider/latest/</td>
    </tr>
    <tr>
      <td>SimpleSAMLphp</td>
      <td>https://simplesamlphp.org/</td>
      <td>https://simplesamlphp.org/download/</td>
    </tr>
  </tbody>
</table>
<br>

<h3 class="text-warning">Which version are you running?</h3>

To determine the software or System Information/version you are currently running, type one of the following commands:

Note: Depending on your software version, these commands/keys may vary.


#### Shibboleth SP

You can determine the overall version of the SP software you have installed by running shibd from the command line with the -v option (Linux/Unix only).

`shibd -v`


On Windows, use:

`shibd -version` 

If the shibboleth SP isn't in your path and you get the `'unrecognised command'` error, you might have to browse to the folder, usually `c:\opt\shibboleth-sp\sbin`.


For any platform, you can determine the version of the SP and various libraries by examining log files during the 
startup sequence or, if you have sufficient access, by using the <a href="https://shibboleth.atlassian.net/wiki/spaces/SP3/pages/2065334870/Status+Handler">status handler</a>.


#### SimpleSAMLphp

To determine the version you are currently running:


SimpleSAML_Configuration-class:

```shell
require_once('.../lib/_autoload.php');

$cfg = SimpleSAML_Configuration::loadFromArray(array());

echo $cfg->getVersion();
```

Output can be something like:

`1.14.14`

<br>

<h3 class="text-warning">Upgrading your software</h3>

Consult the software web site for detailed information on upgrading. Upgrading the Shibboleth SP software is generally straight forward as it packaged software on a number of Linux variants.


When upgrading please ensure you upgrade your test version in the AAF test federation before moving to your production services. Also consider your organisation change processes when upgrading software.
{: .callout-info }

<h3 class="text-warning">Keeping your OS and supporting software up to date</h3>

You SAML Service provider software doesn’t run in isolation, there is the Operating System, Web Server, crypto software and many other dependent software components. Each of these is specific to your environments and each will have its own maintenance processes. You need to ensure that these supporting components are regularly patched and upgraded.


<h3 class="text-warning">Consuming eduGAIN metadata for Service Providers</h3>

The AAF is providing a new Metadata feeds for eduGAIN that must be consumed by AAF Services and Identity Providers that wish to join eduGAIN.


EduGAIN metadata contains all of the authorised entities that can participate with service providers and identity providers within the AAF. This includes;

- All eduGAIN Identity Providers
- All eduGAIN service providers that identify as Research and Scholarly
- All other eduGAIN service providers that have been requested by an AAF organisation and approved by the AAF


<h3 class="text-warning">Production Federation</h3>

Services in the Production federation will use the <a href="https://md.aaf.edu.au/aaf-edugain-metadata.xml">AAF eduGAIN metadata</a>. This metadata is signed by the AAF using a SHA256 signing key. You MUST use the <a href="https://md.aaf.edu.au/aaf-metadata-certificate.pem">public key</a> to verify metadata documents whenever they are retrieved.


To confirm that you have obtained the correct key ensure the file you have downloaded conforms to the following:

```shell
$> openssl x509 -subject -dates -fingerprint -in aaf-metadata-certificate.pem
         subject= /O=Australian Access Federation/CN=AAF Metadata
         notBefore=Nov 24 04:27:20 2015 GMT
         notAfter=Dec  9 04:27:20 2035 GMT
         SHA1 Fingerprint=E2:FC:CC:CB:0E:0F:3B:32:FA:55:87:29:08:DE:E0:34:DA:A2:15:5A
```
<br>

<h3 class="text-warning">Configuring a Shibboleth SP</h3>

If your service provider is using the Shibboleth SP software you will need to make the following changes to the shibboleth2.xml file generally found in the /etc/shibboleth.

Check which version of the AAF metadata you are currently using. If you obtain metadata from <a href="https://ds.aaf.edu.au">https://ds.aaf.edu.au</a> you must first update your SP to use the new AAF federation metadata source available from <a href="https://md.aaf.edu.au">https://md.aaf.edu.au</a> before continuing.


Add the following configuration beneath the AAF federation metadata configuration:

```shell
<MetadataProvider type="XML" uri="https://md.aaf.edu.au/aaf-edugain-metadata.xml"
    backingFilePath="eduGAIN-metadata.aaf.xml" reloadInterval="7200">
           <MetadataFilter type="RequireValidUntil" maxValidityInterval="2419200"/>
           <MetadataFilter type="Signature" certificate="aaf-metadata-cert.pem"/>
        </MetadataProvider>
```

Verify that the certificate used for your AAF metadata feed is the same as for the eduGAIN metadata feed. The `certificate=”aaf-metadata-cert.pem"` config should be the same for both.

Restart your service provider.