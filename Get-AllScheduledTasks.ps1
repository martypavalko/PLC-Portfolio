Add-Type -AssemblyName System.Windows.Forms

function Get-FileName($InitialDirectory)
{
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.InitialDirectory = $InitialDirectory
    $OpenFileDialog.filter = "CSV (*.csv) | *.csv"
    $OpenFileDialog.ShowDialog() | Out-Null
    $OpenFileDialog.FileName

    #return $OpenFileDialog.FileName
}

$servers = Import-Csv -Path (Get-FileName) -Header "Servers" | Select-Object -Unique "Servers"

# Write-Host $Error

foreach ($server in $servers) {
    $cim = New-CimSession -ComputerName $server.Servers -ErrorAction Continue
    if ($null -eq $Error) {
        Get-ScheduledTask -CimSession $cim
    } else {
        Write-Error -Message "ERROR: Cannot establish Cim Session to remote host.  Please try again with the correct hostnames or make sure the server is reachable."
    }
}