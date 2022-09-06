# # * User input for path to create dirs

$folder = Read-Host "Enter path to folder: "

# Write-Host $folder

# Prompt for the script user to select the CSV with the stored names/user names
Write-Host "Please select a CSV file to import"
$ofd = New-Object -TypeName System.Windows.Forms.OpenFileDialog
$ofd.Filter = "CSV files (*.csv) | *.csv"
$ofd.ShowDialog()
# Set $import to the script user's selected file path
$import = $ofd.FileName

$csv = Import-Csv $import

# Set working directory to the script user's selected destination to create the new fodlers in
Set-Location $folder

foreach($row in $csv)
{
   # Create a variable to hold the current iteration's samid for easier use
   $samid = $row.samid

   # Retrieve the ACL permissions of the newly created folder
   $acl = Get-Acl "$folder\$samid"
   # Creates the Modify rule for the user
   $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("$domain\$samid", "Modify", "ContainerInherit,ObjectInherit", "Allow", "Allow")
   # Applies the new rule to the ACL rules that were retreived
   $acl.SetAccessRule($AccessRule)
   # Applies the permissions to the folder itself
   $acl | Set-Acl "$folder\$samid"
}