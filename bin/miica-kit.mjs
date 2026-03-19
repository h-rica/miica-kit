#!/usr/bin/env node

import { copyFileSync, cpSync, existsSync, mkdirSync, readdirSync, readFileSync, rmSync, writeFileSync } from "node:fs";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { homedir } from "node:os";

const scriptPath = fileURLToPath(import.meta.url);
const binDir = dirname(scriptPath);
const kitRoot = resolve(binDir, "..");

function fail(message) {
  console.error(message);
  process.exit(1);
}

function usage() {
  console.log(`miica-kit

Usage:
  miica-kit install-kit [target] [--mode direct|modular] [--skills miica-plan,miica-knowledge] [--force]
  miica-kit uninstall-kit [target]
  miica-kit install-codex-skills [target-dir] [--skills miica-plan,miica-fix-issue,miica-knowledge] [--force]
  miica-kit uninstall-codex-skills [target-dir] [--skills miica-plan,miica-fix-issue,miica-knowledge]
  miica-kit install-claude-skills [target-dir] [--skills miica-plan,miica-fix-issue,miica-knowledge] [--force]
  miica-kit uninstall-claude-skills [target-dir] [--skills miica-plan,miica-fix-issue,miica-knowledge]
  miica-kit install-agent-skills [target-dir] [--skills miica-plan,miica-fix-issue,miica-knowledge] [--force]
  miica-kit uninstall-agent-skills [target-dir] [--skills miica-plan,miica-fix-issue,miica-knowledge]
  miica-kit help

Notes:
  - install-kit and uninstall-kit default to the current working directory when no target is provided.
  - install-codex-skills defaults to $CODEX_HOME/skills or ~/.codex/skills.
  - uninstall-codex-skills removes only kit-managed miica skill folders.
  - install-claude-skills defaults to $CLAUDE_HOME/skills or ~/.claude/skills.
  - uninstall-claude-skills removes only kit-managed miica skill folders.
  - install-agent-skills defaults to $AGENTS_HOME/skills or ~/.agents/skills.
  - uninstall-agent-skills removes only kit-managed miica skill folders.
`);
}

function readValue(args, index, flag) {
  const value = args[index + 1];
  if (!value || value.startsWith("-")) {
    fail(`Missing value for ${flag}.`);
  }
  return value;
}

function parseList(value) {
  return value
    .split(",")
    .map((item) => item.trim())
    .filter(Boolean);
}

function unique(values) {
  return [...new Set(values)];
}

function parseInstallKitArgs(args) {
  const options = {
    targetPath: process.cwd(),
    mode: "direct",
    skills: [],
    force: false,
  };
  const positional = [];

  for (let i = 0; i < args.length; i += 1) {
    const arg = args[i];

    if (arg === "--help" || arg === "-h") {
      usage();
      process.exit(0);
    }
    if (arg === "--force") {
      options.force = true;
      continue;
    }
    if (arg === "--target" || arg === "--target-path") {
      options.targetPath = readValue(args, i, arg);
      i += 1;
      continue;
    }
    if (arg.startsWith("--target=")) {
      options.targetPath = arg.slice("--target=".length);
      continue;
    }
    if (arg.startsWith("--target-path=")) {
      options.targetPath = arg.slice("--target-path=".length);
      continue;
    }
    if (arg === "--mode") {
      options.mode = readValue(args, i, arg);
      i += 1;
      continue;
    }
    if (arg.startsWith("--mode=")) {
      options.mode = arg.slice("--mode=".length);
      continue;
    }
    if (arg === "--skill") {
      options.skills.push(readValue(args, i, arg));
      i += 1;
      continue;
    }
    if (arg.startsWith("--skill=")) {
      options.skills.push(arg.slice("--skill=".length));
      continue;
    }
    if (arg === "--skills") {
      options.skills.push(...parseList(readValue(args, i, arg)));
      i += 1;
      continue;
    }
    if (arg.startsWith("--skills=")) {
      options.skills.push(...parseList(arg.slice("--skills=".length)));
      continue;
    }
    if (arg.startsWith("-")) {
      fail(`Unknown option: ${arg}`);
    }

    positional.push(arg);
  }

  if (positional.length > 0) {
    options.targetPath = positional[0];
    if (positional.length > 1) {
      options.skills.push(...positional.slice(1));
    }
  }

  if (!["direct", "modular"].includes(options.mode)) {
    fail(`Unknown mode: ${options.mode}. Use direct or modular.`);
  }

  options.skills = unique(options.skills.map((item) => item.toLowerCase()));
  return options;
}

