function MediaFileFinder() {
    param (
        $usersToInclude
    )

    $userShareSize = New-Object System.Collections.Generic.Dictionary"[String,Int]"
    $fileExtensions = @(".aif",".cda",".mid",".midi",".mp3",".mpa",".ogg",".wav",".wma",".wpl",".3g2",".3gp",".avi",".flv",".h264",".m4v",".m4a",".mkv",".mov",".mp4",".mpg",".mpeg",".rm",".swf",".vob",".wmv")

    if ($null -eq $usersToInclude) {

        $pathToUserDirs = $fileServerUsersShare

        foreach ($userDir in (Get-ChildItem $pathToUserDirs)) {

            $size = 0

            foreach ($fileExtension in $fileExtensions) {

                $size = $size + (Get-ChildItem $userDir -Recurse | Where-Object {$_.Extension -in $fileExtension}).Sum/1GB
            }

            $userShareSize.Add($userDir, $size)
        }

        $userShareSize | Format-Table | Out-File "\\$automationServer\C$\scripts\MediaFileFinder.log"

    }
    else {
        foreach ($user in $usersToInclude) {
            $size = 0

            foreach ($fileExtension in $fileExtensions) {

                $size = $size + (Get-ChildItem "$fileServerUsersShare\$user" -Recurse | Where-Object {$_.Extension -in $fileExtension}).Sum/1GB
            }

            $userShareSize.Add("$fileServerUsersShare\$user", $size)
        }

        $userShareSize | Format-Table
    }
}

$usersToInclude = @($user)

MediaFileFinder -usersToInclude $usersToInclude