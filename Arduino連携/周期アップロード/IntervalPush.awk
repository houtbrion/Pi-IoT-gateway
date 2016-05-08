# このプログラムは標準入力から読み取ったデータの行の種別を判定して，
# 意味のある行のみを処理対象として選び，標準出力への出力すると共に，
# 外部プログラムに処理を行わせる．
#
# なお，行のパターンの判別は，arduino用のDHT系センサのテンプレート
# プログラムの形式となっている．
BEGIN{
    cmd="date";            # 読み取ったデータに日付を付けるためのコマンドを指定
    filename = "hoge.txt"; # サーバにデータをアップロードする代わりにファイルに
                           # 書き込むプログラムとなっているため，データを書き込む
                           # デフォルトのファイル名を指定する．
    flag=0;
}
$0~/^Status/{              # catでArduinoがつながっているシリアルポートをオープンすると，
                           # Arduinoが再起動するので，再起動直後の最初の出力を検出して，
                           # それ以後の文(行)を処理対象とするため，フラグを立てる．
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
        cmd2=sprintf("echo %s,%s >> %s",buff,$0,filename); # ここの部分のコマンドはサーバへデータをpushするコマンドと入れ替える
        system(cmd2);
        close(cmd2);
    }
}
