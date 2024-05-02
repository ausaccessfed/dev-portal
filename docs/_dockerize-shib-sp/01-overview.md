---
title: Overview
order: 1
duration: 1
---

This tutorial will guide you through how to create a simple application protected by Shibboleth. In contrast to the [previous SAML integration tutorial](http://127.0.0.1:4000/saml-integration/01-overview), you will be creating a Docker image for a Shibboleth Service Provider (SP) application and configuring it to run in a container. This may be useful if you are using a MacOS as opposed to a Windows or Linux machine.

### What you'll learn

- Create a Docker file for building a Docker image
- Use a base image for your Dockerfile
- Install and configure Shibboleth
- Install and configure Apache
- Build a Docker image based on the Dockerfile and run the container
- Test and deploy the dockerized SP
- How to integrate Shibboleth SP with a single page application

### What you'll need

- Docker container platform
- Knowledge running a container platform in a local development environment
