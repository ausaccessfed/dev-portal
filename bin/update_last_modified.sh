#!/bin/bash

cd "$(git rev-parse --show-toplevel)" || exit

for file in docs/**/*.md; do
  commits=$(git log --format="%H" -- "$file")

  last_modified=""
  for commit in $commits; do
    file_content=$(git show "$commit:$file")

    if ! echo "$file_content" | grep -q "^last_updated:"; then
      last_modified=$(git log -1 --format="%ad" --date=format:"%d %B, %Y" "$commit")
      break
    fi
  done

  if [ -n "$last_modified" ]; then
    if grep -q "^last_updated:" "$file"; then
      sed -i '' "s/^last_updated:.*/last_updated: $last_modified/" "$file"
    else
      echo "last_updated: $last_modified" >> "$file"
    fi
    echo "Updated last_updated field in $file"
  else
    echo "No last modified date found for $file"
  fi
done