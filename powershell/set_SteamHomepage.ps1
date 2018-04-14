#requires -version 4
<#
.SYNOPSIS
  Blubb
#>
#---------------------------------------------------------[Initialisations]--------------------------------------------------------

#Set Error Action to Silently Continue
$ErrorActionPreference = 'SilentlyContinue'

#-----------------------------------------------------------[Execution]------------------------------------------------------------

$find = 'https://www.google.com'
$replace = 'http://portal.bene.gg'
$match = 'localconfig.vdf'
$preview = $false

foreach ($sc in Get-ChildItem "D:\Programme\Steam\userdata" -recurse -include $match | Where-Object { test-path $_.fullname -pathtype leaf} ) {
    select-string -path $sc -pattern $find
    if (!$preview) {
       (get-content $sc) | foreach-object { $_ -replace $find, $replace } | set-content $sc
    }
}

#-----------------------------------------------------------[End]------------------------------------------------------------
if ($Host.Name -eq "ConsoleHost")
{ 
    Write-Host "Press any key to continue..."
    $Host.UI.RawUI.FlushInputBuffer()
    $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyUp") > $null
}