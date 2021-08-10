#!/bin/sh

# ルータ間の疎通確認スクリプト

check() {
    docker exec $1 ping $2 -c 1 > /dev/null
    if [ $? -eq 0 ]
    then
        echo "$1->$2 o"
    else
        echo "$1->$2 x"
    fi
}

check router1 10.0.3.2
check router2 10.0.4.1
check router3 10.0.1.2
check router4 10.0.2.1

check router1 10.0.4.2
check router2 10.0.2.2
check router3 10.0.3.1
check router4 10.0.1.1

