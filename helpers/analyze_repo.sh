#!/bin/bash

# this can be saved with the pattern's prompts
# ~/.config/fabric/patterns/analyze_release_integrity/analyze_repo.sh

REPO_PATH="${1:-.}"
DAYS_BACK="${2:-90}"

if [[ ! -d "$REPO_PATH/.git" ]]; then
  echo "Error: Not a git repository or path doesn't exist"
  exit 1
fi

echo "Analyzing repository: $REPO_PATH"
echo "Looking back $DAYS_BACK days"
echo "="

cd "$REPO_PATH"

# Generate comprehensive git log and run it through our pattern
git log \
  --since="$DAYS_BACK days ago" \
  --pretty=format:"%H|%an|%ae|%ad|%s" \
  --date=iso \
  --all \
  --graph=false |
  fabric -p analyze_release_integrity
