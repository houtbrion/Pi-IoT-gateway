#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# モジュールのロード
#
import time
import grovepi
from datetime import datetime
#from grove_rgb_lcd import *
#import commands
#
# グローバル変数の定義 (C言語の #define の代わり)
#
light_sensor_pin = 3
dht_pin = 4
debug = 1
# dht(pin,module_type), change module_type number to use other kind of dht
# module_type:
#             DHT11 0
#             DHT22 1
#             DHT21 2
#             DHT2301 3
DHTtype = 0
#
#
def sensorCheck(dht_pin, light_sensor_pin, DHTtype):
    try:
        light_value = grovepi.analogRead(light_sensor_pin)
    except IOError:
        return "error"
    try:
        [temp,humidity] = grovepi.dht(dht_pin,DHTtype)
    except IOError:
        return "error"
    result = "%s temp = %.1f , humidity = %.1f , light = %d" % (datetime.now().strftime("%H:%M:%S "), temp, humidity, light_value)
    return result

#
# 以下メイン処理
#
if __name__ == "__main__":
#
# ピンの読み取り設定
#
    grovepi.pinMode( light_sensor_pin, "INPUT")
    grovepi.pinMode( dht_pin, "INPUT")

#
# メインループ
#
    while True:
        result = sensorCheck(dht_pin, light_sensor_pin, DHTtype)
        print result
        time.sleep(1)

