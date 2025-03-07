---
title: Requesting Attributes - eduGAIN IdPs
order: 4
duration: 1
last_updated:
---

The Australian Access Federation simplifies access to user attributes from AAF Identity providers. The AAF has defined Core attributes that a service provider can reliably expect to receive from the IdP when requested.

The AAF also provides the <a href="https://manager.aaf.edu.au/welcome">Federation Manager</a> tool where service providers can register their attribute requirements.

Once approved, these attributes are converted into technical attribute requirements within the metadata which inform IdPs to release a correct set of attributes.

This process of using Federation Manager will continue for services that are part of eduGAIN. As a Service Provider you will use Federation Manager to assert the attributes your service requires.

The Research and Scholarly categories will form a fundamental attribute set which guarantees a higher success rate when requesting attributes from the R&S attribute bundle. 
<br>

The R&S attribute bundle consists (abstractly) of the following **required** data elements:

<ul class="list-group list-group">
  <li class="list-group-item">1. shared user identifier</li>
  <li class="list-group-item">2. person name</li>
  <li class="list-group-item">3. email address</li>
</ul>
<br>
and one **optional** element:


1. affiliation

<br>
Where **shared user identifier** is a persistent, non-reassigned, non-targeted identifier defined to be either of the following:

- eduPersonPrincipalName (if non-reassigned)
- eduPersonPrincipalName + eduPersonTargetedID

and where **person name** is defined to be either (or both) of the following:

- displayName
- givenName + sn

**Email address** is defined to be the mail attribute, and **Affiliation** is defined to be the eduPersonScopedAffiliation attribute. All attributes in the R&S attribute bundle are also part of the AAF Core attribute set.


