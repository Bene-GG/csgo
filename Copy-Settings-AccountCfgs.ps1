[CmdletBinding()]
param (
    [Parameter(Mandatory)]
    [string]
    $SourceAccount,
    [Parameter()]
    [string]
    $DestAccount
)

if (-not $DestAccount) {
    Write-Output "no DestAccount"
    $DestAccount = 'All'
}

$configsfolder = "C:\Program Files (x86)\Steam\userdata"
$configs = Get-ChildItem "$configsfolder/[0-9]*"
$configs = $configs | Where-Object { $_.Name –ne $SourceAccount }


if (-not $configs -match $SourceAccount) {
    Write-Output "Invalid SourceAccount"
    exit 1
}

Write-Output "Source: $SourceAccount"
Write-Output "Dest: $DestAccount"

$sourcefile1 = $configsfolder + "\" + $SourceAccount + "\730\local\cfg\config.cfg"
$sourcefile2 = $configsfolder + "\" + $SourceAccount + "\730\local\cfg\video.txt"

if ( -not (Test-Path -Path "$sourcefile1")) {
    Write-Output "Source File does not exist" 
    exit 2
}

if ( -not (Test-Path -Path "$sourcefile2")) {
    Write-Output "Source File does not exist" 
    exit 2
}



foreach ($config in $configs) {
    $targetfolder = $configsfolder + "\" + $config.Name + "\730\local\cfg"
    New-Item $targetfolder -ItemType Directory -ErrorAction SilentlyContinue
    $targetfile1 = $targetfolder + "\config.cfg"
    $targetfile2 = $targetfolder + "\video.txt"
    Write-Output "$targetfile1"
    Write-Output "$targetfile2"
    Copy-Item -Path $sourcefile1 -Destination $targetfile1 -Force
    Copy-Item -Path $sourcefile2 -Destination $targetfile2 -Force
}