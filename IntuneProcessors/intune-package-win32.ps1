$Source= $args[0]
$Destination = $args[1]
$FileName = $args[2]

Write-Output "Acquiring Win32 Content Prep Tool"
Invoke-WebRequest -Uri "https://github.com/microsoft/Microsoft-Win32-Content-Prep-Tool/raw/master/IntuneWinAppUtil.exe" -Outfile "IntuneWinAppUtil.exe"

Write-Output "Begin Packaging..."
& ".\IntuneWinAppUtil.exe" -c $Source -s $FileName -o $Destination -q
Write-Output "Packaging Complete"
