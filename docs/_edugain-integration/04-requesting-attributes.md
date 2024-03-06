---
title: Requesting Attributes from eduGAIN IdPs
order: 4
duration: 1
---

The Australian Access Federation simplifies access to user attributes from AAF Identity providers. The AAF has defined Core attributes that a service provider can reliably expect to receive from the IdP when requested.

The AAF also provides the Federation Manager tool where service providers can register their attribute requirements. Once approved, these attributes are converted into technical attribute requirements within the metadata which inform IdPs to release a correct set of attributes.

This process of using the federation manager will continue for services that are part of eduGAIN. As a Service Provider you will use the Federation Manager to assert the attributes your service requires.

The Research and Scholarly categories will form a fundamental attribute set which guarantees a higher success rates when requesting attribute from the R&S attribute bundle. The R&S attribute bundle consists (abstractly) of the following required data elements:

    shared user identifier
    person name
    email address

and one optional element:

    affiliation

Where shared user identifier is a persistent, non-reassigned, non-targeted identifier defined to be either of the following:

    eduPersonPrincipalName (if non-reassigned)
    eduPersonPrincipalName + eduPersonTargetedID

and where person name is defined to be either (or both) of the following:

    displayName
    givenName + sn

Email address is defined to be the mail attribute, and Affiliation is defined to be the eduPersonScopedAffiliation attribute. All attributes in the R&S attribute bundle are also part of the AAF Core attribute set.


