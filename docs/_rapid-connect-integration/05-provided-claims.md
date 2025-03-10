---
title: Provided Claims
order: 5
duration: 1
last_updated: 07 March, 2025
---

The following claims are provided by AAF Rapid Connect:

<table class="table table-striped">
  <thead>
    <tr>
      <th scope="col">Claim</th>
      <th scope="col">Definition</th>
    </tr>
  </thead>
  <tbody>
    <tr>
    <th scope="row">iss</th>
      <td>Identifies the principal that issued the JWT. For AAF Rapid Connect this is always <code>https://rapid.aaf.edu.au</code> in the production environment, and <code>https://rapid.test.aaf.edu.au</code> in the test environment.
</td>
    </tr>
    <tr>
        <th scope="row">iat</th>
      <td>Identifies the time at which the JWT was issued.</td>
    </tr>
    <tr>
      <th scope="row">jti</th>
      <td>Provides a unique identifier for the JWT that can be used to prevent the JWT from being replayed.</td>
    </tr>
    <tr>
      <th scope="row">nbf</th>
      <td>Identifies the time before which the JWT MUST NOT be accepted for processing.</td>
    </tr>
    <tr>
      <th scope="row">exp</th>
      <td>Identifies the expiration time on or after which the JWT MUST NOT be accepted for processing.</td>
    </tr>
    <tr>
      <th scope="row">typ</th>
      <td>Declare a type for the contents of this JWT Claims Set in an application-specific manner in contexts where this is useful to the application.</td>
    </tr>
    <tr>
      <th scope="row">aud</th>
      <td>Identifies the audiences that the JWT is intended for. Each principal intended to process the JWT MUST identify itself with a value in audience claim. For Rapid Connect this is the value of your application's primary URL (provided as part of service registration).</td>
    </tr>
    <tr>
      <th scope="row">sub</th>
      <td>Identifies the principal that is the subject of the JWT. For Rapid Connect this is the same value supplied as edupersontargetedid within https://aaf.edu.au/attributes as documented below.</td>
    </tr>
    <tr>
      <th scope="row"><code>https://aaf.edu.au/attributes</code></th>
      <td>Contains a set of personally identifiable information associated with sub as provided by the remote AAF connected identity provider.</td>
    </tr>
  </tbody>
</table>
<br>
Timestamps are defined by the specification as `IntDate` values, which are a JSON numeric value representing the number of seconds from 1970-01-01T0:0:0Z UTC until the specified UTC date/time.
