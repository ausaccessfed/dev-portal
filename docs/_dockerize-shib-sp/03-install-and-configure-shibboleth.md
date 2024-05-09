---
title: Install and configure Shibboleth
order: 3
duration: 1
---

In this step, you will install and configure Shibboleth in the Docker container.

<h2 class="text-warning">shibboleth2.xml</h2>

Create a `shibboleth2.xml` file in your project's root directory with the following content:

```xml
<SPConfig xmlns="urn:mace:shibboleth:3.0:native:sp:config"
xmlns:conf="urn:mace:shibboleth:3.0:native:sp:config"
xmlns:saml="urn:oasis:names:tc:SAML:2.0:assertion"
xmlns:samlp="urn:oasis:names:tc:SAML:2.0:protocol"
xmlns:md="urn:oasis:names:tc:SAML:2.0:metadata"
clockSkew="180">

    <StorageService type="Memory" id="mem" cleanupInterval="900" />

    <ApplicationDefaults entityID="https://sp.example.org/shibboleth" REMOTE_USER="eppn persistent-id targeted-id">

        <Sessions lifetime="28800" timeout="3600" relayState="cookie" checkAddress="false" handlerSSL="true"
                  cookieProps="https">
            <SSO entityID="https://idp.example.org/idp/shibboleth">
                SAML2 SAML1
            </SSO>
        </Sessions>

        <MetadataProvider type="XML" validate="true" url="https://md.test.aaf.edu.au/aaf-test-metadata.xml"
            backingFilePath="/var/cache/shibboleth/federation-metadata.xml"
            reloadInterval="1800">
            <MetadataFilter type="RequireValidUntil" maxValidityInterval="2419200" />
            <MetadataFilter type="Signature" certificate="/etc/shibboleth/secrets/aaf-metadata-cert.pem"/>
            <DiscoveryFilter type="Exclude" matcher="EntityAttributes" trimTags="true"
                             attributeName="http://macedir.org/entity-category"
                             attributeNameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:uri"
                             attributeValue="http://refeds.org/category/hide-from-discovery" />
        </MetadataProvider>

        <AttributeExtractor type="XML" path="attribute-map.xml" />
        <AttributeResolver type="Query" subjectMatch="true" />
        <AttributeFilter type="XML" validate="true" path="attribute-policy.xml" />
        <CredentialResolver type="File" key="/etc/shibboleth/secrets/sp-key.pem" certificate="/etc/shibboleth/secrets/sp-cert.pem"/>
    </ApplicationDefaults>

    <SecurityPolicyProvider type="XML" validate="true" path="security-policy.xml" />
    <ProtocolProvider type="XML" validate="true" reloadChanges="false" path="protocols.xml" />
</SPConfig>
```

