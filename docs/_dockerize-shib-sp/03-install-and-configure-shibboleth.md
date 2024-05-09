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

An X.509 keypair is required by the Shibboleth daemon to sign and encrypt SAML messages. The keypair can be
generated using different commands depending on the system being used. For the purpose of this tutorial, a self-signed
certificate will be generated using the `openssl` command.

1. Ensure that [OpenSSL](https://www.openssl.org) has been installed.
2. Create the OpenSSL configuration file `selfsigned-cert.cnf` in the project root directory with the following content:

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

3. Generate the keypair (with a self-signed certificate valid for 10 years) using the following command:

`$ openssl req -new -x509 -config selfsigned-cert.cnf -out sp-cert.pem -days 3700`
