#!/bin/bash

LOCAL=`dirname $0`;
cd $LOCAL
cd ../
PWD=`pwd`

echo "`date` $0 $1 $2 $3 $4 $5 $6" >> ${PWD}/../logs/active-responses.log

log=`/bin/cat /opt/ossec-hids/logs/alerts/alerts.log | /bin/grep -A 3 "$4" | tail -1`

rule=`/bin/cat /opt/ossec-hids/logs/alerts/alerts.log | /bin/grep -A 2 "$4" | tail -1 | awk '{print $2}'`

log=${log:16}

DISPLAY=0:0 /usr/bin/notify-send "$rule $log"
