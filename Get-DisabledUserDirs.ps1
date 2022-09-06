$disabledUsers = @()

$disabledUsers += ((get-aduser -Filter "Enabled -eq 'False'" -SearchBase "OU=Disabled Users,DC=$dc").samaccountname)

foreach ($user in $disabledUsers) {
    $userDirPath = "$fileServerUsersShare\$user"
    if (Test-Path -Path $userDirPath) {
        # Write-Host $user $size
        $size = (Get-ChildItem $userDirPath -Recurse | Measure-Object -Property Length -Sum -ErrorAction SilentlyContinue).Sum/1GB
        # Write-Host $user $size
        $userDirSizes = [PSCustomObject]@{
            'User' = $user
            'Size (GB)' = $size
        }
        $userDirSizes | Export-Csv -Path "C:\Users\$env:USERNAME\Desktop\userdirsizes.csv" -Append -NoTypeInformation -Force
    }

    # Write-Host "$user - $size"
}