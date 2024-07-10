---
title: Register Service
order: 2
duration: 1
---

If you have not done so already, please [log into Federation Manager](/log-into-federation-manager/01-overview) to get started.

Once you have clicked on 'OpenID Connect' on the ['Connect a New Service'](https://manager.test.aaf.edu.au/connected_services/new) page in Federation Manager, you will then be taken to the **Register a New Service** page:

![Register new service](/assets/images/connect-a-synthetic-oidc-service/register-oidc-service.png)

**To complete registration please provide the following information:**

<table border="1">
  <tbody>
    <tr>
        <td>Name</td>
        <td>A descriptive name for the service.</td>
    </tr>
    <tr>
        <td>Description</td>
        <td>A meaningful description to help users of this service understand its purpose.</td>
    </tr>
    <tr>
        <td>URL</td>
        <td>The primary URL of your application where users will initiate the authentication.</td>
    </tr>
    <tr>
        <td style="color: orangered;">Redirect URL</td>
        <td style="color: orangered;">The endpoint which will receive the OIDC responses from AAF. Additional redirect URIs can be added after 
registration via the client details page.
<br><br>In contrast to a standard service, a synthetic service requires the following redirect URLs:
<br><br><ul>
        <li>Synthetic service: <br><br>https://application.com/oidc_synthetic/callback</li><br><br>
        <li>Synthetic service + eduGAIN: <br><br>https://application.com/oidc_synthetic_edugain/callback</li>
      </ul>
        </td>
    </tr>    
    <tr>
      <td>Organisation</td>
      <td>Responsible for the operation of the service, must be an <strong>AAF</strong> subscriber.</td>
    </tr>
  </tbody>
</table>