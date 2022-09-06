$enabledDisabledUsersQuery = Get-ADUser -Filter "Enabled -eq 'True'" -SearchBase "OU=Disabled Users,DC={{DOMAIN}}" | Select-Object name,distinguishedname,enabled


if ($enabledDisabledUsersQuery) {
    
    $MessageParameters = @{
        Subject = "ALERT: Enabled User Moved to Disabled Users OU"
        Body = $enabledDisabledUsersQuery
        From = "it_reports@example.com"
        To = "martypavalko@example.com"
        SmtpServer= "mail.example.com"
    }
    Send-MailMessage @MessageParameters -BodyAsHTML
}