#!/bin/sh

#
# �EArduino��Raspberry Pi�Ɍq�������̃V���A���|�[�g /dev/ttyACM0
# �EIntervalPush.awk Arduino����o��f�[�^����Ӗ��̂���f�[�^�����o���C
#   ������t����v���O����
# �Ehoge2.txt : ���O��~�ς��郍�O�t�@�C��
cat /dev/ttyACM0 |gawk -f IntervalPush.awk |tee hoge2.txt

