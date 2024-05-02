---
title: Create a Basic Dockerfile
order: 2
duration: 1
---

A Dockerfile is a text file that contains a set of instructions for building a Docker image. In this case, we are 
creating a Dockerfile for a Shibboleth-Service Provider application.

```dockerfile
# Use Amazon Linux 2 as base image
FROM amazonlinux:2

# Install Apache and necessary modules
RUN yum install -y httpd mod_proxy mod_proxy_http

# Add Shibboleth repository
RUN echo -e "[shibboleth]\n\
name=Shibboleth (amazonlinux2)\n\
# Please report any problems to https://shibboleth.atlassian.net/jira\n\
type=rpm-md\n\
mirrorlist=https://shibboleth.net/cgi-bin/mirrorlist.cgi/amazonlinux2\n\
gpgcheck=1\n\
gpgkey=https://shibboleth.net/downloads/service-provider/RPMS/repomd.xml.key\n\
        https://shibboleth.net/downloads/service-provider/RPMS/cantor.repomd.xml.key\n\
enabled=1" > /etc/yum.repos.d/shibboleth.repo

# Update packages and install Shibboleth
RUN yum install -y shibboleth && yum clean all

RUN sed -i 's|var/log/shibboleth.*|/proc/self/fd/1|' /etc/shibboleth/shibd.logger

# Copy Shibboleth configuration files
COPY shibboleth2.xml /etc/shibboleth/shibboleth2.xml
COPY attribute-map.xml /etc/shibboleth/attribute-map.xml

# Copy Apache configuration file for your application
COPY myapp.conf /etc/httpd/conf.d/myapp.conf

CMD ["/usr/sbin/shibd"]
```

<br>

The above Dockerfile contains the following instructions:
```dockerfile
# Use Amazon Linux 2 as base image
FROM amazonlinux:2
```
The `FROM` instruction specifies the base image to use. In this case, a container is created with the [Amazon Linux 2](https://aws.amazon.com/amazon-linux-2/?amazon-linux-whats-new.sort-by=item.additionalFields.postDateTime&amazon-linux-whats-new.sort-order=desc) base image. However, any lightweight distribution such as Debian, CentOS, Fedora or Ubuntu can be used.

```dockerfile
# Install Apache and necessary modules
RUN yum install -y httpd mod_proxy mod_proxy_http
``` 
The first `RUN` instruction installs Apache and the necessary modules using the `yum` package manager. 

```dockerfile
# Add Shibboleth repository
RUN echo -e "[shibboleth]\n\
name=Shibboleth (amazonlinux2)\n\
# Please report any problems to https://shibboleth.atlassian.net/jira\n\
type=rpm-md\n\
mirrorlist=https://shibboleth.net/cgi-bin/mirrorlist.cgi/amazonlinux2\n\
gpgcheck=1\n\
gpgkey=https://shibboleth.net/downloads/service-provider/RPMS/repomd.xml.key\n\
        https://shibboleth.net/downloads/service-provider/RPMS/cantor.repomd.xml.key\n\
enabled=1" > /etc/yum.repos.d/shibboleth.repo
```

This tutorial installs prebuilt shib-sp packages from [RPMInstall](https://shibboleth.atlassian.net/wiki/spaces/SP3/pages/2065335566/RPMInstall).
The above `RUN` instruction adds the Shibboleth repository to the list of repositories that yum uses to fetch packages.

To install Shibboleth via Yum, first obtain a copy of the [appropriate repository file for your system.](https://shibboleth.net/downloads/service-provider/RPMS/)
    ![Service Provider RPMS](/assets/images/dockerize-shib-sp/rpms-service-provider.png)

Select the appropriate platform. For the purposes of this tutorial, the platform is Amazon Linux 2. Press "Generate". 

A yum repository file will be generated.

![Yum repo file](/assets/images/dockerize-shib-sp/yum-repository-file.png)

```dockerfile
# Update packages and install Shibboleth
RUN yum install -y shibboleth && yum clean all
```

The above `RUN` instruction updates the package list and installs Shibboleth using the `yum` package manager.

```dockerfile
RUN sed -i 's|var/log/shibboleth.*|/proc/self/fd/1|' /etc/shibboleth/shibd.logger
```

The above `RUN` instruction changes the logging configuration of Shibboleth to output to the console instead of a 
file. This is useful for viewing Shibboleth errors when running the container.

```dockerfile
# Copy Shibboleth configuration files
COPY shibboleth2.xml /etc/shibboleth/shibboleth2.xml
COPY attribute-map.xml /etc/shibboleth/attribute-map.xml
```

The above `COPY` instructions copy the Shibboleth configuration files into the container. The `shibboleth2.xml` file contains the Shibboleth configuration settings, while the `attribute-map.xml` file contains the attribute mapping rules.

```dockerfile
# Copy Apache configuration file for your application
COPY myapp.conf /etc/httpd/conf.d/myapp.conf
```

The `COPY` instruction copies the Apache configuration file for your application into the Docker image. The `myapp.conf` file contains the Apache configuration settings for your application.

```dockerfile
CMD ["/usr/sbin/shibd"]
```

Finally, the `CMD` instruction specifies the command to run when the container is started. In this case, the Shibboleth daemon (`shibd`) is started.


