---
title: Interaction
order: 2
duration: 1
---

The primary interaction of this service requires a User who is accessing a web-based service via a standard web browser.

1. A Client identifies a need to verify the User’s Affiliation values

1. The Client issues a Verification request as specified in [Section 6](/verifid-integration/06-verification-request-and-response) of this tutorial

1. Via VerifID, the User is directed to perform an interactive authentication via the VerifID operator’s SAML federation

1. Upon successful authentication, the User returns to VerifID, which issues a Verification response as specified in 
   the [Section 6](/verifid-integration/06-verification-request-and-response) of this tutorial

1. The Client makes an authenticated request to retrieve an access token which can be used to retrieve the Verification result

1. The Client makes an API call to VerifID to retrieve the Verification result

1. The Verification result is parsed and the Client can use the data within to determine the User’s Affiliation values.


![Perform verification](/assets/images/verifid-integration/Perform-verification.png)

**Figure 1.** Performing a Verification