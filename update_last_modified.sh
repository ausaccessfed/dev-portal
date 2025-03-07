#!/opt/homebrew/bin/bash

find docs -name '*.md' -exec sh -c '
  for file; do
    if grep -q "^last_updated:" "$file"; then
      last_modified=$(git log -1 --format="%ad" --date=iso "$file")
      sed -i "" "s/^last_updated: .*/last_updated: $last_modified/" "$file"
      echo "Updated last_updated in $file"
    fi
  done
' sh {} +