#requires -version 5

<#
.SYNOPSIS
  Setup-CSGOConfig.ps1
.DESCRIPTION
  Setup the configs for CS:GO
.INPUTS
  None
.OUTPUTS
  None
.NOTES
  Version:        1.0
  Author:         Bene
  Creation Date:  2019-05-25
  Purpose/Change: Initial script development
#>
#Request administrative Permissions
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
        $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
        Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
        Exit
    }
}

Add-Type -AssemblyName PresentationFramework

function Show-ErrorMessageBox {
    Param(
        [Parameter(Mandatory = $True)]
        $title,
        [Parameter(Mandatory = $True)]
        $message
    )
    [System.Windows.MessageBox]::Show("$message", "$title", 0) | Out-Null
}

function Get-UserInput {
    Param(
        [Parameter(Mandatory = $False)]
        $title = "Standardtitel",
        [Parameter(Mandatory = $False)]
        $message = "Standardnachricht",
        [Parameter(Mandatory = $False)]
        $buttontext = "OK"
    )
    Add-Type -AssemblyName PresentationFramework
    [xml]$xaml = @"
<Window 
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    x:Name="Window" Title="{0}" WindowStartupLocation = "CenterScreen" ResizeMode="NoResize"
    Width = "450" Height = "150" ShowInTaskbar = "True" Background = "lightgray"> 
    <StackPanel>
        <Label Content='{1}' />
        <TextBox x:Name="InputBox" Height = "50" AcceptsTab="True" AcceptsReturn="True" 
        TextWrapping="Wrap" VerticalScrollBarVisibility = "Auto"/>    
        <StackPanel Orientation = 'Horizontal' HorizontalAlignment="Right">  
            <Button x:Name = "button" Height = "30" Width = "75" Content = '{2}' />
        </StackPanel>
    </StackPanel>
</Window>
"@ -f $title, $message, $buttontext
 
    $reader = (New-Object System.Xml.XmlNodeReader $xaml)
    $Window = [Windows.Markup.XamlReader]::Load( $reader )

    #Connect to Controls
    $button = $Window.FindName('button')
    $InputBox = $Window.FindName('InputBox')

    #Events
    $button.Add_Click( {
            $Window.Close()
        })

    $Window.ShowDialog() | Out-Null
    $InputBox.Text
}
#Check for CSGO-Installation
$regpath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 7301"
$csgopath = (Get-ItemProperty -Path $regpath -ErrorAction SilentlyContinue).InstallLocation

if (-not $csgopath) {
    Show-ErrorMessageBox "Error :(" ("Could not find CS:GO path in registry. ({0})" -f $regpath)
    $csgopath = Get-UserInput "Eingabe CS:GO-Pfad" "Bitte gib hier den Pfad zu dem Ordner an, in dem sich die csgo.exe befindet:"
}

if ((Test-Path $csgopath -ErrorAction SilentlyContinue) -eq $false) {
    Show-ErrorMessageBox "Error :(" ("Could not find CS:GO folder. ({0})" -f $csgopath)
    exit
}

#Check for existing autoexec.cfg
$cfgfolderpath = $csgopath + "\csgo\cfg"
$autoexecpath = $cfgfolderpath + "\autoexec.cfg"
if ((Test-Path $autoexecpath -ErrorAction SilentlyContinue) -eq $true) {
    $newfilename = "autoexec_{0}.cfg" -f (Get-Date -UFormat "%Y%m%d-%H%M%S")
    Write-Output ("autoexec.cfg exists, creating backup: {0}" -f $newfilename)
    Copy-Item -Path $autoexecpath -Destination ($cfgfolderpath + "\" + $newfilename)
    exit
}