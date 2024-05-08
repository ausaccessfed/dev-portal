---
title: Create a Basic Dockerfile
order: 2
duration: 1
---

A Dockerfile is a text file that contains a set of instructions for building a Docker image. In this case, we are creating a Dockerfile for a Shibboleth-Service Provider application.

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

COPY secrets /etc/shibboleth/secrets

# Set read permissions for the secrets folder
RUN chmod -R 444 /etc/shibboleth/secrets

EXPOSE 80

CMD ["/usr/sbin/shibd"]
```

<br>

The above Dockerfile contains the following instructions:

The `FROM` instruction specifies the base image to use. In this case, a container is created with the [Amazon Linux 2](https://aws.amazon.com/amazon-linux-2/?amazon-linux-whats-new.sort-by=item.additionalFields.postDateTime&amazon-linux-whats-new.sort-order=desc) base image. However, any lightweight distribution such as Debian, CentOS, Fedora or Ubuntu can be used.

```dockerfile
# Use Amazon Linux 2 as base image
FROM amazonlinux:2
```

The first `RUN` instruction installs Apache and the necessary modules using the `yum` package manager. 
```dockerfile
# Install Apache and necessary modules
RUN yum install -y httpd mod_proxy mod_proxy_http
``` 

The second `RUN` instruction adds the Shibboleth repository to the list of repositories that yum uses to fetch packages. This is done by installing prebuilt shib-sp packages from [RPMInstall](https://shibboleth.atlassian.net/wiki/spaces/SP3/pages/2065335566/RPMInstall).

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

To obtain a copy of an appropriate repository file for your system, visit [https://shibboleth.net/downloads/service-provider/RPMS/](https://shibboleth.net/downloads/service-provider/RPMS/).

Select the appropriate platform (as shown below). For the purposes of this tutorial, the platform is Amazon Linux 2. 

Press "Generate".
![Service Provider RPMS](/assets/images/dockerize-shib-sp/rpms-service-provider.png)

A yum repository file will be generated:
![Yum repo file](/assets/images/dockerize-shib-sp/yum-repository-file.png)

Add the command `RUN echo -e "..." > /etc/yum.repos.d/shibboleth.repo` to the Dockerfile. Place the contents of the generated repository file between the quotation marks `"..."`. Then add `\n\` at the end of each line to ensure that the file is formatted correctly.

This command will create a new YUM repository file for Shibboleth in the Docker image.

The next `RUN` instruction updates the package list and installs Shibboleth using the `yum` package manager. The `yum clean all` command is used to clean up the package cache after the installation thereby reducing the size of the resulting Docker image.

```dockerfile
# Update packages and install Shibboleth
RUN yum install -y shibboleth && yum clean all
```

The `RUN` instruction below changes the logging configuration of Shibboleth to output to the console instead of a file. This is useful for viewing Shibboleth errors when running the container.

```dockerfile
RUN sed -i 's|var/log/shibboleth.*|/proc/self/fd/1|' /etc/shibboleth/shibd.logger
```

The `COPY` instructions copy the Shibboleth configuration files into the container. The `shibboleth2.xml` file contains the Shibboleth configuration settings, while the `attribute-map.xml` file contains the attribute mapping rules.

```dockerfile
# Copy Shibboleth configuration files
COPY shibboleth2.xml /etc/shibboleth/shibboleth2.xml
COPY attribute-map.xml /etc/shibboleth/attribute-map.xml
```

The `COPY` instruction copies the Apache configuration file for your application into the Docker image. The `myapp.conf` file contains the Apache configuration settings for your application (this will be discussed further in the next section).

```dockerfile
# Copy Apache configuration file for your application
COPY myapp.conf /etc/httpd/conf.d/myapp.conf
```

The `COPY` instruction copies the `secrets` folder into the container. This folder contains the SSL certificate and key files required for Shibboleth to communicate securely with the Identity Provider.

```dockerfile
# Copy secrets folder into the container
COPY secrets /etc/shibboleth/secrets
```

The `RUN` instruction sets read permissions for the `secrets` folder. This is necessary to allow Shibboleth to read the SSL certificate and key files.

```dockerfile
# Set read permissions for the secrets folder
RUN chmod -R 444 /etc/shibboleth/secrets
```

The `EXPOSE` instruction exposes port 80 on the container. This is the port that Apache listens on.

```dockerfile
EXPOSE 80
```

Finally, the `CMD` instruction specifies the command to run when the container is started. In this case, the Shibboleth daemon (`shibd`) is started.

```dockerfile
CMD ["/usr/sbin/shibd"]
```


