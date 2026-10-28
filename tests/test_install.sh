#!/usr/bin/env bash
# Behaviour tests for scripts/install.sh. Every install goes into a temporary
# directory; the real ~/.claude/skills is never touched.
# shellcheck source=tests/lib.sh
. "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

INSTALL="$REPO/scripts/install.sh"
REAL_MV="$(command -v mv)"
SKILL=color-palette SRC="$REPO/design/skills/color-palette"
D="$TMP/dest with spaces & 'quotes'"
export HOME="$TMP/home"   # a stray default install would land here, not in the real home

no_stage_left() { ! ls -A "$1" 2>/dev/null | grep -q '^\.king-skills-install\.'; }

echo "install.sh"

t "--list prints every skill folder"
run "$INSTALL" --list
want=$(find "$REPO"/{writing,productivity,design,engineering,workflows}/skills -mindepth 2 -maxdepth 2 -name SKILL.md | wc -l | tr -d ' ')
got=$(printf '%s\n' "$out" | grep -c /)
expect_rc 0 && { [ "$got" = "$want" ] && ok "$got skills" || bad "listed $got, expected $want"; }

t "fresh install into a path with spaces and quotes"
run "$INSTALL" "$SKILL" --dest "$D"
expect_rc 0 && expect_out "installed: $SKILL" && {
  diff -r "$SRC" "$D/$SKILL" >/dev/null && no_stage_left "$D" && ok || bad "copy differs from source or staging left behind"; }

t "second install without --force is refused and changes nothing"
echo "my notes" > "$D/$SKILL/MY_NOTES.md"
run "$INSTALL" "$SKILL" --dest "$D"
expect_rc 1 && expect_out "use --force" && { [ -f "$D/$SKILL/MY_NOTES.md" ] && ok || bad "existing install was modified"; }

t "--dry-run on an existing install reports replace and writes nothing"
run "$INSTALL" "$SKILL" --dest "$D" --force --dry-run
expect_rc 0 && expect_out "[dry-run] replace" && { [ -f "$D/$SKILL/MY_NOTES.md" ] && ok || bad "dry-run modified files"; }

t "--force replaces the folder with an exact copy of the source"
echo "edited" >> "$D/$SKILL/SKILL.md"
run "$INSTALL" "$SKILL" --dest "$D" --force
expect_rc 0 && expect_out "replaced: $SKILL" && {
  diff -r "$SRC" "$D/$SKILL" >/dev/null && no_stage_left "$D" && ok || bad "folder differs from source after --force"; }

t "repeated --force installs leave exactly one copy"
"$INSTALL" "$SKILL" --dest "$D" --force >/dev/null 2>&1; "$INSTALL" "$SKILL" --dest "$D" --force >/dev/null 2>&1
n=$(find "$D" -mindepth 1 -maxdepth 1 | wc -l | tr -d ' ')
[ "$n" = 1 ] && ok || bad "expected 1 entry in destination, found $n"

t "category install copies every skill in the category"
run "$INSTALL" writing --dest "$TMP/cat"
want=$(find "$REPO/writing/skills" -mindepth 1 -maxdepth 1 -type d | wc -l | tr -d ' ')
expect_rc 0 && { [ "$(find "$TMP/cat" -mindepth 1 -maxdepth 1 | wc -l | tr -d ' ')" = "$want" ] && ok "$want skills" || bad "wrong number of skills"; }

t "--dry-run into a new directory creates nothing"
run "$INSTALL" all --dest "$TMP/never"
run "$INSTALL" all --dest "$TMP/never2" --dry-run
expect_rc 0 && expect_out "would be installed" && { [ ! -e "$TMP/never2" ] && ok || bad "dry-run created the destination"; }

t "--project installs into ./.claude/skills"
mkdir -p "$TMP/proj"
run bash -c 'cd "$1" && "$2" "$3" --project' _ "$TMP/proj" "$INSTALL" "$SKILL"
expect_rc 0 && { [ -f "$TMP/proj/.claude/skills/$SKILL/SKILL.md" ] && ok || bad "not installed under ./.claude/skills"; }

t "default destination is \$HOME/.claude/skills"
run "$INSTALL" "$SKILL"
expect_rc 0 && { [ -f "$HOME/.claude/skills/$SKILL/SKILL.md" ] && ok || bad "not installed under \$HOME"; }

echo "  -- invalid input"
t "unknown skill";            run "$INSTALL" no-such-skill --dest "$TMP/x";  expect_rc 1 && expect_out "no skill or category" && ok
t "path-like target";         run "$INSTALL" ../design --dest "$TMP/x";      expect_rc 1 && ok
t "unknown option";           run "$INSTALL" "$SKILL" --bogus;               expect_rc 2 && ok
t "--dest without a value";   run "$INSTALL" "$SKILL" --dest;                expect_rc 2 && ok
t "--dest with an empty value"; run "$INSTALL" "$SKILL" --dest "";           expect_rc 2 && ok
t "two targets";              run "$INSTALL" "$SKILL" icon-set;              expect_rc 2 && ok
t "no target";                run "$INSTALL";                               expect_rc 2 && ok
t "nothing was created by invalid input"; [ ! -e "$TMP/x" ] && ok || bad "$TMP/x exists"

echo "  -- unsafe destinations"
t "destination is a regular file"
touch "$TMP/afile"; run "$INSTALL" "$SKILL" --dest "$TMP/afile"
expect_rc 1 && expect_out "not a directory" && ok

