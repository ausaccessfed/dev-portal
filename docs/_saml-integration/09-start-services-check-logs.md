---
title: Start services and check logs
order: 9
duration: 1
last_updated: 10 March, 2025
---

Using the system tools, start or restart the Apache and Shibboleth services. For Linux these are: httpd and shibd.

The shibd service creates its own logs in **/var/log/shibboleth**. These are the most important logs for debugging
anything regarding the **SP** and most problems manifest here rather than in the web server logs.

> [Read details on the available configurable options](https://wiki.shibboleth.net/confluence/display/SP3/Logging).

To check the services are active, use the following command to retrieve the Shibboleth service status from the host’s console.

    `$> curl https://localhost/Shibboleth.sso/Status --insecure`

If the Shibboleth and Apache services start correctly, the web server will respond with a Status Handler report
containing the current time (GMT) and the operational status of the **SP** instance. The `<Status Handler>` is only
accessible from a remote client by updating the **shibboleth2.xml** file and adding the client IP address to the
**ACL** parameter within the **`<Handler type=”Status”>`** located within the <Sessions> element. The ACL is
restrictive by default since the SP can reveal sensitive information about the host and software
versions in use.

> [Read details on the available configurable options](https://shibboleth.atlassian.net/wiki/spaces/SP3/pages/2065334870/Status+Handler)