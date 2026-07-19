# Acta installer (Windows / PowerShell)
# Copies the acta-* skills and shared resources into your Claude config (~/.claude).
$ErrorActionPreference = 'Stop'
$claude = Join-Path $env:USERPROFILE '.claude'
$src = $PSScriptRoot

New-Item -ItemType Directory -Force -Path (Join-Path $claude 'skills') | Out-Null
Get-ChildItem (Join-Path $src 'skills') -Directory -Filter 'acta-*' | ForEach-Object {
    Copy-Item $_.FullName -Destination (Join-Path $claude 'skills') -Recurse -Force
    Write-Host "installed skill: $($_.Name)"
}
Copy-Item (Join-Path $src 'acta') -Destination $claude -Recurse -Force
Write-Host "installed shared resources: ~/.claude/acta"
Write-Host ""
Write-Host "Acta installed. Restart Claude Code, then run /acta-init" -ForegroundColor Green
