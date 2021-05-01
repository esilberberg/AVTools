from PIL import Image
img = input('Enter webp file: ')
convert_img = Image.open(img).convert("RGB")
convert_img.save(img[:-5] + '.jpg', "jpeg")
