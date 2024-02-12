#!/bin/bash
set -e

# Check if Gemfile exists
if [ ! -f Gemfile ]; then
  echo "Gemfile Missing! Rebuild image?"
  exit 1
fi

# Check if gems need installation
if ! bundle check >/dev/null 2>&1; then
  echo "Installing gems..."
  bundle install --retry 5 --jobs 20
else
  echo "Gems already installed."
fi

# Execute the provided command
exec "$@"
