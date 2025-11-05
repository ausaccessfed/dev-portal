---
title: Attribute Based Authorisation
order: 9
duration: 1
last_updated: 20 October, 2025
---

Specific claims within the ID token can be utilised to make authorisation decisions within an application.

Below is an example of a decoded JWS for the user "John Doe" sent by Rapid Connect.

```
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

For a live example of attribute release for your institution, sign in to the [AAF Rapid Connector App](https://rapid-connector.dev.aaf.edu.au/).
{: .callout-info}

<br>

Attributes that can be utilised for authorisation are contained within the claim object `https://aaf.edu.au/attributes` of the JWS and include:

<table class="table table-striped">
  <thead>
    <tr>
      <th scope="col">Attribute Name</th>
      <th scope="col">Notes on Usage</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th scope="row"><a href="https://validator.aaf.edu.au/documentation/attributes/oid:1.3.6.1.4.1.5923.1.1.1.9">eduPersonScopedAffiliation</a></th>
      <td><ul><li>Used to authorise users based on their affiliation/s in their home organisation.</li><li>Should be used when the Service Provider <strong>does not</strong> need confirmation of the security domain of the user.
</li></ul></td>
    </tr>
    <tr>
      <th scope="row"><a href="https://validator.aaf.edu.au/documentation/attributes/oid:0.9.2342.19200300.100.1.3">mail</a></th>
      <td><ul><li>Should only be used when a Service Provider needs to communicate with the end user.</li>
<li>This may apply when an applicant needs to be informed whether their access to a research database has been granted or denied.</li></ul></td>
    </tr>
    <tr>
      <th scope="row"><a href="https://validator.aaf.edu.au/documentation/attributes/oid:2.5.4.3">commonName</a></th>
      <td>Should only be used if a user's common name is necessary for a wiki or other collaboration platform.</td>
    </tr>
    <tr>
      <th scope="row"><a href="https://validator.aaf.edu.au/documentation/attributes/oid:2.16.840.1.113730.3.1.241">displayName</a></th>
      <td>Should only be used if a user's preferred name is necessary for a wiki or other collaboration platform.</td>
    </tr>
  </tbody>
</table>

The claim `organizationname` should not be used for authorisation decisions.
{: .callout-info}

