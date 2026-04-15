---
title: Provided Claims and Attributes
order: 5
duration: 1
last_updated: 21 March, 2025
---

<strong>The following claims are provided by AAF Rapid Connect:</strong>

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
<strong>The following attributes are available to Rapid Connect and the AAF recommends:</strong>
- `eduPersonTargetedID` — This should be used as the primary identifier, to match an incoming user against an existing record in an application's data store. This attribute is guaranteed to never change for a user.

- `displayName` — This is the most appropriate name to show in the web interface, to identify the user and show that they are logged in. Do not rely on any specific format for displayName. Attempts to validate names will create problems for those users who do not fit the chosen patterns and this will invariably occur.

- `mail` — Only collect if there is a need to message the user, or use as a secondary identifier.

- `eduPersonScopedAffiliation` — Only collect if there is a need to identify the user's organisation and their affiliation or position within their organisation.

- `eduPersonEntitlement` — Only collect if there is a need to identify specific entitlements assigned to the user.

The AAF strongly recommends that `eduPersonTargetedID` is chosen as the primary identifier rather than `email`. `Email` addresses change on an irregular basis for numerous reasons. When they inevitably do change, users experience service disruption while manual remediation work is undertaken to update primary identifiers. Home institutions will invariably not communicate email addresses updates to external parties.
{: .callout-info}
Though `auEduPersonSharedToken` is a core attribute, it is not recommended for general use or as a primary identifier. `auEduPersonSharedToken` is only useful in grid-computing environments, or to share user data or access rules across security domains or separate Service Providers.
{: .callout-info}

<table class="table table-striped">
  <thead>
    <tr>
      <th scope="col">Attribute</th>
      <th scope="col">Definition</th>
    </tr>
  </thead>
  <tbody>
<tr>
    <th scope="row">authenticationMethod</th>
      <td>Defines the method(s) used to verify the person's identity.
</td>
    </tr>
    <tr>
    <th scope="row">cn (commonName)</th>
      <td>An individual's common name.
</td>
    </tr>
    <tr>
        <th scope="row">displayName</th>
      <td>This is the most appropriate name to show in the web interface, to identify the user and show that they are logged in. Do not rely on any specific format for displayName. Attempts to validate names will create problems for those users who do not fit the chosen patterns and this will invariably occur.</td>
    </tr>
    <tr>
    <th scope="row">eduPersonOrcid</th>
      <td>ORCID iDs are persistent digital identifiers for individual researchers. Their primary purpose is to unambiguously and definitively link them with their scholarly work products. ORCID iDs are assigned, managed and maintained by the ORCID organization. Values MUST be valid ORCID identifiers in the ORCID-preferred URL representation. Each value represents an ORCID identifier registered with ORCID.org as belonging to the principal.
</td>
    </tr>
    <tr>
    <th scope="row">eduPersonEntitlement</th>
      <td>URI (either URN or URL) that indicates a set of rights to specific resources.
</td>
    </tr>
<tr>
    <th scope="row">eduPersonPrincipalName</th>
      <td>eduPerson per Internet2 and EDUCAUSE.
</td>
    </tr>
    <tr>
      <th scope="row">eduPersonScopedAffiliation</th>
      <td>Specifies the person's relationship(s) to the institution in broad categories. Only collect if there is a need to identify the user's organisation and their affiliation or position within their organisation.</td>
    </tr>
    <tr>
      <th scope="row">auEduPersonSharedToken</th>
      <td>A unique identifier enabling federation spanning services such as Grid and Repositories. Values of the identifier are generated using a set formula.[^1] Only collect if there is a need to share user data or access rules across security domains or separate Service Providers. This attribute is only useful in grid-computing environments.</td>
    </tr>
    <tr>
    <th scope="row">eduPersonTargetedID</th>
      <td>A persistent, non-reassigned, privacy-preserving identifier for a user shared between an identity provider and service provider. An identity provider uses the appropriate value of this attribute when communicating with a particular service provider or group of service providers, and does not reveal that value to any other service provider except in limited circumstances.
</td>
    </tr>
<tr>
    <th scope="row">eduPersonTargetedID</th>
      <td>This should be used as the primary identifier, to match an incoming user against an existing record in an application's data store. This attribute is guaranteed to never change for a user.
</td>
    </tr>
    <tr>
    <th scope="row">givenName</th>
      <td>Person's given or first name.
</td>
    </tr>
<tr>
    <th scope="row">mail</th>
      <td>The person's public email address used to contact the person regarding matters related to their organisation. Only collect if there is a need to message the user, or use as a secondary identifier. </td>
    </tr>
    <tr>
    <th scope="row">organizationName</th>
      <td>The standard name of the top-level organization (institution) with which this person is associated.
</td>
    </tr>
<tr>
    <th scope="row">surname</th>
      <td>The person's surname.
</td>
    </tr>
</tbody>
</table>

<br>

[^1] The value has the following qualities:

- unique
- opaque
- non-targeted
- persistent
- resolvable (only by an IdP that has supplied it)
- not re-assignable
- not mutable (refreshing the value is equivalent to creating a new identity)
- permitted to be displayed
  - (Note: the value is somewhat display friendly, and may be appended to the displayName with a separating space,
      and used as a unique display name to be included in PKI Certificate DNs and as a resource ownership label, e.g. John Citizen ZsiAvfxa0BXULgcz7QXknbGtfxk)
- portable

<br>

See the following links for complete information and definitions of the core, optional and conditional AAF attributes available:

- [Support Portal Attributes page](https://support.aaf.edu.au/support/solutions/folders/19000156050)
- [Validator Service](https://validator.aaf.edu.au/documentation/categories)
