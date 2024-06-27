---
title: Attribute Based Authorisation
order: 5
duration: 1
---

Specific attributes provided in the ID Token upon authentication can be used to make authorisation decisions within an application.

Below are the attributes that are provided by the AAF OpenID Provider and translated to OpenID Connect:
  
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
      "affiliate@hsww.wiz"
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

Attributes that can be utilised for authorisation include:

- [`edu_person_scoped_affiliation`](https://validator.aaf.edu.au/documentation/attributes/oid:1.3.6.1.4.1.5923.1.1.1.9) - Indicates the user's position within the organisation, e.g. student, staff, faculty, alumn, library-walk-in. This should be used when the service provider requires confirmation of the user's security domain.
- [`schac_home_organization`](https://validator.aaf.edu.au/documentation/attributes/oid:1.3.6.1.4.1.25178.1.2.9) - Indicates the user's home organisation.
- [`edu_person_affiliation`](https://validator.aaf.edu.au/documentation/attributes/oid:1.3.6.1.4.1.5923.1.1.1.1) - Specifies the person's relationship(s) to the institution in broad categories. This should be used when the service provider does not require confirmation of the user's security domain.
- [`edu_person_entitlement`](https://validator.aaf.edu.au/documentation/attributes/oid:1.3.6.1.4.1.5923.1.1.1.7) - URI (either URN or URL) indicates a set of rights to a specific resource.
