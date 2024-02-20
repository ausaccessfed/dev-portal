---
title: Overview
order: 1
duration: 1
---

This tutorial will assist with standing up a simple application protected by **Shibboleth** and add the application
to the **AAF’s TEST Federation** to evaluate basic functionality.

### What you'll learn
- How to install and configure Shibboleth
- How to configure Apache
- How to integrate Shibboleth SP with an application

### What you'll need

The prerequisites for this tutorial require elevated privileges to one of the supported platforms and the installation 
and/or configuration of the following components:

- a supported web server, 
- SSL libraries suitable for the web server,
- open firewall port HTTPS/443 that permits inbound and outbound traffic,
- NTP service and active time synchronisation - SAML transactions are time-sensitive,
- allocation of a DNS name for the service,
- where available, SELinux is disabled, as it may interfere with communication between the Apache web server and 
the Shibboleth process.

This guide is derived from the **Shibboleth Wiki** and assumes knowledge of the following aspects of the target OS and
architecture:

- working knowledge of the web server platform,
- standard OS-level knowledge, sufficient for software installation, configuration file editing andstarting/stopping of processes/services,
- working knowledge of XML,
- basic knowledge of public key cryptography,
- basic understanding of web cookies and redirects,
- basic understanding of web authentication.

The **Shibboleth Wiki** provides installation and configuration information for **Shibboleth Service Provider (SP)** on
the following platforms:

- RedHat/CentOS versions 6, 7 or 8 with Apache 2.2, 2.4 or FastCGI; and
- Windows 2008 and later with Apache 2.2, 2.4 or IIS;
- additional information on building packages from source for other RPM-supporting Linux versions.


The **Shibboleth Consortium** has considerably streamlined the **SP** installation process for Linux and Apache, and
this guide reflects that approach. Other combinations of platform and web server require additional steps to install
the **SP**, configure the web server and protect content. For these, links in this guide will refer deployers to
additional **Shibboleth documentation**.

All links in this tutorial are collated on the [Links Page](/saml-integration/09-links).
{: .info}