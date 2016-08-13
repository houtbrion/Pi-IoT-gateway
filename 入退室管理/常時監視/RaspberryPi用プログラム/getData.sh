#!/bin/sh

#DATE=`date "+%Y%m%dT%H%M%S"`
#FRONT="curl -i -X GET -H 'Authorization: Bearer n208enter' 'http://api.trial.iot.jp.fujitsu.com/v1/ITP027-001/enter/_past?$filter=_date%20gt%2020150101T000000%2b0900%20and%20_date%20lt%20"
#BACK="%2b0900'"

curl -i -X GET -H 'Authorization: Bearer n208enter' 'http://api.trial.iot.jp.fujitsu.com/v1/ITP027-001/enter/_past?$filter=_date%20gt%2020150101T000000%2b0900%20and%20_date%20lt%2020160627T012119%2b0900'

