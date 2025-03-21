---
title: Tutorials
order: 2
duration: 1
last_updated: 01 March, 2024
---

{% include tutorials.html -%}

{% assign curriculum = "OpenID Connect" %}

{% comment %}
To facilitate proper ordering of tutorials for openid connect series pages, we loop through our ordered list of categories and build the list of tutorials from there
{% endcomment -%}

{% assign sortcategories = "" | split: "" %}

{% comment %}
Add categories used by tutorials with the assigned curriculum in the order
specified in the site config
{% endcomment %}
{% for category in site.tutorial_categories %}
{% for tutorial in tutorials %}
{% if tutorial.curriculum == curriculum and tutorial.category == category %}
{% unless sortcategories contains category %}
{% assign sortcategories = sortcategories | push: category %}
{% endunless %}
{% endif %}
{% endfor %}
{% endfor %}

{% comment %}
Add any missing categories to the end of the list
{% endcomment %}
{% for tutorial in tutorials %}
{% if tutorial.curriculum == curriculum %}
{% unless sortcategories contains tutorial.category %}
{% assign sortcategories = sortcategories | push: category %}
{% endunless %}
{% endif %}
{% endfor %}

{% comment %}
Page content starts here
{% endcomment %}
The OpenID Connect Series consists of the following tutorials, which you can work through at your own pace.

{% for category in sortcategories %}
### {{ category }}
{% for tutorial in tutorials reversed %}
{% if tutorial.curriculum == curriculum and tutorial.category == category %}
<div id="{{ tutorial.label }}" class="series-tutorial" markdown="1">
##### [{{ tutorial.title }}]({{ tutorial.label | relative_url }})
{{ tutorial.summary }}  
<small>Duration: {{ tutorial.duration }} minutes</small>
</div>
{% endif %}
{% endfor %}
{% endfor %}
