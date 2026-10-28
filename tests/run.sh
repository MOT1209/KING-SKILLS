#!/usr/bin/env bash
# Runs every test suite in tests/. Exit status is non-zero if any suite fails.
cd "$(dirname "${BASH_SOURCE[0]}")" || exit 2
status=0
for suite in test_*.sh; do
  bash "$suite" || status=1
  echo
done
[ "$status" -eq 0 ] && echo "all test suites passed" || echo "SOME TEST SUITES FAILED"
exit "$status"
