param(
    [string]$TargetDir = '',
    [string[]]$Skills = @()
)

$ErrorActionPreference = 'Stop'

$KitRoot = Split-Path -Parent $PSScriptRoot
$SourceRoot = Join-Path $KitRoot 'codex-skills'

if ([string]::IsNullOrWhiteSpace($TargetDir)) {
    $CodexHome = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $HOME '.codex' }
    $TargetDir = Join-Path $CodexHome 'skills'
}

$Available = Get-ChildItem -LiteralPath $SourceRoot -Directory
$Selected = if ($Skills.Count -gt 0) {
    foreach ($Skill in $Skills) {
        $Wanted = $Skill.ToLowerInvariant()
        $Match = $Available | Where-Object { $_.Name.ToLowerInvariant() -eq $Wanted }
        if (-not $Match) {
            throw "No Codex skill matched '$Skill'. Use exact names like miica-plan, miica-fix-issue, miica-documentation, miica-knowledge, miica-analyse, or miica-implementation."
        }
        $Match
    }
} else {
    $Available
}

$Removed = @()
foreach ($SkillDir in $Selected | Sort-Object FullName -Unique) {
    $destination = Join-Path $TargetDir $SkillDir.Name
    if (Test-Path -LiteralPath $destination) {
        Remove-Item -LiteralPath $destination -Recurse -Force
        $Removed += $SkillDir.Name
    }
}

if ($Removed.Count -eq 0) {
    Write-Host "No kit-managed Codex skills were found in $TargetDir"
    exit 0
}

Write-Host "Uninstalled Codex skills from $TargetDir"
$Removed | Sort-Object -Unique | ForEach-Object { Write-Host "- $_" }
