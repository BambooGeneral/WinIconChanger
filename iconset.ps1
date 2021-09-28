# Powershell version check
($PSVersionTable)["PSVersion"]
# Administrator authorization Check
if (-not(([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator" ))) {
    Write-Host "+++++++++ Administrator authorization is required +++++++++" -ForegroundColor White -BackgroundColor Red
    Write-Host "Install failured!!"
    Write-Host "You can close this window by anykey"
    return
}

function Set-Icon {
    param (
        [string]
        $iconDir = "/custum-icons",
        [string]
        $Extention = ".cfio",
        [string]
        $iconname = "caelum.ico"
    )

    # regedit
    $RegPath = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\$Extention"
    if (Test-Path $RegPath) {
        Remove-Item -Path $RegPath -Force -Recurse
    }
    New-Item -Path $RegPath
    $RegPath = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\$Extention\DefaultIcon"
    New-Item $RegPath
    New-ItemProperty -Path $RegPath -name "(default)" -Value $iconDir\$iconname -propertyType ExpandString

    # icon set
    if (Test-Path $iconDir) {
        Remove-Item $iconDir\ -Force -Recurse
    }
    New-Item $iconDir -ItemType Directory
    Copy-Item .\$iconname -Destination $iconDir\$iconname -Force -Recurse

    $IconCacheDB = "$env:USERPROFILE/AppData/Local/IconCache.db"
    if (Test-Path $IconCacheDB) {
        Remove-Item -Path $IconCacheDB -Force
    }

    Stop-Process -Name explorer -Force
    Start-Process explorer
}

Set-Icon

Write-Output "Install finished, You can close this window by anykey"