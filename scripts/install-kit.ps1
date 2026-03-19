param(
    [Parameter(Mandatory = $true)]
    [string]$TargetPath,

    [ValidateSet('direct', 'modular')]
    [string]$Mode = 'direct',

    [string[]]$Skills = @(),

    [switch]$Force
)

$ErrorActionPreference = 'Stop'

function Write-AgentIntegrationNote {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path,
        [Parameter(Mandatory = $true)]
        [string]$TargetRoot
    )

    $content = @"
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
Use ./.agent-kit/skills/ when a task maps cleanly to one of the public commands, especially miica-plan, miica-knowledge, miica-deep-dive, miica-analyse, miica-fix-issue, and miica-implementation.
Use ./MEMORY.md for durable project memory when the repository keeps one.
Keep ./CHANGELOG.md current for notable shipped changes.
If there is any conflict, the project-specific AGENTS.md rules win over the generic portable kit.

Target project:
$TargetRoot
"@

    $dir = Split-Path -Parent $Path
    if (-not (Test-Path -LiteralPath $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
    }

    Set-Content -LiteralPath $Path -Value $content
}

function Copy-FileSafe {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Source,
        [Parameter(Mandatory = $true)]
        [string]$Destination,
        [switch]$Overwrite
    )

    $destDir = Split-Path -Parent $Destination
    if (-not (Test-Path -LiteralPath $destDir)) {
        New-Item -ItemType Directory -Path $destDir -Force | Out-Null
    }

    if ((Test-Path -LiteralPath $Destination) -and -not $Overwrite) {
        throw "Destination already exists: $Destination. Re-run with -Force to overwrite."
    }

    Copy-Item -LiteralPath $Source -Destination $Destination -Force:$Overwrite
}

function Sync-File {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Source,
        [Parameter(Mandatory = $true)]
        [string]$Destination
    )

    Copy-FileSafe -Source $Source -Destination $Destination -Overwrite:$true
}

function Store-InstalledSnapshot {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Source,
        [Parameter(Mandatory = $true)]
        [string]$TargetRoot,
        [Parameter(Mandatory = $true)]
        [string]$FileName
    )

    $snapshotDir = Join-Path $TargetRoot '.agent-kit\installed'
    New-Item -ItemType Directory -Path $snapshotDir -Force | Out-Null
    Copy-Item -LiteralPath $Source -Destination (Join-Path $snapshotDir $FileName) -Force
}

function Remove-InstalledSnapshot {
    param(
        [Parameter(Mandatory = $true)]
        [string]$TargetRoot,
        [Parameter(Mandatory = $true)]
        [string]$FileName
    )

    $snapshotPath = Join-Path $TargetRoot (Join-Path '.agent-kit\installed' $FileName)
    if (Test-Path -LiteralPath $snapshotPath) {
        Remove-Item -LiteralPath $snapshotPath -Force
    }
}

function Install-AgentFile {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Source,
        [Parameter(Mandatory = $true)]
        [string]$TargetRoot,
        [switch]$Overwrite
    )

    $targetAgents = Join-Path $TargetRoot 'AGENTS.md'
    $agentKitDir = Join-Path $TargetRoot '.agent-kit'
    $portableAgents = Join-Path $agentKitDir 'AGENTS.portable.md'
    $integrationNote = Join-Path $agentKitDir 'AGENTS.integration.md'
    $backupDir = Join-Path $agentKitDir 'backups'

    if (-not (Test-Path -LiteralPath $targetAgents)) {
        Copy-FileSafe -Source $Source -Destination $targetAgents -Overwrite:$Overwrite
        Store-InstalledSnapshot -Source $Source -TargetRoot $TargetRoot -FileName 'AGENTS.root.md'
        return 'installed-root'
    }

    if ($Overwrite) {
        New-Item -ItemType Directory -Path $backupDir -Force | Out-Null
        Copy-Item -LiteralPath $targetAgents -Destination (Join-Path $backupDir 'AGENTS.pre-kit.md') -Force
        Copy-FileSafe -Source $Source -Destination $targetAgents -Overwrite:$true
        Store-InstalledSnapshot -Source $Source -TargetRoot $TargetRoot -FileName 'AGENTS.root.md'
        return 'overwrote-root'
    }

    Copy-FileSafe -Source $Source -Destination $portableAgents -Overwrite:$true
    Write-AgentIntegrationNote -Path $integrationNote -TargetRoot $TargetRoot
    Remove-InstalledSnapshot -TargetRoot $TargetRoot -FileName 'AGENTS.root.md'
    return 'preserved-root'
}

