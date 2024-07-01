---
title: Attribute Based Authorisation
order: 5
duration: 1
---

Specific attributes can be utilised to make authorisation decisions within an application.

Below is an example of the ID Token attributes that are provided by the AAF OpenID Provider and translated to OpenID Connect. 

For a live example, sign in to the [AAF OpenID Connect Demo App](https://oidc-demo.aaf.edu.au/).
  
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

The relevant attributes that can be utilised for authorisation by a Service Provider include:

<table class="table table-striped">
  <thead>
    <tr>
      <th scope="col">Attribute Name</th>
      <th scope="col">Notes on Usage</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th scope="row"><a href="https://validator.aaf.edu.au/documentation/attributes/oid:1.3.6.1.4.1.5923.1.1.1.7">eduperson_entitlement</a></th>
      <td><ul><li>Indicates a user's set of rights to specific resources.</li><li>Service provider 
invites 
some or all identity providers to express that value for those users who satisfy the 
definition.</li><li>Responsibility for authorisation of access to a particular resource can be delegated by the Service Provider to the Identity Provider.</li></ul></td>
    </tr>
    <tr>
      <th scope="row"><a href="https://validator.aaf.edu.au/documentation/attributes/oid:1.3.6.1.4.1.5923.1.1.1.1">eduperson_affiliation</a></th>
      <td><ul><li>Enables an organisation to assert its relationship with the user.</li><li>Provides a user (member of an organisation, or a specific school or faculty within it) access to a resource on a site licence basis.</li></ul></td>
    </tr>
    <tr>
      <th scope="row"><a href="https://validator.aaf.edu.au/documentation/attributes/oid:1.3.6.1.4.1.5923.1.1.1.9">eduperson_scoped_affiliation</a></th>
      <td>A multivalued attribute used to reflect multiple relationships that a user has with an organisation and that Service Providers use to authorise access.</td>
    </tr>
    <tr>
      <th scope="row"><a href="https://validator.aaf.edu.au/documentation/attributes/oid:1.3.6.1.4.1.25178.1.2.9">schac_home_organization</a></th>
      <td>A person's home organization using the domain name of the organization</td>
    </tr>
    <tr>
    <th scope="row"><a href="https://validator.aaf.edu.au/documentation/attributes/oid:0.9.2342.19200300.100.1.3">email</a></th>
      <td><ul><li>Should only be used when the service provider needs to communicate with the end user.</li>
<li>This may apply when an applicant is informed if their access to a research database is denied or 
granted</li></ul></td>
    </tr>
  </tbody>
</table>