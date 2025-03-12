#!/bin/bash

for file in docs/**/*.md; do
  last_modified=$(git log -1 --format="%ad" --date=format:"%d %B, %Y" "$file")
  if [ -n "$last_modified" ]; then
    if grep -q "^last_updated:" "$file"; then
      sed -i '' "s/^last_updated:.*/last_updated: $last_modified/" "$file"
    else
      sed -i '' "/^last_updated:/ s/^last_updated:/last_updated: $last_modified/" "$file"
    fi
  else
    echo "No last modified date found for $file"
  fi
done