---
title: Getting started
order: 3
duration: 1
last_updated:
---

The interaction used between the Subscriber and VerifID is the Authorization Code Grant(1) as defined by the OAuth 2.
0 specification [(RFC 6749)](https://datatracker.ietf.org/doc/html/rfc6749).

Unless explicitly described as optional, **all** parameters are required (i.e. no parameters are optional) in all request and response payloads. This includes parameters which are described by the OAuth 2.0 specification as optional.

Example URLs are based off the <code>https://example.edu</code> hostname. Your VerifID Service Operator will 
***advise you of the production hostname*** during Client registration.

The information under “Endpoint discovery” must be considered authoritative when determining which URL will be used for each request.


### User Agent

The <code>User-Agent</code> request header is a characteristic string that lets servers and network peers identify the application, operating system, vendor, and/or version of the requesting user agent.

For **all** requests to VerifID endpoints a <code>User-Agent</code> header **must** be supplied. Requests without a <code>User-Agent</code> header may be denied. Developers should note that this is, sadly, often not a header set by HTTP client libraries, though all libraries should be easily configurable to add this.

Valid formatting for the <code>User-Agent</code> header is described by [mdn web docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/User-Agent). To assist in debugging of requests please ensure version information of the VerifID client code you have in production is communicated within the value you provide. 
