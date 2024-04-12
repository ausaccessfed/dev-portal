---
title: EduGAIN Metadata
order: 3
duration: 1
---
<br>

<h3 class="text-warning">Consuming eduGAIN metadata for Service Providers</h3>

The AAF is providing a new Metadata feeds for eduGAIN that must be consumed by AAF Services and Identity Providers that wish to join eduGAIN.


EduGAIN metadata contains all the authorised entities that can participate with service providers and identity providers within the AAF. These include:

- All eduGAIN Identity Providers
- All eduGAIN service providers that identify as Research and Scholarly
- All other eduGAIN service providers that have been requested by an AAF organisation and approved by the AAF


<h3 class="text-warning">Production Federation</h3>

Services in the Production federation will use the <a href="https://md.aaf.edu.au/aaf-edugain-metadata.xml">AAF eduGAIN metadata</a>. This metadata is signed by the AAF using a SHA256 signing key. You MUST use the <a href="https://md.aaf.edu.au/aaf-metadata-certificate.pem">public key</a> to verify metadata documents whenever they are retrieved.


To confirm that you have obtained the correct key, ensure the file you have downloaded conforms to the following:

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

<h3 class="text-warning">Testing</h3>

To verify that your SP is consuming the eduGAIN metadata check your SP logs for any errors and check that the metadata file is downloading correctly and appears on your server. Your SP should have created the file `/var/cache/eduGAIN-metadata.aaf.xml`.


If your SP does not load the eduGAIN metadata, your log files should provide a good indication as to the fault. You may need to increase the log level to DEBUG which will give you all the relevant details.


If your SP does not successfully load the metadata and your logs do not highlight the cause of the failure please contact <a href="mailto:support@aaf.edu.au">AAF Support</a> for assistance.


#### Non-Shibboleth Service Providers

For non-shibboleth service providers please consult the documentation provided by your software on how to consume federation metadata.  AAF Support can provide limited support for non-shibboleth software at this time.

<h3 class="text-warning">Test Federation</h3>

eduGAIN does not provide a test federation, however the AAF does provide an <a href="https://md.test.aaf.edu.au">eduGAIN feed</a> for the test federation. This metadata can be used on your test SP to verify your configuration changes before applying them to your production service.