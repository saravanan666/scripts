#!/bin/bash

LOCAL=`dirname $0`;
cd $LOCAL
cd ../
PWD=`pwd`

echo "`date` $0 $1 $2 $3 $4 $5 $6 $7 $8" >> ${PWD}/../logs/active-responses.log

log_entry=`/bin/cat /opt/ossec-hids/logs/alerts/alerts.log | /bin/grep "$4" | tail -1`

tmp="OSSEC HIDS $log_entry"

log=`echo $tmp | sed 's/->//g'`

DISPLAY=0:0 /usr/bin/notify-send "$log"
