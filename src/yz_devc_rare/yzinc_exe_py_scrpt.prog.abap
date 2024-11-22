#-*- coding: iso-8859-15 -*-
import pytesseract
from PIL import Image

#pytesseract.pytesseract.tesseract_cmd = r'/usr/local/bin/pytesseract'
pytesseract.pytesseract.tesseract_cmd = r'/usr/bin/tesseract'
#print("Test Output")
#print(pytesseract.image_to_string(Image.open(r'/hana/log/Python_MDG_Files/we will win.png')))

print(pytesseract.image_to_string(Image.open(r'%FILE_PATH%')))
