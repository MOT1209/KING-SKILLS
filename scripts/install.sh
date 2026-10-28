#!/usr/bin/env bash
# king-SKILLS installer | مثبّت مهارات king-SKILLS
# Copies skill folders into a Claude skills directory.
#
# Safety model:
#   * Nothing is replaced without --force.
#   * Every selected skill is first copied into a staging folder inside the
#     destination and verified. Only then are existing folders swapped out with
#     same-filesystem renames. If any step fails (or the script is interrupted),
#     the previous installation is restored and the staging folder is removed.
#   * Symbolic links are never followed or replaced, and a destination inside
#     the repository's own skill folders is refused.
#
# Exit codes: 0 success | 1 refused (not found, already installed, unsafe path)
#             2 usage error | 3 install failed, previous state restored
#             4 install failed and automatic restore failed (see message)
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
CATEGORIES=(writing productivity design engineering workflows)
STAGE_PREFIX=".king-skills-install."

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
  --force      replace an existing skill folder; its old contents, including
               your own edits, are removed after the new copy is in place
               | استبدال مهارة موجودة (تُحذف النسخة القديمة وتعديلاتك عليها)
  --dry-run    check everything and show what would happen, copy nothing
  --list       list available skills and exit
  -h, --help   show this help

Exit codes: 0 ok, 1 refused, 2 usage error, 3 failed (previous state restored),
4 failed and restore failed.
USAGE
}

die() {  # code, message...
  local code="$1"; shift
  echo "error: $*" >&2
  exit "$code"
}

valid_name() { [[ "$1" =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]]; }

list_skills() {  # prints "category/skill" per line
  local c d n
  for c in "${CATEGORIES[@]}"; do
    for d in "$ROOT/$c/skills"/*/; do
      [ -d "$d" ] || continue
      n="$(basename "$d")"
      valid_name "$n" || continue
      [ -L "${d%/}" ] && continue
      [ -f "${d}SKILL.md" ] && echo "$c/$n"
    done
  done
  return 0
}

# Absolute, symlink-resolved form of a path that may not exist yet.
canon() {
  local p="$1" rest="" base
  case "$p" in /*) ;; *) p="$PWD/$p" ;; esac
  while [ ! -d "$p" ]; do
    base="$(basename "$p")"
    case "$base" in .|..) return 1 ;; esac
    rest="/$base$rest"
    p="$(dirname "$p")"
  done
  p="$(cd "$p" && pwd -P)" || return 1
  [ "$p" = "/" ] && p=""
  printf '%s\n' "$p$rest"
}

# True when $1 and $2 are the same path or one contains the other.
overlaps() {
  case "$1/" in "$2/"*) return 0 ;; esac
  case "$2/" in "$1/"*) return 0 ;; esac
  return 1
}

target="" dest="$HOME/.claude/skills" force=0 dry=0 want_list=0
while [ $# -gt 0 ]; do
  case "$1" in
    --project) dest="$PWD/.claude/skills" ;;
    --dest) [ $# -ge 2 ] && [ -n "$2" ] || die 2 "--dest needs a directory"; dest="$2"; shift ;;
    --force) force=1 ;;
    --dry-run) dry=1 ;;
    --list) want_list=1 ;;
    -h|--help) usage; exit 0 ;;
    -*) echo "error: unknown option $1" >&2; usage >&2; exit 2 ;;
    *) [ -z "$target" ] || die 2 "only one target allowed"; target="$1" ;;
  esac
  shift
done

if [ "$want_list" -eq 1 ]; then list_skills; exit 0; fi
[ -n "$target" ] || { usage >&2; exit 2; }

for tool in cp mv rm mkdir mktemp find diff; do
  command -v "$tool" >/dev/null 2>&1 || die 1 "required command '$tool' not found"
done

selected=()
if [ "$target" = "all" ] || valid_name "$target"; then
  while IFS= read -r entry; do
    cat="${entry%%/*}"; name="${entry#*/}"
    if [ "$target" = "all" ] || [ "$target" = "$cat" ] || [ "$target" = "$name" ]; then
      selected+=("$entry")
    fi
  done < <(list_skills)
fi
[ "${#selected[@]}" -gt 0 ] || die 1 "no skill or category named '$target' (try --list)"

# ---- Destination checks ------------------------------------------------------
if [ -e "$dest" ] || [ -L "$dest" ]; then
  [ -d "$dest" ] || die 1 "destination '$dest' exists and is not a directory"
fi
dest_real="$(canon "$dest")" || die 1 "cannot resolve destination '$dest'"
[ -n "$dest_real" ] || die 1 "refusing to install into the filesystem root"
if [ -d "$dest_real" ] && [ ! -w "$dest_real" ]; then
  die 1 "destination '$dest_real' is not writable"
fi

