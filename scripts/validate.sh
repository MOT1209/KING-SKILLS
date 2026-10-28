#!/usr/bin/env bash
# king-SKILLS validator | مدقّق مستودع king-SKILLS
# Usage: scripts/validate.sh [--with-claude]
#   --with-claude  also run `claude plugin validate` (needs the Claude Code CLI)
set -u

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT" || exit 2
CATEGORIES=(writing productivity design engineering workflows)
errors=0 warns=0
err()  { echo "ERROR: $*"; errors=$((errors+1)); }
warn() { echo "WARN:  $*"; warns=$((warns+1)); }

AR_SECTIONS=("## متى تُستخدم" "## خطوات العمل" "## صيغة المخرجات" "## قواعد وحدود" "## حالات حدّية" "## مثال كامل")
EN_SECTIONS=("## When to use" "## Workflow" "## Output format" "## Rules and limits" "## Edge cases" "## Full example")

check_frontmatter() {  # file, expected-name
  local f="$1" name="$2"
  [ "$(sed -n 1p "$f")" = "---" ] || err "$f: line 1 must be ---"
  [ "$(sed -n 2p "$f")" = "name: $name" ] || err "$f: line 2 must be 'name: $name'"
  sed -n 3p "$f" | grep -q '^description: .\+' || err "$f: line 3 must start with 'description: '"
  [ "$(sed -n 4p "$f")" = "---" ] || err "$f: line 4 must be ---"
}

check_sections() {  # file, section...
  local f="$1"; shift
  local s
  for s in "$@"; do grep -qxF -- "$s" "$f" || err "$f: missing section '$s'"; done
}

check_frontmatter_loose() {  # file, expected-name (workflow packages)
  local f="$1" name="$2" close
  [ "$(sed -n 1p "$f")" = "---" ] || err "$f: line 1 must be ---"
  grep -q "^name: $name$" "$f" || err "$f: front matter must contain 'name: $name'"
  grep -q '^description:' "$f" || err "$f: front matter must contain 'description:'"
  close=$(grep -n '^---$' "$f" | sed -n 2p | cut -d: -f1)
  [ -n "$close" ] || err "$f: front matter must close with ---"
}

skills=()
declare -A seen
for cat in "${CATEGORIES[@]}"; do
  pj="$cat/.claude-plugin/plugin.json"
  if [ ! -s "$pj" ]; then err "$pj missing"; else
    grep -q "\"name\": \"king-$cat\"" "$pj" || err "$pj: name must be king-$cat"
    grep -q "\"source\": \"./$cat\"" .claude-plugin/marketplace.json 2>/dev/null || err "marketplace.json does not list ./$cat"
    grep -q "\"name\": \"king-$cat\"" .claude-plugin/marketplace.json 2>/dev/null || err "marketplace.json does not name king-$cat"
  fi
  [ -d "$cat/skills" ] || { err "$cat/skills missing"; continue; }
  for d in "$cat"/skills/*/; do
    n="$(basename "$d")"; skills+=("$cat/$n")
    [ -z "${seen[$n]:-}" ] || err "duplicate skill name '$n' ($cat and ${seen[$n]})"
    seen[$n]="$cat"
    if [ "$cat" = "workflows" ]; then
      for f in SKILL.md README.md; do [ -s "$d$f" ] || err "$d$f missing or empty"; done
      [ -s "${d}SKILL.md" ] || continue
      check_frontmatter_loose "${d}SKILL.md" "$n"
      [ -s "${d}README.md" ] && check_sections "${d}README.md" "## What the skill does" "## Example requests" "## What to expect"
      continue
    fi
    for f in SKILL.md README.md SKILL.en.md README.en.md; do [ -s "$d$f" ] || err "$d$f missing or empty"; done
    [ -s "${d}SKILL.md" ] || continue
    check_frontmatter "${d}SKILL.md" "$n"
    [ -s "${d}SKILL.en.md" ] && check_frontmatter "${d}SKILL.en.md" "$n"
    ar=$(wc -l < "${d}SKILL.md")
    { [ "$ar" -ge 60 ] && [ "$ar" -le 120 ]; } || err "${d}SKILL.md has $ar lines (must be 60-120)"
    check_sections "${d}SKILL.md" "${AR_SECTIONS[@]}"
    if [ -s "${d}SKILL.en.md" ]; then
      en=$(wc -l < "${d}SKILL.en.md")
      { [ "$en" -ge 60 ] && [ "$en" -le 125 ]; } || err "${d}SKILL.en.md has $en lines (must be 60-125)"
      check_sections "${d}SKILL.en.md" "${EN_SECTIONS[@]}"
      diff=$((en>ar ? en-ar : ar-en)); [ "$diff" -le 10 ] || warn "$n: Arabic/English length differ by $diff lines (translation drift?)"
    fi
    [ -s "${d}README.md" ] && check_sections "${d}README.md" "## ما الذي تفعله المهارة" "## أمثلة على الطلبات" "## ماذا تتوقع"
    [ -s "${d}README.en.md" ] && check_sections "${d}README.en.md" "## What the skill does" "## Example requests" "## What to expect"
  done
done
total=${#skills[@]}

# Root READMEs: every skill linked with the right path; badge count matches.
for pair in "README.md:README.md" "README.en.md:README.en.md"; do
  rf="${pair%%:*}"; suffix="${pair##*:}"
  [ -s "$rf" ] || { err "$rf missing"; continue; }
  for s in "${skills[@]}"; do
    cat="${s%%/*}"; n="${s#*/}"
    grep -qF "| \`$n\` |" "$rf" || err "$rf: skill '$n' not in a table"
    link="$cat/skills/$n/$suffix"
    [ "$cat" = "workflows" ] && link="$cat/skills/$n/README.md"
    grep -qF "]($link)" "$rf" || err "$rf: missing link to $link"
  done
  grep -q "skills-$total-" "$rf" || err "$rf: skills badge must say $total"
