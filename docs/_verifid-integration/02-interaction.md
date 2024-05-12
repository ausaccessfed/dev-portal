---
title: Interaction
order: 2
duration: 1
---

The primary interaction of this service requires a User who is accessing a web-based service via a standard web browser.

A Client identifies a need to verify the User’s Affiliation values

1. The Client issues a Verification Request as specified in [Section 6](/verifid-integration/06-verification-request-and-response) of this tutorial

1. The Verification Request is redirected (via the User's browser) to the VerifID Service

1. At VerifID, the User is directed to perform an interactive authentication via the VerifID operator’s SAML federation

1. On successful authenication at the User's home institution within the SAML Federation, the User is redirected back to VerifID

1. VerifID issues a Verification response and a redirect back to the User's browser as specified in the [Section 6](/verifid-integration/06-verification-request-and-response) of this tutorial

1. The Verification response is redirected through by User's browser to the Client. 

1. On receiving the Verfication Response, the Client makes an authenticated request to retrieve an access token which is used to retrieve the Verification result

1. The Client makes an API call to VerifID to retrieve the Verification result

At the Client, the Verification result is parsed and the Client determines the User’s Affiliation values.

![Verification Flow](/assets/images/verifid-integration/VerifID-verification.png)

**Figure 1.** Performing a Verification
