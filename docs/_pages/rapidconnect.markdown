---
layout: page
title: Rapid Connect
permalink: /rapidconnect/
nav_order: 2
parent: Connection Types
has_children: true
---

# Welcome

The AAF Rapid Connect service allows the AAF to translate SAML assertions which are verified by a standard Shibboleth SP into JSON Web Token (JWT) which is more suitable for use by services with restricted environments or services with no need to access some of the more advanced parts of the AAF offering.

## What you'll learn

- JWT and Rapid Connect integration code to use with your application

## What you'll need

Before you get started with AAF Rapid Connect, you MUST meet all the following high level requirements:

1. You MUST be using HTTPS on your webserver for all JWT related endpoints. You SHOULD be using HTTPS for your entire application.
2. The organisation which owns the service you're registering must be an existing AAF subscriber.
3. You must have an existing account with an AAF connected Identity Provider which you use to access AAF services.
