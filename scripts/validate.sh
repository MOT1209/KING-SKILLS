#!/usr/bin/env bash
# king-SKILLS validator | مدقّق مستودع king-SKILLS
# Usage: scripts/validate.sh [--with-claude]
#   --with-claude  also run `claude plugin validate` (needs the Claude Code CLI)
# Exit status: 0 when no errors were found (warnings allowed), 1 otherwise.
set -u
if [ "${BASH_VERSINFO[0]:-0}" -lt 4 ]; then
  echo "ERROR: scripts/validate.sh needs bash 4 or newer (found ${BASH_VERSION:-unknown}); on macOS install it with Homebrew." >&2
  exit 2
fi

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT" || exit 2
CATEGORIES=(writing productivity design engineering workflows)
DESC_LIMIT=1536   # Claude Code truncates description + when_to_use beyond this in the skill listing
errors=0 warns=0
err()  { echo "ERROR: $*"; errors=$((errors+1)); }
warn() { echo "WARN:  $*"; warns=$((warns+1)); }

AR_SECTIONS=("## متى تُستخدم" "## خطوات العمل" "## صيغة المخرجات" "## قواعد وحدود" "## حالات حدّية" "## مثال كامل")
EN_SECTIONS=("## When to use" "## Workflow" "## Output format" "## Rules and limits" "## Edge cases" "## Full example")

# Print a Markdown file without fenced code blocks, so headings and links that
# only appear inside examples are not counted.
strip_fences() { awk '/^[[:space:]]*(```|~~~)/ { f = !f; next } !f' "$1"; }

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
  for s in "$@"; do strip_fences "$f" | grep -qxF -- "$s" || err "$f: missing section '$s' (outside code blocks)"; done
}

check_frontmatter_loose() {  # file, expected-name (workflow packages)
  local f="$1" name="$2" fm
  [ "$(sed -n 1p "$f")" = "---" ] || { err "$f: line 1 must be ---"; return; }
  fm="$(awk 'NR == 1 { next } $0 == "---" { print "__END__"; exit } { print }' "$f")"
  case "$fm" in *__END__) ;; *) err "$f: front matter must close with ---"; return ;; esac
  printf '%s\n' "$fm" | grep -qE "^name: *[\"']?${name}[\"']? *$" || err "$f: front matter must contain 'name: $name'"
  printf '%s\n' "$fm" | grep -qE '^description: *[^ ]' || err "$f: front matter must contain a non-empty 'description:'"
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
    [ -d "$d" ] || continue
    n="$(basename "$d")"; skills+=("$cat/$n")
    [[ "$n" =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]] || err "$d: skill folder name must use lowercase letters, digits and single hyphens"
    [ -L "${d%/}" ] && err "${d%/}: skill folders must not be symbolic links"
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

# SKILL.md files outside <category>/skills/<name>/ are never installed or loaded:
# they are stray copies or a missing category.
cat_re="$(IFS='|'; echo "${CATEGORIES[*]}")"
while IFS= read -r f; do
  err "$f: SKILL.md outside <category>/skills/<name>/ (stray copy or unregistered category)"
done < <(find . -name .git -prune -o -name SKILL.md -print | grep -vE "^\./(_template|($cat_re)/skills/[^/]+)/SKILL\.md$")

# Both scripts must agree on the category list.
[ "$(grep -m1 '^CATEGORIES=' scripts/install.sh)" = "$(grep -m1 '^CATEGORIES=' scripts/validate.sh)" ] \
  || err "CATEGORIES differs between scripts/install.sh and scripts/validate.sh"

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

# Relative links in user-facing docs resolve (links inside code blocks are ignored).
docs=(README.md README.en.md CONTRIBUTING.md AGENTS.md CLAUDE.md workflows/README.md)
for d in "${CATEGORIES[@]/%//skills}"; do
  [ -d "$d" ] || continue
  while IFS= read -r f; do docs+=("$f"); done < <(find "$d" -mindepth 2 -maxdepth 2 \( -name 'README*.md' -o -name 'SKILL*.md' \) | sort)
done
for doc in "${docs[@]}"; do
  [ -f "$doc" ] || { err "$doc missing"; continue; }
  base="$(dirname "$doc")"
  while IFS= read -r link; do
    target="${link%%#*}"; target="${target#<}"; target="${target%>}"
    [ -n "$target" ] || continue
    [ -e "$base/$target" ] || err "$doc: broken link '$link'"
  done < <(strip_fences "$doc" | sed 's/`[^`]*`//g' | grep -o '](\([^)]*\))' | sed 's/^](//; s/)$//; s/ .*//' | grep -v -E '^(https?:|mailto:|#)')
done

# Skill names referenced in "do not use" lines must exist.
while IFS= read -r ref; do
  [ -n "${seen[$ref]:-}" ] || err "unknown skill referenced in a 'do not use' line: $ref"
