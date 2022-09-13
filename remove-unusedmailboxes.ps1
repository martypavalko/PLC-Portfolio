$mailboxes = Get-Mailbox -OrganizationalUnit "$ou" -ResultSize unlimited
foreach ($mailbox in $mailboxes) {
   
    $permissions = Get-MailboxPermission $mailbox| Where-Object { $_.IsInherited -eq $false -and $_.AccessRights -like "FullAccess*" }

#$mailbox.Alias 


    $i = 0
   
    foreach ($permission in $permissions) {

        if ($permission.User.securityidentifier -ne "$sid"){
        $i +=1
        }
    }

    if ($i -eq 0) {
        
           remove-mailbox -identity $mailbox.Alias -confirm:$false
                
        }

}



