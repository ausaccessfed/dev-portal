#!/bin/bash
set -eu

title="${1:-}"
if [ -z "$title" ]; then
  echo 'Usage: make tutorial TITLE="Title of my new tutorial"' >&2
  exit 1
fi

RUBY_VERSION="$(cat docs/.ruby-version)" docker-compose run --rm --no-deps -T \
  --user "$(id -u):$(id -g)" jekyll ruby _rake/tutorial.rb "$title"
