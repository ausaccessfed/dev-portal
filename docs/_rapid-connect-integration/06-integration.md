---
title: Integration
order: 6
duration: 1
---

Before you get started with AAF Rapid Connect, you MUST meet all the following high level requirements:

1. You must be using HTTPS on your webserver for all JWT related endpoints. You should be using HTTPS for your entire 
   application.
2. The organisation which owns the service you're registering must be an existing AAF subscriber.
3. You must have an existing account with an AAF connected Identity Provider which you use to access AAF services.

<br>

### 1. Select a JWT library

To get started with AAF Rapid Connect integration, select a suitable JWT library from the following table for your
application. These libraries will assist developers in quickly implementing JWT support. Libraries are not listed in
any particular order and not endorsed by us. You should evaluate them individually to determine which best suits
your needs. Found a useful JWT library not listed here? [Please let us know about it](mailto:support@aaf.edu.au?subject=New JWT library).

<table class="table">
   <thead>
      <tr>
         <th>Language</th>
         <th>Library</th>
         <th>Contributor</th>
      </tr>
   </thead>
   <tbody>
      <tr class="table-active">
         <td>Ruby</td>
         <td><a href="https://github.com/jbarona/omniauth-jwt/tree/flexible-options">Devise and OmniAuth</a></td>
         <td>James Barona from the South Australian Health and Medical Research Institute</td>
      </tr>
      <tr class="table-active">
         <td></td>
         <td><a href="https://gist.github.com/jbarona/7574703">Specific integration example in gist</a></td>
         <td></td>
      </tr>
      <tr class="table-active">
         <td></td>
         <td><a href="https://github.com/progrium/ruby-jwt">progrium ruby-jwt</a></td>
         <td></td>
      </tr>
      <tr>
         <td>Java</td>
         <td><a href="https://bitbucket.org/nimbusds/nimbus-jose-jwt/wiki/Home">nimbus-jose-jwt</a></td>
         <td></td>
      </tr>
      <tr>
         <td></td>
         <td><a href="https://code.google.com/p/jsontoken">Google Code Archive jsontoken</a></td>
         <td></td>
      </tr>
      <tr>
         <td></td>
         <td><a href="http://docs.oracle.com/cd/E23943_01/security.1111/e10037/jwt.htm#CIHFBCBG">Oracle jwt</a></td>
         <td></td>
      </tr>
      <tr class="table-active">
         <td>Python</td>
         <td><a href="https://github.com/magical/jwt-python">magical jwt-python</a></td>
         <td></td>
      </tr>
      <tr class="table-active">
         <td></td>
         <td><a href="https://github.com/progrium/pyjwt">progrium pyjwt</a></td>
         <td></td>
      </tr>
      <tr class="table-active">
         <td></td>
         <td><a href="https://pypi.python.org/pypi/ckanext-aaf?">Example authenticator for CKAN</a></td>
         <td>Louis Des Landes at Swinburne University of Technology</td>
      </tr>
      <tr>
         <td>PHP</td>
         <td><a href="https://github.com/cfrett/JWT-PHP">cfrett JWT-PHP</a></td>
         <td></td>
      </tr>
      <tr>
         <td></td>
         <td><a href="https://github.com/luciferous/jwt">luciferous jwt</a></td>
         <td></td>
      </tr>
      <tr class="table-active">
         <td>Node</td>
         <td><a href="https://github.com/hokaccha/node-jwt-simple">hokaccha node-jwt-simple</a></td>
         <td></td>
      </tr>
      <tr>
         <td>.Net</td>
         <td><a href="https://github.com/johnsheehan/jwt">johnsheehan jwt</a></td>
         <td></td>
      </tr>
      <tr>
         <td></td>
         <td><a href="https://nuget.org/packages/JWT">NuGet JWT</a></td>
         <td></td>
      </tr>
      <tr class="table-active">
         <td>Go</td>
         <td><a href="https://github.com/mendsley/gojwt">mendsley gojwt</a></td>
         <td></td>
      </tr>
      <tr>
         <td>Perl</td>
         <td><a href="https://github.com/spikelynch/Osiris/blob/master/Osiris/lib/Osiris/AAF.pm">Example Perl Code</a></td>
         <td>Michael Lynch from EResearch Support Group, Information Technology Division, University of Technology, Sydney</td>
      </tr>
      <tr class="table-active">
         <td>Haskell</td>
         <td><a href="https://hackage.haskell.org/package/jwt">Hackage jwt</a></td>
         <td></td>
      </tr>
      <tr class="table-active">
         <td></td>
         <td><a href="https://github.com/carlohamalainen/rapid-connect-yesod-demo">rapid-connect-yesod-demo</a></td>
         <td>Dr Carlo Hamalainen, Centre for Advanced Imaging, University of Queensland</td>
      </tr>
      <tr>
         <td>Dart</td>
         <td><a href="https://pub.dev/packages/aaf_rapid_connect">aaf_rapid_connect</a></td>
      </tr>
   </tbody>
