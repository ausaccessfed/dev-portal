---
title: Software Version
order: 2
duration: 1
last_updated: 10 March, 2025
---
<br>

## Latest version of software for eduGAIN services

<h3 class="text-warning">What software are you running?</h3>

There are a number of software implementations of the SAML service provider. Each will have its own website, development activities and update notification processes. You should be following the notifications for the software you are using to implement your SAML service providers to help ensure you are running the latest secure stable version at all times. The following table provides a short list of common software that has been used within the AAF.

<table class="table">
  <thead>
    <tr>
      <th scope="col">Software</th>
      <th scope="col">Source</th>
      <th scope="col">Download site</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Shibboleth</td>
      <td>https://shibboleth.atlassian.net/wiki/spaces/SP3/overview</td>
      <td>https://shibboleth.net/downloads/service-provider/latest/</td>
    </tr>
    <tr>
      <td>SimpleSAMLphp</td>
      <td>https://simplesamlphp.org/</td>
      <td>https://simplesamlphp.org/download/</td>
    </tr>
  </tbody>
</table>
<br>

<h3 class="text-warning">Which version are you running?</h3>

To determine the software or System Information/version you are currently running, use one of the following commands below.

Depending on your software version, these commands/keys may vary.
{: .callout-info}


#### Shibboleth SP

You can determine the overall version of the SP software you have installed by running shibd from the command line with the -v option (Linux/Unix only).

`shibd -v`


On Windows, use:

`shibd -version`

If the shibboleth SP isn't in your path and you get the `'unrecognised command'` error, you might have to browse to the folder, usually `c:\opt\shibboleth-sp\sbin`.


For any platform, you can determine the version of the SP and various libraries by examining log files during the
startup sequence or, if you have sufficient access, by using the <a href="https://shibboleth.atlassian.net/wiki/spaces/SP3/pages/2065334870/Status+Handler">status handler</a>.


#### SimpleSAMLphp

To determine the version you are currently running:


SimpleSAML_Configuration-class:

```shell
require_once('.../lib/_autoload.php');

$cfg = SimpleSAML_Configuration::loadFromArray(array());

echo $cfg->getVersion();
```

Output can be something like:

`1.14.14`

<br>

<h3 class="text-warning">Upgrading software</h3>

Consult the software website for information on its upgrade process. Upgrading the Shibboleth SP software is straightforward as it is pre-packaged for different Linux variants.


Upgrade the version in the AAF Test Federation before upgrading the Production version. All upgrades should align with existing organisational change management processes.
{: .callout-info }

<h3 class="text-warning">Keep the OS and supporting software up to date</h3>

The SAML Service does not run in isolation and depends on the Operating System, the Web Server, the cryptography software and several other software components. Each of these is specific to an environment and each component will have a maintenance process. Ensure that these supporting components are regularly patched and upgraded.
{: .callout-info }