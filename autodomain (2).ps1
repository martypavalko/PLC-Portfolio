function GetOU()
{
   $OUPath
   $parentOU
   $gettingOU = $true

   while($gettingOU)
   {
      $whatOU = Read-Host -Prompt "What OU does this machine belong in?`n[1] {{OU 1}}`n[2] {{OU 2}}"

      if($whatOU -eq 1)
      {
         $parentOU = 'OU 1, OU 2'

         $laptopOrDesktop = Read-Host -Prompt "Is this a laptop or a desktop?`n[1] Laptop`n [2] Desktop"

         if($laptopOrDesktop -eq 1)
         {
            $OUPath = 'Laptops'
            $gettingOU = $false
         }
         elseif($laptopOrDesktop -eq 2)
         {
            $OUPath = 'Desktops'
            $gettingOU = $false
         }
         else
         {
            Write-Host 'ERROR! Try again!' -ForegroundColor Red
            $gettingOU = $true
         }
      }
      elseif($whatOU -eq 2)
      {
         $parentOU = '{{OU 2}}'
         $OUPath = 'Computers'
         $gettingOU = $false
      }
   }
   
   $OU = "$($parentOU), $($OUPath)"

   return $OU

}

$credential = Get-Credential
$hostname = Read-Host -Prompt "What is the new name for this machine?"
$OUPath = GetOU

Write-Host $credential
Write-Host $hostname
Write-Host $OUPath

cmd /c pause