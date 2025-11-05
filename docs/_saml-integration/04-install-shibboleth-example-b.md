---
title: Install Shibboleth - Example B
order: 4
duration: 1
last_updated: 20 October, 2025
---

<br>

### Dockerizing Shib-SP

This tutorial will guide you through how to create a Docker image for a Shibboleth Service Provider (SP) application and configure it to run in a container.

Please note, this is a proof of concept and only configures Shibboleth SP. Apache will need to be installed and configured to get the app to respond to web requests. See the [shibboleth documentation](https://shibboleth.atlassian.net/wiki/spaces/SP3/pages/2065335062/Apache) for more information.
{: .callout-info}

<br>

A Dockerfile is a text file that contains a set of instructions for building a Docker image. In this case, we are creating a Dockerfile for a Shibboleth-Service Provider application.

```
# Use Amazon Linux 2 as base image (alternative lightweight distributions include Debian, CentOS, Fedora or Ubuntu).
FROM amazonlinux:2

# Add Shibboleth repository - To obtain a copy of a repository file for your system, visit https://shibboleth.net/downloads/service-provider/RPMS/ and select the appropriate platform.
RUN echo -e "[shibboleth]\n\
name=Shibboleth (amazonlinux2)\n\
# Please report any problems to https://shibboleth.atlassian.net/jira\n\
type=rpm-md\n\
mirrorlist=https://shibboleth.net/cgi-bin/mirrorlist.cgi/amazonlinux2\n\
gpgcheck=1\n\
gpgkey=https://shibboleth.net/downloads/service-provider/RPMS/repomd.xml.key\n\
        https://shibboleth.net/downloads/service-provider/RPMS/cantor.repomd.xml.key\n\
enabled=1" > /etc/yum.repos.d/shibboleth.repo

# Update packages and install Shibboleth using the `yum` package manager. `yum clean all` cleans up the package cache after the installation reducing the size of the resulting Docker image.
RUN yum install -y shibboleth && yum clean all

# Change logging configuration of Shibboleth to output to console instead of a file. This is useful for viewing Shibboleth errors when running the container.
RUN sed -i 's|var/log/shibboleth.*|/proc/self/fd/1|' /etc/shibboleth/shibd.logger

# Copy Shibboleth configuration files into the container. The `shibboleth2.xml` file contains the Shibboleth configuration settings, while the `attribute-map.xml` file contains the attribute mapping rules.
COPY shibboleth2.xml /etc/shibboleth/shibboleth2.xml
COPY attribute-map.xml /etc/shibboleth/attribute-map.xml

# Copy the secrets folder containing the SSL certificate and key files required for Shibboleth to communicate securely with the Identity Provider.
COPY secrets /etc/shibboleth/secrets

# Set read permissions for the secrets folder. This is necessary to allow Shibboleth to read the SSL certificate and key files.
RUN chmod -R 444 /etc/shibboleth/secrets

# Specifies the command to run when the container is started. In this case, the Shibboleth daemon (`shibd`) is started.
CMD ["/usr/sbin/shibd"]
```