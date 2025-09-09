---
title: overnight-manager
date: 2025-09-09
type: [ readme, incident ]
tags: [ npm, telemetry, monitoring, git, infosec, tools, workflow, sifting, detection ]
id: 20250909083141
---

# overnight-manager

A toolkit of patterns and helpers intended to be used to identify potentially tainted package releases.

**NOTE** this is a draft, I'm experimenting with some possible ways to spot behavioral anomalies that might be common across various types of software supply chain attacks. This is top of mind at the moment due to the ongoing discoveries of tainted packages from `npm` after a software developer was successfully phished

[Coverage from Brian Krebs](https://krebsonsecurity.com/2025/09/18-popular-code-packages-hacked-rigged-to-steal-crypto/) is why you're reading this document.

## Patterns 

- `analyze_release_integrity` 
- `npm_release_detector`
- `supply_chain_forensics`

## Usage Examples

### Basic Repository Analysis

```bash
# Analyze current repo for last 30 days
cd your-project
git log --since="30 days ago" --pretty=format:"%H|%an|%ae|%ad|%s" --date=iso | \
fabric -p analyze_release_integrity
```

### npm-specific Analysis

```bash
# Analyze with npm context
{
  echo "=== GIT LOG ==="
  git log --since="60 days ago" --pretty=format:"%H|%an|%ae|%ad|%s" --date=iso
  echo -e "\n=== NPM INFO ==="
  npm info your-package --json
  echo -e "\n=== PACKAGE.JSON HISTORY ==="
  git log -p --since="60 days ago" -- package.json
} | fabric -p npm_release_detector
```

### multi-source eventing

```bash
# Comprehensive analysis
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
```

## integration with my stack 

see `./helpers/npm-audit-enhanced.sh`


the helpers and their pattens are intended to provide:

1. **Behavioral Analysis** - detects unusual patterns even with legitimate credentials
2. **Historical Context** - identify when normal development patterns break
3. **Multi-Vector Detection** - assist in catching sophisticated attacks that use legitimate infrastructure
4. **Actionable Intelligence** - provides specific commits and commands for verification

i think the current npm attack could have been caught by this pattern because the malicious releases appeared without corresponding legitimate development activity in the git history. not a guarantee of course, but this is easy to implement and let an engineer eyeball and invesetigate what looks interesting to them.

i'd love to hear about any improvements. a good email address for me (also works for imessage) is emory at axiopisty dot org.
