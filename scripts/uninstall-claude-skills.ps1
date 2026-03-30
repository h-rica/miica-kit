param(
    [string]$TargetDir = '',
    [string[]]$Skills = @()
)

$ErrorActionPreference = 'Stop'

$KitRoot = Split-Path -Parent $PSScriptRoot
$SourceRoot = Join-Path $KitRoot 'claude-skills'

if ([string]::IsNullOrWhiteSpace($TargetDir)) {
    $ClaudeHome = if ($env:CLAUDE_HOME) { $env:CLAUDE_HOME } else { Join-Path $HOME '.claude' }
    $TargetDir = Join-Path $ClaudeHome 'skills'
}

$Available = Get-ChildItem -LiteralPath $SourceRoot -Directory
$Selected = if ($Skills.Count -gt 0) {
    foreach ($Skill in $Skills) {
        $Wanted = $Skill.ToLowerInvariant()
        $Match = $Available | Where-Object { $_.Name.ToLowerInvariant() -eq $Wanted }
        if (-not $Match) {
            throw "No Claude skill matched '$Skill'. Use exact names like miica-plan, miica-architecture, miica-fix-issue, miica-documentation, miica-knowledge, miica-deep-dive, miica-analyse, miica-review, miica-implementation, miica-git, or miica-execute-plan."
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
    Write-Host "No kit-managed Claude skills were found in $TargetDir"
    exit 0
}

Write-Host "Uninstalled Claude skills from $TargetDir"
$Removed | Sort-Object -Unique | ForEach-Object { Write-Host "- $_" }
