if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$($MyInvocation.MyCommand.Path)`"" -Verb RunAs
    exit
}

Write-Host "Removing VSCodium context menus..." -ForegroundColor Cyan
reg delete "HKEY_CLASSES_ROOT\Directory\shell\VSCodium" /f 2>$null
reg delete "HKEY_CLASSES_ROOT\*\shell\EditWithVSCodium" /f 2>$null

Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue
Write-Host "Uninstalled successfully! Explorer will refresh." -ForegroundColor Green
pause
