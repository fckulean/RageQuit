# adding all of the dependencies
Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();

[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'
function Hide-Console {
    $consolePtr = [Console.Window]::GetConsoleWindow()
    [Console.Window]::ShowWindow($consolePtr, 0)
}

$Current_Folder = split-path $MyInvocation.MyCommand.Path
	
[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')  	 | out-null
[System.Reflection.Assembly]::LoadWithPartialName('presentationframework') 	 | out-null
[System.Reflection.Assembly]::LoadWithPartialName('System.Drawing') 		 | out-null
[System.Reflection.Assembly]::LoadWithPartialName('WindowsFormsIntegration') | out-null
[System.Reflection.Assembly]::LoadFrom("$Current_Folder\assembly\MahApps.Metro.dll") | out-null
################################

# change the icon image
$icon = [System.Drawing.Icon]::ExtractAssociatedIcon("C:\Windows\System32\changepk.exe")	
#######################

# taskbar entry
$tbicon = New-Object System.Windows.Forms.NotifyIcon
$tbicon.Text = "RageQuit"
$tbicon.Icon = $icon
$tbicon.Visible = $true
###############

# taskbar icon context
$tb_right_exit = New-Object System.Windows.Forms.MenuItem
$tb_right_exit.Text = "Exit (hide icon)"
$contextmenu = New-Object System.Windows.Forms.ContextMenu
$tbicon.ContextMenu = $contextmenu
$tbicon.contextMenu.MenuItems.AddRange($tb_right_exit)
######################

function ForceKill {
    Param(
    [string]$ProcessName
    )
    Get-Process | Where-Object {$_.ProcessName -like "$ProcessName"} | Stop-Process
}
# the single-click magic
$tbicon.Add_Click({					
	If ($_.Button -eq [Windows.Forms.MouseButtons]::Left) {
		Get-Process | Where-Object {$_.MainWindowTitle -ne "" -and "RageQuit"} | Where-Object {$_.ProcessName `
        # manage the exceptions that won't be closed
        -notlike "*explorer*"`
        ############################################
        } | stop-process
        # force kill any other process
        # ForceKill "*process_name*"
        ##############################
	}				
})
########################

# exit ragequit
$tb_right_exit.add_Click({
	$tbicon.Visible = $false
	$window.Close()
	Stop-Process $pid
 })
###############

# second attempt to hide cmd window
$windowcode = '[DllImport("user32.dll")] public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);'
$asyncwindow = Add-Type -MemberDefinition $windowcode -name Win32ShowWindowAsync -namespace Win32Functions -PassThru
$null = $asyncwindow::ShowWindowAsync((Get-Process -PID $pid).MainWindowHandle, 0)
Hide-Console
###################################

# memory drain fix
[System.GC]::Collect()
##################

$appContext = New-Object System.Windows.Forms.ApplicationContext
[void][System.Windows.Forms.Application]::Run($appContext)