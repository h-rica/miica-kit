param(
    [Parameter(Mandatory = $true)]
    [string]$TargetPath
)

$ErrorActionPreference = 'Stop'

function Get-PortableSkillFiles {
    param(
        [Parameter(Mandatory = $true)]
        [string]$SkillsSourceDir
    )

    Get-ChildItem -LiteralPath $SkillsSourceDir -File | Where-Object { $_.Name -ne 'README.md' } | Sort-Object Name
}

function Read-InstallState {
    param(
        [Parameter(Mandatory = $true)]
        [string]$ManifestPath
    )

    if (-not (Test-Path -LiteralPath $ManifestPath)) {
        return $null
    }

    $state = @{}
    foreach ($line in Get-Content -LiteralPath $ManifestPath) {
        if ([string]::IsNullOrWhiteSpace($line)) {
            continue
        }
        $parts = $line -split '=', 2
        if ($parts.Count -ne 2) {
            continue
        }
        $state[$parts[0]] = $parts[1]
    }

    return $state
}

function Test-SameFileContent {
    param(
        [Parameter(Mandatory = $true)]
        [string]$First,
        [Parameter(Mandatory = $true)]
        [string]$Second
    )

    if ((-not (Test-Path -LiteralPath $First)) -or (-not (Test-Path -LiteralPath $Second))) {
        return $false
    }

    return (Get-FileHash -LiteralPath $First -Algorithm SHA256).Hash -eq (Get-FileHash -LiteralPath $Second -Algorithm SHA256).Hash
}

function Remove-IfExists {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    if (Test-Path -LiteralPath $Path) {
        Remove-Item -LiteralPath $Path -Recurse -Force
        return $true
    }

    return $false
}

function Remove-DirectoryIfEmpty {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    if ((Test-Path -LiteralPath $Path) -and -not (Get-ChildItem -LiteralPath $Path -Force)) {
        Remove-Item -LiteralPath $Path -Force
    }
}

$KitRoot = Split-Path -Parent $PSScriptRoot
$ResolvedTarget = Resolve-Path -LiteralPath $TargetPath -ErrorAction SilentlyContinue
if ($null -eq $ResolvedTarget) {
    Write-Host "No project directory found at $TargetPath"
    exit 0
}

$TargetRoot = $ResolvedTarget.Path
$AgentKitDir = Join-Path $TargetRoot '.agent-kit'
$InstalledDir = Join-Path $AgentKitDir 'installed'
$BackupsDir = Join-Path $AgentKitDir 'backups'
$SkillsDir = Join-Path $AgentKitDir 'skills'
$ManifestPath = Join-Path $AgentKitDir 'install-state.env'
$SkillsSourceDir = Join-Path $KitRoot 'skills'

$Manifest = Read-InstallState -ManifestPath $ManifestPath
$Actions = New-Object System.Collections.Generic.List[string]
$Warnings = New-Object System.Collections.Generic.List[string]
$Touched = $false
$BlockedRootRecovery = $false

function Handle-RootDoc {
    param(
        [Parameter(Mandatory = $true)]
        [string]$FileName,
        [Parameter(Mandatory = $true)]
        [string]$StateKey
    )

    $state = $Manifest[$StateKey]
    if ([string]::IsNullOrWhiteSpace($state)) {
        return
    }

    $targetFile = Join-Path $TargetRoot $FileName
    $snapshotName = if ($FileName -eq 'AGENTS.md') { 'AGENTS.root.md' } else { $FileName }
    $snapshotFile = Join-Path $InstalledDir $snapshotName
    $baseName = [System.IO.Path]::GetFileNameWithoutExtension($FileName)
    $backupFile = Join-Path $BackupsDir ($baseName + '.pre-kit.md')

    if ($state -eq 'installed-root') {
        if (-not (Test-Path -LiteralPath $targetFile)) {
            return
        }

        if (Test-SameFileContent -First $targetFile -Second $snapshotFile) {
            Remove-Item -LiteralPath $targetFile -Force
            $Actions.Add("$FileName removed")
            $script:Touched = $true
        } else {
            $Warnings.Add("$FileName was installed by the kit but changed after installation, so it was left in place.")
            $script:BlockedRootRecovery = $true
        }

        return
    }

    if ($state -eq 'overwrote-root') {
        if ((Test-Path -LiteralPath $targetFile) -and (Test-Path -LiteralPath $snapshotFile) -and -not (Test-SameFileContent -First $targetFile -Second $snapshotFile)) {
            $Warnings.Add("$FileName was overwritten by the kit and later modified, so the backup was left in .agent-kit/backups for manual restore.")
            $script:BlockedRootRecovery = $true
            return
        }

        if (Test-Path -LiteralPath $backupFile) {
            Copy-Item -LiteralPath $backupFile -Destination $targetFile -Force
            $Actions.Add("$FileName restored from .agent-kit/backups/$baseName.pre-kit.md")
            $script:Touched = $true
        } else {
            $Warnings.Add("Backup for $FileName is missing, so the current file was left in place.")
            $script:BlockedRootRecovery = $true
        }
    }
}

if ($null -ne $Manifest) {
    Handle-RootDoc -FileName 'AGENTS.md' -StateKey 'AGENTS_STATE'
    Handle-RootDoc -FileName 'MEMORY.md' -StateKey 'MEMORY_STATE'
    Handle-RootDoc -FileName 'CHANGELOG.md' -StateKey 'CHANGELOG_STATE'
} elseif (Test-Path -LiteralPath $AgentKitDir) {
    $Warnings.Add('No install-state manifest was found, so root AGENTS.md, MEMORY.md, and CHANGELOG.md were left untouched.')
}

foreach ($file in @('AGENTS.portable.md', 'AGENTS.integration.md', 'MEMORY.template.md', 'CHANGELOG.template.md', 'ROLES.md', 'WORKFLOW.md')) {
    $path = Join-Path $AgentKitDir $file
    if (Remove-IfExists -Path $path) {
        $Actions.Add(".agent-kit/$file removed")
        $Touched = $true
    }
}

foreach ($skillFile in Get-PortableSkillFiles -SkillsSourceDir $SkillsSourceDir) {
    $targetFile = Join-Path $SkillsDir $skillFile.Name
    if (Remove-IfExists -Path $targetFile) {
        $Actions.Add(".agent-kit/skills/$($skillFile.Name) removed")
        $Touched = $true
    }
}

Remove-DirectoryIfEmpty -Path $SkillsDir

if (($null -ne $Manifest) -and -not $BlockedRootRecovery) {
    if (Remove-IfExists -Path $InstalledDir) {
        $Touched = $true
    }
    if (Remove-IfExists -Path $ManifestPath) {
        $Actions.Add('.agent-kit/install-state.env removed')
        $Touched = $true
    }
    if (Remove-IfExists -Path $BackupsDir) {
        $Touched = $true
    }
} elseif ($BlockedRootRecovery) {
    $Warnings.Add('The install state and backups were kept under .agent-kit so you can finish cleanup manually.')
}

Remove-DirectoryIfEmpty -Path $InstalledDir
Remove-DirectoryIfEmpty -Path $BackupsDir
Remove-DirectoryIfEmpty -Path $AgentKitDir

if (-not $Touched -and ($Warnings.Count -eq 0)) {
    Write-Host "No installed project-local kit elements were found in $TargetRoot"
    exit 0
}

Write-Host "Uninstalled project-local kit from $TargetRoot"
$Actions | ForEach-Object { Write-Host "- $_" }
$Warnings | ForEach-Object { Write-Host "! $_" }
