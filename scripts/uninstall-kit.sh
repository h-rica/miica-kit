#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -lt 1 ]; then
  echo "Usage: ./scripts/uninstall-kit.sh <target-path>" >&2
  exit 1
fi

TARGET_PATH="$1"
KIT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SKILLS_SOURCE_DIR="$KIT_ROOT/skills"

if [ ! -e "$TARGET_PATH" ]; then
  echo "No project directory found at $TARGET_PATH"
  exit 0
fi

TARGET_ROOT="$(cd "$TARGET_PATH" && pwd)"
AGENT_KIT_DIR="$TARGET_ROOT/.agent-kit"
INSTALLED_DIR="$AGENT_KIT_DIR/installed"
BACKUPS_DIR="$AGENT_KIT_DIR/backups"
SKILLS_DIR="$AGENT_KIT_DIR/skills"
MANIFEST_PATH="$AGENT_KIT_DIR/install-state.env"

read_install_state() {
  if [ ! -f "$MANIFEST_PATH" ]; then
    return 1
  fi

  while IFS='=' read -r key value; do
    case "$key" in
      MANIFEST_VERSION) MANIFEST_VERSION="$value" ;;
      MODE) MODE="$value" ;;
      AGENTS_STATE) AGENTS_STATE="$value" ;;
      MEMORY_STATE) MEMORY_STATE="$value" ;;
      CHANGELOG_STATE) CHANGELOG_STATE="$value" ;;
      SKILLS) SKILLS="$value" ;;
    esac
  done < "$MANIFEST_PATH"

  return 0
}

portable_skill_files() {
  find "$SKILLS_SOURCE_DIR" -maxdepth 1 -type f ! -name 'README.md' -print | sort
}

remove_if_exists() {
  local path="$1"
  if [ -e "$path" ]; then
    rm -rf "$path"
    return 0
  fi
  return 1
}

remove_dir_if_empty() {
  local path="$1"
  if [ -d "$path" ] && [ -z "$(find "$path" -mindepth 1 -print -quit)" ]; then
    rmdir "$path"
  fi
}

files_equal() {
  local first="$1"
  local second="$2"
  if [ ! -f "$first" ] || [ ! -f "$second" ]; then
    return 1
  fi
  cmp -s "$first" "$second"
}

actions=()
warnings=()
touched=0
blocked_root_recovery=0
have_manifest=0

if read_install_state; then
  have_manifest=1
elif [ -d "$AGENT_KIT_DIR" ]; then
  warnings+=("No install-state manifest was found, so root AGENTS.md, MEMORY.md, and CHANGELOG.md were left untouched.")
fi

handle_root_doc() {
  local file_name="$1"
  local state="$2"
  local snapshot_name="$file_name"
  local target_file="$TARGET_ROOT/$file_name"
  local backup_base="${file_name%.md}"
  local backup_file="$BACKUPS_DIR/$backup_base.pre-kit.md"

  if [ "$file_name" = "AGENTS.md" ]; then
    snapshot_name="AGENTS.root.md"
  fi

  local snapshot_file="$INSTALLED_DIR/$snapshot_name"

  case "$state" in
    installed-root)
      if [ ! -e "$target_file" ]; then
        return 0
      fi
      if files_equal "$target_file" "$snapshot_file"; then
        rm -f "$target_file"
        actions+=("$file_name removed")
        touched=1
      else
        warnings+=("$file_name was installed by the kit but changed after installation, so it was left in place.")
        blocked_root_recovery=1
      fi
      ;;
    overwrote-root)
      if [ -e "$target_file" ] && [ -e "$snapshot_file" ] && ! files_equal "$target_file" "$snapshot_file"; then
        warnings+=("$file_name was overwritten by the kit and later modified, so the backup was left in .agent-kit/backups for manual restore.")
        blocked_root_recovery=1
        return 0
      fi
      if [ -f "$backup_file" ]; then
        cp -f "$backup_file" "$target_file"
        actions+=("$file_name restored from .agent-kit/backups/$backup_base.pre-kit.md")
        touched=1
      else
        warnings+=("Backup for $file_name is missing, so the current file was left in place.")
        blocked_root_recovery=1
      fi
      ;;
  esac
}

if [ "$have_manifest" = "1" ]; then
  handle_root_doc "AGENTS.md" "${AGENTS_STATE:-}"
  handle_root_doc "MEMORY.md" "${MEMORY_STATE:-}"
  handle_root_doc "CHANGELOG.md" "${CHANGELOG_STATE:-}"
fi

for file in AGENTS.portable.md AGENTS.integration.md MEMORY.template.md CHANGELOG.template.md ROLES.md WORKFLOW.md; do
  if remove_if_exists "$AGENT_KIT_DIR/$file"; then
    actions+=(".agent-kit/$file removed")
    touched=1
  fi
done

if [ -d "$SKILLS_DIR" ]; then
  while read -r file; do
    [ -n "$file" ] || continue
    base="$(basename "$file")"
    if remove_if_exists "$SKILLS_DIR/$base"; then
      actions+=(".agent-kit/skills/$base removed")
      touched=1
    fi
  done < <(portable_skill_files)
fi

remove_dir_if_empty "$SKILLS_DIR"

if [ "$have_manifest" = "1" ] && [ "$blocked_root_recovery" = "0" ]; then
  if remove_if_exists "$INSTALLED_DIR"; then
    touched=1
  fi
  if remove_if_exists "$MANIFEST_PATH"; then
    actions+=(".agent-kit/install-state.env removed")
    touched=1
  fi
  if remove_if_exists "$BACKUPS_DIR"; then
    touched=1
  fi
elif [ "$blocked_root_recovery" = "1" ]; then
  warnings+=("The install state and backups were kept under .agent-kit so you can finish cleanup manually.")
fi

remove_dir_if_empty "$INSTALLED_DIR"
remove_dir_if_empty "$BACKUPS_DIR"
remove_dir_if_empty "$AGENT_KIT_DIR"

if [ "$touched" = "0" ] && [ "${#warnings[@]}" -eq 0 ]; then
  echo "No installed project-local kit elements were found in $TARGET_ROOT"
  exit 0
fi

echo "Uninstalled project-local kit from $TARGET_ROOT"
for action in "${actions[@]}"; do
  echo "- $action"
done
for warning in "${warnings[@]}"; do
  echo "! $warning"
done