</table>

<br>

### 2. Create a secret

The first step in integrating your code is to compute a secret that will be shared between your application and AAF Rapid Connect for signing and verifying JWT.

Recommended secret generation method on *nix hosts, 32 characters long:

`| LC_CTYPE=C tr -dc '[[:alnum:][:punct:]]' < /dev/urandom | head -c32 ;echo`

This value should never be publicly disclosed. Once created be sure to store it securely. This value will be required during service registration.

### 3. Provide a web accessible endpoint

Your application MUST define a https endpoint which accepts a HTTP POST request. The endpoint must acquire the data provided in the parameter **assertion** for further processing.

### 4. Validate the signed JWT (JWS) your application has received

Should any stage of the below validation fail your application MUST discard the token and present the user with a suitable error message.

1. Verify that the signature for the signed JWT you have received is valid by using your locally stored secret value
2. Ensure that the **iss** claim has the value https://rapid.aaf.edu.au when in the production environment, or
   https://rapid.test.aaf.edu.au when in the test environment.
3. Ensure that the **aud** claim has the value of your application's primary URL (provided as part of service
   registration).
4. The current time MUST be after or equal to the time provided in the **nbf** claim.
5. The current time MUST be before the time provided in the **exp** claim.
6. Ensure that the value of the **jti** claim does not exist in a local storage mechanism of **jti** claim values you
   have accepted. If it doesn't (this MUST be the case) add the **jti** claim value to your local storage mechanism for
   protection against replay attacks.

All applications connecting to the AAF must adhere to all relevant [AAF rules and policies](https://aaf.edu.au/support/resources/). Prior to approving the connection of your service to the federation, the AAF may request to review your JWT related code and test your running endpoint to verify that an application's JWT handling conforms to the above requirements.

### 5. Make use of the user's personal information

Your application now has a fully verified JWT provided by AAF Rapid Connect.

By looking at the claim **https://aaf.edu.au/attributes** you will be able to access information about the user
which most Research and Scholarly applications require. The following core AAF attributes should be available:

    1. cn
    2. mail
    3. displayname
    4. edupersontargetedid
    5. edupersonscopedaffiliation
    6. organizationname

The following optional AAF attributes MAY be available at the discretion of the user's Identity Provider:

    1. edupersonprincipalname: The "NetID" of the person for the purposes of inter-institutional authentication.
    2. givenname: A person's first name or preferred name
    3. surname: A person's surname
    4. edupersonorcid: A person's ORCID (https://orcid.org/) identifier, if they have provided one.

You may also be provided with the **auedupersonsharedtoken** attribute if your use case requires it. For more information on **auedupersonsharedtoken**, see this [support article](https://support.aaf.edu.au/support/solutions/articles/19000035966-why-is-auedupersonsharedtoken-no-longer-available-).

You can now use this data to create a local account suitable for internal use by your application, for customisation
and other purposes. It is RECOMMENDED that you use the data provided in either the JWT claim **sub** or the
https://aaf.edu.au/attributes claim's **edupersontargetedid** field to uniquely identify users.
{: .callout-info}

The JWT claim **sub** and the **https://aaf.edu.au/attributes** claim's **edupersontargetedid** field are always identical for Rapid Connect. The same value SHALL be provided for all subsequent visits to your application by each user. The full value of the field MUST be utilised to ensure your application uniquely identifies the remote user. Applications MUST NOT split this value based on the delimited bang segments.

The value of **sub/edupersontargetedid** is not able to correlate a user between services. For more details see
http://wiki.aaf.edu.au/tech-info/attributes/edupersontargetedid.