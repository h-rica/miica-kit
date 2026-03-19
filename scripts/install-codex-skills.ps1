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
$SourceRoot = Join-Path $KitRoot 'codex-skills'

if ([string]::IsNullOrWhiteSpace($TargetDir)) {
    $CodexHome = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $HOME '.codex' }
    $TargetDir = Join-Path $CodexHome 'skills'
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
            throw "No Codex skill matched '$Skill'. Use exact names like miica-plan, miica-fix-issue, miica-documentation, miica-analyse, or miica-implementation."
        }
        $Match
    }
} else {
    $Available
}

foreach ($SkillDir in $Selected | Sort-Object FullName -Unique) {
    Copy-DirectorySafe -Source $SkillDir.FullName -Destination (Join-Path $TargetDir $SkillDir.Name) -Overwrite:$Force
}

Write-Host "Installed Codex skills to $TargetDir"
($Selected | Sort-Object Name -Unique | ForEach-Object { "- $($_.Name)" }) | ForEach-Object { Write-Host $_ }
