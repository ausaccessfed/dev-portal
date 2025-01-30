---
title: Getting Started
order: 1
duration: 1
---
<br>

### What is `kubelogin`?

`kubelogin` is a tool that allows you to authenticate with Kubernetes clusters using OIDC.

`kubectyl` is a command-line tool that allows you to interact with Kubernetes clusters. It is used to deploy
applications, inspect and manage cluster resources, and view logs.

`kubectyl` works with `kubelogin` to provide OIDC authentication for Kubernetes clusters.


Follow the steps below to set up OIDC via `kubelogin` for Kubernetes (K8s) cluster authentication.

### Prerequisites

- A Kubernetes (K8s) cluster (e.g. Docker Desktop, GKE, EKS, AKS, or [Minikube](https://minikube.sigs.k8s.io/docs/) in a development or test environment)

### Steps

1. Install `kubectl` by following the instructions in the [Kubernetes documentation](https://kubernetes.io/docs/tasks/tools/).
2. Install `kubelogin` by following the instructions in the [kubelogin GitHub repository](https://github.com/int128/kubelogin).
3. Set up your OIDC provider by following the instructions in the 
2. Configure `kubelogin` with OIDC by following the instructions in the [kubelogin GitHub repository](