# Docker+Open vSwitchでネットワーク勉強用の環境を作る

- vyOS使いたかったがARMマシンに対応したコンテナの作成方法がわからなかった
- 結局CentOSのコンテナでルーティング
- ルータとして動作させるためにip_forward機能を有効にする必要があった`docker run --sysctl net.ipv4.ip_forward=1 ...`
- 静的ルーティングのため`ip route add`でそれぞれのルータにルーティングテーブルを設定していく
- router1で`ip route add 10.0.3.0/24 via 10.0.1.2 dev eth0`として、router1->router4の通信ができるはずと思い`ping`で疎通確認するが、返信が返ってこない。。。
- router4->router1への経路を設定できていないからと気づくのに１週間かかる。
- router4で`ip route add 10.0.1.0/24 via 10.0.3.1 dev eth0`とした。
- router1->router4への`ping`が通った！

- 

#### ip_forward確認コマンド
```bash
[root@3c4c80f60d77 /]# sysctl net.ipv4.ip_forward
net.ipv4.ip_forward = 1
```