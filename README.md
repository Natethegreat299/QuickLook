# QuickLook

QuickLook is a modular PowerShell diagnostic and inventory tool designed for rapid system assessments.
It collects system, network, and hardware information and generates styled HTML reports with navigation.

## Features
- System, network, and security modules
- HTML reports with navigation bar
- Plug-and-play PowerShell design
- Works fully offline

## Usage
Run `QuickLook_launcher.bat` and it will run the script.
Reports are automatically generated in the `/Reports` folder and will automatically open.


Note: QuickLook is currently in an active development phase.
The launcher temporarily uses ExecutionPolicy Bypass to allow smooth local execution, but future releases will include code-signing and/or executable packaging for improved security and ease of use.

This project is designed primarily as a learning and diagnostic tool — showing how PowerShell can collect and present system data in HTML format.
