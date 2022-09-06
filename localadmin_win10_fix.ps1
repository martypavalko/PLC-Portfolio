Get-ChildItem -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\ProfileList" |
Where-Object {$_.GetValue('ProfileImagePath') -like "*Administrator*"} |
if ($_.Name -like "*.bak" ) {Rename-Item -NewName {$_.Name -replace "\.txt", ""}}
shutdown.exe -r