function parseTargetArgs(args) {
  const options = {
    targetPath: process.cwd(),
  };
  const positional = [];

  for (let i = 0; i < args.length; i += 1) {
    const arg = args[i];

    if (arg === "--help" || arg === "-h") {
      usage();
      process.exit(0);
    }
    if (arg === "--target" || arg === "--target-path") {
      options.targetPath = readValue(args, i, arg);
      i += 1;
      continue;
    }
    if (arg.startsWith("--target=")) {
      options.targetPath = arg.slice("--target=".length);
      continue;
    }
    if (arg.startsWith("--target-path=")) {
      options.targetPath = arg.slice("--target-path=".length);
      continue;
    }
    if (arg.startsWith("-")) {
      fail(`Unknown option: ${arg}`);
    }

    positional.push(arg);
  }

  if (positional.length > 0) {
    options.targetPath = positional[0];
  }

  return options;
}

function parseSkillArgs(args) {
  const options = {
    targetDir: "",
    skills: [],
    force: false,
  };
  const positional = [];

  for (let i = 0; i < args.length; i += 1) {
    const arg = args[i];

    if (arg === "--help" || arg === "-h") {
      usage();
      process.exit(0);
    }
    if (arg === "--force") {
      options.force = true;
      continue;
    }
    if (arg === "--target" || arg === "--target-dir") {
      options.targetDir = readValue(args, i, arg);
      i += 1;
      continue;
    }
    if (arg.startsWith("--target=")) {
      options.targetDir = arg.slice("--target=".length);
      continue;
    }
    if (arg.startsWith("--target-dir=")) {
      options.targetDir = arg.slice("--target-dir=".length);
      continue;
    }
    if (arg === "--skill") {
      options.skills.push(readValue(args, i, arg));
      i += 1;
      continue;
    }
    if (arg.startsWith("--skill=")) {
      options.skills.push(arg.slice("--skill=".length));
      continue;
    }
    if (arg === "--skills") {
      options.skills.push(...parseList(readValue(args, i, arg)));
      i += 1;
      continue;
    }
    if (arg.startsWith("--skills=")) {
      options.skills.push(...parseList(arg.slice("--skills=".length)));
      continue;
    }
    if (arg.startsWith("-")) {
      fail(`Unknown option: ${arg}`);
    }

    positional.push(arg);
  }

  if (positional.length > 0) {
    options.targetDir = positional[0];
    if (positional.length > 1) {
      options.skills.push(...positional.slice(1));
    }
  }

  options.skills = unique(options.skills.map((item) => item.toLowerCase()));
  return options;
}

function ensureDir(path) {
  mkdirSync(path, { recursive: true });
}

function copyFileSafe(source, destination, overwrite = false) {
  ensureDir(dirname(destination));
  if (existsSync(destination) && !overwrite) {
    fail(`Destination already exists: ${destination}. Re-run with --force to overwrite.`);
  }
  copyFileSync(source, destination);
}

function syncFile(source, destination) {
  copyFileSafe(source, destination, true);
}

function copyDirectorySafe(source, destination, overwrite = false) {
  ensureDir(dirname(destination));
  if (existsSync(destination)) {
    if (!overwrite) {
      fail(`Destination already exists: ${destination}. Re-run with --force to overwrite.`);
    }
    rmSync(destination, { recursive: true, force: true });
  }
  cpSync(source, destination, { recursive: true });
}

function removePathIfExists(path) {
  if (!existsSync(path)) {
    return false;
  }
  rmSync(path, { recursive: true, force: true });
  return true;
}

function removeDirectoryIfEmpty(path) {
  if (existsSync(path) && readdirSync(path).length === 0) {
    rmSync(path, { recursive: true, force: true });
  }
}

function filesEqual(pathA, pathB) {
  if (!existsSync(pathA) || !existsSync(pathB)) {
    return false;
  }
  return readFileSync(pathA).equals(readFileSync(pathB));
}

