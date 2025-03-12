---
title: Client registration
order: 4
duration: 1
last_updated: 10 March, 2025
---

When a Client registers with VerifID, the Client shall be registered with the following details:

<table class="table">
  <thead>
    <tr>
      <th style="width:20%">Parameter</th>
      <th>Definition</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>client_id</code></td>
      <td>The unique Client identifier, which shall be assigned by VerifID. The value shall not be longer than 128 characters.</td>
    </tr>
    <tr>
      <td><code>secret</code></td>
      <td>The secure Client secret, which shall be assigned by VerifID. The value shall not be longer than 128 characters. The Client must protect this secret to ensure it is not disclosed.</td>
    </tr>
    <tr>
      <td><code>redirect_uris</code></td>
      <td>A list of all values permitted for the redirect_uri parameter in the Verification request. Each value must 
not be longer than 255 characters. Each <code>redirect_uri</code> value must be a <code>https://</code> endpoint, 
with plaintext <code>http://</code> endpoints explicitly disallowed in all environments.</td>
    </tr>
  </tbody>
</table>

Please refer to [Connecting with VerifID](/connect-with-verifid/02-connect-verifid-service) for details on how to securely undertake Client registration.

