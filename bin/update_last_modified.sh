#!/bin/bash

cd "$(git rev-parse --show-toplevel)" || exit

for file in docs/**/*.md; do
  echo "Processing file: $file"

  if ! git log --format="%H" -- "$file" &>/dev/null; then
    echo "No commits found for $file. Skipping."
    continue
  fi

  last_modified=$(git log -1 --format="%ad" --date=format:"%d %B, %Y" -- "$file")

  if grep -q "^last_updated:" "$file"; then
    # Update the existing last_updated field
    sed -i '' "s/^last_updated:.*/last_updated: $last_modified/" "$file"
  else
    # Insert last_updated into YAML front matter (after ---)
    sed -i '' "2i\\
last_updated: $last_modified
" "$file"
  fi
  echo "Updated last_updated field in $file"
done
