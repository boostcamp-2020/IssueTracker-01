#!/bin/bash

for PID in $(pgrep -fl node | awk '{print $1}'); do
    echo "> kill -15 $PID"
    kill -15 $PID
    sleep 1
done

npm --prefix /root/src/frontend install
npm --prefix /root/src/backend install
nohup npm --prefix /root/src/frontend run dev 2>&1 &
nohup npm --prefix /root/src/backend start 2>&1 &
