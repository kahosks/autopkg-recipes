Set-PSRepository PSGallery -InstallationPolicy Trusted
Install-Module -Name "IntuneWin32App" 

$ClientID= $args[0]
$ClientSecret= $args[1]
$TenantID= $args[2]
$AppName= $args[3]
$IntuneWinFile= $args[4]
$CheckRoot= $args[5]
$CheckTarget= $args[6]
$InstallCommand= $args[7]
$UninstallCommand= $args[8]
$Description= $args[9]
$Publisher= $args[10]
$AppVersion= $args[11]

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
