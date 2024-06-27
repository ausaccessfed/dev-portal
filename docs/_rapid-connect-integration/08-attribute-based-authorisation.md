---
title: Attribute Based Authorisation
order: 8
duration: 1
---

Specific claims within the ID token can be utilised to make authorisation decisions within an application.

Below is an example of a decoded JWS for the user "John Doe" sent by Rapid Connect:

```json
{
  "iat": 1516239022,
  "nbf": 1516239022,
  "exp": 1516242622,
  "jti": "f7e8b1b46b4b4b7d8f0f2b7f1b1b4b7d",
  "typ": "authnresponse",
  "https://aaf.edu.au/attributes": {
    "cn": "John Doe",
    "displayname": "John Doe",
    "surname": "Doe",
    "givenname": "John",
    "mail": "john.doe@someuni.edu.au",
    "organizationname": "Some University",
    "edupersonorcid": "0000-0000-0000-0000",
    "edupersonscopedaffiliation": "affiliate@hsww.wiz.edu.au",
    "edupersonprincipalname": "jdoe@hsww.wiz.edu.au",
    "edupersontargetedid": "https://someuni.edu.au!https://someuni.edu.au/some_connections/1!7bVg9m6p/JI3i/JZ76YCZ7k6pQJ="
  },
  "iss": "https://someuni.edu.au",
  "aud": "https://someuni.edu.au/some_connections/1",
  "sub": "https://someuni.edu.au!https://someuni.edu.au/some_connections/1!7bVg9m6p/JI3i/JZ76YCZ7k6pQJ="
}
```

<br>

Attributes that can be utilised for authorisation are contained within the claim object `https://aaf.edu.au/attributes` and include:

- [`edupersonscopedaffiliation`](https://validator.aaf.edu.au/documentation/attributes/oid:1.3.6.1.4.1.5923.1.1.1.9) - Indicates the user's position within the organisation, e.g. student, staff, faculty, alumn, library-walk-in. This should be used when the service provider requires confirmation of the user's security domain.

The claim `organizationname` should not be used for authorisation decisions.
{: .callout-info}