function readInstallState(targetRoot) {
  const manifestPath = join(targetRoot, ".agent-kit", "install-state.env");
  if (!existsSync(manifestPath)) {
    return null;
  }

  const state = {};
  for (const line of readFileSync(manifestPath, "utf8").split(/\r?\n/)) {
    if (!line || !line.includes("=")) {
      continue;
    }
    const separator = line.indexOf("=");
    const key = line.slice(0, separator);
    const value = line.slice(separator + 1);
    state[key] = value;
  }
  return state;
}

function writeInstallState({ targetRoot, mode, agentState, memoryState, changelogState, skillFiles }) {
  const manifestPath = join(targetRoot, ".agent-kit", "install-state.env");
  ensureDir(dirname(manifestPath));
  const content = [
    "MANIFEST_VERSION=1",
    `MODE=${mode}`,
    `AGENTS_STATE=${agentState}`,
    `MEMORY_STATE=${memoryState}`,
    `CHANGELOG_STATE=${changelogState}`,
    `SKILLS=${unique(skillFiles).join(",")}`,
    "",
  ].join("\n");
  writeFileSync(manifestPath, content, "utf8");
}

function writeAgentIntegrationNote(path, targetRoot) {
  const content = `# Agent Kit Integration Note

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
${targetRoot}
`;

  ensureDir(dirname(path));
  writeFileSync(path, content, "utf8");
}

function storeInstalledSnapshot({ source, targetRoot, fileName }) {
  const installedDir = join(targetRoot, ".agent-kit", "installed");
  ensureDir(installedDir);
  copyFileSync(source, join(installedDir, fileName));
}

function removeInstalledSnapshot({ targetRoot, fileName }) {
  removePathIfExists(join(targetRoot, ".agent-kit", "installed", fileName));
}

function installAgentFile({ source, targetRoot, overwrite }) {
  const targetAgents = join(targetRoot, "AGENTS.md");
  const agentKitDir = join(targetRoot, ".agent-kit");
  const portableAgents = join(agentKitDir, "AGENTS.portable.md");
  const integrationNote = join(agentKitDir, "AGENTS.integration.md");
  const backupDir = join(agentKitDir, "backups");

  if (!existsSync(targetAgents)) {
    copyFileSafe(source, targetAgents, overwrite);
    storeInstalledSnapshot({ source, targetRoot, fileName: "AGENTS.root.md" });
    return "installed-root";
  }

  if (overwrite) {
    ensureDir(backupDir);
    copyFileSync(targetAgents, join(backupDir, "AGENTS.pre-kit.md"));
    copyFileSafe(source, targetAgents, true);
    storeInstalledSnapshot({ source, targetRoot, fileName: "AGENTS.root.md" });
    return "overwrote-root";
  }

  syncFile(source, portableAgents);
  writeAgentIntegrationNote(integrationNote, targetRoot);
  removeInstalledSnapshot({ targetRoot, fileName: "AGENTS.root.md" });
  return "preserved-root";
}

function installProjectDoc({ source, targetRoot, fileName, overwrite }) {
  const targetFile = join(targetRoot, fileName);
  const agentKitDir = join(targetRoot, ".agent-kit");
  const baseName = fileName.replace(/\.md$/, "");
  const templateTarget = join(agentKitDir, `${baseName}.template.md`);
  const backupDir = join(agentKitDir, "backups");
  const backupTarget = join(backupDir, `${baseName}.pre-kit.md`);

  if (!existsSync(targetFile)) {
    copyFileSafe(source, targetFile, overwrite);
    storeInstalledSnapshot({ source, targetRoot, fileName });
    return "installed-root";
  }

  if (overwrite) {
    ensureDir(backupDir);
    copyFileSync(targetFile, backupTarget);
    copyFileSafe(source, targetFile, true);
    storeInstalledSnapshot({ source, targetRoot, fileName });
    return "overwrote-root";
  }

  syncFile(source, templateTarget);
  removeInstalledSnapshot({ targetRoot, fileName });
  return "preserved-root";
}

