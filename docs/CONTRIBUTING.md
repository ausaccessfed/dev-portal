# Contributing

Thanks for contributing to our `dev-portal tutorials` repository.
Below are ways you can help make the dev-portal tutorials better.

The easiest way for you to help us is by **raising an issue**, which will require a GitHub account.
For amendments to the documentation, you will need to be familiar with general Git concepts and submit your changes to our Tech Team for review.
If you'd like to commit substantial changes or even whole **new tutorials**, you will be required to set up the preview environment.

## Raise an issue

The easiest way to help improve the dev-portal tutorials is by raising an issue in our repository at https://github.com/ausaccessfed/dev-portal/issues.

If you find an issues that needs to be resolved, please have a look through the [list of existing issues](https://github.com/ausaccessfed/dev-portal/issues) to see whether your issues hasn't already been reported.
If it has, or a closely related issues exists, please add your comments to the existing issue.

If your issue isn't already listed, then create a New Issue.
Provide details of your suggestion and include the tutorial name and page to which your suggestion applies.
One of our technical team will review your suggestion and resolve it if they can.
They may contact you if they need some more clarification.


## Making changes

If you would like to make a minor or substantial contribution, you'll need to ensure you have Git installed.



### Checking out the code

For minor or substantial edits, you will need to clone the repository of the documentation source code.
This can be done using the Git command:

```sh
git@github.com:ausaccessfed/dev-portal.git
```

You're now ready to make changes.


### Substantial edits and new tutorials

To contribute substantial edits or new tutorials, we recommend that you [set up a local development environment](#setting-up-a-local-development-environment), so you can visualise and fine tune your work before you submit it for review.
You'll need some of your `git` skills with this.

- Clone your fork to your local computer using `git clone`.
- Step through the setup routine ([below](#setting-up-a-local-development-environment)) to set up your computer for local previews of your edits.
- Make the edits using your favourite markdown editor.
- If you intend to add a whole new tutorial, use the instructions for [adding tutorials below](#adding-a-new-tutorial).
- Commit your changes to your branch.
- When you are happy with your edits or additions, commit and send your changes.

### Setting up a local development environment

Note for windows users, this process will be much easier if you set up [Windows Subsystem for Linux (WSL)](https://docs.microsoft.com/en-us/windows/wsl/install), then the commands below will work within the WSL environment.

Install the Ruby packages:

- bundler
- rake
  and you will also need the Ruby development package for building native extensions.

For Ubuntu, this can be done with:

```sh
# apt install ruby-dev ruby-bundler rake zlib1g-dev make gcc g++
```

To install Jekyll and all the required dependencies, run the below command. **But make sure you are in the folder which contains the repository first (ie the `dev-portal/docs` folder)**.

```sh
# rake setup
```
Then to serve the site, you can use:

```sh
# rake serve
```

### Adding a new tutorial

A rake task will set up a skeleton tutorial for you, by typing:

```sh
# rake tutorial "Title of my new tutorial"
```

This command will create you:

- A new directory for hosting the markdown content.
- An initial overview page for this new tutorial.
- An images directory specific to your new tutorial.
- A configuration entry in `_config.yml`.

You will then need to edit the metadata for your new tutorial in `_config.yml` under the `collections` section.

You'll need the following YAML config:

```yaml
  your-tutorial-id:
    output: true
    permalink: /:collection/:name
    title: <tutorial title>
    summary: <tutorial summary>
    category: <one of Beginner, Intermediate, Advanced, Non-Technical or Curriculum>
    tags:
      - <tag 1>
      - <tag n>
    difficulty: <number 1-5>
    duration: <number of minutes tutorial might take>
    status: <draft or published>
    published: <YYYY-MM-DD>
    author: <Your Name>
```

Then for the content of your tutorial, each page within your tutorial should
have the following front matter:

```yaml
---
title: <page title>
order: <number 1 to n for each page>
duration: <estimated page duration>
---
```

You will need to restart the preview process for Jekyll to render your new
tutorial, but once it's done, it will be available from the docs folder of the site.

### Markdown style guide principles

*On the tutorial site, there are a few styling basics to be aware of in Markdown/Liquid.*

**Numbering lists**

To enter a numbered list for a series of steps, use 1. (number one) for each of your numbered steps, and markdown will convert these into the number order:

1.
1.
1.
1.


**Highlighting important information**

There a certain things we need to highlight to users, such as "Warnings" or a "Note" of sorts. This can be done using callouts, which have different types producing slightly different formatting (colours, etc.) for each, 
depending on the type of message you want to highlight.

<code>
{: .callout-success}

{: .callout-danger}

{: .callout-default}

{: .callout-warning }

{: .callout-info}

{: .callout-primary}

</code>

<br>

**Preventing broken home page links**

When adding any links for the tutorial site, which contain tutorials.aaf.edu.au, use  {{ site.baseurl }} in its place instead.

For example https://tutorials.aaf.edu.au/openid-connect-series/02-tutorials will be:

{{ site.baseurl }}/openid-connect-series/02-tutorials

This helps prevent any broken links in the future, if the central URL of the site changes.