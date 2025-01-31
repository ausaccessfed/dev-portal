---
title: Install Kubelogin
order: 3
duration: 1
---

Install the latest `kubelogin` release by following the instructions in the [kubelogin GitHub repository](https://github.com/int128/kubelogin/blob/master/README.md).

### Set up OIDC provider

Set up your OIDC provider by following the instructions in the [Connect (OIDC) service](/connect-an-oidc-service/01-overview) tutorial.

### Configure `kubelogin` with OIDC

Add the issuer URL, client ID, and client secret from your new service to your `~/.kube/config` file.

![kubelogin oidc service](/assets/images/kubelogin-oidc-authentication/kubelogin-oidc.png)

Your `~/.kube/config` file should look similar to the following:

```shell
users:
  - name: oidc
    user:
      exec:
        apiVersion: client.authentication.k8s.io/v1
        command: kubectl
        args:
          - oidc-login
          - get-token
          - --oidc-issuer-url=ISSUER_URL
          - --oidc-client-id=YOUR_CLIENT_ID
          - --oidc-client-secret=YOUR_CLIENT_SECRET
```