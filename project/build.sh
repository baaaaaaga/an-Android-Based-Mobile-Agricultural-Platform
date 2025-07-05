#!/bin/sh
if [ "$1" = "build" ];then
    mkdir /home/changsheng/project/project77262/project
    cp -a /home/changsheng/project/project77262/server/. /home/changsheng/project/project77262/project/
    cd /home/changsheng/project/project77262/project
    rm -rf /home/changsheng/project/project77262/server
    echo "执行成功"
fi
