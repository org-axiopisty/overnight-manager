#!/bin/bash
# comprehensive analysis
#

{
  echo "=== REPOSITORY: $(basename $(pwd)) ==="
  echo "=== GIT LOG ==="
  git log --since="90 days ago" --pretty=format:"%H|%an|%ae|%ad|%s" --date=iso
  echo -e "\n=== TAGS ==="
  git tag -l --sort=-version:refname | head -20
  echo -e "\n=== RECENT RELEASES ==="
  git log --grep="release\|version\|bump" --oneline --since="90 days ago"
  echo -e "\n=== PACKAGE.JSON CHANGES ==="
  git log -p --since="90 days ago" -- package.json | head -100
} | fabric -p supply_chain_forensics
