---
title: Add tutorial content
order: 4
duration: 1
last_updated: 20 June, 2024
---

<br>

On the command line, the following rake task will set up the initial tutorial structure for you:

```
bundle exec rake tutorial "Title of your tutorial"
```

**This command will create:**

1. A new directory for hosting the markdown content.
  - The directory will be named after the title of your tutorial.

2. An initial overview page for your new tutorial.
  - The overview page will be named `01-overview.md`. Please include a summary of the tutorial content in this file as well as the following headings: "What you'll learn" (what the user will learn from your tutorial) and "What you'll need" (what prerequisites a user will require before starting your tutorial).
  - For additional pages, the naming convention will be `02-page-name.md`, `03-page-name.md`, and so on.
  - You may want to include a "Next Steps" page at the end of your tutorial, which will be named `06-next-steps.md`. This page will guide the user on what to do next after completing your tutorial.
  - Each page needs to have the following front matter:

    ```
    ---
    title: <page title>
    order: <number 1 to n for each page>
    duration: <estimated page duration>
    ---
    ```

3. An images directory specific to your new tutorial
  - located in `assets/images/<title of your tutorial>`.
  - This directory will store any images and diagrams you wish to include in your tutorial.

4. An index file
- This file will redirect to the first page of your tutorial. Please do not change this file.

5. A new entry at the bottom of the `_config.yml` file. 
  - You will need to edit the metadata for your new tutorial in this file. 
  - Add the following details to the new entry as shown below:

    ```
      your-tutorial-id:
        output: true # do not change
        permalink: /:collection/:name # do not change
        title: <your tutorial title> # in less than 10 words
        summary: <tutorial description> # in less than 10 words
        category: <choose one of Beginner, Intermediate, Advanced, Non-Technical or Curriculum>
        tags:
          - <keyword>
          - <keyword>
        difficulty: <number 1-5> # see below for difficulty levels
        duration: <number of minutes (in 5 minute intervals) your tutorial might take>
        status: <draft or published> # do not change
        published: YYYY-MM-DD # do not change
        author: Your Name <your email address>
    ```

<br>

Use the following difficulty levels to categorise your tutorial:

| Level | Tutorial Difficulty                  |
|-------|--------------------------------------|
| 1     | Beginner (basic knowledge)           |
| 2     | Beginner (limited experience)        |
| 3     | Intermediate (practical application) |
| 4     | Advanced (applied theory)            |
| 5     | Advanced (recognized authority)      |

After modifying the `config.yml` file, you will need to restart the preview process for Jekyll to render your new tutorial, but once it's done, it will be available from the `docs` folder of the site.

<br>

## Markdown style guide principles

On the tutorial site, there are a few styling basics to be aware of in Markdown/Liquid as shown below. For all other formatting and style guide principles, refer to the [Markdown style guide](https://guides.github.com/features/mastering-markdown/) or any other online markdown resources.

<br>

### Numbering lists

To create a numbered list for a series of steps, use 1. (number one) followed by a space for each of your numbered steps, and markdown will automatically convert these into a list as shown below:

1. 
1. 
1. 
1. 

<br>

### Highlighting important information

There are certain things we need to highlight to users, such as "Warnings" or "Notes". This can be done using callouts, of which there are different types producing slightly different formatting (colours, etc.) for each, depending on the type of message you want to highlight. Just place your text directly above the callout type.

```
{: .callout}
```
Note
{: .callout}

```
{: .callout-success}
```
Success
{: .callout-success}

```
{: .callout-danger}
```
Danger
{: .callout-danger}

```
{: .callout-warning }
```
Warning
{: .callout-warning }

```
{: .callout-info}
```
Info
{: .callout-info}

<br>

### Adding links and images

To add an internal link to a page, use the following syntax:

```
[Link text](/path-to-page)
```

For an external link, use the following syntax:

```
[Link text](https://www.example.com)
```

To add an image, use the following syntax:

```
![Alt text](/path-to-image)
```

<br>

### Preventing broken home page links

When adding any links for the tutorial site, which contain `tutorials.aaf.edu.au`, use **\{\{ site.baseurl \}\}** in its place instead.

For example `https://tutorials.aaf.edu.au/openid-connect-series/02-tutorials` will be:

>**\{\{ site.baseurl \}\}/openid-connect-series/02-tutorials**

This helps prevent any broken links in the future, if the central URL of the site changes.
