#!/usr/bin/env bash
set -euo pipefail

TARGET_DIR="${1:-}"
shift || true
SKILLS=("$@")

KIT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SOURCE_ROOT="$KIT_ROOT/codex-skills"
OPENCODE_CONFIG_ROOT="${OPENCODE_CONFIG_DIR:-$HOME/.config/opencode}"

if [ -z "$TARGET_DIR" ]; then
  TARGET_DIR="$OPENCODE_CONFIG_ROOT/skills"
fi

selected=()
if [ "${#SKILLS[@]}" -eq 0 ]; then
  while read -r dir; do
    [ -n "$dir" ] || continue
    selected+=("$dir")
  done < <(find "$SOURCE_ROOT" -mindepth 1 -maxdepth 1 -type d | sort)
else
  for wanted in "${SKILLS[@]}"; do
    match="$SOURCE_ROOT/$wanted"
    if [ ! -d "$match" ]; then
      echo "No OpenCode skill matched '$wanted'. Use exact names like miica-plan, miica-architecture, miica-fix-issue, miica-documentation, miica-knowledge, miica-deep-dive, miica-analyse, miica-review, miica-implementation, miica-git, or miica-execute-plan." >&2
      exit 1
    fi
    selected+=("$match")
  done
fi

removed=()
for dir in "${selected[@]}"; do
  target="$TARGET_DIR/$(basename "$dir")"
  if [ -e "$target" ]; then
    rm -rf "$target"
    removed+=("$(basename "$dir")")
  fi
done

if [ "${#removed[@]}" -eq 0 ]; then
  echo "No kit-managed OpenCode skills were found in $TARGET_DIR"
  exit 0
fi

echo "Uninstalled OpenCode skills from $TARGET_DIR"
for dir in "${removed[@]}"; do
  echo "- $dir"
done
