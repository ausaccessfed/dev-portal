#!/bin/bash

cd "$(dirname "$0")/.." || exit

for file in docs/**/*.md; do
  last_modified=$(git log -1 --format="%ad" --date=format:"%d %B, %Y" "$file")
  if [ -n "$last_modified" ]; then
    current_last_updated=$(grep "^last_updated:" "$file" | sed 's/^last_updated: //')
    if [ "$current_last_updated" != "$last_modified" ]; then
      if grep -q "^last_updated:" "$file"; then
        sed -i '' "s/^last_updated:.*/last_updated: $last_modified/" "$file"
      else
        echo "last_updated: $last_modified" >> "$file"
      fi
      echo "Updated last_updated field in $file"
    else
      echo "No update needed for $file"
    fi
  else
    echo "No last modified date found for $file"
  fi
done