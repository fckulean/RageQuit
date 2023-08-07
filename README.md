# RageQuit
A simple and configurable PowerShell script for Windows that allows you to close everything by clicking a taskbar icon

## Requirements
PowerShell 6.0+

## Configuring
Changing the icon (at the moment only from any executable):  
Edit line 24: ```$icon = [System.Drawing.Icon]::ExtractAssociatedIcon("<executable path>")```

## Usage
Run `run.vbs` to launch RageQuit
(Optionally you can add run it on Windows Start-up)
