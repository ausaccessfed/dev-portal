---
title: Research and Scholarship Entity Category
order: 5
duration: 1
last_updated: 07 March, 2025
---
<br>

### What is R&S?
The Research and Scholarship (R&S) Entity Category establishes a baseline attribute set that all research-related IdPs and SPs agree to exchange. The R&S Entity Category is an initiative of the international Research and Education Federations (REFEDS) community.

### Why does my service need to assert R&S?
If your service qualifies for [R&S](https://refeds.org/category/research-and-scholarship), we recommend that SPs request the AAF to assert R&S on the SP’s behalf. Service Providers asserting R&S can trust they will receive the attributes they need to authorise access. If an SP does not qualify for R&S they will need to develop an SP integration guide to distribute to international IdPs that want to use the service.

### How do I assert R&S?

Asserting R&S means:
<ul class="list-group">
    <li class="list-group-item"><i class="fa fa-check-circle" style="color:green"></i> “I meet the requirements of the R&S category. I expect to receive attributes defined in the R&S specification from IdPs indicating they support R&S”</li>
</ul>
<br>

If an SP meets the [R&S Registration Criteria](https://refeds.org/category/research-and-scholarship) then you can expect to receive these attributes from an IdP asserting R&S.

<br>

### R&S Attribute Bundle

The R&S attribute bundle consists of the following data elements. "Affiliation" is optional.

<table class="table">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">Element</th>
      <th scope="col">Definition</th>
      <th scope="col">Required?</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th scope="row">1</th>
      <td>shared user identifier</td>
      <td>The shared user identifier is a persistent, non-reassigned, non-targeted identifier defined to be either of the following:
        <br>1. eduPersonPrincipalName (if non-reassigned)
        <br>2. eduPersonPrincipalName + eduPersonTargetedID</td>
      <td style="color: green">YES</td>
    </tr>
    <tr>
      <th scope="row">2</th>
      <td>person name</td>
      <td>Person name is defined as either (or both) of the following:
        <br>1. displayName
        <br>2. givenName + sn</td>
      <td style="color: green">YES</td>
    </tr>
    <tr>
      <th scope="row">3</th>
      <td>email address</td>
      <td>Email address is defined as the mail attribute.</td>
      <td style="color: green">YES</td>
    </tr>
    <tr>
      <th scope="row">4</th>
      <td>affiliation</td>
      <td>Affiliation is defined as the eduPersonScopedAffiliation attribute.</td>
      <td style="color: red">NO</td>
    </tr>
  </tbody>
</table>