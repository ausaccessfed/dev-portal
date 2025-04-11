#!/bin/bash

cd "$(git rev-parse --show-toplevel)" || exit

for file in docs/**/*.md; do
  echo "Processing file: $file"

  if ! git log --format="%H" -- "$file" &>/dev/null; then
    echo "No commits found for $file. Skipping."
    continue
  fi

  commits=$(git log --format="%H" -- "$file")

  last_modified=""
  for commit in $commits; do
    file_content=$(git show "$commit:$file" 2>/dev/null || echo "")

    if [ -n "$file_content" ] && ! echo "$file_content" | grep -q "^last_updated:"; then
      last_modified=$(git log -1 --format="%ad" --date=format:"%d %B, %Y" "$commit")
      break
    fi
  done

  if [ -z "$last_modified" ]; then
    last_modified=$(git log -1 --format="%ad" --date=format:"%d %B, %Y" -- "$file")
  fi

  if [ -n "$last_modified" ]; then
    echo "Last modified date for content: $last_modified"
    if grep -q "^last_updated:" "$file"; then
      sed -i '' "s/^last_updated:.*/last_updated: $last_modified/" "$file"
    else
      echo "last_updated: $last_modified" >> "$file"
    fi
    echo "Updated last_updated field in $file"
  else
    echo "No valid last modified date found for $file"
  fi
done