function Install-ProjectDoc {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Source,
        [Parameter(Mandatory = $true)]
        [string]$TargetRoot,
        [Parameter(Mandatory = $true)]
        [string]$FileName,
        [switch]$Overwrite
    )

    $targetFile = Join-Path $TargetRoot $FileName
    $agentKitDir = Join-Path $TargetRoot '.agent-kit'
    $backupDir = Join-Path $agentKitDir 'backups'
    $baseName = [System.IO.Path]::GetFileNameWithoutExtension($FileName)
    $templateTarget = Join-Path $agentKitDir ($baseName + '.template.md')
    $backupTarget = Join-Path $backupDir ($baseName + '.pre-kit.md')

    if (-not (Test-Path -LiteralPath $targetFile)) {
        Copy-FileSafe -Source $Source -Destination $targetFile -Overwrite:$Overwrite
        Store-InstalledSnapshot -Source $Source -TargetRoot $TargetRoot -FileName $FileName
        return 'installed-root'
    }

    if ($Overwrite) {
        New-Item -ItemType Directory -Path $backupDir -Force | Out-Null
        Copy-Item -LiteralPath $targetFile -Destination $backupTarget -Force
        Copy-FileSafe -Source $Source -Destination $targetFile -Overwrite:$true
        Store-InstalledSnapshot -Source $Source -TargetRoot $TargetRoot -FileName $FileName
        return 'overwrote-root'
    }

    Copy-FileSafe -Source $Source -Destination $templateTarget -Overwrite:$true
    Remove-InstalledSnapshot -TargetRoot $TargetRoot -FileName $FileName
    return 'preserved-root'
}

function Write-ProjectDocSummary {
    param(
        [Parameter(Mandatory = $true)]
        [string]$FileName,
        [Parameter(Mandatory = $true)]
        [string]$Result
    )

    $baseName = [System.IO.Path]::GetFileNameWithoutExtension($FileName)

    if ($Result -eq 'installed-root') {
        Write-Host "- $FileName"
    } elseif ($Result -eq 'overwrote-root') {
        Write-Host "- $FileName (existing file overwritten)"
        Write-Host "- .agent-kit/backups/$baseName.pre-kit.md"
    } else {
        Write-Host "- $FileName preserved"
        Write-Host "- .agent-kit/$baseName.template.md"
    }
}

function Write-InstallState {
    param(
        [Parameter(Mandatory = $true)]
        [string]$TargetRoot,
        [Parameter(Mandatory = $true)]
        [string]$Mode,
        [Parameter(Mandatory = $true)]
        [string]$AgentState,
        [Parameter(Mandatory = $true)]
        [string]$MemoryState,
        [Parameter(Mandatory = $true)]
        [string]$ChangeLogState,
        [string[]]$SkillFiles = @()
    )

    $manifestPath = Join-Path $TargetRoot '.agent-kit\install-state.env'
    $content = @(
        'MANIFEST_VERSION=1',
        "MODE=$Mode",
        "AGENTS_STATE=$AgentState",
        "MEMORY_STATE=$MemoryState",
        "CHANGELOG_STATE=$ChangeLogState",
        ('SKILLS=' + ($SkillFiles -join ',')),
        ''
    )

    Set-Content -LiteralPath $manifestPath -Value $content
}

function Get-PortableSkillFiles {
    param(
        [Parameter(Mandatory = $true)]
        [string]$SkillsSourceDir
    )

    Get-ChildItem -LiteralPath $SkillsSourceDir -File | Where-Object { $_.Name -ne 'README.md' } | Sort-Object Name
}

