#!/usr/bin/env bash
# Regression tests for scripts/validate.sh: the real repository must pass, and
# each deliberately broken copy must fail with a message naming the problem.
# shellcheck source=tests/lib.sh
. "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

echo "validate.sh"

copy_repo "$TMP/base"
CASE="$TMP/case"

# fresh: start a test case from an unmodified copy of the repository.
fresh() { rm -rf "$CASE"; cp -R "$TMP/base" "$CASE"; }
validate() { run bash "$CASE/scripts/validate.sh"; }

# broken <expected text>: the case must fail (exit 1) and name the problem.
broken() { validate; expect_rc 1 "validator accepted a broken repository" && expect_out "$1" && ok; }

edit() {  # file python-expression-on-t: rewrite a file in the case copy
  python3 - "$CASE/$1" "$2" <<'PY'
import sys
p, expr = sys.argv[1], sys.argv[2]
t = open(p, encoding="utf-8").read()
t = eval(expr, {"t": t})
open(p, "w", encoding="utf-8").write(t)
PY
}

t "the repository itself passes with exit 0"
run bash "$REPO/scripts/validate.sh"
expect_rc 0 && expect_out "errors: 0" && ok

t "an unmodified copy passes"
fresh; validate; expect_rc 0 && ok

t "merge-conflict markers fail the run (were printed but ignored before)"
fresh; printf '\n<<<<<<< HEAD\na\n=======\nb\n>>>>>>> other\n' >> "$CASE/writing/skills/writing-arabic/README.md"
broken "writing-arabic/README.md has merge-conflict markers"

t "merge-conflict markers in a script fail the run"
fresh; printf '<<<<<<< HEAD\n' >> "$CASE/workflows/skills/create-brand-kit/scripts/outline.py"
broken "outline.py has merge-conflict markers"

t "a required heading that only appears inside a code block fails"
fresh; edit design/skills/color-palette/SKILL.md "t.replace('\n## حالات حدّية\n', '\n### x\n', 1) + '\n\`\`\`text\n## حالات حدّية\n\`\`\`\n'"
broken "missing section '## حالات حدّية'"

t "a missing English section fails"
fresh; edit design/skills/color-palette/SKILL.en.md "t.replace('\n## Edge cases\n', '\n## Edge\n', 1)"
broken "SKILL.en.md: missing section '## Edge cases'"

t "front matter name that does not match the folder fails"
fresh; edit engineering/skills/commit-message/SKILL.md "t.replace('name: commit-message', 'name: commit-msg', 1)"
broken "line 2 must be 'name: commit-message'"

t "workflow name only in the body, not the front matter, fails"
fresh; edit workflows/skills/review-an-app/SKILL.md "t.replace('name: review-an-app', 'name: other', 1) + '\nname: review-an-app\n'"
broken "front matter must contain 'name: review-an-app'"

t "workflow front matter that never closes fails"
fresh; edit workflows/skills/review-an-app/SKILL.md "'---\n' + '\n'.join(l for l in t.split('\n') if l != '---')"
broken "front matter must close with ---"

t "SKILL.md below 60 lines fails"
fresh; edit writing/skills/formal-messages/SKILL.md "'\n'.join(t.split('\n')[:59]) + '\n'"
broken "lines (must be 60-120)"

t "invalid JSON in a plugin manifest fails"
fresh; edit design/.claude-plugin/plugin.json "t.replace('\"MIT\",', '\"MIT\",,', 1)"
broken "design/.claude-plugin/plugin.json is not valid JSON"

t "a plugin listed twice in the marketplace fails"
fresh; edit .claude-plugin/marketplace.json "t.replace('\"plugins\": [', '\"plugins\": [ {\"name\": \"king-design\", \"source\": \"./design\"},', 1)"
broken "lists plugin 'king-design' more than once"

t "a marketplace source pointing to a missing folder fails"
fresh; edit .claude-plugin/marketplace.json "t.replace('\"./workflows\"', '\"./workflow\"', 1)"
broken "source './workflow' of 'king-workflows' does not exist"

t "a reserved plugin name prefix fails"
fresh; edit .claude-plugin/marketplace.json "t.replace('\"plugins\": [', '\"plugins\": [ {\"name\": \"claude-x\", \"source\": \"./design\"},', 1)"
broken "reserved prefix"

t "a plugin.json name that does not match its category fails"
fresh; edit writing/.claude-plugin/plugin.json "t.replace('\"king-writing\"', '\"king-write\"', 1)"
broken "writing/.claude-plugin/plugin.json: name must be king-writing"

t "the same skill name in two categories fails"
fresh; cp -R "$CASE/writing/skills/writing-arabic" "$CASE/design/skills/writing-arabic"
broken "duplicate skill name 'writing-arabic'"

t "a skill folder name with uppercase or underscores fails"
fresh; mv "$CASE/engineering/skills/commit-message" "$CASE/engineering/skills/Commit_Message"
broken "skill folder name must use lowercase"

t "a SKILL.md outside <category>/skills fails"
fresh; mkdir -p "$CASE/some copy/foo"; cp "$CASE/_template/SKILL.md" "$CASE/some copy/foo/"
broken "some copy/foo/SKILL.md: SKILL.md outside"

t "a broken relative link in a skill README fails"
fresh; printf '\nSee [details](missing-file.md).\n' >> "$CASE/engineering/skills/code-review/README.md"
broken "code-review/README.md: broken link 'missing-file.md'"

t "a link inside a code block is not checked"
fresh; printf '\n```text\n[x](not-a-file.md)\n```\n' >> "$CASE/engineering/skills/code-review/README.md"
validate; expect_rc 0 && ok

t "a skill missing from the root README table fails"
fresh; edit README.en.md "t.replace('| \`icon-set\` |', '| icon-set |', 1)"
broken "README.en.md: skill 'icon-set' not in a table"

t "a wrong skill-count badge fails"
fresh; edit README.md "t.replace('skills-53-', 'skills-52-', 1)"
broken "README.md: skills badge must say"

t "an unknown skill in a 'do not use' line fails"
fresh; edit engineering/skills/code-review/SKILL.md "t.replace('(\`pr-review\`)', '(\`pr-reviews\`)', 1)"
broken "unknown skill referenced in a 'do not use' line: pr-reviews"

t "category lists that differ between the two scripts fail"
fresh; edit scripts/install.sh "t.replace('CATEGORIES=(writing ', 'CATEGORIES=(writting ', 1)"
broken "CATEGORIES differs"

t "an over-long description is a warning, not an error"
fresh; edit workflows/skills/review-an-app/SKILL.md "t.replace('description: ', 'description: ' + 'x' * 1600 + ' ', 1)"
validate; expect_rc 0 && expect_out "Claude Code truncates the skill listing" && ok

t "--with-claude without the CLI warns and still passes"
fresh; run env PATH="/usr/bin:/bin" bash "$CASE/scripts/validate.sh" --with-claude
if command -v python3 >/dev/null 2>&1 && [ ! -x /usr/bin/claude ] && [ ! -x /bin/claude ]; then
  expect_rc 0 && expect_out "claude CLI not found" && ok
else skip "claude or python3 is installed in /usr/bin or /bin"; fi

summary
