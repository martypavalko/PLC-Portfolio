$pathToDeleteFrom = "C:\$pos\log_dir"
$daysToKeep = -90
$currentDate = Get-Date
$dateToDelete = $currentDate.AddDays($daysToKeep)
Get-ChildItem $pathToDeleteFrom | Where-Object { $_.LastWriteTime -lt $dateToDelete } | Remove-Item