param(
    [string]$TargetDir = '',
    [string[]]$Skills = @(),
    [switch]$Force
)

$ErrorActionPreference = 'Stop'

function Copy-DirectorySafe {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Source,
        [Parameter(Mandatory = $true)]
        [string]$Destination,
        [switch]$Overwrite
    )

    if (Test-Path -LiteralPath $Destination) {
        if (-not $Overwrite) {
            throw "Destination already exists: $Destination. Re-run with -Force to overwrite."
        }
        Remove-Item -LiteralPath $Destination -Recurse -Force
    }

    Copy-Item -LiteralPath $Source -Destination $Destination -Recurse -Force
}

$KitRoot = Split-Path -Parent $PSScriptRoot
$SourceRoot = Join-Path $KitRoot 'claude-skills'

if ([string]::IsNullOrWhiteSpace($TargetDir)) {
    $ClaudeHome = if ($env:CLAUDE_HOME) { $env:CLAUDE_HOME } else { Join-Path $HOME '.claude' }
    $TargetDir = Join-Path $ClaudeHome 'skills'
}

if (-not (Test-Path -LiteralPath $TargetDir)) {
    New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null
}

$Available = Get-ChildItem -LiteralPath $SourceRoot -Directory
$Selected = if ($Skills.Count -gt 0) {
    foreach ($Skill in $Skills) {
        $Wanted = $Skill.ToLowerInvariant()
        $Match = $Available | Where-Object { $_.Name.ToLowerInvariant() -eq $Wanted }
        if (-not $Match) {
            throw "No Claude skill matched '$Skill'. Use exact names like miica-plan, miica-fix-issue, miica-documentation, miica-knowledge, miica-deep-dive, miica-analyse, or miica-implementation."
        }
        $Match
    }
} else {
    $Available
}

foreach ($SkillDir in $Selected | Sort-Object FullName -Unique) {
    Copy-DirectorySafe -Source $SkillDir.FullName -Destination (Join-Path $TargetDir $SkillDir.Name) -Overwrite:$Force
}

Write-Host "Installed Claude skills to $TargetDir"
($Selected | Sort-Object Name -Unique | ForEach-Object { "- $($_.Name)" }) | ForEach-Object { Write-Host $_ }
