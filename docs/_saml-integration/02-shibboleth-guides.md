---
title: Shibboleth Guides
order: 2
duration: 1
last_updated: 07 March, 2025
---

The key to deploying federated services is understanding **Shibboleth** and **SAML**, how the required components
interact, and details on session cookies and the terminology in use. 

<strong>The following articles serve as an introduction to these topics:</strong>

<ul class="list-group list-group-flush">
  <li class="list-group-item"><a href="https://wiki.shibboleth.net/confluence/display/CONCEPT/FlowsAndConfig">Describes the interaction between Identity Provider (IdP) and Service Provider (SP)</a></li>
  <li class="list-group-item"><a href="https://wiki.shibboleth.net/confluence/display/SP3/ApplicationModel">Describes the Application Model</a></li>
  <li class="list-group-item"><a href="https://wiki.shibboleth.net/confluence/display/SP3/ApplicationIntegration">Describes Application Integration</a></li>
</ul>
<br>

<strong>Starting point for installation on Linux, Windows and Mac</strong>

<ul class="list-group list-group-flush">
  <li class="list-group-item"><a href="https://wiki.shibboleth.net/confluence/display/SP3/SystemRequirements">System Requirements</a></li>
  <li class="list-group-item"><a href="https://wiki.shibboleth.net/confluence/display/SP3/Installation">Installations</a></li>
</ul>
<br>

<strong>SP Configuration</strong>

<ul class="list-group list-group-flush">
  <li class="list-group-item"><a href="https://wiki.shibboleth.net/confluence/display/SP3/SPConfig">Elements and Components</a></li>
</ul>
<br>

### Standard Flow
The diagram below illustrates the interaction between the user, the service provider (SP) and the identity provider (IdP).


![SAML Diagram](/assets/images/saml-integration/saml-diagram.png)

Figure 1. Shibboleth Component Interactions

The interactions are as follows (and are referenced from [Shibboleth](https://shibboleth.atlassian.net/wiki/spaces/CONCEPT/overview)):

- The SP detects the user attempting to access restricted content within the resource.    
- The SP generates an authentication request, then sends that request, and the user, to the user's IdP.
- The IdP authenticates the user, then sends the authentication response, and the user, back to the SP.
- The SP verifies the IdP's response and sends the request through to the resource which returns the originally requested content.