---
title: Set up development environment
order: 2
duration: 1
---

The AAF Support Tutorials site is built with [Jekyll](https://jekyllrb.com/) and hosted on [GitHub Pages](https://pages.github.com/). To contribute to the content or create a new tutorial, we recommend that you set up a local development environment, so you can visualise and fine tune your work before you submit it for review.
<br>

### Checking out the code

Clone the repository of the documentation source code. This can be done using the Git command:

```shell
git clone git@github.com:ausaccessfed/dev-portal.git
```

<br>

### Setup for Windows users

1. First set up [Windows Subsystem for Linux (WSL)](https://docs.microsoft.com/en-us/windows/wsl/install). This will make the process much easier and allow you to use the commands below within the WSL environment.

2. **Install the Ruby packages** including Bundler, rake and the Ruby development package for building native extensions. For Ubuntu, this can be done with:
```shell
apt install ruby-dev ruby-bundler rake zlib1g-dev make gcc g++
```

3. **Navigate to the publishing source**: Change your working directory to the root of your Jekyll site (typically named `docs`):
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

3. **Navigate to the publishing source**: Change your working directory to the root of your Jekyll site (typically named `docs`):
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