function Remove-KnownPortableSkillFiles {
    param(
        [Parameter(Mandatory = $true)]
        [string]$SkillsSourceDir,
        [Parameter(Mandatory = $true)]
        [string]$SkillsTargetDir
    )

    foreach ($SkillFile in Get-PortableSkillFiles -SkillsSourceDir $SkillsSourceDir) {
        $targetFile = Join-Path $SkillsTargetDir $SkillFile.Name
        if (Test-Path -LiteralPath $targetFile) {
            Remove-Item -LiteralPath $targetFile -Force
        }
    }

    if ((Test-Path -LiteralPath $SkillsTargetDir) -and -not (Get-ChildItem -LiteralPath $SkillsTargetDir -Force)) {
        Remove-Item -LiteralPath $SkillsTargetDir -Force
    }
}

function Remove-DirectModeArtifacts {
    param(
        [Parameter(Mandatory = $true)]
        [string]$TargetRoot,
        [Parameter(Mandatory = $true)]
        [string]$SkillsSourceDir
    )

    $agentKitDir = Join-Path $TargetRoot '.agent-kit'
    $skillsTargetDir = Join-Path $agentKitDir 'skills'

    foreach ($file in @('ROLES.md', 'WORKFLOW.md')) {
        $path = Join-Path $agentKitDir $file
        if (Test-Path -LiteralPath $path) {
            Remove-Item -LiteralPath $path -Force
        }
    }

    Remove-KnownPortableSkillFiles -SkillsSourceDir $SkillsSourceDir -SkillsTargetDir $skillsTargetDir
}

$KitRoot = Split-Path -Parent $PSScriptRoot
$ResolvedTarget = (Resolve-Path -LiteralPath $TargetPath -ErrorAction SilentlyContinue)
if ($null -eq $ResolvedTarget) {
    New-Item -ItemType Directory -Path $TargetPath -Force | Out-Null
    $ResolvedTarget = Resolve-Path -LiteralPath $TargetPath
}
$TargetRoot = $ResolvedTarget.Path

$AgentKitDir = Join-Path $TargetRoot '.agent-kit'
$MemorySource = Join-Path $KitRoot 'templates\PROJECT_MEMORY.md'
$ChangeLogSource = Join-Path $KitRoot 'templates\PROJECT_CHANGELOG.md'
$SkillsSourceDir = Join-Path $KitRoot 'skills'

New-Item -ItemType Directory -Path $AgentKitDir -Force | Out-Null

if ($Mode -eq 'direct') {
    $agentResult = Install-AgentFile -Source (Join-Path $KitRoot 'AGENTS.md') -TargetRoot $TargetRoot -Overwrite:$Force
    $memoryResult = Install-ProjectDoc -Source $MemorySource -TargetRoot $TargetRoot -FileName 'MEMORY.md' -Overwrite:$Force
    $changeLogResult = Install-ProjectDoc -Source $ChangeLogSource -TargetRoot $TargetRoot -FileName 'CHANGELOG.md' -Overwrite:$Force
    Remove-DirectModeArtifacts -TargetRoot $TargetRoot -SkillsSourceDir $SkillsSourceDir
    Write-InstallState -TargetRoot $TargetRoot -Mode 'direct' -AgentState $agentResult -MemoryState $memoryResult -ChangeLogState $changeLogResult

    Write-Host "Installed direct daily-driver kit to $TargetRoot"
    if ($agentResult -eq 'installed-root') {
        Write-Host '- AGENTS.md'
    } elseif ($agentResult -eq 'overwrote-root') {
        Write-Host '- AGENTS.md (existing file overwritten)'
        Write-Host '- .agent-kit/backups/AGENTS.pre-kit.md'
    } else {
        Write-Host '- AGENTS.md preserved'
        Write-Host '- .agent-kit/AGENTS.portable.md'
        Write-Host '- .agent-kit/AGENTS.integration.md'
    }
    Write-ProjectDocSummary -FileName 'MEMORY.md' -Result $memoryResult
    Write-ProjectDocSummary -FileName 'CHANGELOG.md' -Result $changeLogResult
    Write-Host '- .agent-kit/install-state.env'
    exit 0
}

