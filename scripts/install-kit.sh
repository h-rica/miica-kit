#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -lt 1 ]; then
  echo "Usage: ./scripts/install-kit.sh <target-path> [direct|modular] [skill-filter ...]" >&2
  exit 1
fi

TARGET_PATH="$1"
MODE="${2:-direct}"
shift || true
if [ "$#" -gt 0 ]; then shift || true; fi
SKILL_FILTERS=("$@")

KIT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
mkdir -p "$TARGET_PATH"
TARGET_ROOT="$(cd "$TARGET_PATH" && pwd)"
AGENT_KIT_DIR="$TARGET_ROOT/.agent-kit"
INSTALLED_DIR="$AGENT_KIT_DIR/installed"
MEMORY_SOURCE="$KIT_ROOT/templates/PROJECT_MEMORY.md"
CHANGELOG_SOURCE="$KIT_ROOT/templates/PROJECT_CHANGELOG.md"
SKILLS_SOURCE_DIR="$KIT_ROOT/skills"
mkdir -p "$AGENT_KIT_DIR"

copy_file_safe() {
  local src="$1"
  local dest="$2"
  local overwrite="${3:-0}"
  mkdir -p "$(dirname "$dest")"
  if [ -e "$dest" ] && [ "$overwrite" != "1" ] && [ "${FORCE:-0}" != "1" ]; then
    echo "Destination already exists: $dest" >&2
    echo "Re-run with FORCE=1 to overwrite." >&2
    exit 1
  fi
  cp -f "$src" "$dest"
}

store_installed_snapshot() {
  local src="$1"
  local file_name="$2"
  mkdir -p "$INSTALLED_DIR"
  cp -f "$src" "$INSTALLED_DIR/$file_name"
}

remove_installed_snapshot() {
  local file_name="$1"
  rm -f "$INSTALLED_DIR/$file_name"
}

write_agent_integration_note() {
  local path="$1"
  mkdir -p "$(dirname "$path")"
  cat > "$path" <<EOF
# Agent Kit Integration Note

A project-specific AGENTS.md already existed in this repository, so the installer preserved it.

Use the existing AGENTS.md as the canonical file.
Use the portable kit files below as supplemental guidance:

- .agent-kit/AGENTS.portable.md
- .agent-kit/MEMORY.template.md
- .agent-kit/CHANGELOG.template.md
- .agent-kit/ROLES.md
- .agent-kit/WORKFLOW.md
- .agent-kit/skills/

Recommended merge block for the project's AGENTS.md:

## Portable Agent Kit

Use ./.agent-kit/WORKFLOW.md for supplemental workflow guidance.
Use ./.agent-kit/skills/ when a task maps cleanly to one of the public commands, especially miica-plan, miica-knowledge, miica-analyse, miica-fix-issue, and miica-implementation.
Use ./MEMORY.md for durable project memory when the repository keeps one.
Keep ./CHANGELOG.md current for notable shipped changes.
If there is any conflict, the project-specific AGENTS.md rules win over the generic portable kit.

Target project:
$TARGET_ROOT
EOF
}

install_agent_file() {
  local src="$1"
  local target_agents="$TARGET_ROOT/AGENTS.md"
  local portable_agents="$AGENT_KIT_DIR/AGENTS.portable.md"
  local integration_note="$AGENT_KIT_DIR/AGENTS.integration.md"
  local backup_dir="$AGENT_KIT_DIR/backups"

  if [ ! -e "$target_agents" ]; then
    copy_file_safe "$src" "$target_agents"
    store_installed_snapshot "$src" "AGENTS.root.md"
    echo "installed-root"
    return 0
  fi

  if [ "${FORCE:-0}" = "1" ]; then
    mkdir -p "$backup_dir"
    cp -f "$target_agents" "$backup_dir/AGENTS.pre-kit.md"
    copy_file_safe "$src" "$target_agents" 1
    store_installed_snapshot "$src" "AGENTS.root.md"
    echo "overwrote-root"
    return 0
  fi

  copy_file_safe "$src" "$portable_agents" 1
  write_agent_integration_note "$integration_note"
  remove_installed_snapshot "AGENTS.root.md"
  echo "preserved-root"
}

