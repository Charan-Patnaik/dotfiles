$ErrorActionPreference = "Stop"

# Path to this repo (assumes script is run from repo root or direct path)
$RepoRoot = Split-Path -Parent $PSScriptRoot
$Source = Join-Path $RepoRoot "windows\wezterm\.wezterm.lua"
$Target = Join-Path $HOME ".wezterm.lua"

Write-Host "Source: $Source"
Write-Host "Target: $Target"

if (!(Test-Path $Source)) {
    throw "WezTerm config not found at $Source"
}

if (Test-Path $Target) {
    Write-Host "Backing up existing WezTerm config to $Target.bak"
    Move-Item -Force $Target "$Target.bak"
}

New-Item -ItemType SymbolicLink -Path $Target -Target $Source | Out-Null
Write-Host "✅ WezTerm config linked."