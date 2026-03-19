#!/usr/bin/env bash
set -euo pipefail

TARGET_DIR="${1:-}"
shift || true
SKILLS=("$@")

KIT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SOURCE_ROOT="$KIT_ROOT/codex-skills"
CODEX_HOME_DIR="${CODEX_HOME:-$HOME/.codex}"

if [ -z "$TARGET_DIR" ]; then
  TARGET_DIR="$CODEX_HOME_DIR/skills"
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
      echo "No Codex skill matched '$wanted'. Use exact names like miica-plan, miica-fix-issue, miica-documentation, miica-knowledge, miica-analyse, or miica-implementation." >&2
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
  echo "No kit-managed Codex skills were found in $TARGET_DIR"
  exit 0
fi

echo "Uninstalled Codex skills from $TARGET_DIR"
for dir in "${removed[@]}"; do
  echo "- $dir"
done
