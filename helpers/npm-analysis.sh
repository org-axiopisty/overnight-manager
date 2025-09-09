# Analyze with npm context
{
  echo "=== GIT LOG ==="
  git log --since="60 days ago" --pretty=format:"%H|%an|%ae|%ad|%s" --date=iso
  echo -e "\n=== NPM INFO ==="
  npm info your-package --json
  echo -e "\n=== PACKAGE.JSON HISTORY ==="
  git log -p --since="60 days ago" -- package.json
} | fabric -p npm_release_detector
