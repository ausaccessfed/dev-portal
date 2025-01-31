---
title: Background
order: 2
duration: 1
---
<br>

### What is `kubelogin`?

`kubelogin` is a tool that allows you to authenticate with Kubernetes clusters using OIDC. When you run a kubectl command, it will use `kubelogin` to obtain an OIDC token from the configured OIDC provider. This token is then used to authenticate with the Kubernetes API server.

![kubelogin](/assets/images/kubelogin-oidc-authentication/credential-plugin.png)

Figure 1. `kubelogin` OIDC authentication flow (adapted from https://github.com/int128/kubelogin/blob/master/docs/credential-plugin-diagram.svg)