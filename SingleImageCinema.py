# Run in target directory. Creates videos with available mp3's and the selected image.

import glob
import os
import shutil
import subprocess


print('~*~ Single Image Cinema ~*~')
image = input('Drag and drop the image: ')


tracks = glob.glob('*.mp3')

if not os.path.exists('Single_Image_Cinema'):
    os.makedirs('Single_Image_Cinema')

output_folder = 'Single_Image_Cinema'


for track in tracks:
    input_name = f' "{track}" '
    output_name = input_name[:-6]
    subprocess.run(
        f"ffmpeg -loop 1 -y -i {image} -i {input_name} -shortest -acodec copy -vcodec mjpeg {output_name}.mp4")


videos = glob.glob('*.mp4')
for video in videos:
    shutil.move(video, output_folder)

new_videos = os.listdir('Single_Image_Cinema')

videos_count = len(new_videos)

print(
    f'Single Image Cinema created {videos_count} videos.')

input("Press enter to exit")
