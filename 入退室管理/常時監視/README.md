# 常時監視
センサ類を繋いだArduinoとRaspberry PiをUSBでつなぎ，
一定時間間隔でセンサの値をArduinoで読み取り，Raspberry Piに
送信する．
Raspberry PiはArduinoの測定結果に時刻情報等を付与し，
ストレージへの保存や，クラウドへのアップロードを行う．

さらに，Raspberry Piではビーコン等の端末も検出し，
誰が居たかのデータをクラウド上のサーバにアップロードする．

## Arduinoの処理
Raspberry Piのshellでrootになり，Arduinoが接続されている
/dev/以下のファイルをオープンすると
Arduinoが再起動され，結果が定期的にArduinoから
出力される．

## Raspberry Piの処理
### Arduinoの出力に対する処理
Arduino側からのデータを受信用し，タイムスタンプを付けてファイルに保存
しつつ，さらにパイプで他のコマンドに処理を行わせる．

```
root@raspberrypi:~# cat /dev/ttyACM0 |gawk -f IntervalPush.awk |tee hoge2.txt                                 
Thu  5 May 09:11:39 JST 2016 OK 36.0            25.1            77.2
Thu  5 May 09:11:41 JST 2016 OK 36.0            25.1            77.2
Thu  5 May 09:11:46 JST 2016 OK 36.1            25.1            77.2
```

上のコマンドラインで『InterValPush.awk』はデータを読み取り，
タイムスタンプを付け，hoge.txtというファイルに内容を保存する
と共に，標準出力にも書き出す．上のコマンド例では『tee』コマンドに
なっている部分をクラウド等にデータを送るコマンドで置き換え
れば良い．

上記のshellに入力したコマンドは
SensorDataPush.shというファイルに収められている．

### 人の監視
人の検出に利用するデバイスも変更する可能性があるため，現在は未実装．

#### 案:ビーコン(BLE)を利用する場合
Raspberry Piのbluetoothのコマンドのうち，周辺にあるBLEの端末を
検出するためのコマンド『hcitool』を用いると，MACと端末名は
わかる．

```
# hcitool lescan
00:1C:4D:40:D2:B4 (unknown)
.
.
.
.
00:1C:4D:40:D2:B4 (unknown)
```


