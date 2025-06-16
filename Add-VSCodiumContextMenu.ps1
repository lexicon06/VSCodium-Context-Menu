<#
.SYNOPSIS
    Adds VSCodium to Windows context menu (Shift+Right Click on folders and Right Click on files)
.DESCRIPTION
    This script creates two registry entries:
    1. "Open with VSCodium" for folders (Shift+Right Click)
    2. "Edit with VSCodium" for files (Right Click)
.NOTES
    File Name      : Install-VSCodiumContextMenu.ps1
    Author         : Pablo Santillan
    Prerequisite   : PowerShell 5.1+ and VSCodium installed
#>

# Check if running as administrator
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "This script requires administrator privileges. Restarting with elevated permissions..." -ForegroundColor Yellow
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$($MyInvocation.MyCommand.Path)`"" -Verb RunAs
    exit
}

# VSCodium executable path (change if different)
$vscodiumPath = "$env:LOCALAPPDATA\Programs\VSCodium\VSCodium.exe"

# Verify VSCodium exists
if (-not (Test-Path $vscodiumPath)) {
    Write-Host "VSCodium not found at $vscodiumPath" -ForegroundColor Red
    Write-Host "Please modify the path in the script or install VSCodium first." -ForegroundColor Yellow
    pause
    exit
}

# 1. Add Shift+Right Click option for folders
Write-Host "Adding 'Open with VSCodium' to folder context menu (Shift+Right Click)..." -ForegroundColor Cyan
reg add "HKEY_CLASSES_ROOT\Directory\shell\VSCodium" /ve /d "Open with VSCodium" /f
reg add "HKEY_CLASSES_ROOT\Directory\shell\VSCodium" /v "Icon" /t REG_SZ /d "$vscodiumPath,0" /f
reg add "HKEY_CLASSES_ROOT\Directory\shell\VSCodium\command" /ve /t REG_SZ /d "\"$vscodiumPath\" \"%1\"" /f
reg add "HKEY_CLASSES_ROOT\Directory\shell\VSCodium" /v "Extended" /t REG_SZ /d "" /f

# 2. Add Right Click option for files
Write-Host "Adding 'Edit with VSCodium' to file context menu..." -ForegroundColor Cyan
reg add "HKEY_CLASSES_ROOT\*\shell\EditWithVSCodium" /ve /d "Edit with VSCodium" /f
reg add "HKEY_CLASSES_ROOT\*\shell\EditWithVSCodium" /v "Icon" /t REG_SZ /d "$vscodiumPath,0" /f
reg add "HKEY_CLASSES_ROOT\*\shell\EditWithVSCodium\command" /ve /t REG_SZ /d "\"$vscodiumPath\" \"%1\"" /f

# Optional: Add Shift+Right Click for files (uncomment if needed)
# reg add "HKEY_CLASSES_ROOT\*\shell\EditWithVSCodium" /v "Extended" /t REG_SZ /d "" /f

Write-Host "`nSuccessfully added VSCodium to context menus!" -ForegroundColor Green
Write-Host "- Use Shift+Right Click on folders to see 'Open with VSCodium'`n- Right Click on files to see 'Edit with VSCodium'" -ForegroundColor Yellow

# Refresh shell to see changes
Write-Host "`nRefreshing Explorer..." -ForegroundColor Cyan
Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue

pause
