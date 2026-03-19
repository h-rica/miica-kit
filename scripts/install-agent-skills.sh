#!/usr/bin/env bash
set -euo pipefail

TARGET_DIR="${1:-}"
shift || true
SKILLS=("$@")

KIT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SOURCE_ROOT="$KIT_ROOT/codex-skills"
AGENTS_HOME_DIR="${AGENTS_HOME:-$HOME/.agents}"

if [ -z "$TARGET_DIR" ]; then
  TARGET_DIR="$AGENTS_HOME_DIR/skills"
fi

mkdir -p "$TARGET_DIR"

copy_dir_safe() {
  local src="$1"
  local dest="$2"
  if [ -e "$dest" ]; then
    if [ "${FORCE:-0}" != "1" ]; then
      echo "Destination already exists: $dest" >&2
      echo "Re-run with FORCE=1 to overwrite." >&2
      exit 1
    fi
    rm -rf "$dest"
  fi
  cp -R "$src" "$dest"
}

selected=()
if [ "${#SKILLS[@]}" -eq 0 ]; then
  while read -r dir; do
    selected+=("$dir")
  done < <(find "$SOURCE_ROOT" -mindepth 1 -maxdepth 1 -type d | sort)
else
  for wanted in "${SKILLS[@]}"; do
    match="$SOURCE_ROOT/$wanted"
    if [ ! -d "$match" ]; then
      echo "No agent skill matched '$wanted'. Use exact names like miica-plan, miica-fix-issue, miica-documentation, miica-knowledge, miica-analyse, or miica-implementation." >&2
      exit 1
    fi
    selected+=("$match")
  done
fi

for dir in "${selected[@]}"; do
  copy_dir_safe "$dir" "$TARGET_DIR/$(basename "$dir")"
done

echo "Installed agent skills to $TARGET_DIR"
for dir in "${selected[@]}"; do
  echo "- $(basename "$dir")"
done
