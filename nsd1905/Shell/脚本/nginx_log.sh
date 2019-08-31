#!/bin/bash
date=20190719
logpath=/usr/local/nginx/logs
mv $logbath/access.log $logpath/access-$date.log
mv $logpath/error.log $logpath/error-$date.log
kill -USR2 $(cat $logpath/nginx.pid)
