$mailboxes = Get-Mailbox -OrganizationalUnit "Disabled Users" -ResultSize unlimited
foreach ($mailbox in $mailboxes) {
   
    $permissions = Get-MailboxPermission $mailbox| Where-Object { $_.IsInherited -eq $false -and $_.AccessRights -like "FullAccess*" }

#$mailbox.Alias 


    $i = 0
   
    foreach ($permission in $permissions) {

        if ($permission.User.securityidentifier -ne "S-1-5-10"){
        $i +=1
        }
    }

    if ($i -eq 0) {
        
           Write-Host $mailbox.Alias
                
        }

}



