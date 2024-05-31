# AAF Support tutorials

This is the content that hosts the site https://tutorials.aaf.edu.au.
The site is built with [Jekyll](https://jekyllrb.com/) and hosted on [GitHub Pages](https://pages.github.com/).

## Contributing

We welcome contributions to our AAF tutorials. Please read [CONTRIBUTING.md](docs/CONTRIBUTING.md) for more information on how to contribute.

## Checking out the code

Clone the repository of the documentation source code using the Git command:

```sh
git@github.com:ausaccessfed/dev-portal.git
```

## Getting Started with Jekyll
***

[Jekyll](https://jekyllrb.com/) is a static site generator built as a Ruby gem. It requires Ruby and a Ruby version manager, such as [rbenv](https://github.com/rbenv/rbenv) or [chruby](https://github.com/postmodern/chruby), for installation. You can refer to the [Jekyll documentation](https://jekyllrb.com/docs/installation/macos/) for detailed installation instructions tailored to your operating system.

### Using Docker Compose
If you prefer a Docker-based setup, follow these steps:

1. **Build and run Docker Image**: Run the following command to build a new image of your Jekyll site:
    ```bash
    make up
    ```

2. **View Your Site**: Open your web browser and navigate to [http://localhost:4000](http://localhost:4000) to view your Jekyll site running locally.
   

3. **Remove the Docker Image**: To stop and remove the Docker image, use the following command:
    ```bash
    make down
    ```

By using Docker, you can ensure consistent environments across different platforms and simplify the setup process for your Jekyll site.

### Using Native OS
These instructions will guide you through setting up and running your Jekyll site on your local machine using native tools.

#### Quick Setup for macOS users

1. **Install rbenv**: If you haven't already, install [rbenv](https://github.com/rbenv/rbenv) using [Homebrew](https://brew.sh/):
    ```bash
    brew install rbenv
    ```

2. **Install Bundler**: Once rbenv is installed, proceed to install [Bundler](https://bundler.io/):
    ```bash
    gem install bundler
    ```

3. **Navigate to the publishing source**: Change your working directory to the root of your Jekyll site (named `docs`):
    ```bash
    cd path/to/your/docs
    ```

4. **Install Dependencies**: Use Bundler to install the required dependencies for your Jekyll site:
    ```bash
    bundle install
    ```

1. **Build**: To build your site locally, execute the following command:
    ```bash
    bundle exec jekyll serve
    ```

#### Setup for Windows and Linux users

1. For Windows users, first set up the [Windows Subsystem for Linux (WSL)](https://docs.microsoft.com/en-us/windows/wsl/install). This will make the process much easier and allow you to use the commands below within the WSL environment.

2. **Install the Ruby packages** including Bundler, rake and the Ruby development package for building native extensions. For Ubuntu, this can be done with:
```shell
apt install ruby-dev ruby-bundler rake zlib1g-dev make gcc g++
```

3. **Navigate to the publishing source**: Change your working directory to the root of your Jekyll site (named `docs`):
```shell
  cd path/to/your/docs
```

4. **Install Dependencies**: Install the required dependencies for your Jekyll site:
```shell
rake setup
```

5. **Build Your Site**: To build your site locally, execute the following command:
```shell
rake serve
```

#### Running the Site Locally

2. **Preview Your Site**: Once the build process completes, open your web browser and navigate to [http://localhost:4000](http://localhost:4000) to preview your Jekyll site.
