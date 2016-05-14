#
#
#

import time
import grovepi
from datetime import datetime
from grove_rgb_lcd import *
# Connect the Grove Button to digital port D3 and D4
# SIG,NC,VCC,GND
in_button_pin = 3
out_button_pin = 4

grovepi.pinMode(in_button_pin,"INPUT")
grovepi.pinMode(out_button_pin,"INPUT")

while True:
    try:
	in_button = grovepi.digitalRead(in_button_pin)
    except IOError:
        print "In button error"

    try:
	out_button = grovepi.digitalRead(out_button_pin)
    except IOError:
        print "Out button error"
    print "%s In button (3) : %d , Out button (4) : %d" % (datetime.now().strftime("%Y/%m/%d %H:%M:%S"), in_button , out_button)
    time.sleep(.5)
# Grovepi + grove RGB LCD module
 
# Example for using the Grove I2C color LCD
from grove_rgb_lcd import *

while(True):
    setText("Hello world\nLCD test")
    setRGB(0,128,64)
    for c in range(0,255):
        setRGB(c,255-c,0)
        time.sleep(0.01)
    setRGB(0,255,0)
    setText("Bye bye, this should wrap")
    time.sleep(1.5)
