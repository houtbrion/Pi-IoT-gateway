#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# モジュールのロード
#
import time
import grovepi
from datetime import datetime
from grove_rgb_lcd import *
import commands
#
# グローバル変数の定義
#
in_button_pin = 3
out_button_pin = 4
debug = 1

#
# ボタン読み取り関数
#   -1 : ボタン読み取りエラー
#    0 : 変化なし
#    1 : 入室ボタンが押された
#    2 : 退出ボタンが押された
#    3 : 両方押された
#
def checkButtons(in_button_pin, out_button_pin):
    try:
	in_button = grovepi.digitalRead(in_button_pin)
    except IOError:
        print "In button error"
        return -1
    try:
	out_button = grovepi.digitalRead(out_button_pin)
    except IOError:
        print "Out button error"
        return -1
    print "%s In button (3) : %d , Out button (4) : %d" % (datetime.now().strftime("%Y/%m/%d %H:%M:%S"), in_button , out_button)
    if in_button == 0 and out_button == 0:
        return 0
    if in_button == 0 and out_button == 1:
        return 2
    if in_button == 1 and out_button == 0:
        return 1
    if in_button == 1 and out_button == 1:
        return 3
#
# ボタンが押された時に行う処理(関数)
#   NFCやビーコンのIDを読み取り，名前などに変換してその結果を返す．
#   現状はなにを読み取るか決まっていないのでダミー
#
def sensorCheck():
    # 本来は以下の様な外部コマンドでセンサを読んで，変換する．
    # result = commands.getoutput("/usr/local/bin/readSensor")
    # コマンドの返り値は"error"か"実際の人の名前などの文字列"
    result = "XXXX"
    return result

#
# 読み取り結果の出力
#
def displayOutput(name, button):
    if button == 1:
        state="Hello Mr."
    else:
        state="Bye Mr."
    output = datetime.now().strftime("%Y/%m/%d %H:%M:%S") +  state + name
    printMessage(output)
    #setText(output)
    setRGB(0,128,64)
    time.sleep(10)
#
# 読み取り準備完了の表示
#
def displayReady():
    printMessage("Ready")
    #setText("Ready")
    setRGB(0,128,64)
#
# 読み取りエラーの表示
#
def displayError():
    printMessage("Error\nPlease retry.")
    #setText("Error\nPlease retry.")
    setRGB(0,128,64)
    time.sleep(.5)
#
# LCDとコンソールへのメッセージの出力
#
def printMessage(string):
    setText(string)
    if debug==1:
        print "%s" % string
#
# 以下メイン処理
#
if __name__ == "__main__":
#
# グローバル変数の定義
#
#    in_button_pin = 3
#    out_button_pin = 4
#
#
# ピンの読み取り設定
#

    grovepi.pinMode(in_button_pin,"INPUT")
    grovepi.pinMode(out_button_pin,"INPUT")

#
# メインループ
#   動作イメージ
#     ボタンの変化を監視
#     なにか処理をする(処理結果の文字列を生成)
#     LCDとコンソールに出力する
    while True:
        displayReady()
        buttonState = checkButtons(in_button_pin, out_button_pin)
        if buttonState != 0:
            name = sensorCheck()
            if buttonState < 0 or buttonState == 3 or name=="error":
                displayError()
            else:
                displayOutput(name,buttonState)
        time.sleep(.5)

