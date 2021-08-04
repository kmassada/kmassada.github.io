---
layout: single
title: "Wireguard Server on GCP with Gl-iNet Beryl as a client"
excerpt: "Setting up wireguard server on gcp instance and connecting to it using my beryl travel router"
date: 2021-08-01 00:00 -0400
tags: [gcp, blog, gcp]
---

## Setup Server

```shell
# reserve public IP
gcloud compute addresses create wireguard \
    --region us-west \
    --ip-version IPV4

# save IP
IP_ADDRESS=

# create firewall rule to allow 51820
gcloud compute firewall-rules create allow-wireguard \
    --network default \
    --action allow \
    --direction ingress \
    --rules udp:51820 \
    --source-ranges 0.0.0.0/0

# create instance with the public IP assigned
gcloud compute instances create wireguard \
    --address=$IP_ADDRESS \
    --network default \
    --machine-type=f1-micro \
    --image-family=debian-10 \
    --image-project=debian-cloud \
    --can-ip-forward \
    --boot-disk-size=10GB \
    --zone=us-west1-a

#ssh into the server
gcloud  compute ssh --zone=us-west1-a wireguard
``` 

## Pre-Reqs

```shell
sudo sh -c "echo 'deb http://deb.debian.org/debian buster-backports main' >> /etc/apt/sources.list.d/backports.list"
sudo sh -c "printf 'Package: *\nPin: release a=buster-backports\nPin-Priority: 90\n' >> /etc/apt/preferences.d/limit-backports"
sudo apt update
sudo apt install wireguard --assume-yes
sudo apt install linux-headers-$(uname -r)

sudo apt update && sudo apt upgrade

sudo vi /etc/sysctl.conf
sudo sysctl -p /etc/sysctl.conf
sudo sysctl -w net.ipv4.ip_forward=1

sudo reboot
```

## Configure Server

```shell
# Generate server private and public keys
(umask 077 && wg genkey > wg-private.key)
wg pubkey < wg-private.key > wg-public.key

## Print Private Key Needed in /etc/wireguard/wg0.conf
cat wg-private.key

# find the name of interface ()
ip -o -4 route show to default | awk '{print $5}'
```

Notable configs to keep in mind

1- Address of the server is the range of the IPs that live in the vpn subnet, mine for instance is `10.0.2.1/24`, I've confirmed it using 3 sources, [wireguard quickstart guide](https://www.wireguard.com/quickstart/), [wireguard.how guide](https://wireguard.how/server/google-cloud-platform/) and [serversideup guide](https://serversideup.net/courses/gain-flexibility-and-increase-privacy-with-wireguard-vpn/)
2- Saveconfig is important for my guide I use it to add peers. It allows you to run commands at the cli and save them to the `wg0.conf`
3- <YOUR_NETWORK_INTERFACE> is the name of the interface where the traffic is NATted. 

```conf
# filename: /etc/wireguard/wg0.conf
# define the WireGuard service
[Interface]

# contents of file wg-private.key that was recently created
PrivateKey = <SERVER_PRIVATE_KEY>

# MTU
MTU = 1380

# Addy of server
Address = 10.0.2.1/24

# NAT
PostUp = iptables -A FORWARD -i %i -j ACCEPT; iptables -t nat -A POSTROUTING -o <YOUR_NETWORK_INTERFACE> -j MASQUERADE
PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -t nat -D POSTROUTING -o <YOUR_NETWORK_INTERFACE> -j MASQUERADE

# UDP service port; 51820 is a common choice for WireGuard
ListenPort = 51820

# allow changes from cli to be added
SaveConfig = True
```

Now let's bootstrap the interface and enable it to start on reboot. 

```shell
sudo wg-quick up wg0
sudo systemctl enable wg-quick@wg0
```

### Verify Server Setup

Now let's verify before we move on. 

1- the values of these two must match

```shell
$ sudo grep -i private  /etc/wireguard/wg0.conf
<SERVER_PRIVATE_KEY>
$ cat wg-private.key
<SERVER_PRIVATE_KEY>
```

