#!/bin/sh

docker build -t router .
docker run -td --sysctl net.ipv4.ip_forward=1 --name router1 --privileged --net=none router
docker run -td --sysctl net.ipv4.ip_forward=1 --name router3 --privileged --net=none router
docker run -td --sysctl net.ipv4.ip_forward=1 --name router2 --privileged --net=none router
docker run -td --sysctl net.ipv4.ip_forward=1 --name router4 --privileged --net=none router


# Open vSwitch でスイッチ作成
sudo ovs-vsctl add-br switch1
sudo ovs-vsctl add-br switch2
sudo ovs-vsctl add-br switch3
sudo ovs-vsctl add-br switch4

# dockerコンテナに対してNIC追加
# NICにIP・サブネットマスクを設定
# dockerコンテナにスイッチを接続
sudo ovs-docker add-port switch1 eth0 router1 --ipaddress=10.0.1.1/24
sudo ovs-docker add-port switch2 eth1 router1 --ipaddress=10.0.2.1/24
sudo ovs-docker add-port switch1 eth0 router2 --ipaddress=10.0.1.2/24
sudo ovs-docker add-port switch3 eth1 router2 --ipaddress=10.0.3.1/24
sudo ovs-docker add-port switch2 eth0 router3 --ipaddress=10.0.2.2/24
sudo ovs-docker add-port switch4 eth1 router3 --ipaddress=10.0.4.1/24
sudo ovs-docker add-port switch3 eth0 router4 --ipaddress=10.0.3.2/24
sudo ovs-docker add-port switch4 eth1 router4 --ipaddress=10.0.4.2/24

# ネットワーク構成
#    router1(10.0.1.1/24) -- switch1 -- (10.0.1.2/24)router2
# (10.0.2.1/24)                                 (10.0.3.1/24)
#       |                                             |
#    switch2                                       switch3
#       |                                             |
# (10.0.2.2/24)                                 (10.0.3.2/24)
#    router3(10.0.4.1/24) -- switch4 -- (10.0.4.2/24)router4



