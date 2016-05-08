#!/bin/sh

#
# ・ArduinoをRaspberry Piに繋いだ時のシリアルポート /dev/ttyACM0
# ・IntervalPush.awk Arduinoから出るデータから意味のあるデータを取り出し，
#   時刻を付けるプログラム
# ・hoge2.txt : ログを蓄積するログファイル
cat /dev/ttyACM0 |gawk -f IntervalPush.awk |tee hoge2.txt