The elements of the above file are defined in the "SPConfig" section of the [Shibboleth documentation](https://shibboleth.atlassian.net/wiki/spaces/SP3/pages/2063695926/SPConfig).

2. Change the `entityID` attribute on the `<ApplicationDefaults>` element to match the entity ID of your SP.
3. Change the `entityID` attribute on the `<SSO>` element to match the entity ID of your Identity Provider (IdP).
4. The `<MetadataProvider>` element specifies how to load metadata about the identity provider. The `url` attribute should point to the [metadata of the AAF](https://md.test.aaf.edu.au/aaf-test-metadata.xml) in this case.
5. The `<MetadataFilter>` element specifies the filters to apply to the metadata. In this case, the metadata is required to have a valid signature. The certificate used to validate the signature is stored in the `/etc/shibboleth/secrets/aaf-metadata-cert.pem` file and is provided by the [AAF](https://md.test.aaf.edu.au/aaf-metadata-certificate.pem).
6. The `<AttributeExtractor>` element specifies how to extract attributes from the SAML assertion. The `path` attribute should point to the `attribute-map.xml` file.

<h2 class="text-warning">attribute-map.xml</h2>
Create an `attribute-map.xml` file in the project root directory with the following content:

```xml
<Attributes xmlns="urn:mace:shibboleth:2.0:attribute-map" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
</Attributes>
```

Add the attributes you want to extract from the SAML assertion to the `attribute-map.xml` file. Below are some examples of attributes that can be extracted from the SAML assertion. You can add more attributes as needed. Refer to the [Switch sp configuration guides](https://help.switch.ch/aai/guides/sp/configuration/#5) for more information.

```xml
<!-- E-mail -->
<Attribute name="urn:oid:0.9.2342.19200300.100.1.3" id="mail"/>

<!-- Given name -->
<Attribute name="urn:oid:2.5.4.42" id="givenName"/>
        
<!-- Surname -->
<Attribute name="urn:oid:2.5.4.4" id="surname"/>

<!-- Home organization -->
<Attribute name="urn:oid:2.16.756.1.2.5.1.1.4" id="homeOrganization">
    <AttributeDecoder xsi:type="StringAttributeDecoder" caseSensitive="false"/>
</Attribute>
```

<br>

<h2 class="text-warning">attribute-policy.xml</h2>
The `<AttributeFilter>` element points to the `attribute-policy.xml` file. This file defines the attributes and values that the Service Provider will accept from the Identity Provider. Below is an example of an `attribute-policy.xml` file sourced from [Switch](https://help.switch.ch/aai/guides/sp/configuration/#5). Create this file in the project root directory and amend it according to your own requirements:

```xml
<AttributeFilterPolicyGroup
        xmlns="urn:mace:shibboleth:2.0:afp"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">

    <!--
        SWITCHaai federation attribute policy configuration file
        Based on SWITCHaai Attribute Specification 1.7.3 from 2023-06-29
        Last update: 2018-07-04 (no changes required due to version 1.7.x)

        Note (added 2021-01-27)
        Keep the attribute-map.xml and attribute-policy.xml files in sync.
        The configurations in both file files depend on each other.
    -->

    <!-- Shared rule for affiliation values. -->
    <PermitValueRule id="eduPersonAffiliationValues" xsi:type="OR">
        <Rule xsi:type="Value" value="faculty"/>
        <Rule xsi:type="Value" value="student"/>
        <Rule xsi:type="Value" value="staff"/>
        <Rule xsi:type="Value" value="alum"/>
        <Rule xsi:type="Value" value="member"/>
        <Rule xsi:type="Value" value="affiliate"/>
        <!-- The value 'employee' is not allowed in SWITCHaai -->
        <!-- <Rule xsi:type="Value" value="employee"/> -->
        <Rule xsi:type="Value" value="library-walk-in"/>
    </PermitValueRule>

    <!--
    Shared rule for all "scoped" attributes, but you'll have to manually apply it inside
    an AttributeRule for each attribute you want to check.
    -->
    <PermitValueRule id="ScopingRules" xsi:type="AND">
        <Rule xsi:type="NOT">
            <Rule xsi:type="ValueRegex" regex="@"/>
        </Rule>
        <Rule xsi:type="ScopeMatchesShibMDScope"/>
    </PermitValueRule>

    <AttributeFilterPolicy>
        <!-- This policy is in effect in all cases. -->
        <PolicyRequirementRule xsi:type="ANY"/>

        <!-- Filter out undefined affiliations and ensure only one primary. -->
        <AttributeRule attributeID="scoped-affiliation">
            <PermitValueRule xsi:type="AND">
                <RuleReference ref="eduPersonAffiliationValues"/>
                <RuleReference ref="ScopingRules"/>
            </PermitValueRule>
        </AttributeRule>

        <AttributeRule attributeID="affiliation">
            <PermitValueRuleReference ref="eduPersonAffiliationValues"/>
        </AttributeRule>

        <AttributeRule attributeID="eduPersonUniqueId">
            <PermitValueRuleReference ref="ScopingRules"/>
        </AttributeRule>

        <AttributeRule attributeID="primary-affiliation">
            <PermitValueRuleReference ref="eduPersonAffiliationValues"/>
        </AttributeRule>

        <AttributeRule attributeID="subject-id">
            <PermitValueRuleReference ref="ScopingRules"/>
        </AttributeRule>

        <AttributeRule attributeID="pairwise-id">
            <PermitValueRuleReference ref="ScopingRules"/>
        </AttributeRule>

        <AttributeRule attributeID="principalName">
            <PermitValueRuleReference ref="ScopingRules"/>
        </AttributeRule>

        <AttributeRule attributeID="uniqueID">
            <PermitValueRuleReference ref="ScopingRules"/>
        </AttributeRule>

        <!-- Regular expression filter for E-mail -->
        <AttributeRule attributeID="mail">
            <PermitValueRule xsi:type="ValueRegex" regex="^.+@.+$" />
        </AttributeRule>

        <!-- Value filter for Home organization type -->
        <AttributeRule attributeID="homeOrganizationType">
            <PermitValueRule xsi:type="OR">
                <Rule xsi:type="Value" value="university"/>
                <Rule xsi:type="Value" value="uas"/>
                <Rule xsi:type="Value" value="hospital"/>
                <Rule xsi:type="Value" value="library"/>
                <Rule xsi:type="Value" value="tertiaryb"/>
                <Rule xsi:type="Value" value="uppersecondary"/>
                <Rule xsi:type="Value" value="vho"/>
                <Rule xsi:type="Value" value="others"/>
            </PermitValueRule>
        </AttributeRule>

        <!-- Regular expression filter for Study level -->
        <AttributeRule attributeID="studyLevel">
            <PermitValueRule xsi:type="ValueRegex" regex="^\d+\-\d+$" />
        </AttributeRule>

        <!-- Regular expression filter for Staff category -->
        <AttributeRule attributeID="staffCategory">
            <PermitValueRule xsi:type="ValueRegex" regex="^\d+$" />
        </AttributeRule>

        <!-- Regular expression filter for Matriculation number -->
        <AttributeRule attributeID="matriculationNumber">
            <PermitValueRule xsi:type="ValueRegex" regex="^\d{8}$" />
        </AttributeRule>

        <!-- Regular expression filter for Date of birth -->
        <AttributeRule attributeID="dateOfBirth">
            <PermitValueRule xsi:type="ValueRegex" regex="^\d{8}$" />
        </AttributeRule>

        <!-- Value filter for Gender -->
        <AttributeRule attributeID="gender">
            <PermitValueRule xsi:type="OR">
                <Rule xsi:type="Value" value="0"/>
                <Rule xsi:type="Value" value="1"/>
                <Rule xsi:type="Value" value="2"/>
                <Rule xsi:type="Value" value="9"/>
            </PermitValueRule>
        </AttributeRule>

        <!-- Regular expression filter for Study branch 1 -->
        <AttributeRule attributeID="studyBranch1">
            <PermitValueRule xsi:type="ValueRegex" regex="^\d+$" />
        </AttributeRule>

        <!-- Regular expression filter for Study branch 2 -->
        <AttributeRule attributeID="studyBranch2">
            <PermitValueRule xsi:type="ValueRegex" regex="^\d+$" />
        </AttributeRule>

        <!-- Regular expression filter for Study branch 3 -->
        <AttributeRule attributeID="studyBranch3">
            <PermitValueRule xsi:type="ValueRegex" regex="^\d+$" />
        </AttributeRule>

        <!-- Regular expression filter for Card UID -->
        <AttributeRule attributeID="cardUID">
            <PermitValueRule xsi:type="ValueRegex" regex="^.+@.+$" />
        </AttributeRule>

        <!-- Require NameQualifier/SPNameQualifier match IdP and SP entityID respectively. -->
        <AttributeRule attributeID="persistent-id">
            <PermitValueRule xsi:type="NameIDQualifierString"/>
        </AttributeRule>

        <!-- Enforce that the value of swissEduPersonHomeOrganization is a valid Scope. -->
        <AttributeRule attributeID="swissEduPersonHomeOrganization">
            <PermitValueRule xsi:type="ValueMatchesShibMDScope" />
        </AttributeRule>

        <!-- Enforce that the values of schacHomeOrganization are a valid Scope. -->
        <AttributeRule attributeID="schacHomeOrganization">
            <PermitValueRule xsi:type="ValueMatchesShibMDScope" />
        </AttributeRule>

        <!-- Catch-all that passes everything else through unmolested. -->
        <AttributeRule attributeID="*" permitAny="true"/>

    </AttributeFilterPolicy>

</AttributeFilterPolicyGroup>
```

<br>

<h2 class="text-warning">X.509 keypair for SAML signing and encrypting</h2>

An X.509 keypair is required by the Shibboleth daemon to sign and encrypt SAML messages. The keypair can be generated using different commands depending on the system being used (e.g. Debian, Ubuntu, Rocky, CentOS). For the purpose of this tutorial, a self-signed certificate will be generated using the `openssl` command.

- Ensure that [OpenSSL](https://www.openssl.org) has been installed.
- Create the OpenSSL configuration file `selfsigned-cert.cnf` in the project root directory with the following content:

```shell
[req]
default_bits=3072
default_md=sha256
encrypt_key=no
distinguished_name=dn
# PrintableStrings only
string_mask=MASK:0002
prompt=no
x509_extensions=ext

# customize the "default_keyfile,", "CN" and "subjectAltName" lines below
default_keyfile=sp-key.pem

[dn]
CN=yourhost.example.org

[ext]
subjectAltName=DNS:yourhost.example.org
subjectKeyIdentifier=hash
```

- Generate the keypair (with a self-signed certificate valid for 10 years) using the following command:

```shell
$ openssl req -new -x509 -config selfsigned-cert.cnf -out sp-cert.pem -days 3700
```

This command will create a sp-cert.pem file and a sp-key.pem file in your project's root directory. 

To confirm the content of the generated certificate, use the following command:

```shell
$ openssl x509 -in sp-cert.pem -nameopt show_type,sep_comma_plus_space -text
```

This will generate the following:

```shell
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
            99:49:f1:2e:3b:75:85:51
    Signature Algorithm: sha256WithRSAEncryption
        Issuer: CN=PRINTABLESTRING:yourhost.example.org
        Validity
            Not Before: Mar 30 08:05:33 2021 GMT
            Not After : May 17 08:05:33 2031 GMT
        Subject: CN=PRINTABLESTRING:yourhost.example.org
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                Public-Key: (3072 bit)
                Modulus:
                    00:96:b7:88:d3:52:8c:25:41:79:5c:60:98:05:98:
                    81:13:38:74:f8:df:46:04:e9:ca:e0:15:99:c5:80:
                    8b:76:e9:e2:d8:e7:05:a7:5d:3a:e7:6a:27:2c:23:
                    37:3c:a9:a5:27:36:27:13:f1:1d:e0:d5:6a:c0:1b:
                    83:9d:11:19:77:03:e2:87:b4:41:4b:93:a0:b4:36:
                    0b:1f:79:64:f4:74:17:b9:8a:e3:ef:c4:b9:77:2d:
                    2f:a9:43:e3:79:d9:d1:cd:b8:37:9f:dd:cf:a4:50:
                    55:90:e6:f3:42:7c:b1:51:df:ce:e3:00:7f:d9:c9:
                    ba:19:43:b0:8b:84:b1:d7:38:a3:d8:3a:32:f5:8b:
                    cc:56:01:59:2e:c4:1d:5c:2e:b2:d7:08:9d:27:a8:
                    73:64:69:bb:88:21:d0:d5:3f:3e:fe:71:14:ee:e5:
                    df:13:a0:c2:f6:d2:34:46:25:55:d4:ff:d9:5a:32:
                    2c:8d:30:76:5e:b4:d4:e4:3c:0d:6b:2b:3a:c5:1c:
                    73:f0:a9:2d:ef:1e:17:11:69:74:ef:04:ee:c5:3c:
                    79:c6:c3:f3:74:47:fb:c6:a4:b2:fd:ae:5b:36:8f:
                    12:54:05:3d:13:e9:ed:74:d7:4e:c0:ab:82:20:0e:
                    55:ba:55:4c:32:e1:c3:6a:73:80:44:5c:df:cf:b9:
                    e7:fd:17:99:65:14:80:81:0c:8b:44:81:56:91:34:
                    4e:66:a4:e8:da:72:27:a7:9e:22:0c:24:e4:84:4c:
                    3c:10:20:6c:dc:1c:b8:32:c3:3a:9a:58:33:dc:4a:
                    ae:be:25:4f:6b:5b:39:0b:9d:70:96:b7:35:a5:fd:
                    27:1c:2e:4b:93:14:1a:96:12:3b:89:9d:c6:63:b1:
                    d3:54:cd:4d:16:f2:3e:45:e4:4b:1a:46:ea:dd:07:
                    d1:87:51:b6:40:c8:44:73:d1:ca:91:29:8d:54:3a:
                    62:a3:6a:72:18:aa:ba:f5:61:85:3b:b8:51:9e:5e:
                    fd:34:e1:a7:b3:97:98:9f:42:bf
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Subject Alternative Name: 
                DNS:yourhost.example.org
            X509v3 Subject Key Identifier: 
                92:00:04:2B:63:03:B4:AE:E5:32:5D:8C:0D:D9:21:18:73:2C:DD:C7
    Signature Algorithm: sha256WithRSAEncryption
         70:bf:89:7e:cf:f3:a3:45:39:1a:95:92:00:0d:7a:23:6f:96:
         94:7d:e2:09:f4:ec:5b:af:23:6b:fc:e5:91:b4:f1:f4:02:b0:
         9c:48:0f:51:50:09:f3:41:c3:49:31:59:3d:17:f7:26:9b:b0:
         ee:e4:df:d5:d4:94:ae:3b:bd:5e:47:84:a9:b2:dd:1b:59:ab:
         79:59:af:8f:80:98:aa:c4:66:7d:5f:02:e3:ab:59:c7:91:aa:
         57:64:8c:1f:f1:dd:e5:59:3a:97:75:0b:b3:dd:b9:13:80:6d:
         15:48:ce:3d:a0:a6:64:18:cb:0d:7b:a7:5d:1a:83:cb:db:cf:
         4e:6c:39:5d:27:5d:17:0e:1f:e7:a1:46:13:a4:d7:88:48:79:
         85:65:79:af:7e:55:a4:11:8d:8d:25:df:e9:a7:34:d0:de:b3:
         5e:eb:3c:a5:ca:00:31:6e:97:4a:a3:ef:8e:29:39:ad:aa:f8:
         30:80:ed:09:bf:65:c9:80:4f:c1:10:1a:4f:b8:07:a0:83:1e:
         db:b6:c8:ea:14:9a:fd:d4:15:2c:8a:7a:47:fd:20:1a:97:ce:
         3e:d5:19:13:b4:47:55:fd:98:49:d4:a3:a8:5a:aa:e4:c6:c7:
         9b:7c:b0:19:1f:d1:ad:b2:24:25:85:46:d3:de:19:f0:6e:03:
         52:23:3d:11:c0:11:99:aa:d5:af:ad:83:66:2e:9b:e5:98:32:
         d7:48:c8:db:be:f4:87:b8:f4:4c:fa:36:da:05:dc:c6:6c:85:
         5b:43:b2:44:54:0e:74:dd:b2:04:a7:3e:58:66:74:d4:49:a4:
         5a:bb:1f:9f:50:9a:86:2b:29:7e:4a:69:31:b6:7a:0a:cf:91:
         08:62:ce:e2:34:ab:d2:36:85:c7:ae:42:ab:25:5c:8e:51:48:
         5a:a1:1c:92:90:71:71:60:b1:c7:f4:76:0a:99:cb:9b:45:4f:
         ed:94:31:25:8a:79:30:3e:81:f4:44:03:bb:bb:c8:74:a4:b7:
         2a:81:48:10:89:98
-----BEGIN CERTIFICATE-----
MIID9zCCAl+gAwIBAgIJAJlJ8S47dYVRMA0GCSqGSIb3DQEBCwUAMBsxGTAXBgNV
BAMTEHRlc3QuZXhhbXBsZS5vcmcwHhcNMjEwMzMwMDgwNTMzWhcNMzEwNTE3MDgw
NTMzWjAbMRkwFwYDVQQDExB0ZXN0LmV4YW1wbGUub3JnMIIBojANBgkqhkiG9w0B
AQEFAAOCAY8AMIIBigKCAYEAlreI01KMJUF5XGCYBZiBEzh0+N9GBOnK4BWZxYCL
duni2OcFp10652onLCM3PKmlJzYnE/Ed4NVqwBuDnREZdwPih7RBS5OgtDYLH3lk
9HQXuYrj78S5dy0vqUPjednRzbg3n93PpFBVkObzQnyxUd/O4wB/2cm6GUOwi4Sx
1zij2Doy9YvMVgFZLsQdXC6y1widJ6hzZGm7iCHQ1T8+/nEU7uXfE6DC9tI0RiVV
1P/ZWjIsjTB2XrTU5DwNays6xRxz8Kkt7x4XEWl07wTuxTx5xsPzdEf7xqSy/a5b
No8SVAU9E+ntdNdOwKuCIA5VulVMMuHDanOARFzfz7nn/ReZZRSAgQyLRIFWkTRO
ZqTo2nInp54iDCTkhEw8ECBs3By4MsM6mlgz3EquviVPa1s5C51wlrc1pf0nHC5L
kxQalhI7iZ3GY7HTVM1NFvI+ReRLGkbq3QfRh1G2QMhEc9HKkSmNVDpio2pyGKq6
9WGFO7hRnl79NOGns5eYn0K/AgMBAAGjPjA8MBsGA1UdEQQUMBKCEHRlc3QuZXhh
bXBsZS5vcmcwHQYDVR0OBBYEFJIABCtjA7Su5TJdjA3ZIRhzLN3HMA0GCSqGSIb3
DQEBCwUAA4IBgQBwv4l+z/OjRTkalZIADXojb5aUfeIJ9OxbryNr/OWRtPH0ArCc
SA9RUAnzQcNJMVk9F/cmm7Du5N/V1JSuO71eR4Spst0bWat5Wa+PgJiqxGZ9XwLj
q1nHkapXZIwf8d3lWTqXdQuz3bkTgG0VSM49oKZkGMsNe6ddGoPL289ObDldJ10X
Dh/noUYTpNeISHmFZXmvflWkEY2NJd/ppzTQ3rNe6zylygAxbpdKo++OKTmtqvgw
gO0Jv2XJgE/BEBpPuAeggx7btsjqFJr91BUsinpH/SAal84+1RkTtEdV/ZhJ1KOo
WqrkxsebfLAZH9GtsiQlhUbT3hnwbgNSIz0RwBGZqtWvrYNmLpvlmDLXSMjbvvSH
uPRM+jbaBdzGbIVbQ7JEVA503bIEpz5YZnTUSaRaux+fUJqGKyl+SmkxtnoKz5EI
Ys7iNKvSNoXHrkKrJVyOUUhaoRySkHFxYLHH9HYKmcubRU/tlDElinkwPoH0RAO7
u8h0pLcqgUgQiZg=
-----END CERTIFICATE-----
```
