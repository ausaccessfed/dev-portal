---
title: Create a Script
order: 2
duration: 1
---

The following script utilises the LDAP attribute called `distinguishedName` to store group information. Other 
directories may use `memberOf` or various other attributes.

The script assumes that the values or relative distinguished names (RDN) of `distinguishedName` include:

<ul class="list-group list-group">
  <li class="list-group-item">CN - commonName</li>
  <li class="list-group-item">OU - organizationalUnitName</li>
  <li class="list-group-item">DC - domainComponent</li>
</ul>
<br>

where an example of a `distinguishedName`, containing RDNs separated with commas, is below:

<ul class="list-group list-group">
  <li class="list-group-item">CN=John Smith,OU=STAFF,DC=EDU,DC=AU</li>
</ul>
<br>

As you can see the below code matches on the partial OU=STAFF (and student/other). These comparisons are case-sensitive.

```xml
<resolver:AttributeDefinition id="distinguishedName" xsi:type="ad:Simple" sourceAttributeID="distinguishedName">
  <resolver:Dependency ref="myLDAP" />
</resolver:AttributeDefinition>

<resolver:AttributeDefinition xsi:type="Script" xmlns="urn:mace:shibboleth:2.0:resolver:ad"
  id="eduPersonAffiliation"
    sourceAttributeID="eduPersonAffiliation">

  <!-- Dependency that provides the source attribute. -->
  <resolver:Dependency ref="distinguishedName" />

  <!-- SAML 1 and 2 encoders for the attribute. -->
  <resolver:AttributeEncoder xsi:type="SAML1String" xmlns="urn:mace:shibboleth:2.0:attribute:encoder"
      name="urn:mace:dir:attribute-def:eduPersonAffiliation" />
  <resolver:AttributeEncoder xsi:type="SAML2String" xmlns="urn:mace:shibboleth:2.0:attribute:encoder"
      name="urn:oid:1.3.6.1.4.1.5923.1.1.1.1"
  friendlyName="eduPersonAffiliation" />

  <!-- The script, wrapped in a CDATA section so that special XML characters don't need to be removed -->
  <Script><![CDATA[
  importPackage(Packages.edu.internet2.middleware.shibboleth.common.attribute.provider);

  // Create attribute to be returned from definition
  eduPersonAffiliation = new BasicAttribute("eduPersonAffiliation");

  // Add at least one value
  eduPersonAffiliation.getValues().add("affiliate");


  // If the user has group membership
  if (typeof distinguishedName != "undefined" && distinguishedName != null ){
  // Then go through each group membership and add the appropriate affiliation
  // The IdP will remove duplicate values so we don't need to worry about that here
  for ( i = 0; distinguishedName != null && i < distinguishedName.getValues().size(); i++ ){
    value = distinguishedName.getValues().get(i);

  if (value.indexOf("OU=STUDENTS") > 0){
  eduPersonAffiliation.getValues().add("student");
  }

  if (value.indexOf("OU=STAFF") > 0){
  eduPersonAffiliation.getValues().add("staff");
  }

  if (value.indexOf("OU=OTHERS") > 0){
  eduPersonAffiliation.getValues().add("affiliate");
  }
  }
  }
  ]]></Script>
</resolver:AttributeDefinition>
```

<br>

The following debug statements can be added to your script and will output data in your Tomcat log files `catalina.localhost.<date>.log` or similar. 

BE SURE TO REMOVE THESE STATEMENTS ONCE YOUR TESTING IS COMPLETE.
{: .callout-warning}

Debug for use before for loop:

```shell
print("\n\n------------DEBUG START SCRIPT CDATA");
print("\nSCRIPT DEBUG: " + (distinguishedName != null));
print("\nSCRIPT DEBUG: " + distinguishedName.getValues());
```

Debug for use within for loop:

```shell
print("\nSCRIPT DEBUG: Processing distinguishedName value: " + value);
```
