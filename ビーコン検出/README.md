# �r�[�R�����o

BLE�̃r�[�R����ǂ݂����D

## �n�[�h�̏���
����́CRaspberry Pi2�𗘗p���Ă��邽�߁CBluetooth��
USB�ڑ��̂��̂𗘗p�D

## �C���X�g�[��
OS�ɂ́C�g����Bluetooth�A�_�v�^�p�̃h���C�o�Cbluez���C���X�g�[���ς�
�ł��������Cbluez�t���̃v���O�������C���X�g�[������Ă��Ȃ��������߁C
���ꂾ����ǉ��C���X�g�[���D

```
# apt-get install bluez-hcidump
```

## Bluetooth�̎��Ӌ@��̒T����
Linux�̃R�}���h���C���v���O�������g���āC���ӂɂ���Bluetooth�̋@���������D
�V�F���̃E�B���h�E��2�J���āChcidump��hcitool��ʂ̃E�B���h�E�œ��삳����D

### ��M�����p�P�b�g�̃_���v
�Е���shell��hcidump�R�}���h�𓮍삳����D����ƁC��M�����p�P�b�g�̃_���v��
��ʂɏo�͂����D

```
# hcidump -R
```

### ���Ӌ@���T���R�}���h
���������shell��hcitool�R�}���h�����s����ƁChcidump�̉�ʂ�
��M�����p�P�b�g���o�͂����D

#### Bluetooth�̏ꍇ
```
# hcitool scan
```

#### BLE�̏ꍇ

```
# hcitool lescan
```

## ��̓X�N���v�g
�Q�l�����ɂ��������CRadius Networks�����J���Ă���r�[�R�����o�p�̃X�N���v�g`ibeacon_scan`
�𗘗p����ƁC�A�h�o�^�C�Y���Ă���r�[�R���̃��X�g�𓾂邱�Ƃ��ł���D

�Q�l�����ɂ��������CRadius�����J���Ă���t�H�[�����ւ̏������݂��痘�p���
�ȉ��̒ʂ�D

�ʏ�̎g�����D
```
$ ./ibeacon_scan
UUID: 74278BDA-B644-4520-8F0C-720EAF059935 MAJOR: 0 MINOR: 73 POWER: -50
UUID: 2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6 MAJOR: 1 MINOR: 6 POWER: -59
UUID: E2C56DB5-DFFB-48D2-B060-D0F5A71096E0 MAJOR: 6 MINOR: 9 POWER: -55
```

���̃v���O�����ƘA�����ėp����ꍇ�D
```
$ ./ibeacon_scan -b
2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6 1 6 -59
E2C56DB5-DFFB-48D2-B060-D0F5A71096E0 6 9 -55
74278BDA-B644-4520-8F0C-720EAF059935 0 73 -50
```


## �Q�l����
### �l������菇�Ȃǂ̎Q�l����
* [http://qiita.com/katsuyoshi/items/9d5417495a47c4b15ac1](http://qiita.com/katsuyoshi/items/9d5417495a47c4b15ac1)
* [http://d.hatena.ne.jp/kaito834/20130119/1358524567](http://d.hatena.ne.jp/kaito834/20130119/1358524567)
* [http://tomosoft.jp/design/?p=3981](http://tomosoft.jp/design/?p=3981)
* [http://rpd7.tomolog.info/knowledge/raspberrypi/07\_hcitool.html](http://rpd7.tomolog.info/knowledge/raspberrypi/07_hcitool.html)

### ��̓X�N���v�g
* [http://stackoverflow.com/questions/21733228/can-raspberrypi-with-ble-dongle-detect-ibeacons](http://stackoverflow.com/questions/21733228/can-raspberrypi-with-ble-dongle-detect-ibeacons)



