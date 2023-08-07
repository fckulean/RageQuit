# RageQuit
A simple and configurable PowerShell script for Windows that allows you to close everything by clicking a tray icon
  
## Requirements
PowerShell 6.0+
  
## Usage
Extract `.zip` archive in an empty directory  
Run `run.vbs` to launch RageQuit  
(Optionally you can add run it on Windows Start-up)
  
## Changing the tray icon
```$icon = [System.Drawing.Icon]::ExtractAssociatedIcon("executable_path")```  
*(At the moment only from any executable)*
  
## Exceptions and force kills  
First you need a list of your process names:  
```Get-Process | Select ProcessName```
  
If you don't want to kill a certain process, add it to the **exceptions**:  
i.e. ``-notlike "*process_name*"` ``  
  
If for some reason the script doesn't kill a process you need,  
add it to **ForceKill**:  
i.e. `ForceKill "*process_name*"`  
  
![Like this:](https://i.imgur.com/zE8i2Mv.png)
  
## Credits
[Hiding cmd window](https://stackoverflow.com/questions/13142603/prevent-vbscript-app-from-showing-console-window)  
[Tray icon](https://www.systanddeploy.com/2018/12/create-your-own-powershell.html)  
[MahApps.Metro framework](https://github.com/MahApps/MahApps.Metro)
