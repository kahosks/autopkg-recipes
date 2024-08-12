Set-PSRepository PSGallery -InstallationPolicy Trusted
Install-Module -Name SvRooij.ContentPrep.Cmdlet

$Source= $args[0]
$Destination = $args[1]
$FileName = $args[2]


Write-Output "Begin Packaging..."
New-IntuneWinPackage -SourcePath $Source -DestinationPath $Destination -SetupFile $FileName
Write-Output "Packaging Complete"