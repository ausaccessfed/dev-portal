#!/opt/homebrew/bin/bash

for file in docs/**/*.md; do
  echo "Processing file: $file"
  last_modified=$(git log -1 --format="%ad" --date=format:"%B %d, %Y" "$file")
  echo "Last modified date: $last_modified"
  if [ -n "$last_modified" ]; then
    if grep -q "^last_updated:" "$file"; then
      sed -i '' "s/^last_updated:.*/last_updated: $last_modified/" "$file"
    else
      sed -i '' "/^last_updated:/ s/^last_updated:/last_updated: $last_modified/" "$file"
    fi
    echo "Updated last_updated field in $file"
  else
    echo "No last modified date found for $file"
  fi
done