function writeProjectDocSummary(fileName, result) {
  const baseName = fileName.replace(/\.md$/, "");

  if (result === "installed-root") {
    console.log(`- ${fileName}`);
  } else if (result === "overwrote-root") {
    console.log(`- ${fileName} (existing file overwritten)`);
    console.log(`- .agent-kit/backups/${baseName}.pre-kit.md`);
  } else {
    console.log(`- ${fileName} preserved`);
    console.log(`- .agent-kit/${baseName}.template.md`);
  }
}

function portableSkillName(fileName) {
  return fileName.replace(/^[0-9]+-/, "").replace(/\.md$/, "").toLowerCase();
}

function getPortableSkillFiles() {
  return readdirSync(join(kitRoot, "skills"))
    .filter((file) => file.endsWith(".md") && file !== "README.md")
    .sort();
}

function removeKnownPortableSkillFiles(skillsDir) {
  const removed = [];
  for (const file of getPortableSkillFiles()) {
    const target = join(skillsDir, file);
    if (removePathIfExists(target)) {
      removed.push(file);
    }
  }
  return removed;
}

function cleanupDirectModeArtifacts(targetRoot) {
  const agentKitDir = join(targetRoot, ".agent-kit");
  const skillsDir = join(agentKitDir, "skills");
  removePathIfExists(join(agentKitDir, "ROLES.md"));
  removePathIfExists(join(agentKitDir, "WORKFLOW.md"));
  removeKnownPortableSkillFiles(skillsDir);
  removeDirectoryIfEmpty(skillsDir);
}

function installKit(options) {
  const targetRoot = resolve(options.targetPath);
  ensureDir(targetRoot);
  ensureDir(join(targetRoot, ".agent-kit"));

  const memorySource = join(kitRoot, "templates", "PROJECT_MEMORY.md");
  const changelogSource = join(kitRoot, "templates", "PROJECT_CHANGELOG.md");

  if (options.mode === "direct") {
    const agentResult = installAgentFile({
      source: join(kitRoot, "AGENTS.md"),
      targetRoot,
      overwrite: options.force,
    });
    const memoryResult = installProjectDoc({
      source: memorySource,
      targetRoot,
      fileName: "MEMORY.md",
      overwrite: options.force,
    });
    const changelogResult = installProjectDoc({
      source: changelogSource,
      targetRoot,
      fileName: "CHANGELOG.md",
      overwrite: options.force,
    });

    cleanupDirectModeArtifacts(targetRoot);
    writeInstallState({
      targetRoot,
      mode: "direct",
      agentState: agentResult,
      memoryState: memoryResult,
      changelogState: changelogResult,
      skillFiles: [],
    });

    console.log(`Installed direct daily-driver kit to ${targetRoot}`);
    if (agentResult === "installed-root") {
      console.log("- AGENTS.md");
    } else if (agentResult === "overwrote-root") {
      console.log("- AGENTS.md (existing file overwritten)");
      console.log("- .agent-kit/backups/AGENTS.pre-kit.md");
    } else {
      console.log("- AGENTS.md preserved");
      console.log("- .agent-kit/AGENTS.portable.md");
      console.log("- .agent-kit/AGENTS.integration.md");
    }
    writeProjectDocSummary("MEMORY.md", memoryResult);
    writeProjectDocSummary("CHANGELOG.md", changelogResult);
    console.log("- .agent-kit/install-state.env");
    return;
  }

  const agentResult = installAgentFile({
    source: join(kitRoot, "templates", "PROJECT_AGENT_INSTRUCTIONS.md"),
    targetRoot,
    overwrite: options.force,
  });
  const memoryResult = installProjectDoc({
    source: memorySource,
    targetRoot,
    fileName: "MEMORY.md",
    overwrite: options.force,
  });
  const changelogResult = installProjectDoc({
    source: changelogSource,
    targetRoot,
    fileName: "CHANGELOG.md",
    overwrite: options.force,
  });
  const agentKitDir = join(targetRoot, ".agent-kit");
  const skillsTargetDir = join(agentKitDir, "skills");

  syncFile(join(kitRoot, "ROLES.md"), join(agentKitDir, "ROLES.md"));
  syncFile(join(kitRoot, "WORKFLOW.md"), join(agentKitDir, "WORKFLOW.md"));
  ensureDir(skillsTargetDir);

  const availableSkillFiles = getPortableSkillFiles();
  const selectedSkillFiles = options.skills.length === 0
    ? availableSkillFiles
    : options.skills.map((wanted) => {
        const match = availableSkillFiles.find((file) => portableSkillName(file) === wanted);
        if (!match) {
          fail(`No skill file matched '${wanted}'. Use exact portable skill names such as miica-plan, miica-fix-issue, miica-documentation, miica-knowledge, miica-analyse, or miica-implementation.`);
        }
        return match;
      });
  const uniqueSelectedSkillFiles = unique(selectedSkillFiles);

  for (const file of availableSkillFiles) {
    if (!uniqueSelectedSkillFiles.includes(file)) {
      removePathIfExists(join(skillsTargetDir, file));
    }
  }
  for (const file of uniqueSelectedSkillFiles) {
    syncFile(join(kitRoot, "skills", file), join(skillsTargetDir, file));
  }

  writeInstallState({
    targetRoot,
    mode: "modular",
    agentState: agentResult,
    memoryState: memoryResult,
    changelogState: changelogResult,
    skillFiles: uniqueSelectedSkillFiles,
  });

  console.log(`Installed modular agent kit to ${targetRoot}`);
  if (agentResult === "installed-root") {
    console.log("- AGENTS.md");
  } else if (agentResult === "overwrote-root") {
    console.log("- AGENTS.md (existing file overwritten)");
    console.log("- .agent-kit/backups/AGENTS.pre-kit.md");
  } else {
    console.log("- AGENTS.md preserved");
    console.log("- .agent-kit/AGENTS.portable.md");
    console.log("- .agent-kit/AGENTS.integration.md");
  }
  writeProjectDocSummary("MEMORY.md", memoryResult);
  writeProjectDocSummary("CHANGELOG.md", changelogResult);
  console.log("- .agent-kit/ROLES.md");
  console.log("- .agent-kit/WORKFLOW.md");
  console.log("- .agent-kit/skills/");
  console.log("- .agent-kit/install-state.env");
}

