# ���̃v���O�����͕W�����͂���ǂݎ�����f�[�^�̍s�̎�ʂ𔻒肵�āC
# �Ӗ��̂���s�݂̂������ΏۂƂ��đI�сC�W���o�͂ւ̏o�͂���Ƌ��ɁC
# �O���v���O�����ɏ������s�킹��D
#
# �Ȃ��C�s�̃p�^�[���̔��ʂ́Carduino�p��DHT�n�Z���T�̃e���v���[�g
# �v���O�����̌`���ƂȂ��Ă���D
BEGIN{
    cmd="date";            # �ǂݎ�����f�[�^�ɓ��t��t���邽�߂̃R�}���h���w��
    filename = "hoge.txt"; # �T�[�o�Ƀf�[�^���A�b�v���[�h�������Ƀt�@�C����
                           # �������ރv���O�����ƂȂ��Ă��邽�߁C�f�[�^����������
                           # �f�t�H���g�̃t�@�C�������w�肷��D
    flag=0;
}
$0~/^Status/{              # cat��Arduino���Ȃ����Ă���V���A���|�[�g���I�[�v������ƁC
                           # Arduino���ċN������̂ŁC�ċN������̍ŏ��̏o�͂����o���āC
                           # ����Ȍ�̕�(�s)�������ΏۂƂ��邽�߁C�t���O�𗧂Ă�D
    flag=1;
    cmd | getline buff;
    close(cmd);
    printf("%s %s\n",buff,$0);
}
$0~/^OK/{
    if (flag==1) {
        cmd | getline buff;
        close(cmd);
        printf("%s %s\n",buff,$0);
        cmd2=sprintf("echo %s,%s >> %s",buff,$0,filename); # �����̕����̃R�}���h�̓T�[�o�փf�[�^��push����R�}���h�Ɠ���ւ���
        system(cmd2);
        close(cmd2);
    }
}
