#!/usr/bin/env bash
# king-SKILLS installer | مثبّت مهارات king-SKILLS
# Copies skill folders into a Claude skills directory.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CATEGORIES=(writing productivity design engineering workflows)

usage() {
  cat <<'USAGE'
Usage: scripts/install.sh <skill|category|all> [options]
الاستخدام: scripts/install.sh <مهارة|فئة|all> [خيارات]

  <skill>      a skill name, e.g. color-palette   | اسم مهارة
  <category>   writing | productivity | design | engineering | workflows
  all          every skill                        | كل المهارات

Options | الخيارات:
  --project    install into ./.claude/skills (default: ~/.claude/skills)
  --dest DIR   install into DIR instead
  --force      replace an existing skill folder   | استبدال مهارة موجودة
  --dry-run    show what would happen, copy nothing
  --list       list available skills and exit
  -h, --help   show this help
USAGE
}

list_skills() {  # prints "category/skill" per line
  local c d
  for c in "${CATEGORIES[@]}"; do
    for d in "$ROOT/$c/skills"/*/; do
      [ -f "${d}SKILL.md" ] && echo "$c/$(basename "$d")"
    done
  done
}

target="" dest="$HOME/.claude/skills" force=0 dry=0 want_list=0
while [ $# -gt 0 ]; do
  case "$1" in
    --project) dest="$PWD/.claude/skills" ;;
    --dest) [ $# -ge 2 ] || { echo "error: --dest needs a directory" >&2; exit 2; }; dest="$2"; shift ;;
    --force) force=1 ;;
    --dry-run) dry=1 ;;
    --list) want_list=1 ;;
    -h|--help) usage; exit 0 ;;
    -*) echo "error: unknown option $1" >&2; usage >&2; exit 2 ;;
    *) [ -z "$target" ] || { echo "error: only one target allowed" >&2; exit 2; }; target="$1" ;;
  esac
  shift
done

if [ "$want_list" -eq 1 ]; then list_skills; exit 0; fi
[ -n "$target" ] || { usage >&2; exit 2; }

selected=()
while IFS= read -r entry; do
  cat="${entry%%/*}"; name="${entry#*/}"
  if [ "$target" = "all" ] || [ "$target" = "$cat" ] || [ "$target" = "$name" ]; then
    selected+=("$entry")
  fi
done < <(list_skills)

if [ "${#selected[@]}" -eq 0 ]; then
  echo "error: no skill or category named '$target' (try --list)" >&2
  exit 1
fi

# Refuse to touch anything if a destination exists and --force was not given.
if [ "$force" -eq 0 ]; then
  clash=0
  for entry in "${selected[@]}"; do
    name="${entry#*/}"
    if [ -e "$dest/$name" ]; then echo "exists: $dest/$name (use --force to replace)" >&2; clash=1; fi
  done
  [ "$clash" -eq 0 ] || { echo "nothing was copied." >&2; exit 1; }
fi

for entry in "${selected[@]}"; do
  cat="${entry%%/*}"; name="${entry#*/}"
  src="$ROOT/$cat/skills/$name"
  if [ "$dry" -eq 1 ]; then echo "[dry-run] $src -> $dest/$name"; continue; fi
  mkdir -p "$dest"
  [ -n "$name" ] && [ "$name" != "." ] && [ "$name" != ".." ] || exit 1
  [ -e "$dest/$name" ] && rm -rf "${dest:?}/$name"
  cp -R "$src" "$dest/$name"
  echo "installed: $name -> $dest/$name"
done
if [ "$dry" -eq 1 ]; then echo "dry-run: ${#selected[@]} skill(s) would be installed."; else echo "done: ${#selected[@]} skill(s)."; fi
