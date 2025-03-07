---
title: Attribute Based Authorisation
order: 6
duration: 1
last_updated:
---

Specific attributes can be utilised to make authorisation decisions within an application.

Below is an example of the ID Token attributes that are provided by the AAF OpenID Provider and translated to OpenID Connect:
  
```json
  {
    "sub": "YAdr3eQkhvnHrtOcdnOl4cFRdYnOmKoP4523eh45y89",
    "name": "John Doe",
    "given_name": "John",
    "family_name": "Doe",
    "preferred_username": "jdoe",
    "email": "john.doe@uni.edu.au",
    "phone_number": "+61 412 345 678",
    "au_edu_person_shared_token": "BG67eQkhvnHrtOcdnOl4cFRdYnO",
    "edu_person_affiliation": [
      "affiliate"
    ],
    "edu_person_assurance": [
      "urn:mace:uni.edu.au:iap:id:1",
      "urn:mace:uni.edu.au:iap:authn:1"
    ],
    "edu_person_entitlement": [
      ""
    ],
    "edu_person_orcid": "0000-0000-0000-0000",
    "edu_person_principal_name": "jdoe@hsww.wiz.edu.au",
    "edu_person_scoped_affiliation": [
      "faculty@hsww.wiz.edu.au"
    ],
    "schac_home_organization": "hsww.wiz",
    "iss": "https://hsww.wiz.edu.au",
    "aud": "b56y89re-4w32-2c5r-0b3q-1a2s3d4f5g6h",
    "exp": 1234567890,
    "iat": 1234567890,
    "auth_time": 1234567890,
    "azp": "b56y89re-4w32-2c5r-0b3q-1a2s3d4f5g6h",
    "nonce": "6oP4523eh45y89re4w322c5r0b3q1e1e"
}
```

<br>

For a live example of attribute release for your institution, sign in to the [AAF OpenID Connect Demo App](https://oidc-demo.aaf.edu.au/).
{: .callout-info}

<br>

The relevant attributes that can be utilised for authorisation by a Service Provider (SP) include:

<table class="table table-striped">
  <thead>
    <tr>
      <th scope="col">Attribute Name</th>
      <th scope="col">Notes on Usage</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th scope="row"><a href="https://validator.aaf.edu.au/documentation/attributes/oid:1.3.6.1.4.1.5923.1.1.1.7">eduPersonEntitlement</a></th>
      <td><ul><li>Indicates a user's set of rights to specific resources.</li><li>The SP can invite some or all Identity Providers (IdP) to express that value for those users who satisfy the definition.
</li><li>The SP can delegate responsibility for authorisation of access to a particular resource to the IdP.</li></ul></td>
    </tr>
    <tr>
      <th scope="row"><a href="https://validator.aaf.edu.au/documentation/attributes/oid:1.3.6.1.4.1.5923.1.1.1.1">eduPersonAffiliation</a></th>
      <td><ul><li>Enables an organisation to assert its relationship with the user.</li><li>Provides a user (member of an organisation, or a specific school or faculty within it) access to a resource on a site licence basis.
</li><li>Should be used when the SP <strong>does not</strong> need confirmation of the security domain of the user.</li></ul></td>
    </tr>
    <tr>
      <th scope="row"><a href="https://validator.aaf.edu.au/documentation/attributes/oid:1.3.6.1.4.1.5923.1.1.1.9">eduPersonScopedAffiliation</a></th>
      <td><ul><li>A multivalued attribute used to reflect multiple relationships that a user has with an organisation.</li>
<li>Should be used when the SP <strong>does need</strong> confirmation of the security domain of the user.</li></ul></td>
    </tr>
    <tr>
      <th scope="row"><a href="https://validator.aaf.edu.au/documentation/attributes/oid:1.3.6.1.4.1.25178.1.2.9">schacHomeOrganization</a></th>
      <td><ul><li>Can be used when the SP needs to identify the Home Institution of a user.</li></ul></td>
    </tr>
    <tr>
      <th scope="row"><a href="https://validator.aaf.edu.au/documentation/attributes/oid:0.9.2342.19200300.100.1.3">mail</a></th>
      <td><ul><li>Should only be used when the SP needs to communicate with the end user.</li>
<li>This may apply when an applicant needs to be informed whether their access to a research database has been granted or denied.</li></ul></td>
    </tr>
  </tbody>
</table>