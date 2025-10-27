# QuickLook

QuickLook is a modular PowerShell diagnostic and inventory tool designed for rapid system assessments.
It collects system, network, and hardware information and generates styled HTML reports with navigation.

## Features
- System, network, and security modules
- HTML reports with navigation bar
- Plug-and-play PowerShell design
- Works fully offline

## Usage
Open PowerShell in the QuickLook directory.  
2. Run:
   ```powershell
   .\QuickLook.ps1
Reports are automatically generated in the `/Reports` folder and will automatically open.


If QuickLook doesn’t start due to PowerShell’s execution policy,
run the following command in PowerShell to allow the script for this session only: Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

This temporarily allows QuickLook to run without permanently changing your system’s policy.
After closing PowerShell, your normal security settings are restored automatically.
