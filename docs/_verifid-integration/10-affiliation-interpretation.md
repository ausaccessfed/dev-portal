---
title: How to interpret the Affiliation
order: 10
duration: 1
last_updated: 07 March, 2025
---

[The eduPerson schema(10)](https://wiki.refeds.org/display/STAN/eduPerson+2020-01#eduPerson202001-eduPersonAffiliation) defines the attribute “`eduPersonAffiliation`” as follows:

*Specifies the person's relationship(s) to the institution in broad categories such as student, faculty, staff, alum, etc. (See controlled vocabulary).*

On the topic of what criteria define each type of user, the eduPerson schema also notes:

*It is not feasible to attempt to reach broad-scale, precise and binding inter-institutional definitions of affiliations such as faculty and students. Organizations have a variety of business practices and institutional specific uses of common terms. Therefore, each institution will decide the criteria for membership in each affiliation classification. What is desirable is that a reasonable person should find an institution's definition of the affiliation plausible.*

VerifID supplies a boolean value (i.e. true/false) for each Affiliation that forms part of a Verification. Any value which is “true” corresponds to an Affiliation which was present in the User’s set of attributes, and any value which is “false” corresponds to an Affiliation which was not present. VerifID does not augment or derive Affiliations, and instead presents them exactly as they were received from the Organisation.

It should be noted that Affiliation information may change depending on an institution's policies and procedures. The status and accuracy of this information is outside of the VerifID Service Operator’s control.
{: .callout-info}