---
title: Add a new tutorial
order: 3
duration: 1
---

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
