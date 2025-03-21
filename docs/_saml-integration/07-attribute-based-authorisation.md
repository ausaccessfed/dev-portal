---
title: Attribute Based Authorisation
order: 7
duration: 1
last_updated: 02 July, 2024
---

Released attributes can be utilised to make authorisation decisions within an application. 

Below are the core attributes that can be released by the AAF Identity Provider (IdP) to a Service Provider (SP) using SAML:

![Core attributes](/assets/images/saml-integration/core-attributes.png)

<br>

For a live example of attribute release for your institution, sign in to [AAF Validator](https://validator.aaf.edu.au/).
{: .callout-info}

<br>

The core attributes that can be utilised for authorisation by a SP include:

<table class="table table-striped">
  <thead>
    <tr>
      <th scope="col">Attribute Name</th>
      <th scope="col">Notes on Usage</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th scope="row"><a href="https://validator.aaf.edu.au/documentation/attributes/oid:2.16.840.1.113730.3.1.241">displayName</a></th>
      <td><ul><li>Should only be used if a user's preferred name is necessary for a wiki or other collaboration platform.</li></ul></td>
    </tr>
    <tr>
      <th scope="row"><a href="https://validator.aaf.edu.au/documentation/attributes/oid:1.3.6.1.4.1.5923.1.1.1.1">eduPersonAffiliation</a></th>
      <td><ul><li>Enables an organisation to assert its relationship with the user.</li><li>Provides a user (member of an organisation, or a specific school or faculty within it) access to a resource on a site licence basis.</li>
      <li>Should be used when the SP <strong>does not</strong> need confirmation of the security domain of the user.</li></ul></td>
    </tr>
    <tr>
      <th scope="row"><a href="https://validator.aaf.edu.au/documentation/attributes/oid:1.3.6.1.4.1.5923.1.1.1.9">eduPersonScopedAffiliation</a></th>
      <td><ul><li>Used to authorise users based on their affiliation/s in their home organisation.</li><li>Should be used when the SP <strong>does not</strong> need confirmation of the security domain of the user.</li></ul></td>
    </tr>
    <tr>
      <th scope="row"><a href="https://validator.aaf.edu.au/documentation/attributes/oid:1.3.6.1.4.1.5923.1.1.1.7">eduPersonEntitlement</a></th>
      <td><ul><li>Indicates a user's set of rights to specific resources.</li><li>The SP can invite some or all IdPs to express that value for those users who satisfy the definition. </li><li>The SP can delegate responsibility for authorisation of access to a particular resource to the IdP.</li></ul></td>
    </tr>
    <tr>
      <th scope="row"><a href="https://validator.aaf.edu.au/documentation/attributes/oid:0.9.2342.19200300.100.1.3">mail</a></th>
      <td><ul><li>Should only be used when a SP needs to communicate with the end user.</li>
      <li>This may apply when an applicant needs to be informed whether their access to a research database has been granted or denied.</li></ul></td>
    </tr>
    <tr>
      <th scope="row"><a href="https://validator.aaf.edu.au/documentation/attributes/oid:1.3.6.1.4.1.25178.1.2.9">homeOrganization</a></th>
      <td><ul><li>Can be used when the SP needs to identify the Home Institution of a user.</li></ul></td>
    </tr>
  </tbody>
</table>