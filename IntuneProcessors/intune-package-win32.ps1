$Source= $args[0]
$Destination = $args[1]
$FileName = $args[2]

Write-Output "Begin Packaging..."
Start-DownloadFile -URL "https://github.com/microsoft/Microsoft-Win32-Content-Prep-Tool/raw/master/IntuneWinAppUtil.exe" -Name "IntuneWinAppUtil.exe"
& ".\IntuneWinAppUtil.exe" -c $Source -s $FileName -o $Destination -q

Write-Output "Packaging Complete"