function uninstallKit(options) {
  const targetRoot = resolve(options.targetPath);
  const agentKitDir = join(targetRoot, ".agent-kit");
  const installedDir = join(agentKitDir, "installed");
  const backupsDir = join(agentKitDir, "backups");
  const skillsDir = join(agentKitDir, "skills");
  const manifestPath = join(agentKitDir, "install-state.env");

  if (!existsSync(targetRoot)) {
    console.log(`No project directory found at ${targetRoot}`);
    return;
  }

  const manifest = readInstallState(targetRoot);
  const actions = [];
  const warnings = [];
  let touched = false;
  let blockedRootRecovery = false;

  function handleRootDoc(fileName, stateKey) {
    const state = manifest?.[stateKey];
    if (!state) {
      return;
    }

    const targetFile = join(targetRoot, fileName);
    const snapshotFile = join(installedDir, fileName === "AGENTS.md" ? "AGENTS.root.md" : fileName);
    const baseName = fileName.replace(/\.md$/, "");
    const backupFile = join(backupsDir, `${baseName}.pre-kit.md`);

    if (state === "installed-root") {
      if (!existsSync(targetFile)) {
        return;
      }
      if (filesEqual(targetFile, snapshotFile)) {
        rmSync(targetFile, { force: true });
        actions.push(`${fileName} removed`);
        touched = true;
      } else {
        warnings.push(`${fileName} was installed by the kit but changed after installation, so it was left in place.`);
        blockedRootRecovery = true;
      }
      return;
    }

    if (state === "overwrote-root") {
      if (existsSync(targetFile) && existsSync(snapshotFile) && !filesEqual(targetFile, snapshotFile)) {
        warnings.push(`${fileName} was overwritten by the kit and later modified, so the backup was left in .agent-kit/backups for manual restore.`);
        blockedRootRecovery = true;
        return;
      }
      if (existsSync(backupFile)) {
        ensureDir(dirname(targetFile));
        copyFileSync(backupFile, targetFile);
        actions.push(`${fileName} restored from .agent-kit/backups/${baseName}.pre-kit.md`);
        touched = true;
      } else {
        warnings.push(`Backup for ${fileName} is missing, so the current file was left in place.`);
        blockedRootRecovery = true;
      }
    }
  }

  if (manifest) {
    handleRootDoc("AGENTS.md", "AGENTS_STATE");
    handleRootDoc("MEMORY.md", "MEMORY_STATE");
    handleRootDoc("CHANGELOG.md", "CHANGELOG_STATE");
  } else if (existsSync(agentKitDir)) {
    warnings.push("No install-state manifest was found, so root AGENTS.md, MEMORY.md, and CHANGELOG.md were left untouched.");
  }

  for (const file of [
    "AGENTS.portable.md",
    "AGENTS.integration.md",
    "MEMORY.template.md",
    "CHANGELOG.template.md",
    "ROLES.md",
    "WORKFLOW.md",
  ]) {
    if (removePathIfExists(join(agentKitDir, file))) {
      actions.push(`.agent-kit/${file} removed`);
      touched = true;
    }
  }

  for (const file of removeKnownPortableSkillFiles(skillsDir)) {
    actions.push(`.agent-kit/skills/${file} removed`);
    touched = true;
  }
  removeDirectoryIfEmpty(skillsDir);

  if (manifest && !blockedRootRecovery) {
    if (removePathIfExists(installedDir)) {
      touched = true;
    }
    if (removePathIfExists(manifestPath)) {
      touched = true;
      actions.push(`.agent-kit/install-state.env removed`);
    }
    if (removePathIfExists(backupsDir)) {
      touched = true;
    }
  } else if (blockedRootRecovery) {
    warnings.push("The install state and backups were kept under .agent-kit so you can finish cleanup manually.");
  }

  removeDirectoryIfEmpty(join(agentKitDir, "installed"));
  removeDirectoryIfEmpty(join(agentKitDir, "backups"));
  removeDirectoryIfEmpty(agentKitDir);

  if (!touched && warnings.length === 0) {
    console.log(`No installed project-local kit elements were found in ${targetRoot}`);
    return;
  }

  console.log(`Uninstalled project-local kit from ${targetRoot}`);
  for (const action of actions) {
    console.log(`- ${action}`);
  }
  for (const warning of warnings) {
    console.log(`! ${warning}`);
  }
}