t "skill path in destination is a symlink (never followed or replaced, even with --force)"
mkdir -p "$TMP/linkdest" "$TMP/precious"; echo keep > "$TMP/precious/data.txt"
ln -s "$TMP/precious" "$TMP/linkdest/$SKILL"
run "$INSTALL" "$SKILL" --dest "$TMP/linkdest" --force
expect_rc 1 && expect_out "symbolic link" && {
  [ -L "$TMP/linkdest/$SKILL" ] && [ "$(cat "$TMP/precious/data.txt")" = keep ] && [ ! -e "$TMP/precious/SKILL.md" ] && ok || bad "symlink or its target changed"; }

t "skill path in destination is a regular file"
mkdir -p "$TMP/filedest"; echo keep > "$TMP/filedest/$SKILL"
run "$INSTALL" "$SKILL" --dest "$TMP/filedest" --force
expect_rc 1 && { [ "$(cat "$TMP/filedest/$SKILL")" = keep ] && ok || bad "file was replaced"; }

t "destination inside the repository's own skill folder is refused"
copy_repo "$TMP/repo"
run "$TMP/repo/scripts/install.sh" "$SKILL" --dest "$TMP/repo/design/skills" --force
expect_rc 1 && expect_out "overlaps" && { diff -r "$SRC" "$TMP/repo/design/skills/$SKILL" >/dev/null && ok || bad "source skill was damaged"; }

t "destination given with .. into the source folder is refused"
run "$TMP/repo/scripts/install.sh" "$SKILL" --dest "$TMP/repo/scripts/../design/skills" --force
expect_rc 1 && expect_out "overlaps" && ok

t "source skill containing a symlink is refused before anything is written"
ln -s /etc/passwd "$TMP/repo/design/skills/$SKILL/evil"
run "$TMP/repo/scripts/install.sh" "$SKILL" --dest "$TMP/fromlink"
expect_rc 1 && expect_out "symbolic links" && { [ ! -e "$TMP/fromlink" ] && ok || bad "destination was created"; }
rm "$TMP/repo/design/skills/$SKILL/evil"

t "destination that is not writable"
if [ "$(id -u)" -eq 0 ]; then skip "running as root, permissions are not enforced"
else
  mkdir -p "$TMP/ro"; chmod 555 "$TMP/ro"
  run "$INSTALL" "$SKILL" --dest "$TMP/ro"; chmod 755 "$TMP/ro"
  expect_rc 1 && expect_out "not writable" && ok
fi

echo "  -- failed and interrupted updates keep the previous installation"
stub() {  # name script-body: puts a fake command first on PATH
  mkdir -p "$TMP/stub"; printf '#!/usr/bin/env bash\n%s\n' "$2" > "$TMP/stub/$1"; chmod +x "$TMP/stub/$1"
}
prepare_old() {  # dir: an installed writing category plus a local edit to detect
  rm -rf "$1"; "$INSTALL" writing --dest "$1" >/dev/null
  echo "my notes" > "$1/writing-arabic/MY_NOTES.md"; cp -R "$1" "$1.before"
}

t "copy failure: nothing changes, exit 3"
prepare_old "$TMP/upd"; rm -rf "$TMP/stub"; stub cp 'exit 1'
run env PATH="$TMP/stub:$PATH" "$INSTALL" writing --dest "$TMP/upd" --force
expect_rc 3 && expect_out "nothing was changed" && {
  diff -r "$TMP/upd.before" "$TMP/upd" >/dev/null && no_stage_left "$TMP/upd" && ok || bad "previous installation changed"; }

t "failure in the middle of the swap: every skill is restored, exit 3"
prepare_old "$TMP/upd2"; rm -rf "$TMP/stub"; echo 0 > "$TMP/mvcount"
stub mv "n=\$(( \$(cat '$TMP/mvcount') + 1 )); echo \$n > '$TMP/mvcount'; [ \$n -eq 4 ] && exit 1; exec '$REAL_MV' \"\$@\""
run env PATH="$TMP/stub:$PATH" "$INSTALL" writing --dest "$TMP/upd2" --force
expect_rc 3 && expect_out "previous installation was restored" && {
  diff -r "$TMP/upd2.before" "$TMP/upd2" >/dev/null && no_stage_left "$TMP/upd2" && ok || bad "previous installation not restored"; }

# The signal lands right after rename number k, before the script can record it.
# Updating the 5 writing skills takes 10 renames; k=10 is after the last one.
for k in 1 2 3 4 5 6 7 8 9; do
  t "interrupted (SIGTERM) right after rename $k of the swap: every skill is restored"
  prepare_old "$TMP/upd3"; rm -rf "$TMP/stub"; echo 0 > "$TMP/mvcount"
  stub mv "n=\$(( \$(cat '$TMP/mvcount') + 1 )); echo \$n > '$TMP/mvcount'; '$REAL_MV' \"\$@\"; s=\$?; [ \$n -eq $k ] && kill -TERM \$PPID; exit \$s"
  run env PATH="$TMP/stub:$PATH" "$INSTALL" writing --dest "$TMP/upd3" --force
  expect_rc 3 && {
    diff -r "$TMP/upd3.before" "$TMP/upd3" >/dev/null && no_stage_left "$TMP/upd3" && ok || bad "previous installation not restored"; }
  rm -rf "$TMP/upd3" "$TMP/upd3.before"
done

t "a leftover staging folder is reported, not installed or deleted"
mkdir -p "$TMP/left/.king-skills-install.abc123"
run "$INSTALL" "$SKILL" --dest "$TMP/left"
expect_rc 0 && expect_out "leftover staging folder" && { [ -d "$TMP/left/.king-skills-install.abc123" ] && ok || bad "leftover was removed"; }

summary
