# RageQuit
A simple and configurable PowerShell script for Windows that allows you to close everything by clicking a tray icon

## Requirements
PowerShell 6.0+

## Configuring
Changing the tray icon (at the moment only from any executable):  
Edit line 24: ```$icon = [System.Drawing.Icon]::ExtractAssociatedIcon("<executable path>")```

## Usage
Run `run.vbs` to launch RageQuit
(Optionally you can add run it on Windows Start-up)

## Credits
[Hiding cmd window](https://stackoverflow.com/questions/13142603/prevent-vbscript-app-from-showing-console-window)
[Tray icon](https://www.systanddeploy.com/2018/12/create-your-own-powershell.html)
[MahApps.Metro framework](https://github.com/MahApps/MahApps.Metro)
