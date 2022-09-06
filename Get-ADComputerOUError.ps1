# $today = Get-Date -Format "yyyyMMdd"
$sevenDays = [DateTime]::Today.AddDays(-7)
$activeDirectoryReport = Get-ADComputer -Filter "whenCreated -ge $sevenDays" -Properties whenCreated,CanonicalName | Select-Object Name,whenCreated,CanonicalName

foreach ( $item in $activeDirectoryReport )
{
    if ( $item -like "*{{OU 1}}*" )
    {
        Write-Host $item
    }
}