---
title: Add tutorial content
order: 4
duration: 1
---

On the command line, the following rake task will set up the initial tutorial structure for you:

```shell
bundle exec rake tutorial "Title of your tutorial"
```

This command will create:

- A new directory for hosting the markdown content.
- An initial overview page for your new tutorial.
- An images directory specific to your new tutorial (located in `assets/images/<title of your tutorial>`).
- A configuration entry in `_config.yml`.

You will then need to edit the metadata for your new tutorial in `_config.yml` under the `collections` section.

Add the following details to the YAML config:

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
    duration: <number of minutes your tutorial might take>
    status: <draft or published>
    published: YYYY-MM-DD
    author: <Your Name>
```


Each page (i.e. file) of the tutorial needs to be in Markdown format (`<name-of-page>`.md) and have the following front matter:

```yaml
---
title: <page title>
order: <number 1 to n for each page>
duration: <estimated page duration>
---
```

You will need to restart the preview process for Jekyll to render your new tutorial, but once it's done, it will be available from the `docs` folder of the site.

<br>

## Markdown style guide principles

On the tutorial site, there are a few styling basics to be aware of in Markdown/Liquid as shown below. For all other formatting and style guide principles, refer to the [Markdown style guide](https://guides.github.com/features/mastering-markdown/) or any other online markdown resources.

#### Numbering lists

To create a numbered list for a series of steps, use 1. (number one) followed by a space for each of your numbered steps, and markdown will automatically convert these into a list as shown below:

1. 
1. 
1. 
1. 

<br>

#### Highlighting important information

There are certain things we need to highlight to users, such as "Warnings" or "Notes". This can be done using callouts, which have different types producing slightly different formatting (colours, etc.) for each, depending on the type of message you want to highlight. Just place your text directly above the callout type.

```shell
{: .callout}
```
Note
{: .callout}

```shell
{: .callout-success}
```
Success
{: .callout-success}

```shell
{: .callout-danger}
```
Danger
{: .callout-danger}

```shell
{: .callout-warning }
```
Warning
{: .callout-warning }

```shell
{: .callout-info}
```
Info
{: .callout-info}

<br>

#### Preventing broken home page links

When adding any links for the tutorial site, which contain `tutorials.aaf.edu.au`, use **\{\{ site.baseurl \}\}** in its place instead.

For example `https://tutorials.aaf.edu.au/openid-connect-series/02-tutorials` will be:

>**\{\{ site.baseurl \}\}/openid-connect-series/02-tutorials**

This helps prevent any broken links in the future, if the central URL of the site changes.
