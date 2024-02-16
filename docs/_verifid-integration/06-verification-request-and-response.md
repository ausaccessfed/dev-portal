---
title: Verification request and response
order: 6
duration: 1
---
<br>

### Verification request

To initiate Verification, the Client shall issue a request which is an Authorization Request(3) per the OAuth 2.0 specification. This request takes the form of redirecting the User’s browser to VerifID’s “authorization_endpoint” with a query string of the following format:

```
https://example.edu/oauth/authorize?response_type=code&client_id=CLIENT_ID&redirect_uri=REDIRECT_URL&scope=verify:student&state=STATE
```
<br>

**Required parameters:**

<table class="table">
  <thead class="thead-light">
    <tr>
      <th style="width:30%">Parameter</th>
      <th>Definition</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>response_type</code></td>
      <td>The fixed string “code” (without quotes).</td>
    </tr>
    <tr>
      <td><code>client_id</code></td>
      <td>The unique Client identifier assigned during registration.</td>
    </tr>
    <tr>
      <td><code>redirect_uri</code></td>
      <td>A callback URL for the Verification response to be delivered. This must be one of the URLs stored with the 
Client registration. We require <code>redirect_uri</code> values to be encoded according to <a href="https://datatracker.ietf.org/doc/html/rfc3986#section-2.1">RFC 3986, Section 2.1</a>. This is commonly known as percent or URL encoding. Not using this encoding method may result in HTTP 403, resource forbidden, errors.</td>
    </tr>
    <tr>
      <td><code>scope</code></td>
      <td>A space-separated list of scopes requested for Verification. The supported values for VerifID 
        are:<ul><li><code>verify:faculty<li>verify:student</li><li>verify:staff</li><li>verify:employee</li><li>verify:member
        </li><li>verify:affiliate</li><li>verify:alum</li><li>verify:library-walk-in</li><li>verify:*</li></code></li></ul>
        <br>The scope <code>verify:*</code> is interpreted specially by VerifID, and is expanded to all verification types 
        granted to the client. When requesting this scope, the verification response will indicate the true set of scopes 
        that are granted.
        <br><br>Other scopes may be listed among the supported scopes in the authorization server metadata. These are not described in this document and not required for VerifID integration.
      </td>
    </tr>
    <tr>
      <td><code>state</code></td>
      <td>An identifier which the Client provides to uniquely identify the Verification request they have initiated. It is recommended that the Client use this to relate request to response and prevent cross-site request forgery. The value must be unique and securely random, and shall be stored by VerifID for auditing purposes. Non-unique values shall be rejected by VerifID and will result in failed Verification requests. The value must be at least 16 characters, and must not exceed 128 characters in length. It must consist of only letters, numbers, hyphens (-) and underscores (_). 
        <br><br>A suggested method of generating a suitable <code>state</code> value is:
        <ol><li>Generate 60 random bytes using a cryptographically secure PRNG;</li> and then <li>Encode those bytes using 
        the URL-safe Base64 encoding scheme.</li></ol></td>
    </tr>
  </tbody>
</table>

<br>

**Optional parameters:**

<table class="table">
  <thead>
    <tr>
      <th scope="col">Parameter</th>
      <th scope="col">Definition</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>entity_id</code></td>
      <td>A preselected SAML Identity Provider provided by the Client which will be used to authenticate the User. 
If this value is provided, it is the responsibility of the Client to ensure the value represents a valid IdP which 
is known to VerifID. <br><br>The presence of this value will skip the SAML Discovery Service when performing 
federated authentication. <br><br>We require <code>entity_id</code> values to be encoded according to <a href="https://datatracker.ietf.org/doc/html/rfc3986#section-2.1">RFC 3986,Section 2.1</a>. This is commonly known as percent or URL encoding. Not using this encoding method may result in HTTP 403, resource forbidden, errors.</td>
    </tr>
</tbody>
</table>

<br>

### Verification response

After authenticating to their Organisation via the VerifID Service Operator federation, the result of Verification will be a “protected resource”4 as described in the OAuth 2.0 specification. An authorization response shall be returned by redirecting the User’s browser to the Client’s redirect_uri, with query parameters:

```
[redirect_uri]?code=AUTHORIZATION_CODE&
scope=verify:student&state=STATE
```

The parameters shall be completed as follows:

<table class="table">
  <thead>
    <tr>
      <th scope="col">Parameter</th>
      <th scope="col">Definition</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>code</code></td>
      <td>The authorization code which shall be used to gain an access token for access to the Verification result. The value shall not exceed 128 characters in length.</td>
    </tr>
    <tr>
      <td><code>scope</code></td>
      <td>The list of scopes which have been granted for Verification. Clients must allow for a space-separated list 
of values to be returned here per the OAuth 2.0 specification, even if they only anticipate receiving a single scope.
<br><br> The <code>verify:*</code> scope will not appear in this list. If it was requested, it will instead be 
expanded to the true set of scopes that are granted.</td>
    </tr>
    <tr>
      <td><code>state</code></td>
      <td>The <code>state</code> value which the Client provided in the Verification request.</td>
    </tr>
  </tbody>
</table>