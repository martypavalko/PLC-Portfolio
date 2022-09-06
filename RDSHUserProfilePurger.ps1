Write-Host "==============================="
Write-Host "RDSH USER PROFILE PURGER v.0.4"
Write-Host "==============================="

$username = Read-Host "Enter the username for the profile you would like to purge: "

# BRAPP SERVERS
for ($i = 1; $i -le $num; $i += 1)
{
    $userProfilePath = "\\rdsh-$i\C$\Users\$username"
    # $userProfileRegKey = Get-ChildItem $pathToRegKey | Where-Object {$_.GetValue('ProfileImagePath') -eq "C:\Users\$username"}

    if (Test-Path -Path $userProfilePath)
    {
        Remove-Item -Path $userProfilePath -Recurse -Force
        Write-Host "Removed $userProfilePath from RDSH-$i"
    }
    else {
        Write-Host "User profile: $userProfilePath does not exist on RDSH-$i"
    }

    Invoke-Command -ComputerName "rdsh-$i" -ScriptBlock { 
        param($username)
        Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\*" | Where-Object { $_.ProfileImagePath -eq "C:\Users\$username" } | Remove-Item 
    } -ArgumentList $username
    Write-Host "Removed registry key for $username on RDSH-$i"

}

$roamingProfilePath = "$fileServerProfilesShare\$username"
$roamingProfilePathV2 = $roamingProfilePath+".{{DOMAIN}}.V2"
$roamingProfilePathV6 = $roamingProfilePath+".{{DOMAIN}}.V6"


if (Test-Path -Path $roamingProfilePathV2)
{
    Remove-Item -Path $roamingProfilePathV2 -Recurse -Force
    Write-Host "Removed $roamingProfilePathV2"
}
if (Test-Path -Path $roamingProfilePathV6)
{
    Remove-Item -Path $roamingProfilePathV6 -Recurse -Force
    Write-Host "Removed $roamingProfilePathV6"
}