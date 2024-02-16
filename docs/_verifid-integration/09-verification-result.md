---
title: Verification result
order: 9
duration: 1
---

This payload describes the result of Verification, and takes the following format:

```
{
  "user": {
    "identifier": "1CeCQp231k7...", 
    "student": true
  },
  "entity_id": "https://idp.example.com
/idp/shibboleth",
  "verification_id":
"kpClHkefsS1hK_wuU3ksdnE341Gh3SwxSRo_tD5L",
  "verification_timestamp": "2018-01-01T00:00:00Z"
} 
```

<br>

The fields in the Verification result shall be populated as follows:

<table class="table">
    <thead>
        <tr>
            <th style="width:30%">Field</th>
            <th>Definition</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>user.identifier</code></td>
            <td>An opaque identifier for this User, which shall be unique to the Client (i.e. the same user will have different identifiers at different Clients). It is recommended that the Client store this identifier if they wish to correlate this Verification with past or future Verifications by the same User. This value shall not be longer than 128 characters.</td>
        </tr>
        <tr>
            <td><code>user.&lt;affiliation&gt;</code></td>
            <td>A boolean value indicating whether the User has the given Affiliation. Only present if the 
<code>verify:&lt;affiliation&gt;</code> scope was granted. 
            <br> The Affiliation value is substituted for “<code>&lt;affiliation&gt;</code>”, from the following list 
    defined by the eduPerson schema(8):
            <ul>
                <li><code>faculty</code></li>
                <li><code>student</code></li>
                <li><code>staff</code></li>
                <li><code>employee</code></li>
                <li><code>member</code></li>
                <li><code>affiliate</code></li>
                <li><code>alum</code></li>
                <li><code>library-walk-in</code></li>
            </ul>
            e.g. When the <code>verify:staff</code> and <code>verify:student</code> scopes are granted, the 
Verification result will contain “<code>user.staff</code>” and “<code>user.student</code>” fields.
            </td>
        </tr>
        <tr>
            <td><code>entity_id</code></td>
            <td>The unique identifier of the originating IdP used for the verification. Note that this will only be present in the response if this functionality has been enabled for the Client. An additional surcharge may apply for this data.</td>
        </tr>
        <tr>
            <td><code>verification_id</code></td>
            <td>A unique identifier for this verification. It is recommended that the Client store this for auditing 
        purposes, alongside the original “<code>state</code>” provided in the Verification request. This value shall not be 
        longer than 128 characters.
            </td>
        </tr>
        <tr>
            <td><code>verification_timestamp</code></td>
            <td>A timestamp at which this verification was undertaken. This shall be formatted according to the W3 
            Consortium profile of ISO 8601, in the <code>YYYY-MM-DDThh:mm:ssTZD</code> format(9).
            </td>
        </tr>
    </tbody>
</table>