2- the following values for public key must match

```shell
$ sudo wg show wg0
interface: wg0
  public key: <SERVER_PUBLIC_KEY>
  private key: (hidden)
  listening port: 51820
$ cat wg-public.key
<SERVER_PUBLIC_KEY>
```

3- IP address must be check out

```
$ ip address show dev wg0
9: wg0: <POINTOPOINT,NOARP,UP,LOWER_UP> mtu 1380 qdisc noqueue state UNKNOWN group default qlen 1000
    link/none
    inet 10.0.2.1/24 scope global wg0
       valid_lft forever preferred_lft forever
$ sudo grep -i address /etc/wireguard/wg0.conf
Address = 10.0.2.1/24
```

4- Verify the steps for when the interface comes online, watching for iptables routes, mtu, and address set correctly

```shell
$ sudo wg-quick up wg0
[#] ip link add wg0 type wireguard
[#] wg setconf wg0 /dev/fd/63
[#] ip -4 address add 10.0.2.1/24 dev wg0
[#] ip link set mtu 1380 up dev wg0
[#] iptables -A FORWARD -i wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o ens4 -j MASQUERADE
```

## Configure Client

```shell
# Generate client private and public keys
sudo wg show wg0
(umask 077 && wg genkey > wg-private-client.key)
wg pubkey < wg-private-client.key > wg-public-client.key

## Print Private Key Needed in ~/wg-client.conf
cat wg-private-client.key
```

let's work on the config, in the GLi Admin panel, under wireguard client, create a new configuration file with the following valiables