install_project_doc() {
  local src="$1"
  local file_name="$2"
  local base_name="${file_name%.md}"
  local target_file="$TARGET_ROOT/$file_name"
  local template_target="$AGENT_KIT_DIR/$base_name.template.md"
  local backup_dir="$AGENT_KIT_DIR/backups"
  local backup_target="$backup_dir/$base_name.pre-kit.md"

  if [ ! -e "$target_file" ]; then
    copy_file_safe "$src" "$target_file"
    store_installed_snapshot "$src" "$file_name"
    echo "installed-root"
    return 0
  fi

  if [ "${FORCE:-0}" = "1" ]; then
    mkdir -p "$backup_dir"
    cp -f "$target_file" "$backup_target"
    copy_file_safe "$src" "$target_file" 1
    store_installed_snapshot "$src" "$file_name"
    echo "overwrote-root"
    return 0
  fi

  copy_file_safe "$src" "$template_target" 1
  remove_installed_snapshot "$file_name"
  echo "preserved-root"
}

write_project_doc_summary() {
  local file_name="$1"
  local result="$2"
  local base_name="${file_name%.md}"

  if [ "$result" = "installed-root" ]; then
    echo "- $file_name"
  elif [ "$result" = "overwrote-root" ]; then
    echo "- $file_name (existing file overwritten)"
    echo "- .agent-kit/backups/$base_name.pre-kit.md"
  else
    echo "- $file_name preserved"
    echo "- .agent-kit/$base_name.template.md"
  fi
}

write_install_state() {
  local mode="$1"
  local agent_state="$2"
  local memory_state="$3"
  local changelog_state="$4"
  local skills_csv="${5:-}"

  cat > "$AGENT_KIT_DIR/install-state.env" <<EOF
MANIFEST_VERSION=1
MODE=$mode
AGENTS_STATE=$agent_state
MEMORY_STATE=$memory_state
CHANGELOG_STATE=$changelog_state
SKILLS=$skills_csv
EOF
}

portable_skill_files() {
  find "$SKILLS_SOURCE_DIR" -maxdepth 1 -type f ! -name 'README.md' -print | sort
}

remove_known_portable_skills() {
  local target_dir="$1"
  if [ ! -d "$target_dir" ]; then
    return 0
  fi

  while read -r file; do
    [ -n "$file" ] || continue
    rm -f "$target_dir/$(basename "$file")"
  done < <(portable_skill_files)

  if [ -d "$target_dir" ] && [ -z "$(find "$target_dir" -mindepth 1 -print -quit)" ]; then
    rmdir "$target_dir"
  fi
}

remove_direct_mode_artifacts() {
  rm -f "$AGENT_KIT_DIR/ROLES.md" "$AGENT_KIT_DIR/WORKFLOW.md"
  remove_known_portable_skills "$AGENT_KIT_DIR/skills"
}

