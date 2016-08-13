# このプログラムは標準入力から読み取ったデータの行の種別を判定して，
# 意味のある行のみを処理対象として選び，標準出力への出力すると共に，
# 外部プログラムに処理を行わせる．
#
# なお，行のパターンの判別は，arduino用のDHT系センサのテンプレート
# プログラムの形式となっている．
BEGIN{
    cmd="date \"+%Y%m%dT%H%M%S\"";  # 読み取ったデータに日付を付けるためのコマンドを指定
    filename = "hoge.txt"; # サーバにデータをアップロードする代わりにファイルに
                           # 書き込むプログラムとなっているため，データを書き込む
                           # デフォルトのファイル名を指定する．
    flag=0;
    debug=1;
    dataID="n208enter"
}
$0 ~/^close/ || $0 ~/^open/ {
    if (flag==1) {
        cmd | getline buff;
        close(cmd);
        cmd2=sprintf("curl -i -X PUT -H 'Authorization: Bearer %s' -d '{ \"id\": 0,  \"sensor\": [ { \"door\" : \"%s\" }]}' 'http://api.trial.iot.jp.fujitsu.com/v1/ITP027-001/enter.json?$date=%s%%2b0900'",dataID,$1,buff); # ここの部分のコマンドはサーバへデータをpushするコマンド
        if (debug==1) {
            printf("%s\n",$0);
            printf("%s\n",cmd2);
        }
        #system(cmd2);
        #close(cmd2);
    } else {
        flag=1;
    }
}
$0~/^OK/ {
    if (flag==1) {
        cmd | getline buff;
        close(cmd);
        cmd2=sprintf("curl -i -X PUT -H 'Authorization: Bearer %s' -d '{ \"id\": 0,  \"sensor\": [ { \"temp\" : %s }, { \"humid\" : %s}, {\"illuminance\": %s}]}' 'http://api.trial.iot.jp.fujitsu.com/v1/ITP027-001/enter.json?$date=%s%%2b0900'",dataID,$4,$3,$2,buff); # ここの部分のコマンドはサーバへデータをpushするコマンド
        if (debug==1) {
            printf("%s\n",$0);
            printf("%s\n",cmd2);
	}
        #system(cmd2);
        #close(cmd2);
    } else {
        flag=1;
    }
}
