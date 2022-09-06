function PSTFileFinder() {
    param (
        $usersToInclude
    )

    $userShareSize = New-Object System.Collections.Generic.Dictionary"[String,Int]"
    $fileExtensions = @(".pst", ".bak")

    if ($null -eq $usersToInclude) {

        $pathToUserDirs = $fileShareUsersShare

        foreach ($userDir in (Get-ChildItem $pathToUserDirs)) {

            $size = 0

            foreach ($fileExtension in $fileExtensions) {

                $size = $size + (Get-ChildItem $userDir -Recurse | Where-Object {$_.Extension -in $fileExtension} | Measure-Object -Property Length -Sum -ErrorAction SilentlyContinue).Sum/1GB
            }

            $userShareSize.Add($userDir, $size)
        }

        $userShareSize | Format-Table

    }
    else {
        foreach ($user in $usersToInclude) {
            $size = 0

            foreach ($fileExtension in $fileExtensions) {

                $size = $size + (Get-ChildItem "$fileShareUsersShare\$user" -Recurse | Where-Object {$_.Extension -in $fileExtension} | Measure-Object -Property Length -Sum -ErrorAction SilentlyContinue).Sum/1GB
            }

            Write-Host $size

            $userShareSize.Add("$fileShareUsersShare\$user", $size)
        }

        $userShareSize | Format-Table
    }
}

$usersToInclude = @("$user")

PSTFileFinder -usersToInclude $usersToInclude