case "$MODE" in
  direct)
    agent_result="$(install_agent_file "$KIT_ROOT/AGENTS.md")"
    memory_result="$(install_project_doc "$MEMORY_SOURCE" "MEMORY.md")"
    changelog_result="$(install_project_doc "$CHANGELOG_SOURCE" "CHANGELOG.md")"
    remove_direct_mode_artifacts
    write_install_state "direct" "$agent_result" "$memory_result" "$changelog_result"

    echo "Installed direct daily-driver kit to $TARGET_ROOT"
    if [ "$agent_result" = "installed-root" ]; then
      echo "- AGENTS.md"
    elif [ "$agent_result" = "overwrote-root" ]; then
      echo "- AGENTS.md (existing file overwritten)"
      echo "- .agent-kit/backups/AGENTS.pre-kit.md"
    else
      echo "- AGENTS.md preserved"
      echo "- .agent-kit/AGENTS.portable.md"
      echo "- .agent-kit/AGENTS.integration.md"
    fi
    write_project_doc_summary "MEMORY.md" "$memory_result"
    write_project_doc_summary "CHANGELOG.md" "$changelog_result"
    echo "- .agent-kit/install-state.env"
    ;;
  modular)
    agent_result="$(install_agent_file "$KIT_ROOT/templates/PROJECT_AGENT_INSTRUCTIONS.md")"
    memory_result="$(install_project_doc "$MEMORY_SOURCE" "MEMORY.md")"
    changelog_result="$(install_project_doc "$CHANGELOG_SOURCE" "CHANGELOG.md")"
    copy_file_safe "$KIT_ROOT/ROLES.md" "$AGENT_KIT_DIR/ROLES.md" 1
    copy_file_safe "$KIT_ROOT/WORKFLOW.md" "$AGENT_KIT_DIR/WORKFLOW.md" 1
    mkdir -p "$AGENT_KIT_DIR/skills"

    available_skill_files=()
    while read -r file; do
      [ -n "$file" ] || continue
      available_skill_files+=("$file")
    done < <(portable_skill_files)

    selected_skill_files=()
    if [ "${#SKILL_FILTERS[@]}" -eq 0 ]; then
      selected_skill_files=("${available_skill_files[@]}")
    else
      for filter in "${SKILL_FILTERS[@]}"; do
        matched=0
        for file in "${available_skill_files[@]}"; do
          base="$(basename "$file")"
          skill_name="$(printf '%s' "$base" | sed -E 's/^[0-9]+-//; s/\.md$//')"
          if [ "$skill_name" = "$filter" ]; then
            matched=1
            selected_skill_files+=("$file")
          fi
        done
        if [ "$matched" -eq 0 ]; then
          echo "No skill file matched '$filter'. Use an exact portable skill name such as miica-plan, miica-fix-issue, miica-documentation, miica-knowledge, miica-analyse, or miica-implementation." >&2
          exit 1
        fi
      done
    fi

    selected_csv=""
    for file in "${available_skill_files[@]}"; do
      base="$(basename "$file")"
      keep=0
      for selected in "${selected_skill_files[@]}"; do
        if [ "$(basename "$selected")" = "$base" ]; then
          keep=1
          break
        fi
      done
      if [ "$keep" = "0" ]; then
        rm -f "$AGENT_KIT_DIR/skills/$base"
      fi
    done

    for file in "${selected_skill_files[@]}"; do
      base="$(basename "$file")"
      copy_file_safe "$file" "$AGENT_KIT_DIR/skills/$base" 1
      if [ -n "$selected_csv" ]; then
        selected_csv+=","
      fi
      selected_csv+="$base"
    done

    write_install_state "modular" "$agent_result" "$memory_result" "$changelog_result" "$selected_csv"

    echo "Installed modular agent kit to $TARGET_ROOT"
    if [ "$agent_result" = "installed-root" ]; then
      echo "- AGENTS.md"
    elif [ "$agent_result" = "overwrote-root" ]; then
      echo "- AGENTS.md (existing file overwritten)"
      echo "- .agent-kit/backups/AGENTS.pre-kit.md"
    else
      echo "- AGENTS.md preserved"
      echo "- .agent-kit/AGENTS.portable.md"
      echo "- .agent-kit/AGENTS.integration.md"
    fi
    write_project_doc_summary "MEMORY.md" "$memory_result"
    write_project_doc_summary "CHANGELOG.md" "$changelog_result"
    echo "- .agent-kit/ROLES.md"
    echo "- .agent-kit/WORKFLOW.md"
    echo "- .agent-kit/skills/"
    echo "- .agent-kit/install-state.env"
    ;;
  *)
    echo "Unknown mode: $MODE" >&2
    echo "Use 'direct' or 'modular'." >&2
    exit 1
    ;;
esac
