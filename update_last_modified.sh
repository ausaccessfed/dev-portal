#!/opt/homebrew/bin/bash

find docs -name '*.md' -exec sh -c '
  for file; do
    last_modified=$(git log -1 --format="%ad" --date=iso "$file")
    sed -i "" "s/^last_updated: .*/last_updated: $last_modified/" "$file"
  done
' sh {} +