$agentResult = Install-AgentFile -Source (Join-Path $KitRoot 'templates\PROJECT_AGENT_INSTRUCTIONS.md') -TargetRoot $TargetRoot -Overwrite:$Force
$memoryResult = Install-ProjectDoc -Source $MemorySource -TargetRoot $TargetRoot -FileName 'MEMORY.md' -Overwrite:$Force
$changeLogResult = Install-ProjectDoc -Source $ChangeLogSource -TargetRoot $TargetRoot -FileName 'CHANGELOG.md' -Overwrite:$Force
Sync-File -Source (Join-Path $KitRoot 'ROLES.md') -Destination (Join-Path $AgentKitDir 'ROLES.md')
Sync-File -Source (Join-Path $KitRoot 'WORKFLOW.md') -Destination (Join-Path $AgentKitDir 'WORKFLOW.md')

$SkillsTargetDir = Join-Path $AgentKitDir 'skills'
New-Item -ItemType Directory -Path $SkillsTargetDir -Force | Out-Null

$AvailableSkillFiles = Get-PortableSkillFiles -SkillsSourceDir $SkillsSourceDir

$SkillFiles = if ($Skills.Count -gt 0) {
    foreach ($Skill in $Skills) {
        $Wanted = $Skill.ToLowerInvariant()
        $Match = $AvailableSkillFiles | Where-Object {
            (($_.BaseName -replace '^[0-9]+-', '').ToLowerInvariant()) -eq $Wanted
        }
        if (-not $Match) {
            throw "No skill file matched '$Skill'. Use the exact portable skill name, for example: miica-plan, miica-fix-issue, miica-documentation, miica-knowledge, miica-deep-dive, miica-analyse, or miica-implementation."
        }
        $Match
    }
} else {
    $AvailableSkillFiles
}

$SelectedSkillFiles = $SkillFiles | Sort-Object FullName -Unique
$SelectedSkillNames = @($SelectedSkillFiles | ForEach-Object { $_.Name })

foreach ($AvailableSkillFile in $AvailableSkillFiles) {
    $targetFile = Join-Path $SkillsTargetDir $AvailableSkillFile.Name
    if (($SelectedSkillNames -notcontains $AvailableSkillFile.Name) -and (Test-Path -LiteralPath $targetFile)) {
        Remove-Item -LiteralPath $targetFile -Force
    }
}

foreach ($SkillFile in $SelectedSkillFiles) {
    Sync-File -Source $SkillFile.FullName -Destination (Join-Path $SkillsTargetDir $SkillFile.Name)
}

Write-InstallState -TargetRoot $TargetRoot -Mode 'modular' -AgentState $agentResult -MemoryState $memoryResult -ChangeLogState $changeLogResult -SkillFiles $SelectedSkillNames

Write-Host "Installed modular agent kit to $TargetRoot"
if ($agentResult -eq 'installed-root') {
    Write-Host '- AGENTS.md'
} elseif ($agentResult -eq 'overwrote-root') {
    Write-Host '- AGENTS.md (existing file overwritten)'
    Write-Host '- .agent-kit/backups/AGENTS.pre-kit.md'
} else {
    Write-Host '- AGENTS.md preserved'
    Write-Host '- .agent-kit/AGENTS.portable.md'
    Write-Host '- .agent-kit/AGENTS.integration.md'
}
Write-ProjectDocSummary -FileName 'MEMORY.md' -Result $memoryResult
Write-ProjectDocSummary -FileName 'CHANGELOG.md' -Result $changeLogResult
Write-Host '- .agent-kit/ROLES.md'
Write-Host '- .agent-kit/WORKFLOW.md'
Write-Host '- .agent-kit/skills/'
Write-Host '- .agent-kit/install-state.env'
