---
title: Add service endpoints
order: 5
duration: 1
---

To configure the service endpoints, click on the 'dot points' icon in the 'Edit' column of the 'OAuth 2 Service' row.

![Configure Endpoints](/assets/images/set-up-moodle-via-aaf-authn/configure-endpoints.png)

Next, click on 'Create new endpoint for issuer "Your Service"'.

![Create New Endpoint](/assets/images/set-up-moodle-via-aaf-authn/create-endpoint.png)

Fill in the required fields for the new endpoint: `Name` and `URL`.

![Add Endpoint Fields](/assets/images/set-up-moodle-via-aaf-authn/add-endpoint-fields.png)

Three endpoints are required for your new service: `Authorization`, `Token`, and `User Info`.
{: .callout-info}

Ensure that the `name` of each endpoint ends with `_endpoint`.
{: .callout-info}

* Enter the endpoints and URLs below:

<table class="table">
  <thead>
    <tr>
      <th scope="col">Endpoint</th>
      <th scope="col">URL</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>authorization_endpoint</th>
      <td>https://central.test.aaf.edu.au/oidc/authorize</td>
    </tr>
    <tr>
      <th>token_endpoint</th>
      <td>https://central.test.aaf.edu.au/oidc/token</td>
    </tr>
    <tr>
      <th>userinfo_endpoint</th>
      <td>https://central.test.aaf.edu.au/oidc/userinfo</td>
    </tr>
  </tbody>
</table>

![All Endpoint URLs](/assets/images/set-up-moodle-via-aaf-authn/all-endpoints.png)