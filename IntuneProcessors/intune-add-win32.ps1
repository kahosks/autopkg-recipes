Set-PSRepository PSGallery -InstallationPolicy Trusted
Install-Module -Name "IntuneWin32App" 

$ClientID= $Env:ClientID
$ClientSecret= $Env:ClientSecret
$TenantID= $Env:TenantID
$AppName= $args[0]
$IntuneWinFile= $args[1]
$CheckRoot= $args[2]
$CheckTarget= $args[3]
$InstallCommand= $args[4]
$UninstallCommand= $args[5]
$Description= $args[6]
$Publisher= $args[7]
$AppVersion= $args[8]

Write-Output "ClientID: $ClientID
ClientSecret: $ClientSecret
TenantID: $TenantID
AppName: $AppName
IntuneWinFile: $IntuneWinFile
CheckRoot: $CheckRoot
CheckTarget: $CheckTarget
InstallCommand: $InstallCommand
UninstallCommand: $UninstallCommand
Description: $Description
Publisher: $Publisher
AppVersion: $AppVersion"

Connect-MSIntuneGraph -TenantID $TenantID -ClientID $ClientID -ClientSecret $ClientSecret
$RequirementRule = New-IntuneWin32AppRequirementRule -Architecture "x64" -MinimumSupportedWindowsRelease "W10_1607"
$DetectionRule = New-IntuneWin32AppDetectionRuleFile -Existence -Path $CheckRoot -FileOrFolder $CheckTarget -DetectionType "exists"
Add-IntuneWin32App -FilePath $IntuneWinFile -DisplayName $AppName -Description $Description -Publisher $Publisher -AppVersion $AppVersion -InstallExperience "system" -RestartBehavior "suppress" -DetectionRule $DetectionRule -RequirementRule $RequirementRule -InstallCommandLine $InstallCommand -UninstallCommandLine $UninstallCommand
