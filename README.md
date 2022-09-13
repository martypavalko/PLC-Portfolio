# PLC PORTFOLIO

## GO (Golang)

### api_custom_reporting

## Powershell

### aclfix.ps1
Approximate Time Investment: 4 hours

Accomplishments:

This script is designed to read access lists (ACL) for folder permissions from a user-provided CSV file.  The script will read the ACLs and then apply them to the folder provided by the user.  This was an early design to quickly migrate or copy permissions from one share on a Windows File server to another share.

### activedirectory-newpc.ps1
Approximate Time Investment: 4 hours

Accomplishments: Accurately accounted for when PCs are added to the domain, allowing for reporting of when PCs are added to the incorrect Organization Units 

This script was intended to regularly notify me of when PCs were added to our domain.  We were having a regularly occurring problem on our helpdesk, where PC's, once added to the domain, were not being placed into the correct organizational units (OUs).  This script was set up as a scheduled task on my computer that would run every Friday at 9:00 AM.  It would allow me to quickly spot PCs that were not moved to the correct OUs and I was able to correct it that very same week.  This was one of the first scripts that I wrote at my job, so it took quite a bit of research to plug it all together, but I found some pieces online to figure out how to accomplish this task.
### PSTFileFinder.ps1
Approximate Time Investment 20+ hours

Accomplishments: Reported an accurate count of the .pst files that exist on a share.

We had a reoccurring issue of running out of space on a volume that was attached to a certain file server.  We identified that there were a siginificant number of Outlook (.pst) files saved on the share.  To see just how big this problem was, I designed this script.  It iterates through a predefined list of users, or with a little midification, all users, and then iterates through their particular share.  From there it filters to just the .pst extenstion and returns the number of that file type.  It adds it all up and displays who has how many PST files and how mych space is being taken up.

### RDSHPUserProfilePurger.ps1
Approximate Time Investment: 30+ hours

Accomplishments: Clears user profiles from remote desktop session hosts when users call in saying that they cannot connect to the sessions.

This script is used to purge user profiles from remote desktop session hosts.  First it takes the username of the user that is having an issue.  Once inputted, it cycles through the session hosts and tests to make sure a profile has been created for the user.  If it has, it deletes it and the corresponding registry entry.  It then goes to the repository where roaming profiles are stores, and it purges them from there as well.

### get-unusedmailboxes.ps1
Approximate Time Investment: 20 hours

Accomplishments: Purges unused mailboxes from Exchange servers allowing us to conserve more storage.

This script, though it looks short and simple, took a long time for me to get working correctly.  It retrieves a list of mailboxes from an organizational unit, then it checks the permissions of each mailbox.  If no one else has access to it, then it adds the mailbox to an array.  Once iterations conclude, it iterates through the 

## Python

### query_devices.py
Approximate Time Investment: 20 hours

Accomplishments: Successfully scripted a menas to communicate with a vendor's API.  This API will aid in reporting and analytics for the systems administration team at AVI.

This script's intention is to streamline a way to retrieve data from one of our purchased products.  

### TBMigrated.py
Approximate Time Investment: 12 hours

Accomplishments: Kept accurate accounting of what users' data has been migrated to a central repository during Windows 10 rollout.

This script was written during my time on the service desk at AVI.  We were in the process of migrating our users off of their Windows 7 operating system and onto Windows 10.  In most cases we did in-place upgrades, but a little untraditionally.  We would take their computer, back up the data to a file server that we spun up, re-image their computer to Windows 10, and move the data back.  The data migration takes place in another script, but this script in particular checks the share on the file server that we are using.  It checks the data that's been migrated and gives me a list of those users so I can compare it to the list of users that have been marked as completed.

## JavaScript

### sortSheetsByName.js
Approximate Time Investment: 4 hours
Accomplishments: Successfully created a method to sort a Google Sheet by the sheet names.

This was designed to sort sheets on our POS quoting spreadsheet by sheet title, excluding one sheet.  We typically organize the sheets by date, but after so many quotes are processed in a year, the sheets become cluttered and unorganized.