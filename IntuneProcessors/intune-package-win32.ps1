$Source= $args[0]
$Destination = $args[1]
$FileName = $args[2]

Write-Output "Begin Packaging..."
Start-DownloadFile -URL "https://github.com/microsoft/Microsoft-Win32-Content-Prep-Tool/raw/master/IntuneWinAppUtil.exe" -Path $env:TEMP -Name "IntuneWinAppUtil.exe"
$IntuneWinAppUtilPath = Join-Path -Path $env:TEMP -ChildPath "IntuneWinAppUtil.exe"
$PackageInvocation = Invoke-Executable -FilePath $IntuneWinAppUtilPath -Arguments "-c ""$($SourceFolder)"" -s ""$($SetupFile)"" -o ""$($OutPutFolder)"" -q" -RedirectStandardOutput $false -RedirectStandardError $false -CreateNoWindow $false -UseShellExecute $true

Write-Output "Packaging Complete"