function availableInstallableSkills(sourceDirName) {
  return readdirSync(join(kitRoot, sourceDirName))
    .filter((entry) => existsSync(join(kitRoot, sourceDirName, entry, "SKILL.md")))
    .sort();
}

function selectInstallableSkills(requested, label, sourceDirName) {
  const available = availableInstallableSkills(sourceDirName);
  if (requested.length === 0) {
    return available;
  }

  return requested.map((wanted) => {
    const match = available.find((entry) => entry === wanted);
    if (!match) {
      fail(`No ${label} skill matched '${wanted}'. Use exact names like miica-plan, miica-fix-issue, miica-documentation, miica-knowledge, miica-analyse, or miica-implementation.`);
    }
    return match;
  });
}

function installCodexSkills(options) {
  const codexHome = process.env.CODEX_HOME ? process.env.CODEX_HOME : join(homedir(), ".codex");
  const targetDir = resolve(options.targetDir || join(codexHome, "skills"));
  ensureDir(targetDir);

  const selected = unique(selectInstallableSkills(options.skills, "Codex", "codex-skills"));

  for (const entry of selected) {
    copyDirectorySafe(join(kitRoot, "codex-skills", entry), join(targetDir, entry), options.force);
  }

  console.log(`Installed Codex skills to ${targetDir}`);
  for (const entry of selected) {
    console.log(`- ${entry}`);
  }
}

function uninstallCodexSkills(options) {
  const codexHome = process.env.CODEX_HOME ? process.env.CODEX_HOME : join(homedir(), ".codex");
  const targetDir = resolve(options.targetDir || join(codexHome, "skills"));
  const selected = unique(selectInstallableSkills(options.skills, "Codex", "codex-skills"));
  const removed = [];

  for (const entry of selected) {
    if (removePathIfExists(join(targetDir, entry))) {
      removed.push(entry);
    }
  }

  if (removed.length === 0) {
    console.log(`No kit-managed Codex skills were found in ${targetDir}`);
    return;
  }

  console.log(`Uninstalled Codex skills from ${targetDir}`);
  for (const entry of removed) {
    console.log(`- ${entry}`);
  }
}