# ---- Per-skill checks (nothing is written until all of them pass) -------------
clash=0
for entry in "${selected[@]}"; do
  cat="${entry%%/*}"; name="${entry#*/}"
  src="$ROOT/$cat/skills/$name"
  tgt="$dest_real/$name"
  [ -d "$src" ] && [ ! -L "$src" ] && [ -f "$src/SKILL.md" ] || die 1 "source skill '$src' is missing or incomplete"
  if [ -n "$(find "$src" ! -type f ! -type d -print -quit)" ]; then
    die 1 "source skill '$src' contains symbolic links or special files; refusing to copy"
  fi
  overlaps "$tgt" "$src" && die 1 "destination '$tgt' overlaps the repository source '$src'"
  if [ -L "$tgt" ]; then
    die 1 "'$tgt' is a symbolic link; remove or rename it yourself, the installer never replaces links"
  elif [ -e "$tgt" ] && [ ! -d "$tgt" ]; then
    die 1 "'$tgt' exists and is not a directory; remove or rename it yourself"
  elif [ -e "$tgt" ] && [ "$force" -eq 0 ]; then
    echo "exists: $tgt (use --force to replace)" >&2; clash=1
  fi
done
[ "$clash" -eq 0 ] || { echo "nothing was copied." >&2; exit 1; }

for left in "$dest_real/$STAGE_PREFIX"*; do
  [ -e "$left" ] && echo "warning: leftover staging folder from an interrupted run: $left" >&2
done

if [ "$dry" -eq 1 ]; then
  for entry in "${selected[@]}"; do
    cat="${entry%%/*}"; name="${entry#*/}"
    action="install"; [ -e "$dest_real/$name" ] && action="replace"
    echo "[dry-run] $action: $ROOT/$cat/skills/$name -> $dest_real/$name"
  done
  echo "dry-run: ${#selected[@]} skill(s) would be installed."
  exit 0
fi

# ---- Stage ------------------------------------------------------------------
mkdir -p -- "$dest_real" || die 1 "cannot create destination '$dest_real'"
[ -w "$dest_real" ] || die 1 "destination '$dest_real' is not writable"
stage="$(mktemp -d "$dest_real/${STAGE_PREFIX}XXXXXX")" || die 1 "cannot create a staging folder in '$dest_real'"
mkdir -p -- "$stage/new" "$stage/old"

phase="stage"
existing=" "   # names already installed before the swap, recorded before anything moves
for entry in "${selected[@]}"; do
  name="${entry#*/}"
  [ -e "$dest_real/$name" ] && existing="$existing$name "
done

# Undo the swap from what is actually on disk, so a signal that lands between a
# rename and the next line cannot make the restore miss a folder.
restore() {
  local entry n ok=0
  for entry in "${selected[@]}"; do
    n="${entry#*/}"
    if [ -e "$stage/old/$n" ]; then
      if [ -e "$dest_real/$n" ]; then mv -- "$dest_real/$n" "$stage/new/$n.failed" 2>/dev/null || ok=1; fi
      mv -- "$stage/old/$n" "$dest_real/$n" 2>/dev/null || ok=1
    elif [[ "$existing" != *" $n "* ]] && [ -e "$dest_real/$n" ] && [ ! -e "$stage/new/$n" ]; then
      mv -- "$dest_real/$n" "$stage/new/$n.failed" 2>/dev/null || ok=1
    fi
  done
  return "$ok"
}

finish() {
  local status=$?
  trap - EXIT INT TERM
  if [ "$phase" = "swap" ]; then
    if restore; then
      echo "install failed; the previous installation was restored." >&2
      status=3
    else
      status=4
    fi
  fi
  if [ -n "${stage:-}" ] && [ -d "$stage" ]; then
    # Never delete previous versions unless the install completed.
    if [ "$phase" != "done" ] && [ -n "$(ls -A "$stage/old" 2>/dev/null)" ]; then
      echo "install failed and could not be fully restored." >&2
      echo "previous versions are kept in: $stage/old" >&2
      exit 4
    fi
    case "$(basename "$stage")" in "$STAGE_PREFIX"*) rm -rf -- "$stage" ;; esac
  fi
  [ "$phase" = "stage" ] && [ "$status" -ne 0 ] && echo "nothing was changed in $dest_real." >&2
  exit "$status"
}
trap finish EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

for entry in "${selected[@]}"; do
  cat="${entry%%/*}"; name="${entry#*/}"
  src="$ROOT/$cat/skills/$name"
  cp -R -- "$src" "$stage/new/$name" || { echo "error: copying $name failed" >&2; exit 3; }
  diff -rq "$src" "$stage/new/$name" >/dev/null 2>&1 || { echo "error: the copy of $name does not match its source" >&2; exit 3; }
done

# ---- Swap -------------------------------------------------------------------
phase="swap"
for entry in "${selected[@]}"; do
  name="${entry#*/}"
  if [ -e "$dest_real/$name" ]; then
    mv -- "$dest_real/$name" "$stage/old/$name" || { echo "error: could not move the existing $name aside" >&2; exit 3; }
  fi
  mv -- "$stage/new/$name" "$dest_real/$name" || { echo "error: could not put the new $name in place" >&2; exit 3; }
done
phase="done"

for entry in "${selected[@]}"; do
  name="${entry#*/}" how="installed"
  [[ "$existing" == *" $name "* ]] && how="replaced"
  echo "$how: $name -> $dest_real/$name"
done
echo "done: ${#selected[@]} skill(s)."