done

# Relative links in top-level docs resolve.
for doc in README.md README.en.md CONTRIBUTING.md; do
  [ -f "$doc" ] || { err "$doc missing"; continue; }
  while IFS= read -r link; do
    target="${link%%#*}"; [ -n "$target" ] || continue
    [ -e "$target" ] || err "$doc: broken link '$link'"
  done < <(grep -o ']([^)]*)' "$doc" | sed 's/^](//; s/)$//' | grep -v -E '^(https?:|mailto:)')
done

# Skill names referenced in "do not use" lines must exist.
while IFS= read -r ref; do
  [ -n "${seen[$ref]:-}" ] || err "unknown skill referenced in a 'do not use' line: $ref"
done < <(grep -h -E '^(لا تُستخدم عندما|Do not use when)' */skills/*/SKILL.md */skills/*/SKILL.en.md 2>/dev/null | grep -o '`[a-z0-9-]*`' | tr -d '`' | sort -u)

# JSON validity and leftovers.
if command -v python3 >/dev/null 2>&1; then
  for j in .claude-plugin/marketplace.json "${CATEGORIES[@]/%//.claude-plugin/plugin.json}"; do
    python3 -c 'import json,sys; json.load(open(sys.argv[1], encoding="utf-8"))' "$j" 2>/dev/null || err "$j is not valid JSON"
  done
else
  warn "python3 not found; skipped JSON validity checks"
fi
grep -rIl -E '^(<<<<<<<|>>>>>>>)' --include='*.md' . 2>/dev/null | grep -v '^./.git/' | while read -r f; do err "$f has merge-conflict markers"; done

# Installer sees every skill.
listed=$(scripts/install.sh --list 2>/dev/null | wc -l | tr -d ' ')
[ "$listed" = "$total" ] || err "install.sh --list shows $listed skills, expected $total"

if [ "${1:-}" = "--with-claude" ]; then
  if command -v claude >/dev/null 2>&1; then
    claude plugin validate . >/dev/null 2>&1 || err "claude plugin validate failed for the marketplace"
    for cat in "${CATEGORIES[@]}"; do claude plugin validate "./$cat" >/dev/null 2>&1 || err "claude plugin validate failed for ./$cat"; done
  else
    warn "claude CLI not found; skipped --with-claude"
  fi
fi

echo "skills: $total | errors: $errors | warnings: $warns"
[ "$errors" -eq 0 ]
