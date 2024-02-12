# Getting Started with Jekyll
***

[Jekyll](https://jekyllrb.com/) is a static site generator built as a Ruby gem. It requires Ruby and a Ruby version manager, such as [rbenv](https://github.com/rbenv/rbenv) or [chruby](https://github.com/postmodern/chruby), for installation. You can refer to the [Jekyll documentation](https://jekyllrb.com/docs/installation/macos/) for detailed installation instructions tailored to your operating system.

## Using Docker
If you prefer a Docker-based setup, follow these steps:

1. **Build the Docker Image**: Run the following command to build a new image of your Jekyll site:
    ```bash
    make build-image
    ```

2. **Run the Docker Container**: Once the image is built, you can run your site using Docker with the following command:
    ```bash
    make run-image
    ```

3. **View Your Site**: Open your web browser and navigate to [http://localhost:4000](http://localhost:4000) to view your Jekyll site running locally.

By using Docker, you can ensure consistent environments across different platforms and simplify the setup process for your Jekyll site.

## Using Native OS

### Quick Setup

1. **Install rbenv**: If you haven't already, install [rbenv](https://github.com/rbenv/rbenv) using [Homebrew](https://brew.sh/):
    ```bash
    brew install rbenv
    ```

2. **Install Bundler**: Once rbenv is installed, proceed to install [Bundler](https://bundler.io/):
    ```bash
    gem install bundler
    ```

3. **Navigate to the publishing source**: Change your working directory to the root of your Jekyll site (typically named `docs`):
    ```bash
    cd path/to/your/docs
    ```

4. **Install Dependencies**: Use Bundler to install the required dependencies for your Jekyll site:
    ```bash
    bundle install
    ```

### Running the Site Locally

1. **Build and Preview**: To build and preview your site locally, execute the following command:
    ```bash
    bundle exec jekyll serve
    ```

2. **Preview Your Site**: Once the build process completes, open your web browser and navigate to [http://localhost:4000](http://localhost:4000) to preview your Jekyll site.

These instructions will guide you through setting up and running your Jekyll site on your local machine using native tools.
