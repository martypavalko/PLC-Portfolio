# PLC PORTFOLIO

## Powershell

#### aclfix.ps1
Approximate Time Investment: 4 hours
Accomplishments:

This script is designed to read access lists (ACL) for folder permissions from a user-provided CSV file.  The script will read the ACLs and then apply them to the folder provided by the user.  This was an early design to quickly migrate or copy permissions from one share on a Windows File server to another share.

#### activedirectory-newpc.ps1
Approximate Time Investment: 4 hours
Accomplishments: Accurately accounted for when PCs are added to the domain, allowing for reporting of when PCs are added to the incorrect Organization Units 

This script was intended to regularly notify me of when PCs were added to our domain.  We were having a regularly occurring problem on our helpdesk, where PC's, once added to the domain, were not being placed into the correct organizational units (OUs).  This script was set up as a scheduled task on my computer that would run every Friday at 9:00 AM.  It would allow me to quickly spot PCs that were not moved to the correct OUs and I was able to correct it that very same week.  This was one of the first scripts that I wrote at my job, so it took quite a bit of research to plug it all together, but I found some pieces online to figure out how to accomplish this task.

## Python

#### query_devices.py
Approximate Time Investment: 20 hours
Accomplishments: Successfully scripted a menas to communicate with a vendor's API.  This API will aid in reporting and analytics for the systems administration team at AVI.

This script's intention is to streamline a way to retrieve data from one of our purchased products.  

#### TBMigrated.py
Approximate Time Investment: 12 hours
Accomplishments: Kept accurate accounting of what users' data has been migrated to a central repository during Windows 10 rollout.

This script was written during my time on the service desk at AVI.  We were in the process of migrating our users off of their Windows 7 operating system and onto Windows 10.  In most cases we did in-place upgrades, but a little untraditionally.  We would take their computer, back up the data to a file server that we spun up, re-image their computer to Windows 10, and move the data back.  The data migration takes place in another script, but this script in particular checks the share on the file server that we are using.  It checks the data that's been migrated and gives me a list of those users so I can compare it to the list of users that have been marked as completed.

## JavaScript

#### sortSheetsByName.js
Approximate Time Investment: 4 hours
Accomplishments: Successfully created a method to sort a Google Sheet by the sheet names.

This was designed to sort sheets on our POS quoting spreadsheet by sheet title, excluding one sheet.  We typically organize the sheets by date, but after so many quotes are processed in a year, the sheets become cluttered and unorganized.