param(
    [string]$TargetDir = '',
    [string[]]$Skills = @()
)

$ErrorActionPreference = 'Stop'

$KitRoot = Split-Path -Parent $PSScriptRoot
$SourceRoot = Join-Path $KitRoot 'codex-skills'

if ([string]::IsNullOrWhiteSpace($TargetDir)) {
    $AgentsHome = if ($env:AGENTS_HOME) { $env:AGENTS_HOME } else { Join-Path $HOME '.agents' }
    $TargetDir = Join-Path $AgentsHome 'skills'
}

$Available = Get-ChildItem -LiteralPath $SourceRoot -Directory
$Selected = if ($Skills.Count -gt 0) {
    foreach ($Skill in $Skills) {
        $Wanted = $Skill.ToLowerInvariant()
        $Match = $Available | Where-Object { $_.Name.ToLowerInvariant() -eq $Wanted }
        if (-not $Match) {
            throw "No agent skill matched '$Skill'. Use exact names like miica-plan, miica-architecture, miica-fix-issue, miica-documentation, miica-knowledge, miica-deep-dive, miica-analyse, miica-review, miica-implementation, miica-git, or miica-execute-plan."
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
    Write-Host "No kit-managed agent skills were found in $TargetDir"
    exit 0
}

Write-Host "Uninstalled agent skills from $TargetDir"
$Removed | Sort-Object -Unique | ForEach-Object { Write-Host "- $_" }
