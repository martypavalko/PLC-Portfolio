:: Clear the current taskbar
DEL /F /S /Q /A "%AppData%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\*"
REG DELETE HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband /F

:: Add IE, Chrome, Outlook, and Explorer to taskbar
CD "%AppData%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\"
MKLINK "Internet Explorer" "C:\Program Files\internet explorer\iexplore.exe"
MKLINK "Google Chrome" "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
MKLINK "Microsoft Outlook" "C:\Program Files (x86)\Microsoft Office\Office14\OUTLOOK.EXE"
MKLINK "File Explorer" "C:\Windows\explorer.exe"

taskkill /f /im explorer.exe

start explorer.exe