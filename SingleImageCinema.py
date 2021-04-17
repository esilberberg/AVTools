# Run in target directory.
# Creates videos with available mp3's and selected image

import glob
import os
import shutil

print('~*~ Single Image Cinema ~*~')
image = input('Drag and drop the image: ')

tracks = glob.glob('*.mp3')

if not os.path.exists('Single_Image_Cinema'):
    os.makedirs('Single_Image_Cinema')

output_folder = 'Single_Image_Cinema'

for track in tracks:
    output_name = os.path.splitext(track)[0]
    os.system(
        f"ffmpeg -loop 1 -y -i {image} -i {track} -shortest -acodec copy -vcodec mjpeg {output_name}.mp4")

videos = glob.glob('*.mp4')
for video in videos:
    shutil.move(video, output_folder)
