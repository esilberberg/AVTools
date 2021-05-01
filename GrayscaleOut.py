import os
import glob
from PIL import Image

if not os.path.exists('Grayscale_images'):
    os.makedirs('Grayscale_images')

images = glob.glob('*.jpg')

for i in images:
    im = Image.open(i)
    grayscale = im.convert('L')
    grayscale.save('Grayscale_images\\' + 'Grayscale_' + i[:-4] + '.jpg')

grayscale_videos = glob.glob(r'Grayscale_images\*.jpg')
number_converted = len(grayscale_videos)

print(
    f'You converted {number_converted} files to grayscale.')
