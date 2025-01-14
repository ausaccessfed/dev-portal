---
title: Get started
order: 2
duration: 3
---

* If you are using Keycloak for the first time, [please refer to their documentation](https://www.keycloak.org/documentation) to get started.
* Otherwise, if you are already using Keycloak on a container platform, log into the Keycloak admin console. In a local development environment, it is located at `http://localhost:8080/admin`.

![Keycloak Sign In Page](/assets/images/connect-with-keycloak/keycloak-signin-page.png)

* Once signed in, click on 'master' (at the top of the left hand menu bar).

![Keycloak Master Page](/assets/images/connect-with-keycloak/keycloak-master-realm-page.png)

### Create a new realm

* Create a new realm where you would like to add AAF as an identity provider and in which you will manage your users, applications, roles and groups. To do this, click 'Create Realm'.

![Master Realm Page](/assets/images/connect-with-keycloak/keycloak-create-realm.png)

* Select an appropriate `Realm name`. In this example, the new realm is called 'myrealm'.
* Click 'Create'.

![Create Realm Page](/assets/images/connect-with-keycloak/keycloak-create-realm-2.png)

* You will now see the new realm 'myrealm' in the left hand menu bar.

![New Realm Page](/assets/images/connect-with-keycloak/created-realm.png)

### Create a new user

* Within your new realm, click on 'Users' in the left hand menu bar.

![Users Link](/assets/images/connect-with-keycloak/navigate-to-users.png)