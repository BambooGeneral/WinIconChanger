# Powershell version check
($PSVersionTable)["PSVersion"]
# Administrator authorization Check
if (-not(([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator" ))) {
    Write-Host "+++++++++ Administrator authorization is required +++++++++" -ForegroundColor White -BackgroundColor Red
    Write-Host "Install failured!!"
    Write-Host "You can close this window by anykey"
    return
}

$iconDir = "C:\gficons"
$Extention = ".cfio"
$iconname = "caelum.ico"

# regedit
$RegPath = "Registry::HKEY_CLASSES_ROOT\$Extention"
Remove-Item -Path $RegPath -Force -Recurse
New-Item -Path $RegPath
$RegPath = "Registry::HKEY_CLASSES_ROOT\$Extention\DefaultIcon"
New-Item $RegPath
New-ItemProperty -Path $RegPath -name "(default)" -Value $iconDir\$iconname -propertyType ExpandString

# icon set
Remove-Item $iconDir\ -Force -Recurse
New-Item $iconDir -ItemType Directory
Copy-Item .\$iconname -Destination $iconDir\$iconname -Force -Recurse

Stop-Process -Name explorer -Force
Start-Process explorer

Write-Output "Install finished, You can close this window by anykey"