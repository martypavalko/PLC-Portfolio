# Set properties
$identity = "{{GROUP}}"
$fileSystemRights = "{{RIGHTS}}"
$type = "{{TYPE}}"
$inheritanceFlags = "{{INHERITANCE}}"
$rule = @($identity, $fileSystemRights, $inheritanceFlags, "None", $type)
$sharesThatNeedModifiedACLS = @()

foreach ($share in Get-SmbShare | Where-Object { $_.Path -like "*{{PATTERN}}*" } | Sort-Object -Property Path ) {
    $incorrectACL = 0
    $acl = Get-Acl -Path $share.Path
    foreach ($access in $acl.Access) {
        if ($access.IdentityReference -eq $identity) {
            $incorrectACL = 1
        }
    }
    if ($incorrectACL -eq 0) {
        $sharesThatNeedModifiedACLS += $share.Path
    }
}

$fileSystemAccessRule = New-Object -TypeName System.Security.AccessControl.FileSystemAccessRule -ArgumentList $rule

foreach ($share in $sharesThatNeedModifiedACLS) {
    # Create new rule
    # Apply new rule
    $acl = Get-Acl -Path $share
    $acl.AddAccessRule($fileSystemAccessRule)
    Set-Acl -Path $share -AclObject $acl
    Write-Host "Modified ACLs for $share"
    # Read-Host
}

# $sharesThatNeedModifiedACLS