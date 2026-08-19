#!/usr/bin/env bash
# Package skills as .skill zips for manual upload to claude.ai, and track which
# uploads have gone stale. Claude Code gets these skills via the plugin, not this.
#
#   ./build.sh            build dist/<name>.skill for every claude.ai-bound skill
#   ./build.sh status     show current / STALE / never-uploaded per skill
#   ./build.sh mark NAME  record that dist/NAME.skill was uploaded (then commit)
set -euo pipefail
cd "$(dirname "$0")"
ROOT=$(pwd)

sha() { if command -v sha256sum >/dev/null 2>&1; then sha256sum; else shasum -a 256; fi; }

# Content hash of a skill directory: file names + contents, no timestamps.
# Hashes the source (zips embed mtimes and are not reproducible).
hash_skill() {
  { ( cd skills && find "$1" -type f | LC_ALL=C sort )
    ( cd skills && find "$1" -type f -print0 | LC_ALL=C sort -z | xargs -0 cat )
  } | sha | cut -c1-12
}

# Every skill not marked `surfaces: code` in its frontmatter.
ai_skills() {
  for d in skills/*/; do
    n=$(basename "$d")
    grep -Eq '^surfaces:[[:space:]]*code[[:space:]]*$' "$d/SKILL.md" || echo "$n"
  done
}

uploaded_hash() {
  [ -f uploaded.tsv ] || return 0
  awk -F'\t' -v n="$1" '$1==n{print $2}' uploaded.tsv
}

case "${1:-build}" in
  build)
    mkdir -p dist
    for n in $(ai_skills); do
      stage=$(mktemp -d)
      cp -R "skills/$n" "$stage/$n"
      # claude.ai rejects unknown frontmatter keys, so drop our own convention key.
      grep -v '^surfaces:' "skills/$n/SKILL.md" > "$stage/$n/SKILL.md"
      rm -f "dist/$n.skill"
      ( cd "$stage" && zip -qrX "$ROOT/dist/$n.skill" "$n" )
      rm -rf "$stage"
      echo "dist/$n.skill"
    done
    echo "→ upload the stale ones (./build.sh status) at claude.ai → Customize → Skills"
    ;;
  status)
    for n in $(ai_skills); do
      h=$(hash_skill "$n"); u=$(uploaded_hash "$n")
      case "$u" in
        "")  s="never uploaded" ;;
        "$h") s="current" ;;
        *)   s="STALE (repo $h, uploaded $u)" ;;
      esac
      printf '%-24s %s\n' "$n" "$s"
    done
    ;;
  mark)
    shift
    [ $# -gt 0 ] || { echo "usage: ./build.sh mark <skill>..." >&2; exit 2; }
    touch uploaded.tsv
    for n in "$@"; do
      [ -d "skills/$n" ] || { echo "no such skill: $n" >&2; exit 1; }
      { grep -v "^$n	" uploaded.tsv || true
        printf '%s\t%s\t%s\n' "$n" "$(hash_skill "$n")" "$(date +%F)"
      } | LC_ALL=C sort > uploaded.tsv.tmp
      mv uploaded.tsv.tmp uploaded.tsv
    done
    echo "uploaded.tsv updated — commit it"
    ;;
  *) echo "usage: ./build.sh [build|status|mark <skill>...]" >&2; exit 2 ;;
esac
