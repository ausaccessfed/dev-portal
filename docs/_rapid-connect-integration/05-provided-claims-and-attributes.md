---
title: Provided Claims and Attributes
order: 5
duration: 1
last_updated: 21 March, 2025
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
<br>
<br>
The following attributes are available to Rapid Connect and are recommended by the AAF. Only consider what is truly 
necessary to provide a service. For a complete list of available AAF attributes, refer to the [AAF Support Portal Attributes](https://support.aaf.edu.au/support/solutions/folders/19000156050) page.

<table class="table table-striped">
  <thead>
    <tr>
      <th scope="col">Attribute</th>
      <th scope="col">Definition</th>
    </tr>
  </thead>
  <tbody>
    <tr>
    <th scope="row">eduPersonTargetedID</th>
      <td>This should be used as the primary identifier, to match an incoming user against an existing record in an application's data store. This attribute is guaranteed to never change for a user.
</td>
    </tr>
    <tr>
        <th scope="row">displayName</th>
      <td>This is the most appropriate name to show in the web interface, to identify the user and show that they are logged in. Do not rely on any specific format for displayName. Attempts to validate names will create problems for those users who do not fit the chosen patterns and this will invariably occur.</td>
    </tr>
<tr>
      <th scope="row">mail</th>
      <td>Only collect if there is a need to message the user, or use as a secondary identifier. </td>
    </tr>
    <tr>
      <th scope="row">eduPersonScopedAffiliation</th>
      <td>Only collect if there is a need to identify the user's organisation and their affiliation or position within their organisation.</td>
    </tr>
  </tbody>
</table>

<br>
The AAF strongly recommends that `eduPersonTargetedID` is chosen as the primary identifier rather than `email`. Email addresses change on an irregular basis for numerous reasons. When they inevitably do change, users experience service disruption while manual remediation work is undertaken to update primary identifiers. Home institutions will invariably not communicate email addresses updates to external parties.

Though `auEduPersonSharedToken` is a core attribute, it is not recommended for general use or as a primary identifier. `auEduPersonSharedToken` is only useful in grid-computing environments, or to share user data or access rules across security domains or separate Service Providers.
