# Contributing

Thanks for contributing to our `dev-portal tutorials` repository.
Below are ways you can help make the dev-portal tutorials better.

The easiest way for you to help us is by **raising an issue**, which will require a [GitHub account](https://github.com).
For amendments to the documentation, you will need to be familiar with general Git concepts and submit your changes to our Tech Team for review.
If you'd like to commit substantial changes or even whole **new tutorials**, you will be required to set up a local development environment.

## Raise an issue

The easiest way to help improve the dev-portal tutorials is by raising an issue in our repository at https://github.com/ausaccessfed/dev-portal/issues.

If you find an issue that needs to be resolved, please have a look through the [list of existing issues](https://github.com/ausaccessfed/dev-portal/issues) to see whether your issue hasn't already been reported.
If it has, or a closely related issue exists, please add your comments to the existing issue.

If your issue isn't already listed, then create a New Issue.
Provide details of your suggestion and include the tutorial name and page to which your suggestion applies, as well as your email address.
One of our technical team will review your suggestion and resolve it if they can.
They may contact you if they need some more clarification.


## Making substantial changes and adding new tutorials

To contribute substantial changes or new tutorials, we recommend that you set up a local development environment, so you can visualise and fine tune your work before you submit it for review.
You'll need a basic understanding of `git` to do this. Please refer to the `README.md` file for more information on how to get started.

- Step through the setup routine to set up your computer for local previews of your edits.
- Make the edits using your favourite markdown editor.
- If you intend to add a whole new tutorial, use the instructions for [adding tutorials below](#adding-a-new-tutorial).
- Commit your changes to your branch.
- When you are happy with your edits or additions, commit and send your changes.
- Push your commits to your remote branch `git push -u origin <your-branch-name>`.
- Navigate to the [Dev Portal GitHub repository](https://github.com/ausaccessfed/dev-portal) where you will be prompted to create a pull request (PR).

### Adding a new tutorial

A rake task will set up a skeleton tutorial for you, by typing:

```sh
rake tutorial "Title of my new tutorial"
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
    author: <Your Name> <your email address>
```

Then for the content of your tutorial, each page within your tutorial should have the following front matter:

```yaml
---
title: <page title>
order: <number 1 to n for each page>
duration: <estimated page duration>
---
```

You will need to restart the preview process for Jekyll to render your new tutorial, but once it's done, it will be available from the `docs` folder of the site.

### Markdown style guide principles

On the tutorial site, there are a few styling basics to be aware of in Markdown/Liquid.

**Numbering lists**

To enter a numbered list for a series of steps, use 1. (number one) for each of your numbered steps, and markdown will convert these into the number order:

1.
1.
1.
1.


**Highlighting important information**

Important information can be highlighted for users through the use of callouts. There are different types of callouts available producing slightly different formatting (e.g. colours, etc.), depending on the type of message you want to highlight.

```markdown
{: .callout-success}

{: .callout-danger}

{: .callout-default}

{: .callout-warning}

{: .callout-info}

{: .callout-primary}
```

<br>

**Preventing broken home page links**

When adding any links for the tutorial site, which contain tutorials.aaf.edu.au, use  {{ site.baseurl }} in its place instead.

For example https://tutorials.aaf.edu.au/openid-connect-series/02-tutorials will be:

{{ site.baseurl }}/openid-connect-series/02-tutorials

This helps prevent any broken links in the future, if the central URL of the site changes.