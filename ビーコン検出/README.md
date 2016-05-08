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

## Bluetoothの周辺機器の探し方
Linuxのコマンドラインプログラムを使って，周辺にあるBluetoothの機器を見つける．
シェルのウィンドウを2つ開いて，hcidumpとhcitoolを別のウィンドウで動作させる．

### 受信したパケットのダンプ
片方のshellでhcidumpコマンドを動作させる．すると，受信したパケットのダンプが
画面に出力される．

```
# hcidump -R
```

### 周辺機器を探すコマンド
もう一方のshellでhcitoolコマンドを実行すると，hcidumpの画面に
受信したパケットが出力される．

#### Bluetoothの場合
```
# hcitool scan
```

#### BLEの場合

```
# hcitool lescan
```

## 解析スクリプト
参考文献にも挙げた，Radius Networksが公開しているビーコン検出用のスクリプト`ibeacon_scan`
を利用すると，アドバタイズしているビーコンのリストを得ることができる．

参考文献にも挙げた，Radiusが公開しているフォーラムへの書き込みから利用例は
以下の通り．

通常の使い方．
```
$ ./ibeacon_scan
UUID: 74278BDA-B644-4520-8F0C-720EAF059935 MAJOR: 0 MINOR: 73 POWER: -50
UUID: 2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6 MAJOR: 1 MINOR: 6 POWER: -59
UUID: E2C56DB5-DFFB-48D2-B060-D0F5A71096E0 MAJOR: 6 MINOR: 9 POWER: -55
```

他のプログラムと連結して用いる場合．
```
$ ./ibeacon_scan -b
2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6 1 6 -59
E2C56DB5-DFFB-48D2-B060-D0F5A71096E0 6 9 -55
74278BDA-B644-4520-8F0C-720EAF059935 0 73 -50
```


## 参考文献
### 考え方や手順などの参考文献
* [http://qiita.com/katsuyoshi/items/9d5417495a47c4b15ac1](http://qiita.com/katsuyoshi/items/9d5417495a47c4b15ac1)
* [http://d.hatena.ne.jp/kaito834/20130119/1358524567](http://d.hatena.ne.jp/kaito834/20130119/1358524567)
* [http://tomosoft.jp/design/?p=3981](http://tomosoft.jp/design/?p=3981)
* [http://rpd7.tomolog.info/knowledge/raspberrypi/07\_hcitool.html](http://rpd7.tomolog.info/knowledge/raspberrypi/07_hcitool.html)

### 解析スクリプト
* [http://stackoverflow.com/questions/21733228/can-raspberrypi-with-ble-dongle-detect-ibeacons](http://stackoverflow.com/questions/21733228/can-raspberrypi-with-ble-dongle-detect-ibeacons)



