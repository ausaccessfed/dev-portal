---
title: Create a Basic Dockerfile
order: 2
duration: 1
---

A Dockerfile is a text file that contains a set of instructions for building a Docker image. 

<h2>In the example below:</h2>

- the `FROM` instruction specifies the base image to use. In this case, a container is created with the [Amazon Linux 2](https://aws.amazon.com/amazon-linux-2/?amazon-linux-whats-new.sort-by=item.additionalFields.postDateTime&amazon-linux-whats-new.sort-order=desc) base image. However, any lightweight distribution such as Debian, CentOS, Fedora or Ubuntu can be used.
- the `RUN` instruction installs the necessary packages. In this case, install the prebuilt shib-sp packages from [Shibboleth](https://shibboleth.atlassian.net/wiki/spaces/SP3/pages/2065335566/RPMInstall). Note that the `shibboleth.x86_64` package is used for 64-bit OS, and `shibboleth` is used for 32-bit OS. 
- the `COPY` instruction copies the Shibboleth configuration files into the container,
- the `EXPOSE` instruction exposes the required ports. 
- the `CMD` instruction starts the Apache web server and Shibboleth SP when the container is run.

The container will start the Apache web server and Shibboleth SP when it is run.

```dockerfile
# Use Amazon Linux 2 as the base image
FROM amazonlinux:2

# Install required packages.
RUN yum -y update && \
    yum -y install httpd && \
    yum -y install shibboleth && \
    yum -y clean all

# Copy the Shibboleth configuration files into the container \
COPY shibboleth /etc/shibboleth

# Expose the necessary ports used by Shibboleth SP \
EXPOSE 80 443

# Start the Apache web server and Shibboleth SP \
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
```
