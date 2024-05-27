---
title: Set up development environment
order: 2
duration: 1
---

The AAF Support Tutorials site is built with Jekyll and hosted on GitHub Pages. To contribute a new tutorial, we recommend that you set up a local development environment, so you can visualise and fine tune your work before you submit it for review.
You'll need some of your `git` skills to do this.

- Clone your fork to your local computer using `git clone`.
- Step through the setup routine ([below](#setting-up-a-local-development-environment)) to set up your computer for local previews of your edits.
- Make the edits using your favourite markdown editor.
- If you intend to add a whole new tutorial, use the instructions for [adding tutorials below](#adding-a-new-tutorial).
- Commit your changes to your branch.
- When you are happy with your edits or additions, commit and send your changes.

<br>

### Setup for Windows users

Note: this process will be much easier if you set up [Windows Subsystem for Linux (WSL)](https://docs.microsoft.com/en-us/windows/wsl/install), then the commands below will work within the WSL environment.

Install the Ruby packages including Bundler, rake and the Ruby development package for building native extensions.

For Ubuntu, this can be done with:

```sh
apt install ruby-dev ruby-bundler rake zlib1g-dev make gcc g++
```

To install Jekyll and all the required dependencies, run the below command. **But make sure you are in the folder which contains the repository first (ie the `dev-portal/docs` folder)**.

```sh
rake setup
```
Then to serve the site, you can use:

```sh
rake serve
```

<br>

### Setup for macOS users

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

<br>

### Running the Site Locally

1. **Build and Preview**: To build and preview your site locally, execute the following command:
    ```bash
    bundle exec jekyll serve
    ```

2. **Preview Your Site**: Once the build process completes, open your web browser and navigate to [http://localhost:4000](http://localhost:4000) to preview your Jekyll site.


