---
title: Basic Dockerfile
order: 1
duration: 1
---

The Dockerfile below will create a container with the Amazon Linux 2 base image, install the Apache web server and Shibboleth SP, copy the necessary configuration files, and expose the required ports. The container will start the Apache web server and Shibboleth SP when it is run.


```dockerfile
# Use Amazon Linux 2 as the base image
FROM amazonlinux:2

# Install necessary packages. If using a 64 bit OS, use the command yum -y install shibboleth.x86_64
RUN yum -y update && \
    yum -y install httpd && \
    yum -y install shibboleth 

# Copy the Shibboleth configuration files into the container \
    COPY shibboleth2.xml /etc/shibboleth/shibboleth2.xml \
    COPY attribute-map.xml /etc/shibboleth/attribute-map.xml 

# Expose the necessary ports \
EXPOSE 80 \
EXPOSE 443

# Start the Apache web server and Shibboleth SP \
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
```
