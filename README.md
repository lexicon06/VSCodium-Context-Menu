# VSCodium Context Menu Integration ✨

Adds VSCodium to Windows right-click menus:
- **Shift + Right-Click** on folders → "Open with VSCodium"
- **Right-Click** on files → "Edit with VSCodium"

![Context Menu Demo](demo.gif) *(Optional: Add screenshot later)*

## Features
- ✅ No hardcoded paths - works for all users
- ✅ Admin rights auto-detection
- ✅ Includes icons in context menus
- ✅ Explorer auto-refresh after installation

## Installation
1. Download `Add-VSCodiumContextMenu.ps1`
2. Right-click → "Run with PowerShell" (admin required)
3. Accept UAC prompt if shown

## Usage
- For folders: **Shift + Right-Click** → "Open with VSCodium"
- For files: **Right-Click** → "Edit with VSCodium"

## Uninstallation
Run `Uninstall-VSCodiumContextMenu.ps1` (included in releases)

## Technical Details
- Registry paths modified:
  - `HKEY_CLASSES_ROOT\Directory\shell\VSCodium`
  - `HKEY_CLASSES_ROOT\*\shell\EditWithVSCodium`
- Uses dynamic path resolution via `%LOCALAPPDATA%`

## Credits
Created by [Pablo Santillan](https://github.com/lexicon06)  

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
