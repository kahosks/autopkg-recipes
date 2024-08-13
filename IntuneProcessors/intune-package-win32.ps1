Set-PSRepository PSGallery -InstallationPolicy Trusted
Install-Module -Name "IntuneWin32App" 

$Source= $args[0]
$Destination = $args[1]
$FileName = $args[2]

Write-Output "Begin Packaging..."
New-IntuneWin32AppPackage -SourcePath $Source -DestinationPath $Destination -SetupFile $FileName
Write-Output "Packaging Complete"
