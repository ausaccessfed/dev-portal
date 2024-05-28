---
title: Set up development environment
order: 3
duration: 1
---

To contribute to the content or create a new tutorial, we recommend that you set up a local development environment, so you can visualise and fine tune your work before you submit it for review.
<br>

### Checking out the code
The AAF Support Tutorials site is built with [Jekyll](https://jekyllrb.com/) and hosted on [GitHub Pages](https://pages.github.com/). The source code for the site is hosted in the [AAF dev portal repository](https://github.com/ausaccessfed/dev-portal).
Clone the repository of the documentation source code. This can be done using the Git command:

```shell
git clone git@github.com:ausaccessfed/dev-portal.git
```

<br>

### Setup for Windows and Linux users

1. For Windows users, first set up the [Windows Subsystem for Linux (WSL)](https://docs.microsoft.com/en-us/windows/wsl/install). This will make the process much easier and allow you to use the commands below within the WSL environment.

2. **Install the Ruby packages** including Bundler, rake and the Ruby development package for building native extensions. For Ubuntu, this can be done with:
```shell
apt install ruby-dev ruby-bundler rake zlib1g-dev make gcc g++
```

3. **Navigate to the publishing source**: Change your working directory to the root of your Jekyll site (named `docs`):
```shell
  cd path/to/your/docs
```

4. **Install Dependencies**: Use [Bundler](https://bundler.io/) to install the required dependencies for your Jekyll site:
```shell
rake setup
```

5. **Build Your Site**: To build your site locally, execute the following command:
```shell
rake serve
```

6. **Preview Your Site**: Once the build process completes, open your web browser and navigate to [http://localhost:4000](http://localhost:4000) to preview your Jekyll site.

<br>

### Setup for macOS users

1. **Install rbenv** using [Homebrew](https://brew.sh/):
    ```shell
    brew install rbenv
    ```

2. **Install Bundler**: Once rbenv is installed, proceed to install [Bundler](https://bundler.io/):
    ```shell
    gem install bundler
    ```

3. **Navigate to the publishing source**: Change your working directory to the root of your Jekyll site (named `docs`):
    ```shell
    cd path/to/your/docs
    ```

4. **Install Dependencies**: Use Bundler to install the required dependencies for your Jekyll site:
    ```shell
    bundle install
    ```

5. **Build Your Site**: To build your site locally, execute the following command:
    ```shell
    bundle exec jekyll serve
    ```

6. **Preview Your Site**: Once the build process completes, open your web browser and navigate to [http://localhost:4000](http://localhost:4000) to preview your Jekyll site.

<br>

### Using Docker Compose
If you prefer a Docker-based setup, follow these steps (ensure you are in the root of your Jekyll site):

1. **Build and run Docker Image**: Run the following command to build a new image of your Jekyll site:
    ```bash
    make up
    ```

3. **View Your Site**: Open your web browser and navigate to [http://localhost:4000](http://localhost:4000) to view your Jekyll site running locally.


2. **Remove the Docker Image**: Once the image is built, you can stop and remove the image with the following command:
    ```bash
    make down
    ```

By using Docker, you can ensure consistent environments across different platforms and simplify the setup process for your Jekyll site.