done < <(grep -h -E '^(لا تُستخدم عندما|Do not use when)' */skills/*/SKILL.md */skills/*/SKILL.en.md */skills/*/README*.md 2>/dev/null | grep -o '`[a-z0-9-]*`' | tr -d '`' | sort -u)

# Structured checks: JSON syntax, marketplace/plugin consistency, description length.
if command -v python3 >/dev/null 2>&1; then
  while IFS= read -r line; do
    case "$line" in
      ERROR:*) err "${line#ERROR: }" ;;
      WARN:*) warn "${line#WARN: }" ;;
      *) err "unexpected checker output: $line" ;;
    esac
  done < <(python3 - "$DESC_LIMIT" "${CATEGORIES[@]}" <<'PY' 2>&1
import glob, json, os, re, sys

limit = int(sys.argv[1])
cats = sys.argv[2:]

def load(path):
    try:
        with open(path, encoding="utf-8") as fh:
            return json.load(fh)
    except FileNotFoundError:
        print(f"ERROR: {path} missing")
    except (ValueError, UnicodeDecodeError) as exc:
        print(f"ERROR: {path} is not valid JSON ({exc})")
    return None

market = load(".claude-plugin/marketplace.json")
if isinstance(market, dict):
    if market.get("name") != "king-skills":
        print("ERROR: .claude-plugin/marketplace.json: name must be king-skills")
    plugins = market.get("plugins")
    if not isinstance(plugins, list):
        print("ERROR: .claude-plugin/marketplace.json: plugins must be a list")
        plugins = []
    names, sources = {}, {}
    for i, p in enumerate(plugins):
        if not isinstance(p, dict):
            print(f"ERROR: marketplace.json plugins[{i}] must be an object")
            continue
        name, src = p.get("name"), p.get("source")
        if not isinstance(name, str) or not name:
            print(f"ERROR: marketplace.json plugins[{i}] has no name")
            continue
        if name.startswith(("claude-", "anthropic-")):
            print(f"ERROR: marketplace.json: plugin name '{name}' uses a reserved prefix")
        if name in names:
            print(f"ERROR: marketplace.json lists plugin '{name}' more than once")
        names[name] = src
        if isinstance(src, str):
            if src in sources:
                print(f"ERROR: marketplace.json: source '{src}' is used by '{sources[src]}' and '{name}'")
            sources[src] = name
            if not os.path.isdir(src):
                print(f"ERROR: marketplace.json: source '{src}' of '{name}' does not exist")
    for c in cats:
        want = f"king-{c}"
        if want not in names:
            print(f"ERROR: marketplace.json does not list plugin {want}")
        elif names[want] != f"./{c}":
            print(f"ERROR: marketplace.json: {want} source must be ./{c} (found {names[want]!r})")
    for extra in sorted(set(names) - {f"king-{c}" for c in cats}):
        print(f"ERROR: marketplace.json lists '{extra}', which is not a known category plugin")
elif market is not None:
    print("ERROR: .claude-plugin/marketplace.json must be a JSON object")

for c in cats:
    path = f"{c}/.claude-plugin/plugin.json"
    if not os.path.exists(path):
        continue
    data = load(path)
    if data is None:
        continue
    if not isinstance(data, dict):
        print(f"ERROR: {path} must be a JSON object")
    elif data.get("name") != f"king-{c}":
        print(f"ERROR: {path}: name must be king-{c} (found {data.get('name')!r})")

def description(path):
    with open(path, encoding="utf-8") as fh:
        lines = fh.read().split("\n")
    if not lines or lines[0] != "---":
        return None
    out, grab = [], False
    for line in lines[1:]:
        if line == "---":
            break
        if grab:
            if line.startswith((" ", "\t")) or not line.strip():
                out.append(line.strip())
                continue
            grab = False
        m = re.match(r"description:\s*(.*)$", line)
        if m:
            value = m.group(1).strip()
            if value[:1] in (">", "|"):
                grab = True
            else:
                out.append(value.strip("\"'"))
    return " ".join(x for x in out if x)

for path in sorted(glob.glob("*/skills/*/SKILL.md")):
    if path.split("/")[0] not in cats:
        continue
    desc = description(path)
    if desc and len(desc) > limit:
        print(f"WARN: {path}: description is {len(desc)} characters; Claude Code truncates the skill listing at {limit}")
PY
)
else
  warn "python3 not found; skipped JSON and description-length checks"
fi

# Merge-conflict markers in any text file.
while IFS= read -r f; do
  err "$f has merge-conflict markers"
done < <(grep -rIl --exclude-dir=.git -E '^(<<<<<<<|>>>>>>>)( |$)' . 2>/dev/null)

# Installer sees every skill.
listed=$(scripts/install.sh --list 2>/dev/null | wc -l | tr -d ' ')
[ "$listed" = "$total" ] || err "install.sh --list shows $listed skills, expected $total"

if [ "${1:-}" = "--with-claude" ]; then
  if command -v claude >/dev/null 2>&1; then
    for p in . "${CATEGORIES[@]/#/./}"; do
      if ! out="$(claude plugin validate "$p" 2>&1)"; then
        err "claude plugin validate failed for $p:"
        printf '%s\n' "$out" | sed 's/^/    /'
      fi
    done
  else
    warn "claude CLI not found; skipped --with-claude"
  fi
fi

echo "skills: $total | errors: $errors | warnings: $warns"
[ "$errors" -eq 0 ]
