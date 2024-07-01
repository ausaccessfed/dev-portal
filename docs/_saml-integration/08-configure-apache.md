---
title: Configure Apache
order: 8
duration: 1
---

The default Apache installation creates a self-signed certificate which is sufficient for this demonstration. A
production-ready deployment requires a CA-issued SSL certificate and a review of the Apache configuration files for
suitability. This review should include enabling **UseCanonicalName** and setting a value for **ServerName**.

For this demonstration these can be set in Apache’s **conf.d/ssl.conf** file within the **`<VirtualHost _default_:443>`**
directive.

To ensure that users are always accessing the server via **HTTPS**, either disable port 80 or configure a redirect from
port 80/HTTP to 443/HTTPS. Adding the following virtual host element to Apache’s **conf.d/shib.conf** file is a simple
means of achieving the redirect, replacing the string **sp-example.uni.edu.au** with the DNS name of the host. The
**shib.conf** file also contains the default **`<Location>`** directive which protects the secure directory with
Shibboleth.

    <VirtualHost *:80>
        ServerName sp-example.uni.edu.au:80
        RedirectMatch 301 (.*) https://sp-example.uni.edu.au$1
    </VirtualHost>

> Details on the configuration options for Apache are available here:
>
>  - [https://httpd.apache.org/docs/2.4/](https://httpd.apache.org/docs/2.4/)
>
>  - [https://httpd.apache.org/docs/current/sections.html](https://httpd.apache.org/docs/current/sections.html)
>
>  - [https://wiki.shibboleth.net/confluence/display/SP3/Apache](https://wiki.shibboleth.net/confluence/display/SP3/Apache)
>
>  - [https://wiki.shibboleth.net/confluence/display/SP3/WebServers](https://wiki.shibboleth.net/confluence/display/SP3/WebServers)
>
>  - [https://wiki.shibboleth.net/confluence/display/SP3/Clustering](https://wiki.shibboleth.net/confluence/display/SP3/Clustering)
>
>  - [https://wiki.shibboleth.net/confluence/display/SP3/OneOrMany](https://wiki.shibboleth.net/confluence/display/SP3/OneOrMany)


> Details on the configuration options for IIS are available here:
>
> - [https://wiki.shibboleth.net/confluence/display/SP3/IIS](https://wiki.shibboleth.net/confluence/display/SP3/IIS)