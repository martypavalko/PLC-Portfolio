import os, os.path
from pathlib import Path

print('Users that need their data migrated:')
list_of_files = os.listdir('\\\\{{SHARE}}')
for f in list_of_files:
   if os.path.isdir('\\\\{{SHARE}}\\'+f):
      dirs = os.listdir('\\\\{{SHARE}}\\'+f)
      for subdir in dirs:
         files_in_subdir = []
         files_in_subdir.append(subdir)
      if not "migrated_data.log" in files_in_subdir:
         print(f)