NOTE: config is picky, remove all the comments and make sure there's spacing between the equal sign, the variable name and the value. [gl-iNet's wireguard guide](https://docs.gl-inet.com/en/3/app/wireguard/#input-the-configuration) is comprehensive for this step.

```conf
# filename: ~/wg-client.conf
# define the local WireGuard interface (client)
[Interface]

# contents of wg-private-client.key
PrivateKey = <CLIENT PRIVATE_KEY>

# the IP address of this client on the WireGuard network
Address = 10.0.2.2/32

# DNS
DNS = 1.1.1.1

# MTU
MTU = 1460

# define the remote WireGuard interface (server)
[Peer]

# from `sudo wg show wg0`
PublicKey = <SERVER PUBLIC_KEY>

# the IP address of the server on the WireGuard network 
AllowedIPs = 0.0.0.0/0

# public IP address and port of the WireGuard server
Endpoint = XX.XX.XX.XX:51820
```

Now let's write into the server config the peer config for the client. 

```shell
sudo wg set wg0 peer <PUBLIC CLIENT KEY> allowed-ips 10.0.2.2
```

## Verify client config

Now let's verify 

1- public client key should now be part of the wg0 config. the allowed IPs should show the single IP range of the client, in this case `10.0.2.2/32`.

```shell
$ cat wg-public-client.key
 <CLIENT PUBLIC_KEY>
$ sudo wg show wg0
interface: wg0
  public key: <SERVER PUBLIC_KEY>
  private key: (hidden)
  listening port: 51820

peer: <CLIENT PUBLIC_KEY>
  endpoint: XX.XX.XX.XX:40253
  allowed ips: 10.0.2.2/32
```

2- you've validated that on the GL-iNet side, the following values in the config are the Client's Private Key and the Server's Public key.

```shell
PrivateKey = <CLIENT PRIVATE_KEY>
PublicKey = <SERVER PUBLIC_KEY>
```

## Connect

In order to connect, you simply go to the Wireguard client and establish connection. [gl-iNet's wireguard guide](https://docs.gl-inet.com/en/3/app/wireguard) is comprehensive for this step.

Things to remember once the client's connection is established

1- when you've established connection on the GL-iNet side it shows the IP address you've told your server the client would have.

```shell
IP Address10.0.2.2
Upload / Download82.41 MB / 90.19 MB
```

2- This command will show you data transfer rates, and the client's endpoint

```shell
$ sudo wg show wg0
...
peer: <CLIENT PUBLIC_KEY>
  endpoint: XX.XX.XX.XX:XXX
  allowed ips: 10.0.2.2/32
..CONNECTION INFO..
```

## Troublehsoot

### Making changes

1- edit conf

```shell
sudo vi /etc/wireguard/wg0.conf
```

2- down interface

```shell
sudo wg-quick down wg0
```

3- sysctl to up interface

```shell
sudo systemctl restart wg-quick@wg0.service
```

4- check if changes are live

```shell
ug 03 23:25:57 wireguard wg-quick[1004]: [#] ip link add wg0 type wireguard
Aug 03 23:25:57 wireguard wg-quick[1004]: [#] wg setconf wg0 /dev/fd/63
Aug 03 23:25:57 wireguard wg-quick[1004]: [#] ip -4 address add 10.0.2.1/24 dev wg0
Aug 03 23:25:57 wireguard wg-quick[1004]: [#] ip link set mtu 1360 up dev wg0
Aug 03 23:25:57 wireguard wg-quick[1004]: [#] iptables -A FORWARD -i wg0 -j ACCEPT; iptables -t nat -A POSTROUTING 
Aug 03 23:25:57 wireguard systemd[1]: Started WireGuard via wg-quick(8) for wg0.
```

5- show interface

```shell
ip address show dev wg0
```

6- show status
```shell
sudo wg show wg0
```

### GCP Troubleshoot

1- it is very important that the instance `--can-ip-forward`, and that the Natting and Masquerade rules are set. 

2- GCP's firewall rules allows to enable logging, to log when you 

this Cloud Logging query 

```
logName:(projects/<YOUR PROJECT>/logs/compute.googleapis.com%2Ffirewall) AND jsonPayload.rule_details.reference:("network:default/firewall:allow-wireguard")
```

allowed me to confirm traffic/connection attempts are reaching my node.

```json
connection: {
dest_ip: "10.138.0.3"
dest_port: 51820
protocol: 17
src_ip: "xx.xx.xx.xx"
src_port: xxxxx
}
```

3- GCP instances MTU, I've set the server side to 1360 and the client to 1480. this actually helped me increase my performance on the instance. 

4- This is a quick way to verify that you static IP was indeed attached to the node

```shell
curl zx2c4.com/ip
xx.xx.xx.xx
```

## Linux / NetTools Troubleshooting

once I can confirm traffic is reaching the vm's nic, I can run this to be sure 

```shell
$ sudo tcpdump -i YOUR INTERFACE NAME dst port 51820
...
04:14:28.618587 IP c-ISP-STUFF-EH.40253 > wireguard.us-west1-a.c.YOUR-PROJECT-EH.internal.51820: UDP, length 80
04:14:29.326714 IP c-ISP-STUFF-EH.40253 > wireguard.us-west1-a.c.YOUR-PROJECT-EH.internal.51820: UDP, length 80
04:14:29.394530 IP c-ISP-STUFF-EH.40253 > wireguard.us-west1-a.c.YOUR-PROJECT-EH.internal.51820: UDP, length 80
47 packets captured
47 packets received by filter
0 packets dropped by kernel
```

I can also confirm pings from client to server

```shell
$ sudo tcpdump -i wg0 icmp
04:24:48.700291 IP 10.0.2.2 > 10.0.2.1: ICMP echo request, id 48775, seq 0, length 64
04:24:48.700364 IP 10.0.2.1 > 10.0.2.2: ICMP echo reply, id 48775, seq 0, length 64
```

I can also troubleshoot dns lookups by sending an nlookup on my client 

```shell
04:29:12.956849 IP 10.0.2.2.54136 > one.one.one.one.domain: 56514+ A? google.com. (28)
04:29:12.965835 IP one.one.one.one.domain > 10.0.2.2.54136: 56514 1/0/0 A 142.250.217.110 (44)
```