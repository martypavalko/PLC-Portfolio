while($true)
{
    Write-Host "What is the hostname of the remote PC?"
    $name = Read-Host
    Get-WmiObject -Class Win32_Product -Computer $name | Select-Object Name, Version | Export-CSV "C:\Users\$env:USERNAME\Desktop\"+$name+"_programs.csv" -Append -NoTypeInformation;
    $res = Read-Host "Would you like to look up another remote PC?"
    if($res.ToLower() -eq 'y')
    {
        continue
    }
    else
    {
        break
    }
}