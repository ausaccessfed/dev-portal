---
title: EduGAIN Metadata
order: 3
duration: 1
---
<br>

<h3 class="text-warning">Consuming eduGAIN Metadata</h3>

EduGAIN metadata contains all the authorised entities with which AAF service providers and identity providers can interact. The AAF provides a Metadata distribution service for eduGAIN. These include:

- All eduGAIN Identity Providers
- All eduGAIN Service Providers that identify as Research and Scholarly entity categories
- Other eduGAIN Service Providers requested by AAF subscriber organisations and approved by the AAF.

To participate in eduGAIN, AAF Service Providers and Identity Providers must:

- consume the eduGAIN metadata
- agree to and abide by the AAF eduGAIN Participant Rules

<br>

<h3 class="text-warning">Production Federation</h3>

Service Providers in the Production federation will use the <a href="https://md.aaf.edu.au/mdq/aaf_and_edugain/">AAF eduGAIN MDQ endpoints</a>. 

The AAF digitally signs the eduGAIN metadata. A service MUST use the <a href="https://md.aaf.edu.au/aaf-metadata-certificate.pem">public key</a> to verify metadata documents whenever they are retrieved. To confirm that you have obtained the correct key, ensure the PEM file you have downloaded conforms to the following:

```shell
$> openssl x509 -subject -dates -fingerprint -in aaf-metadata-certificate.pem
         subject= /O=Australian Access Federation/CN=AAF Metadata
         notBefore=Nov 24 04:27:20 2015 GMT
         notAfter=Dec  9 04:27:20 2035 GMT
         SHA1 Fingerprint=E2:FC:CC:CB:0E:0F:3B:32:FA:55:87:29:08:DE:E0:34:DA:A2:15:5A
```

<br>

<h3 class="text-warning">Configuring a Shibboleth Service Provider (SP)</h3>

For a service provider using the Shibboleth SP software, the following changes to the `/etc/shibboleth/shibboleth2.xml` file are necessary.

Add the following configuration element as a child element of the element:

```shell
<MetadataProvider
type="MDQ" id="mdq" ignoreTransport="true" cacheDirectory="/var/cache/shibboleth/mdq-metadata" baseUrl="https://md.test.aaf.edu.au/mdq/aaf_and_edugain/"
reloadInterval="1800">
<MetadataFilter type="RequireValidUntil" maxValidityInterval="2419200" />
<MetadataFilter type="Signature" certificate="aaf-metadata-certificate.pem" />
<DiscoveryFilter type="Exclude" matcher="EntityAttributes" trimTags="true" attributeName="http://macedir.org/entity-category" attributeNameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:uri" attributeValue="http://refeds.org/category/hide-from-discovery" />
</MetadataProvider>
```

The AAF digitally signs the eduGAIN metadata with the same certificate as the AAF metadata. Restart the Shibboleth service provider to load the change.

<br>

<h3 class="text-warning">Testing</h3>

To verify that the SP is consuming the eduGAIN metadata, check the Shibboleth logs for any errors and that the metadata is downloading correctly to the "cacheDirectory" `/var/cache/shibboleth/mdq-metadata`.

The Shibboleth log files should indicate any issues if the software does not load the eduGAIN metadata. It may be necessary to increase the log-level to DEBUG to log all relevant details.

If the SP does not successfully load the metadata and the logs fail to highlight the cause of the failure, contact <a href="mailto:support@aaf.edu.au">AAF Support</a> for assistance.

#### Non-Shibboleth Service Providers

For non-shibboleth SAML service providers, consult the relevant documentation for the software on how to consume federation metadata. AAF Support can provide some support for non-shibboleth software at this time.

<br>

<h3 class="text-warning">Test Federation</h3>

Though eduGAIN does not provide a test federation, the AAF does provide a test <a href="https://md.test.aaf.edu.au">eduGAIN</a> metadata feed for services in the AAF Test Federation. This feed enables testing of an SP to verify configuration changes before applying them to a production service.