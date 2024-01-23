---
layout: page
title: Integration
permalink: /rapidconnect/integration/
nav_order: 2
parent: Rapid Connect
grand_parent: Connection Types
---

# Integrating with AAF Rapid Connect
## Examples

### 1. **Code**
Refer to the following AAF developed example code which may assist your understanding when writing your own integration code:

- [Ruby](/rapidconnect_ruby/#ruby-example-of-aaf-jwt-code)
- [Python](/rapidconnect_python/#python-example-of-aaf-jwt-code)
- [PHP](/rapidconnect_php/#php-example-of-aaf-jwt-code)

### 2. **AAF Rapid Connect - Ruby Sample App**
For a more developed example, [refer to this Ruby sample application](https://github.com/ausaccessfed/rapidconnect-sample-ruby). It is provided purely for illustrative
purposes. It should be noted that the code presented here should not be used as a base to build your application, but is provided to give you an idea of the concepts behind connecting a service, so you can pick it apart (everybody’s requirements are different and just cutting and pasting the code won’t generally work if you decide to do that). No effort has been made to audit the code's security, or make it production-ready.

---
## 1. Select a JWT library

To get started with AAF Rapid Connect integration select a suitable JWT library from the following for your
application. These libraries will assist developers in quickly implementing JWT support. Libraries are not listed in
any particular order and not endorsed by us. You should evaluate them individually to determine which best suits
your needs. Found a useful JWT library not listed here? [Please let us know about it](mailto:support@aaf.edu.au?subject=New JWT library).

| Language | Library                                                                                        | Contributor                                                                                                   |
|----------|------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------|
| Ruby     | [Devise and OmniAuth](https://github.com/jbarona/omniauth-jwt/tree/flexible-options)           | James Barona from the South Australian Health and Medical Research Institute                                  |
|          | [Specific integration example in gist](https://gist.github.com/jbarona/7574703)                |                                                                                                               |
|          | [progrium ruby-jwt](https://github.com/progrium/ruby-jwt)                                      |                                                                                                               |
| Java     | [nimbus-jose-jwt](https://bitbucket.org/nimbusds/nimbus-jose-jwt/wiki/Home)                    |                                                                                                               |
|          | [Google Code Archive jsontoken](https://code.google.com/p/jsontoken)                           |                                                                                                               |
|          | [Oracle jwt](http://docs.oracle.com/cd/E23943_01/security.1111/e10037/jwt.htm#CIHFBCBG)        |                                                                                                               |
| Python   | [magical jwt-python](https://github.com/magical/jwt-python)                                    |                                                                                                               | 
|          | [progrium pyjwt](https://github.com/progrium/pyjwt)                                            |                                                                                                               |
|          | [Example authenticator for CKAN](https://pypi.python.org/pypi/ckanext-aaf?)                    | Louis Des Landes at Swinburne University of Technology                                                        |
| PHP      | [cfrett JWT-PHP](https://github.com/cfrett/JWT-PHP)                                            |                                                                                                               |
|          | [luciferous jwt](https://github.com/luciferous/jwt)                                            |                                                                                                               |
| Node     | [hokaccha node-jwt-simple](https://github.com/hokaccha/node-jwt-simple)                        |                                                                                                               |
| .Net     | [johnsheehan jwt](https://github.com/johnsheehan/jwt)                                          |                                                                                                               |
|          | [NuGet JWT](https://nuget.org/packages/JWT)                                                    |                                                                                                               |
| Go       | [mendsley gojwt](https://github.com/mendsley/gojwt)                                            |                                                                                                               |
| Perl     | [Example Perl Code](https://github.com/spikelynch/Osiris/blob/master/Osiris/lib/Osiris/AAF.pm) | Michael Lynch from EResearch Support Group, Information Technology Division, University of Technology, Sydney |
| Haskell  | [Hackage jwt](https://hackage.haskell.org/package/jwt)                                         |                                                                                                               |
|          | [rapid-connect-yesod-demo](https://github.com/carlohamalainen/rapid-connect-yesod-demo)        | Dr Carlo Hamalainen, Centre for Advanced Imaging, University of Queensland                                    |
| Dart     | [aaf_rapid_connect](https://pub.dev/packages/aaf_rapid_connect)                                |


### 2. Create a secret

The first step in integrating your code is to compute a secret that will be shared between your application and AAF Rapid Connect for signing and verifying JWT.

Recommended secret generation method on *nix hosts, 32 characters long:

`| LC_CTYPE=C tr -dc '[[:alnum:][:punct:]]' < /dev/urandom | head -c32 ;echo`

{: .warning }
This value should never be publicly disclosed. Once created be sure to store it securely. This value will be required during service registration.

### 3. Provide a web accessible endpoint

Your application MUST define a https endpoint which accepts a HTTP POST request.

The endpoint must acquire the data provided in the parameter **assertion** for further processing.

### 4. Validate the signed JWT (JWS) your application has received

Should any stage of the below validation fail, your application MUST discard the token and present the user with a suitable error message.

1. Verify that the signature for the signed JWT you have received is valid by using your locally stored secret value.
2. Ensure that the **iss** claim has the value `https://rapid.test.aaf.edu.au` when in the test environment.
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

By looking at the claim **https://aaf.edu.au/attributes** you will be able to access information about the user which most Research and Scholarly applications require. The following core AAF attributes SHOULD be available:

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

The JWT claim **sub** and the **https://aaf.edu.au/attributes** claim's **edupersontargetedid** field are always identical for Rapid Connect. The same value SHALL be provided for all subsequent visits to your application by each user. The full value of the field MUST be utilised to ensure your application uniquely identifies the remote user. Applications MUST NOT split this value based on the delimited bang segments.

The value of **sub/edupersontargetedid** is not able to correlate a user between services. For more details see
http://wiki.aaf.edu.au/tech-info/attributes/edupersontargetedid.

---

{: .next_steps }
Once you have completed the Rapid Connect configuration, you are ready to connect your service!
<br><br> Head over to [Connect a New Service](/new_service) and follow the steps to authenticate to Federation Manager (Test) after which you can [register your new Rapid Connect service](/new_service/rapidconnect_register).