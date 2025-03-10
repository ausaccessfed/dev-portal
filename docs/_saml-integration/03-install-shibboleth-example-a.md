---
title: Install Shibboleth - Example A
order: 3
duration: 1
last_updated: 07 March, 2025
---

<br>

### A Simple PHP Server installed on Linux

The following is a sequence of steps to protect a service (in this instance, a simple PHP script) by deploying a **Shibboleth SP** with Apache running on Linux.
{: .callout-info}

For supported Linux distributions, the **Shibboleth Consortium** provides a web service which generates the appropriate package management configuration file. [Read about this service](https://shibboleth.net/downloads/service-provider/RPMS/).


Copy the configuration into a file in the repository directory, on CentOS/RedHat for example, the file can be labelled `/etc/yum.repos.d/shibboleth.repo`

### 1. Install Shibboleth

Install **Shibboleth**, Apache and the SSL libraries for the architecture of the OS: x86_64 or i386, to ensure the installation of the appropriate versions of mod_shib.so and other pluggable modules. This demonstration will use Shibboleth SP 3.1.x, Apache 2.4 and the current SSL libraries, and PHP to demonstrate the protection of a simple application and passing user attributes to the application.

`$> yum install httpd.x86_64 mod_ssl.x86_64 shibboleth.x86_64 PHP.x86_64 -y`

An outline for installing the **Shibboleth SP** on other web platforms is available in the [**Shibboleth Wiki.**](https://shibboleth.atlassian.net/wiki/spaces/SP3/pages/2065335537/Installation)

At this point in the deployment process, determine which federation the application will join: **TEST** or **PRODUCTION**. This choice influences which metadata distribution service to connect and which **Federation Manager (FM)** will process the **SP Registration**.
{: .callout-info}
