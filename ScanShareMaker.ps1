# Iterate through username (samid) from csv
# Verify username (samid) exists on AD
# If it does exist in AD return the full name
# Search AD with the full name and return the samid
# Prompt for path to create folders
# Make directories named for each username (samid) at input path
# Set NTFS Permissions for the new directories with the corresponding username (samid)

$dir = C:\Users\$env:USERNAME

$scanFolderCsv = Import-Csv -Path $dir\Documents\ScanFolders.csv

$scanFolderCsv | Get-Member

cmd /c pause | out-null