BEGIN{
	dataID="n208beacon"
	cmd="date \"+%Y%m%dT%H%M%S\"";  # 読み取ったデータに日付を付けるためのコマンドを指定
	flag=0;
	debug=1;
}

$0~/.*/ {
        cmd | getline buff;
        close(cmd);
	cmd2=sprintf("curl -i -X PUT -H 'Authorization: Bearer %s' -d '{ \"id\": 0,  \"beacon\": [ { \"uuid\" : %s }, { \"major\" : %s}, {\"minor\": %s}, {\"rssi\": %s}]}' 'http://api.trial.iot.jp.fujitsu.com/v1/ITP027-001/enter.json?$date=%s%%2b0900'",dataID,$2,$4,$6,$8,buff); # ここの部分のコマンドはサーバへデータをpushするコマンド
	if (debug==1) {
		printf("%s\n",$0);
		printf("%s\n",cmd2);
	}
	#system(cmd2);
	#close(cmd2);
}
