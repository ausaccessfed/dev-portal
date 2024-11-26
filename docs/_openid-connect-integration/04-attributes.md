---
title: Attributes
order: 4
duration: 1
---

These are the attributes/claims our OpenID Provider (OP) can provide to a Relying Party (RP) currently:

This is a maturing service and at this stage only supports a subset of attributes/claims. For attribute
requirements outside this range, [please contact us to discuss](mailto:support@aaf.edu.au).
{: .callout-info}

<table class="table table-striped">
  <thead>
    <tr>
      <th scope="col">Supported Scopes</th>
      <th scope="col">Claims</th>
    </tr>
  </thead>
  <tbody>
    <tr>
    <th scope="row">openid</th>
      <td>Returns the subclaim, which uniquely identifies the user. In an ID Token, iss, aud, exp, iat, and at_hash 
claims will also be present.</td>
    </tr>
    <tr>
        <th scope="row">profile</th>
      <td>Returns claims that represent basic profile information, including name, <a href="https://validator.aaf.edu.au/documentation/attributes/oid:2.5.4.4">family_name</a>, <a href="https://validator.aaf.edu.au/documentation/attributes/oid:2.5.4.42">given_name</a>, and preferred_username.</td>
    </tr>
    <tr>
      <th scope="row">email</th>
      <td>Returns the email claim, which contains the user's <a href="https://validator.aaf.edu.au/documentation/attributes/oid:0.9.2342.19200300.100.1.3">email address</a></td>
    </tr>
    <tr>
      <th scope="row">phone</th>
      <td>Returns the <a href="https://validator.aaf.edu.au/documentation/attributes/oid:2.5.4.20">phone_number</a> of the user. Not many AAF IdPs will return this value.</td>
    </tr>
    <tr>
      <th scope="row">aueduperson</th>
      <td>Returns the users <a href="https://validator.aaf.edu.au/documentation/attributes/oid:1.3.6.1.4.1.27856.1.2.5">au_edu_person_shared_token</a> value</td>
    </tr>
    <tr>
      <th scope="row">eduperson_affiliation</th>
      <td>Returns the users <a href="https://validator.aaf.edu.au/documentation/attributes/oid:1.3.6.1.4.1.5923.1.1.1.1">eduperson_affiliation</a> value</td>
    </tr>
    <tr>
      <th scope="row">eduperson_assurance</th>
      <td>Returns the users <a href="https://validator.aaf.edu.au/documentation/attributes/oid:1.3.6.1.4.1.5923.1.1.1.11">eduperson_assurance</a> value</td>
    </tr>
    <tr>
      <th scope="row">eduperson_orcid</th>
      <td>Returns the users <a href="https://validator.aaf.edu.au/documentation/attributes/oid:1.3.6.1.4.1.5923.1.1.1.16">eduperson_orcid</a> value</td>
    </tr>
    <tr>
      <th scope="row">eduperson_principal_name</th>
      <td>Returns the users <a href="https://validator.aaf.edu.au/documentation/attributes/oid:1.3.6.1.4.1.5923.1.1.1.6">eduperson_principal_name</a> value</td>
    </tr>
    <tr>
      <th scope="row">eduperson_scoped_affiliation</th>
      <td>Returns the users <a href="https://validator.aaf.edu.au/documentation/attributes/oid:1.3.6.1.4.1.5923.1.1.1.9">eduperson_scoped_affiliation</a> value</td>
    </tr>
    <tr>
      <th scope="row">schac_home_organization</th>
      <td>Returns the users <a href="https://validator.aaf.edu.au/documentation/attributes/oid:1.3.6.1.4.1.25178.1.2.9">schac_home_organization</a> value</td>
    </tr>
    <tr>
      <th scope="row">home_organization</th>
      <td>Returns the users <a href="https://validator.aaf.edu.au/documentation/attributes/oid:2.5.4.10">o</a> value</td>
    </tr>
  </tbody>
</table>
<br>

A claim for a user will only be provided if their home organisation provides the specific attribute. For example 
most universities will *not* provide phone numbers for their users.
{: .callout-info}