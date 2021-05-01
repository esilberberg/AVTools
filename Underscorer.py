# Run inside directory to create copy of all files with whitespace in filename and
# will replace whitespace with underscores " _ " in copy filenames.

import os
import re
import shutil

if not os.path.exists('renamed_files'):
    os.makedirs('renamed_files')

directory = os.getcwd()
files = os.listdir(directory)

for f in files:
    if re.findall(r"\s", f):
        basename = os.path.splitext(f)
        underscored = basename[0].replace(" ", "_")
        newname = underscored + basename[1]
        shutil.copy2(f, r'renamed_files\\' + newname)

output_dir = os.listdir("renamed_files")
number_renamed = len(output_dir)

print(
    f'You renamed {number_renamed} files.')


# Alternative: To rename files in director
# os.rename(file, newname)
