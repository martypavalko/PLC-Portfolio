#get max password age policy
$maxPwdAge=(Get-ADDefaultDomainPasswordPolicy).MaxPasswordAge.Days

#expiring in 7 days

Get-ADUser -filter {Enabled -eq $True -and PasswordNeverExpires -eq $False -and PasswordLastSet -gt 0} -Properties * |
where-object {($_.PasswordLastSet).AddDays(90).ToShortDateString() -ge (Get-Date).ToShortDateString() -and ($_.PasswordLastSet).AddDays(90).ToShortDateString() -le (Get-Date).ToShortDateString()} |
Select-Object -Property "SamAccountName", @{n="ExpiryDate";e={$_.PasswordLastSet.AddDays($maxPwdAge).ToShortDateString()}} |
Sort-Object ExpiryDate -Ascending | 
Out-File expired.txt