function installClaudeSkills(options) {
  const claudeHome = process.env.CLAUDE_HOME ? process.env.CLAUDE_HOME : join(homedir(), ".claude");
  const targetDir = resolve(options.targetDir || join(claudeHome, "skills"));
  ensureDir(targetDir);

  const selected = unique(selectInstallableSkills(options.skills, "Claude", "claude-skills"));

  for (const entry of selected) {
    copyDirectorySafe(join(kitRoot, "claude-skills", entry), join(targetDir, entry), options.force);
  }

  console.log(`Installed Claude skills to ${targetDir}`);
  for (const entry of selected) {
    console.log(`- ${entry}`);
  }
}

function uninstallClaudeSkills(options) {
  const claudeHome = process.env.CLAUDE_HOME ? process.env.CLAUDE_HOME : join(homedir(), ".claude");
  const targetDir = resolve(options.targetDir || join(claudeHome, "skills"));
  const selected = unique(selectInstallableSkills(options.skills, "Claude", "claude-skills"));
  const removed = [];

  for (const entry of selected) {
    if (removePathIfExists(join(targetDir, entry))) {
      removed.push(entry);
    }
  }

  if (removed.length === 0) {
    console.log(`No kit-managed Claude skills were found in ${targetDir}`);
    return;
  }

  console.log(`Uninstalled Claude skills from ${targetDir}`);
  for (const entry of removed) {
    console.log(`- ${entry}`);
  }
}

function installAgentSkills(options) {
  const agentsHome = process.env.AGENTS_HOME ? process.env.AGENTS_HOME : join(homedir(), ".agents");
  const targetDir = resolve(options.targetDir || join(agentsHome, "skills"));
  ensureDir(targetDir);

  const selected = unique(selectInstallableSkills(options.skills, "agent", "codex-skills"));

  for (const entry of selected) {
    copyDirectorySafe(join(kitRoot, "codex-skills", entry), join(targetDir, entry), options.force);
  }

  console.log(`Installed agent skills to ${targetDir}`);
  for (const entry of selected) {
    console.log(`- ${entry}`);
  }
}

function uninstallAgentSkills(options) {
  const agentsHome = process.env.AGENTS_HOME ? process.env.AGENTS_HOME : join(homedir(), ".agents");
  const targetDir = resolve(options.targetDir || join(agentsHome, "skills"));
  const selected = unique(selectInstallableSkills(options.skills, "agent", "codex-skills"));
  const removed = [];

  for (const entry of selected) {
    if (removePathIfExists(join(targetDir, entry))) {
      removed.push(entry);
    }
  }

  if (removed.length === 0) {
    console.log(`No kit-managed agent skills were found in ${targetDir}`);
    return;
  }

  console.log(`Uninstalled agent skills from ${targetDir}`);
  for (const entry of removed) {
    console.log(`- ${entry}`);
  }
}

const [command, ...rest] = process.argv.slice(2);

if (!command || command === "help" || command === "--help" || command === "-h") {
  usage();
  process.exit(0);
}

if (command === "install-kit" || command === "install") {
  installKit(parseInstallKitArgs(rest));
} else if (command === "uninstall-kit" || command === "uninstall") {
  uninstallKit(parseTargetArgs(rest));
} else if (command === "install-codex-skills" || command === "install-codex") {
  installCodexSkills(parseSkillArgs(rest));
} else if (command === "uninstall-codex-skills" || command === "uninstall-codex") {
  uninstallCodexSkills(parseSkillArgs(rest));
} else if (command === "install-claude-skills" || command === "install-claude") {
  installClaudeSkills(parseSkillArgs(rest));
} else if (command === "uninstall-claude-skills" || command === "uninstall-claude") {
  uninstallClaudeSkills(parseSkillArgs(rest));
} else if (command === "install-agent-skills" || command === "install-agents") {
  installAgentSkills(parseSkillArgs(rest));
} else if (command === "uninstall-agent-skills" || command === "uninstall-agents") {
  uninstallAgentSkills(parseSkillArgs(rest));
} else {
  fail(`Unknown command: ${command}`);
}
