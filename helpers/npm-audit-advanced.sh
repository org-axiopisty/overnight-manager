#!/bin/bash
# enhanced npm audit using fabric patterns

REPO_PATH="${1:-.}"
OUT_DIR="${HOME}/security-reports/$(date +%Y%m%d-%H%M%S)"

mkdir -p "$OUT_DIR"

# Run traditional audit
npm audit --json >"$OUT_DIR/npm-audit.json"

# Run fabric analysis
cd "$REPO_PATH"
git log --since="90 days ago" --pretty=format:"%H|%an|%ae|%ad|%s" --date=iso |
  fabric -p analyze_release_integrity >"$OUT_DIR/release-integrity.md"

echo "Analysis complete. Reports in: $OUT_DIR"
