# ビーコン検出

BLEのビーコンを読みだす．

## ハードの準備
今回は，Raspberry Pi2を利用しているため，Bluetoothは
USB接続のものを利用．

## インストール
OSには，使ったBluetoothアダプタ用のドライバ，bluezもインストール済み
であったが，bluez付属のプログラムがインストールされていなかったため，
それだけを追加インストール．

```
# apt-get install bluez-hcidump
```

## 参考文献
### 考え方や手順などの参考文献
* [http://qiita.com/katsuyoshi/items/9d5417495a47c4b15ac1](http://qiita.com/katsuyoshi/items/9d5417495a47c4b15ac1)
* [http://d.hatena.ne.jp/kaito834/20130119/1358524567](http://d.hatena.ne.jp/kaito834/20130119/1358524567)
* [http://tomosoft.jp/design/?p=3981](http://tomosoft.jp/design/?p=3981)
* [http://rpd7.tomolog.info/knowledge/raspberrypi/07\_hcitool.html](http://rpd7.tomolog.info/knowledge/raspberrypi/07_hcitool.html)

### 解析スクリプト
* [http://stackoverflow.com/questions/21733228/can-raspberrypi-with-ble-dongle-detect-ibeacons](http://stackoverflow.com/questions/21733228/can-raspberrypi-with-ble-dongle-detect-ibeacons)



