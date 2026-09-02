#!/bin/bash

cd "$(git rev-parse --show-toplevel)" || exit

for file in docs/**/*.md; do
  echo "Processing file: $file"

  if ! git log --format="%H" -- "$file" &>/dev/null; then
    echo "No commits found for $file. Skipping."
    continue
  fi

  last_commit=$(git log -1 --format="%H" -- "$file")
  last_modified=$(git log -1 --format="%ad" --date=format:"%d %B, %Y" -- "$file")

  if grep -q "^last_updated:" "$file"; then
    changed_lines=$(git diff --unified=0 "${last_commit}^" "$last_commit" -- "$file" |
      grep -E '^[+-]' |
      grep -v -E '^(---|\+\+\+)' || true)
    if [[ -n "$changed_lines" ]] &&
      ! printf '%s\n' "$changed_lines" | grep -q -v '^[+-]last_updated: '; then
      echo "Latest change only updates last_updated for $file. Skipping."
      continue
    fi

    # Update the existing last_updated field
    sed -i.bak "s/^last_updated:.*/last_updated: $last_modified/" "$file"
     rm "$file.bak"
  else
    # Insert last_updated into YAML front matter (after ---)
    sed -i.bak "2i\\
last_updated: $last_modified
" "$file"
   rm "$file.bak"
  fi
  echo "Updated last_updated field in $file"
done
