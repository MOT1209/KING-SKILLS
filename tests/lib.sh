#!/usr/bin/env bash
# Shared helpers for the king-SKILLS shell tests. Source this file; do not run it.
# Every test works inside a private temporary directory that is removed on exit.

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
TMP="$(mktemp -d "${TMPDIR:-/tmp}/king-skills-test.XXXXXX")"
trap 'rm -rf "$TMP"' EXIT

passed=0 failed=0 skipped=0 current=""

t() { current="$1"; }    # name the test that follows
ok()   { passed=$((passed+1)); echo "  ok    $current${1:+ ($1)}"; }
bad()  { failed=$((failed+1)); echo "  FAIL  $current: $*"; }
skip() { skipped=$((skipped+1)); echo "  skip  $current: $*"; }

# run <cmd...>: runs a command, keeping its output in $out and status in $rc.
run() { out="$("$@" 2>&1)"; rc=$?; }

expect_rc() {  # expected-status [message]
  if [ "$rc" -eq "$1" ]; then return 0; fi
  bad "expected exit $1, got $rc${2:+ ($2)}"; printf '%s\n' "$out" | sed 's/^/        | /' | tail -15; return 1
}
expect_out() {  # fixed string expected in $out
  if printf '%s\n' "$out" | grep -qF -- "$1"; then return 0; fi
  bad "output does not contain '$1'"; printf '%s\n' "$out" | sed 's/^/        | /' | tail -15; return 1
}

# A writable copy of the repository working tree (without .git).
copy_repo() {  # dest
  mkdir -p "$1"
  (cd "$REPO" && tar -cf - --exclude=./.git .) | (cd "$1" && tar -xf -)
}

summary() {
  echo "passed: $passed | failed: $failed | skipped: $skipped"
  [ "$failed" -eq 0 ]
}
