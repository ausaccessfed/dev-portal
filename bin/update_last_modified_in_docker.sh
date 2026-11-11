#!/bin/bash
set -eu

bundle_file=$(mktemp)
trap 'rm -f "$bundle_file"' EXIT
git bundle create "$bundle_file" HEAD

RUBY_VERSION="$(cat docs/.ruby-version)" docker-compose run --rm --no-deps -T \
  --user "$(id -u):$(id -g)" \
  --volume "$(pwd):/repo" \
  --volume "$bundle_file:/tmp/repo.bundle:ro" \
  --workdir /repo \
  jekyll sh -c 'git -c init.defaultBranch=main clone --bare --quiet /tmp/repo.bundle /tmp/repo.git && GIT_DIR=/tmp/repo.git GIT_WORK_TREE=/repo bash bin/update_last_modified.sh'
