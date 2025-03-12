---
title: Configure the application
order: 10
duration: 1
last_updated: 10 March, 2025
---

The Shibboleth installation will create the **secure** directory in Apache’s **DocumentRoot** directory and protect
that directory with a **`<Location>`** directive in the **conf.d/shib.conf** file. Create a PHP file in the **secure** directory
and add the following PHP script to the file. This script is the Shibboleth protected application for this demonstration. The PHP script is not accessible without authentication and reports the Apache’s environment, including the attributes received by Shibboleth from the user agent.


    <?php echo date("h:i A, l jS \of F, Y.") ?> <br/>
    <?php echo $_SERVER['eppn']; ?> <br/>
    <?php echo $_SERVER['affiliation']; ?> <br/>
    <?php echo $_SERVER['persistent-id']; ?> <hr/>
    <?php foreach ($_SERVER as $key => $value) {
       print $key."=>".$value."<br>";} ?> <br/>